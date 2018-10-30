Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D89CC1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 15:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJaAXa (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 20:23:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51099 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeJaAX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 20:23:29 -0400
Received: by mail-it1-f196.google.com with SMTP id k206-v6so14204477ite.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMsUpqiXAJV0x6sqKoACggex0pG8Di/55nDJDya34Tw=;
        b=q3l9eeKGxGaPvXJmz7T7xGYba8qve8daAx9FSiGYUjnZeCCcLfM5iyK83tQO8Q+YEZ
         2ue3Bf2rTMpXobviK57RVQJkWSoBcXfYZpSxGdexfPWNOhuMixRIJFwGTkVZmTtR+0Vn
         Hm31Lg0YFgn5sbsmIQTN7TFJGb0J/XG0dw/cU/Qxkbn6lJ2NlZav1R0kPbK/cfzoBvv6
         IJwWByzEYPNTqVUhSnuw+WsxKiZVfWxfWsPD4frgGO2POlq+KKb3cRxRpRW8m/5YbmLO
         g9xHjwPIHJq5rY+f5m+oH1cS2HhMnw0IptKdunsxItF0W6L+RbSzU9hn8b2uiDJm6WWA
         huPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMsUpqiXAJV0x6sqKoACggex0pG8Di/55nDJDya34Tw=;
        b=K/kY4gWZIJecfH8ja4csoCnvlUb/2KjFTAPjv9+0OWfE3wCxzgKUO+j5w31S9fRs43
         /xsZrPSdaGKgnYC0eTCptpT6FouAI+FcO5HXv+y5qyhdmViUIOmPEH/K02zCanBDTarc
         Lx0WqiHmB1K7+T0qycpTr61cJsgtgujYDiVpSpF8lNP11nqbWt/Y+H0oR5SChGrQdSMk
         5IUCEQilVG+Cm9ZNnuMUjsE63nDCLTiY0wRl019AqFfVOoGyZ9V9BZWM9lNOsCG2lCUR
         8ZYPr4IA7bXHBYyS1CB4sGqXjIAw3vH2W5h3ZzljHFfun1Z6YhhCZN/Y0gdq7KDGUr+7
         aF+Q==
X-Gm-Message-State: AGRZ1gKMbmVA1LuKjl6cRLYww07CDXLrdyVdz0iEc28GetHrZEEEoi/4
        HZQW1ueNYZN9nrIYU9rlRkH5O9SfO2h0EZ3tp4g=
X-Google-Smtp-Source: AJdET5fbcGOGaVUYyXsxYnrup7//5VQmh17rSUk2PbQFanKO7Zrw1uh6VRRaEmzrXgyS+E0xLKYChmfgN/DjVUbBfpw=
X-Received: by 2002:a02:958a:: with SMTP id b10-v6mr14064018jai.130.1540913373851;
 Tue, 30 Oct 2018 08:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com> <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
In-Reply-To: <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 30 Oct 2018 16:29:07 +0100
Message-ID: <CACsJy8Ajc0qWw3RLak1PRPXvQzMHjaFuWJ6BPkhiVg=7fQvCnA@mail.gmail.com>
Subject: Re: [PATCH v2] completion: use builtin completion for format-patch
To:     liu.denton@gmail.com,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, anmolmago@gmail.com,
        briankyho@gmail.com, david.lu97@outlook.com,
        shirui.wang@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 7:39 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> This patch offloads completion functionality for format-patch to
> __gitcomp_builtin. In addition to this, send-email was borrowing some
> completion options from format-patch so those options are moved into
> send-email's completions.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> I ran t9902-completion.sh on this patch and it seems to pass. Thus, this
> should address the concerns about losing some completion options in
> send-email.
>
> ---
>  contrib/completion/git-completion.bash | 34 +++++++++++---------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d63d2dffd..cb4ef6723 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1531,15 +1531,6 @@ _git_fetch ()
>         __git_complete_remote_or_refspec
>  }
>
> -__git_format_patch_options="
> -       --stdout --attach --no-attach --thread --thread= --no-thread
> -       --numbered --start-number --numbered-files --keep-subject --signoff
> -       --signature --no-signature --in-reply-to= --cc= --full-index --binary
> -       --not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
> -       --inline --suffix= --ignore-if-in-upstream --subject-prefix=
> -       --output-directory --reroll-count --to= --quiet --notes
> -"
> -
>  _git_format_patch ()
>  {
>         case "$cur" in
> @@ -1550,7 +1541,7 @@ _git_format_patch ()
>                 return
>                 ;;
>         --*)
> -               __gitcomp "$__git_format_patch_options"
> +               __gitcomp_builtin format-patch

We do want to keep some extra options back because __gitcomp_builtin
cannot show all supported options of format-patch. The reason is a
subset of options is handled by setup_revisions() which does not have
--git-completion-helper support.

> @@ -2080,16 +2071,19 @@ _git_send_email ()
>                 return
>                 ;;
>         --*)
> -               __gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
> -                       --compose --confirm= --dry-run --envelope-sender
> -                       --from --identity
> -                       --in-reply-to --no-chain-reply-to --no-signed-off-by-cc
> -                       --no-suppress-from --no-thread --quiet --reply-to
> -                       --signed-off-by-cc --smtp-pass --smtp-server
> -                       --smtp-server-port --smtp-encryption= --smtp-user
> -                       --subject --suppress-cc= --suppress-from --thread --to
> -                       --validate --no-validate
> -                       $__git_format_patch_options"
> +               __gitcomp "--all --annotate --attach --bcc --binary --cc --cc= --cc-cmd
> +                       --chain-reply-to --compose --confirm= --cover-letter --dry-run
> +                       --dst-prefix= --envelope-sender --from --full-index --identity
> +                       --ignore-if-in-upstream --inline --in-reply-to --in-reply-to=
> +                       --keep-subject --no-attach --no-chain-reply-to --no-prefix
> +                       --no-signature --no-signed-off-by-cc --no-suppress-from --not --notes
> +                       --no-thread --no-validate --numbered --numbered-files
> +                       --output-directory --quiet --reply-to --reroll-count --signature
> +                       --signed-off-by-cc --signoff --smtp-encryption= --smtp-pass
> +                       --smtp-server --smtp-server-port --smtp-user --src-prefix=
> +                       --start-number --stdout --subject --subject-prefix= --suffix=
> +                       --suppress-cc= --suppress-from --thread --thread= --to --to=
> +                       --validate"

I have no comment about this. In an ideal world, sendemail.perl could
be taught to support --git-completion-helper but I don't think my
little remaining Perl knowledge (or time) is enough to do it. Perhaps
this will do. I don't know.
-- 
Duy
