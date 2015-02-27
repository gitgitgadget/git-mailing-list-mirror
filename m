From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Fri, 27 Feb 2015 16:13:13 +0100
Message-ID: <54F08989.2050504@drmicha.warpmail.net>
References: <54EDBEC2.8090107@peralex.com>	<CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>	<20150225143116.GA13567@peff.net>	<xmqqk2z5on72.fsf@gitster.dls.corp.google.com>	<20150225185128.GA16569@peff.net>	<xmqqbnkholx9.fsf@gitster.dls.corp.google.com>	<20150225191108.GA17467@peff.net>	<54EF0089.6070605@drmicha.warpmail.net> <xmqqr3tcl78o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Noel Grandin <noel@peralex.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 16:13:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRMbS-0003Se-3m
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 16:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbbB0PNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 10:13:17 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47792 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754624AbbB0PNP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2015 10:13:15 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 58D662084B
	for <git@vger.kernel.org>; Fri, 27 Feb 2015 10:13:14 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 27 Feb 2015 10:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=D9RonbkBTXTri/ggfk4y1o
	MAdYw=; b=eahPq4ElJCQgkR/HuthULwPai9sjwj3W/72fhsj7HEBHZdv704BAtc
	/gOE3MLpEmCkxcbxnPd0JSYVcaijJdEndwaozdsL4N42bzuXcqn6QRlB5igtGHjg
	dsq2ZMA/YP+J7+Y4YGsqgkNJaiLrUJ11Jyr0RdvuL/aqA2HXH2zXI=
X-Sasl-enc: VDdnm3XfGJSkzILNjdCRFRmmAEsfSw92QXSZer+NVCvG 1425049994
Received: from localhost.localdomain (unknown [88.71.97.79])
	by mail.messagingengine.com (Postfix) with ESMTPA id 617256800AF;
	Fri, 27 Feb 2015 10:13:14 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqr3tcl78o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264498>

Junio C Hamano venit, vidit, dixit 26.02.2015 21:59:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> So, as a summary of the discussion, it seems it's time to switch the
>> default to --textconv for git grep?
> 
> Hmmm, why?
> 
> Nobody seems to be asking for such a change in this thread.  The
> original issue IIRC was that the grep output was unnecessary for
> some paths and the repository did not mark these paths as such.
> Once they are marked as "-diff", there is no reason why you want to
> trigger textconv to squelch the hits from grep.

Of course not. All that I want, and that I wanted back then, was to have
diff and grep behave the same.

> So that does not sound to me a summary of the discussion at all.
> 

Well, your conditional

> I do not recall its conclusion, but it it were "Yes, that is what it
> means", then it might be reasonable to:
> 
>  - have "git grep" ignore paths marked with -diff by default
>    (perhaps "-a" option to disable, just like GNU)
> 
>  - have "git grep" pay attention to diff.textconv and search in the
>    result of textconv filter.

and Jeff's "Yes" on that condition certainly read like that to me: Make
"git grep" react to "diff", "-diff" attributes in the same way as "git
diff".

But I've set up my alias greppp since then and don't care any more, and
I won't invest anything in this topic any more.

Michael
