Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 128BA1FAED
	for <e@80x24.org>; Fri,  9 Jun 2017 10:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdFIK7N (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 06:59:13 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35132 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdFIK7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 06:59:13 -0400
Received: by mail-it0-f45.google.com with SMTP id m62so135395649itc.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 03:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h1zOiCGp2SOzH7yKlOvVi8ZsNGVGrJfvqqbYGSO/Wds=;
        b=LslDdrz/PJi34BniazJz2sLhfSoe9EJotAw1iE4DO1gTswbgOsmBRRxwZjku68btYj
         66V7k3FaUWMxwgp3xxPZwlfbhkg3t081SmWN+SWrlhpND4FDETv4x+TwJas5kbsmwoM9
         RpSvYAzNrrUr3IMOPKGLLqcHdF9OIkwt8Y1owSdJC2RHvl5IEFSdgDX3hzll00d2/XtQ
         7YoYAGVe4UzlUUa/LJJbVPhAtfv0qy/NN/BSKPJjOQEGiTQqCuctqyXJWl+bJF0wEJQj
         1qY48KbidRK2cZc7q9KVmCImm9aQZnBJwdPsoCbcrJ28RYbfxqV4nQIAh0cj98rQ8HNG
         ISaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h1zOiCGp2SOzH7yKlOvVi8ZsNGVGrJfvqqbYGSO/Wds=;
        b=eF+f00WZi6NJ+tf3k0iaeQ7jLpuqkknqWPmXa2cgL6z1anzUnUwGetSRl1T03zZ7e0
         FQ15UJNYICa4iLeekX/Nbf275KYi/8pBCIFsgk6/V/2bCd40QGMQHM0+bzAda/oTcsnn
         hC2Q1dpzf1Tq6/dYiOi1LW07DcKGND74fyqUWJKpy+KS42298ehhTmr85zSHSU/rf56S
         8I4umTWsOHt4RhrwYpjs91oVGaXEDdnX2Xb+K/PecDtlMT+r3wJ9t+OUUj3Z2XF7EIak
         Fb0Ex9PPUrjsNHCR3uObFfdOvvLGLUcrz7THIv20ygV6veu2gS59VceGUBxJUDnOXDic
         OXvw==
X-Gm-Message-State: AODbwcDYuVkH1T5SXlDHy4pievAA6tOI/ITiaGZ5zql8e/PTpqi1nGmH
        7nRasfdOM6xh0Hb9Jsv3F/7ZT98LKW9k
X-Received: by 10.36.29.150 with SMTP id 144mr9613328itj.71.1497005952161;
 Fri, 09 Jun 2017 03:59:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Fri, 9 Jun 2017 03:58:51 -0700 (PDT)
In-Reply-To: <CAN0heSo_S+_dut8RgDzVxffPZOzSTLwahsKrn7KG8aLvnrPbAw@mail.gmail.com>
References: <20170608234100.188529-8-bmwill@google.com> <20170609085346.19974-1-avarab@gmail.com>
 <20170609085346.19974-3-avarab@gmail.com> <CAN0heSo_S+_dut8RgDzVxffPZOzSTLwahsKrn7KG8aLvnrPbAw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 9 Jun 2017 12:58:51 +0200
Message-ID: <CACBZZX7U2SO11VZ43duLco1BhgM_XDzNTtrjcknjhijRkaeuxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] *.[ch] refactoring: make use of the freez() wrapper
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 9, 2017 at 12:12 PM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 9 June 2017 at 10:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>> Replace occurrences of `free(p); p =3D NULL` with `freez(p)`. This
>> introduces no functional changes, but cuts the number of lines spent
>> on this cleanup in half.
>
> It's even better than that. ;)
>
>>  48 files changed, 97 insertions(+), 197 deletions(-)
>
> The difference is in builtin/am.c where some empty lines are removed
> in am_next(), so no need to be alarmed.
>
> The macro would be dangerous with things like "freez(ptr++)" but I
> couldn't find any such side-effects. In hindsight, I guess your commit
> message says as much since using "ptr++" for "p" would already be a
> bug.

Yes, although perhaps we should call this FREEZ() or GIT_FREEZ()
instead of freez() to make it clear that it's a macro.

> I have no idea whether this conflicts with other topics, or any
> opinion on the best strategy for doing the conversion (all-at-once or
> "while we're here").

It has no conflicts with pu, so that's something, and passes all tests
with & without that merge.
