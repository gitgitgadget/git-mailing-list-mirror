Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E788202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 20:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbdCIUQI (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 15:16:08 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35412 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdCIUQH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 15:16:07 -0500
Received: by mail-lf0-f65.google.com with SMTP id v2so5438708lfi.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 12:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bFB95qU0eW0ZlKi2cO3ezRZ+DE4iy9/kveaCLOmiORk=;
        b=qkzGS/ufb9dTATXNgwBTABTdl5egarUcMcuWJaPD5eRtA/PEDh4SjI3b/uvquMj7ul
         2U8C1UHoTDXYSHUAu4rTK5Cc8lRDS9/4BymgE+4xULGxGFNc1Dslf8b9r+WmXLPkLpNn
         +pIGaqSQUhEcmBKBFCLopUksRjUtUQCcGzhh88BWE2A2bCyiWRyNoLFUFMpY6zP1a1bE
         Cwgd3hC6Dkiva/M/FEEy8hpXu3VpEAo1SVJoJ3xQGOjZaBpVVCUFwo7YDqEuIPaIjs47
         egnOsUHa4nWCWbicXeZ6E9LInMrncI+aaGEi4fGN8LH627NfgKK08S+zud/Yo7yVrLUi
         hGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bFB95qU0eW0ZlKi2cO3ezRZ+DE4iy9/kveaCLOmiORk=;
        b=O3szfidfCBYpglhXib5yCJjSztVNY6z5P+fckQGfkYiaQWEuAqZEQF+kZqSBNw5uFv
         Qz/KO0ZX8p0GgfWpFOcM+QGhe3mYxctfI2M0TzSNGaD5FsXgDyjdL/Jiy6nRFALVubXs
         B/jPYzv5x5B9kuvztATp3gqQr9WbvlZab4vkzVm6tPe9oGqJHLKZ4TOyGk5n3Rdwu3td
         hgl+SoDk/22EBP5eCIkNksmI15sWV4kWw6qztG4hUohQD3nEJGOOE6dHKOnHDg5arq7i
         lSBFzs1kZUTtEoH26RwDISYoJZhonrKjLGQyCH376NYPMmTLlu2w061vT1WH2bbWQfpZ
         UQQA==
X-Gm-Message-State: AMke39mYMo56FoVNBhidJwhBrHMcPGpsryeaaVqXbHnn17PIGRGEaT/60ylTrkvmU0I/SJod59qZuc2SOYs76A==
X-Received: by 10.25.196.21 with SMTP id u21mr3753117lff.81.1489090559730;
 Thu, 09 Mar 2017 12:15:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Thu, 9 Mar 2017 12:15:59 -0800 (PST)
In-Reply-To: <20170309190310.30589-1-pc44800@gmail.com>
References: <20170309190310.30589-1-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Mar 2017 21:15:59 +0100
Message-ID: <CAP8UFD1xQnR8aWVRqu1_k2qhEcR2fOdyHT51aUyq9EdFg7f7Xw@mail.gmail.com>
Subject: Re: [PATCH] t2027: avoid using pipes
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Jon Loeliger <jdl@jdl.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 8:03 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> From: Prathamesh <pc44800@gmail.com>
>
> Whenever a git command is present in the upstream of a pipe, its failure
> gets masked by piping and hence it should be avoided for testing the
> upstream git command. By writing out the output of the git command to
> a file, we can test the exit codes of both the commands as a failure exit
> code in any command is able to stop the && chain.
>
> Signed-off-by: Prathamesh <pc44800@gmail.com>
> ---

When you post a new version of a patch or a patch series, could you do
the following:

- add v2 or v3, or ... after "PATCH" in the subject, so that we know
which version it is (see the mailing list archive and the format-patch
documentation to see how it should appear and how to do it)
- tell what you changed since the previous version, and maybe also why
you made those changes, if it has not already been explained or
discussed (you can do it after the "---" above and before the file
stats below, or in a separate email replying to the patch, or in the
cover letter of the patch series if you are sending a patch series)

>  t/t2027-worktree-list.sh | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> index 848da5f36..d8b3907e0 100755
> --- a/t/t2027-worktree-list.sh
> +++ b/t/t2027-worktree-list.sh
> @@ -31,7 +31,8 @@ test_expect_success '"list" all worktrees from main' '
>         test_when_finished "rm -rf here && git worktree prune" &&
>         git worktree add --detach here master &&
>         echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
> -       git worktree list | sed "s/  */ /g" >actual &&
> +       git worktree list >out &&
> +       sed "s/  */ /g" <out >actual &&
>         test_cmp expect actual
>  '

[...]

> @@ -118,9 +122,9 @@ test_expect_success 'broken main worktree still at the top' '
>                 cd linked &&
>                 echo "worktree $(pwd)" >expected &&
>                 echo "ref: .broken" >../.git/HEAD &&
> -               git worktree list --porcelain | head -n 3 >actual &&
> +               git worktree list --porcelain >out && head -n 3 out >actual &&
>                 test_cmp ../expected actual &&
> -               git worktree list | head -n 1 >actual.2 &&
> +               git worktree list >out && head -n 1 out >actual.2 &&

I think it would be better if the 'head' commands above and the 'grep'
command below were also on their own line.

>                 grep -F "(error)" actual.2
>         )
>  '
> @@ -134,7 +138,7 @@ test_expect_success 'linked worktrees are sorted' '
>                 test_commit new &&
>                 git worktree add ../first &&
>                 git worktree add ../second &&
> -               git worktree list --porcelain | grep ^worktree >actual
> +               git worktree list --porcelain >out && grep ^worktree out >actual
>         ) &&
>         cat >expected <<-EOF &&
>         worktree $(pwd)/sorted/main
> --
> 2.11.0
>
