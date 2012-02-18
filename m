From: "=?UTF-8?q?Philip=20J=C3=A4genstedt?=" <philip.jagenstedt@gmail.com>
Subject: [PATCH] remote: align set-branches builtin usage and documentation
Date: Sat, 18 Feb 2012 12:17:47 +0100
Message-ID: <1329563867-13283-1-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 12:18:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyiIk-0005nG-Fk
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 12:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab2BRLR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Feb 2012 06:17:57 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:49379 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752438Ab2BRLR4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Feb 2012 06:17:56 -0500
Received: by lagu2 with SMTP id u2so4730120lag.19
        for <git@vger.kernel.org>; Sat, 18 Feb 2012 03:17:55 -0800 (PST)
Received-SPF: pass (google.com: domain of philip.jagenstedt@gmail.com designates 10.112.98.36 as permitted sender) client-ip=10.112.98.36;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip.jagenstedt@gmail.com designates 10.112.98.36 as permitted sender) smtp.mail=philip.jagenstedt@gmail.com; dkim=pass header.i=philip.jagenstedt@gmail.com
Received: from mr.google.com ([10.112.98.36])
        by 10.112.98.36 with SMTP id ef4mr4654350lbb.55.1329563875461 (num_hops = 1);
        Sat, 18 Feb 2012 03:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=lzLp71dwg4dBk1cf+5KEuf4Nhr+q48PdEivXoMo4HHM=;
        b=GX8fkVkzW42AfUC7Qx0IxDmeG37yRADUDTnVVpxIYi6sWvZDH+FF4CCbUHF/K1SPfe
         YKgJ+38yZkvwE0lXsPe6IDMBzgVp5aYX2aU6q0ImFp3fcJbWh+0gzGvyTyuB8qiWwjhU
         cMZcnjQ/B1crGYBUaZfvMWuTwd4eqqSnxXbVk=
Received: by 10.112.98.36 with SMTP id ef4mr3876727lbb.55.1329563875397;
        Sat, 18 Feb 2012 03:17:55 -0800 (PST)
Received: from localhost.localdomain (h128n3-g-hn-a11.ias.bredband.telia.com. [217.209.32.128])
        by mx.google.com with ESMTPS id mc3sm12319351lab.12.2012.02.18.03.17.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Feb 2012 03:17:54 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1.246.g77c8c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191004>

The order of [--add] <name> <branch>... was inconsistent
between builtin remote usage messages and git-remote.txt.
Align it closer to the order used in set-url.

Signed-off-by: Philip J=C3=A4genstedt <philip@foolip.org>
---
 Documentation/git-remote.txt |    2 +-
 builtin/remote.c             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.tx=
t
index 5a8c506..d376d19 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git remote rename' <old> <new>
 'git remote rm' <name>
 'git remote set-head' <name> (-a | -d | <branch>)
-'git remote set-branches' <name> [--add] <branch>...
+'git remote set-branches' [--add] <name> <branch>...
 'git remote set-url' [--push] <name> <newurl> [<oldurl>]
 'git remote set-url --add' [--push] <name> <newurl>
 'git remote set-url --delete' [--push] <name> <url>
diff --git a/builtin/remote.c b/builtin/remote.c
index f54a89a..fec92bc 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,7 +16,7 @@ static const char * const builtin_remote_usage[] =3D =
{
 	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
 	"git remote [-v | --verbose] update [-p | --prune] [(<group> | <remot=
e>)...]",
-	"git remote set-branches <name> [--add] <branch>...",
+	"git remote set-branches [--add] <name> <branch>...",
 	"git remote set-url <name> <newurl> [<oldurl>]",
 	"git remote set-url --add <name> <newurl>",
 	"git remote set-url --delete <name> <url>",
--=20
1.7.9.1.246.g77c8c.dirty
