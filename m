Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD05FC61DA4
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 20:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCKUr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 15:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCKUrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 15:47:25 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E12969CE6
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 12:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1678567635; i=l.s.r@web.de;
        bh=L0rhI6oNYBxxyOFTblFVGcfL7RN3P8tfDN/8ALBMmo0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=diqrbJt0ILpktfE2lZ33WJvNUH0sbtVAyvTgytCzEj/8TaOyeLe7iKiUOBoha8fQP
         /rfeOne4+XkHR5x+X64u84dFmiyVkGbv23ohgviOUaAKFrTeegQRGdisutaA6qq3no
         26oBrCJ+BUqUit9PeVUAJ2OQt9PIvTfem/6uBfTMxAXnEcrygBf/H9zHGoxvBUS35T
         52DsVcPSensekXjkPn2wefFQM5jaxAErEsYp6OINn50xeE81C/dZV5pF9te0W7hBxR
         +EoUk+zUXPN7lUsm8UIexNx/LgPnztmoAdsa40yOqFsL3A3Kvl7uLlyGyTaUl8znjP
         aXy23CjwmHEjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6bCu-1qc7LB2IBS-018NAT; Sat, 11
 Mar 2023 21:47:15 +0100
Message-ID: <f7949f1b-4bad-e1bf-4754-f8b79e3ce279@web.de>
Date:   Sat, 11 Mar 2023 21:47:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: Bug in git archive + .gitattributes + relative path
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org,
        =?UTF-8?Q?Matthias_G=c3=b6rgens?= <matthias.goergens@gmail.com>
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
 <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
 <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
 <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de> <xmqqcz5lbxiq.fsf@gitster.g>
 <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de> <xmqqo7p59049.fsf@gitster.g>
 <3da35216-ca42-9759-d4f9-20451a44c231@web.de> <xmqq4jqx8q6q.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq4jqx8q6q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bZqlwRpbmXI9fIFwlh9H5l+CzuFoyerWaRCbylzZXlR1nC/wNjO
 zJqg3azoZkDrVcH1EBDlyCFswAVxVznI0d6Gq36bn7HWp6EieGE4rkwCqOIA9PFPOpRg+hT
 xlvjkAXDNBGb2mO5r+XXv57Kb+8ped7+SQlISFDtebE7oeCV1AJVs6ugJPBypiY4zZGXmcL
 MuehSPhnxMk4gdtFd+kZg==
UI-OutboundReport: notjunk:1;M01:P0:8gSIoT4ZK8A=;Q2qfWDNmccfqgI/Jwm7sUr1iA3X
 atz0iy0LFalWsimxm8QdMlMqjwuQX0K7rR9OMS1hFwY6ccK6nIBOPdO/5X5YIk/jpdbNojAXO
 q+6HZeYQWao1GKACjgTK/gxgnA9ZI1762yLIsByRqU50wbRXryCMwScojHIk6uthYL2VGRoNc
 6i7FB9ucaevX3/Ddyq6bQLd8Pn4gCrsBH7WtfIJIYq0aBNcFUgITbxyEz9WArvBJ0a02fhvOn
 P9z47JfrAXLVFNG6AjCnSfWvJhpEAH9nPgmZ4v2/A/hyhHKZi2kmMjpMVmarE7ddvuQ9cc0gU
 2kHmdGImvrI3vpmifs45sFefLBEA8KDr8/g19QLSgqAVB09rm3exnAeIcG6TRD5T53RQ+BocQ
 NC7EF99LdZ0W4UrmvHYaHtbmnAUZf7TaxIzk0VjTMgQfdp2RU6K8//9LxVkHieZL0ZdL37eVE
 V65/sGOQKrSTHesVoDEj0IBRURWNoWrITWPEQWEJC29s6cjx4i0XHyq/Z8vJLENjp9wTaX3jh
 7m+BhFWbbktpTYuJIydr2nmjHVnzgQUxmN1TlNu3itWTsl3Yu2SSuPr9ebspeCsda/PLN2Yn6
 AZ9bGpOLJ61XzhJgJFujnBRIGtDOQul4PqLELyWTDSmXXf6luglcjnUxeKPTZm1aGDT15tLrH
 /DsF2dPa3Nq9p8gWye8ABTXhXuoLx9qrStqeEFWk7ynXCh5gVZUr+yfCPPcE90vUcarQ3mlfp
 c9rHs9qMZEUnFejK0jXwNm97iCqjTnqpcMunDMEVwVmLbKAi8ktdinTtDsxxxFGin8it4Gb8f
 FpYbNyZ1kX2be6UfIU5bKYPpW5zJBTypjQhWOrPoCQqcPkAgN+D1Q97pj6D5hrdw6IwyJGKI7
 CIIZP90d+5l/yXgSD++20a3+LiGcgh9+DSC9WPGkpBz/GIAxGmPWhfRDaEDc5RYQd93r5iJRe
 7nYINA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.03.23 um 23:34 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Neither of them resolves "../$PWD/" parts to "" like git ls-tree does,
