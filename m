From: Jeff King <peff@peff.net>
Subject: [PATCH] format-patch: set default stat_width to 72
Date: Thu, 3 Apr 2008 06:22:14 -0400
Message-ID: <20080403102214.GA23121@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jan Engelhardt <jengelh@computergmbh.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhMaz-0003he-Cp
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 12:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbYDCKWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 06:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbYDCKWR
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 06:22:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2334 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbYDCKWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 06:22:16 -0400
Received: (qmail 9539 invoked by uid 111); 3 Apr 2008 10:22:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 03 Apr 2008 06:22:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Apr 2008 06:22:14 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78743>

The usual default is 80, which should fit in the terminals
of most users. However, it is usually considered polite to
keep email lines to 72 characters to accomodate a few layers
of quoting.

Signed-off-by: Jeff King <peff@peff.net>
---
On Thu, Apr 03, 2008 at 06:14:18AM -0400, Jeff King wrote:

> format-patch already defaults to "--stat --summary -p" if you give it
> no format options. The default stat is 80, I believe; for format-patch
> it should probably be bumped to 72 anyway.

This should be totally harmless and maint-worthy, I would think.

 builtin-log.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5c00725..8d7b975 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -771,6 +771,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.ignore_merges = 1;
 	rev.diffopt.msg_sep = "";
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
+	rev.diffopt.stat_width = 72;
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
 
-- 
1.5.5.rc2.171.g7962.dirty
