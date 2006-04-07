From: Junio C Hamano <junkio@cox.net>
Subject: blame now knows -S
Date: Fri, 07 Apr 2006 02:28:40 -0700
Message-ID: <7v1ww9loon.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Fri Apr 07 11:28:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRnGm-0006mm-Q2
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 11:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWDGJ2m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 05:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDGJ2m
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 05:28:42 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:6848 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932394AbWDGJ2l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Apr 2006 05:28:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060407092841.WVVW26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Apr 2006 05:28:41 -0400
To: Martin Langhoff <martin@catalyst.net.nz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18496>

I've made a few changes to "git blame" myself:

 - fix breakage caused by recent revision walker reorganization;
 - use built-in xdiff instead of spawning GNU diff;
 - implement -S <ancestry-file> like annotate does.

Depending on the density of changes, it now appears that blame
is 10%-30% faster than annotate.  I thought CVS emulator might
be interested to give it a whirl..
