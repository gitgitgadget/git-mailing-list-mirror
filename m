From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH] Collocate strings to simplify translation
Date: Thu, 24 May 2012 07:41:28 +0000
Message-ID: <1337845288-7656-1-git-send-email-vfr@lyx.org>
Cc: Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 09:41:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXSg2-0008H3-DQ
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 09:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab2EXHlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 03:41:37 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42669 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2EXHlg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 03:41:36 -0400
Received: by eaak11 with SMTP id k11so2287390eaa.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 00:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=Mrgw8DqNKgq7BG5ZctpBIQFK/L56pO+qvfxrhG95w+8=;
        b=WO8EUTzGlomtt7zrzyHyrPNQunySL33Aq4gSz8zol7o12S/Psgrc26XnkHFUenFKLQ
         otjyolTNnXpplH/j2oa/NwG7q/9sqU0HT+paRBnKdzT8hxfF3l7tsf1w5DwSdAHJTzBE
         Eha0yze+zuwK6CyoqHU3Pb4FiuooJUpRIVc/V9s5WhKkHV62dKPxGl67osoFxZLhiBXV
         Hg1A79fA6Hza9vx2t/SINskxnq2F/DldnZnEOWlR1ebu34qPGniaA5Pi7tXMKPQfVJL/
         9FtT5en7FuXJpy8EEOn7bEUaSNYRByFZzvYJGupJA1h66myxdKP7HuRJwLaMbno/T0K/
         LyEA==
Received: by 10.213.7.70 with SMTP id c6mr2004987ebc.75.1337845295299;
        Thu, 24 May 2012 00:41:35 -0700 (PDT)
Received: from localhost (wlan-145-94-170-237.wlan.tudelft.nl. [145.94.170.237])
        by mx.google.com with ESMTPS id u7sm127457432eeb.7.2012.05.24.00.41.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 00:41:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.msysgit.0
X-Gm-Message-State: ALoCoQlcXO0wfItp4jxHbk8n9LqxZiZqKmYwP45vhbk/7YL5KFMEIVQhZfIE9+Qrzfxd59xiSghx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198361>

The translation of 'Untracked' and 'Ignored' might depend on the following
word. To help the translator, this patch collocates the term 'files'.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 wt-status.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index dd6d8c4..9b65a8c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -185,7 +185,7 @@ static void wt_status_print_other_header(struct wt_status *s,
 					 const char *how)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
-	status_printf_ln(s, c, _("%s files:"), what);
+	status_printf_ln(s, c, _("%s:"), what);
 	if (!advice_status_hints)
 		return;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
@@ -766,9 +766,9 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_submodule_summary(s, 1);  /* unstaged */
 	}
 	if (s->show_untracked_files) {
-		wt_status_print_other(s, &s->untracked, _("Untracked"), "add");
+		wt_status_print_other(s, &s->untracked, _("Untracked files"), "add");
 		if (s->show_ignored_files)
-			wt_status_print_other(s, &s->ignored, _("Ignored"), "add -f");
+			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f");
 	} else if (s->commitable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
 			advice_status_hints
-- 
1.7.9.msysgit.0
