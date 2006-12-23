From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Makefile: add quick-install-doc for installing pre-built manpages
Date: Fri, 22 Dec 2006 23:59:06 -0800
Message-ID: <7virg3t54l.fsf@assigned-by-dhcp.cox.net>
References: <11668546833727-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:59:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1mj-0004nh-Ow
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbWLWH7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbWLWH7K
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:59:10 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:39498 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbWLWH7J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:59:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061223075907.BJNE3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Dec 2006 02:59:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 27yQ1W00B1kojtg0000000; Sat, 23 Dec 2006 02:58:25 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11668546833727-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Fri, 22 Dec 2006 22:18:02 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35298>

Eric Wong <normalperson@yhbt.net> writes:

> This adds and uses the install-doc-quick.sh file to
> Documentation/, which is usable for people who track either the
> 'html' or 'man' heads in Junio's repository.

Sadly I cannot use this myself ;-).

Two points and a half.

(1) DESTDIR traditionally is always used to denote the virtual
    root directory for fake install, typically later to be
    copied over elsewhere or tarred up (e.g. "install git.1
    $(DESTDIR)/usr/share/man/man1/git.1"); I'd suggest to make
    install-doc-quick.sh script take two parameters, the branch
    and the destination directory.

(2) "git-clone" makes my html and man branches tracked with
    remotes/origin/{html,man} by default; you would want to make
    the local tracking branch 'man' you have hardcoded in the
    Makefile overridable and make it default to "origin/man".

(2.5) "chmod +x install-doc-quick.sh", even if you say "sh
      ./..." in your Makefile.


      
