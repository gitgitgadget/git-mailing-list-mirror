From: Chris Rorvick <chris@rorvick.com>
Subject: Re: Feature Request - Hide ignored files before checkout
Date: Sat, 8 Dec 2012 13:21:07 -0600
Message-ID: <CAEUsAPaHJ+N0EnxGuVkRqcmY0fUy+4myMiWtd1_vu1vRL763JQ@mail.gmail.com>
References: <000301cdd4dd$f8554090$e8ffc1b0$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthew Ciancio <matthew.ciancio16@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 20:21:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThPxn-0001sL-Sp
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 20:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965537Ab2LHTVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2012 14:21:10 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38683 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965534Ab2LHTVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2012 14:21:09 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so1145401lbb.19
        for <git@vger.kernel.org>; Sat, 08 Dec 2012 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=8enI8La+P5StWvQZ5g6eKC97c9JEZ5Zj1+17wfEZBeg=;
        b=KQPkkwbdD4K2pNQoLMgHxZogIdzcPEmF8yHbde+KQq9AxOl1pNW5e6p7/TpVNuHHhU
         FFckZLh20z6qZOcXkbU/f320FFx59ou9pGA+ayuL8P5DBbr4NIb5RgcCPH9SZ8Qtj+J0
         BRmgsBjveey8jYvgtxHy7b46O2RUov1wxyEtWe8QQHihgzA4w/gE0G3is6PamNsigbIa
         2LZzatFbzn4gLJ0/PPQBfmf7U8n0cfu8MCJxQaRRfp10qBpc378eE/uOWR4cO7EB3WYv
         ZONnKnbiqaL21M7POpqZoFsMdHmgzlsEHHr6fxfy1QGuNlMx/+d2xCcJL0xo3B+FvIAe
         /ZVA==
Received: by 10.152.104.240 with SMTP id gh16mr9203473lab.56.1354994467703;
 Sat, 08 Dec 2012 11:21:07 -0800 (PST)
Received: by 10.114.60.230 with HTTP; Sat, 8 Dec 2012 11:21:07 -0800 (PST)
In-Reply-To: <000301cdd4dd$f8554090$e8ffc1b0$@gmail.com>
X-Google-Sender-Auth: HP5sgaVbhD85fYnDyz95msbkFaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211212>

On Fri, Dec 7, 2012 at 6:50 PM, Matthew Ciancio
<matthew.ciancio16@gmail.com> wrote:
> Imagine this scenario:
>
> 1) You have a Git repo with two branches (branchA and branchB), which are
> currently identical.
> 2) Checkout to branch.
> 3) Create file foo.txt, stage it and commit it.
> 4) Create file ignore.txt and add it to the ".gitignore" file of branchB so
> that it is successfully ignored by Git.
> 5) Checkout to branchA.
>
> Problem: ignore.txt does not "disappear" like foo.txt does

When you say "disappear", do you mean "deleted from the file system"
or something else?

> and is now just
> sitting in branchA (and now any other branch I checkout into).

It's not in branchA, it's just no longer ignored because your changes
to .gitignore were effectively reverted by jumping back to the commit
that branchA points to.

> When I first started using Git, I genuinely thought this was a bug, because
> it seems so logical to me that ignore files should hide/reappear just like
> tracked files do, when switching branches.

"hide/reappear" is the equivalent to saying "deleted/created" in the
case of a tracked file in your working tree.  But how would Git cause
an untracked file to reappear?  By definition, it doesn't know
anything about the file.

> P.S. Here is a forum post I made on StackOverflow about the issue:
> http://stackoverflow.com/questions/13761682/gitignore-hide-ignored-files-dur
> ing-checkout

I posted an answer there, too, but I'm not sure I fully understand the
problem.  The top-voted answer doesn't make much sense, though.

Thanks,

Chris
