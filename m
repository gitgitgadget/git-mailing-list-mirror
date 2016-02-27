From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/22] ident.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:42:02 +0700
Message-ID: <1456555333-5853-12-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:43:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYb0-0003R6-E9
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066AbcB0GnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:43:14 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34542 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbcB0GnN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:43:13 -0500
Received: by mail-pf0-f172.google.com with SMTP id x65so63889580pfb.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBoopEaEvcNp+VIRQw3wG2Nk2lB1GU0juuknVBfkOdc=;
        b=RkBLJF5rzupUOtI2f+w9sL+ApGnUNXSOIzLsGLvyphlI0xOz8TErGnzAL5tMxONmSl
         5/yn9bq634/ACy/zTeXSnnTZBwJEt74AHbrqJ0oU1dP2m4KvCFThlJNTwxuSrxp7cDbg
         uczJ8m2FORDGpq76X0Hor7VG+6n1EbuKP+GY0YOcdjHh1paei5KfH4hxOs58yRfxz+Ah
         m2MQ5F3upuLgi9rbpvqge0aYrjkDWnrcHtRpjG/r9cVG/zdWAaEJlBfiVSucn/4kFG57
         dYHOTzPy+7cCAau+WVkA7JZhVJUodEyxIqPfreVENywM6hM0MsUkRY2JiZIstuB0icM3
         2+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBoopEaEvcNp+VIRQw3wG2Nk2lB1GU0juuknVBfkOdc=;
        b=UGhXTuQbfElTxmjhAprKJzfwdmlGZpIpl7E0Akmj7e6oj64Y80XX9RV4bb2d+fVCtK
         UIeKiEPy4gXrI1DqrYjtTRk8BH8o19eQ62qiyQIrqQvURwUUVvOm2FUoMaWJK+mHMoRK
         vnk/Rdk35tpIxM9uJkOfxiKVVwEtzFY17OLovaEqlcdsEs3LsBy/os+yhTkjCo5cURBE
         OLKHlJP49oW2J/6qE6hcfYROfeNoZjQr3+5caIBP0yXqWqE/tLAhpTRRyAZbWTbReUtg
         yfZS5ZLgx3j7gr+T0FKXHvOezbbKkuYrZhcEieGKUWKlrFXATDDKwCHJ+MeHMc5xykR4
         LPoQ==
X-Gm-Message-State: AD7BkJLHGqRoPq8XBPutyAYduqoYfq7GraH79RNKaVNdOULnLiW3GcEOFfrLC/FDWWlYpA==
X-Received: by 10.98.89.200 with SMTP id k69mr6374449pfj.56.1456555392221;
        Fri, 26 Feb 2016 22:43:12 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 81sm6690362pfa.12.2016.02.26.22.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:43:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:43:45 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287672>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ident.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/ident.c b/ident.c
index 6e12582..367a5dc 100644
--- a/ident.c
+++ b/ident.c
@@ -75,13 +75,13 @@ static int add_mailname_host(struct strbuf *buf)
 	mailname =3D fopen("/etc/mailname", "r");
 	if (!mailname) {
 		if (errno !=3D ENOENT)
-			warning("cannot open /etc/mailname: %s",
+			warning(_("cannot open /etc/mailname: %s"),
 				strerror(errno));
 		return -1;
 	}
 	if (strbuf_getline(&mailnamebuf, mailname) =3D=3D EOF) {
 		if (ferror(mailname))
-			warning("cannot read /etc/mailname: %s",
+			warning(_("cannot read /etc/mailname: %s"),
 				strerror(errno));
 		strbuf_release(&mailnamebuf);
 		fclose(mailname);
@@ -125,7 +125,7 @@ static void add_domainname(struct strbuf *out, int =
*is_bogus)
 	char buf[1024];
=20
 	if (gethostname(buf, sizeof(buf))) {
-		warning("cannot get host name: %s", strerror(errno));
+		warning(_("cannot get host name: %s"), strerror(errno));
 		strbuf_addstr(out, "(none)");
 		*is_bogus =3D 1;
 		return;
@@ -355,18 +355,18 @@ const char *fmt_ident(const char *name, const cha=
r *email,
 			using_default =3D 1;
 			if (strict && default_name_is_bogus) {
 				fputs(env_hint, stderr);
-				die("unable to auto-detect name (got '%s')", name);
+				die(_("unable to auto-detect name (got '%s')"), name);
 			}
 			if (strict && ident_use_config_only
 			    && !(ident_config_given & IDENT_NAME_GIVEN))
-				die("user.useConfigOnly set but no name given");
+				die(_("user.useConfigOnly set but no name given"));
 		}
 		if (!*name) {
 			struct passwd *pw;
 			if (strict) {
 				if (using_default)
 					fputs(env_hint, stderr);
-				die("empty ident name (for <%s>) not allowed", email);
+				die(_("empty ident name (for <%s>) not allowed"), email);
 			}
 			pw =3D xgetpwuid_self(NULL);
 			name =3D pw->pw_name;
@@ -377,11 +377,11 @@ const char *fmt_ident(const char *name, const cha=
r *email,
 		email =3D ident_default_email();
 		if (strict && default_email_is_bogus) {
 			fputs(env_hint, stderr);
-			die("unable to auto-detect email address (got '%s')", email);
+			die(_("unable to auto-detect email address (got '%s')"), email);
 		}
 		if (strict && ident_use_config_only
 		    && !(ident_config_given & IDENT_MAIL_GIVEN))
-			die("user.useConfigOnly set but no mail given");
+			die(_("user.useConfigOnly set but no mail given"));
 	}
=20
 	strbuf_reset(&ident);
@@ -396,7 +396,7 @@ const char *fmt_ident(const char *name, const char =
*email,
 		strbuf_addch(&ident, ' ');
 		if (date_str && date_str[0]) {
 			if (parse_date(date_str, &ident) < 0)
-				die("invalid date format: %s", date_str);
+				die(_("invalid date format: %s"), date_str);
 		}
 		else
 			strbuf_addstr(&ident, ident_default_date());
--=20
2.8.0.rc0.205.g7ec8cf1
