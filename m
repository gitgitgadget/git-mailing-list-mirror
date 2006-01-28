From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.1.5
Date: Fri, 27 Jan 2006 20:48:33 -0800
Message-ID: <7virs5x8im.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 28 05:49:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2i1F-0004VM-F5
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 05:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWA1Esg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jan 2006 23:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWA1Esg
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jan 2006 23:48:36 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:61587 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932515AbWA1Esf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2006 23:48:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060128044724.CRXG20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 Jan 2006 23:47:24 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15190>

The latest maintenance release GIT 1.1.5 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.1.5.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.1.5-1.$arch.rpm	(RPM)

Mark Wooding noticed that there is a bug in git-checkout-index
to overflow its internal buffer, if you construct a blob that
records an insanely long symbolic link in your index file and
try to check it out.  This makes it dump core or worse.  

The fix for this problem is the only change from v1.1.4.  The
master branch has been updated with the same fix (so has "pu").


---

By the way, "dump core or worse" is a subtle way to say that
this is a security fix.  To be victimized, you have to somehow
first get such a bogus symbolic link in your index.  Merging
with somebody of dubious trustworthiness is a way to do so;
please practice safe merge ;-).
