From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] log: add --show-linear-break to help see non-linear history
Date: Sat,  8 Feb 2014 20:50:17 +0700
Message-ID: <1391867417-979-1-git-send-email-pclouds@gmail.com>
References: <CANgJU+UcONQYAQ7K-_W7H_12JhfG+iuqYAU81xYMc5kLPXwn_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq@gmail.com, dak@gnu.org, vfr@lyx.org,
	francisstephens@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 14:50:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC8J3-0007uH-Sg
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 14:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbaBHNul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 08:50:41 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64368 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbaBHNuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 08:50:20 -0500
Received: by mail-pd0-f177.google.com with SMTP id x10so4263354pdj.22
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 05:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=m2R9IppIqZl56zguWGc3tiS22x+5OdkmxZBWXWgUX9A=;
        b=iWAIbk4Tq/i9r/JScq9SjtrwMK1eEySljnu/PuLEfCd8IsXUMwc5DYttl6VQh8iLtk
         0XNFpW1AEa8/pbiA7s911Lik601gWHfzo8ZhuEWS4jUXFECHT9bhq5UX9T5pUqBdGy28
         wROrhjwrOTHcY8XQNlchCw1KQONTDyrwV2Fpeuildn/KUGqO6Hfd6NK9Eu395EvSzcSU
         SFXYclB4bkFCBgltS7PSoRrzBBP+JL5QPKRhwp9fKI+abaj6ABoo+CSp1N4chqaDDL7w
         WMvSLv0Qt5FJHsz3ovp2VYROk5hwwgrNMFE090JwKlQCW5rjTBVa4l+Cs8J2HJTAz7kU
         d/4A==
X-Received: by 10.68.136.162 with SMTP id qb2mr26490174pbb.88.1391867419578;
        Sat, 08 Feb 2014 05:50:19 -0800 (PST)
Received: from lanh ([115.73.239.36])
        by mx.google.com with ESMTPSA id ns7sm23797321pbc.32.2014.02.08.05.50.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 05:50:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Feb 2014 20:50:19 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <CANgJU+UcONQYAQ7K-_W7H_12JhfG+iuqYAU81xYMc5kLPXwn_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241836>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This is a more serious attempt to make non-linear history more
 visible without --graph. It looks like this

    commit e4ddb05720710213108cd13ddd5a115e12a6211d
    Author: Andy Spencer <andy753421@gmail.com>
   =20
        tree_entry_interesting: match against all pathspecs
   =20
                        ..........
   =20
    commit a0332337be53f266682279c72a5e553986638c87
    Author: Jeff King <peff@peff.net>
   =20
        t7700: do not use "touch" unnecessarily
   =20
    commit 088304bf73b9b4149e04d2246fe08a06eef6e795
    Author: Jeff King <peff@peff.net>
   =20
        t7501: fix "empty commit" test with NO_PERL
   =20
                        ..........
   =20
    commit 74b4f7f27736f3e196a4eb3db41c68e37a6e2160
    Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>
   =20
        tree-walk.c: ignore trailing slash on submodule in tree_entry_i=
nteresting()

 You can use fancier break bars from [1] instead of plain dots. I'm
 not sure it works with all combinations of rev-list. But at least
 log (with/out pathspec) and log --reverse work.
=20
 [1] http://www.ascii-art.de/ascii/ab/border.txt

 Documentation/rev-list-options.txt |  7 +++++
 log-tree.c                         |  4 +++
 revision.c                         | 52 ++++++++++++++++++++++++++++++=
+++++---
 revision.h                         |  6 +++++
 4 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 03533af..a0780be 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -750,6 +750,13 @@ This enables parent rewriting, see 'History Simpli=
fication' below.
 This implies the `--topo-order` option by default, but the
 `--date-order` option may also be specified.
=20
+--show-linear-break[=3D<break bar>]::
+	When --graph is not used, all history branches are flatten and
+	could be hard to see that the two consecutive commits do not
+	belong to a linear branch. This option puts a break bar in
+	between them in that case. If `<break bar>` is specified, it
+	is the string that will be shown instead of the default one.
+
 ifdef::git-rev-list[]
 --count::
 	Print a number stating how many commits would have been
diff --git a/log-tree.c b/log-tree.c
index 08970bf..17862f6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -805,12 +805,16 @@ int log_tree_commit(struct rev_info *opt, struct =
commit *commit)
 	if (opt->line_level_traverse)
 		return line_log_print(opt, commit);
=20
+	if (opt->track_linear && !opt->linear && !opt->reverse_output_stage)
+		printf("\n%s\n", opt->break_bar);
 	shown =3D log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
 		log.parent =3D NULL;
 		show_log(opt);
 		shown =3D 1;
 	}
