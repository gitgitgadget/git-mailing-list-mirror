Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559F41F404
	for <e@80x24.org>; Fri, 23 Feb 2018 18:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeBWSYm (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 13:24:42 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37706 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeBWSYl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 13:24:41 -0500
Received: by mail-yw0-f194.google.com with SMTP id j143so3096868ywb.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 10:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eFOfsEvKPBEWPFLBQN92gGKli7gXupCv7WVzx/Li/kU=;
        b=spP8aK8J8eb4P4sCKlxN0mnAY2GygT1V7kxdankrPyKFLIKQ1Sdkm7Zj41UhgtOENM
         8Ra915Vlo8Bjzy21gQCiXJH3CzAmDKWyzI4GfQYK5tTAGhxxfVFjwkVZqAtt2TrBXAy2
         WVZsIeNM81UxJvdhXSDDgdDmYSCVaubZsu+2agnQbIrxPYWKiXG1kfRoF1Ca4WVwLYYN
         C0X8NJBslyYRTeuswJLC3O7fK7uMGeXlTwVCRVH6Cfmmi32Zb1fDC3wtKUH2ymISYfpA
         0Mjx5vbOZoak3eKN0z7UjbEduCB8enoFcHyOrKTpC4yD0F8v4EXnhHl2q/xzsHerryUX
         BV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eFOfsEvKPBEWPFLBQN92gGKli7gXupCv7WVzx/Li/kU=;
        b=Ngbb/4MxQmD30N6U4TlK5f4KQ/TtMLTpM6PJFa2lEY9JK02RhRTmVuD8f+Hktniqti
         0Di5MpVmcTtI/BlkMOzOp7tpl30qmd5byTthNk8wy69D4Anf3bWXAIfhohFvFxxEPvG+
         fjKzDzxhditEayAwVoG5y7YDja/QWdGKmV5fPU0a/z4sAqTU6088np91S2OreeAT/WfE
         OhvWn4ZRqtQTVefStARxS9EUT/9xAJs3KRgkdM2JKSA8JwJLXwWFW09L/PGo3Vp2/fxW
         KRw2sQX5A845BUfSnvn7mz1vXI1E0bpSvGv2tJ35cY8mlPwa6ODJvUXtx15sBkPaIHUg
         MBzQ==
X-Gm-Message-State: APf1xPB1fg+HAbCuXhrMKQYK2WY1WDgJy7eUtB9ZJSkzMx4u2+RGnPgp
        SOnRY8FsU1qbwYxIcZDNZ2b5Z4VGnPYwci91jpOoXg==
X-Google-Smtp-Source: AH8x2272z54+w9BSxEZ15//wJVTxhv1psJ2ku+SrcsQIOVUvZyxSbgdzNCd5VLXyM04uliFP98hBwKe20T9aIyAE/u8=
X-Received: by 10.129.25.214 with SMTP id 205mr1789587ywz.340.1519410280421;
 Fri, 23 Feb 2018 10:24:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 23 Feb 2018 10:24:39
 -0800 (PST)
In-Reply-To: <20180223095640.25876-3-pclouds@gmail.com>
References: <20180214180814.GA139458@google.com> <20180223095640.25876-1-pclouds@gmail.com>
 <20180223095640.25876-3-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Feb 2018 10:24:39 -0800
Message-ID: <CAGZ79karK7MT_qpFyYfVkioeBsBHidGdC_QfisPmG1a4dQuk5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "repository: pre-initialize hash algo pointer"
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 1:56 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This reverts commit e26f7f19b6c7485f04234946a59ab8f4fd21d6d1. The root
> problem, git clone not setting up the_hash_algo, has been fixed in the
> previous patch.
>
> As a result of the revert, some code paths that use the_hash_algo
> without initialization is revealed and fixed here. It's basically
> commands that are allowed to run without a repository. The fix here is
> not the best. We probably could figure out the hash algorithm from input
> somehow.
>
> Since this is a dangerous move and could potentially break stuff after
> release (and leads to workaround like the reverted commit), the
> workaround technically remains, but is hidden behind a new environment
> variable GIT_HASH_FIXUP. This should let the users continue to use git
> while we fix the problem.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/index-pack.c             | 5 +++++
>  common-main.c                    | 4 ++++
>  diff-no-index.c                  | 5 +++++
>  repository.c                     | 2 +-
>  t/helper/test-dump-split-index.c | 2 ++
>  5 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 7e3e1a461c..8ee935504e 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1673,6 +1673,11 @@ int cmd_index_pack(int argc, const char **argv, co=
nst char *prefix)
>         if (prefix && chdir(prefix))
>                 die(_("Cannot come back to cwd"));
>
> +       if (!the_hash_algo) {
> +               warning(_("Running without a repository, assuming SHA-1 h=
ash"));
> +               repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +       }
> +
>         for (i =3D 1; i < argc; i++) {
>                 const char *arg =3D argv[i];
>
> diff --git a/common-main.c b/common-main.c
> index 6a689007e7..12aec36794 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "exec_cmd.h"
>  #include "attr.h"
> +#include "repository.h"
>
>  /*
>   * Many parts of Git have subprograms communicate via pipe, expect the
> @@ -40,5 +41,8 @@ int main(int argc, const char **argv)
>
>         restore_sigpipe_to_default();
>
> +       if (getenv("GIT_HASH_FIXUP"))
> +               repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +
>         return cmd_main(argc, argv);
>  }
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 0ed5f0f496..f038f665bc 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -241,6 +241,11 @@ void diff_no_index(struct rev_info *revs,
>         struct strbuf replacement =3D STRBUF_INIT;
>         const char *prefix =3D revs->prefix;
>
> +       if (!the_hash_algo) {
> +               warning(_("Running without a repository, assuming SHA-1 h=
ash"));
> +               repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +       }
> +
>         diff_setup(&revs->diffopt);
>         for (i =3D 1; i < argc - 2; ) {
>                 int j;
> diff --git a/repository.c b/repository.c
> index 4ffbe9bc94..0d715f4fdb 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -5,7 +5,7 @@
>
>  /* The main repository */
>  static struct repository the_repo =3D {
> -       NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index,=
 &hash_algos[GIT_HASH_SHA1], 0, 0
> +       NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index,=
 NULL, 0, 0

I am not sure I agree with this defense in depth, because it would add
a lot to maintenance burden.
Specifically this part. The series that I sent out usually clashes
here as this is currently a hot area
of the code touched by many different series in flight.

However this is the long term correct thing to do? We assume no algorithm u=
ntil
the repository can tell us from its config (or we default to sha1 if there =
is no
configuration present).

I wonder if there is yet another missing case in the enumeration of
the previous patch:
Some commands are able to operate on GIT_OBJECT_DIR instead
of GIT_DIR (git repack?), which may not even explore the full git directory=
,
and so doesn't know about the hash value.

In the cover letter you reference my series, but comparing the diffstats
(and looking through the patches), I would only expect this one place
to have merge conflicts, which ought to be easy to resolve.
(In my series I break the initializer into multiple lines to help the
future, too)

After some thought, I like this series.

Thanks,
Stefan
