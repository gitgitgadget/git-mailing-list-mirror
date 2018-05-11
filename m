Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3AD1F406
	for <e@80x24.org>; Fri, 11 May 2018 14:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753035AbeEKOG3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 10:06:29 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41097 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeEKOG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 10:06:28 -0400
Received: by mail-ua0-f196.google.com with SMTP id a3-v6so3667879uad.8
        for <git@vger.kernel.org>; Fri, 11 May 2018 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mfWPh5NcUMwDGnqQBb2wgZ3UOlvCMiCXfZiwI6B7rXM=;
        b=hm92NgQXr5SXUw96joDqvPj+MB7rr0oEcGB1lG+Kf8I/VD7ep8bh89iFwPLwfi/dxs
         7+UZL4c8C3mkTxGX9jQ0jfIkDS+L57Z4uEJs0hvfgTuOCvOtp6Cv230P8W6GXkXvQYaV
         9el9pAdLjeFfSf2uzqWvpX2bSwv61dtkZnmAPfbtdRpfcRSeLfQDX05o/uV74RVQeLoW
         WQ623AHPVyGozFQJsDsBH/wZAX+8S3EWnM3J09/rBOyFRzFE2giylxKO8uCN68vHhX7m
         jDsCfgwNQz8z+SlHoP9RitP0ahnByU0pCCaAcdvWuCDydOVNhpTHjgt73kc0gu3fEGdK
         QUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mfWPh5NcUMwDGnqQBb2wgZ3UOlvCMiCXfZiwI6B7rXM=;
        b=PmGXgfFL0bkwwWRn0VqHPBdAFO8Sw7tfECt+M86G0v0A6OYvaXtNt6UaI3H4Nz9bBU
         BLAcz8dw3SzsVwratMYNDcLFh3eO7Q11nYhsh4cwTKLEZCyvMQRcOPk39KvCt4O9Fzag
         Zu8nWSGH2O6ju+XrGPhZrtB8bJeCMO7Sw34LOuON2lsWyZXq8jK4gxY9hIWAK8fro3cg
         6VxGPujLi0ffJSFilehgtaolS6dZQ06/oTL1BHZ/P6uogGA2FbCM9Af6vJrB6kg6gm4y
         J5AMKNB7SVGU5rjr8NR5WBY5wxPDkJ8H6Ot0gZFm6XAtIj1qCIAvYD/bbbNAa9HXj1Td
         ZyEQ==
X-Gm-Message-State: ALKqPwetCdXeoufRNATsVsJOWa/bTp4DHj8Ti7mQgjdhmHC6rHFX+6Od
        Xi64KI2sU+cfQME9I8ZBqAnJ5mXjyKWB9Kw84dfA3w==
X-Google-Smtp-Source: AB8JxZo8jh9B3wG0yoHt8J6wiOAqrVt61SSRmN0ZlBDMC9W62zpZ30nwQDTubkmle+V5t30pD1EqC4BIIvGFSsSSEFw=
X-Received: by 2002:ab0:5bd6:: with SMTP id z22-v6mr1560112uae.48.1526047587411;
 Fri, 11 May 2018 07:06:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.22.212 with HTTP; Fri, 11 May 2018 07:06:27 -0700 (PDT)
In-Reply-To: <20180510084652.25880-8-pclouds@gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com> <20180510084652.25880-1-pclouds@gmail.com>
 <20180510084652.25880-8-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 11 May 2018 16:06:27 +0200
Message-ID: <CAM0VKjk3kqKpVz0ZjX58REwP8rz08kLsiVR4NWDO6-9iPGPe9g@mail.gmail.com>
Subject: Re: [PATCH v7 07/13] completion: implement and use --list-cmds=main,others
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 10:46 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> Instead of parsing "git help -a" output, which is tricky to get right,
> less elegant and also slow,

Is it tricky?  It seems rather straightforward.
Is it slow?  Well, there is a pipe and an egrep, sure, but thanks to
caching it's only run once, so basically doesn't matter.

