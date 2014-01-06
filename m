From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 6 Jan 2014 16:13:44 -0500
Message-ID: <CAEBDL5VD9C8DXFUS9VawxZhAC0AnR=abV-FEVTdi25NVBPvDVg@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
	<1389028732-27760-3-git-send-email-artagnon@gmail.com>
	<xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
	<CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
	<xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
	<20140106201854.GA28162@sigill.intra.peff.net>
	<CAEBDL5UaS2Hd-Yb417W+Fw_7j1+5sRAgszko-PbU7z901_X+cw@mail.gmail.com>
	<20140106204203.GI3881@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 22:13:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0HUc-0000Hw-Px
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 22:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241AbaAFVNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 16:13:47 -0500
Received: from mail-we0-f178.google.com ([74.125.82.178]:51494 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984AbaAFVNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 16:13:46 -0500
Received: by mail-we0-f178.google.com with SMTP id u57so15978665wes.23
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 13:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=L37QbuikfLETMwrgu1gNQ7GwjQhGR0qc22XVriV5O1o=;
        b=kPzHe3CGYd5EGxoAnqaj8sUS5+mhdb2jTdcIrCxiLD/xllhzjvxrPBsefsbUBUz19u
         O8yJK6e5YYlohxpmCscDbIpG11m75acFUuKKO7IJvnxM4rmjgvJBILi5LXd9QhTBGQ8r
         mOw0SRAUJM1h6bUp6euv298KT4/3ARwmA22pSlMOKLHxUp8UFf0fZJBSLnLYcPFh82nO
         ATK6b6JlJjedSPMqPgzaH2/Z/h+bDrGDA837lEws493PGFJf6wtjOOzm1HwCZUg9zE/O
         RdzwWQ9VlkBs+tlW68lrMpn9ei6zERGFBg1PAJl2CkT/jy3zQU0zNC5+6W27Js8B7bUo
         M16Q==
X-Received: by 10.180.19.165 with SMTP id g5mr13852332wie.31.1389042824888;
 Mon, 06 Jan 2014 13:13:44 -0800 (PST)
Received: by 10.180.74.232 with HTTP; Mon, 6 Jan 2014 13:13:44 -0800 (PST)
In-Reply-To: <20140106204203.GI3881@google.com>
X-Google-Sender-Auth: MBWQeUznIr3pCb53H1-6eHwMatA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240064>

On Mon, Jan 6, 2014 at 3:42 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> John Szakmeister wrote:
>
>>                                                        I think in a
>> typical, feature branch-based workflow @{u} would be nearly useless.
>
> I thought the idea of @{u} was that it represents which ref one
> typically wants to compare the current branch to.  It is used by
> 'git branch -v' to show how far ahead or behind a branch is and
> used by 'git pull --rebase' to forward-port a branch, for example.
>
> So a topic branch with @{u} pointing to 'master' or 'origin/master'
> seems pretty normal and hopefully the shortcuts it allows can make
> life more convenient.

Is there an outline of this git workflow in the documentation
somewhere?  Do you save your work in a forked repo anywhere?  If so,
how do you typically save your work.  I typically have my @{u}
pointing to where I save my work.  Perhaps I'm missing something
important here, but I don't feel like the current command set and
typical workflow (at least those in tutorials) leads you in that
direction.

Here is one example:
   <https://www.atlassian.com/git/workflows#!workflow-feature-branch>

> It is *not* primarily about where the branch gets pushed.  After all,
> in both the 'matching' and the 'simple' mode, "git push" does not push
> the current branch to its upstream @{u} unless @{u} happens to have
> the same name.

Then where does it get pushed?  Do you always specify where to save your work?

FWIW, I think the idea of treating @{u} as the eventual recipient of
your changes is good, but then it seems like Git is lacking the
"publish my changes to this other branch" concept.

Am I missing something?  If there is something other than @{u} to
represent this latter concept, I think `git push` should default to
that instead.  But, at least with my current knowledge, that doesn't
exist--without explicitly saying so--or treating @{u} as that branch.
If there's a better way to do this, I'd love to hear it!

Thanks!

-John
