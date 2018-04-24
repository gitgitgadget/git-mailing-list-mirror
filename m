Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8B21F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755905AbeDXFm0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:42:26 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:46412 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754824AbeDXFmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:42:25 -0400
Received: by mail-qt0-f177.google.com with SMTP id h4-v6so20524659qtn.13
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dXzhi5p94+k5MxeExW+uJ2h9umoKxQLDhyslsKi/OoY=;
        b=ZR6cZspi276S4roqCaGiJqyeyp+eLMTQ8BR4xdjPI160q3J6Z8/w2z39u1/BlWxYws
         0lxa3Xc4PeK4efR1Fv/YMQnnq8NaEMT+7dZDk0yfvkKwEk9iIIS1gGe9xhnHLgfqYjsG
         cO61OunjaXiYPREYiRI7oTan6MnB8wWMfO3+YCNI8rcA8Q/Jmp79ikXLX/eAVRVdUTD2
         xdEdS73J0Bvsb9oifPS0hPkygGsy1ETbaUEuCULF+j/22jiUuIWTFlbIgm4mWoB35B0H
         5gfPK7WKWYidgbnbwRU8jrhTo/ZhD6NMaz64qberq3PSH4BQTq8bC8RrmyavJqHVUbtB
         f9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dXzhi5p94+k5MxeExW+uJ2h9umoKxQLDhyslsKi/OoY=;
        b=Z22TMYM08Nd9PeoZdFrsV0Oc+Mt+L5H1Ynuzd6xfc7fLOuiw+ca9rqt/xH9uUnXE1W
         BiyR0xteMv1kon35RNu2tXdX1ZslMZeUF1heNQLZeXvrZ/aLeCqZCqx4vzSZXJ3kXkf1
         yX6geDU4ubNGLZS38khKsQjt8i2hi+DpK3AMYuNxCwoSUJlQiWuLZLLZC4lX+2UuGBSu
         1Bic6UL06YLT4WScjCexfFbR4TnE4NI58DwY3NU0ebV/6DexWdiX513Y1mDvDIxjzHVF
         ts1d6mtaZUDX7snord6+Vad22IXrqRvYjSUhvPB0TqQYLdCS9nVSiaeachlWzg7IulVt
         mZ3w==
X-Gm-Message-State: ALQs6tCd6Y/7ZG2M5yvdB4Rygy9r6SLpab1NDJeAR5oY+0AiR9tcfzBI
        EjAEAQzycoTd3eG0jZxcgKmpcaCxplKd4afuXAFtsA==
X-Google-Smtp-Source: AB8JxZpirKezITRF/9LoRPogoCxYQ+mYyoh9Hvk3f0yug7T1C3QD5Qo7lDfi0N8vwOGLX64C8gOGbykR5Zl9b/1NVRo=
X-Received: by 2002:ac8:42b:: with SMTP id v43-v6mr26192065qtg.69.1524548544593;
 Mon, 23 Apr 2018 22:42:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 23 Apr 2018 22:42:24 -0700 (PDT)
In-Reply-To: <f6f74e43eec63e9e7a9037a2a40075feb5fa0ac4.1524545768.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local> <cover.1524545768.git.me@ttaylorr.com>
 <f6f74e43eec63e9e7a9037a2a40075feb5fa0ac4.1524545768.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 24 Apr 2018 01:42:24 -0400
X-Google-Sender-Auth: hCGzPSnJMf_NjLKIBKMCQtZywdE
Message-ID: <CAPig+cTPmJW9S-3Mu_4eBkLULNZetd9agjSShf0AMEd+iLbc2w@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] grep.c: display column number of first match
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 1:07 AM, Taylor Blau <me@ttaylorr.com> wrote:
> To prepare for 'git grep' learning '--column-number', teach grep.c's
> show_line() how to show the column of the first match on non-context
> line.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/grep.c b/grep.c
> @@ -1399,6 +1399,17 @@ static void show_line(struct grep_opt *opt, char *=
bol, char *eol,
> +       /**
> +        * Treat 'cno' as the 1-indexed offset from the start of a non-co=
ntext
> +        * line to its first match. Otherwise, 'cno' is 0 indicating that=
 we are
> +        * being called with a context line.
> +        */

Nit: =C3=86var's review[1] mentioned that this project tends to use
/*...*/, not /**...*/.

[1]: https://public-inbox.org/git/874lk2e4he.fsf@evledraar.gmail.com/

> +       if (opt->columnnum && cno) {
> +               char buf[32];
> +               xsnprintf(buf, sizeof(buf), "%d", cno);
> +               output_color(opt, buf, strlen(buf), opt->color_columnno);
> +               output_sep(opt, sign);
> +       }
