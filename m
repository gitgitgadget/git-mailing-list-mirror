From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git status: print files under untracked dir if -a is given
Date: Tue, 30 May 2006 02:34:55 -0700
Message-ID: <7vfyir26v4.fsf@assigned-by-dhcp.cox.net>
References: <87slmrdhe6.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 11:35:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl0d1-0003Jp-7w
	for gcvg-git@gmane.org; Tue, 30 May 2006 11:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWE3Je5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 05:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWE3Je5
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 05:34:57 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:14333 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932212AbWE3Je5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 05:34:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060530093456.XQKG11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 May 2006 05:34:56 -0400
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <87slmrdhe6.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Tue, 30 May 2006 17:46:17 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21027>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> git status: print files under untracked dir if -a is given
>
> git status (git-commit.sh) currently doesn't show files under
> untracked directory.  this is inconvenient when adding many files
> under new directory.
>
> this patch change its behavior to show files under untracked directory
> if option --all is given.
>
> Signed-off-by: Yasushi SHOJI <yashi@atmark-techno.com>

I do not quite understand your rationale behind linking -a and
"show untracked" behaviour.  In many cases, after modifying
multiple files "commit -a" is the preferred way to make commits
for people who keep their tree clean (meaning, they do not leave
unrelated changes to their working tree files), and I suspect
your change would clutter their commit log buffer with unrelated
files they did not ask to see.

At least this would make things somewhat unpleasant for me to
use, since I do "commit -a" often and I have my random notes
files under ./+trash subdirectory of the main project (yes, I
know I could add /+trash to .gitignore).

We have something different but perhaps related by Matthias
Lederhofer to add "git status --untracked" since you did this
patch.

        commit 443f8338b9e248353a7095a1096684f1ed106c66
        Author: Matthias Lederhofer <matled@gmx.net>
        Date:   Mon May 22 23:02:06 2006 +0200

Does it solve your problem?
