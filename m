From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 24/25] gettextize: git-status basic messages
Date: Thu,  2 Sep 2010 19:40:45 +0000
Message-ID: <1283456446-22577-25-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFgV-0006jt-G5
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699Ab0IBTmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:42:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59496 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694Ab0IBTmn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:42:43 -0400
Received: by wyb35 with SMTP id 35so82207wyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=NuEJz4lNEcAB02LTvUBJt4HqRuB/tCNqfl/cnZm6DTo=;
        b=u5DTZncljZHFUCY1u3FZKPGjbsaUugEB1ruQI2+wfVJeoesBPm6Q/ssVBm8mATkgey
         Kv4U94x+BlREjyYrHvxoXZ39BGdmmt+4bVUXqpJsF8oRIbzAWYvBjmj1HEiZrpeqJC4P
         DQtpf+c4RiURt9VeD94VLOEyiOnF/Uf63J8Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fqhTEy1ucDEWpKOk9YjhZgBMOIrLLgHvKm9Xr/dVbWoOETNOe6hcHCFJXOgVzOXbfY
         +Ntb0qqK2eAX4LYufBmen1aWD5ZNiOBX1lCt43ZwohX3uxbVrzkgK85koAYtvCTNHNOz
         mbQnSJeOS+bRxEJZQl3EIHnsNdzOd3iG09oHE=
Received: by 10.227.146.142 with SMTP id h14mr86361wbv.25.1283456560195;
        Thu, 02 Sep 2010 12:42:40 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.42.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:42:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155184>

Ripped out as-is from the "Add initial C, Shell and Perl gettext
translations" patch that was part of the gettext RFC for a long time
and has already been reviewed by a lot of eyeballs.

The only change is the removal of two messages that didn't really
belong: _("#\t") and _("%-20s%s\n").

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 wt-status.c |  102 +++++++++++++++++++++++++++++----------------------=
-------
 1 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 7716dd9..1c1a575 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -54,16 +54,16 @@ static void wt_status_print_unmerged_header(struct =
wt_status *s)
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
=20
-	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
+	color_fprintf_ln(s->fp, c, _("# Unmerged paths:"));
 	if (!advice_status_hints)
 		return;
 	if (s->in_merge)
 		;
 	else if (!s->is_initial)
-		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to u=
nstage)", s->reference);
+		color_fprintf_ln(s->fp, c, _("#   (use \"git reset %s <file>...\" to=
 unstage)"), s->reference);
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" t=
o unstage)");
-	color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" as appr=
opriate to mark resolution)");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git rm --cached <file>...\"=
 to unstage)"));
+	color_fprintf_ln(s->fp, c, _("#   (use \"git add/rm <file>...\" as ap=
propriate to mark resolution)"));
 	color_fprintf_ln(s->fp, c, "#");
 }
=20
@@ -71,15 +71,15 @@ static void wt_status_print_cached_header(struct wt=
_status *s)
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
=20
-	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
+	color_fprintf_ln(s->fp, c, _("# Changes to be committed:"));
 	if (!advice_status_hints)
 		return;
 	if (s->in_merge)
 		; /* NEEDSWORK: use "git reset --unresolve"??? */
 	else if (!s->is_initial)
-		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to u=
nstage)", s->reference);
+		color_fprintf_ln(s->fp, c, _("#   (use \"git reset %s <file>...\" to=
 unstage)"), s->reference);
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" t=
o unstage)");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git rm --cached <file>...\"=
 to unstage)"));
 	color_fprintf_ln(s->fp, c, "#");
 }
=20
@@ -89,16 +89,16 @@ static void wt_status_print_dirty_header(struct wt_=
status *s,
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
=20
-	color_fprintf_ln(s->fp, c, "# Changed but not updated:");
+	color_fprintf_ln(s->fp, c, _("# Changed but not updated:"));
 	if (!advice_status_hints)
 		return;
 	if (!has_deleted)
-		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update=
 what will be committed)");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git add <file>...\" to upda=
te what will be committed)"));
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" to upd=
ate what will be committed)");
-	color_fprintf_ln(s->fp, c, "#   (use \"git checkout -- <file>...\" to=
 discard changes in working directory)");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git add/rm <file>...\" to u=
