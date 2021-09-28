Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C87C4332F
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 06:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CD361159
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 06:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbhI1G0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 02:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbhI1GZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 02:25:56 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E766C061770
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 23:24:17 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso27636035ota.8
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 23:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3V2uFj0DXjgCoW08E6xJauKQxn/H3L/n+bPjKmQJWE=;
        b=AzVNLw3HjjYyUE6nw83zk5y+Y7jaWpywe4e2+6Hie8DibBabWbMrv4vbkzzA5rrhFD
         11ctx/9ROhpFkaXWL1KwN6jpLEojFgOsgyOEJMPlbSWP8kce5xy7Idvq4eXQtxpJHhh7
         FrKh1Wpmm7naA/YmN7rlmTXs8KidKF4HefTAAS+HytKNwCMIgzj/97JPri2W1OFB8dDv
         QfSBvO4T7UJ6ZRiyHn2s+iRCwfC2aRg7SguXziA0+TrnZa40DO4ujxx59c4xTscrlC04
         bTT+3JmxYRsxzUK0jsvvdLG3+dX+HDqxbXcVoAxgSs1qDVD4W0/UUrJgOUnAC9XIRAJM
         4ZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3V2uFj0DXjgCoW08E6xJauKQxn/H3L/n+bPjKmQJWE=;
        b=43ibDkGjLbyR6uVaPSI6ZGG/uRDZEW4T2hwWk+JVh+vDRyz3PNI+9bqPOJL8gXWOry
         bl9btTF3Fno1a3fqMuvBVcewzN2PHUmgzr+cW0LPYw3XPxWFLdJBys2gusbI6XXGho/g
         MOADkLpD/am19qvtQy3K++4AhXDVQ4mgq3LJ+ry3F+s+nLZxq11+rzMa5t6WTtxz/F3l
         1GrBSkyXaq+0xy9bdZRTLGVVB/KEiQqYnVooR0awDV8ffrhYfCUo5zg9b6rhB6O6iYLT
         Fcst8He9NojVLFTVXyzEqTUAQOwEbfU1EQHEUQxH1o192GHo5kosUd7TK7burer9Ov+k
         BmnQ==
X-Gm-Message-State: AOAM533lWswSS0op87mSAsR6+db39J+f3qky/RVngrj42gV5LNpRFNr2
        l10YO4SnA8UV2/KuZe0uppgR41Av+8yJ/kbuZXU=
X-Google-Smtp-Source: ABdhPJx1JTdeGnxxhUMRLAbFUng/F4ewi6Q6GfMRT4U0KnrthUy8agJLModjtzCi+2+4YBkJpWikWSicUewsg005c1w=
X-Received: by 2002:a9d:7751:: with SMTP id t17mr3674819otl.276.1632810256809;
 Mon, 27 Sep 2021 23:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com> <914c16c7fcd948374fb2c0582c435d0d6ac775a0.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <914c16c7fcd948374fb2c0582c435d0d6ac775a0.1631630356.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Sep 2021 23:24:05 -0700
Message-ID: <CABPp-BGzw4XUhEnUSnp5C1q-7qHcLP-8owbpqTfnbrCuwVkMQw@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] scalar: implement the `delete` command
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 7:39 AM Matthew John Cheetham via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> Delete an enlistment by first unregistering the repository and then
> deleting the enlistment directory (usually the directory containing the
> worktree `src/` directory).
>
> On Windows, if the current directory is inside the enlistment's
> directory, change to the parent of the enlistment directory, to allow us
> to delete the enlistment (directories used by processes e.g. as current
> working directories cannot be deleted on Windows).

But if the current directory is inside the enlistment's directory,
didn't that happen because the parent process' current directory was
inside the enlistment directory?  Or was there some kind of directory
switching that scalar itself was doing causing it to be inside the
enlistment directory?

If the the current directory was inside the enlistment's directory
because it inherited a parent process' current directory, wouldn't
that also prevent deleting it?  If so, should there be a special check
for that case and pre-emptively returning an error rather than
attempting the recursive directory deletion and just spitting out an
error when it fails?

(Also seems slightly related to
https://github.com/gitgitgadget/git/pull/1037, which I'll submit as
soon as en/removing_untracked_fixes hits next.)

