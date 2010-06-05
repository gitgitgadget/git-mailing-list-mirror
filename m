From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v7 2/2] Add initial C, Shell and Perl gettext translations
Date: Sat,  5 Jun 2010 02:13:55 +0000
Message-ID: <1275704035-6552-3-git-send-email-avarab@gmail.com>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 05 04:14:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKiuD-0001Nn-LV
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 04:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab0FECOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 22:14:35 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43793 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701Ab0FECOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 22:14:34 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so471609bwz.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 19:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HxW4B9UMIcPXmgtJCNcks3LAolGs3OYoIpRlUerLSeA=;
        b=kPVYiPFvPkWbaILO4q1raWb1u68nB9/J7JEEqSIo9khtO8ufymhXJXt0Zae6cKxyKv
         CPwK7XcuryQzo0FIsfnRyYG+KDOuWFZ7eWzms/ZxmsLPhyJr7Cwz6pjqvnKObMUtsXpv
         xjXFbGH/S3VrpLBoOlonoFFLwCpZWWNYdz5ZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NVGrEHoAVfJ4DmsgCziMLN85KeyGZBGi0w6E9hNQZDLhhp+v1g/Cf99eWGRbbm3eO6
         TRjSMYOeT/0cGBbDLba+B/VRFmQAOZGYMs6a7sHFO7w9/Fg2x0xCv0r8DI9k0E4lnr/M
         l24UfGsTNQzxrfhuUqmqLwCuSAplEApqh6p/w=
Received: by 10.204.47.21 with SMTP id l21mr4575708bkf.134.1275704073256;
        Fri, 04 Jun 2010 19:14:33 -0700 (PDT)
Received: from aoeu.localdomain (pD9537C21.dip.t-dialin.net [217.83.124.33])
        by mx.google.com with ESMTPS id v2sm7779342bkz.13.2010.06.04.19.14.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 19:14:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.243.gda92d6
In-Reply-To: <1275704035-6552-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148447>

Change the git status, git pull, and git send-email commands to have
at least one translatable string. Each command uses a different core
language, so this makes a good example of how C, Shell and Perl
programs can be translated using gettext.

Since this introduces translation into the real Git tools more tests
can be added to check if they translations actually work for real core
tools.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh         |   16 ++++---
 git-send-email.perl |    3 +-
 po/is.po            |   27 ++++++++++++-
 t/t0200/test.c      |    1 -
 wt-status.c         |  107 ++++++++++++++++++++++++++-----------------=
--------
 5 files changed, 90 insertions(+), 64 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 1a4729f..0d95722 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -9,6 +9,7 @@ LONG_USAGE=3D'Fetch one or more remote refs and merge i=
t/them into the current HEA
 SUBDIRECTORY_OK=3DYes
 OPTIONS_SPEC=3D
 . git-sh-setup
+. git-sh-i18n
 set_reflog_action "pull $*"
 require_work_tree
 cd_to_toplevel
@@ -121,8 +122,8 @@ error_on_no_merge_candidates () {
 	do
 		case "$opt" in
 		-t|--t|--ta|--tag|--tags)
-			echo "Fetching tags only, you probably meant:"
-			echo "  git fetch --tags"
+			gettext "Fetching tags only, you probably meant:"; echo
+			gettext "  git fetch --tags"; echo
 			exit 1
 		esac
 	done
