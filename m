From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] git-cvsimport-script: update cvsps cache instead of rebuilding it
Date: Mon, 4 Jul 2005 16:09:46 +0200
Message-ID: <20050704140946.GO18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl> <20050630163000.GT10850@kiste.smurf.noris.de> <Pine.LNX.4.63.0506301321350.1667@localhost.localdomain> <pan.2005.07.01.09.43.24.106822@smurf.noris.de> <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 04 16:27:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpRuU-0001He-Bk
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 16:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVGDO0o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 10:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVGDO0o
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 10:26:44 -0400
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:2776 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261190AbVGDO0d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 10:26:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id E4D7D137A2C
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 16:26:32 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by thumbler.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 1DFA8137A54
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 16:26:31 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 07B184C0D1
	for <git@vger.kernel.org>; Mon,  4 Jul 2005 16:26:31 +0200 (CEST)
Received: (qmail 24414 invoked by uid 500); 4 Jul 2005 14:09:46 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-cvsimport-script: update cvsps cache instead of rebuilding it

Updating the cache is sufficient for most purposes.
If users really want to rebuild the cache, they can specify
the option themselves.

---
commit 6e7e37b0bfc921aa1f0cb30560fc128e87a41966
tree 12a9303d4ba4566d9e081b2c375648685ce41e93
parent 46e63efc072bc440e4c6aad33d3157b70f5172b6
author Sven Verdoolaege <skimo@kotnet.org> Mon, 04 Jul 2005 15:35:30 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Mon, 04 Jul 2005 15:35:30 +0200

 git-cvsimport-script |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -436,7 +436,7 @@ die "Cannot fork: $!\n" unless defined $
 unless($pid) {
 	my @opt;
 	@opt = split(/,/,$opt_p) if defined $opt_p;
-	exec("cvsps",@opt,"-x","-A","--cvs-direct",'--root',$opt_d,$cvs_tree);
+	exec("cvsps",@opt,"-u","-A","--cvs-direct",'--root',$opt_d,$cvs_tree);
 	die "Could not start cvsps: $!\n";
 }
 
