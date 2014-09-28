From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/32] nd/multiple-work-trees
Date: Sat, 27 Sep 2014 23:35:45 -0700
Message-ID: <xmqqr3yw6ym6.fsf@gitster.dls.corp.google.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
	<1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 08:36:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY85Y-000281-TB
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 08:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbaI1Gfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Sep 2014 02:35:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55736 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbaI1Gfy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Sep 2014 02:35:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E1D238F28;
	Sun, 28 Sep 2014 02:35:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TEhFhFWIFLCh
	jAvXcZxbWSos2p8=; b=lX8qSOxeiEIGfdlYhzPC1/VUysB7ZRfR7fzMjqnQpMDS
	VzkwIl8mrHHAp2ag3v9kwOkUPu6Tb1l8lhiXbdsogNyzQjXFkIPvWXYLie3w1QNl
	kuHrRTc9TnjJjLKb7Xv5UuQCW3uvDzT7yKykzF6x8xw3Id6PvNLAkVEqHNFmQ50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FRPP8z
	QKuGLA4Vex77n/0/W9IPLcgkpooj2hEDL0xGShxaJcrBZy813NenzURLoIh61BRd
	3hL/uMUXzEbwAwm2rLkTD8T1SLukyQz+KuSJ96EnbKCtBI0G8rdI6KoL4OPslcNt
	4HSVDjOxBQ87ZZ84voBfgdnAXD1+FxtOSM9Rw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 72BB438F26;
	Sun, 28 Sep 2014 02:35:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D352238F24;
	Sun, 28 Sep 2014 02:35:46 -0400 (EDT)
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 28
 Sep 2014 08:22:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ADFBECAE-46D9-11E4-90F7-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257592>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> On Fri, Sep 26, 2014 at 4:20 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> It has been a while since the last review exchanges were seen. =C2=A0=
Will
>> it be time for v3 soon?
>
> Sorry I've been slow on picking up feedback from v2. v3 is rebased on
> latest master. Other changes are mostly *.txt, and one broken &&
> chain.

