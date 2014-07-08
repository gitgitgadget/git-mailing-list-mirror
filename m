From: Michal Nazarewicz <mina86@mina86.com>
Subject: [PATCH] path: for clarity, rename get_pathname to get_path_buffer
Date: Tue, 08 Jul 2014 14:35:13 +0200
Organization: Google Inc
Message-ID: <xa1ta98k58qm.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 14:35:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4UcX-0004he-1L
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 14:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbaGHMfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 08:35:36 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38159 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266AbaGHMfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 08:35:18 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so903006wib.8
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:organization:user-agent:face:date
         :message-id:mime-version:content-type;
        bh=rAJBnOwKgCxOChiBXxQw7cSsXXwlNo92CQ2zTsNd3Zg=;
        b=RH6kfia5ymncRmEIrNQkzTKOuMzOu3bLFBHW59CuuwN2CVZbex4adOpNfv7rBsKAW1
         vjL+0CsufFnwgnIeMtt7j/8quSZmFnqMZjOokYYMEUit8hW7mnamubxp4tpbmDdW0hA+
         T6mxbHNFimdJyXW5JTyzWpvBFUtcgaMCP6nEtVsHctOXYPxLn73EneJ4bGcvm9P1sbiU
         JAEHQHhfPIqjeWOAL29tXJHuIhhN0d8LT/EIAFw7n4gU5w43Mmt9wfJAByJTv2ORaGl+
         gEESb/yqmsyim6vzBbeKL+MoakC1BoUYSU/vvUmy+dqDtJOHdBnKu5WJ/vUfxXTFNWHF
         e2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:organization
         :user-agent:face:date:message-id:mime-version:content-type;
        bh=rAJBnOwKgCxOChiBXxQw7cSsXXwlNo92CQ2zTsNd3Zg=;
        b=llt4PHNGGzYp6p+VMvK9oDlqUjJFLnIA/+UQBkr/5ReIAIlrujCv5rYde/M1OW3dcu
         1VG37H19O8I39MtkKTDfoJT9Z7emryJgWD4EBPXyWu8sDts2IsKOjTfbqox5GsZvZWT8
         twnHgAVYFigAOkWCP4v+lb8fsEZOuVJU06lvxNyJrWYvUN2X5I/ZrJcR/gVD2iAbPxhi
         QqVA9UqKXc0Go/6UVWKR1KSvhgXGaXIagSjTxKKzy6LXPN+EBIQYDnSTx5imts6HcpSf
         kgCmi7gcAQweDQ/abz6mMLzb5cXTdb2K45EVKTtcgu0byKbRZfRQmfHkSyxfu9PDMyly
         xt9A==
X-Gm-Message-State: ALoCoQkdD1zBYpj3Do5nWDgUM8NVtl7leDNxyvevUibeCK+9pkAMivASrmvNbmrOKJwlA9I6/+cX
X-Received: by 10.180.103.228 with SMTP id fz4mr3635050wib.4.1404822915861;
        Tue, 08 Jul 2014 05:35:15 -0700 (PDT)
Received: from mpn-glaptop.roam.corp.google.com ([2620:0:105f:311:5ce1:b7a9:45ae:3b51])
        by mx.google.com with ESMTPSA id jb16sm6633005wic.10.2014.07.08.05.35.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Jul 2014 05:35:15 -0700 (PDT)
User-Agent: Notmuch/0.17+15~gb65ca8e (http://notmuchmail.org) Emacs/24.4.50.1 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253019>

The get_pathname function does not really return path name but rather
a buffer to store pathname in.  As such, current name is a bit
confusing.  Change the name as to make it clearer what the function is
doing.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 path.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/path.c b/path.c
index bc804a3..70e2f85 100644
--- a/path.c
+++ b/path.c
@@ -16,7 +16,7 @@ static int get_st_mode_bits(const char *path, int *mode)
 
 static char bad_path[] = "/bad-path/";
 
-static char *get_pathname(void)
+static char *get_path_buffer(void)
 {
 	static char pathname_array[4][PATH_MAX];
 	static int index;
@@ -108,7 +108,7 @@ char *mkpath(const char *fmt, ...)
 {
 	va_list args;
 	unsigned len;
-	char *pathname = get_pathname();
+	char *pathname = get_path_buffer();
 
 	va_start(args, fmt);
 	len = vsnprintf(pathname, PATH_MAX, fmt, args);
@@ -120,7 +120,7 @@ char *mkpath(const char *fmt, ...)
 
 char *git_path(const char *fmt, ...)
 {
-	char *pathname = get_pathname();
+	char *pathname = get_path_buffer();
 	va_list args;
 	char *ret;
 
@@ -158,7 +158,7 @@ void home_config_paths(char **global, char **xdg, char *file)
 
 char *git_path_submodule(const char *path, const char *fmt, ...)
 {
-	char *pathname = get_pathname();
+	char *pathname = get_path_buffer();
 	struct strbuf buf = STRBUF_INIT;
 	const char *git_dir;
 	va_list args;
-- 
2.0.0.526.g5318336
