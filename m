Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDC41F404
	for <e@80x24.org>; Thu,  8 Mar 2018 19:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933755AbeCHT1D (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 14:27:03 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:44525 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeCHT1C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 14:27:02 -0500
Received: by mail-pf0-f176.google.com with SMTP id 17so294604pfw.11
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 11:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FMR6R+pPFmEOOjJ4KZoRoBNOsH1B0x/jGWHo84ju018=;
        b=BjvHiwGEdB8dUCUIJTnK2SRI6daNXJIvofSczU4XzOubISLtO2emBZI4DPTFVCycvQ
         KXh2TTtKi5EUPiF7ZOKBcbQq73brAJX/qQXqbx3GT0gqSmK3T33mVpWJ/TGhISmxmaC2
         7/wp02StiMFTKN7VZXJ/9Gc7Jk29eqFBYigm5UUKrjODgfhuH3hHJvJbcSh0l9/zqNfZ
         vrgZZ+w4LKCCi/nD31jH+KS+ApEGvlq5LsvjAAIp2jkAlpzB0XNSpBaH5rjfbrDnqCvK
         I1znXCFMW46OsUkZhWqFRRdP+R9wbMcnW3xaVh2PT50UBVZ8vaqxZI/6Jr6nePrBxinA
         7i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FMR6R+pPFmEOOjJ4KZoRoBNOsH1B0x/jGWHo84ju018=;
        b=hsZ2TXFIujBDVpnexh8ZR8csJpLB9X9o6hf3SucQppJzzPcHB05dre7Mm7vbTt5eXu
         11KsMlwhuFVuGaVuCpf31oh3QuzGaU8cHFPTViDQWT2hweTJpFVR5smtcm79URUwoWS/
         Ijn7Qvha/VkUxpktVM3jjPBBZcJ2pqRUB5WNtUXPu0gawcBl58r9dtADiULanFzG7Jyt
         JZQxn+xGFz0AHQjPVc/q2ROzsZ/jxIeQUE48yGlg3MxN777ALCy8mQUhxZWojrWXdnyE
         IlHLV+GjwbIEtl2y2atvx6oEzXNt+elvbZ/1vyCBkz9/1bmkvgmL759dbHAIB9DuTo6P
         BSEw==
X-Gm-Message-State: APf1xPDH4zaS1WygWT2QTsFs0PWQr6D6+ipjHpg6Up+yReH3TplVqTpt
        XbDMDWzQpSPF2xcvJfeLPraZhReVNxX3CFXwrtY=
X-Google-Smtp-Source: AG47ELtQ+byJ2KkLBv9d8uZ/UrER2/B2GmsfDhYlYCqnci8CQmJ7Wf0u0dAuFNkWn8/8dsgtCa8CUvYvcJsid6zS3gA=
X-Received: by 10.98.87.80 with SMTP id l77mr27578306pfb.32.1520537222079;
 Thu, 08 Mar 2018 11:27:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Thu, 8 Mar 2018 11:27:01 -0800 (PST)
In-Reply-To: <20180306193116.23876-1-ungureanupaulsebastian@gmail.com>
References: <20180306193116.23876-1-ungureanupaulsebastian@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 8 Mar 2018 20:27:01 +0100
Message-ID: <CAN0heSrnERYggyJ8bL1nAV=X2JQYS8aOkc6nWZhnZu3oqhzAfA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4] Make options that expect object ids less chatty
 if id is invalid
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul-Sebastian

On 6 March 2018 at 20:31, Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
> Usually, the usage should be shown only if the user does not know what
> options are available. If the user specifies an invalid value, the user
> is already aware of the available options. In this case, there is no
> point in displaying the usage anymore.
>
> This patch applies to "git tag --contains", "git branch --contains",
> "git branch --points-at", "git for-each-ref --contains" and many more.

Thanks for scratching this itch.

>  8 files changed, 110 insertions(+), 14 deletions(-)
>  create mode 100755 t/tcontains.sh
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 9dcb367b9..a5fbec8fb 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -728,6 +728,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>                             PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
>         for (;;) {
>                 switch (parse_options_step(&ctx, options, blame_opt_usage)) {
> +               case PARSE_OPT_ERROR:
>                 case PARSE_OPT_HELP:
>                         exit(129);
>                 case PARSE_OPT_DONE:
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index e29875b84..0789e2eea 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -282,6 +282,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
>
>         for (;;) {
>                 switch (parse_options_step(&ctx, options, shortlog_usage)) {
> +               case PARSE_OPT_ERROR:
>                 case PARSE_OPT_HELP:
>                         exit(129);
>                 case PARSE_OPT_DONE:
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 58d1c2d28..34adf55a7 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1059,6 +1059,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>                         break;
>                 switch (parseopt_state) {
>                 case PARSE_OPT_HELP:
> +               case PARSE_OPT_ERROR:
>                         exit(129);
>                 case PARSE_OPT_NON_OPTION:
>                 case PARSE_OPT_DONE:

> diff --git a/parse-options.c b/parse-options.c
> index d02eb8b01..47c09a82b 100644
> --- a/parse-options.c
> +++ b/parse-options.c
[...]
>  int parse_options_end(struct parse_opt_ctx_t *ctx)
> @@ -539,6 +540,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
>         parse_options_start(&ctx, argc, argv, prefix, options, flags);
>         switch (parse_options_step(&ctx, options, usagestr)) {
>         case PARSE_OPT_HELP:
> +       case PARSE_OPT_ERROR:
>                 exit(129);
>         case PARSE_OPT_NON_OPTION:
>         case PARSE_OPT_DONE:

These are very slightly inconsistent with the ordering of
PARSE_OPT_ERROR and PARSE_OPT_HELP. I don't think it matters much. ;-)

> diff --git a/t/tcontains.sh b/t/tcontains.sh
> new file mode 100755
> index 000000000..4856111ff
> --- /dev/null
> +++ b/t/tcontains.sh

This filename is not on the usual form, t1234-foo. As a result, it it is
not picked up by `make test`, so isn't actually exercised. I believe you
selected this name based on the feedback in [1], but I do not think that
this ("tcontains.sh") was what Junio had in mind. Running the script
manually succeeds though. :-)

> @@ -0,0 +1,92 @@
> +#!/bin/sh
> +
> +test_description='Test "contains" argument behavior'

Ok, that matches the file name.

> +test_expect_success 'setup ' '
> +       git init . &&
> +       echo "this is a test" >file &&
> +       git add -A &&
> +       git commit -am "tag test" &&
> +       git tag "v1.0" &&
> +       git tag "v1.1"
> +'

You might find `test_commit` helpful. All in all, this could be a
two-liner (this example is white-space mangled though):

test_expect_success 'setup ' '
        test_commit "v1.0" &&
        git tag "v1.1"
'

> +test_expect_success 'tag usage error' '
> +       test_must_fail git tag --noopt 2>actual &&
> +       test_i18ngrep "usage" actual
> +'

Hmm, this one and a couple like it do not match the filename or test
description. I wonder if these are needed at all, or if some checks like
these are already done elsewhere (maybe not for "git tag", but for some
other user of the option-parsing machinery).

I hope you find this useful.

Martin

[1] https://public-inbox.org/git/xmqqinar1bq2.fsf@gitster-ct.c.googlers.com/
