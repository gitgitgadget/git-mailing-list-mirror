From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/14] checkout: add new options to support sparse checkout
Date: Sat, 20 Sep 2008 17:01:52 +0700
Message-ID: <1221904913-25887-14-git-send-email-pclouds@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:05:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzKq-0001Tk-Qv
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbYITKDw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbYITKDv
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:03:51 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:14530 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbYITKDu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:03:50 -0400
Received: by rv-out-0506.google.com with SMTP id k40so808445rvb.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SVPm/xhinozel9XhzQHdBXcBgOcPGgHrT4XjtSEu+vg=;
        b=O+08Dhd1GjxA67h/FlMxqPLXpuhRYPZtghddaJzO/7Q70hiiQ6mISQUilsxRKlLwY0
         erWBxLJV14LSFfu6Nx4pJdX0mA+7axyVBzRJhuDRCYd3/bOt9JrxXU7ZjbtHfEQYGsYj
         APMb37wukrt9R1Wc2w2qnMPOfWS7HeHphkLyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=M6wUNhkAZv4m+DHn6LaHA0k+6jcc7Z1C031BkqLZRrXcENyi5f0M0FaB5muv/Q/Dju
         m0GSEGsHDfyehOLWZYDq9+W3R2f2Od03K3RF3B8PVD92ESISVuJpCyL8647qmSYQQRgD
         /kChjXbdGmBryayezBtJjlTXOsT/q0gM2zy+0=
Received: by 10.142.188.4 with SMTP id l4mr455538wff.92.1221905030122;
        Sat, 20 Sep 2008 03:03:50 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 24sm3673195wfc.6.2008.09.20.03.03.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:03:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:03:38 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-13-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96351>

This patch adds main interface to manipulate sparse checkout.
New options are added to support entering/updating/leaving sparse
checkout:

 --full: return to full checkout (default)
 --reset-path: set checkout area according to given spec
 --add-path/--remove-path: adjust current sparse checkout area

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt |   54 +++++++++++++++++++-
 builtin-checkout.c             |   37 ++++++++++++++
 t/t2011-checkout-sparse.sh     |  108 ++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 196 insertions(+), 3 deletions(-)
 create mode 100755 t/t2011-checkout-sparse.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index d6f94a6..571e2a4 100644
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
+	  [<sparse checkout options>] [<branch>]
+'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish=
>]
+	  [<sparse checkout options>] [--] <paths>...
=20
 DESCRIPTION
 -----------
@@ -34,6 +36,10 @@ used to specify a specific tree-ish (i.e. commit, ta=
g or tree)
 to update the index for the given paths before updating the
 working tree.
=20
+<sparse checkout options> include --full, --reset-path, --add-path
+and --remove-path. The last three require sparse patterns. Please refe=
r
+to "sparse checkout" section for more information about this mode.
+
 The index may contain unmerged entries after a failed merge.  By
 default, if you try to check out such an entry from the index, the
 checkout operation will fail and nothing will be checked out.
@@ -117,6 +123,32 @@ should result in deletion of the path).
 When checking out paths from the index, this option lets you recreate
 the conflicted merge in the specified paths.
=20
+--full::
+	Quit sparse checkout mode. Return to full checkout. This option
+	cannot be used with either --reset-path, --add-path,
+	--remove-path or <paths>.
+
+--reset-path=3D<sparse patterns>::
+	Re-apply new sparse patterns on current working directory to
+	form new checkout area. All no-checkout bits will be wiped
+	out before applying the patterns. This option cannot be used
+	with --full, --add-path, --remove-path or <paths>. Multiple
+	--reset-path is not allowed.
+
+--add-path=3D<sparse patterns>::
+	Checkout more areas specified by sparse patterns to current
+	checkout area. Already checked out entries are not affected.
+	This option cannot be used with --full, --reset-path,
+	--remove-path or <paths>. Multiple --add-path is not allowed.
+
+--remove-path=3D<sparse patterns>::
+	Narrow checkout area by removing files specified by sparse patterns
+	from current checkout area. This operation will fail if there
+	are unmerged or modified files in the removing areas. No-checkout
+	entries are not affected. This option cannot be used with --full,
+	--reset-path, --add-path or <paths>. Multiple --remove-path is not
+	allowed.
+
 --conflict=3D<style>::
 	The same as --merge option above, but changes the way the
 	conflicting hunks are presented, overriding the
@@ -186,7 +218,10 @@ Because sparse checkout uses a new index format, i=
t will be
 incompatible with git prior to 1.6.0 regarding worktree operations.
 Operations that only need access to the repository itself, such as
 clone, push, or pull/fetch from another (normal) repository... should
-not be affected by sparse checkout.
+not be affected by sparse checkout. In order to make your working
+directory work again with those versions, you can use
+`git checkout --full` to return to normal mode (and compatible index
+format).
=20
 In sparse checkout mode, checkout status of every files in your
 working directory will be recorded in index. If a file is marked
@@ -251,6 +286,19 @@ Patterns have the following format:
  - Because colons are used to separate patterns, you cannot put them
    in patterns directly. You must quote them using backslash.
=20
+When you apply new sparse patterns to your working directory using eit=
her
+--reset-path, --add-path or --remove-path, it will update "checkout" s=
tatus
+in index accordingly. Moreover, if a file is marked "no-checkout" and
+is present in working directory, it will be removed. If a file is
+turned from "no-checkout" to "checkout", then it will be added again
+to working directory. Modified and unmerged entries can't bear
+"no-checkout" status, if sparse patterns apply to them, "git checkout"
+will refuse to update working directory.
+
+Sparse patterns are not saved by "git checkout" anywhere in the reposi=
tory.
+You can form your checkout area in one go with --reset-path option,
+or do it incrementally with --add-path and --remove-path.
+
 EXAMPLES
 --------
