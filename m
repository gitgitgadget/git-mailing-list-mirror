From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] git reset --hard gives clean working tree
Date: Sat, 5 Mar 2016 09:27:23 +0100
Message-ID: <56DA986B.6040003@web.de>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
 <1455207366-24892-1-git-send-email-tboegi@web.de>
 <xmqqy4arw089.fsf@gitster.mtv.corp.google.com> <56DA896A.3050201@web.de>
 <xmqqtwklwdrh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 05 09:27:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac7Yn-0003Dg-2S
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 09:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759531AbcCEI1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 03:27:33 -0500
Received: from mout.web.de ([212.227.15.4]:60722 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754342AbcCEI1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 03:27:31 -0500
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M2ZtN-1ZmdUv2F6b-00sOpA; Sat, 05 Mar 2016 09:27:24
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <xmqqtwklwdrh.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:sk/1OR01aevHeeTB2h5maDsvdIIxCRAJdiyMGsvIArAfhx2pbOn
 z2Kx/HipfcPelgnP8Y1/y5eGOrzzuWTS4KOAx7wh59eQnWj0Q3lkqIiJRzYE4VknwkVr1PG
 pB0wWr0+KA4QdzFFcqkLQTmdwUjXUMDFCVyE12EIku1xByp0LfY/gbzHGnX1erkxMnD1vp6
 c1FxjcJ72qaQg/1X9hr6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e9JsKmEzNzQ=:AbWj5QuEg/WbDNfSHqTWIl
 keZf4UzcTrviXmQdHwEl5QH0P4XSeHWXF250JAeIOWgMYRfihdrRO5P54g2T0xJRIJ0+wbO/o
 xdBIFMH0hCpCo0jomBR4zrGQ+MB4nmmBe7oUU6zPUJhlgFIxXiywnDewuE12rIE5zrPs71HhT
 wGBh29ZxPjoTav3Et72tAQiNJh5rX84fUh48n0Z9Bpw/odEmee/TH7q2lpano6Anl+ihjRmBU
 ZwfW7ggrJ9Ic5u/NInjfGqDMy2RG+lY6F6yRFy0E4wypGEYPKh+/F+uDSs7tjiTFOob9BFDxj
 BuG3s9mhPEU7pW3q/SRHsU7QZ3SbVmtoH7eTYplqhkADyUJf0M+SybqcpSl8SaqIepMDsRpdv
 FgQ267OhZQ8I8t7xTFltM73MZaSLMJY6OvztycO4Hh2JQQ14HfpTuEiwaPVpHUUp95WTqO8El
 TMcnvO3azoreJRrIttXhcozBNOogrxbRXkCs8yzmMfKzgq051SWssA3Oc0rOfRMkLcsizfog0
 5YRFdZD4K+UVqYobb+c7Ydd7o4tu7nPE4cnX5D9WIRMxxt9eCNiZ58Q21IMaeOcfUTy3axVY9
 tKv27bKRit+hxuD8adREPk7zMqEiwSpYIvQRigLarnL4kc8zkHzBb4Az6fHbVurp1/PKGUZi3
 czI0UCHHIErUBvFZaWFV3RdT4TYdGX7dSIlg4rLf+HFrPiXEO8FX4dfXIDMHEw+mJPWFk7IgN
 MMs/aTdaVKVj0EO94IR0YTOnhBXKGorw61uL6QpT4SuRp091r4l0+Zj9AlexnO7NOMCFRtdC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288304>


> I do not think I can endorse this approach, as I cannot explain why
> it could possibly make sense to treat as if CRLF conversion is
> somehow special among all the convert_to_git()/convert_to_worktree()
> conversions, which your patch does to the diff code.
>
> Comparisons between contents from two tree objects and comparisons
> between contents from a tree object and the index must happen
> without conversion, and comparisons between contents from the tree
> in the HEAD commit and contents from the working tree must be done
> in line with the HEAD vs index comparison to serve as a preview of
> what would happen after adding the contents taken from the working
> tree to the index, which means we should compare what is in the
> index (without conversion) and the result of running the whole
> convert_to_git() conversion on what is in the working tree.  It
> feels fundamentally wrong to apply only CRLF conversion without any
> other conversion, whether the direction of the conversion is from
> worktree to git or the other way around, when comparing two things.
>
> When the user has CRLF data in the index and the user tell the
> attribute system so that the next "add" would result in "fixing" the
> indexed lines to be terminated with LF, "diff-files" _should_ show
> that correction as a change, I think.
Fair enough.
There are 2 users here:
User 1 commits files with CRLF into the index, and later decides
to set the "text eol=crlf" attribute on it, without normalizing the repo.

User 2 does a simple "git clone", which includes checkout.
Running "git diff" tells user 2, that his work tree is dirty.

My conclusion is, that we could suppress the normalization for text files,
(as we do it for core.autocrlf with the new safer CRLF handling)
meaning that "git diff" and "git status" is clean and that files stay with CRLF
in the index.
Does this make sense ?
