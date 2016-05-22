From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/6] nd/worktree-cleanup-post-head-protection update
Date: Sun, 22 May 2016 16:33:50 +0700
Message-ID: <20160522093356.22389-1-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 11:34:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4PmK-0001EA-EH
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 11:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbcEVJe2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 05:34:28 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34485 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbcEVJe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 05:34:26 -0400
Received: by mail-pa0-f68.google.com with SMTP id yl2so15029466pac.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CRePu8lR8bsjKbjnbjidzoXhRJ3ETHQOKq6BfZAuw8=;
        b=bfsqUk0soUGaTkxW6chwDHkyC4QYXKGv7kKP+dMFPpQdv5PVJcLAtlQesg1lXuJj1P
         G2YZO1prGKPHi9katwamSZ1rRkd6wXbcUcGY1t7iqMl1Tu0g83B4yuHARG4zpOrrE40X
         EfviEpmeymXdOFMj0A66JLNLMtbBMa61wnPRIiiR7qPXXJ5R5NvNtYxN8FH7k7pVMxnJ
         75KC9fyhdJ5UlzANR9LoYNA9uihovhnzHW/5QYuWWhAfvP3lKJBAHq99NPovdM+GKwBP
         qlGfs0RRZK1RZoKEOKYkbx9BjT6oQVeW14kthKnahCyZH/Ng061KCprSdndYVMGTnFwd
         ef6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CRePu8lR8bsjKbjnbjidzoXhRJ3ETHQOKq6BfZAuw8=;
        b=SN4c9QG0Dpv9gpyo5O84kTaLT8CBIsXM2ZndhxBa0BNvaYYv+Y3of6en1+FZJhHhrf
         d+HyOs2Efqs18ZPMrCiJYWYsCY7AfKs53NnwVXq/SINXXDQLY+h0vPaPlPU980V8tCxu
         DbQRDjK/JsNhD8JefF9Y8UQ2DQO9FcX3oHbi1xbUfEagN9yS1sp+XKjck1krgyYPMzJn
         V/PuYOcvwcmya49F4pCWNYuDv62OaYUfbxSMJGZFAR14YabRGuXVZo4E4QLA6xXgU7VR
         FAeSymuAHGs4ZhzLGZR9AVwvbcFe3Ole61PV0heaLZLRBLdu7HTaBZZZbhrp38buu3su
         cxjA==
X-Gm-Message-State: AOPr4FXEekxYMpuYwb9ceRARpA+Q4mXGBIzXVwGINyDkgYtq4oqkQaZzit3PBXyPqG24Mw==
X-Received: by 10.66.160.133 with SMTP id xk5mr18528083pab.71.1463909665251;
        Sun, 22 May 2016 02:34:25 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id m64sm15886650pfc.19.2016.05.22.02.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 02:34:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 16:34:19 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141416.GA22672@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295260>

This is mostly commit message update plus

 - dropping "--force" from the completion patch (a comment from Szeder
   Gabor in a previous attempt of worktree completion support).
=20
 - the removal of clear_worktree() patch.

I keep the completion patch anyway even though two versions of it were
posted by Eric and Szeder (and didn't get discussed much) because I
needed this for new commands and because I didn't aim high. It's meant
to provide very basic completion support. Fancy stuff like ref
completion can be added later by people who are more experienced in
bash completion stuff.

Anyway, interdiff

-- 8< --
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index d3ac391..951a186 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2604,7 +2604,7 @@ _git_worktree ()
 	else
 		case "$subcommand,$cur" in
 		add,--*)
-			__gitcomp "--detach --force"
+			__gitcomp "--detach"
 			;;
 		list,--*)
 			__gitcomp "--porcelain"
diff --git a/worktree.c b/worktree.c
index 335c58f..f4a4f38 100644
--- a/worktree.c
+++ b/worktree.c
@@ -5,22 +5,14 @@
 #include "dir.h"
 #include "wt-status.h"
=20
-void clear_worktree(struct worktree *wt)
-{
-	if (!wt)
-		return;
-	free(wt->path);
-	free(wt->id);
-	free(wt->head_ref);
-	memset(wt, 0, sizeof(*wt));
-}
-
 void free_worktrees(struct worktree **worktrees)
 {
 	int i =3D 0;
=20
 	for (i =3D 0; worktrees[i]; i++) {
-		clear_worktree(worktrees[i]);
+		free(worktrees[i]->path);
+		free(worktrees[i]->id);
+		free(worktrees[i]->head_ref);
 		free(worktrees[i]);
 	}
 	free (worktrees);
diff --git a/worktree.h b/worktree.h
index 7430a4e..1394909 100644
--- a/worktree.h
+++ b/worktree.h
@@ -29,11 +29,6 @@ extern struct worktree **get_worktrees(void);
  */
 extern const char *get_worktree_git_dir(const struct worktree *wt);
=20
-/*
- * Free up the memory for worktree
- */
-extern void clear_worktree(struct worktree *);
-
 /*
  * Free up the memory for worktree(s)
  */
-- 8< --

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  completion: support git-worktree
  worktree.c: rewrite mark_current_worktree() to avoid strbuf
  git-worktree.txt: keep subcommand listing in alphabetical order
  worktree.c: use is_dot_or_dotdot()
  worktree: avoid 0{40}, too many zeroes, hard to read
  worktree: simplify prefixing paths

 Documentation/git-worktree.txt         | 10 +++++-----
 builtin/worktree.c                     | 10 ++++++----
 contrib/completion/git-completion.bash | 23 +++++++++++++++++++++++
 worktree.c                             | 18 ++++++++----------
 4 files changed, 42 insertions(+), 19 deletions(-)

--=20
2.8.2.524.g6ff3d78
