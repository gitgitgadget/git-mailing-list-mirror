Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EEB31F403
	for <e@80x24.org>; Thu,  7 Jun 2018 17:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeFGRY3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 13:24:29 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44001 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbeFGRY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 13:24:28 -0400
Received: by mail-yb0-f196.google.com with SMTP id w3-v6so3472760ybq.10
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4urSkLJhe7VvYUJelfZ3Uc57VuFT7KGkB6cQ4NQsceM=;
        b=lYvyiKUnUeLrncl1vGqXPtqCWhBbnPp0TnrGoFd+uiJbpm3M00//ostbQicekbyKIs
         8vRU78Y2vAlWX+vADNXG+dOd+yxhRSwWJgx1HzwHXGEjD7QakUBU5Ct5VvZZi4bK4mCO
         StCTVaOi69KuxatRhm1FD2G7r9lp6xSvVOmLg//jqkWruJ4ZN7sRp4h+5BDzgssdL44b
         EDhQQJjxjmdfGAXHRQU320c6+WbZ6u7Pl9glyWD/Jk9qVDGzfemTzy5X95FStgbRBb7+
         mO03lAbKTzC2VTLpMjtud26K/1XIQROCfvDSS9nJBnKtMGzN5zlUgTXCeh2yDZwlIKPN
         CHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4urSkLJhe7VvYUJelfZ3Uc57VuFT7KGkB6cQ4NQsceM=;
        b=dbqDqYIW1d4LNQpfCIKkdljWekk8pNdhVD1I0JHQqrH4/zq47ga0fzQhYt666Xrta/
         1GjhFwttV6YtTfeWaoAd/1J14AcnQCcAzFamFCmAXhwC8xISLJ3RvrLJIrRUzmJ1QTmt
         /VB9/aXA/LrzqmL/Kdh8yx+J+Oahxk6bhTPCaX5iegUO6eMSESu7IYdNwQRdOkyFzbea
         /gX2ZvQkHZ14hJkdr+u0fvt77RJIop2/AahYG5CoQ4d5ok/tPqGk4teK3cjwSm+EyPtL
         GUgaJ+5AyLsSIr5jsYDJgk7su7g86X0yERVDVJCYKnOJKZ24RnrQgLLhYsuVLexKV1g1
         T11Q==
X-Gm-Message-State: APt69E1D6JKqcyjbTU219n9dCXyDKbgBVX1e05UpMzzC3egKtEsDI7Uo
        CO43wLRnwHD7ITFTNvX8wpKlCfddRIKPIPcf16E=
X-Google-Smtp-Source: ADUXVKL05sebEFu6CqvbYHnRUyKzhN1wAwozLdE6oHiO81TV5JI2du+ZUE3DjCDGQeM+JvjbU8dVHph6axEu73jnFeE=
X-Received: by 2002:a25:83c6:: with SMTP id v6-v6mr1660537ybm.263.1528392267435;
 Thu, 07 Jun 2018 10:24:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:785:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:24:26 -0700 (PDT)
In-Reply-To: <20180607141209.24423-2-git@jeffhostetler.com>
References: <20180607141209.24423-1-git@jeffhostetler.com> <20180607141209.24423-2-git@jeffhostetler.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Jun 2018 13:24:26 -0400
X-Google-Sender-Auth: ZIrqiYBDEtvf7Dj5N3qVIms5oMM
Message-ID: <CAPig+cRBCr2dKOBFnUF_D1SXfPTE5SPbB4t=y51VGa_jLQGkcA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] json_writer: new routines to create data in JSON format
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 10:12 AM,  <git@jeffhostetler.com> wrote:
> Add a series of jw_ routines and "struct json_writer" structure to compose
> JSON data.  The resulting string data can then be output by commands wanting
> to support a JSON output format.
> [...]
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
> diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
> @@ -0,0 +1,236 @@
> +test_expect_success 'simple object' '
> +       cat >expect <<-\EOF &&
> +       {"a":"abc","b":42,"c":3.14,"d":true,"e":false,"f":null}
> +       EOF
> +       test-json-writer >actual \
> +               @object \
> +                       @object-string a abc \
> +                       @object-int b 42 \
> +                       @object-double c 2 3.140 \
> +                       @object-true d \
> +                       @object-false e \
> +                       @object-null f \
> +               @end &&
> +       test_cmp expect actual
> +'

To make it easier on people writing these tests, it might be nice for
this to be less noisy by getting rid of "@" and "\". To get rid of
"\", the test program could grab its script commands from stdin (one
instruction per line) rather than from argv[]. For instance:

    test-json-writer >actual <<-\EOF &&
        object
            object-string a abc
            ...
        end
    EOF

Not a big deal, and certainly not worth a re-roll.
