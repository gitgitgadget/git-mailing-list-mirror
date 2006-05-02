From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bug in git log
Date: Tue, 02 May 2006 01:24:21 -0700
Message-ID: <7virooomve.fsf@assigned-by-dhcp.cox.net>
References: <20060502075122.GA8203@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 10:24:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaqBF-00074f-V9
	for gcvg-git@gmane.org; Tue, 02 May 2006 10:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWEBIYX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 04:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWEBIYX
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 04:24:23 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:54437 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932507AbWEBIYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 04:24:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060502082422.EWUO15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 04:24:22 -0400
To: Matthias Kestenholz <lists@irregular.ch>
In-Reply-To: <20060502075122.GA8203@spinlock.ch> (Matthias Kestenholz's
	message of "Tue, 2 May 2006 09:51:22 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19407>

Matthias Kestenholz <lists@irregular.ch> writes:

> Inside your git source directory, do:
>
> First bug using old whatchanged script (not builtin version)
>
> $ ./git-whatchanged.sh -- unresolve.c
> fatal: ambiguous argument 'unresolve.c': unknown revision or
> filename
> Use '--' to separate filenames from revisions
>
> $ ./git-whatchanged.sh -- -- unresolve.c
> [...] gives the expected output

That indeed sounds funny.  I was hoping to see it myself but did
not reproduce for me X-<.

> $ git log -- unresolve.c
> $ git log -- -- unresolve.c
> $ git whatchanged -- unresolve.c
>
> both give no output.

I do not have an older version between 0.99.9m and 1.3.1, but
1.3.1 (the current stale release) does not seem to have this
"double dash" problem.  Neither the tonight's "master" version
(746437) nor "next".

We used to have a build problem where we forgot to remove
libgit.a and an old object from the archive was used by
mistake.  Could you try rm -f libgit.a and rebuild your git to
see if it helps?
