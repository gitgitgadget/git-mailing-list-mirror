From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 4/6] log: update to OPT_BOOL
Date: Sun,  7 Apr 2013 12:46:22 -0500
Message-ID: <1365356784-24872-5-git-send-email-felipe.contreras@gmail.com>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 19:48:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOthR-0003ti-9M
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934205Ab3DGRsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:48:11 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:38838 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934151Ab3DGRsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:48:10 -0400
Received: by mail-oa0-f54.google.com with SMTP id n12so5411150oag.41
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=KUO9Qpzi+31cLruTJvyI9mIi6oGMQ4SkZt1x9QRdY9A=;
        b=uJnNh1TrDkk/UWaF205EpzmiaCS3VCMSAFvxIVNDN0I8kK/TlDULgyIQ9/GcTKKDha
         iMiRvI0M1oofUK41U/qxY+pOt56FpKJwtowLagm3e/kUKVnXbFSpi9q+t+NsZMHaucUN
         Bn3zPDSH3pl1XGQ+1Xrtyoq4LtsVDuYZW8LLeMFSESrQjV0GeMUEFpYrhX33T2UnhR4X
         Amm0SJHQl+qUjtqKTZktQ1XJmD6EHnM5BG8OT4eITwlJJQDEhDGwjFB+k5qI9vgSO40i
         bB/lbOpr6UDoadtRSnSZIqyrryaRBWbgBlVsxCBMNw6S/AXQeOGtFPzj06r7EuMY/KWv
         fYJg==
X-Received: by 10.182.164.73 with SMTP id yo9mr13312796obb.28.1365356889358;
        Sun, 07 Apr 2013 10:48:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id jw8sm987544obb.14.2013.04.07.10.48.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 10:48:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220344>

OPT_BOOLEAN is deprecated, and this is what we want.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/log.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index cd942ee..488a254 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -99,9 +99,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	int quiet = 0, source = 0, mailmap = 0;
 
 	const struct option builtin_log_options[] = {
-		OPT_BOOLEAN(0, "quiet", &quiet, N_("suppress diff output")),
-		OPT_BOOLEAN(0, "source", &source, N_("show source")),
-		OPT_BOOLEAN(0, "use-mailmap", &mailmap, N_("Use mail map file")),
+		OPT_BOOL(0, "quiet", &quiet, N_("suppress diff output")),
+		OPT_BOOL(0, "source", &source, N_("show source")),
+		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
 		  PARSE_OPT_OPTARG, decorate_callback},
 		OPT_END()
@@ -1090,12 +1090,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'N', "no-numbered", &numbered, NULL,
 			    N_("use [PATCH] even with multiple patches"),
 			    PARSE_OPT_NOARG, no_numbered_callback },
-		OPT_BOOLEAN('s', "signoff", &do_signoff, N_("add Signed-off-by:")),
-		OPT_BOOLEAN(0, "stdout", &use_stdout,
+		OPT_BOOL('s', "signoff", &do_signoff, N_("add Signed-off-by:")),
+		OPT_BOOL(0, "stdout", &use_stdout,
 			    N_("print patches to standard out")),
-		OPT_BOOLEAN(0, "cover-letter", &cover_letter,
+		OPT_BOOL(0, "cover-letter", &cover_letter,
 			    N_("generate a cover letter")),
-		OPT_BOOLEAN(0, "numbered-files", &just_numbers,
+		OPT_BOOL(0, "numbered-files", &just_numbers,
 			    N_("use simple number sequence for output file names")),
 		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
 			    N_("use <sfx> instead of '.patch'")),
-- 
1.8.2
