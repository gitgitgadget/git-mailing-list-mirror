From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 2/2] Make some strings translatable
Date: Mon, 19 Mar 2012 18:51:43 +0100
Message-ID: <1332179503-2992-3-git-send-email-vfr@lyx.org>
References: <1332179503-2992-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 18:52:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9gkf-0004O6-4Y
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 18:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030737Ab2CSRwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 13:52:09 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46428 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030417Ab2CSRwH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 13:52:07 -0400
Received: by mail-ee0-f46.google.com with SMTP id c41so2815283eek.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 10:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=4B6GD+RRM/zdt+GqRRFnKoGdcmN1+Gi1zy42WJC90Bo=;
        b=a1poJpiAf4os3wJCdzwmW+mChOiKDB1xWodOwhLZbnPgLRhH1YGpSETH0JizKNpbqt
         m4EduY4XMVhGJAW5sBJXgi9Yix1jPVc0440k6SPMNcxxdC8mpzmmPLLIKbqodUuu4zGo
         UBS4ztN2z1C8X56gLvnDzWaKcHjOSuuOc6fV8af0mayPWq3wrBSyJiqL3OYgO8JRh+/z
         y0tmJxlTne4oVVPsnmwdW9imJoEtIi8LIuL4ZsNJHlCpBFiS0iwanRaMGLDThqitOOpz
         mJpl9u7VwnpR4KCY+Zx7DVwUKX+tnAEiRXftavurDPVDnOWaTo+wl4BW4ajWQ2nvFsF8
         c2nQ==
Received: by 10.14.94.139 with SMTP id n11mr1179035eef.47.1332179526967;
        Mon, 19 Mar 2012 10:52:06 -0700 (PDT)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id m42sm21762289eef.0.2012.03.19.10.52.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 10:52:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1332179503-2992-1-git-send-email-vfr@lyx.org>
X-Gm-Message-State: ALoCoQmxwGyR2c3YEstFdQP/5PsRbaQdwuaU2NVoOyWuQrbeiju/I/oZ10SzxwJV8CWrxfSsbQXI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193446>

From: Vincent van Ravesteijn <vfr@lyx.org>

These strings seem not to be part of the plumbing interface and can therefore be translated. Also the style is adjusted to the guidelines mentioned in the previous commit.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 gpg-interface.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 5e14a21..66a7c12 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -109,10 +109,10 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	args_gpg[0] = gpg_program;
 	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
 	if (fd < 0)
-		return error("could not create temporary file '%s': %s",
+		return error(_("Could not create temporary file '%s': %s"),
 			     path, strerror(errno));
 	if (write_in_full(fd, signature, signature_size) < 0)
-		return error("failed writing detached signature to '%s': %s",
+		return error(_("Failed writing detached signature to '%s': %s"),
 			     path, strerror(errno));
 	close(fd);
 
@@ -124,7 +124,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	args_gpg[2] = path;
 	if (start_command(&gpg)) {
 		unlink(path);
-		return error("could not run gpg.");
+		return error(_("Could not run 'gpg'"));
 	}
 
 	write_in_full(gpg.in, payload, payload_size);
-- 
1.7.5.4