OTOH you don't mention the most important reason, namely that the
completion script contains a long hard-coded list of the names of all
known plumbing commands to filter out, which is redundant with the
categorization in 'command-list.txt', is a maintenance burden, and
tends to get out-of-sync when new plumbing commands are added.

> make git provide the list in a
> machine-friendly form. This adds two separate listing types, main and
> others, instead of just "all" for more flexibility.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  contrib/completion/git-completion.bash |  2 +-
>  git.c                                  |  4 ++++
>  help.c                                 | 32 ++++++++++++++++++++++++++
>  help.h                                 |  4 ++++
>  4 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 3556838759..62ca8641f4 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -839,7 +839,7 @@ __git_commands () {
>         then
>                 printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
>         else
> -               git help -a|egrep '^  [a-zA-Z0-9]'
> +               git --list-cmds=3Dmain,others
>         fi
>  }
>
> diff --git a/git.c b/git.c
> index 376a59b97f..10907f7266 100644
> --- a/git.c
> +++ b/git.c
> @@ -56,6 +56,10 @@ static int list_cmds(const char *spec)
>
>                 if (match_token(spec, len, "builtins"))
>                         list_builtins(&list, 0);
> +               else if (match_token(spec, len, "main"))
> +                       list_all_main_cmds(&list);
> +               else if (match_token(spec, len, "others"))
> +                       list_all_other_cmds(&list);
>                 else
>                         die(_("unsupported command listing type '%s'"), s=
pec);
>                 spec +=3D len;
> diff --git a/help.c b/help.c
> index 2d6a3157f8..d5ce9dfcbb 100644
> --- a/help.c
> +++ b/help.c
> @@ -297,6 +297,38 @@ void list_common_cmds_help(void)
>         print_cmd_by_category(common_categories);
>  }
>
> +void list_all_main_cmds(struct string_list *list)
> +{
> +       struct cmdnames main_cmds, other_cmds;
> +       int i;
> +
> +       memset(&main_cmds, 0, sizeof(main_cmds));
> +       memset(&other_cmds, 0, sizeof(other_cmds));
> +       load_command_list("git-", &main_cmds, &other_cmds);
> +
> +       for (i =3D 0; i < main_cmds.cnt; i++)
> +               string_list_append(list, main_cmds.names[i]->name);
> +
> +       clean_cmdnames(&main_cmds);
> +       clean_cmdnames(&other_cmds);
> +}
> +
> +void list_all_other_cmds(struct string_list *list)
> +{
> +       struct cmdnames main_cmds, other_cmds;
> +       int i;
> +
> +       memset(&main_cmds, 0, sizeof(main_cmds));
> +       memset(&other_cmds, 0, sizeof(other_cmds));
> +       load_command_list("git-", &main_cmds, &other_cmds);
> +
> +       for (i =3D 0; i < other_cmds.cnt; i++)
> +               string_list_append(list, other_cmds.names[i]->name);
> +
> +       clean_cmdnames(&main_cmds);
> +       clean_cmdnames(&other_cmds);
> +}
> +
>  int is_in_cmdlist(struct cmdnames *c, const char *s)
>  {
>         int i;
> diff --git a/help.h b/help.h
> index b21d7c94e8..97e6c0965e 100644
> --- a/help.h
> +++ b/help.h
> @@ -1,6 +1,8 @@
>  #ifndef HELP_H
>  #define HELP_H
>
> +struct string_list;
> +
>  struct cmdnames {
>         int alloc;
>         int cnt;
> @@ -17,6 +19,8 @@ static inline void mput_char(char c, unsigned int num)
>  }
>
>  extern void list_common_cmds_help(void);
> +extern void list_all_main_cmds(struct string_list *list);
> +extern void list_all_other_cmds(struct string_list *list);
>  extern const char *help_unknown_cmd(const char *cmd);
>  extern void load_command_list(const char *prefix,
>                               struct cmdnames *main_cmds,
> --
> 2.17.0.705.g3525833791
>
