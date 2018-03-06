Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E611F576
	for <e@80x24.org>; Tue,  6 Mar 2018 07:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeCFHIp (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 02:08:45 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:43756 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeCFHIo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 02:08:44 -0500
Received: by mail-qk0-f171.google.com with SMTP id j4so23723881qke.10
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 23:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=x0FjnQA2a52/6GxS86+OsNZsAkr5JOY5n5HvGBV4yF0=;
        b=ggvFBQ6DIik6vi+NMdFN67p6yIrK6rudTBCQl0LIB1SWhDwsteQhq9O67TCRtZvx94
         jrECU8XA9A/FX5VO7UX2q8KjcGyFh9BuiQDYZmO+yTNzd+7mbRlwdbzdodJuCl10XNOt
         ndhJ2SZCD80/PsxkEO1ilYS4UViUGtqmr6XZ+5sIlb5HUO/LFejFJzAUMu6wq7BA2J7l
         rwGg4OZqHPgni0tWqY75DGiRYcvuvioXuJJNcTUkpfIICbAXM1akxrJso7DCmjDvuVb9
         3lliz8jIwFPPWQ8hMSNwekJOwQ3AL4jRlDq/vPB0riuvdngTJAOoDrfxOFoUcstyfC5T
         8wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=x0FjnQA2a52/6GxS86+OsNZsAkr5JOY5n5HvGBV4yF0=;
        b=LkKiJ3eRUW7AszqPU/HcjIs+eF6czoNan86758K27r5O5bUkdEDb33n6SXmXcyzJl8
         T5rZLJBzUPctD000d2P4AtFcq6WU46bh0tWOaxK3Z57Frq9X2MiDIwfXLhUYaI+o+o60
         2ZEJO/oAI6vD92AgoQLDAQYvxwxGs5NT1W2umKawBu4krGoy3rsSs85usF1jelNK8Czv
         Ek7ymk8w5CpjETBogAmWhlkFRDAZWcsjTnLCC52yn48/1pX2rVPfEjpRGC6et6eWYLLL
         DttjoFvdFkCKsgRpKVdUogxK6379ySToxxtHpIA8ErZI/edIwx34PM2NLieSJCainvgo
         ESxg==
X-Gm-Message-State: AElRT7FXKGOCGUg2pmxzniSTqEEkVuotszRBdcW8oI46o2I8kN4mn6CG
        knguUfTn1vHmXRyeNGS2ONP0hCpCm2MH0Gc1FuU=
X-Google-Smtp-Source: AG47ELttIFIXdDCzL7gN1FT/hjmn2+aUw/LdFhfq3ibqG84HsO3isA1R/2oJU4niLUH1pFTFPP4NYHl6BHPL0SpSLqk=
X-Received: by 10.55.13.206 with SMTP id 197mr26767173qkn.115.1520320123884;
 Mon, 05 Mar 2018 23:08:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Mon, 5 Mar 2018 23:08:43 -0800 (PST)
In-Reply-To: <20180306021729.45813-2-me@ttaylorr.com>
References: <20180306021729.45813-1-me@ttaylorr.com> <20180306021729.45813-2-me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Mar 2018 02:08:43 -0500
X-Google-Sender-Auth: rUtgCFS-qUy1Caoym-PYTDYS6xM
Message-ID: <CAPig+cTrXF_Hm8Uj8jFbBsNhB=J_6TP0wBzKEqfUZDDTwE-0tQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] builtin/config: introduce `--default`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 5, 2018 at 9:17 PM, Taylor Blau <me@ttaylorr.com> wrote:
> In an aim to replace:
>
>   $ git config --get-color slot [default] [...]
>
> with:
>
>   $ git config --default default --color slot [...]
>
> introduce `--defualt` to behave as if the given default were present and

s/--defualt/--default/

> assigned to slot in the case that that slot does not exist.
>
> Values filled by `--default` behave exactly as if they were present in
> the affected configuration file; they will be parsed by type specifiers
> without the knowledge that they are not themselves present in the
> configuraion.
>
> Specifically, this means that the following will work:
>
>   $ git config --int --default 1M does.not.exist
>   1048576
>
> In subsequent commits, we will offer `--color`, which (in conjunction
> with `--default`) will be sufficient to replace `--get-color`.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