pdate what will be committed)"));
+	color_fprintf_ln(s->fp, c, _("#   (use \"git checkout -- <file>...\" =
to discard changes in working directory)"));
 	if (has_dirty_submodules)
-		color_fprintf_ln(s->fp, c, "#   (commit or discard the untracked or =
modified content in submodules)");
+		color_fprintf_ln(s->fp, c, _("#   (commit or discard the untracked o=
r modified content in submodules)"));
 	color_fprintf_ln(s->fp, c, "#");
 }
=20
@@ -107,10 +107,10 @@ static void wt_status_print_other_header(struct w=
t_status *s,
 					 const char *how)
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
-	color_fprintf_ln(s->fp, c, "# %s files:", what);
+	color_fprintf_ln(s->fp, c, _("# %s files:"), what);
 	if (!advice_status_hints)
 		return;
-	color_fprintf_ln(s->fp, c, "#   (use \"git %s <file>...\" to include =
in what will be committed)", how);
+	color_fprintf_ln(s->fp, c, _("#   (use \"git %s <file>...\" to includ=
e in what will be committed)"), how);
 	color_fprintf_ln(s->fp, c, "#");
 }
=20
@@ -127,18 +127,18 @@ static void wt_status_print_unmerged_data(struct =
wt_status *s,
 	const char *c =3D color(WT_STATUS_UNMERGED, s);
 	struct wt_status_change_data *d =3D it->util;
 	struct strbuf onebuf =3D STRBUF_INIT;
-	const char *one, *how =3D "bug";
+	const char *one, *how =3D _("bug");
=20
 	one =3D quote_path(it->string, -1, &onebuf, s->prefix);
 	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
 	switch (d->stagemask) {
-	case 1: how =3D "both deleted:"; break;
-	case 2: how =3D "added by us:"; break;
-	case 3: how =3D "deleted by them:"; break;
-	case 4: how =3D "added by them:"; break;
-	case 5: how =3D "deleted by us:"; break;
-	case 6: how =3D "both added:"; break;
-	case 7: how =3D "both modified:"; break;
+	case 1: how =3D _("both deleted:"); break;
+	case 2: how =3D _("added by us:"); break;
+	case 3: how =3D _("deleted by them:"); break;
+	case 4: how =3D _("added by them:"); break;
+	case 5: how =3D _("deleted by us:"); break;
+	case 6: how =3D _("both added:"); break;
+	case 7: how =3D _("both modified:"); break;
 	}
 	color_fprintf(s->fp, c, "%-20s%s\n", how, one);
 	strbuf_release(&onebuf);
@@ -168,11 +168,11 @@ static void wt_status_print_change_data(struct wt=
_status *s,
 		if (d->new_submodule_commits || d->dirty_submodule) {
 			strbuf_addstr(&extra, " (");
 			if (d->new_submodule_commits)
-				strbuf_addf(&extra, "new commits, ");
+				strbuf_addf(&extra, _("new commits, "));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				strbuf_addf(&extra, "modified content, ");
+				strbuf_addf(&extra, _("modified content, "));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-				strbuf_addf(&extra, "untracked content, ");
+				strbuf_addf(&extra, _("untracked content, "));
 			strbuf_setlen(&extra, extra.len - 2);
 			strbuf_addch(&extra, ')');
 		}
@@ -186,31 +186,31 @@ static void wt_status_print_change_data(struct wt=
_status *s,
 	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
 	switch (status) {
 	case DIFF_STATUS_ADDED:
-		color_fprintf(s->fp, c, "new file:   %s", one);
+		color_fprintf(s->fp, c, _("new file:   %s"), one);
 		break;
 	case DIFF_STATUS_COPIED:
-		color_fprintf(s->fp, c, "copied:     %s -> %s", one, two);
+		color_fprintf(s->fp, c, _("copied:     %s -> %s"), one, two);
 		break;
 	case DIFF_STATUS_DELETED:
-		color_fprintf(s->fp, c, "deleted:    %s", one);
+		color_fprintf(s->fp, c, _("deleted:    %s"), one);
 		break;
 	case DIFF_STATUS_MODIFIED:
-		color_fprintf(s->fp, c, "modified:   %s", one);
+		color_fprintf(s->fp, c, _("modified:   %s"), one);
 		break;
 	case DIFF_STATUS_RENAMED:
-		color_fprintf(s->fp, c, "renamed:    %s -> %s", one, two);
+		color_fprintf(s->fp, c, _("renamed:    %s -> %s"), one, two);
 		break;
 	case DIFF_STATUS_TYPE_CHANGED:
-		color_fprintf(s->fp, c, "typechange: %s", one);
+		color_fprintf(s->fp, c, _("typechange: %s"), one);
 		break;
 	case DIFF_STATUS_UNKNOWN:
-		color_fprintf(s->fp, c, "unknown:    %s", one);
+		color_fprintf(s->fp, c, _("unknown:    %s"), one);
 		break;
 	case DIFF_STATUS_UNMERGED:
-		color_fprintf(s->fp, c, "unmerged:   %s", one);
+		color_fprintf(s->fp, c, _("unmerged:   %s"), one);
 		break;
 	default:
-		die("bug: unhandled diff status %c", status);
+		die(_("bug: unhandled diff status %c"), status);
 	}
 	if (extra.len) {
 		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "%s", extra.buf);
@@ -633,14 +633,14 @@ void wt_status_print(struct wt_status *s)
 	const char *branch_color =3D color(WT_STATUS_HEADER, s);
=20
 	if (s->branch) {
-		const char *on_what =3D "On branch ";
+		const char *on_what =3D _("On branch ");
 		const char *branch_name =3D s->branch;
 		if (!prefixcmp(branch_name, "refs/heads/"))
 			branch_name +=3D 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_name =3D "";
 			branch_color =3D color(WT_STATUS_NOBRANCH, s);
-			on_what =3D "Not currently on any branch.";
+			on_what =3D _("Not currently on any branch.");
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
 		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
@@ -650,7 +650,7 @@ void wt_status_print(struct wt_status *s)
=20
 	if (s->is_initial) {
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "# Initial commi=
t");
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("# Initial com=
mit"));
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 	}
=20
@@ -664,38 +664,38 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_submodule_summary(s, 1);  /* unstaged */
 	}
 	if (s->show_untracked_files) {
-		wt_status_print_other(s, &s->untracked, "Untracked", "add");
+		wt_status_print_other(s, &s->untracked, _("Untracked"), _("add"));
 		if (s->show_ignored_files)
-			wt_status_print_other(s, &s->ignored, "Ignored", "add -f");
+			wt_status_print_other(s, &s->ignored, _("Ignored"), _("add -f"));
 	} else if (s->commitable)
-		fprintf(s->fp, "# Untracked files not listed%s\n",
+		fprintf(s->fp, _("# Untracked files not listed%s\n"),
 			advice_status_hints
-			? " (use -u option to show untracked files)" : "");
+			? _(" (use -u option to show untracked files)") : "");
=20
 	if (s->verbose)
 		wt_status_print_verbose(s);
 	if (!s->commitable) {
 		if (s->amend)
-			fprintf(s->fp, "# No changes\n");
+			fprintf(s->fp, _("# No changes\n"));
 		else if (s->nowarn)
 			; /* nothing */
 		else if (s->workdir_dirty)
-			printf("no changes added to commit%s\n",
+			printf(_("no changes added to commit%s\n"),
 				advice_status_hints
-				? " (use \"git add\" and/or \"git commit -a\")" : "");
+				? _(" (use \"git add\" and/or \"git commit -a\")") : "");
 		else if (s->untracked.nr)
-			printf("nothing added to commit but untracked files present%s\n",
+			printf(_("nothing added to commit but untracked files present%s\n")=
,
 				advice_status_hints
-				? " (use \"git add\" to track)" : "");
+				? _(" (use \"git add\" to track)") : "");
 		else if (s->is_initial)
 			printf("nothing to commit%s\n", advice_status_hints
-				? " (create/copy files and use \"git add\" to track)" : "");
+				? _(" (create/copy files and use \"git add\" to track)") : "");
 		else if (!s->show_untracked_files)
-			printf("nothing to commit%s\n", advice_status_hints
-				? " (use -u to show untracked files)" : "");
+			printf(_("nothing to commit%s\n"), advice_status_hints
+				? _(" (use -u to show untracked files)") : "");
 		else
-			printf("nothing to commit%s\n", advice_status_hints
-				? " (working directory clean)" : "");
+			printf(_("nothing to commit%s\n"), advice_status_hints
+				? _(" (working directory clean)") : "");
 	}
 }
=20
--=20
1.7.2.2.614.g1dc9
