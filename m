From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore submodules
Date: Fri, 7 Nov 2014 14:58:22 +0100 (CET)
Message-ID: <84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 07 14:58:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmk3h-0000Ot-PD
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 14:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbaKGN61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 08:58:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:54435 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbaKGN6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 08:58:24 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LgvEY-1YPhE02St4-00oHwd;
 Fri, 07 Nov 2014 14:58:22 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1415368490.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:jG//jz95iYidjXoGSyRRW0/jzrGI5EFNYPIry9WK2KpwGyVL468
 GwgD6Xjv1CcU/QWSyCun9nDHQ8uI01r4gR9VeuhblYR/VUHTfM5oeDRkrek+5RN7dacxUc4
 crKJs9OoAZqjtlQxWc4N+MMBmcYGp4paZqJpdEqLVk3WCoORvag7VHNVh6v5qVE5FIE+eqQ
 KIzGh4/PqzGvDPT8e8I4w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They are not affected by the update anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index be4172f..4ba51df 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -740,7 +740,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 static void merge_worktree(unsigned char *sha1)
 {
 	const char *update_refresh[] = {
-		"update-index", "--refresh", NULL
+		"update-index", "--ignore-submodules", "--refresh", NULL
 	};
 	const char *read_tree[] = {
 		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
-- 
2.0.0.rc3.9669.g840d1f9
