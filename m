From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/4] revert: use run_command_v_opt() instead of
	execv_git_cmd()
Date: Sat, 29 May 2010 06:40:40 +0200
Message-ID: <20100529044044.569.15379.chriscool@tuxfamily.org>
References: <20100529043738.569.85482.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 29 06:41:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIDrb-0007PG-5b
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 06:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019Ab0E2ElS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 00:41:18 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56244 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab0E2ElR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 00:41:17 -0400
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 07D2E818015;
	Sat, 29 May 2010 06:41:10 +0200 (CEST)
X-git-sha1: 639e313e98b0365513e2a4b40059e43b938c8aad 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100529043738.569.85482.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147953>

This is needed by the following commits, because we are going
to cherry pick many commits instead of just one.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 7976b5a..9737ad5 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -534,7 +534,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			args[i++] = defmsg;
 		}
 		args[i] = NULL;
-		return execv_git_cmd(args);
+		return run_command_v_opt(args, RUN_GIT_CMD);
 	}
 	free_message(&msg);
 	free(defmsg);
-- 
1.7.1.346.g7c1d7.dirty
