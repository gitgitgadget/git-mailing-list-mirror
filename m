From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] clone: reorder --dissociate and --reference options
Date: Thu, 21 May 2015 00:16:04 -0400
Message-ID: <20150521041604.GB5196@peff.net>
References: <20150521041435.GA18978@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:16:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvHtz-0008Io-OR
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbbEUEQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:16:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:33632 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751700AbbEUEQG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:16:06 -0400
Received: (qmail 659 invoked by uid 102); 21 May 2015 04:16:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:16:06 -0500
Received: (qmail 30779 invoked by uid 107); 21 May 2015 04:16:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:16:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:16:04 -0400
Content-Disposition: inline
In-Reply-To: <20150521041435.GA18978@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269539>

These options are intimately related, so it makes sense to
list them nearby in the "-h" output (they are already
adjacent in the manpage).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 1426ef5..a0ec1a9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -76,6 +76,8 @@ static struct option builtin_clone_options[] = {
 		   N_("directory from which templates will be used")),
 	OPT_STRING_LIST(0, "reference", &option_reference, N_("repo"),
 			N_("reference repository")),
+	OPT_BOOL(0, "dissociate", &option_dissociate,
+		 N_("use --reference only while cloning")),
 	OPT_STRING('o', "origin", &option_origin, N_("name"),
 		   N_("use <name> instead of 'origin' to track upstream")),
 	OPT_STRING('b', "branch", &option_branch, N_("branch"),
@@ -86,8 +88,6 @@ static struct option builtin_clone_options[] = {
 		    N_("create a shallow clone of that depth")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
-	OPT_BOOL(0, "dissociate", &option_dissociate,
-		 N_("use --reference only while cloning")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
-- 
2.4.1.528.g00591e3
