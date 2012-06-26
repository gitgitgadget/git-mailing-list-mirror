From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20i18n=3A=20mark=20outputs=20of=20mode=20changes=20for=20i18n?=
Date: Tue, 26 Jun 2012 20:21:50 +0200
Message-ID: <1340734910-7180-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 26 20:22:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjaOr-0004uS-ER
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 20:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758809Ab2FZSWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 14:22:00 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57323 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758703Ab2FZSV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 14:21:58 -0400
Received: by bkcji2 with SMTP id ji2so234978bkc.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=gIG2mAvBQW8q5HYlPOTIpIarpq/wxdWlrSaIFD6r9AU=;
        b=1F/GfO0FRwxZ5EU1eIRBqYN0DTjb81GydUuA6IBRX9vKnHtzn2H8amDPz/vgsu/Wx6
         KuLynnB9gHwcbok94Tynebx0oaa7e9TtYE5fnBDXpZ4mVCwkGGgYXNB7Q1hg27RbpvI3
         XmfkQ1xp198leEhIshuk7MdT64kbY5eR+6tGZ1Ox72CmoLvlJ0d2brioc2glhX6Q2q7+
         HmAS7LtkMFTY9QExByz9stI4eAy4yAAmM3ZioK2vfQJmllAJDXJE0ngqsbuzApVkxpsO
         Nv9wR36Nt90Jdi124y/Ad7HInJuU6JG/7G579lo2P8NOlQF6fuIDwAjDl9fg/MXWCRPI
         SPSw==
Received: by 10.205.33.136 with SMTP id so8mr5690522bkb.1.1340734916744;
        Tue, 26 Jun 2012 11:21:56 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ig1sm51839006bkc.4.2012.06.26.11.21.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jun 2012 11:21:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200665>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 combine-diff.c |  2 +-
 diff.c         | 10 +++++-----
 2 Dateien ge=C3=A4ndert, 6 Zeilen hinzugef=C3=BCgt(+), 6 Zeilen entfer=
nt(-)

diff --git a/combine-diff.c b/combine-diff.c
index 9786680..bf534e4 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -734,7 +734,7 @@ static void show_combined_header(struct combine_dif=
f_path *elem,
 			    DIFF_STATUS_ADDED)
 				added =3D 0;
 		if (added)
-			printf("%snew file mode %06o",
+			printf(_("%snew file mode %06o"),
 			       c_meta, elem->mode);
 		else {
 			if (deleted)
diff --git a/diff.c b/diff.c
index 1a594df..25fcb6f 100644
--- a/diff.c
+++ b/diff.c
@@ -2264,21 +2264,21 @@ static void builtin_diff(const char *name_a,
 	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, set, a_=
one, b_two, reset);
 	if (lbl[0][0] =3D=3D '/') {
 		/* /dev/null */
-		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, set,=
 two->mode, reset);
+		strbuf_addf(&header, "%s%s%s %06o%s\n", line_prefix, set, _("new fil=
e mode"), two->mode, reset);
 		if (xfrm_msg)
 			strbuf_addstr(&header, xfrm_msg);
 		must_show_header =3D 1;
 	}
 	else if (lbl[1][0] =3D=3D '/') {
-		strbuf_addf(&header, "%s%sdeleted file mode %06o%s\n", line_prefix, =
set, one->mode, reset);
+		strbuf_addf(&header, "%s%s%s %06o%s\n", line_prefix, set, _("deleted=
 file mode"), one->mode, reset);
 		if (xfrm_msg)
 			strbuf_addstr(&header, xfrm_msg);
 		must_show_header =3D 1;
 	}
 	else {
 		if (one->mode !=3D two->mode) {
-			strbuf_addf(&header, "%s%sold mode %06o%s\n", line_prefix, set, one=
->mode, reset);
-			strbuf_addf(&header, "%s%snew mode %06o%s\n", line_prefix, set, two=
->mode, reset);
+			strbuf_addf(&header, "%s%s%s %06o%s\n", line_prefix, set, _("old mo=
de"), one->mode, reset);
+			strbuf_addf(&header, "%s%s%s %06o%s\n", line_prefix, set, _("new mo=
de"), two->mode, reset);
 			must_show_header =3D 1;
 		}
 		if (xfrm_msg)
@@ -4130,7 +4130,7 @@ static void show_mode_change(FILE *file, struct d=
iff_filepair *p, int show_name,
 		const char *line_prefix)
 {
 	if (p->one->mode && p->two->mode && p->one->mode !=3D p->two->mode) {
-		fprintf(file, "%s mode change %06o =3D> %06o%c", line_prefix, p->one=
->mode,
+		fprintf(file, _("%s mode change %06o =3D> %06o%c"), line_prefix, p->=
one->mode,
 			p->two->mode, show_name ? ' ' : '\n');
 		if (show_name) {
 			write_name_quoted(p->two->path, file, '\n');
--=20
1.7.11.1
