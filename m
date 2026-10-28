Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146536;
	b=3vJUO9nEoyOqPlzXB+7wZjRIPAUTzA54eXdS/eescNyNxR0jTVvP5TUVRsXVxA5qh4m/
	 mybVKr4KCFjmt3E1yAHVWDspojT1s3FBK/SHajipjrXG2E26aeFOEYjuVdHu3X8vk3o/P
	 j7dxlALD/dpfz2EUWyBogOVXN9tVaqwvVKiuDGr/pKW2PmBkukJpoe3Kf5E0bEA1Ztsr8
	 eHykH+le48e+FhJzRU0pn0siHbDGgd9ip2L8Y3ffDGD8NAgRZwWw9jlBKgWjVnGRMx56e
	 A+mHD8ErLIkO0Xmh492KfFghRF4QNeTk68KFaMvn6MoP4GZnx0GYEU/Gu5y9BfpT3Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AeQZu3zAiwhYNwpxU//S/PsZFl/8aQLyBAngbo05SXM=;
	b=FPVBxagPRZL3FZxKcZ5LdV/GHjEICUfOW2JuA3ULTVQLYXym0wNBQZ/+4oIG/bmCxpMq
	 hGUG/rLJybsV//ah6ZgTFFj37ZpWtLELtQtO8jasDfCoCt+vpDBb3lszULFFzsHbH3c2s
	 r1XJcFyTlUt/AXHWwv0Ku+K/JH4ak1cpGbAR8/z+iBkb/tcACi3hMNfWZxk2qmkclXUZM
	 BZoEV+ilX7c2yiCvUVlymsEE2V6n2KvXiPC9aax9Q52Jw2sR6gYEBUJ00OteKYOvb53Qy
	 uVqhsYQfkio9/9TYnS8WonH5S5eShtDx5FA552jWDkQzj1bUEBZweuiVmO/RfTgBKpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sy0J8e2Y;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F97606A338
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 00:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F97606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sy0J8e2Y
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c73c63116so5080326d6.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793146535; x=1793751335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AeQZu3zAiwhYNwpxU//S/PsZFl/8aQLyBAngbo05SXM=;
        b=sy0J8e2YjIo+yVeg+a8zfr2Msc/It21qpZin8pFIeHkpLiHRU1Nq1YWZj5snZbmw5V
         7vU7X5o11WmJgTU5KTqepFqEHp7et0uZmfCZ0F4fqrFNbYWgCTbkOJdviaIZL/YD8nMG
         l+KR07lFlyHzOiUEhyGxd0rCnyAFsLpHrR4Dd3whHrY75nT0RC9lmYvywpcBgQEuljmB
         uXdYilCCqqbRiaXYHJsMMXUO9ylHxLFWghUMcE6H5at95EiprXxBB+bDS/A8/u7cDrwd
         3zfnY+QtS6luCwVzwImgz3tqfOhbyl3A6ZpzP7AO2D1/QfmjVypyVnVo5cwcO8dkzEa6
         eLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793146535; x=1793751335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AeQZu3zAiwhYNwpxU//S/PsZFl/8aQLyBAngbo05SXM=;
        b=XGFe4HtlfHySkRh7Mn9zyIM+exrfl+VX4jfO9FbnQhZfWh4o3tOqo2g8AlGPiJqvRY
         7iSlaFrXU8VXBeRnmYLnI3Zoevnkzcy4MgSQwPbkybKbM/59+VZ3aZjpst8zSu5dtZhM
         volXg5iyttCi6qgGAqTBOKG4d07j4YoaYnrib3HY9LQllRCn3edEvHIjWiSk68TeEoX7
         5HifZkF6qdz3mZRllNJP36bIZKnGblU8ieS7pirqF6SZv9LDPLif+9HK7mOhZDX/tqwO
         M9v/kgvKzGkH9/3h4V7k1ZYYYffplR9hTqVSAcKXAdxrJ6yVki+4FcUfaNlrWr36y40q
         IMuA==
X-Gm-Message-State: AFq9FYKBgT4C9F1dH8lqZKz0hFz6iENn+JQVyFAYINLvVCTPoNlJoZ36
	ByEXzbnl+Mk5u7ARa2TBu4mzby7kDK+za88YxVa6u82PWIYDjELWHc+au6wkYA==