@@ -154,11 +155,12 @@ error_on_no_merge_candidates () {
 		echo "a branch. Because this is not the default configured remote"
 		echo "for your current branch, you must specify a branch on the comm=
and line."
 	elif [ -z "$curr_branch" ]; then
-		echo "You are not currently on a branch, so I cannot use any"
-		echo "'branch.<branchname>.merge' in your configuration file."
-		echo "Please specify which remote branch you want to use on the comm=
and"
-		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
+		gettext "You are not currently on a branch, so I cannot use any
+'branch.<branchname>.merge' in your configuration file.
+Please specify which remote branch you want to use on the command
+line and try again (e.g. 'git pull <repository> <refspec>').
+See git-pull(1) for details.";
+		echo
 	elif [ -z "$upstream" ]; then
 		echo "You asked me to pull without telling me which branch you"
 		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge' i=
n"
diff --git a/git-send-email.perl b/git-send-email.perl
index 111c981..4977fdf 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,6 +26,7 @@ use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use Error qw(:try);
 use Git;
+use Git::I18N;
=20
 Getopt::Long::Configure qw/ pass_through /;
=20
@@ -674,7 +675,7 @@ if (!defined $sender) {
 	$sender =3D $repoauthor || $repocommitter || '';
 	$sender =3D ask("Who should the emails appear to be from? [$sender] "=
,
 	              default =3D> $sender);
-	print "Emails will be sent from: ", $sender, "\n";
+	printf __("Emails will be sent from: %s\n"), $sender;
 	$prompting++;
 }
=20
diff --git a/po/is.po b/po/is.po
index 1b35738..0c77b90 100644
--- a/po/is.po
+++ b/po/is.po
@@ -2,8 +2,8 @@ msgid ""
 msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2010-06-02 17:35+0000\n"
-"PO-Revision-Date: 2010-06-02 16:01+0000\n"
+"POT-Creation-Date: 2010-06-02 19:43+0000\n"
+"PO-Revision-Date: 2010-06-02 19:35+0000\n"
 "Last-Translator: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>\n"
 "Language-Team: Git Mailing List <git@vger.kernel.org>\n"
 "MIME-Version: 1.0\n"
@@ -12,6 +12,20 @@ msgstr ""
 "X-Poedit-Language: English\n"
 "X-Poedit-SourceCharset: utf-8\n"
=20
+#: wt-status.c:63 wt-status.c:79 wt-status.c:98 wt-status.c:110
+#: wt-status.c:622
+msgid "On branch "
+msgstr "=C3=81 greininni "
+
+#: wt-status.c:629
+msgid "Not currently on any branch."
+msgstr "Ekki =C3=A1 neinni grein."
+
+#: wt-status.c:663
+#, c-format
+msgid "# No changes\n"
+msgstr "# Engar breytingar\n"
+
 #. TRANSLATORS: This is a test. You don't need to translate it.
 #: t/t0200-gettext/test.c:6
 msgid "TEST: A C test string"
@@ -23,6 +37,10 @@ msgstr "TILRAUN: C tilraunastrengur"
 msgid "TEST: A C test string %s"
 msgstr "TILRAUN: C tilraunastrengur %s"
=20
+#: git-pull.sh:124
+msgid "Fetching tags only, you probably meant:"
+msgstr "N=C3=A6 a=C3=B0eins =C3=AD t=C3=B6gg, =C3=BE=C3=BA =C3=A1ttir =
l=C3=ADkast til vi=C3=B0:"
+
 #. TRANSLATORS: This is a test. You don't need to translate it.
 #: t/t0200-gettext/test.sh:8
 msgid "TEST: A Shell test string"
@@ -34,6 +52,11 @@ msgstr "TILRAUN: Skeljartilraunastrengur"
 msgid "TEST: A Shell test $variable"
 msgstr "TILRAUN: Skeljartilraunastrengur me=C3=B0 breytunni $variable"
=20
+#: git-send-email.perl:678
+#, perl-format
+msgid "Emails will be sent from: %s\n"
+msgstr "P=C3=B3starnir ver=C3=B0a sendir fr=C3=A1: %s\n"
+
 #. TRANSLATORS: This is a test. You don't need to translate it.
 #: t/t0200-gettext/test.perl:5
 msgid "TEST: A Perl test string"
diff --git a/t/t0200/test.c b/t/t0200/test.c
index 9fa4c23..171bcc6 100644
--- a/t/t0200/test.c
+++ b/t/t0200/test.c
@@ -8,4 +8,3 @@ int main(void)
 	/* TRANSLATORS: This is a test. You don't need to translate it. */
 	printf(_("TEST: A C test string %s"), "variable");
 }
-=09
diff --git a/wt-status.c b/wt-status.c
index 14e0acc..484a866 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "run-command.h"
 #include "remote.h"
+#include "gettext.h"
=20
 static char default_wt_status_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -49,16 +50,16 @@ static void wt_status_print_unmerged_header(struct =
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
@@ -66,15 +67,15 @@ static void wt_status_print_cached_header(struct wt=
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
@@ -84,16 +85,16 @@ static void wt_status_print_dirty_header(struct wt_=
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
@@ -102,10 +103,10 @@ static void wt_status_print_other_header(struct w=
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
@@ -122,20 +123,20 @@ static void wt_status_print_unmerged_data(struct =
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
-	color_fprintf(s->fp, c, "%-20s%s\n", how, one);
+	color_fprintf(s->fp, c, _("%-20s%s\n"), how, one);
 	strbuf_release(&onebuf);
 }
=20
@@ -163,11 +164,11 @@ static void wt_status_print_change_data(struct wt=
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
@@ -178,34 +179,34 @@ static void wt_status_print_change_data(struct wt=
_status *s,
 	one =3D quote_path(one_name, -1, &onebuf, s->prefix);
 	two =3D quote_path(two_name, -1, &twobuf, s->prefix);
=20
-	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
+	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), _("#\t"));
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
@@ -618,14 +619,14 @@ void wt_status_print(struct wt_status *s)
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
@@ -635,7 +636,7 @@ void wt_status_print(struct wt_status *s)
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
@@ -647,38 +648,38 @@ void wt_status_print(struct wt_status *s)
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
1.7.1.243.gda92d6
