From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] fmt-merge-msg: detached HEAD
Date: Thu, 25 Jan 2007 16:36:45 +0100
Message-ID: <87zm875d9u.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 16:37:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA6f5-0005Yc-U1
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 16:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbXAYPhL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 25 Jan 2007 10:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbXAYPhL
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 10:37:11 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:35123 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030201AbXAYPhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 10:37:09 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l0PFb6q31807
	for <git@vger.kernel.org>; Thu, 25 Jan 2007 16:37:07 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37729>


Do not say 'Merge ... into HEAD' when detached.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 builtin-fmt-merge-msg.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 87d3d63..8cef425 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -331,7 +331,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, =
const char *prefix)
 			printf(" of %s", srcs.list[i]);
 	}
=20
-	if (!strcmp("master", current_branch))
+	if (!strcmp("master", current_branch) ||
+	    !strcmp("HEAD", current_branch))
 		putchar('\n');
 	else
 		printf(" into %s\n", current_branch);
--=20
1.5.0.rc2.g2fa185-dirty
