From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH] Add `format.to` configuration variable.
Date: Wed, 13 Jan 2010 20:55:39 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1001132054380.24673@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 09:02:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUyBA-0003QO-C0
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 09:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab0AMICI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 03:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286Ab0AMICG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 03:02:06 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:43864 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab0AMICF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 03:02:05 -0500
Received: from idran.drake.org.nz (ip-118-90-54-75.xdsl.xnet.co.nz [118.90.54.75])
	by ananke.wxnz.net (Postfix) with ESMTP id 376B9170BDF
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 21:02:01 +1300 (NZDT)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136788>

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
This email was address using this new configuration variable.
---
 builtin-log.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 41b6df4..a608c3d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -501,6 +501,13 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.suffix"))
 		return git_config_string(&fmt_patch_suffix, var, value);
+	if (!strcmp(var, "format.to")) {
+		if (!value)
+			return config_error_nonbool(var);
+		ALLOC_GROW(extra_to, extra_to_nr + 1, extra_to_alloc);
+		extra_to[extra_to_nr++] = xstrdup(value);
+		return 0;
+	}
 	if (!strcmp(var, "format.cc")) {
 		if (!value)
 			return config_error_nonbool(var);
-- 
1.6.6.85.ga4c31
