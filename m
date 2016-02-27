From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/22] convert.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:41:59 +0700
Message-ID: <1456555333-5853-9-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:42:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYag-0003Ev-37
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035AbcB0Gmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:42:54 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36732 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbcB0Gmx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:42:53 -0500
Received: by mail-pf0-f179.google.com with SMTP id e127so64364675pfe.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1dsRzCUFBR3Z1giWgOGUjIqcDXMs2lh9Tn5imPwMns=;
        b=fOLhzHv6ykdCOCNOu17gDnBIeNBAP2AlREkadvXupzASTSolYbUVI1sZXtPg8+Xs0H
         v8zSDJ8xEXVdzn6dn8omMcLlj+kVovx+XtVcSYCSmtMZI4CLSoLy+5+2ROMiEBJNWoJS
         YjfTeMMvZfvt4s/XZZwJ2V/3Lyg5E5nskDgdmnKHAes9zddXw5BwtFc40uWy7XPcE8yb
         fxHqkY42APEPQdfYpWIVblsjsjNLghllEF5hbw+T/TT54E27eXCukwwHf+lVJXZI9+/C
         wJeM+15fMBMh2Q4NMk4NHRYhgLR7xRDtjyxSFISGPe/4P72fhk2jyAOtd64oq/Td3AoR
         mnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1dsRzCUFBR3Z1giWgOGUjIqcDXMs2lh9Tn5imPwMns=;
        b=LIXVj1pAq1xRgZCvAdeqeIxd0p4po6CjszkM3OXZVOz4MBPAAKl5yhE+Nunky923Ib
         Mv7ywEso1XZEulVR1fe4j3vKa8gsZ+VhWvxrcPgtQ+fAgY7pPiJ56whohHA1kY4UgLwz
         U1z+07wC1rRn+9STjubE1rvO6QGuAwwYbWA6pW+iwPQdKHLywE2L+0L628ogDAtdasYx
         /gBdD01whUezY3SblKaknRszpjLSywjHx8vbixkVkW7LNEzZC7bvXNORXvlXw2HiytfR
         Kij1VnrGe7SiKHNVs3FXIOPZoKlG+DgOBUvwrvXk0bWs5q5XR6VlX1qNVbLrSpT/ZaZX
         6dNQ==
X-Gm-Message-State: AD7BkJI85bKM+arDAq/bl9B3IVYDucdOSALIbYngLatIrTvFwnF/xTUNRIfyg5zyXvpvyQ==
X-Received: by 10.98.17.75 with SMTP id z72mr7614798pfi.16.1456555372799;
        Fri, 26 Feb 2016 22:42:52 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id r77sm23482101pfa.47.2016.02.26.22.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:42:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:43:25 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287669>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 convert.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/convert.c b/convert.c
index f524b8d..59d03b0 100644
--- a/convert.c
+++ b/convert.c
@@ -199,9 +199,11 @@ static void check_safe_crlf(const char *path, enum=
 crlf_action crlf_action,
 		 */
 		if (stats->crlf) {
 			if (checksafe =3D=3D SAFE_CRLF_WARN)
-				warning("CRLF will be replaced by LF in %s.\nThe file will have it=
s original line endings in your working directory.", path);
+				warning(_("CRLF will be replaced by LF in %s.\n"
+					  "The file will have its original line "
+					  "endings in your working directory."), path);
 			else /* i.e. SAFE_CRLF_FAIL */
-				die("CRLF would be replaced by LF in %s.", path);
+				die(_("CRLF would be replaced by LF in %s."), path);
 		}
 	} else if (output_eol(crlf_action) =3D=3D EOL_CRLF) {
 		/*
@@ -210,9 +212,11 @@ static void check_safe_crlf(const char *path, enum=
 crlf_action crlf_action,
 		 */
 		if (stats->lonelf) {
 			if (checksafe =3D=3D SAFE_CRLF_WARN)
-				warning("LF will be replaced by CRLF in %s.\nThe file will have it=
s original line endings in your working directory.", path);
+				warning(_("LF will be replaced by CRLF in %s.\n"
+					  "The file will have its original line "
+					  "endings in your working directory."), path);
 			else /* i.e. SAFE_CRLF_FAIL */
-				die("LF would be replaced by CRLF in %s", path);
+				die(_("LF would be replaced by CRLF in %s"), path);
 		}
 	}
 }
@@ -397,7 +401,7 @@ static int filter_buffer_or_fd(int in, int out, voi=
d *data)
 	child_process.out =3D out;
=20
 	if (start_command(&child_process))
-		return error("cannot fork to run external filter %s", params->cmd);
+		return error(_("cannot fork to run external filter %s"), params->cmd=
);
=20
 	sigchain_push(SIGPIPE, SIG_IGN);
=20
@@ -415,13 +419,13 @@ static int filter_buffer_or_fd(int in, int out, v=
oid *data)
 	if (close(child_process.in))
 		write_err =3D 1;
 	if (write_err)
-		error("cannot feed the input to external filter %s", params->cmd);
+		error(_("cannot feed the input to external filter %s"), params->cmd)=
;
=20
 	sigchain_pop(SIGPIPE);
=20
 	status =3D finish_command(&child_process);
 	if (status)
-		error("external filter %s failed %d", params->cmd, status);
+		error(_("external filter %s failed %d"), params->cmd, status);
=20
 	strbuf_release(&cmd);
 	return (write_err || status);
@@ -462,15 +466,15 @@ static int apply_filter(const char *path, const c=
har *src, size_t len, int fd,
 		return 0;	/* error was already reported */
=20
 	if (strbuf_read(&nbuf, async.out, len) < 0) {
-		error("read from external filter %s failed", cmd);
+		error(_("read from external filter %s failed"), cmd);
 		ret =3D 0;
 	}
 	if (close(async.out)) {
-		error("read from external filter %s failed", cmd);
+		error(_("read from external filter %s failed"), cmd);
 		ret =3D 0;
 	}
 	if (finish_async(&async)) {
-		error("external filter %s failed", cmd);
+		error(_("external filter %s failed"), cmd);
 		ret =3D 0;
 	}
=20
@@ -868,7 +872,7 @@ int convert_to_git(const char *path, const char *sr=
c, size_t len,
=20
 	ret |=3D apply_filter(path, src, len, -1, dst, filter);
 	if (!ret && required)
-		die("%s: clean filter '%s' failed", path, ca.drv->name);
+		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
=20
 	if (ret && dst) {
 		src =3D dst->buf;
@@ -892,7 +896,7 @@ void convert_to_git_filter_fd(const char *path, int=
 fd, struct strbuf *dst,
 	assert(ca.drv->clean);
=20
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
-		die("%s: clean filter '%s' failed", path, ca.drv->name);
+		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
=20
 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe)=
;
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
@@ -932,7 +936,7 @@ static int convert_to_working_tree_internal(const c=
har *path, const char *src,
=20
 	ret_filter =3D apply_filter(path, src, len, -1, dst, filter);
 	if (!ret_filter && required)
-		die("%s: smudge filter %s failed", path, ca.drv->name);
+		die(_("%s: smudge filter %s failed"), path, ca.drv->name);
=20
 	return ret | ret_filter;
 }
--=20
2.8.0.rc0.205.g7ec8cf1
