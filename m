From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/4] format-patch: update append_signoff prototype
Date: Thu, 22 Nov 2012 23:38:08 +0700
Message-ID: <1353602289-9418-4-git-send-email-pclouds@gmail.com>
References: <CACsJy8BiJRK7N3_HZ2WXpMd1YkDSW00AxuYqiCWJgij+Kq6AiQ@mail.gmail.com>
 <1353602289-9418-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 19:27:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbbV0-0001yu-Qt
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 19:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab2KVS11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2012 13:27:27 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62159 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab2KVS1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 13:27:24 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3033310pad.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VEBbREKVJlcYMOhhL1gYeu9XQQdpy6TgYyaza/Cj5Io=;
        b=0jL4S8QdkQe5+y+ixSGoVEfcks+LHnIl/fM8ok9PoNhE8LDfvmq5FHRuo9C+rlLRwt
         GDJNrxJtte86m7lh4GCmgm64ykuAXk5jNFSM6tIjpBWxHqlP0ldcnJOXrHSAQXrCZJF/
         gARUDey/y0YqjwzTF+K7nYgNPFrnTlB2MfjCZROoJ1BBR4tQdIONvO+BsUJUREVgaR4F
         QM0qPYw1WSwuuUOZ/9U9aHsq/KS7VwkFawiziqfsX0tKBTDYQAAlIagshaNh6YvzsO6f
         Gpak2IeqFRoQ5nwPuaSNPawyGKABvdYK75phDvJvZgY9ygS6mYhFX/E8ZmiCNi4XPWrn
         OM2A==
Received: by 10.68.242.40 with SMTP id wn8mr6502604pbc.16.1353602300104;
        Thu, 22 Nov 2012 08:38:20 -0800 (PST)
Received: from lanh ([115.74.40.93])
        by mx.google.com with ESMTPS id nm2sm2294766pbc.43.2012.11.22.08.38.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 08:38:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 22 Nov 2012 23:38:32 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1353602289-9418-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210178>

This is a preparation step for merging with append_signoff from
sequencer.c

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c | 13 +------------
 log-tree.c    | 21 +++++++++++++--------
 revision.h    |  2 +-
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 09cf43e..f201070 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1053,7 +1053,6 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 	struct commit *origin =3D NULL, *head =3D NULL;
 	const char *in_reply_to =3D NULL;
 	struct patch_ids ids;
-	char *add_signoff =3D NULL;
 	struct strbuf buf =3D STRBUF_INIT;
 	int use_patch_format =3D 0;
 	int quiet =3D 0;
@@ -1148,16 +1147,6 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
=20
-	if (do_signoff) {
-		const char *committer;
-		const char *endpos;
-		committer =3D git_committer_info(IDENT_STRICT);
-		endpos =3D strchr(committer, '>');
-		if (!endpos)
-			die(_("bogus committer info %s"), committer);
-		add_signoff =3D xmemdupz(committer, endpos - committer + 1);
-	}
-
 	for (i =3D 0; i < extra_hdr.nr; i++) {
 		strbuf_addstr(&buf, extra_hdr.items[i].string);
 		strbuf_addch(&buf, '\n');
@@ -1348,7 +1337,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 		total++;
 		start_number--;
 	}
-	rev.add_signoff =3D add_signoff;
+	rev.add_signoff =3D do_signoff;
 	while (0 <=3D --nr) {
 		int shown;
 		commit =3D list[nr];
diff --git a/log-tree.c b/log-tree.c
index aff7c0a..7e50545 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -253,9 +253,11 @@ static int detect_any_signoff(char *letter, int si=
ze)
 	return seen_head && seen_name;
 }
=20
-static void append_signoff(struct strbuf *sb, const char *signoff)
+static void append_signoff(struct strbuf *sb, int flags)
 {
-	static const char signed_off_by[] =3D "Signed-off-by: ";
+	char* signoff =3D xstrdup(fmt_name(getenv("GIT_COMMITTER_NAME"),
+					 getenv("GIT_COMMITTER_EMAIL")));
+	static const char sign_off_header[] =3D "Signed-off-by: ";
 	size_t signoff_len =3D strlen(signoff);
 	int has_signoff =3D 0;
 	char *cp;
@@ -274,9 +276,9 @@ static void append_signoff(struct strbuf *sb, const=
 char *signoff)
 	}
=20
 	/* First see if we already have the sign-off by the signer */
-	while ((cp =3D strstr(cp, signed_off_by))) {
+	while ((cp =3D strstr(cp, sign_off_header))) {
 		const char *s =3D cp;
-		cp +=3D strlen(signed_off_by);
+		cp +=3D strlen(sign_off_header);
=20
 		if (!has_signoff && s > sb->buf) {
 			/*
@@ -317,9 +319,10 @@ static void append_signoff(struct strbuf *sb, cons=
t char *signoff)
 	if (!has_signoff)
 		strbuf_addch(sb, '\n');
=20
-	strbuf_addstr(sb, signed_off_by);
+	strbuf_addstr(sb, sign_off_header);
 	strbuf_add(sb, signoff, signoff_len);
 	strbuf_addch(sb, '\n');
+	free(signoff);
 }
=20
 static unsigned int digits_in_number(unsigned int number)
@@ -684,8 +687,10 @@ void show_log(struct rev_info *opt)
 	/*
 	 * And then the pretty-printed message itself
 	 */
-	if (ctx.need_8bit_cte >=3D 0)
-		ctx.need_8bit_cte =3D has_non_ascii(opt->add_signoff);
+	if (ctx.need_8bit_cte >=3D 0 && opt->add_signoff)
+		ctx.need_8bit_cte =3D
+			has_non_ascii(fmt_name(getenv("GIT_COMMITTER_NAME"),
+					       getenv("GIT_COMMITTER_EMAIL")));
 	ctx.date_mode =3D opt->date_mode;
 	ctx.date_mode_explicit =3D opt->date_mode_explicit;
 	ctx.abbrev =3D opt->diffopt.abbrev;
@@ -696,7 +701,7 @@ void show_log(struct rev_info *opt)
 	pretty_print_commit(&ctx, commit, &msgbuf);
=20
 	if (opt->add_signoff)
-		append_signoff(&msgbuf, opt->add_signoff);
+		append_signoff(&msgbuf, 0);
 	if (opt->show_log_size) {
 		printf("log size %i\n", (int)msgbuf.len);
 		graph_show_oneline(opt->graph);
diff --git a/revision.h b/revision.h
index a95bd0b..af35325 100644
--- a/revision.h
+++ b/revision.h
@@ -136,7 +136,7 @@ struct rev_info {
 	int		numbered_files;
 	char		*message_id;
 	struct string_list *ref_message_ids;
-	const char	*add_signoff;
+	int              add_signoff;
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
--=20
1.8.0.4.g5d0415a
