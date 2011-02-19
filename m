From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 59/72] gettextize: git-archive basic messages
Date: Sat, 19 Feb 2011 19:24:42 +0000
Message-ID: <1298143495-3681-60-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUa-0003dU-N3
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334Ab1BST3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:12 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:32957 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab1BST2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:17 -0500
Received: by eye27 with SMTP id 27so2347251eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=iqbxuuzRkHHMU3OeW/48yiVflh/ruRGUuVPLDy8snik=;
        b=B3DIrVa7WEj3ia/Wl2qurmvW9do6TCsMYK38xUf5mU8DlwwX2c8auwQyC/5tPrJDhR
         VXJgA4HnLhTij+0OlARuaYj7836Neh7XkcX74K4xH/rk1JmXxgOl/R9ijuEmBuke/Ztj
         FQWk5WrKybmO3qzwRHk30GgXcCKdrxFyvL2D8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=n5aM0ZQb6dcJaKVPxtoNJJieshdfxcw0WIjZtceDDUv6WxzHFoc29BLkt1HJKbAtPS
         mnAZtJQh+1rflPBCJklq3rxWrHIcwNaO/Hx+GKyZq6DPEBL+OkZ+Ml7Q/5zR6Qt8+S7o
         56nqAL2iZfTA/gQE1yaNJcgifDL9Ys6z80zLE=
Received: by 10.213.3.20 with SMTP id 20mr2579876ebl.5.1298143696251;
        Sat, 19 Feb 2011 11:28:16 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.15
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:15 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167360>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/archive.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 6a887f5..b14eaba 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -14,10 +14,10 @@ static void create_output_file(const char *output_f=
ile)
 {
 	int output_fd =3D open(output_file, O_CREAT | O_WRONLY | O_TRUNC, 066=
6);
 	if (output_fd < 0)
-		die_errno("could not create archive file '%s'", output_file);
+		die_errno(_("could not create archive file '%s'"), output_file);
 	if (output_fd !=3D 1) {
 		if (dup2(output_fd, 1) < 0)
-			die_errno("could not redirect output");
+			die_errno(_("could not redirect output"));
 		else
 			close(output_fd);
 	}
@@ -33,7 +33,7 @@ static int run_remote_archiver(int argc, const char *=
*argv,
=20
 	_remote =3D remote_get(remote);
 	if (!_remote->url[0])
-		die("git archive: Remote with no URL");
+		die(_("git archive: Remote with no URL"));
 	transport =3D transport_get(_remote, _remote->url[0]);
 	transport_connect(transport, "git-upload-archive", exec, fd);
=20
@@ -43,18 +43,18 @@ static int run_remote_archiver(int argc, const char=
 **argv,
=20
 	len =3D packet_read_line(fd[0], buf, sizeof(buf));
 	if (!len)
-		die("git archive: expected ACK/NAK, got EOF");
+		die(_("git archive: expected ACK/NAK, got EOF"));
 	if (buf[len-1] =3D=3D '\n')
 		buf[--len] =3D 0;
 	if (strcmp(buf, "ACK")) {
 		if (len > 5 && !prefixcmp(buf, "NACK "))
-			die("git archive: NACK %s", buf + 5);
-		die("git archive: protocol error");
+			die(_("git archive: NACK %s"), buf + 5);
+		die(_("git archive: protocol error"));
 	}
=20
 	len =3D packet_read_line(fd[0], buf, sizeof(buf));
 	if (len)
-		die("git archive: expected a flush");
+		die(_("git archive: expected a flush"));
=20
 	/* Now, start reading from fd[0] and spit it out to stdout */
 	rv =3D recv_sideband("archive", fd[0], 1);
--=20
1.7.2.3
