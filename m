From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] builtin/log: remove redundant initialization
Date: Wed, 21 Dec 2011 13:05:27 +0100
Message-ID: <4EF1CB87.8050801@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 13:06:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdKwa-00086S-9X
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 13:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab1LUMGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 07:06:40 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:50759 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057Ab1LUMGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 07:06:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id C9FB0DE968
	for <git@vger.kernel.org>; Wed, 21 Dec 2011 13:06:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z8glneBJGp3e for <git@vger.kernel.org>;
	Wed, 21 Dec 2011 13:06:36 +0100 (CET)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id A3BD1DE820
	for <git@vger.kernel.org>; Wed, 21 Dec 2011 13:06:36 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111108 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187560>

"abbrev" and "commit_format" in struct rev_info get initialized in
init_revisions - no need to reinit in cmd_log_init_defaults.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 builtin/log.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 89d0cc0..7d1f6f8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -73,8 +73,6 @@ static int decorate_callback(const struct option *opt, const char *arg, int unse
 
 static void cmd_log_init_defaults(struct rev_info *rev)
 {
-	rev->abbrev = DEFAULT_ABBREV;
-	rev->commit_format = CMIT_FMT_DEFAULT;
 	if (fmt_pretty)
 		get_commit_format(fmt_pretty, rev);
 	rev->verbose_header = 1;
-- 
1.7.8.400.g03f4
