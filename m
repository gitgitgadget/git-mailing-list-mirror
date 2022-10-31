Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE718C38A02
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 10:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJaKzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 06:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJaKy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 06:54:57 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE97C1171
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 03:54:52 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id j2so71956ybb.6
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 03:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=APvw90kLnXhSd6yMz/gWODkAYdRNldtlxpnjHEnKh48=;
        b=K/48dR7vtMMvccWLT35Bmv4x+DdFOqyvQvW3BprOPcg1KiooM6q9851zI+DXkn9nq9
         LyHNrH1NFZPh7v0ON4DYSNw7hefFly141EJRUmJ23xIXoVn1F8apoS/3e55J1uSebhwT
         PDzJoSATSc0QTLQ5/gp1YCQ95E2oNcpBsEH7bSr/UKXutU2J8BfqaEAH1/SJZx4GdeHT
         ZCIWVrGzLL0UZzXPCYcnMw1natEc/zSWeHrkt92pzgbCiOU0oVj3jDsDW233MAqKukdU
         X2wZF7OYMIoUOcMf7o3WZAdi5GGqNNtflkKiI+G0fuH87fhDYgYhbS0cGZW6IFXwCiqD
         2uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APvw90kLnXhSd6yMz/gWODkAYdRNldtlxpnjHEnKh48=;
        b=RBmaFUABv4rl3daaWKCvHm5iOHi+NXyh84U9/nmUtzRYgAmXLaSUJCCpainWcOJAPv
         v6x7EYmzOuQdgFa7u3ED55j74+CrbCXlHZPasSeRcN3OEGk6c/xfQKNpdg3808s2dyoS
         kvXgPgfEt1VZU21nKdeTnPJaqObVmMdAXsaePLD0wCUiM7QQvPoC9ilI4gqlvFmVGW9q
         K1adZuDHlCdu6ktg3laPNuEJropeIji5az7Q5MP+Ob+KPC7JJ83RBV9ElHjR527TPwfd
         xHC4mOQDfFx6GI3d+s2ARvPVj5gb1lZGi0z7WdcJEurSHefM9tQqt21xM/Mp+qLX2eiI
         7oRw==
X-Gm-Message-State: ACrzQf13q8IGZn7LlBPR+PDQfgj9wp0lpwaW2+eXA6eL35HwA/NQNIGN
        THphvDW89rdEglR9GbgYWKJHwyaAdTJ8jQptep7rb6Pxaa8=
X-Google-Smtp-Source: AMsMyM4KAV1Ir1tgALyf4YwYk6boUD8JdBIqEiNwYMWsv+rlKFkNSH6ypmG65wPCVPpuKIHfCJl5KJa4R5F+Ofu0xz8=
X-Received: by 2002:a05:6902:10ca:b0:671:3616:9147 with SMTP id
 w10-20020a05690210ca00b0067136169147mr11615933ybu.105.1667213691611; Mon, 31
 Oct 2022 03:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220923193543.58635-1-siddharthasthana31@gmail.com> <20221029092513.73982-1-siddharthasthana31@gmail.com>
In-Reply-To: <20221029092513.73982-1-siddharthasthana31@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 31 Oct 2022 11:54:40 +0100
Message-ID: <CAP8UFD2vLnE8Suf259RWQk2fcq+gDFTi+cDr9mrbidY49n3Lzw@mail.gmail.com>
Subject: Re: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2022 at 11:25 AM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> The command git cat-file can now use the mailmap mechanism to replace
> idents with their canonical versions for commit and tag objects. There
> are several options like `--batch`, `--batch-check` and
> `--batch-command` that can be combined with `--use-mailmap`. But, the
> documentation for `--batch`, `--batch-check` and `--batch-command`
> doesn't say so. This patch fixes that documentation.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>
> This patch was previously sent as the first patch of a 3 patch series for
> adding the mailmap support in git cat-file options:
> https://lore.kernel.org/git/20220916205946.178925-2-siddharthasthana31@gmail.com/

I think Taylor is probably right that there should be a version number
at the start of the subject line if the patch has already been sent
many times with the same subject and mostly the same content to the
list.

