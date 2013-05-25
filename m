From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/6] build: cleanup using $^
Date: Fri, 24 May 2013 21:41:02 -0500
Message-ID: <1369449666-18879-3-git-send-email-felipe.contreras@gmail.com>
References: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:42:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Ra-0000Du-0t
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138Ab3EYCmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:42:51 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:36487 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001Ab3EYCmu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:42:50 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so6113537obc.7
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kimNe8PqVSjwVbXw6W5gFUw+vybltPDH1IPMEanepWg=;
        b=M5MUE0bO5Q+wnkU0Idnj77B/J75mlF8r0DELAYUtazrIceibnlnb/Ci1YU3m4kybts
         F1OTldq1jg7Nke0r6xRk5U7fY3Z/19JsDLUI9tcw2Q8tCJXkLwwqW2BFqRtg8LZfb8VQ
         jlb8lYsn3WsJrFAZJg0aJDhgn3dUvcKdw62Z1XRVm8fKFslAaME9Rc0nj09SaGtcRaYz
         qe3k2qRzwucEYivJ2IC6Urt5ZTnPj0q18f9vOLF+Fb1y+xODYEs7cVvI+2ZBWYjT+R9a
         T97KttJaLoNQIbJqWKosJFGipnTCzTgkOhHAmmcax1TNQo4xUXAMLH+QklKE8uVWF9q0
         o4hg==
X-Received: by 10.182.138.4 with SMTP id qm4mr13697089obb.101.1369449769920;
        Fri, 24 May 2013 19:42:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b1sm9177896oeo.8.2013.05.24.19.42.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:42:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225470>

There's no need to list again the prerequisites. No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 2704df4..1ac52dd 100644
--- a/Makefile
+++ b/Makefile
@@ -510,11 +510,11 @@ build-python-script: $(SCRIPT_PYTHON_GEN)
 
 .PHONY: install-perl-script install-sh-script install-python-script
 install-sh-script: $(SCRIPT_SH_GEN)
-	$(INSTALL) $(SCRIPT_SH_GEN) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 install-perl-script: $(SCRIPT_PERL_GEN)
-	$(INSTALL) $(SCRIPT_PERL_GEN) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 install-python-script: $(SCRIPT_PYTHON_GEN)
-	$(INSTALL) $(SCRIPT_PYTHON_GEN) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
 .PHONY: clean-perl-script clean-sh-script clean-python-script
 clean-sh-script:
@@ -1671,7 +1671,7 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
 shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 
 strip: $(PROGRAMS) git$X
-	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
+	$(STRIP) $(STRIP_OPTS) $^
 
 ### Target-specific flags and dependencies
 
-- 
1.8.3.rc3.312.g47657de
