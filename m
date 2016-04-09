From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] config: lower-case first word of error strings
Date: Sat, 9 Apr 2016 13:42:31 -0400
Message-ID: <20160409174230.GA11873@sigill.intra.peff.net>
References: <20160409173904.GA5127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Tom G. Christensen" <tgc@jupiterrise.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 19:42:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aowuD-00057x-B5
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 19:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbcDIRmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 13:42:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:46918 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754308AbcDIRmf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 13:42:35 -0400
Received: (qmail 3666 invoked by uid 102); 9 Apr 2016 17:42:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 13:42:34 -0400
Received: (qmail 12960 invoked by uid 107); 9 Apr 2016 17:42:38 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 09 Apr 2016 13:42:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Apr 2016 13:42:31 -0400
Content-Disposition: inline
In-Reply-To: <20160409173904.GA5127@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291103>

This follows our usual style (both throughout git, and
throughout the rest of this file).

This covers the whole file, but note that I left the capitalization in
the multi-sentence:

  error: malformed value...
  error: Must be one of ...

because it helps make it clear that we are starting a new sentence in
the second one.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 8f66519..6b81931 100644
--- a/config.c
+++ b/config.c
@@ -108,7 +108,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 
 	expanded = expand_user_path(path);
 	if (!expanded)
-		return error("Could not expand include path '%s'", path);
+		return error("could not expand include path '%s'", path);
 	path = expanded;
 
 	/*
@@ -950,7 +950,7 @@ static int git_default_branch_config(const char *var, const char *value)
 		else if (!strcmp(value, "always"))
 			autorebase = AUTOREBASE_ALWAYS;
 		else
-			return error("Malformed value for %s", var);
+			return error("malformed value for %s", var);
 		return 0;
 	}
 
@@ -976,7 +976,7 @@ static int git_default_push_config(const char *var, const char *value)
 		else if (!strcmp(value, "current"))
 			push_default = PUSH_DEFAULT_CURRENT;
 		else {
-			error("Malformed value for %s: %s", var, value);
+			error("malformed value for %s: %s", var, value);
 			return error("Must be one of nothing, matching, simple, "
 				     "upstream or current.");
 		}
@@ -2223,7 +2223,7 @@ void git_config_set_multivar_in_file(const char *config_filename,
 {
 	if (git_config_set_multivar_in_file_gently(config_filename, key, value,
 						   value_regex, multi_replace) < 0)
-		die(_("Could not set '%s' to '%s'"), key, value);
+		die(_("could not set '%s' to '%s'"), key, value);
 }
 
 int git_config_set_multivar_gently(const char *key, const char *value,
@@ -2404,7 +2404,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 #undef config_error_nonbool
 int config_error_nonbool(const char *var)
 {
-	return error("Missing value for '%s'", var);
+	return error("missing value for '%s'", var);
 }
 
 int parse_config_key(const char *var,
-- 
2.8.1.245.g18e0f5c
