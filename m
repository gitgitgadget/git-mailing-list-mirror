From: Jeff King <peff@peff.net>
Subject: [PATCH] tag: fix some mis-organized options in "-h" listing
Date: Thu, 12 Mar 2015 14:15:09 -0400
Message-ID: <20150312181509.GA20987@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 19:16:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW7ez-0005xZ-MM
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 19:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbbCLSPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 14:15:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:60639 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752014AbbCLSPM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 14:15:12 -0400
Received: (qmail 3003 invoked by uid 102); 12 Mar 2015 18:15:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 13:15:12 -0500
Received: (qmail 5457 invoked by uid 107); 12 Mar 2015 18:15:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 14:15:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Mar 2015 14:15:09 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265364>

Running "git tag -h" currently prints:

  [...]
  Tag creation options
      [...]
      --column[=<style>]    show tag list in columns
      --sort <type>         sort tags

  Tag listing options
      --contains <commit>   print only tags that contain the commit
      --points-at <object>  print only tags of the object

The "--column" and "--sort" options should go under the "Tag listing" group.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 4194b9a..6f07ac6 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -605,13 +605,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists")),
+
+		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
 		{
 			OPTION_CALLBACK, 0, "sort", &tag_sort, N_("type"), N_("sort tags"),
 			PARSE_OPT_NONEG, parse_opt_sort
 		},
-
-		OPT_GROUP(N_("Tag listing options")),
 		{
 			OPTION_CALLBACK, 0, "contains", &with_commit, N_("commit"),
 			N_("print only tags that contain the commit"),
-- 
2.3.2.472.geadab3c
