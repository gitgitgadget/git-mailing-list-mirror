From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/5] parseopt: add flag to stop on first non option
Date: Fri, 29 Feb 2008 01:45:09 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290145020.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 29 02:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUuKO-00019E-I0
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbYB2Bpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbYB2Bpp
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:45:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:46090 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751119AbYB2Bpo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:45:44 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:45:42 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp032) with SMTP; 29 Feb 2008 02:45:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/x1/cW3Rrxi7rJZ4Sq7zrOwSBLb950naGQTU1JVo
	o2txkfJ2ReV7ns
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802290144130.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75488>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 parse-options.c |    2 ++
 parse-options.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index d9562ba..be35785 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -249,6 +249,8 @@ int parse_options(int argc, const char **argv, const struct option *options,
 		const char *arg = args.argv[0];
 
 		if (*arg != '-' || !arg[1]) {
+			if (flags & PARSE_OPT_STOP_AT_NON_OPTION)
+				break;
 			argv[j++] = args.argv[0];
 			continue;
 		}
diff --git a/parse-options.h b/parse-options.h
index 102ac31..0d40cd2 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -18,6 +18,7 @@ enum parse_opt_type {
 
 enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH = 1,
+	PARSE_OPT_STOP_AT_NON_OPTION = 2,
 };
 
 enum parse_opt_option_flags {
-- 
1.5.4.3.431.g066fa


