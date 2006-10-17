From: Junio C Hamano <junkio@cox.net>
Subject: heads-up: git-index-pack in "next" is broken
Date: Mon, 16 Oct 2006 21:55:57 -0700
Message-ID: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 17 06:56:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZgzi-0003w8-6m
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 06:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423056AbWJQEz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 00:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423060AbWJQEz7
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 00:55:59 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:7819 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1423056AbWJQEz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 00:55:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017045558.QJLZ18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 00:55:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bGvl1V0011kojtg0000000
	Tue, 17 Oct 2006 00:55:45 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29018>

I'm still a bit under the weather and do not have enough
concentration to dig into the problem tonight, but I noticed
that something in "next", most likely the delta-base-offset
patchset, broke git-index-pack:

$ X=ec0c3491753e115e1775256f6b7bd1bce4dea7cd
$ wget http://www.kernel.org/pub/scm/git/git.git/objects/pack/pack-$X.pack
$ ~/git-master/bin/git-index-pack pack-$X.pack
ec0c3491753e115e1775256f6b7bd1bce4dea7cd
$ git-index-pack pack-$X.pack
fatal: packfile 'pack-ec0c3491753e115e1775256f6b7bd1bce4dea7cd.pack' has unresolved deltas