>> but I can accept that difference.  And then we'd need to keep leading
>> "../", I suppose.  Still unsure.
>
> I offhand do not know how well it would mix with --strip-components
> if we leave the leading "../".

Not too well when entries from $PWD are shortened and mixed with ones
from elsewhere that aren't.  But that seems like a strange thing to do.
If two sub-trees are needed then git archive should be started in a
shared parent directory higher up.

> But it certainly would be nice if we somehow:
>
>  * can keep the current behaviour where "git -C sub archive" records
>    paths relative to "sub" for backward compatibility.

Right.  That's what relative_path() provides in the patch.

>  * fail loudly when "git -C sub archive <pathspec>" makes us use
>    "../" prefix because <pathspec> goes above the $PWD for backward
>    compatibility and sanity.

Without the patch this fails, but are there really people that depend on
it failing?  We could certainly forbid it, but do we need to?  It costs
a few lines of code (see patch below).

>  * with --some-option, make "git -C sub archive --some-option :/"
>    act exactly like "git archive :/".

Perhaps I'm reading this too literally, but it would be easier to remove
"-C sub" from that command. Or to add "-C $(git rev-parse --show-cdup)".
We could add a shortcut for that (see patch below).

>> And I don't know why PATHSPEC_PREFER_CWD is necessary.

PATHSPEC_PREFER_FULL makes the empty pathspec match everything, while
PATHSPEC_PREFER_CWD makes it match the current working directory, only.
In git archive without these patches both mean the same because we
make the tree of the current working directory the root of our pathspec
worldview.  When we stop doing that it actually makes a difference and
we need the more limited variant.

Ren=C3=A9


 Documentation/git.txt |  4 ++++
 archive.c             | 36 ++++++++++++++++++++++--------------
 git.c                 | 18 ++++++++++++++++++
 t/t0056-git-C.sh      |  6 ++++++
 4 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 74973d3cc4..e254572fec 100644
=2D-- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -73,6 +73,10 @@ example the following invocations are equivalent:
     git --git-dir=3Da.git --work-tree=3Db -C c status
     git --git-dir=3Dc/a.git --work-tree=3Dc/b status

+--cdup::
+	Run as if git was started at the root of the repository or
+	worktree.  Same as `-C $(git rev-parse --show-cdup)`.
+
 -c <name>=3D<value>::
 	Pass a configuration parameter to the command. The value
 	given will override values from configuration files.
