From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Sun, 14 Sep 2008 20:08:04 +0700
Message-ID: <1221397685-27715-16-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
 <1221397685-27715-8-git-send-email-pclouds@gmail.com>
 <1221397685-27715-9-git-send-email-pclouds@gmail.com>
 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
 <1221397685-27715-11-git-send-email-pclouds@gmail.com>
 <1221397685-27715-12-git-send-email-pclouds@gmail.com>
 <1221397685-27715-13-git-send-email-pclouds@gmail.com>
 <1221397685-27715-14-git-send-email-pclouds@gmail.com>
 <1221397685-27715-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:11:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerNr-00069e-BN
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbYINNKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754231AbYINNKM
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:10:12 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257AbYINNKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:10:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wum+P6zvYVx+xb0dmyTtdWbqwdSomufmKxFGLWJm7KU=;
        b=OPHB9x9oxV7fjGOU1q0S5aY1mbaGzZ7X3RL3bOFHsotWoNhX8aW9Wvz/dgOSRRG/3p
         TedVHDB9mioH+wTbh+NMvfYRNktFzh50xzP+ezpkpu0X9gXcjrk54YOqaoBxjC0sOrKd
         5FDHM6pIUihdIq23hLy067rrQVVngE/Rq4WEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=P6D/Ty0pwhfVnlXdlwIpEhQdqQgtZFxH9VoeiQawp6nYRAXVVh+KmdnjE5URxZYVig
         GEaTDvK9fXsDtQjbNL2oHM4WhQc3bUWAk9hrfMsNwhDNpQ5y9+eRqL2mErou0nFnk5nf
         pguCr3CvazKf1JMkxD85xLWc1DKipRpEF9zVw=
Received: by 10.142.215.5 with SMTP id n5mr2260585wfg.131.1221397809548;
        Sun, 14 Sep 2008 06:10:09 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 30sm19641044wfa.10.2008.09.14.06.10.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:10:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:10:01 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-15-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95842>

These options include:

 --full: return to full checkout (default)
 --path: narrow checkout to some areas according to given spec
 --add-path/--remove-path: adjust current narrow checkout

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt |   68 ++++++++++++++++++++++++++++++++=
+-
 builtin-checkout.c             |   44 ++++++++++++++++++++++
 t/t2011-checkout-narrow.sh     |   80 ++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 190 insertions(+), 2 deletions(-)
 create mode 100755 t/t2011-checkout-narrow.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 82e154d..2ae483b 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,8 +8,10 @@ git-checkout - Checkout a branch or paths to the worki=
ng tree
 SYNOPSIS
 --------
 [verse]
-'git checkout' [-q] [-f] [--track | --no-track] [-b <new_branch> [-l]]=
 [-m] [<branch>]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish=
>] [--] <paths>...
+'git checkout' [-q] [-f] [--track | --no-track] [-b <new_branch> [-l]]=
 [-m]
+	  [<narrow options>] [<branch>]
+'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish=
>]
+	  [<narrow options>] [--] <paths>...
=20
 DESCRIPTION
 -----------
@@ -34,6 +36,10 @@ used to specify a specific tree-ish (i.e. commit, ta=
g or tree)
 to update the index for the given paths before updating the
 working tree.
=20
+<narrow options> include --full, --path, --add-path and --remove-path.
+The last three require narrow spec. Please refer to "narrow checkout"
+section to have more information about this mode.
+
 The index may contain unmerged entries after a failed merge.  By
 default, if you try to check out such an entry from the index, the
 checkout operation will fail and nothing will be checked out.
@@ -108,6 +114,22 @@ exlicitly give a name with '-b' in such a case.
 	However, with this option, a three-way merge between the current
 	branch, your working tree contents, and the new branch
 	is done, and you will be on the new branch.
