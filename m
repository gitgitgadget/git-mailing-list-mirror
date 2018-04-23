Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA34E1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 00:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753775AbeDWAY5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 20:24:57 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:41521 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753664AbeDWAY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 20:24:57 -0400
Received: by mail-qt0-f180.google.com with SMTP id d3-v6so15841611qth.8
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 17:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yceAo0qzlTflkC6ed8hJrXcmTPR6LNXfa9N0Hsxmp1o=;
        b=PHS8Sho2hTWg9T/CX0WrlCNx+dOtPiozjMb88c2G+xMzLgXh1KhFjoML3utd7J3Lzy
         Pzv0m5Hw0Jxazfx5nFG/mxcgbYpEg4szgfa26A0IM0tkcvoEmBM/foQlj2op1JWzogou
         PMIJjuPd1ba9bmW6j6J0F6ifIy/prFZ/hQfLKTPCdLXNgzp4c92YGLHLxMdk7hoQo7Xp
         nJPMqUmoWt8GxKZkcrGbwA3eWtI27AUOMEnZBqxfYZP7EZTeqVccVxvwFw+PmerK5YOo
         IFdrE3wHEtIIwzEDBQbjDuSNyU6G98C7r6ntS21y7wlb7A6wmTlC7EmF7c/OndAAOj5r
         fm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yceAo0qzlTflkC6ed8hJrXcmTPR6LNXfa9N0Hsxmp1o=;
        b=ml3ArMymo4zYd50syPDX2xn0+eILc75eAxGsR1UEUvmOxaBKBOXgw+9HpF5dPl7+7j
         MX9ZOATQ+79JfV5p9W7mdQMcr9TB19Axw30tRexXKcU2TBJxXqKxhrgO0j+VxMPvTTbn
         6rTiZfofE6TuFvczGeVcI1+9mZbUso1uJpUQ+GDjfulVYvZDbDzBtiQkz0PS8pn1gmpj
         S1f1W4qE3HpXFKxDONftUaszuHxkpmbq8+tUQdQyrU3to8edG16YF0sFLLJPymCRmRcr
         ZmRy8H5zUzx2zXOf6wgb5L26TcLBPxEwrwJoQQYCYOprtLuT23y2ilIbuKGmup9LD5kD
         QPmA==
X-Gm-Message-State: ALQs6tCJ7Ij5i6XuVGo7X1oTI4YZk0hKjEKnDSpU3OK4KSMAEnubQS94
        t/NmA8lf3Ud0Hzb11QLRRjfq/0ABjYY/8l0+kSc=
X-Google-Smtp-Source: AB8JxZq0My/dJVkSOTvT+z/TuP4Rajp5SkKpxt0ZSKkQt6Ygv5BzvXlvmUVZXuttSDhKRpkGOb1GFeloUaSZW3Au9p0=
X-Received: by 2002:ac8:3267:: with SMTP id y36-v6mr21390130qta.25.1524443096284;
 Sun, 22 Apr 2018 17:24:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 22 Apr 2018 17:24:55 -0700 (PDT)
In-Reply-To: <4531659687de87b1bc143cb5cb364b691a58c6c9.1524429778.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local> <cover.1524429778.git.me@ttaylorr.com>
 <4531659687de87b1bc143cb5cb364b691a58c6c9.1524429778.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 22 Apr 2018 20:24:55 -0400
X-Google-Sender-Auth: cbG-uTcIrUn9aBr1-dngeudM110
Message-ID: <CAPig+cR0unM2uKcapHyAFrvMyPx4VgsW4wDswb_GNwE4EcYb8Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] grep.c: display column number of first match
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 4:47 PM, Taylor Blau <me@ttaylorr.com> wrote:
> Building upon our work in the previous commit to add members 'columnnum'
> and 'color_columno' to 'grep_opt', we teach show_line() how to respect
> those options.
>
> When requested, show_line() will display the column number of the first
> match on a non-context line. show_line() differentiates between context
> and non-context lines through the '&& cno' check. 'cno' will be equal to
> zero if and only if show_line() is invoked on a context line. It will be
> a non-zero value otherwise.

This interpretation of 'cno' seems important enough to deserve an
in-code comment. (And, you may be able to drop some of the same
information from the commit message if it merely duplicates the
in-code comment.)

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/grep.c b/grep.c
> @@ -1404,6 +1404,12 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
> +       if (opt->columnnum && cno) {
> +               char buf[32];
> +               xsnprintf(buf, sizeof(buf), "%d", cno);
> +               output_color(opt, buf, strlen(buf), opt->color_columnno);
> +               output_sep(opt, sign);
> +       }