diff --git a/archive.c b/archive.c
index c7e9f58b02..6f587876e5 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -396,6 +396,7 @@ static const struct archiver *lookup_archiver(const ch=
ar *name)
 struct path_exists_context {
 	struct pathspec pathspec;
 	struct archiver_args *args;
+	int dotdot;
 };

 static int reject_entry(const struct object_id *oid UNUSED,
@@ -405,35 +406,43 @@ static int reject_entry(const struct object_id *oid =
UNUSED,
 {
 	int ret =3D -1;
 	struct path_exists_context *ctx =3D context;
+	const char *prefix =3D ctx->args->prefix;
+	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf scratch =3D STRBUF_INIT;

+	strbuf_addbuf(&sb, base);
+	strbuf_addstr(&sb, filename);
 	if (S_ISDIR(mode)) {
-		struct strbuf sb =3D STRBUF_INIT;
-		strbuf_addbuf(&sb, base);
-		strbuf_addstr(&sb, filename);
 		if (!match_pathspec(ctx->args->repo->index,
 				    &ctx->pathspec,
 				    sb.buf, sb.len, 0, NULL, 1))
 			ret =3D READ_TREE_RECURSIVE;
-		strbuf_release(&sb);
+	} else {
+		if (starts_with(relative_path(sb.buf, prefix, &scratch), "../"))
+			ctx->dotdot =3D 1;
 	}
+	strbuf_release(&sb);
+	strbuf_release(&scratch);
 	return ret;
 }

-static int path_exists(struct archiver_args *args, const char *prefix,
+static void check_path(struct archiver_args *args, const char *prefix,
 		       const char *path)
 {
 	const char *paths[] =3D { path, NULL };
 	struct path_exists_context ctx;
-	int ret;

 	ctx.args =3D args;
+	ctx.dotdot =3D 0;
 	parse_pathspec(&ctx.pathspec, 0, 0, prefix, paths);
 	ctx.pathspec.recursive =3D 1;
-	ret =3D read_tree(args->repo, args->tree,
-			&ctx.pathspec,
-			reject_entry, &ctx);
+	if (!read_tree(args->repo, args->tree, &ctx.pathspec,
+		       reject_entry, &ctx))
+		die(_("pathspec '%s' did not match any files"), path);
+	if (ctx.dotdot)
+		die(_("pathspec '%s' matches files above current directory"),
+		    path);
 	clear_pathspec(&ctx.pathspec);
-	return ret !=3D 0;
 }

 static void parse_pathspec_arg(const char **pathspec, const char *prefix,
@@ -445,7 +454,7 @@ static void parse_pathspec_arg(const char **pathspec, =
const char *prefix,
 		pathspec =3D match_all;

 	/*
-	 * must be consistent with parse_pathspec in path_exists()
+	 * must be consistent with parse_pathspec in check_path()
 	 * Also if pathspec patterns are dependent, we're in big
 	 * trouble as we test each one separately
 	 */
@@ -455,9 +464,8 @@ static void parse_pathspec_arg(const char **pathspec, =
const char *prefix,
 	ar_args->pathspec.recursive =3D 1;
 	if (pathspec) {
 		while (*pathspec) {
-			if (**pathspec &&
-			    !path_exists(ar_args, prefix, *pathspec))
-				die(_("pathspec '%s' did not match any files"), *pathspec);
+			if (**pathspec)
+				check_path(ar_args, prefix, *pathspec);
 			pathspec++;
 		}
 	}
diff --git a/git.c b/git.c
index 6171fd6769..22993991a9 100644
=2D-- a/git.c
+++ b/git.c
@@ -293,6 +293,24 @@ static int handle_options(const char ***argv, int *ar=
gc, int *envchanged)
 			}
 			(*argv)++;
 			(*argc)--;
+		} else if (!strcmp(cmd, "--cdup")) {
+			struct child_process cp =3D CHILD_PROCESS_INIT;
+			struct strbuf out =3D STRBUF_INIT;
+			struct strbuf err =3D STRBUF_INIT;
+
+			cp.git_cmd =3D 1;
+			strvec_pushl(&cp.args, "rev-parse", "--show-cdup", NULL);
+			if (pipe_command(&cp, NULL, 0, &out, 0, &err, 0)) {
+				strbuf_trim_trailing_newline(&err);
+				if (err.len)
+					die("%s", err.buf);
+				die(_("unable to get repo root or worktree"));
+			}
+			strbuf_trim_trailing_newline(&out);
+			if (out.len && chdir(out.buf))
+				die_errno(_("cannot change to '%s'"), out.buf);
+			strbuf_release(&out);
+			strbuf_release(&err);
 		} else if (skip_prefix(cmd, "--list-cmds=3D", &cmd)) {
 			trace2_cmd_name("_query_");
 			if (!strcmp(cmd, "parseopt")) {
diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
index 752aa8c945..95107d724e 100755
=2D-- a/t/t0056-git-C.sh
+++ b/t/t0056-git-C.sh
@@ -92,4 +92,10 @@ test_expect_success 'Relative followed by fullpath: "-C=
 ./here -C /there" is equ
 	test_cmp expected actual
 '

+test_expect_success '"--cdup" goes back' '
+	git status >expected &&
+	git -C c --cdup status >actual &&
+	test_cmp expected actual
+'
+
 test_done
