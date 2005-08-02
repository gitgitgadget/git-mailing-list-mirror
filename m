From: Nicolas Pitre <nico@cam.org>
Subject: [patch] list shortlog items in commit order
Date: Tue, 02 Aug 2005 17:18:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508021713230.15300@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 23:23:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E04E0-0000GG-7H
	for gcvg-git@gmane.org; Tue, 02 Aug 2005 23:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVHBVWY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 17:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVHBVTv
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 17:19:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63078 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261838AbVHBVTT
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 17:19:19 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IKM00CBY5VLW6@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Aug 2005 17:18:57 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The current shortlog list is backward making it look odd.
This reverses it so things appear more logically.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/git-shortlog b/git-shortlog
--- a/git-shortlog
+++ b/git-shortlog
@@ -90,7 +90,7 @@ sub shortlog_output {
 
 		# output author's 1-line summaries
 		$obj = $map{$key};
-		foreach $desc (@$obj) {
+		foreach $desc (reverse @$obj) {
 			print "  $desc\n";
 			$n_output++;
 		}
