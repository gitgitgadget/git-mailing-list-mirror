Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD85D1FD09
	for <e@80x24.org>; Wed, 31 May 2017 20:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbdEaU6U (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 16:58:20 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35798 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdEaU6S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 16:58:18 -0400
Received: by mail-pf0-f181.google.com with SMTP id n23so17650437pfb.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CeXRehVFpVsjplfjkWEPVEm15YU/yZ67+czMbVQJvio=;
        b=kQQfTWkRHJdneVoSHjBrNM31ir+1dN17tX7EiqjhqaCeBV3uih7Z5XVJIf52Oml0ce
         OSnCFFaqz9S1EJONSWOdTrJszEupwIKorMWPea+dbL8/88TdoVQPgXz2HOfggfl/hiOc
         vru3BdOQbNGf1TTKaYHB11QQptrCRx+7F5+AdpiQ3ZS8bGjDjR8Kg0xZUOzhI7VLMu2K
         aD26gZGqJK2KlInZ7AsvHt6Kja/P3e8T/D7rDLXVZ1c4Qj7bOfMc7QqpC2ljevlPE7TG
         JiGjxzQ89+AbvsaNj2Qvb3fqsNkozlmfg+NQ1Im77Sq+d7al3JLKPyOC4SAAUwsl/1bc
         I4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CeXRehVFpVsjplfjkWEPVEm15YU/yZ67+czMbVQJvio=;
        b=X0aSXV5YKA+jrKd6LN6PFom028hFOx6RtTstL9q65aSh3DyzQCZRAGvYoNgomw9hn9
         2VJGYw5QwKSJlV6L9usI9gZwILRmD28HUVm8zLZEs61MNicdcm8Sij+miK6zDJ1vf3Dv
         DA5mqtW4VfOr/jc2/JT33AJ+rVYorPRyp9IbSaAi0+mDghX+YQi7bU0CQ4o1MimunlVf
         kK7OB3yPF/pIFrY9m7kg9cO8cv8kuA/M/tmAGA0Of7RAWG4PnZUuzjbvZokLtlSVtvTl
         u4vk3GdwtYD315UKQj2IY26Js0My71By43Hma6mlnOATLjkZ3pTduGpX2lIuhURnHUOf
         tNzg==
X-Gm-Message-State: AODbwcCEqcjRXLZBC+jH6mhdT+ps2YAxoHoz2eoA86ad7PQtwRgYlz+8
        6lcO42NpvPp/CG5OIIbunKLenqq5W6fC
X-Received: by 10.101.76.201 with SMTP id n9mr184856pgt.40.1496264297239; Wed,
 31 May 2017 13:58:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 31 May 2017 13:58:16 -0700 (PDT)
In-Reply-To: <CA+izobteEUSisKXNr=k5BcN9hVV4nyqYPWuRLAgV-rg9chH4_g@mail.gmail.com>
References: <CALKRkrxHNao6NY+-_UmznHdq29yVJJynu8Xx5M__YfK9UkdOAw@mail.gmail.com>
 <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
 <3d02b958-5f72-9676-bce9-afca962c07df@kdbg.org> <CA+izobteEUSisKXNr=k5BcN9hVV4nyqYPWuRLAgV-rg9chH4_g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 May 2017 13:58:16 -0700
Message-ID: <CAGZ79kaVomdMaDw9xBphDnqaEwzaZB7M+rsBMErWfpnyeXhucg@mail.gmail.com>
Subject: Re: [Bug] git branch -v has problems with carriage returns
To:     Atousa Duprat <atousa.p@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Animi Vulpis <animi.vulpis@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 10:32 PM, Atousa Duprat <atousa.p@gmail.com> wrote:
> Here is my first attempt at fixing the issue.

Cool you're looking into this. :)

>
> There are two problems in ref-filter.c:
>
> First, copy_subject() has been modified to turn '\n' into a space and
> every other ascii control character to be ignored.
>
> Second, find_subpos() doesn't realize that a line that only contains a
> '\r\n' is a blank line =E2=80=93 at least when using crlf convention.
> I have changed things so that a sequence of either '\n' or "\r\n"
> separate the subject from the body of the commit message.
> I am not looking at the crlf setting because it doesn't seem like a
> useful distinction =E2=80=93 when one would we ever care for \r\n not to =
be a
> blank line?  But it could be done...
>
> Both fixes are minimal, but it feels like they are a issues with the
> specific encoding.  Does git mandate ascii or utf-8 commit messages?
> If not, there may be a larger issue here with encodings and line-end
> conventions at the very least in ref-filter.c
> Guidance would be appreciated for how to deal with this issue...
>
> Patch attached.
>

Please read Documentation/SubmittingPatches
(tl;dr:
(a) please sign your patch, read https://developercertificate.org/
(b) if possible please send patches inline instead of attached)

> diff --git a/ref-filter.c b/ref-filter.c
> index 3a640448f..bc573f481 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -836,11 +836,15 @@ static const char *copy_email(const char *buf)
>  static char *copy_subject(const char *buf, unsigned long len)
>  {
>          char *r =3D xmemdupz(buf, len);
> -        int i;
> +        int i, j;
>
> -        for (i =3D 0; i < len; i++)
> +        for (i =3D 0, j =3D 0; i < len; i++, j++)
>                  if (r[i] =3D=3D '\n')
> -                        r[i] =3D ' ';
> +                        r[j] =3D ' ';
> +                else if (r[i] < 32)
> +                    j--; // skip ascii control characters that are not '=
\n'

/*
 * Our comment style uses the other way,
 * as it is compatible with more compilers, still.
 */

This seems to solve a different problem than the carriage return
discussed? So it could go into a separate patch.


> +                else r[j] =3D r[i];
> +        r[j]=3D0;
>
>          return r;
>  }
> @@ -956,9 +960,12 @@ static void find_subpos(const char *buf, unsigned lo=
ng sz,
>                          eol++;
>                  buf =3D eol;
>          }
> +

stray new line?

>          /* skip any empty lines */
>          while (*buf =3D=3D '\n')
>                  buf++;
> +        while (*buf =3D=3D '\r' && *(buf+1) =3D=3D '\n')
> +                buf +=3D 2;

This first skips LF empty lines and then skips CRLF empty
lines. What if they are mixed? I'd think if we extend the
empty line detection we'd want to robust to such as well,
so maybe

    while (*buf =3D=3D '\r' || *buf =3D=3D '\n')
        buf++;

Maybe this is a bit too greedy?
