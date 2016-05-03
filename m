From: Stefan Beller <sbeller@google.com>
Subject: [RFD/PATCH] submodule doc: describe where we can configure them
Date: Tue,  3 May 2016 16:26:25 -0700
Message-ID: <1462317985-640-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Wed May 04 01:26:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axjiC-0005qM-G8
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 01:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837AbcECX0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 19:26:36 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33768 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295AbcECX0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 19:26:35 -0400
Received: by mail-pf0-f175.google.com with SMTP id 206so17140705pfu.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 16:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jn7IXyxNSr0KdTMhj6PkLswUv2YTQir8blINYKvI3K0=;
        b=eELszt2gbFxC9WGL5hVU3eNzi21r2hjI5kJQuEzfrKs0Ajq+BO0JZKmRJZt2nGmrc0
         ZbKX5Z6w3h8uCo8ggmj/MeLkdLEAU+eSitQjZXIaV6yJlgtiaTpaGon2EumAZpdNy31a
         Ir+CET3vFYVyCLTRnHMh19LtjkqJmgu99YUZrFUtUSCi615kX8qKNeQoaQ3o5bZTg0Zw
         oieUFU/z6KfHgbHAEnQMkca3iyU62hzNIAP7MvRNcX7D4wmWcYj+VBew4DB5E58sEbzj
         fss+Ix6wboowrVe7DUS1SUWb2CFATEEZeDeAVQljYosd5ijiIj4fDkobBflmyDh0V7dr
         e+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jn7IXyxNSr0KdTMhj6PkLswUv2YTQir8blINYKvI3K0=;
        b=fsDJ1RywY+/VoNsoSI11VF7wOuaFtnTkX4sXHPu7r4ZEcQCcA/XE/tvrIdqWlHAGiL
         bRhFyRN5v5Buq1cwNiFuG9Ud3IUtpCK3XCdNnDhKDBfvhyXaT/hEgDw8S6ywavaNs8ZI
         w3NIFctDaPgqoEJAsSRGihwvU6xtMfmSRQVDqyc9NH0o1u5yVLTIMspsyO/hrUvW/VrQ
         PnSQHmlPuhP6updaEC/sVAdic+yry8lY16iO+4nBkUBPkVPMB97UoA3ct76fvj3LJBdG
         f1mW5VCJ5icBYae79seP/YwdFuaZBqW0CPngdGKU56Z5LzVsU0CBea+PLyzYaFhknkzn
         7S6A==
X-Gm-Message-State: AOPr4FUWXQt467x9u3maSfMHKE+O0GpQtaKYtlN7jdZyFJ3C9ILMHkAnYEpI/QbNhlv0Ygop
X-Received: by 10.98.9.83 with SMTP id e80mr7621262pfd.34.1462317994481;
        Tue, 03 May 2016 16:26:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:81d8:5415:7a03:cda9])
        by smtp.gmail.com with ESMTPSA id w187sm695560pfw.50.2016.05.03.16.26.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 May 2016 16:26:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.geb92688.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293478>

This is similar to the gitignore document, but doesn't mirror
the current situation. It is rather meant to start a discussion for
the right approach for mirroring repositories with submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Jonathan, is this something you had in mind?

 Documentation/git-submodule.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 13adebf..b5559e5 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -59,6 +59,22 @@ instead of treating the other project as a submodule. Directories
 that come from both projects can be cloned and checked out as a whole
 if you choose to go that route.
 
+Submodule operations can be configured using the following mechanisms
+(from highest to lowest precedence):
+
+ * the command line for those commands that support taking submodule specs.
+
+ * the configuration file `$GIT_DIR/config`.
+
+ * the configuration file `config` found in the `refs/submodule/config` branch.
+   This can be used to overwrite the upstream configuration in the `.gitmodules`
+   file without changing the history of the project.
+   Useful options here are overwriting the base, where relative URLs apply to,
+   when mirroring only parts of the larger collection of submodules.
+
+ * the `.gitmodules` file inside the repository. A project usually includes this
+   file to suggest defaults for the upstream collection of repositories.
+
 COMMANDS
 --------
 add::
-- 
2.8.0.rc4.10.geb92688.dirty