X-Gm-Gg: AYBFou2pAAFjicjtIksyNDXe+ChufAWpRwS8ciSwifr8n2m6GG7HsM/y50x+ux198Vm
	hvv1LYh48vFDNCKCcRk06FqMPTMKkeSTSRS8a6ztIxkVxB36wSw3xzscd8ItEbMSDJw8nTTG7xS
	pVSK+HlroQEGIscArIrnJtOXICZvOiG5dDnC/laL6/ehga58WH4V2PMD4QDZErmJnxrUz8tCC9R
	MNRiDj1h//gTWbHChN7NKPGD0sL4mKXB9EVlnlE+CclqDiS+DCT3Ef1eFdoavKrq9XcroGRo57o
	VNQ+BTcR2xtSVRq0aQVVW7W0Ry3wb+yoKPWBPS6RIs1ztfY3Vwzzvf9CL8pT71lDH7n9jWi7u6a
	fybf6NBDd1VxudYlG6vGKhHgp8/curXqhKyQrBBdQ1l+Ha8KQTxtkLr3u8RYg3vNF0qt7p1RFE3
	2NcMVlbVxl3xHVaj7TTqlPZ5HMpcW4R/rLroNslJKzLgt7eHkHhuVFIMCOWtOQxAQUk4yElPm4T
	DV5xA1MKdw/GECy2pL0We9JnUyjFpd7ofBDVBss6iz+Gs0SkAaxcuiZFWlzf/jdLy2ANAdS1omH
	EagAnJcY2UPG3nPcyqneeUTT5KJYcwZEXvlQ/5V1fmvH7d2QYtugTZbRd/zg9Q==
X-Received: by 2002:ad4:5aaf:0:b0:91b:8272:5157 with SMTP id 6a1803df08f44-91c7cdf5c78mr14162276d6.2.1793146534972;
        Tue, 27 Oct 2026 17:15:34 -0700 (PDT)
Received: from Williams-MBP.internal ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6e20ba4fsm38666656d6.14.2026.10.27.17.15.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 17:15:34 -0700 (PDT)
From: William Hatfield <whatfield.git@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>,
	Glen Choo <glencbz@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	William Hatfield <whatfield.git@gmail.com>
Subject: [PATCH v2 3/3] submodule: add --reversive shorthand to foreach
Date: Tue, 27 Oct 2026 20:15:29 -0400
Message-ID: <20261028001529.81557-4-whatfield.git@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028001529.81557-1-whatfield.git@gmail.com>
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
 <20261028001529.81557-1-whatfield.git@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Visiting each submodule before its superproject, ending with the
top-level superproject, takes all of --recursive, --reverse-traversal
and --include-superproject. Those are three options to remember and to
type for what is, for this purpose, a single thing.

Add --reversive as a shorthand for the three of them. The options keep
working on their own, for the cases that need only one or two of them.

Signed-off-by: William Hatfield <whatfield.git@gmail.com>
---
 Documentation/git-submodule.adoc       | 14 ++++++++++----
 builtin/submodule--helper.c            | 11 ++++++++++-
 contrib/completion/git-completion.bash |  2 +-
 git-submodule.sh                       |  7 ++++++-
 t/t7427-submodule-foreach-reversive.sh | 14 ++++++++++++--
 5 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 5d4b06cb96..8f4bc002cc 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -18,7 +18,7 @@ git submodule [--quiet] update [<options>] [--] [<path>...]
 git submodule [--quiet] set-branch [<options>] [--] <path>
 git submodule [--quiet] set-url [--] <path> <newurl>
 git submodule [--quiet] summary [<options>] [--] [<path>...]
-git submodule [--quiet] foreach [--recursive] [--reverse-traversal] [--include-superproject] <command>
+git submodule [--quiet] foreach [--recursive] [--reverse-traversal] [--include-superproject] [--reversive] <command>
 git submodule [--quiet] sync [--recursive] [--] [<path>...]
 git submodule [--quiet] absorbgitdirs [--] [<path>...]
 
@@ -222,7 +222,7 @@ specifications.
 Using the `--submodule=log` option with linkgit:git-diff[1] will provide that
 information too.
 
-`foreach [--recursive] [--reverse-traversal] [--include-superproject] <command>`::
+`foreach [--recursive] [--reverse-traversal] [--include-superproject] [--reversive] <command>`::
 	Evaluate an arbitrary shell _<command>_ in each checked out submodule.
 	The command has access to the variables `$name`, `$sm_path`, `$displaypath`,
 	`$sha1` and `$toplevel`:
@@ -255,6 +255,8 @@ superproject, that is, at the top level of the repository `foreach` was
 started in, after all the submodules. There, Git sets `$displaypath` to
 the name of that directory and sets none of the other variables listed
 above, although they may come from the environment.
+`--reversive` is a shorthand for giving `--recursive`,
+`--reverse-traversal` and `--include-superproject` together.
 A non-zero return from the command in any submodule causes
 the processing to terminate. This can be overridden by adding ++||:++
 to the end of the command.
@@ -270,8 +272,7 @@ And this shows the path of each submodule and then of the superproject,
 visiting the submodules nested in a submodule before the submodule itself:
 +
 --------------
-git submodule --quiet foreach --recursive --reverse-traversal \
-	--include-superproject 'echo $displaypath'
+git submodule --quiet foreach --reversive 'echo $displaypath'
 --------------
 
 `sync [--recursive] [--] [<path>...]`::