>
> Co-authored-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/scalar/scalar.c          | 55 ++++++++++++++++++++++++++++++++
>  contrib/scalar/scalar.txt        |  8 +++++
>  contrib/scalar/t/t9099-scalar.sh |  9 ++++++
>  3 files changed, 72 insertions(+)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 67fa5305225..00bedb0bf66 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -8,6 +8,7 @@
>  #include "config.h"
>  #include "run-command.h"
>  #include "refs.h"
> +#include "dir.h"
>
>  /*
>   * Remove the deepest subdirectory in the provided path string. Path must not
> @@ -334,6 +335,33 @@ static char *remote_default_branch(const char *url)
>         return NULL;
>  }
>
> +static int delete_enlistment(struct strbuf *enlistment)
> +{
> +#ifdef WIN32
> +       struct strbuf parent = STRBUF_INIT;
> +#endif
> +
> +       if (unregister_dir())
> +               die(_("failed to unregister repository"));
> +
> +#ifdef WIN32
> +       /*
> +        * Change the current directory to one outside of the enlistment so
> +        * that we may delete everything underneath it.
> +        */
> +       strbuf_addbuf(&parent, enlistment);
> +       strbuf_parent_directory(&parent);
> +       if (chdir(parent.buf) < 0)
> +               die_errno(_("could not switch to '%s'"), parent.buf);
> +       strbuf_release(&parent);
> +#endif
> +
> +       if (remove_dir_recursively(enlistment, 0))
> +               die(_("failed to delete enlistment directory"));
> +
> +       return 0;
> +}
> +
>  static int cmd_clone(int argc, const char **argv)
>  {
>         const char *branch = NULL;
> @@ -694,6 +722,32 @@ static int cmd_unregister(int argc, const char **argv)
>         return unregister_dir();
>  }
>
> +static int cmd_delete(int argc, const char **argv)
> +{
> +       struct option options[] = {
> +               OPT_END(),
> +       };
> +       const char * const usage[] = {
> +               N_("scalar delete <enlistment>"),
> +               NULL
> +       };
> +       struct strbuf enlistment = STRBUF_INIT;
> +       int res = 0;
> +
> +       argc = parse_options(argc, argv, NULL, options,
> +                            usage, 0);
> +
> +       if (argc != 1)
> +               usage_with_options(usage, options);
> +
> +       setup_enlistment_directory(argc, argv, usage, options, &enlistment);
> +
> +       res = delete_enlistment(&enlistment);
> +       strbuf_release(&enlistment);
> +
> +       return res;
> +}
> +
>  static struct {
>         const char *name;
>         int (*fn)(int, const char **);
> @@ -704,6 +758,7 @@ static struct {
>         { "unregister", cmd_unregister },
>         { "run", cmd_run },
>         { "reconfigure", cmd_reconfigure },
> +       { "delete", cmd_delete },
>         { NULL, NULL},
>  };
>
> diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
> index 2fa96fcabc6..6fc57707718 100644
> --- a/contrib/scalar/scalar.txt
> +++ b/contrib/scalar/scalar.txt
> @@ -14,6 +14,7 @@ scalar register [<enlistment>]
>  scalar unregister [<enlistment>]
>  scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
>  scalar reconfigure [ --all | <enlistment> ]
> +scalar delete <enlistment>
>
>  DESCRIPTION
>  -----------
> @@ -127,6 +128,13 @@ reconfigure the enlistment.
>  With the `--all` option, all enlistments currently registered with Scalar
>  will be reconfigured. Use this option after each Scalar upgrade.
>
> +Delete
> +~~~~~~
> +
> +delete <enlistment>::
> +       This subcommand lets you delete an existing Scalar enlistment from your
> +       local file system, unregistering the repository.
> +
>  SEE ALSO
>  --------
>  linkgit:git-clone[1], linkgit:git-maintenance[1].
> diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
> index 5fe7fabd0e5..7e8771d0eff 100755
> --- a/contrib/scalar/t/t9099-scalar.sh
> +++ b/contrib/scalar/t/t9099-scalar.sh
> @@ -76,4 +76,13 @@ test_expect_success 'scalar reconfigure' '
>         test true = "$(git -C one/src config core.preloadIndex)"
>  '
>
> +test_expect_success 'scalar delete without enlistment shows a usage' '
> +       test_expect_code 129 scalar delete
> +'
> +
> +test_expect_success 'scalar delete with enlistment' '
> +       scalar delete cloned &&
> +       test_path_is_missing cloned
> +'
> +
>  test_done
> --
> gitgitgadget
