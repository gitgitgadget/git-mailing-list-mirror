From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/14] wt-status: Show orphaned entries in "git status" output
Date: Sat, 20 Sep 2008 17:01:53 +0700
Message-ID: <1221904913-25887-15-git-send-email-pclouds@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <1221904913-25887-3-git-send-email-pclouds@gmail.com>
 <1221904913-25887-4-git-send-email-pclouds@gmail.com>
 <1221904913-25887-5-git-send-email-pclouds@gmail.com>
 <1221904913-25887-6-git-send-email-pclouds@gmail.com>
 <1221904913-25887-7-git-send-email-pclouds@gmail.com>
 <1221904913-25887-8-git-send-email-pclouds@gmail.com>
 <1221904913-25887-9-git-send-email-pclouds@gmail.com>
 <1221904913-25887-10-git-send-email-pclouds@gmail.com>
 <1221904913-25887-11-git-send-email-pclouds@gmail.com>
 <1221904913-25887-12-git-send-email-pclouds@gmail.com>
 <1221904913-25887-13-git-send-email-pclouds@gmail.com>
 <1221904913-25887-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzLb-0001Tk-4q
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbYITKD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbYITKD7
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:03:59 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:21281 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbYITKD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:03:58 -0400
Received: by wf-out-1314.google.com with SMTP id 27so880198wfd.4
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1L+fRkWxug+cILgoO5PzH1iZVhxZJYkLEWWqZouRuV8=;
        b=IGxUr7pEzSNfr42kpJa4Pu0KMIiz+fFm7PWg9Vlv/C40L7kTqZ8ECocaaaVIptxSCz
         p9VsMR0Ylx9NjOX2ztdBrMSJ33XNY1p12y6oiEFgGwgxzchD2ueh358vnO+QK7v7/HpO
         0ZTkgrd5WOrddNPnZACumlmNcawplWnjX4RxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Gf2PMGUrajZywd0JMmWoBNxcQeFidlAdPCt0uZTtcpDvr6yHa4fYy0+3ZwRYnyMUTK
         bPK7v9wnAx8Ucg2LhBJgD8bWfnWDmlre2myV2w0SZLFj7e/cIfQtyeajwydw6Ol3GoF9
         WVhemUvUgemdD/18GEmmvkwVkc/MU5sToyDp0=
Received: by 10.143.42.6 with SMTP id u6mr452931wfj.140.1221905038146;
        Sat, 20 Sep 2008 03:03:58 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 32sm3680052wfa.8.2008.09.20.03.03.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:03:56 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:03:47 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-14-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96352>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c |   39 +++++++++++++++++++++++++++++++++++++++
 wt-status.h |    1 +
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 7cf890f..4c237e2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -20,6 +20,7 @@ static char wt_status_colors[][COLOR_MAXLEN] =3D {
 	"\033[31m", /* WT_STATUS_CHANGED: red */
 	"\033[31m", /* WT_STATUS_UNTRACKED: red */
 	"\033[31m", /* WT_STATUS_NOBRANCH: red */
+	"\033[31m", /* WT_STATUS_ORPHANED: red */
 };
=20
 enum untracked_status_type show_untracked_files =3D SHOW_NORMAL_UNTRAC=
KED_FILES;
@@ -83,6 +84,16 @@ static void wt_status_print_dirty_header(struct wt_s=
tatus *s,
 	color_fprintf_ln(s->fp, c, "#");
 }
=20
+static void wt_status_print_orphaned_header(struct wt_status *s)
+{
+	const char *c =3D color(WT_STATUS_HEADER);
+	color_fprintf_ln(s->fp, c, "# Orphaned files:");
+	color_fprintf_ln(s->fp, c, "#   (these are tracked, but marked no-che=
ckout and should not be present)");
+	color_fprintf_ln(s->fp, c, "#   (use \"git update-index --checkout\" =
to remove no-checkout status)");
+	color_fprintf_ln(s->fp, c, "#   (otherwise remove them to avoid confu=
sion because git will ignore them)");
+	color_fprintf_ln(s->fp, c, "#");
+}
+
 static void wt_status_print_untracked_header(struct wt_status *s)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
@@ -233,6 +244,33 @@ static void wt_status_print_changed(struct wt_stat=
us *s)
 	run_diff_files(&rev, 0);
 }
=20
+static void wt_status_print_orphaned(struct wt_status *s)
+{
+	int i, show_header =3D 0;
+	struct stat st;
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	for (i =3D 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce =3D the_index.cache[i];
+
+		if (ce_checkout(ce) || lstat(ce->name, &st))
+			continue;
+
+		if (!show_header) {
+			wt_status_print_orphaned_header(s);
+			show_header =3D 1;
+		}
+
+		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+		color_fprintf_ln(s->fp, color(WT_STATUS_ORPHANED), "%s",
+				 quote_path(ce->name, -1, &buf, s->prefix));
+	}
+
+	if (show_header)
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),"#");
+}
+
 static void wt_status_print_submodule_summary(struct wt_status *s)
 {
 	struct child_process sm_summary;
@@ -373,6 +411,7 @@ void wt_status_print(struct wt_status *s)
 	}
=20
 	wt_status_print_changed(s);
+	wt_status_print_orphaned(s);
 	if (wt_status_submodule_summary)
 		wt_status_print_submodule_summary(s);
 	if (show_untracked_files)
diff --git a/wt-status.h b/wt-status.h
index 78add09..52f1eb5 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -9,6 +9,7 @@ enum color_wt_status {
 	WT_STATUS_CHANGED,
 	WT_STATUS_UNTRACKED,
 	WT_STATUS_NOBRANCH,
+	WT_STATUS_ORPHANED,
 };
=20
 enum untracked_status_type {
--=20
1.6.0.96.g2fad1.dirty
