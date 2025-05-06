Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7F280008
	for <git@vger.kernel.org>; Tue,  6 May 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536341; cv=pass; b=suz6u7zZmXCjOYlJMmEs+tSN6QaVTNpepS0hzitUcD3CSRZjpOwpdoaqQ4taRSnk5HyZFKnax1UO7qsin1MI6rqP7rUtlTjf7VXNSK9KeNguQbGWdY6P/hURCEeGL5nx+K7evA1xtRvMmDCSz3BnLbLZzBUQEqiNlZdEpUBn2ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536341; c=relaxed/simple;
	bh=SfoWvpS31migN/o5VB02pkS6Z0iXydR9u3RMDfqueJg=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=d/sNIfrvoLupWope5ZW9CU2/C/X0ICCuAfleE6fpJD5tykK0uyv4xFYbmno1AJy0PkvrOgcqFHbuSoYMPrsWXBoOi/sl3OT3tyVgwWy6bNBwqM4jPjuffvBmGx0STlhiTTwdFwK0jWX0/Y0YvoV8JUuJKAy+x5bNvRzOTwSKgt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=s1s5De0P; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="s1s5De0P"
ARC-Seal: i=1; a=rsa-sha256; t=1746536335; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y2TeVMGHjX0wxl2WOfh/i/GeD5OxRK06DU0gWbZ9lwWuyH94lyG0UX0m3H9sdZGLKoXnL70jPNJL4OVF/KjhHCPeardlEsXaIcLDffdBQ8pzisymi5Wq5n6cc9V9lOc6MhgS+d2SS+4w2SgsnKjT+7CrZafAFDTn49TOtt66S9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746536335; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=IQIzAMBR/MbKCwbkOTHpaUHfFUtw1c5LmevQjFdNMig=; 
	b=FNOsH5cSiyibwYRXBOra+7iLFfuKpvJO+zKa+Se4PSs3HFU71aET/mVU6KIhF+32HTErZjS6eVbLv0EkqXKLQcjm0kwG8In85UJia3qMoiOcKxnULuMt+0/jw/u2hXRH4gWu6bTSp2ulrjVY8jXq/xXg9pjVuvnxv9Gfh9m+Pvo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746536335;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=IQIzAMBR/MbKCwbkOTHpaUHfFUtw1c5LmevQjFdNMig=;
	b=s1s5De0PJbxyku5FTmXvpJU/co83jtxOc1QoDekGYpzrLdJYRM9DTZXE9i+EoYgJ
	5zcvgHo3Z5pNQMUmIhsAxE/J/D5tB00L69aBf2ezcLAlzEOYpy8+yHGAtkGVZhvD/Ia
	tQyvI+I0Anq9tUyKZO4Z5WNKP3alt2v42fdmEYpc=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1746536333341251.1934622106935; Tue, 6 May 2025 05:58:53 -0700 (PDT)
Date: Tue, 06 May 2025 20:58:53 +0800
From: Li Chen <me@linux.beauty>
To: "git" <git@vger.kernel.org>
Message-ID: <196a5ad7fff.c587c495188189.5980390754046003962@linux.beauty>
In-Reply-To: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
Subject: [RFC PATCH 2/2] rebase: support --trailer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

From: Li Chen <chenl311@chinatelecom.cn>

Implement a new `--trailer <text>` option for `git rebase`
(support merge backend only now), which appends arbitrary
trailer lines to each rebased commit message. Reject early
if used with the apply backend (git am) since it lacks
message=E2=80=91filter/trailer hook. Automatically set REBASE_FORCE when
any trailer is supplied.

