Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB151F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 22:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932475AbcJTWHF (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 18:07:05 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35196 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbcJTWHE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 18:07:04 -0400
Received: by mail-qk0-f176.google.com with SMTP id z190so121369695qkc.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XEY2CEvXWCkFabsQtvirbox1t0XURMv5XHM16/V0+4U=;
        b=AS7wKQUssXbQNGoHw7Ccm4cDgVBMHYW1jXp2i9R6vERp5EMxM0x+IkV2glv8w4Fbqe
         WbcXCrMzcXHb8HNOI7s6KL2mEP9qT94ZRzmoy5Dbnws35aoR5INQkRdWwH8e3lcEf16d
         A80jvH81HXLvTugltDQcdtHxCkMJgkoqq1Wj6zdjfe3Lj/uA4q4zsu89ryxbzwY+0k4O
         Oqbkwf2c7Xya42EQyYg+1w2t9210QwizHmd6CLyL7xhmURFB+ugEhCmq1EPvsQz047ck
         yQwpVLPeIqFpR+DP2zS0SdLDnxzepw0dApN9y9EHllGQTkptYHAkAgnn/ef9Wt7dMkmy
         yLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XEY2CEvXWCkFabsQtvirbox1t0XURMv5XHM16/V0+4U=;
        b=Z/GQ9jnJQB7R1yJmeZquEwRI7vhNTq4h37NLEow8Ux7EHHM5dKqRaJPnr1oSz7gRJG
         0CyFSzEXJCsiM0Cd6kiaBdcVIH7+sANoQCLcG+ntUuTbWtcPNZ5GKNGCN55B019PsNXi
         kQ9hotsrF59I9uwK5ZbC2CyZxulKZK8kBg5r3tR8Rqsp/TZgoLGTiYvYBnXGm5U0Ft7B
         6TRtF9r6ryX7qEelJipl8jpX3Yk5Lv+AP2tR8+mjip9aJoGiyjX29Id4PP1l/8SJ2ewQ
         UZ8nb5Hpn0wWPupKcTSokoiX+9dts715ZupIuhVqOcKsehpvrYwglnOrxUFj+M/wHFo0
         ru2w==
X-Gm-Message-State: ABUngvdklVmuR7PKHATiAWEMNmha1EcMLprbXb0VOjVNH2OkoNhgn+krxZ5qlOkkujOsEiw+Zs6uk+2LZehRpp4g
X-Received: by 10.55.184.2 with SMTP id i2mr2984170qkf.47.1477001222724; Thu,
 20 Oct 2016 15:07:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 15:07:02 -0700 (PDT)
In-Reply-To: <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476998988.git.jonathantanmy@google.com> <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 15:07:02 -0700
Message-ID: <CAGZ79kYi=+JUqmFyR+Xapwy2bLHtmCX7ZFxd9bGkNHS5tjEdOw@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] trailer: clarify failure modes in parse_trailer
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 2:39 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> The parse_trailer function has a few modes of operation, all depending
> on whether the separator is present in its input, and if yes, the
> separator's position. Some of these modes are failure modes, and these
> failure modes are handled differently depending on whether the trailer
> line was sourced from a file or from a command-line argument.
>
> Extract a function to find the separator, allowing the invokers of
> parse_trailer to determine how to handle the failure modes instead of
> making parse_trailer do it.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  trailer.c | 70 +++++++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 48 insertions(+), 22 deletions(-)
>
> diff --git a/trailer.c b/trailer.c
> index 99018f8..137a3fb 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -543,29 +543,40 @@ static int token_matches_item(const char *tok, struct arg_item *item, int tok_le
>         return item->conf.key ? !strncasecmp(tok, item->conf.key, tok_len) : 0;
>  }
>
> -static int parse_trailer(struct strbuf *tok, struct strbuf *val,
> -                        const struct conf_info **conf, const char *trailer)
> +/*
> + * Return the location of the first separator or '=' in line, or -1 if either a
> + * newline or the null terminator is reached first.
> + */
> +static int find_separator(const char *line)
> +{
> +       const char *c;
> +       for (c = line; ; c++) {
> +               if (!*c || *c == '\n')
> +                       return -1;
> +               if (*c == '=' || strchr(separators, *c))
> +                       return c - line;
> +       }

I was about to suggest this function can be simplified and maybe
even inlined by the use of strspn or strcspn, but I think manual
processing of the string is fine, too, as it would not really be shorter.
