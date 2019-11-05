Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C74D1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 23:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfKEXte (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 18:49:34 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41693 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfKEXtd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 18:49:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id 94so19231998oty.8
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 15:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGkq+7MwfrUze5H1xDC30/q0GGll5C/6d05puY9tIPU=;
        b=WheIZOswSLo4ZAK7Gl6t5eGUftxyWOedidEetmwiuHs1+54JqJbg7XwN/TrmutXlCP
         q6+imntBPUr7cacW5QoEN/tTIpMhCInfu4kF2Y5NTmxKUuHQqMV30cL9GZNbZsVhWFQs
         QhXHmdHKdksFkOCI2Ivmg1gD6DNQSyyMMb/jviXuB4uSilhjUYq6H6MD8iAzQsZMuauX
         ggK9yNeYQ8R0TIPkZ0N8tu5DWHUTgRZvwyOofEYVm3r741zrucAJcH0k+IoQA09q3yKE
         LtSkzkQmIRQSIRbOrXJbOlRBRCqxQgENFw6Pl58aDLaum4vT5UvmcQ69QL2vS5jzvCTZ
         lC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGkq+7MwfrUze5H1xDC30/q0GGll5C/6d05puY9tIPU=;
        b=X4ImtVQvAxtLZN6rTu63gx+VUbCaOsBQRQJfq3LeEqTgTrjTbhmTV5apEK5fGQlbVn
         maof4wMuf5YlxZFDf/fDlKd0qb/SDg/85hHl6iXK5Lmfrhmon8nAe3cb+p1ccMJ217Lo
         Fkxo5Ki35qgVWsMeEQ2dd1I0DDUShMgOKRrOuDrNxg+ogrqhYB2HSyJy7mwAUM2qVXmx
         gHv6schVsvPxKlePDgSAyeGeZvKv435Z5ffdVSvxzFPjHn/KUHnTVEzz4VvBvq0wVxx1
         jcmyuIlSI5NSUfT7AGy7rfD95YsuQ7/A3jZ3Fi+2uWMqNK8sO0Cz54F5S2JzQEEioAu4
         yfIQ==
X-Gm-Message-State: APjAAAXkmAdL2zw2BxzjXYE8g5CoqzGZIL0AmyK+vq+azUNwNvrVjtps
        PtaFS7RqnXCyL34VFeF8+0iBHWSledG8zX233MM=
X-Google-Smtp-Source: APXvYqyQVxflw2UEchV8rRpsqiQcnxv5YnuhIVAOz3rZCSzPIrPIzFa2X+xy5y6ZTFKN54GaDd+KEZVWOCwViPKmavA=
X-Received: by 2002:a05:6830:1507:: with SMTP id k7mr21619518otp.316.1572997772250;
 Tue, 05 Nov 2019 15:49:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.447.git.1572995581.gitgitgadget@gmail.com> <51df6661f772b08eef709fcc36ba11a158ba6fad.1572995581.git.gitgitgadget@gmail.com>
In-Reply-To: <51df6661f772b08eef709fcc36ba11a158ba6fad.1572995581.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Nov 2019 15:49:21 -0800
Message-ID: <CABPp-BFDyMxre=gp64sgHyZtMbe-EL=ke3b5FA6CwsqbcdyJBQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Improve unpack trees error text
To:     naiduv via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        naiduv <naiduvenkat@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the contribution.  Looks like we were on similar
wavelengths, as I also contributed a fix to this phrasing just a
quarter of a day before you:
https://public-inbox.org/git/466aead9af6516ff94a5d217e58ab894e63088b7.1572973651.git.gitgitgadget@gmail.com/

On Tue, Nov 5, 2019 at 3:15 PM naiduv via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: naiduv <naiduvenkat@gmail.com>
>
> Signed-off-by: naiduv <naiduvenkat@gmail.com>
> ---
>  t/t7110-reset-merge.sh | 4 ++--
>  unpack-trees.c         | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> index a82a07a04a..9b2298bfb3 100755
> --- a/t/t7110-reset-merge.sh
> +++ b/t/t7110-reset-merge.sh
> @@ -173,7 +173,7 @@ test_expect_success 'reset --merge fails with changes in file it touches' '
>      sed -e "s/line 1/changed line 1/" <file1 >file3 &&
>      mv file3 file1 &&
>      test_must_fail git reset --merge HEAD^ 2>err.log &&
> -    grep file1 err.log | grep "not uptodate"
> +    grep file1 err.log | grep "not up to date"
>  '
>
>  # The next test will test the following:
> @@ -189,7 +189,7 @@ test_expect_success 'reset --keep fails with changes in file it touches' '
>      sed -e "s/line 1/changed line 1/" <file1 >file3 &&
>      mv file3 file1 &&
>      test_must_fail git reset --keep HEAD^ 2>err.log &&
> -    grep file1 err.log | grep "not uptodate"
> +    grep file1 err.log | grep "not up to date"
>  '
>
>  test_expect_success 'setup 3 different branches' '
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 33ea7810d8..74c348d40e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -29,7 +29,7 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
>         "Entry '%s' would be overwritten by merge. Cannot merge.",
>
>         /* ERROR_NOT_UPTODATE_FILE */
> -       "Entry '%s' not uptodate. Cannot merge.",
> +       "Entry '%s' is not up to date. Cannot merge.",

According to https://writingexplained.org/up-to-date-hyphenated, "up
to date" is an adverb phrase (which would not be correct to use here),
while "up-to-date" is the adjectival phrase.

>         /* ERROR_NOT_UPTODATE_DIR */
>         "Updating '%s' would lose untracked files in it",
> @@ -44,7 +44,7 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
>         "Entry '%s' overlaps with '%s'.  Cannot bind.",
>
>         /* ERROR_SPARSE_NOT_UPTODATE_FILE */
> -       "Entry '%s' not uptodate. Cannot update sparse checkout.",
> +       "Entry '%s' is not up to date. Cannot update sparse checkout.",
>
>         /* ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN */
>         "Working tree file '%s' would be overwritten by sparse checkout update.",

This patch misses a similar usage within gitk that would need to be
updated for this change.