+
+--full::
+	Quit narrow checkout mode. Return to full checkout.
+
+--path=3D<narrow_spec>::
+	Re-apply new narrow spec on current working directory to
+	form new checkout area.
+
+--add-path=3D<narrow_spec>::
+	Checkout more areas specified by narrow spec to current
+	checkout area.
+
+--remove-path=3D<narrow_spec>::
+	Narrow checkout area by removing files specified by narrow spec
+	from current checkout area. This operation will fail if there
+	is unmerged or modified files in the removing areas.
 +
 When a merge conflict happens, the index entries for conflicting
 paths are left unmerged, and you need to resolve the conflicts
@@ -171,6 +193,48 @@ the reflog for HEAD where you were, e.g.
 $ git log -g -2 HEAD
 ------------
=20
+Narrow checkout
+---------------
+
+Normally when you do checkout a branch, your working directory
+will be fully populated. In some situations, you just need to
+work on certain files, no full checkout is required. Narrow
+checkout is a mode that limits checkout area according to your
+rules.
+
+Because narrow checkout uses new index format, it will be
+incompatible with git prior to 1.6.0. In order to make your
+working directory work with those versions, you can use `git
+checkout --full` to return to normal mode (and compatible index
+format).
+
+Narrow works by applying your rules to the index, marking which
+file you need and which file you need not. Modified/Unmerged
+files cannot be marked unneeded. Unnecessary files will be
+removed from working directory.  Note that after this step,
+removed files can still be added to working directory when they
+are needed by any git command. For example, when you have a merge
+conflict, conflicted files will be checked out on working
+directory and will no longer be marked "unneeded".
+
+New files after merges will always be "needed". You can also
+apply rules when switching branches to avoid unwanted new files.
+
+Files that are marked "no-checkout" will be treated like entries
+with "assume-unchanged bit" (see linkgit:git-update-index[1]). In
+short, Git will never look for those files in working directory
+no matter whether they exist in working directory.
+
+You can apply your rules at once with --path option, or do it
+incrementally with --add-path and --remove-path.
+
+Narrow spec will be used to specify how you want to narrow your
+checkout. It is a list of pathspecs separated by colons. Each
+patchspec specifies what files should be checked out on working
+directory. Pathspec can contain wildcards and is relative to
+current working directory. Usually asterisk (*) does not match
+slashes. If a pathspec is prefixed by a plus sign (+), then
+any asterisk will match anything, even slashes.
=20
 EXAMPLES
 --------
diff --git a/builtin-checkout.c b/builtin-checkout.c
index c7b0aad..b6bc3c5 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -33,6 +33,12 @@ struct checkout_opts {
 	const char *new_branch;
 	int new_branch_log;
 	enum branch_track track;
+
+	const char *prefix;
+	char *new_path;
+	char *add_path;
+	char *remove_path;
+	int no_narrow_checkout;
 };
