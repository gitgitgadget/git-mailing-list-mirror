Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A245C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 07:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109C763211
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 07:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhKOHsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 02:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhKOHsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 02:48:03 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15040C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 23:45:07 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so12527098pja.1
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 23:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5DXMwXqv837HP9ZvrQ60kO0CENXI59O/2AVZVx1WPw=;
        b=J0K4ijYo0d1QAsx2+0dJaNOaNKI/hZzcyHKBPzml1uEQj9ttgWucm5FxTmrp5rbKFe
         Vi3gYRwajrNqdzgTgGEQuypzkDyaBABOw8oYlzMG2jTireZQaw2w690zOkTxpa3dYioe
         seUADduC4B0/yXBVJlsT+3eoSj2sakXjz7E9TeYTDVkszHGzgIggFKcGju2rCl4urrlF
         nOyAXL+VhPjgqWsSS3F4f35Fq+SXji2AyUqsxrDfRVn1dU8RpnASxrzfNr4cJ1RPwuIz
         04N3h7yZQMI+nkZDvnSxoToYmskJ4+ihY3FUr4fc/7y+a8G8evDvlLDH/6i+uOZfVbcd
         F22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5DXMwXqv837HP9ZvrQ60kO0CENXI59O/2AVZVx1WPw=;
        b=hoxUrw6LrbuVgzTCBp0Ds2RzhPggL0DOrYhE1LEJTGDGteqAHzUQRcNjHrucWIw8na
         Z25gdRDIEL4y29Y3aVla3Ww+dQKbMqrfngDygz+uKoq8qLyrJATUa92zi4ybLIG1paMT
         /6M9UZlRakb/zuQGdbHs+VjZTrXKmmjdH4EsTVfFBtBSjqtUKBHimdnDYyvlG+EYdIa6
         cwUMcQ7YovXgqaRBx9xSWpA7ftxmtd91HP3AzbZlyHgkHCcEleabPHa437Q378XQsRna
         NXZok/QD3v+FOuUhCxBopeNuKEpsFBStZDWmYjxqE+91J8rMMp/24b9QSn3+vni34iXs
         zCfw==
X-Gm-Message-State: AOAM531hIt2vPBfygwLRYQc5eBwLD6Tixd8Kj+56YzKLRH7I/OsxkZ4I
        6vAXsg1o2mbA/SnCCZ4q7Hcjz3w83NHefhGfkuhIY5pLFVA=
X-Google-Smtp-Source: ABdhPJyhpxWWfKMXltWkXxw0UiRgJwbZpx0BKudFypNNlKwwCIJcwSHSgVQsNbw5NPKTLyHQFcOoyIoYkJxlzvHZ9kg=
X-Received: by 2002:a17:90b:2412:: with SMTP id nr18mr63406065pjb.233.1636962306549;
 Sun, 14 Nov 2021 23:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com> <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
 <xmqq7ddbme7q.fsf@gitster.g> <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
 <xmqqilwulims.fsf@gitster.g> <xmqqpmr2j5lq.fsf_-_@gitster.g>
In-Reply-To: <xmqqpmr2j5lq.fsf_-_@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 15 Nov 2021 08:44:55 +0100
Message-ID: <CAN0heSpLy8c6WM1UpyEXJLfmnX=5B0eFhJwH3wqSZN15HAJGeg@mail.gmail.com>
Subject: Re: [PATCH] revision: use C99 declaration of variable in for() loop
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 15 Nov 2021 at 07:30, Junio C Hamano <gitster@pobox.com> wrote:
>
> There are certain C99 features that might be nice to use in our code
> base, but we've hesitated to do so in order to avoid breaking
> compatibility with older compilers. But we don't actually know if
> people are even using pre-C99 compilers these days.

> is a long-enough time, so let's try it agin.

s/agin/again/

>  void show_object_with_name(FILE *out, struct object *obj, const char *name)
>  {
> -       const char *p;
> -
>         fprintf(out, "%s ", oid_to_hex(&obj->oid));
> -       for (p = name; *p && *p != '\n'; p++)
> +       for (const char *p = name; *p && *p != '\n'; p++)
>                 fputc(*p, out);
>         fputc('\n', out);
>  }

This seems like a stable-enough function for this experiment.

Similar to 765dc16888 ("git-compat-util: always enable variadic macros",
2021-01-28), maybe we should add something like

  /*
   * This "for (const char *p = ..." is made as a first step towards
   * making use of such declarations elsewhere in our codebase.  If
   * it causes compilation problems on your platform, please report
   * it to the Git mailing list at git@vger.kernel.org.
   */

to reduce the chance of someone patching it up locally thinking that
it's just a one-off.

Martin
