Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0014B1F462
	for <e@80x24.org>; Sun, 28 Jul 2019 01:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfG1BlU (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 21:41:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46647 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfG1BlT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 21:41:19 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so112546914iol.13
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 18:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SiX4+IufY1bba2ICGKXHbNeSLyyIRSy+wc+9Lt0kQ1U=;
        b=OP30i+7YZCUr0gIO1MDBMnTxqfIeEOaRF8qGHWExd+mkqaTttMZp+erEVKmy9ux8Ff
         a1Z/RoPwh+bQP/UF4O9DJc9qTQJX/uCd9e1Jyq7zdiXjIyImQyMlk0BBrgTTx87//mlQ
         fo5rC8LWETT9XCqUI2NvMWx+iBIiuf/f8Xf245Ex77dmiaNe1Yr+rupRhEVXiR3RdGfr
         99iOk3ARrQMw6rWEqcDue0/DMfO6A9LsEuPo+c46JyEG+EphTZ1d1yEdM8wo6OpmiOMm
         cXOksm0th98g0nSB221DwRh7ADAcsIXT+E9zcKQNbc3sb74Ongw5g6YmSkzZkB8YhoBd
         Px1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SiX4+IufY1bba2ICGKXHbNeSLyyIRSy+wc+9Lt0kQ1U=;
        b=UT+v5G/IWGBDgAFMJFr0Mcug7+O/af07jIhNGYW5ubu1cyrInHS1hD/nRd+4oDJT3W
         N22bnjNdCPuIq6gCx0+VEVBORmhFydhibtx4yZC6k6ZwSbmEvzP6vAH4AAmldDJCOOcL
         DwabiErrCqkRUqU8ibfCOPQ0fMqMMvErvoZ3igpHNoaQ8yyE+8hjn7V0BTIILxeoJB2v
         LOdes3+eKhO4F5z5Kxmk+bRtDoKbhB1zQSvWIwtEKHOOo3YGVqhjSKJiaFqy29hIG7co
         oftR2FbQeGOGILsFCbzZGpjJbdybIKCqHcit8hOK6qD4lbSAjt2ha78wWHDnChJFy4US
         nR6w==
X-Gm-Message-State: APjAAAXogDW2N1iYYcmzHW33G9huy0pWzhT3InN6QduigDlPk0zvgS2/
        37+xUD/8802NIBECniRzCtfIlaHpY09wIlNKvaM=
X-Google-Smtp-Source: APXvYqwFcOQMZvlOzncWRkAyCPEwsdpnQUEvDYxdoMch10xn+lFC3f2OwFKTFnsNefKCgyNyOQOXNQq0TjCWJssAbYY=
X-Received: by 2002:a02:bb05:: with SMTP id y5mr101777977jan.93.1564278078919;
 Sat, 27 Jul 2019 18:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190727202759.22310-1-carenas@gmail.com> <20190727202759.22310-4-carenas@gmail.com>
 <874l376nud.fsf@evledraar.gmail.com>
In-Reply-To: <874l376nud.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 27 Jul 2019 18:41:08 -0700
Message-ID: <CAPUEspgowrhj56SzW8cPKjZL28nPTkX-RScKrSAai8i0YkwFaA@mail.gmail.com>
Subject: Re: [PATCH 3/3] grep: plug leak of pcre chartables in PCRE2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 27, 2019 at 4:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > +     free((void *)p->pcre_tables);
>
> Is the cast really needed? I'm rusty on the rules, removing it from the
> pcre_free() you might have copied this from produces a warning for me,
> but not for free() itself. This is on GCC 8.3.0. How about for you &
> what compiler(s)?

both will trigger warnings for the same reason
(-Wincompatible-pointer-types-discards-qualifiers)
with Apple LLVM version 10.0.1 (clang-1001.0.46.4)

gcc-9 in macOS triggers 2 "warnings"; one for discarding the const
qualifier (-Wdiscarded-qualifiers)
and another for mismatching parameter to free():

note: expected 'void *' but argument is of type 'const uint8_t *' {aka
'const unsigned char *'}

Carlo
