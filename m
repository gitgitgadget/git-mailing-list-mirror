Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB1C207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 06:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbcJDGOV (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 02:14:21 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33613 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbcJDGOU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 02:14:20 -0400
Received: by mail-yw0-f196.google.com with SMTP id g192so7294767ywh.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 23:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EXBUfhq4HYaaBO6AMoEPojWgLiUPaM2cl00dygm8NJo=;
        b=qpFZXBHEIxE9wgenTzNEeJbU4JDwi/s5McC8V2uVmMcuYiAtojj+R6znK6hP+PFf2L
         X1QHSe4pq1idmXKrIO4RUWJUySB60BbHhza285OSEALOwkkKnPPxwK0uEDDEdf/+SE3/
         8lRuR5hCIcNiFTL2BcS5Y2yGYR7luy2qHLxL2TUrgD5u+klYd4uObV4y9DwXFl3KZlcT
         3Aqi+9u6AUCcAamYMFQTrPr+gxxglK9AS5bbn5xm1o9zzKEH/p9ynK3NpQ9wdfhfCVbM
         wgmoPYhGfkqlN8FaC7hS/rTMNUnLHNoYK/IfFOJnlG09/QcKoMvFAWhf8WQg+by2jXlO
         VzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EXBUfhq4HYaaBO6AMoEPojWgLiUPaM2cl00dygm8NJo=;
        b=cMd2QMjnN8fn2lJiFpX2nc6gI95uvVM+N7Flt54yliDdOYC85UxU5QY7wpYjdvzyGJ
         Of4amMLl+j/izfJbwhlX7QfyAcHgD2jqECrjCGh/vEgl0hkI91qv1FMJa/hNTnNF+P7H
         dG8r8ZuZOS9BoumVgIge5VdwyNclqBZbDoYJsjA8hyLuYZhlMbM3cW3ZbyOJBTWFzQVf
         4xuLskV2nlYZrxHmcvme78rPrX8ViIFpWKJUxsEYKABtvzDkDQkeaZHmOOKI8+qaDw1j
         rb3IsEtn5Ac5/nY8fY9yvK5OAEfb2oenrsQgPPl2h71FdYtsprNhRTtEakCkLBVg8TYz
         HBZw==
X-Gm-Message-State: AA6/9RkaLXKPyd0N2W4Z02zgxYkoU74sHihgXZQ0DpUk4Ri4vayxJfpssIqIU6zsYkTbTOtUZdL+406br8fCUQ==
X-Received: by 10.13.209.131 with SMTP id t125mr1444604ywd.204.1475561659736;
 Mon, 03 Oct 2016 23:14:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 23:13:59 -0700 (PDT)
In-Reply-To: <20161003203555.6xadycotmmkuf34h@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203555.6xadycotmmkuf34h@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 23:13:59 -0700
Message-ID: <CA+P7+xpOxoRBDZGF_CU1Q-SYiQZtMx2vuwQKS0og864awZod5g@mail.gmail.com>
Subject: Re: [PATCH 13/18] fill_sha1_file: write "boring" characters
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:35 PM, Jeff King <peff@peff.net> wrote:
> This function forms a sha1 as "xx/yyyy...", but skips over
> the slot for the slash rather than writing it, leaving it to
> the caller to do so. It also does not bother to put in a
> trailing NUL, even though every caller would want it (we're
> forming a path which by definition is not a directory, so
> the only thing to do with it is feed it to a system call).
>
> Let's make the lives of our callers easier by just writing
> out the internal "/" and the NUL.
>

Ya this makes sense.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_file.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 70c3e2f..c6308c1 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -178,10 +178,12 @@ static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
>         for (i = 0; i < 20; i++) {
>                 static char hex[] = "0123456789abcdef";
>                 unsigned int val = sha1[i];
> -               char *pos = pathbuf + i*2 + (i > 0);
> -               *pos++ = hex[val >> 4];
> -               *pos = hex[val & 0xf];
> +               *pathbuf++ = hex[val >> 4];
> +               *pathbuf++ = hex[val & 0xf];
> +               if (!i)
> +                       *pathbuf++ = '/';
>         }
> +       *pathbuf = '\0';

I think this makes a lot more sense than making the callers have to do this.

Thanks,
Jake

>  }
>
>  const char *sha1_file_name(const unsigned char *sha1)
> @@ -198,8 +200,6 @@ const char *sha1_file_name(const unsigned char *sha1)
>                 die("insanely long object directory %s", objdir);
>         memcpy(buf, objdir, len);
>         buf[len] = '/';
> -       buf[len+3] = '/';
> -       buf[len+42] = '\0';
>         fill_sha1_path(buf + len + 1, sha1);
>         return buf;
>  }
> @@ -406,8 +406,6 @@ struct alternate_object_database *alloc_alt_odb(const char *dir)
>
>         ent->name = ent->scratch + dirlen + 1;
>         ent->scratch[dirlen] = '/';
> -       ent->scratch[dirlen + 3] = '/';
> -       ent->scratch[entlen-1] = 0;
>
>         return ent;
>  }
> --
> 2.10.0.618.g82cc264
>
