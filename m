From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/25] worktree move: accept destination as directory
Date: Wed, 13 Apr 2016 20:15:45 +0700
Message-ID: <1460553346-12985-25-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:18:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKgK-00053k-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758288AbcDMNSB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:18:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35348 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758359AbcDMNSA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:18:00 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so4129728pfr.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8h451k9iMkee9+2r0/eXohJBRzOYsFIkACOXcFIcek=;
        b=Wg6q++bCQr99g2X4nkscByi7tm9bo/b1cD1pOvs0gRY6ghLKDy3sTS0y2woNFgzp0o
         3LXBiIJculboq5CHXEVMc1OVKR9OUy4WEcbSH8ocjP/GLbWVUtrLfnTUvn4luSmJUynZ
         X6tp3i6IU3VnAeNvq3VeCteKckIk5ilIXIB/XPkpnP0D7gjxHQfLI788/C0oxa23RzPQ
         HzFkuKfNvb67dAdDvAqsqlB+1TL5Njj5Vngygi5Asjcw0YUZUJ+mM8ZvGUEUl+4sHyMX
         CIuGDyKFYp0OTNJ9bTTCnaudKn7LIe57ueeyP0QKiXTaqVAccg98YydMQCBZRJKPXWJA
         SwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8h451k9iMkee9+2r0/eXohJBRzOYsFIkACOXcFIcek=;
        b=SeALIZzoBACqFLi1W0WCvIuGQv8AeLxyWF2iwPgmdtiW/8Wk92TMtFIx/B4Hz7TkKj
         nq3RZyvNEKFPKLhmpxe29LOyXdCgT6TYqAjfeMe4hzA37nzPIRqh6EYekozviTLZqKGE
         zpGxUd7ZP40cF13Itx1vlSxIycdBmB/xCYN1Skoe9wM5SLD2+7ln6UWw4WfraVXm2Mko
         1T+mEwG+wlD6w096O/GDJEGjoRzwuP4HJmjMJbodk9pabiBdktZdoRgLeadYYFKHUNWx
         abhvucxE38chJbaGs5rF5ON7It7mIql9mCQCbeqMsxBYRMZUN3Fnm++hv2pWrCcRK2eI
         U5LQ==
X-Gm-Message-State: AOPr4FUyHO0oE+RXYC80ysRuuDbYOFpJHIKfT/kgBcNnDEAJNpiHTrUe5hMpLnRRELikDw==
X-Received: by 10.98.10.74 with SMTP id s71mr12894371pfi.86.1460553479756;
        Wed, 13 Apr 2016 06:17:59 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id m89sm51200438pfi.12.2016.04.13.06.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:17:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:18:05 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291445>

Similar to "mv a b/", which is actually "mv a b/a", we extract basename
of source worktree and create a directory of the same name at
destination if dst path is a directory.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index a988913..5402a4e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -538,7 +538,13 @@ static int move_worktree(int ac, const char **av, =
const char *prefix)
 	strbuf_addstr(&dst, prefix_filename(prefix,
 					    strlen(prefix),
 					    av[1]));
-	if (file_exists(dst.buf))
+	if (is_directory(dst.buf))
+		/*
+		 * keep going, dst will be appended after we get the
+		 * source's absolute path
+		 */
+		;
+	else if (file_exists(dst.buf))
 		die(_("target '%s' already exists"), av[1]);
=20
 	worktrees =3D get_worktrees();
@@ -558,6 +564,17 @@ static int move_worktree(int ac, const char **av, =
const char *prefix)
 	if (validate_worktree(wt, 0))
 		return -1;
=20
+	if (is_directory(dst.buf)) {
+		const char *sep =3D strrchr(wt->path, '/');
+
+		if (!sep)
+			die(_("could not figure out destination name from '%s'"),
+			    wt->path);
+		strbuf_addstr(&dst, sep);
+		if (file_exists(dst.buf))
+			die(_("target '%s' already exists"), dst.buf);
+	}
+
 	/*
 	 * First try. Atomically move, and probably cheaper, if both
 	 * source and target are on the same file system.
--=20
2.8.0.rc0.210.gd302cd2
