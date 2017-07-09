Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D63A202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 13:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbdGINZt (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 09:25:49 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33645 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752313AbdGINZs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 09:25:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so10962500pfh.0
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nTUzjEM/O9/jkWtsmgpsYvKMKtBQ903zyPq/zRcLmcc=;
        b=u8BzAhbuRd99/yF/mFKOvYgFPr7KV0MxrLE/MeGEPPGnEfLjR+icOkVgLAzwlnKJMR
         XdNTIwoYs1O1xzwyFeG6wm3lsOcXbFZjFRmd7RNQAwM2I0lsZl7eq3Ndp0S74fHJNTud
         OmdkXxbQmts1RHcrc+jLvg8isE2c95xSr1iQqxcQuM2Ps2sfQE0UW4jrsLc+EYHjJbzu
         mfYwHMsP3xXkLrRjgHcXVQWxr/MNvxM2CvV9uv43Tz6PiJuKt5MRwPHTWLBQ/o1m3swG
         iaBg/OzyyB3NqbrQkD1ibip3VPQBh4f8ihXYafgvj4yssinsEjr+9q8jmPzn56c2BUqR
         jlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nTUzjEM/O9/jkWtsmgpsYvKMKtBQ903zyPq/zRcLmcc=;
        b=HXQSoUtnA1UqcGLGsEO38z2oEsbWmhUAZxX39+xK6M81IBXk0b3BLVkMRolEm4UHTM
         6OlyjHD0AvHrZmIJKjgdULU8/oYWqW3XEnZNIsc0m1p+OcxiGMJe3Ce1E5H55GDqJTKe
         XCKVCLA52UNtnXPHPvZhoAgHX38986pYQbWbKaLYZTQQe43FVDBFAH9G/hQwKcetrL0V
         IGMH0dXH3kN+MBKeunqTFtquZYrXKbG/B9JvxAsof3G5f86zZClz4mwpR0S1N2WEpUpy
         KZAt3/edqH9bncqKh6IsmLBwSMVt+mQ/X98DxX2MVtsYNQGjM1Dvpb4775vwANiUutMm
         DyIg==
X-Gm-Message-State: AIVw111v8BlTFTsuZPFGVeqz0V71A//2li9oCn+D0dXeG6WZP+0HsLq6
        j4KVVzPvdpTuEz2xslWqzALAfUkh8JMK
X-Received: by 10.98.222.3 with SMTP id h3mr39440665pfg.93.1499606747640; Sun,
 09 Jul 2017 06:25:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.102 with HTTP; Sun, 9 Jul 2017 06:25:46 -0700 (PDT)
In-Reply-To: <4d2c274a-f6cb-6ea5-304f-51a3152cc436@web.de>
References: <4d2c274a-f6cb-6ea5-304f-51a3152cc436@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 9 Jul 2017 15:25:46 +0200
Message-ID: <CAN0heSr0qJv7VqaasLGNFbNDbqYOoqmi3FyLkb=co4E10Y9VOg@mail.gmail.com>
Subject: Re: [PATCH] use DIV_ROUND_UP
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 July 2017 at 12:35, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Convert code that divides and rounds up to use DIV_ROUND_UP to make the
> intent clearer and reduce the number of magic constants.
...
> diff --git a/sha1_name.c b/sha1_name.c
> index e7f7b12ceb..8c513dbff6 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -492,7 +492,7 @@ int find_unique_abbrev_r(char *hex, const unsigned ch=
ar *sha1, int len)
>                  * together we need to divide by 2; but we also want to r=
ound
>                  * odd numbers up, hence adding one before dividing.
>                  */
> -               len =3D (len + 1) / 2;
> +               len =3D DIV_ROUND_UP(len, 2);

Since the addition is now an implementation detail of DIV_ROUND_UP,
should the comment be adjusted, maybe simply by removing ", hence
adding one before dividing"?

Or perhaps even better, "... divide by 2; but since len might be odd,
we need to make sure we round up as we divide". My thinking being,
we're not actually rounding odd numbers up (presumably to even
numbers), but we're rounding the result of the division up (to the
smallest larger integer).