=20
 static int post_checkout_hook(struct commit *old, struct commit *new,
@@ -412,6 +418,24 @@ static int merge_working_tree(struct checkout_opts=
 *opts,
 		tree =3D parse_tree_indirect(new->commit->object.sha1);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
=20
+		topts.narrow_prefix =3D opts->prefix;
+		if (opts->no_narrow_checkout) {
+			/* leave narrow_spec NULL */
+			topts.new_narrow_path =3D 1;
+		}
+		else if (opts->new_path) {
+			topts.narrow_spec =3D opts->new_path;
+			topts.new_narrow_path =3D 1;
+		}
+		else if (opts->add_path) {
+			topts.narrow_spec =3D opts->add_path;
+			topts.add_narrow_path =3D 1;
+		}
+		else if (opts->remove_path) {
+			topts.narrow_spec =3D opts->remove_path;
+			topts.remove_narrow_path =3D 1;
+		}
+
 		ret =3D unpack_trees(2, trees, &topts);
 		if (ret =3D=3D -1) {
 			/*
@@ -600,6 +624,10 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
 		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
+		OPT_BOOLEAN(0, "full", &opts.no_narrow_checkout, "quit sparse checko=
ut"),
+		OPT_STRING(0, "path", &opts.new_path, "prefixes", "apply new narrow =
checkout path"),
+		OPT_STRING(0, "add-path", &opts.add_path, "prefixes", "add more chec=
kout area"),
+		OPT_STRING(0, "remove-path", &opts.remove_path, "prefixes", "narrow =
checkout area"),
 		OPT_END(),
 	};
 	int has_dash_dash;
@@ -610,6 +638,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	git_config(git_checkout_config, NULL);
=20
 	opts.track =3D BRANCH_TRACK_UNSPECIFIED;
+	opts.prefix =3D prefix;
=20
 	argc =3D parse_options(argc, argv, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
@@ -639,6 +668,18 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
 	if (!opts.new_branch && (opts.track !=3D git_branch_track))
 		die("git checkout: --track and --no-track require -b");
=20
+	if (((opts.no_narrow_checkout ? 1 : 0) +
+	     (opts.new_path ? 1 : 0) +
+	     (opts.add_path ? 1 : 0) +
+	     (opts.remove_path ? 1 : 0)) > 1)
+		die("git checkout: --path, --full, --add-path and --remove-path are =
incompatible");
+
+	if (opts.new_branch && (opts.add_path || opts.remove_path))
+		die("git checkout: --add-path and --remove-path should only be used =
on current branch");
+
+	if (opts.new_branch && opts.no_narrow_checkout)
+		die("git checkout: switching branch with --full does not make sense"=
);
+
 	if (opts.force && opts.merge)
 		die("git checkout: -f and -m are incompatible");
=20
@@ -732,6 +773,9 @@ no_reference:
 		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
 			die("git checkout: --ours/--theirs, --force and --merge are incompa=
tible when\nchecking out of the index.");
=20
+		if (opts.no_narrow_checkout || opts.new_path || opts.add_path || opt=
s.remove_path)
+			die("git checkout: updating paths is incompatible with setting spar=
se checkout");
+
 		return checkout_paths(source_tree, pathspec, &opts);
 	}
=20
diff --git a/t/t2011-checkout-narrow.sh b/t/t2011-checkout-narrow.sh
new file mode 100755
index 0000000..77b99e1
--- /dev/null
+++ b/t/t2011-checkout-narrow.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+test_description=3D'narrow checkout'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir work1 work2 work3
+	touch one two three
+	touch work1/one work2/two work3/three
+	git add one work1/one
+	git commit -m work1
+	git add two work2/two
+	git commit -m work2
+	git add three work3/three
+	git commit -m work3
+'
+
+test_expect_success '--full on no-narrow checkout' '
+	git checkout --full
+'
+
+test_expect_success '--full and --path incompatible' '
+	test_must_fail git checkout --full --path=3Dwork1
+'
+
+test_expect_success 'limit worktree to work1 and work2' '
+	git checkout --path=3D"work1/*:work2/*" &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three
+'
+
+test_expect_success 'update worktree to work2 and work3' '
+	git checkout --path=3D"work2/*:work3/*" &&
+	! test -f work1/one &&
+	test -f work2/two &&
+	test -f work3/three
+'
+
+test_expect_success 'update narrow prefix with modification' '
+	echo modified >> work2/two &&
+	git checkout --path=3D"work1/*:work2/*" &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three &&
+	grep -q modified work2/two
+'
+
+test_expect_success 'update narrow should not lose modification' '
+	! git checkout --path=3D"work1/*:work3/*" &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three &&
+	grep -q modified work2/two
+'
+
+test_expect_success 'widen checkout area' '
+	git checkout --add-path=3D"work3/*" &&
+	test -f work1/one &&
+	test -f work2/two &&
+	test -f work3/three
+'
+
+test_expect_success 'narrow checkout area' '
+	git checkout --remove-path=3D"work3/*" &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three
+'
+
+test_expect_success 'exit narrow checkout' '
+	git checkout --full &&
+	test -f work1/one &&
+	test -f work2/two &&
+	test -f work3/three &&
+	test one
+'
+
+test_done
--=20
1.6.0.96.g2fad1.dirty
