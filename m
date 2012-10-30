From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: change symlink
Date: Tue, 30 Oct 2012 22:19:07 +0100
Message-ID: <m2mwz3odys.fsf@igel.home>
References: <CAH_OBie-irmpBrJG6KB3W8bgYjQdyVYiUR-SvJPnx1FXUya0uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:19:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJDp-0003EF-Db
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934722Ab2J3VTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:19:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:35364 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934669Ab2J3VTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:19:12 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Xrlt34QJqz3hhk2;
	Tue, 30 Oct 2012 22:19:07 +0100 (CET)
X-Auth-Info: Ev6QPq/emd7Nm2hY9+S0/pTrNLQxe9TnGtFnyJhV71M=
Received: from igel.home (ppp-88-217-108-88.dynamic.mnet-online.de [88.217.108.88])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Xrlt344wdzbbhR;
	Tue, 30 Oct 2012 22:19:07 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 43985CA2A2; Tue, 30 Oct 2012 22:19:07 +0100 (CET)
X-Yow: I have accepted Provolone into my life!
In-Reply-To: <CAH_OBie-irmpBrJG6KB3W8bgYjQdyVYiUR-SvJPnx1FXUya0uA@mail.gmail.com>
	(shawn wilson's message of "Tue, 30 Oct 2012 21:07:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208739>

shawn wilson <ag4ve.us@gmail.com> writes:

> i'm curious why this is being reported as deleted in status and diff
> and not modified? this was tested on a build of the master branch of
> the current git repo (1.8.0).
>
> mkdir t cd t; git --init
>
> touch test
> git add test
> git commit test -m "test"
>
> ln -s test t2
> git add t2
> git commit t2 -m "symlink"
>
> rm t2
> mkdir -p t2/one
> ln -s test t2/one/test
  git add t2/one/test

> this then shows up as:
>
>  % git status
> # On branch master
> # Changes not staged for commit:
> #   (use "git add/rm <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       deleted:    t2
> #
> no changes added to commit (use "git add" and/or "git commit -a")

I'd expected t2/one/test be reported as untracked.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
