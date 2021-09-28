Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C625FC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C23611BD
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 05:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhI1F0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 01:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbhI1F0j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 01:26:39 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547A2C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 22:25:00 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w206so28649719oiw.4
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 22:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PAOGO9H62hHPc56468S8ACIPcxAjfzMcK8rewUSlGK0=;
        b=Ef3gk/D8kcBLlU0rBiJ3jmj9g72938iMLoVaFr1S3pQOTLQJXLr+TPyT33VUIbpl/N
         8GxWe5UHeEroaGpq4Qvl9PwospCd0oCVMWbCRDZkQPfXAzlVuQ/euNTBIRdZz9asbC32
         u+ABCpylpZKTldRkvr5ULbO1u9Szcf95TFRv1KUbTkM/MZV5vyyMb0we6BIMZoTQEFvk
         xXES4qaUE8FjZaYhjESZli5/ioZkkOYcA0Y+tjJ4/Dy9hSG1yQRAphTmgPw34NF62J5l
         iESeQinznVRHgZMIeI6p/pgjTuteMB4/ArQB3weSyG9CO1In7cO8zNGlKyYHYvhuqAg8
         1fVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAOGO9H62hHPc56468S8ACIPcxAjfzMcK8rewUSlGK0=;
        b=KuM8WtjFl5lvuYNk+rFunj6kdU/tne+gig10vFpbFWfGWBLRNwydpfWg/kwRAZeRXh
         jrEeXiu49llmBDBrfLKRGA8AI3VrYuhOWHxqnzWtlgbAUMeGHrzztU5RK/CrDLfXZEgW
         R+tyabRxIk0pzSzpZ0bwTYMXiZMuiSijTRkIXN/ZooXHiQx/261r+kxaVcWQnY6yLa5M
         ZE7BTzkltKj+JEv7MjgG8IcGGkOPpJMx6ygBM+Z6ctizlaDUetbdzjLAPg0sRCcuE7Sw
         BmOnK2T5z7tAA10miLj7hzhT3zSCRgd9mNw0J/1qu+3VqcLtWzcyxnlUXwALo2FmmLWk
         n8Og==
X-Gm-Message-State: AOAM531TS65UVp53gH81KPk+AMP8yYUDV/tJNIvZ9E1L4TfQykSDQ/R0
        02gJmGFyyvhx9JTBGRbpDqUeTWl3jmon4oVFNpb+e6pGs3U=
X-Google-Smtp-Source: ABdhPJx8akBgwzz52kOIfPoC23XIEyKSNMbKpXOZY1A051KD3cALr8r8uNWx8JDlgA/eZSR7h0M92dRkTtZ5OcjtHkc=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr2313430oib.39.1632806699678;
 Mon, 27 Sep 2021 22:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com> <ada242c7c8c1f530231f97e76c97fff18e368ff5.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <ada242c7c8c1f530231f97e76c97fff18e368ff5.1631630356.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Sep 2021 22:24:47 -0700
Message-ID: <CABPp-BG3FwBVO67ZVPCLokA3xh5=fLiXYe-K2GiRa7ELFvQkEA@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] scalar: allow reconfiguring an existing enlistment
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 7:39 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This comes in handy during Scalar upgrades, or when config settings were
> messed up by mistake.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/scalar/scalar.c          | 79 +++++++++++++++++++++-----------
>  contrib/scalar/scalar.txt        |  8 ++++
>  contrib/scalar/t/t9099-scalar.sh |  8 ++++
>  3 files changed, 67 insertions(+), 28 deletions(-)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 8a11f390251..1fff7eb7c12 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -115,18 +115,20 @@ static int run_git(const char *arg, ...)
>         return res;
>  }
>
> -static int set_recommended_config(void)
> +static int set_recommended_config(int reconfigure)
>  {
>         struct {
>                 const char *key;
>                 const char *value;
> +               int overwrite_on_reconfigure;
>         } config[] = {
> -               { "am.keepCR", "true" },
> -               { "core.FSCache", "true" },
> -               { "core.multiPackIndex", "true" },
> -               { "core.preloadIndex", "true" },
> +               /* Required */
> +               { "am.keepCR", "true", 1 },
> +               { "core.FSCache", "true", 1 },
> +               { "core.multiPackIndex", "true", 1 },
> +               { "core.preloadIndex", "true", 1 },
>  #ifndef WIN32
> -               { "core.untrackedCache", "true" },
> +               { "core.untrackedCache", "true", 1 },
>  #else
>                 /*
>                  * Unfortunately, Scalar's Functional Tests demonstrated
> @@ -140,28 +142,29 @@ static int set_recommended_config(void)
>                  * Therefore, with a sad heart, we disable this very useful
>                  * feature on Windows.
>                  */
> -               { "core.untrackedCache", "false" },
> +               { "core.untrackedCache", "false", 1 },
>  #endif
> -               { "core.logAllRefUpdates", "true" },
> -               { "credential.https://dev.azure.com.useHttpPath", "true" },
> -               { "credential.validate", "false" }, /* GCM4W-only */
> -               { "gc.auto", "0" },
> -               { "gui.GCWarning", "false" },
> -               { "index.threads", "true" },
> -               { "index.version", "4" },
> -               { "merge.stat", "false" },
> -               { "merge.renames", "false" },
> -               { "pack.useBitmaps", "false" },
> -               { "pack.useSparse", "true" },
> -               { "receive.autoGC", "false" },
> -               { "reset.quiet", "true" },
> -               { "feature.manyFiles", "false" },
> -               { "feature.experimental", "false" },
> -               { "fetch.unpackLimit", "1" },
> -               { "fetch.writeCommitGraph", "false" },
> +               { "core.logAllRefUpdates", "true", 1 },
> +               { "credential.https://dev.azure.com.useHttpPath", "true", 1 },
> +               { "credential.validate", "false", 1 }, /* GCM4W-only */
> +               { "gc.auto", "0", 1 },
> +               { "gui.GCWarning", "false", 1 },
> +               { "index.threads", "true", 1 },
> +               { "index.version", "4", 1 },
> +               { "merge.stat", "false", 1 },
> +               { "merge.renames", "false", 1 },
> +               { "pack.useBitmaps", "false", 1 },
> +               { "pack.useSparse", "true", 1 },
> +               { "receive.autoGC", "false", 1 },
> +               { "reset.quiet", "true", 1 },
> +               { "feature.manyFiles", "false", 1 },
> +               { "feature.experimental", "false", 1 },
> +               { "fetch.unpackLimit", "1", 1 },
> +               { "fetch.writeCommitGraph", "false", 1 },
>  #ifdef WIN32
> -               { "http.sslBackend", "schannel" },
> +               { "http.sslBackend", "schannel", 1 },
>  #endif
> +               /* Optional */
>                 { "status.aheadBehind", "false" },
>                 { "commitGraph.generationVersion", "1" },
>                 { "core.autoCRLF", "false" },

Now you have optional settings...but index.version and merge.renames
aren't among them??  Why are those required?  (...and to go a step
further; should merge.renames even be off in a merge-ort world?)
