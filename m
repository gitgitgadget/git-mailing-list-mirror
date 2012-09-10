From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: Teach "--edit" action
Date: Mon, 10 Sep 2012 18:25:00 +0200
Message-ID: <vpqk3w1j15v.fsf@bauges.imag.fr>
References: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
	<1347293683-27996-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:25:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6nT-0004ob-4k
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab2IJQZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:25:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56847 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805Ab2IJQZF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:25:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8AGKcb3008690
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Sep 2012 18:20:38 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TB6nE-0001T2-Mo; Mon, 10 Sep 2012 18:25:00 +0200
In-Reply-To: <1347293683-27996-2-git-send-email-andrew.kw.w@gmail.com> (Andrew
	Wong's message of "Mon, 10 Sep 2012 12:14:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Sep 2012 18:20:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8AGKcb3008690
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1347898840.31761@VG8X5ClGXPbaar01apZmXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205139>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> This allows users to edit the todo list while they're in the middle of
> an interactive rebase.

I like the idea.

> +edit)
> +  git_sequence_editor "$todo" ||
> +    die_abort "Could not execute editor"
> +
> +  exit
> +  ;;

Indent with space. Please, use tabs (same below).

> index 15da926..c394b8d 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -38,6 +38,7 @@ C=!                passed to 'git apply'
>  continue!          continue
>  abort!             abort and check out the original branch
>  skip!              skip current patch and continue
> +edit!              edit the todo list during interactive rebase

Just "edit" may be a bit misleading, as we already have the "edit"
action inside the todolist. I'd call this --edit-list to avoid
ambiguity.

This lacks tests, IMHO, as there are many corner-cases (e.g. should we
be allowed to --edit-list while the worktree is in conflict?) that would
deserve to be at least discussed, and as much as possible automatically
tested.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
