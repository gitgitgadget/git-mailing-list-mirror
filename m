From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/10] i18n: mark relative dates for translation
Date: Mon, 23 Apr 2012 19:30:23 +0700
Message-ID: <1335184230-8870-4-git-send-email-pclouds@gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMITP-0005Qi-E0
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab2DWMe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 08:34:26 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55597 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab2DWMe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:34:26 -0400
Received: by pbcun15 with SMTP id un15so3837007pbc.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3m/5IYUmPu55/HErm374+g715l6D22Hv3irByxh1nyU=;
        b=zvgBKChEBM3ryrV3TZjmwADDl2X/Smperca2Z6KoDdCza2IIFRsFGaje9l3QwP/ax6
         q8+FHo/I/34Rszlg17Pj9tFh3mnqpmlg+nIve3TEnYfJa0s2EcNwjnparpNR7jev2sRz
         fcqwldTQlTr0r+cTaudDUhz8hO6ACg0K9CIVx0+JjIwQqtBhApoSAkYB0MEV7KtItMvd
         Z3CEl/QoT3R0zmSLbl60hdny2vpSM7i5Z5YpVh80GpwRV6/72JqFKkZjjQ0Ayo+Wy++m
         zANABGnc9fFS5bANAEwq4C83KXs3v3ob5nd/XPDd9Ofe+ou+sk9QVbsHmH+IE1Nhc80N
         gAcQ==
Received: by 10.68.217.67 with SMTP id ow3mr36660590pbc.16.1335184465666;
        Mon, 23 Apr 2012 05:34:25 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.47])
        by mx.google.com with ESMTPS id gz3sm5687850pbc.3.2012.04.23.05.34.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 05:34:24 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 23 Apr 2012 19:31:08 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196117>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     |    6 +--
 date.c      |   95 ++++++++++++++++++++++++++++++++++-----------------=
-------
 test-date.c |    7 ++--
 3 files changed, 62 insertions(+), 46 deletions(-)

diff --git a/cache.h b/cache.h
index a8aceb5..aa9f8f9 100644
--- a/cache.h
+++ b/cache.h
@@ -906,10 +906,8 @@ enum date_mode {
 };
=20
 const char *show_date(unsigned long time, int timezone, enum date_mode=
 mode);
-const char *show_date_relative(unsigned long time, int tz,
-			       const struct timeval *now,
-			       char *timebuf,
-			       size_t timebuf_size);
+void show_date_relative(unsigned long time, int tz, const struct timev=
al *now,
+			struct strbuf *timebuf);
 int parse_date(const char *date, char *buf, int bufsize);
 int parse_date_basic(const char *date, unsigned long *timestamp, int *=
offset);
 void datestamp(char *buf, int bufsize);
diff --git a/date.c b/date.c
index a5055ca..1fdcf7c 100644
--- a/date.c
+++ b/date.c
@@ -86,83 +86,98 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
=20
-const char *show_date_relative(unsigned long time, int tz,
+void show_date_relative(unsigned long time, int tz,
 			       const struct timeval *now,
-			       char *timebuf,
-			       size_t timebuf_size)
+			       struct strbuf *timebuf)
 {
 	unsigned long diff;
-	if (now->tv_sec < time)
-		return "in the future";
+	if (now->tv_sec < time) {
+		strbuf_addstr(timebuf, _("in the future"));
+		return;
+	}
 	diff =3D now->tv_sec - time;
 	if (diff < 90) {
-		snprintf(timebuf, timebuf_size, "%lu seconds ago", diff);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu second ago", "%lu seconds ago", diff), diff);
+		return;
 	}
 	/* Turn it into minutes */
 	diff =3D (diff + 30) / 60;
 	if (diff < 90) {
-		snprintf(timebuf, timebuf_size, "%lu minutes ago", diff);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu minute ago", "%lu minutes ago", diff), diff);
+		return;
 	}
 	/* Turn it into hours */
 	diff =3D (diff + 30) / 60;
 	if (diff < 36) {
-		snprintf(timebuf, timebuf_size, "%lu hours ago", diff);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu hour ago", "%lu hours ago", diff), diff);
+		return;
 	}
 	/* We deal with number of days from here on */
 	diff =3D (diff + 12) / 24;
 	if (diff < 14) {
-		snprintf(timebuf, timebuf_size, "%lu days ago", diff);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu day ago", "%lu days ago", diff), diff);
+		return;
 	}
 	/* Say weeks for the past 10 weeks or so */
 	if (diff < 70) {
-		snprintf(timebuf, timebuf_size, "%lu weeks ago", (diff + 3) / 7);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu week ago", "%lu weeks ago", (diff + 3) / 7),
+			 (diff + 3) / 7);
+		return;
 	}
 	/* Say months for the past 12 months or so */
 	if (diff < 365) {
-		snprintf(timebuf, timebuf_size, "%lu months ago", (diff + 15) / 30);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu month ago", "%lu months ago", (diff + 15) / 30),
+			 (diff + 15) / 30);
+		return;
 	}
 	/* Give years and months for 5 years or so */
 	if (diff < 1825) {
 		unsigned long totalmonths =3D (diff * 12 * 2 + 365) / (365 * 2);
 		unsigned long years =3D totalmonths / 12;
 		unsigned long months =3D totalmonths % 12;
-		int n;
-		n =3D snprintf(timebuf, timebuf_size, "%lu year%s",
-				years, (years > 1 ? "s" : ""));
-		if (months)
-			snprintf(timebuf + n, timebuf_size - n,
-					", %lu month%s ago",
-					months, (months > 1 ? "s" : ""));
-		else
-			snprintf(timebuf + n, timebuf_size - n, " ago");
-		return timebuf;
+		if (months) {
+			struct strbuf sb =3D STRBUF_INIT;
+			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
+			/* TRANSLATORS: "%s" is "<n> years" */
+			strbuf_addf(timebuf,
+				 Q_("%s, %lu month ago", "%s, %lu months ago", months),
+				 sb.buf, months);
+			strbuf_release(&sb);
+		} else
+			strbuf_addf(timebuf,
+				 Q_("%lu year ago", "%lu years ago", years), years);
+		return;
 	}
 	/* Otherwise, just years. Centuries is probably overkill. */
