Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50912202CA
	for <e@80x24.org>; Wed,  1 Mar 2017 12:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbdCAMf0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 07:35:26 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35603 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752342AbdCAMfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 07:35:21 -0500
Received: by mail-oi0-f67.google.com with SMTP id a134so1247456oii.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 04:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IiRxacUYsUvLAH85ioKSalfJLjA4QrGYDIO8RXzM09s=;
        b=EOEJM4nGyZopFx2n72PReBFhYgwy0J98JQuf3VoWHr+qi8N1u2OChLHGsQO0PtwG+G
         D3Vp/EnH1Czz9/MtZaPnCl6qGkgAsJp9DnnQf6CCNLaPTE3uzN5zFbeLbu3/GwP5I4xo
         EJu//ATEc4wQSdNAOEbWoNEbP4Kn0OfOUukYhXP5uMBUG3F9xxvvsagFrmASHEKyedlu
         wNUHCnabrAU31Y8yjta/AQXjshmFumtglEVJ4rN/PxTn7qvZYDhfTvtR9e1QbXPoQcCp
         iAZQkFdGqndCniqwkDjkUJZuwGfh0qddHjaR/k4PBPL9Yk9mQGXpX2gKwFiixXVgv27C
         mHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IiRxacUYsUvLAH85ioKSalfJLjA4QrGYDIO8RXzM09s=;
        b=U40VyJlDWgv3kT+8H+ZRKzfcWN+ntQdj92o7mZaHnQ9qVXhbURY/YVuuwKnjKDugez
         nlMHmhnjwZfZjrBxmahLQR/7MtP8mukpDYdq0eJn1GPsi3Kk11GBh7ZWM4SZFftanDjy
         1mYXZdNB4nGndD5JsERt3VRYiyWY2NPmYB0ZX4eyJbupALGytTJqozIdOlI4yxblP/tk
         QQqdB3Uu+xFWbmcFWZs2QiX6smk45kD/RkqsSz+XOKvUfjbFCpIxjKTmpgMHJOCifaKD
         56aJFpa98Ncro0Yny7Yus0eOP3yPQWDJxqlWwMSUqYInWJDjQnQ3wQU8aiapIC/qr5+L
         ZXpQ==
X-Gm-Message-State: AMke39lGGb7Tt+esDmSNHUltKeeFpZrFrajRYx52Fsbyg6KY/W7P405o7Nb3NMwsAmvX3I/uGlIkAOOQI52Qaw==
X-Received: by 10.202.181.135 with SMTP id e129mr3542766oif.124.1488371720533;
 Wed, 01 Mar 2017 04:35:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Wed, 1 Mar 2017 04:34:50 -0800 (PST)
In-Reply-To: <7e5ef9e7-bd90-1917-d8eb-c6310c2744ab@alum.mit.edu>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-25-pclouds@gmail.com> <7e5ef9e7-bd90-1917-d8eb-c6310c2744ab@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 Mar 2017 19:34:50 +0700
Message-ID: <CACsJy8BOY8jsCrDYESJ6Gwy_p=J=c8m1qe64w18HX1Cv2AaYnA@mail.gmail.com>
Subject: Re: [PATCH v5 24/24] t1406: new tests for submodule ref store
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 12:34 AM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 02/22/2017 03:04 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  t/t1406-submodule-ref-store.sh (new +x) | 95 ++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 95 insertions(+)
>>  create mode 100755 t/t1406-submodule-ref-store.sh
>>
>> diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-stor=
e.sh
>> new file mode 100755
>> index 000000000..3b30ba62f
>> --- /dev/null
>> +++ b/t/t1406-submodule-ref-store.sh
>> [...]
>
> I haven't actually read this far in the patch series, but I noticed that
> a test in this file fails:
>
>
> t1406-submodule-ref-store.sh                     (Wstat: 256 Tests: 15
> Failed: 1)
>   Failed test:  10
>   Non-zero exit status: 1
>
> I didn't have time to look into it more; let me know if you can't
> reproduce it.

Fantastic. No I couldn't reproduce it, even --valgrind did not
complain. First step maybe just pushing your branch somewhere so I can
try out if you're applying the patches via mail (maybe there's some
changes in the base that affect this). .Otherwise /t1406-* -v -i might
be enough clue for me to dig in, I hope.
--=20
Duy
