Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE481F404
	for <e@80x24.org>; Thu, 22 Mar 2018 17:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeCVRG5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:06:57 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42715 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeCVRG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:06:56 -0400
Received: by mail-ot0-f195.google.com with SMTP id v23-v6so10254831oth.9
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S16NY6orHYdegDFDnbZ6cMbVXEa0N3HfDWuXIOi4GM4=;
        b=AvV/uJ35nbhn6APbcn7gpArYhul6wJkVp36wdsbkNkYiFF3hrunMBDaNovwVp/dKgl
         LdIiwK+8mvtfQ9pg00IZLML6DEbhnEYF4/U7ceKBQkJ5dzMtyKpY/Ach0cykW6DimmEz
         vT2wum9k7fXa6aLTWyPLh/nwhG0aamzgymX0njP1Vuh+qLS57qBrm+2KeOkfSqSZ6Q8H
         YkupQJ5E6stQ+oj78v95HPUWnc1LJLxXChfM3VQJGh9O2veCOr2JAbwgSMfjskIs/JLa
         Bl+7jTT2S41pXrEm2nkgbWxMl226o8u52vhIkmKa57c98fssfIpCEKGQaPxxfvxhllMg
         Qjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S16NY6orHYdegDFDnbZ6cMbVXEa0N3HfDWuXIOi4GM4=;
        b=Q1o36fDPcwBg6xgVsXr+Bi+6/rwHWuiAONZ6WvRvTGz7NYczz+kXTpJ7Fon/+E9I1m
         5MceGV1gqI/H871NajSp9VZUXEM/6h6rp/58bMmq5J2MnOGKQp2sZLBIYmY8Y/qm1lRL
         Yvduhpn1cPtqWJZreIad3SbvlYI5nR3IoGoB01FlULdmP2/WL9tOJD7offTXzJR9ZFJt
         RZW+L3/m4uJ4nS2JXvf23K349i/cDM10wW+hnnd2iIfjSn2NC2ZBPcLVDLG4Yh+LFFzZ
         dLSvJyXHg9YjTsW+0+zn+xqxgy5sMovhdePzA8Ls09N5Vg8OSkQRmRDP7mIQFOh6E1dC
         v7nQ==
X-Gm-Message-State: AElRT7ER6/dTNfq4fiWVGZMnTGYeRTqNshc2jAxsaDuo230d49tQvBJ8
        DaO7paI67p7Z31kCnjYI8XLhVN/YSBygvMSmd14=
X-Google-Smtp-Source: AG47ELt3zJ4AM5DPapEpGWh6VFqs+3wQC2DwAHZWR4P2eQ8GFAiOpDaj3CPSBQTcrQ+0AzJAvuT3a2PU/GWwr8MufNc=
X-Received: by 2002:a9d:154c:: with SMTP id z12-v6mr16170805otz.65.1521738415548;
 Thu, 22 Mar 2018 10:06:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Thu, 22 Mar 2018 10:06:24 -0700 (PDT)
In-Reply-To: <20180322141604.15957-1-szeder.dev@gmail.com>
References: <20180322141604.15957-1-szeder.dev@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 22 Mar 2018 18:06:24 +0100
Message-ID: <CACsJy8DZo_ggxhg0sKXiVSDBahNBTu_Kfowvay5urapaZ7dVGw@mail.gmail.com>
Subject: Re: [PATCH] completion: clear cached --options when sourcing the
 completion script
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 3:16 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> The established way to update the completion script in an already
> running shell is to simply source it again: this brings in any new
> --options and features, and clears caching variables.  E.g. it clears
> the variables caching the list of (all|porcelain) git commands, so
> when they are later lazy-initialized again, then they will list and
> cache any newly installed commmands as well.
>
> Unfortunately, since d401f3debc (git-completion.bash: introduce
> __gitcomp_builtin, 2018-02-09) and subsequent patches this doesn't
> work for a lot of git commands' options.  To eliminate a lot of
> hard-to-maintain hard-coded lists of options, those commits changed
> the completion script to use a bunch of programmatically created and
> lazy-initialized variables to cache the options of those builtin
> porcelain commands that use parse-options.  These variables are not
> cleared upon sourcing the completion script, therefore they continue
> caching the old lists of options, even when some commands recently
> learned new options or when deprecated options were removed.
>
> Always 'unset' these variables caching the options of builtin commands
> when sourcing the completion script.

And here I have been happily unsetting these manually when I re-source
to test stuff, not thinking it as a bug. Thanks!

> Redirect 'unset's stderr to /dev/null, because ZSH's 'unset' complains
> if it's invoked without any arguments, i.e. no variables caching
> builtin's options are set.  This can happen, if someone were to source
> the completion script twice without completing any --options in
> between.  Bash stays silent in this case.
>
> Add tests to ensure that these variables are indeed cleared when the
> completion script is sourced; not just the variables caching options,
> but all other caching variables, i.e. the variables caching commands,
> porcelain commands and merge strategies as well.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>
> Fixes a recent regression introduced in 'nd/parseopt-completion'.
>
>  contrib/completion/git-completion.bash |  4 ++++
>  t/t9902-completion.sh                  | 31 ++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 7c84eb1912..602352f952 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -280,6 +280,10 @@ __gitcomp ()
>         esac
>  }
>
> +# Clear the variables caching builtins' options when (re-)sourcing
> +# the completion script.
> +unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=
=3D.*/\1/p') 2>/dev/null
> +
>  # This function is equivalent to
>  #
>  #    __gitcomp "$(git xxx --git-completion-helper) ..."
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index e6485feb0a..4c86adadf2 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1497,4 +1497,35 @@ do
>         '
>  done
>
> +test_expect_success 'sourcing the completion script clears cached comman=
ds' '
> +       __git_compute_all_commands &&
> +       verbose test -n "$__git_all_commands" &&
> +       . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +       verbose test -z "$__git_all_commands"
> +'
> +
> +test_expect_success 'sourcing the completion script clears cached porcel=
ain commands' '
> +       __git_compute_porcelain_commands &&
> +       verbose test -n "$__git_porcelain_commands" &&
> +       . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +       verbose test -z "$__git_porcelain_commands"
> +'
> +
> +test_expect_success 'sourcing the completion script clears cached merge =
strategies' '
> +       __git_compute_merge_strategies &&
> +       verbose test -n "$__git_merge_strategies" &&
> +       . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +       verbose test -z "$__git_merge_strategies"
> +'
> +
> +test_expect_success 'sourcing the completion script clears cached --opti=
ons' '
> +       __gitcomp_builtin checkout &&
> +       verbose test -n "$__gitcomp_builtin_checkout" &&
> +       __gitcomp_builtin notes_edit &&
> +       verbose test -n "$__gitcomp_builtin_notes_edit" &&
> +       . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +       verbose test -z "$__gitcomp_builtin_checkout" &&
> +       verbose test -z "$__gitcomp_builtin_notes_edit"
> +'
> +
>  test_done
> --
> 2.17.0.rc0.103.gbdc5836ed3
>



--=20
Duy
