From: Aaron Straus <aaron@merfinllc.com>
Subject: [PATCH] trivial fix for init-db
Date: Mon, 18 Apr 2005 16:14:35 -0700
Message-ID: <20050418231435.GF8929@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 19 01:15:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNfRv-00063d-Vd
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 01:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVDRXSl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 19:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVDRXSl
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 19:18:41 -0400
Received: from mmsmtp.merfinllc.com ([63.73.180.145]:16833 "EHLO
	mule.merfinllc.com") by vger.kernel.org with ESMTP id S261186AbVDRXSj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 19:18:39 -0400
Received: from mule.merfinllc.com (localhost [127.0.0.1])
	by mule.merfinllc.com (8.13.4/8.13.4/Debian-1) with ESMTP id j3INEZfq021669
	for <git@vger.kernel.org>; Mon, 18 Apr 2005 16:14:35 -0700
Received: (from aaron@localhost)
	by mule.merfinllc.com (8.13.4/8.13.4/Submit) id j3INEZQU021667
	for git@vger.kernel.org; Mon, 18 Apr 2005 16:14:35 -0700
X-Authentication-Warning: mule.merfinllc.com: aaron set sender to aaron@merfinllc.com using -f
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This makes init-db work for common object database.

Signed-Off-By: Aaron Straus <aaron@merfinllc.com>

init-db.c: aa00fbb1b95624f6c30090a17354c9c08a6ac596
--- a/init-db.c
+++ b/init-db.c
@@ -24,7 +24,7 @@ int main(int argc, char **argv)
 	sha1_dir = getenv(DB_ENVIRONMENT);
 	if (sha1_dir) {
 		struct stat st;
-		if (!stat(sha1_dir, &st) < 0 && S_ISDIR(st.st_mode))
+		if (!stat(sha1_dir, &st) && S_ISDIR(st.st_mode))
 			return 0;
 		fprintf(stderr, "DB_ENVIRONMENT set to bad directory %s: ", sha1_dir);
 	}