@@ -473,6 +474,11 @@ NOTE: See the NOTE above for the `--reference` option.
 	Also evaluate the command in the superproject, after all the
 	submodules. This option is only valid for the `foreach` command.
 
+`--reversive`::
+	A shorthand for `--recursive --reverse-traversal
+	--include-superproject`. This option is only valid for the `foreach`
+	command.
+
 `--depth=<depth>`::
 	Create a 'shallow' clone with a history truncated to the _<depth>_ revisions.
 	This option is valid for `add` and `update` commands. See linkgit:git-clone[1]
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fff5142eda..f923d2e926 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -485,6 +485,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int i, j;
+	int reversive = 0;
 	struct option module_foreach_options[] = {
 		OPT__SUPER_PREFIX(&info.super_prefix),
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
@@ -494,10 +495,12 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 			 N_("visit submodules in the reverse of the usual order")),
 		OPT_BOOL(0, "include-superproject", &info.include_superproject,
 			 N_("also run the command in the superproject, last")),
+		OPT_BOOL(0, "reversive", &reversive,
+			 N_("shorthand for --recursive --reverse-traversal --include-superproject")),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule foreach [--quiet] [--recursive] [--reverse-traversal] [--include-superproject] [--] <command>"),
+		N_("git submodule foreach [--quiet] [--recursive] [--reverse-traversal] [--include-superproject] [--reversive] [--] <command>"),
 		NULL
 	};
 	int ret = 1;
@@ -505,6 +508,12 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, module_foreach_options,
 			     git_submodule_helper_usage, 0);
 
+	if (reversive) {
+		info.recursive = 1;
+		info.reverse_traversal = 1;
+		info.include_superproject = 1;
+	}
+
 	if (module_list_compute(NULL, prefix, &pathspec, &list) < 0)
 		goto cleanup;
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f47459d589..69a31316ca 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3645,7 +3645,7 @@ _git_submodule ()
 		__gitcomp "--cached --files --summary-limit"
 		;;
 	foreach,--*)
-		__gitcomp "--recursive --reverse-traversal --include-superproject"
+		__gitcomp "--recursive --reverse-traversal --include-superproject --reversive"
 		;;
 	sync,--*)
 		__gitcomp "--recursive"
diff --git a/git-submodule.sh b/git-submodule.sh
index 964f5a8bf0..c86cbe76d2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -14,7 +14,7 @@ USAGE="[--quiet] [--cached]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
    or: $dashless [--quiet] set-url [--] <path> <newurl>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
-   or: $dashless [--quiet] foreach [--recursive] [--reverse-traversal] [--include-superproject] <command>
+   or: $dashless [--quiet] foreach [--recursive] [--reverse-traversal] [--include-superproject] [--reversive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
    or: $dashless [--quiet] absorbgitdirs [--] [<path>...]"
 OPTIONS_SPEC=
@@ -38,6 +38,7 @@ cached=
 recursive=
 reverse_traversal=
 include_superproject=
+reversive=
 init=
 require_init=
 files=
@@ -181,6 +182,9 @@ cmd_foreach()
 		--include-superproject)
 			include_superproject=$1
 			;;
+		--reversive)
+			reversive=$1
+			;;
 		-*)
 			usage
 			;;
@@ -196,6 +200,7 @@ cmd_foreach()
 		$recursive \
 		$reverse_traversal \
 		$include_superproject \
+		$reversive \
 		-- \
 		"$@"
 }
diff --git a/t/t7427-submodule-foreach-reversive.sh b/t/t7427-submodule-foreach-reversive.sh
index a53ea0b851..d5aa29f08e 100755
--- a/t/t7427-submodule-foreach-reversive.sh
+++ b/t/t7427-submodule-foreach-reversive.sh
@@ -3,13 +3,14 @@
 # Copyright (c) 2026 William Hatfield
 #
 
-test_description='git submodule foreach --reverse-traversal and --include-superproject
+test_description='git submodule foreach --reverse-traversal, --include-superproject and --reversive
 
 Check that --reverse-traversal visits submodules in the reverse of their
 usual order, and that, together with --recursive, each submodule is
 visited after the submodules nested in it. Check that
 --include-superproject also runs the command in the superproject, after
-all the submodules.
+all the submodules, and that --reversive is a shorthand for all three of
+these options.
 '
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
@@ -416,4 +417,13 @@ test_expect_success 'committing in the submodules and the superproject leaves no
 	done
 '
 
+test_expect_success '--reversive is --recursive --reverse-traversal --include-superproject' '
+	git -C reversive/top submodule --quiet foreach --recursive \
+		--reverse-traversal --include-superproject \
+		"echo \$displaypath" >expect &&
+	git -C reversive/top submodule --quiet foreach --reversive \
+		"echo \$displaypath" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.0

