Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6491F597
	for <e@80x24.org>; Thu,  2 Aug 2018 20:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeHBWeK (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 18:34:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42575 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeHBWeK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 18:34:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4-v6so1388845edp.9
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 13:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zQ6Ct5cYaN6y3y3849okd19zcPhtwDmT53TAUQREnAA=;
        b=UsRTKznM7K0p3zTnC3fM7uK1FqTsYX5Az/HFzjSBbmtyhT0PPGPa0SQwniPwinQ3Zy
         gWQKjV4n6fX0z8RlYXeX3ENn7eUw8cQ/Z1LXIk3SsbHVj3B7RWixBZewk7voGf4pF3Ty
         hVTUO3QLYI3KMABwAn1bK0YDzNqG+e1efD80nvz3LO2kutXOXBA1VQ78sv1oacJIW3Mc
         /zlsxY18JEySE9CNQBd/KWPf35ALg+mdrYRNYonkDiR1xiUabkqV/gP7WlLw9a9mmpLT
         yv3rYOP2qS157DEGNmOWiflu5pqxjYGzkfAAmttJN9lsNcaDfbsQJ3mN6KfNXU4/6XKx
         qVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zQ6Ct5cYaN6y3y3849okd19zcPhtwDmT53TAUQREnAA=;
        b=Big1fn7jce/WN2jzlsa4wXlg9hrLeH3iRjQftDLsjZbAMSybTyg/h+zElFqc2tesMy
         Nz1gEBGFKm5HZ7jS3j12sNG1YRcLCieuu4bJY4cGz+a32HGEzBQfP/9JmfcufqrJfXxW
         +W6pza8x3zCrqg6tM1T66pIAtJJz6UsV1MgTpqY7P2SrYhQ6agEryTTC+kKeS5RQgjW8
         AM9sZL3j21w+N3aUKdpo9Eh+RReUJc382TbSC+sWDzHEIZAeVUED/03xgny5irhQ7aHW
         rKYl8bjimRVkZeMDsEgfulEHgas8eDZ82oi8EroWM6iqcpKNUmCA1TMkx1gqSutbIpyw
         r0Ag==
X-Gm-Message-State: AOUpUlHrdCFOkgIMh2mwZfwDCA0AUzzgo9olCKa4wytjpP14ZeQ4Mcy9
        ia0eOXlYIEbycHvST60RdIY=
X-Google-Smtp-Source: AAOMgpfhpZd3wJ1r8IfkbFgZgWqaX6jxpJCOsTCAz1rqaDIcm6V7XoNWlYK+p1NfErvHsAislBnJCw==
X-Received: by 2002:a50:b56e:: with SMTP id z43-v6mr4843258edd.223.1533242481301;
        Thu, 02 Aug 2018 13:41:21 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id n46-v6sm2097649edd.6.2018.08.02.13.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 13:41:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/6] add, update-index: fix --chmod argument help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <87h8kdu3ay.fsf@evledraar.gmail.com>
        <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
        <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
        <20180802165457.GC15984@sigill.intra.peff.net>
        <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
        <2bc31a96-1d1a-3b71-59cc-47a3a2e29e16@web.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <2bc31a96-1d1a-3b71-59cc-47a3a2e29e16@web.de>
Date:   Thu, 02 Aug 2018 22:41:19 +0200
Message-ID: <87d0v0tsb4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 02 2018, René Scharfe wrote:

> Don't translate the argument specification for --chmod; "+x" and "-x"
> are the literal strings that the commands accept.
>
> Separate alternatives using a pipe character instead of a slash, for
> consistency.
>
> Use the flag PARSE_OPT_LITERAL_ARGHELP to prevent parseopt from adding a
> pair of angular brackets around the argument help string, as that would
> wrongly indicate that users need to replace the literal strings with
> some kind of value.

Good change.

Let's mention in the commit message thath we ended up with this because
of 4a4838b46a ("i18n: update-index: mark parseopt strings for
translation", 2012-08-20) and 4e55ed32db ("add: add --chmod=+x /
--chmod=-x options", 2016-05-31) , both of which obviously didn't intend
for this to happen, but were either mass-replacing "..." with N_("..."),
or blindly copy/pasting an existing option whose argument should have
been translated.

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/add.c          | 4 +++-
>  builtin/update-index.c | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 8a155dd41e..84bfec9b73 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -304,7 +304,9 @@ static struct option builtin_add_options[] = {
>  	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
>  	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
>  	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
> -	OPT_STRING( 0 , "chmod", &chmod_arg, N_("(+/-)x"), N_("override the executable bit of the listed files")),
> +	{ OPTION_STRING, 0, "chmod", &chmod_arg, "(+|-)x",
> +	  N_("override the executable bit of the listed files"),
> +	  PARSE_OPT_LITERAL_ARGHELP },
>  	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
>  			N_("warn when adding an embedded repository")),
>  	OPT_END(),
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index a8709a26ec..7feda6e271 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -971,7 +971,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
>  			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
>  			(parse_opt_cb *) cacheinfo_callback},
> -		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
> +		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, "(+|-)x",
>  			N_("override the executable bit of the listed files"),
>  			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
>  			chmod_callback},