=20
diff --git a/builtin-checkout.c b/builtin-checkout.c
index c7b0aad..d459bc6 100644
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
+	int all_path;
 };
=20
 static int post_checkout_hook(struct commit *old, struct commit *new,
@@ -412,6 +418,23 @@ static int merge_working_tree(struct checkout_opts=
 *opts,
 		tree =3D parse_tree_indirect(new->commit->object.sha1);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
=20
+		if (opts->all_path) {
+			/* leave narrow_spec NULL */
+			topts.new_narrow_path =3D 1;
+		}
+		else if (opts->new_path) {
+			topts.narrow_spec =3D parse_narrow_spec(opts->new_path, opts->prefi=
x);
+			topts.new_narrow_path =3D 1;
+		}
+		else if (opts->add_path) {
+			topts.narrow_spec =3D parse_narrow_spec(opts->add_path, opts->prefi=
x);
+			topts.add_narrow_path =3D 1;
+		}
+		else if (opts->remove_path) {
+			topts.narrow_spec =3D parse_narrow_spec(opts->remove_path, opts->pr=
efix);
+			topts.remove_narrow_path =3D 1;
+		}
+
 		ret =3D unpack_trees(2, trees, &topts);
 		if (ret =3D=3D -1) {
 			/*
@@ -600,6 +623,10 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
 		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
+		OPT_BOOLEAN(0, "full", &opts.all_path, "quit sparse checkout"),
+		OPT_STRING(0, "reset-path", &opts.new_path, "prefixes", "reset to ne=
w sparse checkout"),
+		OPT_STRING(0, "add-path", &opts.add_path, "prefixes", "widen checkou=
t area"),
+		OPT_STRING(0, "remove-path", &opts.remove_path, "prefixes", "narrow =
checkout area"),
 		OPT_END(),
 	};
 	int has_dash_dash;
@@ -610,6 +637,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	git_config(git_checkout_config, NULL);
=20
 	opts.track =3D BRANCH_TRACK_UNSPECIFIED;
+	opts.prefix =3D prefix;
=20
 	argc =3D parse_options(argc, argv, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
@@ -639,6 +667,12 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
 	if (!opts.new_branch && (opts.track !=3D git_branch_track))
 		die("git checkout: --track and --no-track require -b");
=20
+	if (((opts.all_path ? 1 : 0) +
+	     (opts.new_path ? 1 : 0) +
+	     (opts.add_path ? 1 : 0) +
+	     (opts.remove_path ? 1 : 0)) > 1)
+		die("git checkout: --reset-path, --full, --add-path and --remove-pat=
h are incompatible");
+
 	if (opts.force && opts.merge)
 		die("git checkout: -f and -m are incompatible");
=20
@@ -732,6 +766,9 @@ no_reference:
 		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
 			die("git checkout: --ours/--theirs, --force and --merge are incompa=
tible when\nchecking out of the index.");
=20
+		if (opts.all_path || opts.new_path || opts.add_path || opts.remove_p=
ath)
+			die("git checkout: updating paths is incompatible with setting spar=
se checkout");
+
 		return checkout_paths(source_tree, pathspec, &opts);
 	}
=20
diff --git a/t/t2011-checkout-sparse.sh b/t/t2011-checkout-sparse.sh
new file mode 100755
index 0000000..b5ccfe4
--- /dev/null
+++ b/t/t2011-checkout-sparse.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+
+test_description=3D'sparse checkout'
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
+test_expect_success '--full and --reset-path incompatible' '
+	test_must_fail git checkout --full --reset-path=3Dwork1
+'
+
+test_expect_success 'limit worktree to work1 and work2' '
+	git checkout --reset-path=3Dwork1/:work2/ &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three
+'
+
+test_expect_success 'update worktree to work2 and work3' '
+	git checkout --reset-path=3Dwork2/:work3/ &&
+	! test -f work1/one &&
+	test -f work2/two &&
+	test -f work3/three
+'
+
+test_expect_success 'update narrow prefix with modification' '
+	echo modified >> work2/two &&
+	git checkout --reset-path=3Dwork1/:work2/ &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three &&
+	grep -q modified work2/two
+'
+
+test_expect_success 'update checkout should not lose modification' '
+	! git checkout --reset-path=3Dwork1/:work3/ &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three &&
+	grep -q modified work2/two
+'
+
+test_expect_success 'widen checkout area' '
+	git checkout --add-path=3Dwork3/ &&
+	test -f work1/one &&
+	test -f work2/two &&
+	test -f work3/three
+'
+
+test_expect_success 'narrow checkout area' '
+	git checkout --remove-path=3Dwork3/ &&
+	test -f work1/one &&
+	test -f work2/two &&
+	! test -f work3/three
+'
+
+test_expect_success 'update outside checkout area' '
+	echo one >> work1/one &&
+	git add work1/one &&
+	git commit -m update &&
+	git checkout --reset-path=3Dwork2/ &&
+	git checkout HEAD^ &&
+	git checkout master
+'
+
+test_expect_success 'conflict outside checkout area' '
+	git checkout --add-path=3Dwork1/one -b conflict HEAD~2 &&
+	echo two >> work1/one &&
+	git add work1/one &&
+	git commit -m conflict-update &&
+	git checkout --reset-path=3Dwork2/ master &&
+	test -z "$(git ls-files --sparse work1/one)"
+	git merge conflict
+	test $? =3D 1 &&
+	test -n "$(git ls-files --sparse work1/one)" &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'removal outside checkout area' '
+	git rm work1/one &&
+	git commit -m remove &&
+	git checkout --reset-path=3Dwork2/ HEAD^
+'
+
+test_expect_success 'exit sparse checkout' '
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