Reviewed-by: Li Chen <chenl311@chinatelecom.cn>
---
 Documentation/git-rebase.adoc |   8 +++
 builtin/rebase.c              |  70 ++++++++++++++++++++++
 sequencer.c                   |  13 ++++
 sequencer.h                   |   2 +
 t/meson.build                 |   1 +
 t/t3440-rebase-trailer.sh     | 108 ++++++++++++++++++++++++++++++++++
 6 files changed, 202 insertions(+)
 create mode 100755 t/t3440-rebase-trailer.sh

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 1f3d152035..757016e529 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -525,6 +525,14 @@ See also INCOMPATIBLE OPTIONS below.
 =09Append a `Reviewed-by:` trailer whose value is taken from the
 =09current committer identity, exactly like `--signoff` appends a
 =09Signed-off-by:` trailer.
+
+--trailer <trailer>::
+       Append the given trailer line(s) to every rebased commit
+       message, processed via linkgit:git-interpret-trailers[1].
+       When this option is present *rebase automatically enables*
+       `--force-rebase` so that fast=E2=80=91forwarded commits are also
+       rewritten.
+
 See also INCOMPATIBLE OPTIONS below.
=20
 -i::
diff --git a/builtin/rebase.c b/builtin/rebase.c
index b288aedfb1..df65a1e040 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -36,6 +36,9 @@
 #include "reset.h"
 #include "trace2.h"
 #include "hook.h"
+#include "trailer.h"
+
+static const char trailer_state_name[] =3D "trailer";
=20
 static char const * const builtin_rebase_usage[] =3D {
 =09N_("git rebase [-i] [options] [--exec <cmd>] "
@@ -46,6 +49,8 @@ static char const * const builtin_rebase_usage[] =3D {
 =09NULL
 };
=20
+static struct strvec trailer_args =3D STRVEC_INIT;
+
 static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
 static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
 static GIT_PATH_FUNC(apply_dir, "rebase-apply")
@@ -114,6 +119,7 @@ struct rebase_options {
 =09char *reflog_action;
 =09int signoff;
 =09int reviewby;
+=09struct strvec trailer_args;
 =09int allow_rerere_autoupdate;
 =09int keep_empty;
 =09int autosquash;
@@ -144,6 +150,7 @@ struct rebase_options {
 =09=09.flags =3D REBASE_NO_QUIET, =09=09\
 =09=09.git_am_opts =3D STRVEC_INIT,=09=09\
 =09=09.exec =3D STRING_LIST_INIT_NODUP,=09=09\
+=09=09.trailer_args =3D STRVEC_INIT,  \
 =09=09.git_format_patch_opt =3D STRBUF_INIT,=09\
 =09=09.fork_point =3D -1,=09=09=09\
 =09=09.reapply_cherry_picks =3D -1,             \
@@ -167,6 +174,7 @@ static void rebase_options_release(struct rebase_option=
s *opts)
 =09free(opts->strategy);
 =09string_list_clear(&opts->strategy_opts, 0);
 =09strbuf_release(&opts->git_format_patch_opt);
+=09strvec_clear(&opts->trailer_args);
 }
=20
 static struct replay_opts get_replay_opts(const struct rebase_options *opt=
s)
@@ -179,6 +187,10 @@ static struct replay_opts get_replay_opts(const struct=
 rebase_options *opts)
=20
 =09replay.signoff =3D opts->signoff;
 =09replay.reviewby =3D opts->reviewby;
+
+=09for (size_t i =3D 0; i < opts->trailer_args.nr; i++)
+        strvec_push(&replay.trailer_args, opts->trailer_args.v[i]);
+
 =09replay.allow_ff =3D !(opts->flags & REBASE_FORCE);
 =09if (opts->allow_rerere_autoupdate)
 =09=09replay.allow_rerere_auto =3D opts->allow_rerere_autoupdate;
@@ -437,6 +449,8 @@ static int read_basic_state(struct rebase_options *opts=
)
 =09struct strbuf head_name =3D STRBUF_INIT;
 =09struct strbuf buf =3D STRBUF_INIT;
 =09struct object_id oid;
+=09struct strbuf t =3D STRBUF_INIT, one =3D STRBUF_INIT;
+=09const char *path =3D state_dir_path(trailer_state_name, opts);
=20
 =09if (!read_oneliner(&head_name, state_dir_path("head-name", opts),
 =09=09=09   READ_ONELINER_WARN_MISSING) ||
@@ -509,6 +523,22 @@ static int read_basic_state(struct rebase_options *opt=
s)
=20
 =09strbuf_release(&buf);
=20
+=09if (strbuf_read_file(&t, path, 0) >=3D 0) {
+=09=09const char *p =3D t.buf, *end =3D t.buf + t.len;
+
+=09=09while (p < end) {
+=09=09=09const char *nl =3D memchr(p, '\n', end - p);
+=09=09=09strbuf_reset(&one);
+=09=09=09strbuf_add(&one, p, nl ? nl - p : end - p);
+=09=09=09if (one.len) /* skip empty line */
+=09=09=09=09strvec_push(&opts->trailer_args,
+=09=09=09=09=09    strbuf_detach(&one, NULL));
+=09=09=09p =3D nl ? nl + 1 : end;
+=09=09}
+=09=09strbuf_release(&one);
+=09}
+=09strbuf_release(&t);
+
 =09return 0;
 }
=20
@@ -537,6 +567,28 @@ static int rebase_write_basic_state(struct rebase_opti=
ons *opts)
 =09if (opts->reviewby)
 =09=09write_file(state_dir_path("reviewby", opts), "--reviewby");
=20
+    /*
+     * save opts->trailer_args into state_dir/trailer
+     */
+    if (opts->trailer_args.nr) {
+            struct strbuf buf =3D STRBUF_INIT;
+            size_t i;
+
+            for (i =3D 0; i < opts->trailer_args.nr; i++) {
+                    strbuf_addstr(&buf, opts->trailer_args.v[i]);
+                    strbuf_addch(&buf, '\n');
+            }
+            write_file(state_dir_path(trailer_state_name, opts),
+                       "%s", buf.buf);
+            strbuf_release(&buf);
+    } else {
+            /*
+             * but if rebase doesn't pass any --trailer=EF=BC=8C
+             * and state dir still have residual files=EF=BC=8Clet's delet=
e it=E3=80=82
+             */
+            unlink_or_warn(state_dir_path(trailer_state_name, opts));
+    }
+
 =09return 0;
 }
=20
@@ -1140,6 +1192,7 @@ int cmd_rebase(int argc,
 =09=09=09.flags =3D PARSE_OPT_NOARG,
 =09=09=09.defval =3D REBASE_DIFFSTAT,
 =09=09},
+=09=09OPT_PASSTHRU_ARGV(0, "trailer", &trailer_args, N_("trailer"), N_("ad=
d custom trailer(s)"), PARSE_OPT_NONEG),
 =09=09OPT_BOOL(0, "signoff", &options.signoff,
 =09=09=09 N_("add a Signed-off-by trailer to each commit")),
 =09=09OPT_BOOL(0, "reviewby", &options.reviewby,
@@ -1292,6 +1345,13 @@ int cmd_rebase(int argc,
 =09=09=09     builtin_rebase_options,
 =09=09=09     builtin_rebase_usage, 0);
=20
+    for (i =3D 0; i < trailer_args.nr; i++)
+ =09   strvec_push(&options.trailer_args, trailer_args.v[i]);
+
+    /* if add --trailer=EF=BC=8Cforce rebase */
+    if (options.trailer_args.nr)
+=09=09   options.flags |=3D REBASE_FORCE;
+
 =09if (preserve_merges_selected)
 =09=09die(_("--preserve-merges was replaced by --rebase-merges\n"
 =09=09=09"Note: Your `pull.rebase` configuration may also be set to 'prese=
rve',\n"
@@ -1549,6 +1609,16 @@ int cmd_rebase(int argc,
 =09if (options.root && !options.onto_name)
 =09=09imply_merge(&options, "--root without --onto");
=20
+=09/*
+=09 * The apply=E2=80=91based backend (git=C2=A0am) cannot append trailers=
 because
+=09 * it lacks a message=E2=80=91filter facility.  Reject early, before an=
y
+=09 * state (index, HEAD,=C2=A0etc.) is modified.
+=09 */
+=09if (options.type =3D=3D REBASE_APPLY && options.trailer_args.nr)
+=09=09die(_("the --apply backend (git am) cannot currently handle "
+=09=09      "--trailer; please omit --apply or use "
+=09=09      "the merge/interactive backend"));
+
 =09if (isatty(2) && options.flags & REBASE_NO_QUIET)
 =09=09strbuf_addstr(&options.git_format_patch_opt, " --progress");
=20
diff --git a/sequencer.c b/sequencer.c
index 01933882ed..b61c668c39 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -429,6 +429,7 @@ void replay_opts_release(struct replay_opts *opts)
 =09free(opts->revs);
 =09replay_ctx_release(ctx);
 =09free(opts->ctx);
+=09strvec_clear(&opts->trailer_args);
 }
=20
 int sequencer_remove_state(struct replay_opts *opts)
@@ -2506,6 +2507,18 @@ static int do_pick_commit(struct repository *r,
 =09=09=09_("dropping %s %s -- patch contents already upstream\n"),
 =09=09=09oid_to_hex(&commit->object.oid), msg.subject);
 =09} /* else allow =3D=3D 0 and there's nothing special to do */
+
+    if (!res && opts->trailer_args.nr && !drop_commit) {
+            const char *trailer_file =3D
+                    msg_file ? msg_file : git_path_merge_msg(r);
+
+            if (amend_file_with_trailers(trailer_file,
+                                         &opts->trailer_args)) {
+                    res =3D error(_("unable to add trailers to commit mess=
age"));
+                    goto leave;
+            }
+    }
+
 =09if (!opts->no_commit && !drop_commit) {
 =09=09if (author || command =3D=3D TODO_REVERT || (flags & AMEND_MSG))
 =09=09=09res =3D do_commit(r, msg_file, author, opts, flags,
diff --git a/sequencer.h b/sequencer.h
index 82b79fd1e8..4f5ea2d818 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -46,6 +46,7 @@ struct replay_opts {
 =09int no_commit;
 =09int signoff;
 =09int reviewby;
+=09struct strvec trailer_args;
 =09int allow_ff;
 =09int allow_rerere_auto;
 =09int allow_empty;
@@ -88,6 +89,7 @@ struct replay_opts {
 =09.action =3D -1,=09=09=09=09\
 =09.xopts =3D STRVEC_INIT,=09=09=09\
 =09.ctx =3D replay_ctx_new(),=09=09\
+=09.trailer_args =3D STRVEC_INIT, \
 }
=20
 /*
diff --git a/t/meson.build b/t/meson.build
index 327fa461fd..fc4b64fca1 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -393,6 +393,7 @@ integration_tests =3D [
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
   't3439-rebase-reviewby.sh',
+  't3440-rebase-trailer.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
new file mode 100755
index 0000000000..6dc08e9633
--- /dev/null
+++ b/t/t3440-rebase-trailer.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+#
+
+test_description=3D'git rebase --trailer integration tests
+We verify that --trailer on the merge/interactive/exec/root backends,
+and that it is rejected early when the apply backend is requested.'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh       # test_commit_message, helpers
+
+##########################################################################=
##
+# 1.  repository setup
+##########################################################################=
##
+
+test_expect_success 'setup repo with a small history' '
+=09git commit --allow-empty -m "Initial empty commit" &&
+=09test_commit first   file a &&
+=09test_commit second  file &&
+=09git checkout -b conflict-branch first &&
+=09test_commit file-2  file-2 &&
+=09test_commit conflict file &&
+=09test_commit third   file &&
+=09ident=3D"$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+'
+
+create_expect () {
+=09cat >"$1" <<-EOF
+=09$2
+
+=09Reviewed-by: Dev <dev@example.com>
+=09EOF
+}
+# golden files:
+create_expect initial-signed  "Initial empty commit"
+create_expect first-signed    "first"
+create_expect second-signed   "second"
+create_expect file2-signed    "file-2"
+create_expect third-signed    "third"
+create_expect conflict-signed "conflict"
+
+##########################################################################=
##
+# 2.  explicitly reject --apply + --trailer
+##########################################################################=
##
+
+test_expect_success 'apply backend is rejected when --trailer is given' '
+=09git reset --hard third &&
+=09git tag before-apply &&
+=09test_expect_code 128 \
+=09=09git rebase --apply --trailer "Reviewed-by: Dev <dev@example.com>" \
+=09=09=09HEAD^ &&
+=09git diff --quiet before-apply..HEAD      # prove nothing moved
+'
+
+##########################################################################=
##
+# 3.  --no=E2=80=91op: same range, no changes
+##########################################################################=
##
+
+test_expect_success '--trailer without range change is a no=E2=80=91op' '
+=09git checkout main &&
+=09git tag before-noop &&
+=09git rebase --trailer "Reviewed-by: Dev <dev@example.com>" HEAD &&
+=09git diff --quiet before-noop..HEAD
+'
+
+##########################################################################=
##
+# 4.  merge backend (-m), conflict resolution path
+##########################################################################=
##
+
+test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
+=09git reset --hard third &&
+=09test_must_fail git rebase -m \
+=09=09--trailer "Reviewed-by: Dev <dev@example.com>" \
+=09=09second third &&
+=09git checkout --theirs file &&
+=09git add file &&
+    GIT_EDITOR=3D: git rebase --continue &&
+=09git show --no-patch --pretty=3Dformat:%B HEAD~2 >actual &&
+=09test_cmp file2-signed actual
+'
+
+##########################################################################=
##
+# 5.  --exec path
+##########################################################################=
##
+
+test_expect_success 'rebase --exec --trailer adds trailer' '
+=09test_when_finished "rm -f touched" &&
+=09git rebase --exec "touch touched" \
+=09=09--trailer "Reviewed-by: Dev <dev@example.com>" \
+=09=09first^ first &&
+=09test_path_is_file touched &&
+=09test_commit_message HEAD first-signed
+'
+
+##########################################################################=
##
+# 6.  --root path
+##########################################################################=
##
+
+test_expect_success 'rebase --root --trailer updates every commit' '
+=09git checkout first &&
+=09git rebase --root --keep-empty \
+=09=09--trailer "Reviewed-by: Dev <dev@example.com>" &&
+=09test_commit_message HEAD   first-signed &&
+=09test_commit_message HEAD^  initial-signed
+'
+test_done
--=20
2.49.0