As there have been quite a lot of changes in overlapping areas
(e.g. with Ronnie and Jonathan's refs.c clean-up series, and also
with Tanay's config API changes in builtin/gc.c), I agree that it no
longer makes sense to stick to the old fork point.

This applies cleanly to the 'master', the result merges cleanly to
where the old series were merged to 'pu', and the difference between
the old/new "pu^{/^Merge branch 'nd/multiple-work-trees' into pu}"
commits matches what I remember from the review discussion you were
having on the old series with others (attached below for others to
eyeball as a rough substitute for an interdiff).

Thanks.

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 23f0c80..0c13825 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -229,8 +229,8 @@ section of linkgit:git-add[1] to learn how to opera=
te the `--patch` mode.
 	Check out a branch in a separate working directory at
 	`<path>`. A new working directory is linked to the current
 	repository, sharing everything except working directory
-	specific files such as HEAD, index... See "MULTIPLE CHECKOUT
-	MODE" section for more information.
+	specific files such as HEAD, index... See "MULTIPLE WORKING
+	TREES" section for more information.
=20
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
@@ -395,58 +395,66 @@ $ git reflog -2 HEAD # or
 $ git log -g -2 HEAD
 ------------
=20
-MULTIPLE CHECKOUT MODE
+MULTIPLE WORKING TREES
 ----------------------
-Normally a working directory is attached to repository. When "git
-checkout --to" is used, a new working directory is attached to the
-current repository. This new working directory is called "linked
-checkout" as compared to the "main checkout" prepared by "git init" or
-"git clone". A repository has one main checkout and zero or more
-linked checkouts.
-
-Each linked checkout has a private directory in $GIT_DIR/worktrees in
-the main checkout, usually named after the base name of the new
-working directory, optionally with a number added to make it
-unique. For example, the command `git checkout --to ../test-next next`
-running with $GIT_DIR=3D/path/main may create the directory
-`$GIT_DIR/worktrees/test-next` (or `$GIT_DIR/worktrees/test-next1` if
-`test-next` is already taken).
-
-Within a linked checkout, $GIT_DIR is set to point to this private
-directory (e.g. `/path/main/worktrees/test-next` in the example) and
-$GIT_COMMON_DIR is set to point back to the main checkout's $GIT_DIR
-(e.g. `/path/main`). Setting is done via a .git file located at the
-top directory of the linked checkout.
-
-Path resolution via `git rev-parse --git-path` would use either
-$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, the
-linked checkout's `$GIT_DIR/HEAD` resolve to
-`/path/main/worktrees/test-next/HEAD` (not `/path/main/HEAD` which is
-the main checkout's HEAD) while `$GIT_DIR/refs/heads/master` would use
-$GIT_COMMON_DIR and resolve to `/path/main/refs/heads/master`, which
-is shared across checkouts.
+
+A git repository can support multiple working trees, allowing you to c=
heck
+out more than one branch at a time.  With `git checkout --to` a new wo=
rking
+tree is associated with the repository.  This new working tree is call=
ed a
+"linked working tree" as opposed to the "main working tree" prepared b=
y "git
+init" or "git clone".  A repository has one main working tree (if it's=
 not a
+bare repository) and zero or more linked working trees.
+
+Each linked working tree has a private sub-directory in the repository=
's
+$GIT_DIR/worktrees directory.  The private sub-directory's name is usu=
ally
+the base name of the linked working tree's path, possibly appended wit=
h a
+number to make it unique.  For example, when `$GIT_DIR=3D/path/main/.g=
it` the
+command `git checkout --to /path/other/test-next next` creates the lin=
ked
+working tree in `/path/other/test-next` and also creates a
+`$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-=
next1`
+if `test-next` is already taken).
+
+Within a linked working tree, $GIT_DIR is set to point to this private
+directory (e.g. `/path/main/.git/worktrees/test-next` in the example) =
and
+$GIT_COMMON_DIR is set to point back to the main working tree's $GIT_D=
IR
+(e.g. `/path/main/.git`). These settings are made in a `.git` file loc=
ated at
+the top directory of the linked working tree.
+
+Path resolution via `git rev-parse --git-path` uses either
+$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
+linked working tree `git rev-parse --git-path HEAD` returns
+`/path/main/.git/worktrees/test-next/HEAD` (not
+`/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `gi=
t
+rev-parse --git-path refs/heads/master` uses
+$GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
+since refs are shared across all working trees.
=20
 See linkgit:gitrepository-layout[5] for more information. The rule of
 thumb is do not make any assumption about whether a path belongs to
 $GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
 inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
=20
-When you are done, simply deleting the linked working directory would
-suffice. $GIT_DIR/worktrees can be cleaned up using `git prune
---worktrees`, which is part of automated garbage collection.
-
-After you move a linked working directory to another file system, or
-on a file system that does not support hard link, execute any git
-command (e.g. `git status`) in the new working directory so that it
-could update its location in $GIT_DIR/worktrees and not be
-accidentally pruned.
-
-To stop `git prune --worktrees` from deleting a specific working
-directory (e.g. because it's on a portable device), you could add the
-file 'locked' to $GIT_DIR/worktrees. For example, if `.git` file of
-the new working directory points to `/path/main/worktrees/test-next`,
-the full path of the 'locked' file would be
-`/path/main/worktrees/test-next/locked`. See
+When you are done with a linked working tree you can simply delete it.
+The working tree's entry in the repository's $GIT_DIR/worktrees
+directory will eventually be removed automatically (see
+`gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
+`git prune --worktrees` in the main or any linked working tree to
+clean up any stale entries in $GIT_DIR/worktrees.
+
+If you move a linked working directory to another file system, or
+within a file system that does not support hard links, you need to run
+at least one git command inside the linked working directory
+(e.g. `git status`) in order to update its entry in $GIT_DIR/worktrees
+so that it does not get automatically removed.
+
+To prevent a $GIT_DIR/worktrees entry from from being pruned (which
+can be useful in some situations, such as when the
+entry's working tree is stored on a portable device), add a file named
+'locked' to the entry's directory. The file contains the reason in
+plain text. For example, if a linked working tree's `.git` file points
+to `/path/main/.git/worktrees/test-next` then a file named
+`/path/main/.git/worktrees/test-next/locked` will prevent the
+`test-next` entry from being pruned.  See
 linkgit:gitrepository-layout[5] for details.
=20
 EXAMPLES
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index a0ea381..1cf3bed 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -49,7 +49,7 @@ OPTIONS
 	Only expire loose objects older than <time>.
=20
 --worktrees::
-	Prune dead worktree information in $GIT_DIR/worktrees.
+	Prune dead working tree information in $GIT_DIR/worktrees.
=20
 <head>...::
 	In addition to objects
diff --git a/builtin/gc.c b/builtin/gc.c
index 125f0dd..35542f3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -57,12 +57,14 @@ static void remove_pidfile_on_signal(int signo)
 	raise(signo);
 }
=20
-static void git_config_get_date_string(const char *var, const char **o=
ut)
+static void git_config_date_string(const char *key, const char **outpu=
t)
 {
-	if (!git_config_get_string_const(var, out) && strcmp(*out, "now")) {
+	if (git_config_get_string_const(key, output))
+		return;
+	if (strcmp(*output, "now")) {
 		unsigned long now =3D approxidate("now");
-		if (approxidate(*out) >=3D now)
-			git_die_config(var, _("Invalid %s: '%s'"), var, *out);
+		if (approxidate(*output) >=3D now)
+			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
 	}
 }
=20
@@ -82,8 +84,8 @@ static void gc_config(void)
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
-	git_config_get_date_string("gc.pruneexpire", &prune_expire);
-	git_config_get_date_string("gc.pruneworktreesexpire", &prune_worktree=
s_expire);
+	git_config_date_string("gc.pruneexpire", &prune_expire);
+	git_config_date_string("gc.pruneworktreesexpire", &prune_worktrees_ex=
pire);
 	git_config(git_default_config, NULL);
 }
=20
diff --git a/refs.c b/refs.c
index c4850f5..33ac01c 100644
--- a/refs.c
+++ b/refs.c
@@ -2935,12 +2935,14 @@ static int log_ref_write(const char *refname, c=
onst unsigned char *old_sha1,
 		error("Unable to append to %s", log_file);
 		errno =3D save_errno;
 		result =3D -1;
+		goto done;
 	}
 	if (close(logfd)) {
 		int save_errno =3D errno;
 		error("Unable to append to %s", log_file);
 		errno =3D save_errno;
 		result =3D -1;
+		goto done;
 	}
 done:
 	strbuf_release(&sb_log_file);
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 27384a1..eddd325 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -49,7 +49,7 @@ test_expect_success 'checkout --to a new worktree fro=
m a subdir' '
 test_expect_success 'checkout --to from a linked checkout' '
 	(
 		cd here &&
-		git checkout --detach --to nested-here master
+		git checkout --detach --to nested-here master &&
 		cd nested-here &&
 		git fsck
 	)
diff --git a/wrapper.c b/wrapper.c
index 6f40341..e821d05 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -531,6 +531,14 @@ struct passwd *xgetpwuid_self(void)
 	return pw;
 }
=20
+char *xgetcwd(void)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	if (strbuf_getcwd(&sb))
+		die_errno(_("unable to get current working directory"));
+	return strbuf_detach(&sb, NULL);
+}
+
 int write_file(const char *path, int fatal, const char *fmt, ...)
 {
 	struct strbuf sb =3D STRBUF_INIT;
@@ -561,11 +569,3 @@ int write_file(const char *path, int fatal, const =
char *fmt, ...)
 	}
 	return 0;
 }
-
-char *xgetcwd(void)
-{
-	struct strbuf sb =3D STRBUF_INIT;
-	if (strbuf_getcwd(&sb))
-		die_errno(_("unable to get current working directory"));
-	return strbuf_detach(&sb, NULL);
-}