> Changes in v2:
> - Fixed the names in trailers in the commit message
> - Updated the documentation to clearly state that the `--batch-check`,
>   `--batch-command` and `--batch` options can only be used with
>   `--textconv`, `--filters` or `--use-mailmap`.
> - Fixed formatting
>
> Changes in v3:
> - Fixed formatting
>
> Changes in v4:
> - Fixed some grammatical errors

The version number should logically be "v4" according to the above.

>  Documentation/git-cat-file.txt | 45 ++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index ec30b5c574..db2bba9b65 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -89,26 +89,45 @@ OPTIONS
>  --batch::
>  --batch=<format>::
>         Print object information and contents for each object provided
> -       on stdin.  May not be combined with any other options or arguments
> -       except `--textconv` or `--filters`, in which case the input lines
> -       also need to specify the path, separated by whitespace.  See the
> -       section `BATCH OUTPUT` below for details.
> +       on stdin. May not be combined with any other options or arguments
> +       except --textconv, --filters, or --use-mailmap.
> +       +
> +       * When used with `--textconv` or `--filters`, the input lines
> +         must specify the path, separated by whitespace. See the section
> +         `BATCH OUTPUT` below for details.
> +       +
> +       * When used with `--use-mailmap`, the info command shows the size
> +         of the object as if the identities recorded in it were replaced
> +         by the mailmap mechanism.

Sorry to realize this only at this point but actually I think the
`info` command is only available when the `--batch-command` option is
used, not when the `--batch` option is used.

As the `--batch` option prints both object information (which includes
the size) and contents (which includes the idents), I think something
like the following should be used here:

       * When used with `--use-mailmap`, for commit and tag objects, the
          contents part of the output shows the identities replaced using the
          mailmap mechanism, while the information part of the output shows
          the size of the object as if it actually recorded the replacement
          identities.

>  --batch-check::
>  --batch-check=<format>::
> -       Print object information for each object provided on stdin.  May
> -       not be combined with any other options or arguments except
> -       `--textconv` or `--filters`, in which case the input lines also
> -       need to specify the path, separated by whitespace.  See the
> -       section `BATCH OUTPUT` below for details.
> +       Print object information for each object provided on stdin. May not be
> +       combined with any other options or arguments except --textconv, --filters
> +       or --use-mailmap.
> +       +
> +       * When used with `--textconv` or `--filters`, the input lines must
> +        specify the path, separated by whitespace. See the section
> +        `BATCH OUTPUT` below for details.
> +       +
> +       * When used with `--use-mailmap`, the info command shows the size
> +         of the object as if the identities recorded in it were replaced
> +         by the mailmap mechanism.

Same remark about the `info` command as above.

As the `--batch-check` option prints only object information (which
includes the size), I think something like the following should be
used here:

       * When used with `--use-mailmap`, for commit and tag objects, the
          printed object information shows the size of the object as if the
          identities recorded in it were replaced by the mailmap mechanism.

>  --batch-command::
>  --batch-command=<format>::
>         Enter a command mode that reads commands and arguments from stdin. May
> -       only be combined with `--buffer`, `--textconv` or `--filters`. In the
> -       case of `--textconv` or `--filters`, the input lines also need to specify
> -       the path, separated by whitespace. See the section `BATCH OUTPUT` below
> -       for details.
> +       only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
> +       `--filters`.
> +       +
> +       * When used with `--textconv` or `--filters`, the input lines must
> +         specify the path, separated by whitespace. See the section
> +         `BATCH OUTPUT` below for details.
> +       +
> +       * When used with `--use-mailmap`, the info command shows the size
> +         of the object as if the identities recorded in it were replaced
> +         by the mailmap mechanism.

s/info command/`info` command/

And I think it could be interesting to add:

  - that it happens only for commits and tags, and
  - that when the `contents` command is used the idents are replaced.

So maybe something like:

       * When used with `--use-mailmap`, for commit and tag objects, the
         `contents` command shows the identities replaced using the
          mailmap mechanism, while the `info` command shows the size
          of the object as if it actually recorded the replacement
          identities.

Also this will become true only after your other patch series will be
merged. Which means that you should say somewhere that either

  - this patch should be merged only after the other patch series is merged, or
  - it's a bug that the `info` command doesn't show the size of the
updated object and this is going to be fixed soon by the other patch
series anyway.

Thanks for working on finishing this!
Christian.
