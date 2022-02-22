Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CBEC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbiBWXla (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245045AbiBWXlW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:41:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A704A5B3D3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:40:47 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hw13so657700ejc.9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bxpSnGCnoiNgvnSVqlhSRu+Uqe8R1bq72zOK30DE3pQ=;
        b=Fs1+9GLpwVE3grjNbd6DG09QmRDbYG98K6sXTLSvEsQaoQTrzdMQRzM60iQV69Owqg
         fkOb9Uzg3WHvvQDWMbIfjQQ22Il9jLfInVU77OH14X3a/jwAgy++ZtIpo43GahOz0rr3
         ro1xpE0H4YtBhmSeTbI7MPY2rop4r0CVRUvuW/waf8Hp7dn9/s357vR+KLLjcWBNqYYy
         crXvvt7iRU3x7dkT7Ea+Fn2Cd+5ma8iMldB/lOXeSKY5wgowqOYAjmCz0+qYdYsaIhGl
         zfVmjRHkdP0iA71p8Rh4ERR0wfvpa+emyF9wpigaCatVMAEsxj2HMgtDI3Yj8kB/QBy+
         Zp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bxpSnGCnoiNgvnSVqlhSRu+Uqe8R1bq72zOK30DE3pQ=;
        b=XG+xgnw+g2QSb9Je5nQ2mNcsY5vg2Df0QFlF+LZA+JGofo0ISbHx7G25PG/OndwoYB
         EoDe22f3CWIkN5sLCtbEE5ltIi1KOoq42E84J/riRGtJKtBnQlH4lUxyN8r5KkduNIMw
         jaBMeeIQA5avMlBunhoKnD6gobIaQ/d3ON+oYrvympE8eLeztviXP02lT5io9MwGCizc
         ciXy/TgkLF1sALokWUEgu3K0GNp89v6c2DOk49gdo60IjQgklJ1ooLK8T3wgeEsVuNoq
         16r9laqeSqFSDA6i1u/c8pTGpKRjXEOo+3QmTQg8aFb2LqHiBCMfxEGdWPUTIyzrEJ2W
         uN6Q==
X-Gm-Message-State: AOAM531e1W1JvCKaxTfEbIOSdGeJhHqP/qekgndOwDViGWyUr+VwFmfZ
        NuC/XN+EWWTcmgLLKbLxTC1ENZynxgY=
X-Google-Smtp-Source: ABdhPJzGL6UsTJyX/sNZM71rxEwNwrtHM+NwubH7tis0W0JL0GzbSJ9ujSBmbVCHkwZlt36tNrplPQ==
X-Received: by 2002:a17:906:1be1:b0:6ce:b0a8:17d with SMTP id t1-20020a1709061be100b006ceb0a8017dmr53715ejg.413.1645659645762;
        Wed, 23 Feb 2022 15:40:45 -0800 (PST)
Received: from archlinux (ip5f5bf390.dynamic.kabel-deutschland.de. [95.91.243.144])
        by smtp.gmail.com with ESMTPSA id e3sm454774eja.77.2022.02.23.15.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:40:45 -0800 (PST)
References: <B0458F2D-C6B9-41AE-8F2F-39C1D2AEE6BD@icloud.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Maximilian Reichel <reichemn@icloud.com>
Cc:     git@vger.kernel.org
Subject: Re: pull fails after commit dry-run
Date:   Tue, 22 Feb 2022 23:15:02 +0000
In-reply-to: <B0458F2D-C6B9-41AE-8F2F-39C1D2AEE6BD@icloud.com>
Message-ID: <878ru1kv8t.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,

Maximilian Reichel <reichemn@icloud.com> writes:

> =EF=BB=BFThank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Running the following two scripts.
>
>
> Script one:
> '#!/bin/bash
>
> mkdir parent
> git -C parent init
> git -C parent -c user.name=3D"P" -c user.email=3D"m@example.com" commit -=
m one --allow-empty=20
>
> mkdir cloneDir
> cd cloneDir
> git init
>
> git pull -v --rebase "../parent"
> echo git pull exit code: $?'
>
>
>
>
> script two:
> '#!/bin/bash
>
> mkdir parent
> git -C parent init
> git -C parent -c user.name=3D"P" -c user.email=3D"m@example.com" commit -=
m one --allow-empty=20
>
> mkdir cloneDir
> cd cloneDir
> git init
> git commit -m "foo" --dry-run
> git pull -v --rebase "../parent"
> echo git pull exit code: $?'
>

Thanks for providing the script to quickly assess the problem.

>
> What did you expect to happen? (Expected behavior)
> Since they only differ in the 'git commit -m "foo" --dry-run' invocation,=
 I would expect the same outcome for both scripts.
> Expected output of the last two lines:
> 'From ../parent
> * branch            HEAD       -> FETCH_HEAD
> git pull exit code: 0'
>
> What happened instead? (Actual behavior)
> The second script is not able to pull from ../parent.
> Output of the last lines of the second script:
> 'fatal: Updating an unborn branch with changes added to the index.
> git pull exit code: 128=E2=80=99
>

First of all, as I'm not an experienced contributor, the following
should be taken with a grain of salt. Nevertheless, I thought about
given a shot here.

It seems this boils down to the fact that on the second script, `git
commit --dry-run` will create the `.git/index` (the Git Index) in order
to run the commit process as part of its natural workflow (i.e: `git
add`, `git commit`). Even though the index has no entries in it.

Later, when `git pull --rebase` is called, it executes the following
condition that evaluates to true (as we can see from the report ;) ):

    # builtin/pull.c:cmd_pull
    if (is_null_oid(&orig_head) && !is_cache_unborn())
        die(_("Updating an unborn branch with changes added to the index.")=
);

