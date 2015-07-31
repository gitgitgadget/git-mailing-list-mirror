From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] add: remove dead code
Date: Thu, 30 Jul 2015 17:19:16 -0700
Message-ID: <1438301956-1658-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 31 02:19:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKy2w-0008Pu-5T
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 02:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbbGaATZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 20:19:25 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36395 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbbGaATU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 20:19:20 -0400
Received: by pachj5 with SMTP id hj5so30928132pac.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 17:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=crZL3JVfPf+6nv0ttTLgDXBDipTjv2mpv3SpMe6LaSA=;
        b=eAimEiD8t57vhsMemUC93LL0j+Hmzt7sgaV9yZOqtguZ9mP6FpVmI+UKHX+74ZbWsD
         nnkRBxwiebZnGx46+Cz3gNpcE0GHtTjyIFDB4rWFrmqVliZSb6yRg1G8xeYqb7Bsa0fz
         36ozJQt9jLdKfRBYdoWiZGesnwn/AA2ZbD+FcRjeM2yU4XWNsIWV+343rFSurwEwpCNZ
         zOnGEjXlO1Aa2gIism4IgQ4/DKjKlg8zqrRaqwbT7JRMMooF1h5dc7JeH2QCeW1uqhfI
         jUiRPv6Dhi06DxRQL87bd4L8F7jpr6an6r0WXe10ZFWfwrUD04qVTVvNqE7TjRhKv96m
         mr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=crZL3JVfPf+6nv0ttTLgDXBDipTjv2mpv3SpMe6LaSA=;
        b=LrT0bjam6qi4qfxHI7oH1X+OUulYIV/KtAVjnxPGjtKhKXeDnZ38CGJiR5yl716VQU
         OxIbrJdvLdNsL40V8XSdIUbhN0ayEK/iTneF/28LotWnmWpz7mCHGvOG4khPRrc/sjjN
         wo+pcb/6NyFe5uMR5E/t25AdXpoVOTHXeg2ruWh8LI3kTg+Vbpc/JkzzqYyTD4NDdeyn
         SVHkrKb920xJ9TxlKMiKlg69KOWJE+lHtr3mm9J6XiQUZNUcp+HDeU64nDJtWZe/it0W
         wojYbdIFYU3MDvFt4CbBuKiYcl2lbdt21tu6kwig9nbf75x0njs18LDKnOF5+c6ryYgM
         ibGg==
X-Gm-Message-State: ALoCoQnZnCIfKahiUXIAXlIMdUhNSXYrMd9Lrxc5tMimOgNitkQGCZnQrHKC8Xlei4dBvXGKQ2Hd
X-Received: by 10.66.102.41 with SMTP id fl9mr111636668pab.93.1438301960165;
        Thu, 30 Jul 2015 17:19:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bc55:9e9b:68d0:8e2d])
        by smtp.gmail.com with ESMTPSA id rh11sm4197334pdb.22.2015.07.30.17.19.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jul 2015 17:19:19 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.391.g15b60ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275032>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

So I was trying to understand how to implement "git add .gitmodules" as 
I intend to rewrite git submodules in C.

 builtin/add.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 4bd98b7..b2a5c57 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -375,7 +375,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (add_new_files) {
 		int baselen;
-		struct pathspec empty_pathspec;
 
 		/* Set up the default git porcelain excludes */
 		memset(&dir, 0, sizeof(dir));
@@ -384,7 +383,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			setup_standard_excludes(&dir);
 		}
 
-		memset(&empty_pathspec, 0, sizeof(empty_pathspec));
 		/* This picks up the paths that are not tracked */
 		baselen = fill_directory(&dir, &pathspec);
 		if (pathspec.nr)
-- 
2.5.0.rc1.391.g15b60ce