-	snprintf(timebuf, timebuf_size, "%lu years ago", (diff + 183) / 365);
-	return timebuf;
+	strbuf_addf(timebuf,
+		 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
+		 (diff + 183) / 365);
 }
=20
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
-	static char timebuf[200];
+	static struct strbuf timebuf =3D STRBUF_INIT;
=20
 	if (mode =3D=3D DATE_RAW) {
-		snprintf(timebuf, sizeof(timebuf), "%lu %+05d", time, tz);
-		return timebuf;
+		strbuf_reset(&timebuf);
+		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
+		return timebuf.buf;
 	}
=20
 	if (mode =3D=3D DATE_RELATIVE) {
 		struct timeval now;
+
+		strbuf_reset(&timebuf);
 		gettimeofday(&now, NULL);
-		return show_date_relative(time, tz, &now,
-					  timebuf, sizeof(timebuf));
+		show_date_relative(time, tz, &now, &timebuf);
+		return timebuf.buf;
 	}
=20
 	if (mode =3D=3D DATE_LOCAL)
@@ -171,23 +186,25 @@ const char *show_date(unsigned long time, int tz,=
 enum date_mode mode)
 	tm =3D time_to_tm(time, tz);
 	if (!tm)
 		return NULL;
+
+	strbuf_reset(&timebuf);
 	if (mode =3D=3D DATE_SHORT)
-		sprintf(timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
+		strbuf_addf(&timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
 	else if (mode =3D=3D DATE_ISO8601)
-		sprintf(timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
+		strbuf_addf(&timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
 				tm->tm_year + 1900,
 				tm->tm_mon + 1,
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
 	else if (mode =3D=3D DATE_RFC2822)
-		sprintf(timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
+		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else
-		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
+		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
 				month_names[tm->tm_mon],
 				tm->tm_mday,
@@ -195,7 +212,7 @@ const char *show_date(unsigned long time, int tz, e=
num date_mode mode)
 				tm->tm_year + 1900,
 				(mode =3D=3D DATE_LOCAL) ? 0 : ' ',
 				tz);
-	return timebuf;
+	return timebuf.buf;
 }
=20
 /*
diff --git a/test-date.c b/test-date.c
index 6bcd5b0..10afaab 100644
--- a/test-date.c
+++ b/test-date.c
@@ -7,13 +7,14 @@ static const char *usage_msg =3D "\n"
=20
 static void show_dates(char **argv, struct timeval *now)
 {
-	char buf[128];
+	struct strbuf buf =3D STRBUF_INIT;
=20
 	for (; *argv; argv++) {
 		time_t t =3D atoi(*argv);
-		show_date_relative(t, 0, now, buf, sizeof(buf));
-		printf("%s -> %s\n", *argv, buf);
+		show_date_relative(t, 0, now, &buf);
+		printf("%s -> %s\n", *argv, buf.buf);
 	}
+	strbuf_release(&buf);
 }
=20
 static void parse_dates(char **argv, struct timeval *now)
--=20
1.7.8.36.g69ee2
