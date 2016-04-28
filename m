From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 13:01:09 -0700
Message-ID: <CAGZ79kY1TB9sZpZcihiC5rPmbf8qD9KsAZsWDcon+UnHG7R3jw@mail.gmail.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
	<20160428112912.GB11522@sigill.intra.peff.net>
	<alpine.DEB.2.20.1604281405540.2896@virtualbox>
	<20160428134953.GB25364@sigill.intra.peff.net>
	<CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
	<20160428153902.GF31063@sigill.intra.peff.net>
	<CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
	<20160428165031.GA31421@sigill.intra.peff.net>
	<xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
	<20160428191038.GA10574@sigill.intra.peff.net>
	<xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYoRP=rkfaL+rLapmvouUdPxXGBr-KWOLhL94bYB1B2-w@mail.gmail.com>
	<xmqqoa8t4il8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:01:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avs7f-0004ut-Mw
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 22:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbcD1UBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 16:01:11 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33952 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcD1UBK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 16:01:10 -0400
Received: by mail-ig0-f172.google.com with SMTP id u5so5110449igk.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=1rSXJDx8QuM9WLDuqdlICxBOrbDHba6eG2Dqg42ag54=;
        b=XNj4mMGTi9a74lcXVCG9FIdRHHfuQhoFtDN1BrPiN4CGXM9PLMI1fTdTXdUmty0jQd
         0WZPudHUVuVvLfTY+NaJY1ku/OOYHuG8ae4C0ZlKXqNFQfKR76qiFTrg8SqYIAkG7U7U
         Zb0v165HGHVUZNwPJeZxR8qgXFlnJM+S/jj5q/zEeD02i6Ic9QgxXzTSodKlZDpFexG/
         LWSnN4R9PVmQQdmZ/1WQLP4QXsZJsBx3yH6iVaOklqUyLu61Rx5qzFPQV1G6AhFl5NTE
         b71Ugw2VrrQE/fdJka0eNu+jy6ONwBde29S+u1bSEEucFlEMAHfoKRGsbXsXWT2PeHjd
         sUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=1rSXJDx8QuM9WLDuqdlICxBOrbDHba6eG2Dqg42ag54=;
        b=cOIIpxHNGcvdkRSxJwdFRyBUOkFpmxv1Jd2ObOKBtPP/QRFZsxGRsRqrl1U4G17a+b
         ZOUEeblkKIqjyKMzgys87zPZU/zKkp1MgKzzKXfHwGIM6tdT1WYL1BlBs3PJyZ/FgDEH
         DvA4nqM6Q0lSJuGzj5Prza8i0OeAvxfvpW9YP9W8yPV//8PURR+0gksJ0vR9G3u7NRmu
         I9D1w+Uy9RbzpSRS3AaWVV8D9S/3EyPYn1lRcFhqyry2Dl+2UFd9T8QIr760lSNANftx
         +YwE4UBFgqrunnNMRUSjzwCsGFeVQK5xfRrVRDWzQUa9g57KxT2pnVoar9BNAZs1Fgt0
         G75g==
X-Gm-Message-State: AOPr4FUIvONofAkCKRrsew4YFuApO2XYJofGQGcH1/bYblh8AafxVv/+p2kOAGwSjiiWNQngz8ak45RV60dahwd7
X-Received: by 10.50.111.15 with SMTP id ie15mr21202263igb.94.1461873669201;
 Thu, 28 Apr 2016 13:01:09 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 13:01:09 -0700 (PDT)
In-Reply-To: <xmqqoa8t4il8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292944>

On Thu, Apr 28, 2016 at 12:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So when going with that philosophy, the user might be missing
>> switches like
>>
>>     -c-for-this-repo-only core.worktree=... -c
>> submodule.worktree=align-relative-to-parent
>>
>> i.e. when shifting the responsibility to the user, we need to have
>> switches to pass options to the repository or a subset of submodules?
>
> I think that is an excellent illlustration of the issue by an
> example of what we shouldn't do ;-)

So rather have a white / black list?

Could we have a pre curated list with the list easily changed by the user?
So instead of screaming at the mailing list they can work around easily,
and eventually someone fixes the "stupid" default?

Maybe a user would want to do

    git config --global submodule-credentials-filter-white-list "host.*"

instead? (Naming intentionally bad)

>
> "git" is not always about submodules, so "-c-but-not-for-submodules"
> option does not belong to "git" wrapper.
>
> Users use "git -c" and hope to affect what happens in submodules,
> only because "git submodule" support is still immature and does not
> have options to do that.  You certainly smell a linkage between
> "pass options to a selected subset of submodules" and your recent
> "give labels to submodules so that they can be named with *group
> syntax" topic, no?

I thought about that for a split second, but no. I mean it in the
most general  way possible.

It doesn't even have to be a submodule related thing at all.

I can imagine that `git gc` could learn to walk nested repos
(not submodules, just repos on disk inside the work tree).
And for that use case we'd maybe want to have a setting
to pack the nested repos more aggressively than the toplevel repo.

(Not sure if there would be a use case or such a thing, but it is the
first I came up with)
