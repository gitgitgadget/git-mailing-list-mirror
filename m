Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63A4B1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 21:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967248AbeF1V7K (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 17:59:10 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43860 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966732AbeF1V7J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 17:59:09 -0400
Received: by mail-yw0-f195.google.com with SMTP id r19-v6so2699725ywc.10
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTRhT7Y9hK8xNHILNWcgJDAdZ1vMEBxbGorKur1JcKA=;
        b=qdtp2ELKOyzsxpqlWNMb6ORRF1iJKREhrI92qsuP1OorgElWNwgr1+6NlI4bEATVUZ
         c5nkTuMPHuv3x5hpnEWuL28XGc8a2kPGP1v3a16UdlrTj1ETRqSjzjGlJSQKzAxZVero
         riF7Z8VCLA9Chji9jcL4eeVEvYQq2kjdeQGUs+z4fOyNry33FYczdZFRfmEd4z+yCt+X
         VVm66DJgKFpG1mVvWuYv7o+22fXoKCrgeO1Jdl3Q6GyQD1+l9ZBsI6a8IUIpPMvQaLoV
         0Ge1xOBPkWnbZ6jFmiS1AoibUduieoJgiE9Zs/JJNby6vdKuVnpsWvGdvSLvJssu907G
         rryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTRhT7Y9hK8xNHILNWcgJDAdZ1vMEBxbGorKur1JcKA=;
        b=ZwBXYH9lXv3MhPJdP0i3UDxrw6fu9ur1EK1Pjl10Ux1Wm534ZEimg/4a0LrolXH9bg
         qTleJ/M4A3UCt9lougs19OF/Wo85reJEIChuMG+Ot9DY3Km/RH1+EYJLSHyxnKAHKktR
         3aCAipH6Tb5c2wEx+r7FFRyxgUFF0oXt8nhAObdShtxWfXVtXWPyaPoGZAErpoAp8KJN
         3XAjMk/RaVo4K2qKvehLz3PunwKNXrPTg5a/rVVICa8uzs+o7hzvR96OfN42iZQ1sdag
         /ivP6tQOdnTvpIqY9ktSl+QuWKhdOB8YirbrbNVzV35xRjG+8fdp6/GI5f6Hdv6cnEvV
         8pbg==
X-Gm-Message-State: APt69E2Nv9RgvMLO/QVieZ/RG9NvPN7u7IGJpGJdkxqh2VNL8qkPpYOF
        3GapqpSVWV6pd4f/ha5F2Vd09i/VTuMDd7fcSwaBNQ==
X-Google-Smtp-Source: AAOMgpeBqCMXei6ohfVp6Naw/SJcipYPAyTZ76vd87NkvOlXXfgDlAnA7MqJN/cCC83iZN8pewtPopYLdm8TEwSD0rw=
X-Received: by 2002:a0d:d304:: with SMTP id v4-v6mr5931571ywd.500.1530223148080;
 Thu, 28 Jun 2018 14:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180628074655.5756-6-predatoramigo@gmail.com>
In-Reply-To: <20180628074655.5756-6-predatoramigo@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 28 Jun 2018 14:58:56 -0700
Message-ID: <CAGZ79kZpf3AMqZPraCYp+KNKPo9xex3OBJLAz_foGiSPVswYHw@mail.gmail.com>
Subject: Re: [PATCH 5/5] builtin/rebase: support running "git rebase <upstream>"
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 12:48 AM Pratik Karki <predatoramigo@gmail.com> wrote:
>
> This patch gives life to the skeleton added in the previous patch.
> This patch makes real operation happen i.e. by using
> `git -c rebase.usebuiltin=true rebase <upstream>`.
> With this patch, the basic operation of rebase can be done.

Would it make sense to add this config option to some basic test in the
test suite to show off one case in there? (Otherwise it is hard to keep this
code correct for the future (even if it is just a few days/weeks) as other
series on the list may collide with it in subtle ways, so a test would be
fast signal to catch these subtleties).

Maybe setting this in one of the early tests in t3400 would be good?

> These backends use Unix shell functions defined both by git-sh-setup.sh
> and git-rebase.sh (we move the latter's into git-rebase--common.sh to

s/move/moved in a previous patch/ ? But then again we already know about
the earlier patch, I am on the fence whether this is worth mentioning. But
it sure is fine to leave it here.

> accommodate for that), so we not only have to source the backend file
> before calling the respective Unix shell script function, but we have
> to source git-sh-setup and git-rebase--common before that.
> And since this is all done in a Unix shell script snippet, all of this
> is in argv[0]. There never will be a non-NULL argv[1].

No double negatives are never harder to read than simple forms. ;)
So you are saying, there are no further arguments to that shell
invocation?

> This patch does the *bare* minimum to get `git rebase <upstream>` to
> work: there is still no option parsing, and only the bare minimum set
> of environment variables are set (in particular, the current revision
> would be susceptible to bugs where e.g. `rebase_root` could be set by
> mistake before running `git rebase` and the `git-rebase--am` backend
> would pick up that variable and use it).
>
> It still calls original `git-legacy-rebase.sh` unless the config
> setting rebase.useBuiltin is set to true. This patch uses the
> detach_head_to() function from checkout.c introduced by a previous
> commit to perform initial checkout.
>
> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> ---
>  builtin/rebase.c | 231 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 229 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 1152b7229..2f90389c2 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -9,6 +9,19 @@
>  #include "exec-cmd.h"
>  #include "argv-array.h"
>  #include "dir.h"
> +#include "packfile.h"
> +#include "checkout.h"
> +#include "refs.h"
> +
> +static GIT_PATH_FUNC(apply_dir, "rebase-apply");
> +static GIT_PATH_FUNC(merge_dir, "rebase-merge");
> +
> +enum rebase_type {
> +       REBASE_AM,
> +       REBASE_MERGE,
> +       REBASE_INTERACTIVE,
> +       REBASE_PRESERVE_MERGES
> +};
>
>  static int use_builtin_rebase(void)
>  {
> @@ -28,8 +41,129 @@ static int use_builtin_rebase(void)
>         return ret;
>  }
>
> +static int apply_autostash(void)
> +{
> +       warning("TODO");

This comes up unconditionally here, so the automated testing
idea from above might not be as good as I thought after all.

> +static struct commit *peel_committish(const char *name)

The -ish suffix is to indicate that a wide range of notations
that describe commits are accepted. Another way of naming this
function would be by its output, i.e. peel_to_commit, the name
similar to peel_to_type. But I guess emphasizing the input
to be anything that describes a commit is also important here,
as we pass in the arguments eventually provided by users
(e.g. "master^^") so this name sounds fine; I cannot think of
a better suggestion for now.
