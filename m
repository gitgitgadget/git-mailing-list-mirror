From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/7] Add a test for rebase when a change was picked upstream
Date: Sat, 07 Jan 2006 18:22:29 -0800
Message-ID: <7v7j9b7922.fsf@assigned-by-dhcp.cox.net>
References: <20060108003948.GL1113@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 03:22:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvQCY-000614-OT
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 03:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbWAHCWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 21:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWAHCWc
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 21:22:32 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:36586 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161141AbWAHCWb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 21:22:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060108022003.NDUG20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 21:20:03 -0500
To: Yann Dirson <ydirson@altern.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14303>

Yann Dirson <ydirson@altern.org> writes:

> +export GIT_AUTHOR_EMAIL=bogus_email_address

This is probably not needed for this test, although it would not
hurt.

> +test_expect_success \
> +    'rebase topic branch against new master and check git-am did not get halted' \
> +    'sh -x git-rebase master &&
> +     test ! -d .dotest
> +'

Some people build git with SHELL_PATH=/bin/bash because their
/bin/sh is not POSIX enough (e.g. Solaris).  Perhaps emulate
what t5501 does?