On the condition, according to my understand of the code, we die when
.git/HEAD does not point to a commit and when the index is there (or
born, to use the code terminology). The first will be true, on this
particular case, because it's a fresh repository.

IOW, we assume that is not safe to rebase on a "yet to be born branch"
with a non-empty index, as the index is not based on anything that comes
from the upstream repository. This indicates that there local changes
that will be destroy if the rebase is performed.

This behavior dates back to 19a7fcbf16 (allow pull --rebase on branch
yet to be born, 2009-08-11). Back then, `git pull` was written in shell
script with the following code:

    # On an unborn branch
    if test -f "$GIT_DIR/index"
    then
            die "updating an unborn branch with changes added to the index"
    fi

On the current code (e6ebfd0e8c (The sixth batch, 2022-02-18)), we
identify if the index is not born, by checking if the index has no
entries and if the timestamp is set:

    #define is_cache_unborn() is_index_unborn(&the_index)

    int is_index_unborn(struct index_state *istate)
    {
             return (!istate->cache_nr && !istate->timestamp.sec);
    }

Now, this is where it gets a bit interesting. On this case, the index
created by the `commit --dry-run` is empty in a sense: It doesn't have
any entries. Which makes me think that we "should" be able to `pull
--rebase`, for such case. For instance, by untighting the condition to
only check the number of entries. However, I'm probably missing some
intrinsic information that will break the code or worse deleting local
changes.

Just in order to illustrate better how such change can look like:

--- 8< ---
diff --git a/builtin/pull.c b/builtin/pull.c
index 3768552e68..c45a880e56 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -980,6 +980,20 @@ static void show_advice_pull_non_ff(void)
 		 "invocation.\n"));
 }

+/*
+ * If, for some reason, this turns out to be a good idea,
+ * it shuold be move to its proper location.
+ */
+#define is_cache_empty() is_index_empty(&the_index)
+
+static int is_index_empty(struct index_state *istate)
+{
+	return !istate->cache_nr;
+}
+
+int is_index_unborn(struct index_state *);
+
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
@@ -1043,7 +1057,7 @@ int cmd_pull(int argc, const char **argv, const char =
*prefix)
 		if (opt_autostash =3D=3D -1)
 			opt_autostash =3D config_autostash;

-		if (is_null_oid(&orig_head) && !is_cache_unborn())
+		if (is_null_oid(&orig_head) && !is_cache_empty())
 			die(_("Updating an unborn branch with changes added to the index."));

 		if (!opt_autostash)
--- >8 ---

Whether this is a good idea or not, I'm not able to tell right now. If
this turns out to be a good idea, I can prepare a follow up patch with
proper testing.

>
> Anything else you want to add:
> I tested this on git 2.35.1, 2.34.1 and 2.21.0 and they are all affected.=
=20
>
>
> [System Info]
> git version:
> git version 2.35.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.10.25-linuxkit #1 SMP Tue Mar 23 09:27:39 UTC 2021 x86_64
> compiler info: gnuc: 10.2
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): <unset>
>
>
> [Enabled Hooks]
> not run from a git repository - no hooks to show


--=20
Thanks
Raffs
