Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2245B202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 15:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbdGIPOy (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 11:14:54 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35765 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdGIPOx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 11:14:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id q85so11176633pfq.2
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3o+Svz8N1DJzC4KsV2w5DzDpTMfun2fsIgsO/4l5lj0=;
        b=pM/MsI//PrZmDJDXg4iAPk3lM/zAfyouYd2wND0zDQRmBe6qZ8jOM06MIDF06AQErk
         V5Mpks/6ZU6akjq3bLZd12e95KAmWEnYmxTJ/J9pNF3Cf4yZGV2TnEM2Rg13ym6J+UuV
         5WmG/8KRL+Ee8hupKTssV89sEymt/L1mQPccoyvDMVaDds6YmpLMhPo41jeF5cjI73lj
         LpdRIrM01/7noOi6y/pPXbRuatlr1Ti3dvezETpa+A1XuQqCFS7yGwJ7GTQffIX+bhRV
         OOlemqf/gkSaq9a/Rkc2jOmemSN48yDq+SGj9tiAEjvh/pYcpP57Vu9+67C5t542rX8s
         /t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3o+Svz8N1DJzC4KsV2w5DzDpTMfun2fsIgsO/4l5lj0=;
        b=RjvvnZ9FvMzx2qtAGo9ugZszZ5L5HXO5JAZbO1XmgpTWk9KzBwRrPVjSE9+gADQ00o
         EOvzov+angnTNl3M5yNUkhwg+A1IqJSIdp5a3debbsJJUb9KA3YNkMQepF3DjlDqzY0/
         Qu1JsLnG5bGfAuXupfoab2WCc0JdNtlT99R4Cr8cxkd3BS31gkr9FLsqjY5kVNLUTEL0
         6MKhXV0wFRwiHxwmMFjoMk9uMdSAyy7A23lVZSylcTqTf8hWKNNDSsscpTU7AAcLtv/c
         7483wgd3v8g4x2xZBET2Ez1TaUsCG6ZNZFAdp6XjBDLVWw5ePJd+84YXVxyyQcVm+Ic8
         hI3g==
X-Gm-Message-State: AIVw110hGkNlwFA1wZE9nj+FIKCM8iLC1p5msMqlHBs/pIJ/CoZwukeJ
        bTG3JLV5HZ+snum2LRItGErb2O6uSA==
X-Received: by 10.98.192.204 with SMTP id g73mr40249672pfk.26.1499613293108;
 Sun, 09 Jul 2017 08:14:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.102 with HTTP; Sun, 9 Jul 2017 08:14:52 -0700 (PDT)
In-Reply-To: <be5b6900-9e5e-0796-c16a-03c1b72cfa50@web.de>
References: <4d2c274a-f6cb-6ea5-304f-51a3152cc436@web.de> <CAN0heSr0qJv7VqaasLGNFbNDbqYOoqmi3FyLkb=co4E10Y9VOg@mail.gmail.com>
 <be5b6900-9e5e-0796-c16a-03c1b72cfa50@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 9 Jul 2017 17:14:52 +0200
Message-ID: <CAN0heSpaLqfD_ZU=6K=bQs3E4iBj0BjQEVruivc7LXCWoXi2tg@mail.gmail.com>
Subject: Re: [PATCH] use DIV_ROUND_UP
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 July 2017 at 16:01, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 09.07.2017 um 15:25 schrieb Martin =C3=85gren:
>> On 8 July 2017 at 12:35, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>> Convert code that divides and rounds up to use DIV_ROUND_UP to make the
>>> intent clearer and reduce the number of magic constants.
>> ...
>>> diff --git a/sha1_name.c b/sha1_name.c
>>> index e7f7b12ceb..8c513dbff6 100644
>>> --- a/sha1_name.c
>>> +++ b/sha1_name.c
>>> @@ -492,7 +492,7 @@ int find_unique_abbrev_r(char *hex, const unsigned =
char *sha1, int len)
>>>                   * together we need to divide by 2; but we also want t=
o round
>>>                   * odd numbers up, hence adding one before dividing.
>>>                   */
>>> -               len =3D (len + 1) / 2;
>>> +               len =3D DIV_ROUND_UP(len, 2);
>>
>> Since the addition is now an implementation detail of DIV_ROUND_UP,
>> should the comment be adjusted, maybe simply by removing ", hence
>> adding one before dividing"?
>>
>> Or perhaps even better, "... divide by 2; but since len might be odd,
>> we need to make sure we round up as we divide". My thinking being,
>> we're not actually rounding odd numbers up (presumably to even
>> numbers), but we're rounding the result of the division up (to the
>> smallest larger integer).
>
> Good point; perhaps just squash this in?
>
> ---
>  sha1_name.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 8c513dbff6..74fcb6d788 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -489,8 +489,7 @@ int find_unique_abbrev_r(char *hex, const unsigned ch=
ar *sha1, int len)
>                  * We now know we have on the order of 2^len objects, whi=
ch
>                  * expects a collision at 2^(len/2). But we also care abo=
ut hex
>                  * chars, not bits, and there are 4 bits per hex. So all
> -                * together we need to divide by 2; but we also want to r=
ound
> -                * odd numbers up, hence adding one before dividing.
> +                * together we need to divide by 2 and round up.
>                  */
>                 len =3D DIV_ROUND_UP(len, 2);
>                 /*

Much better than my suggestions.