+	if (opt->track_linear && !opt->linear && opt->reverse_output_stage)
+		printf("\n%s\n", opt->break_bar);
 	opt->loginfo =3D NULL;
 	maybe_flush_or_die(stdout, "stdout");
 	return shown;
diff --git a/revision.c b/revision.c
index a0df72f..ff3107f 100644
--- a/revision.c
+++ b/revision.c
@@ -1836,6 +1836,12 @@ static int handle_revision_opt(struct rev_info *=
revs, int argc, const char **arg
 		revs->notes_opt.use_default_notes =3D 1;
 	} else if (!strcmp(arg, "--show-signature")) {
 		revs->show_signature =3D 1;
+	} else if (!strcmp(arg, "--show-linear-break")) {
+		revs->track_linear =3D 1;
+		revs->break_bar =3D "                    ..........";
+	} else if (starts_with(arg, "--show-linear-break=3D")) {
+		revs->track_linear =3D 1;
+		revs->break_bar =3D xstrdup(arg + 20);
 	} else if (starts_with(arg, "--show-notes=3D") ||
 		   starts_with(arg, "--notes=3D")) {
 		struct strbuf buf =3D STRBUF_INIT;
@@ -2901,6 +2907,32 @@ enum commit_action simplify_commit(struct rev_in=
fo *revs, struct commit *commit)
 	return action;
 }
=20
+define_commit_slab(saved_linear, int);
+
+static void track_linear(struct rev_info *revs, struct commit *commit)
+{
+	struct commit_list *p =3D revs->previous_parents;
+
+	if (p) {
+		int got_parent =3D 0;
+		for (; p && !got_parent; p =3D p->next)
+			got_parent =3D !hashcmp(p->item->object.sha1,
+					      commit->object.sha1);
+		revs->linear =3D got_parent;
+		free_commit_list(revs->previous_parents);
+	} else
+		revs->linear =3D 1;
+	if (revs->reverse) {
+		if (!revs->saved_linear_slab) {
+			revs->saved_linear_slab =3D xmalloc(sizeof(struct saved_linear));
+			init_saved_linear(revs->saved_linear_slab);
+		}
+
+		*saved_linear_at(revs->saved_linear_slab, commit) =3D revs->linear;
+	}
+	revs->previous_parents =3D copy_commit_list(commit->parents);
+}
+
 static struct commit *get_revision_1(struct rev_info *revs)
 {
 	if (!revs->commits)
@@ -2933,6 +2965,9 @@ static struct commit *get_revision_1(struct rev_i=
nfo *revs)
 				    sha1_to_hex(commit->object.sha1));
 		}
=20
+		if (revs->track_linear)
+			track_linear(revs, commit);
+
 		switch (simplify_commit(revs, commit)) {
 		case commit_ignore:
 			continue;
@@ -3106,14 +3141,25 @@ struct commit *get_revision(struct rev_info *re=
vs)
 		revs->reverse_output_stage =3D 1;
 	}
=20
-	if (revs->reverse_output_stage)
-		return pop_commit(&revs->commits);
+	if (revs->reverse_output_stage) {
+		c =3D pop_commit(&revs->commits);
+		if (revs->track_linear)
+			revs->linear =3D *saved_linear_at(revs->saved_linear_slab, c);
+		return c;
+	}
=20
 	c =3D get_revision_internal(revs);
 	if (c && revs->graph)
 		graph_update(revs->graph, c);
-	if (!c)
+	if (!c) {
 		free_saved_parents(revs);
+		if (revs->saved_linear_slab)
+			clear_saved_linear(revs->saved_linear_slab);
+		if (revs->previous_parents) {
+			free_commit_list(revs->previous_parents);
+			revs->previous_parents =3D NULL;
+		}
+	}
 	return c;
 }
=20
diff --git a/revision.h b/revision.h
index 88967d6..bffdc15 100644
--- a/revision.h
+++ b/revision.h
@@ -134,6 +134,7 @@ struct rev_info {
 			use_terminator:1,
 			missing_newline:1,
 			date_mode_explicit:1,
+			track_linear:1,
 			preserve_subject:1;
 	unsigned int	disable_stdin:1;
 	unsigned int	leak_pending:1;
@@ -195,6 +196,11 @@ struct rev_info {
=20
 	/* copies of the parent lists, for --full-diff display */
 	struct saved_parents *saved_parents_slab;
+
+	struct commit_list *previous_parents;
+	struct saved_linear *saved_linear_slab;
+	char *break_bar;
+	unsigned int linear;
 };
=20
 extern int ref_excluded(struct string_list *, const char *path);
--=20
1.8.5.2.240.g8478abd
