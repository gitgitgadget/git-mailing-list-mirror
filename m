Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C775207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 14:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966136AbcIWOeD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 10:34:03 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34104 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965954AbcIWOeC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 10:34:02 -0400
Received: by mail-qk0-f193.google.com with SMTP id b204so7213423qkc.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DrDNWtx7UDKNeG/ZzCsqadIm7ebTKD/g4PXY7LT4/IU=;
        b=pkSWyk717pNzPBbSDwGZBhpa8YRioP8/wB6Xd83YobQnrA7MN0NkBp6LM+f6cc9Tft
         s7UkpE/NRkKdLjNiQZfFtIlZVeVFY4rEcCKqbvXJMQgmxa1dlzK6LUanfp2ABZyg2RKC
         64kRzbhTV1U09/dy5yjkadAyIXZLMO8x1XoLkwXNHenVthMLHzOOJzIG88eEu579mTdF
         lDHjA8+FCvk/GGYkHX8dzY/TjzgXY0Pt4t/X1mBNnFoOw2Ziu/yqR2UwH35f87ITVWH/
         KnbEhuIkTk7Y/h7DLFA8DLXAYHxR9JfJRub4fwYSFUVq7Kem1CJdU4T4nnZKaOOkgam4
         KHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DrDNWtx7UDKNeG/ZzCsqadIm7ebTKD/g4PXY7LT4/IU=;
        b=X3hxXg6n5x8dApb3rwejPPUK4zxaNDpH6DS2DZa86GC0N93CTVHXVorhNTZpDEKVWy
         nLYvbPxktuxW6hKycMvfiwFFuuMG8eH5/wa26mNYsb/nxmknw7DXRyA8QKithjUj4R9r
         VCPT5k1B+ahQZ/9pNGg+R6LyMp4GIWT361czBmLsvE/sp/BqXTn/AwQkq+WBjEE85v6h
         kIvdHimkoqmKtriib5WNSHDJv5t7XqjlS1p0xFehj5eAxKxe8aU2ulbU+JcHqIR6QgCY
         XmnkA6n/3sbf/SaBcbmHiHXf/ks3L6lZi9iVHoo6NaCSHUiHTZWMR2kchbkWVprLKcFy
         8Sww==
X-Gm-Message-State: AA6/9RlpAnkdoifVBSMQhFwwAxzxkmUfZDXkSQ2MeThSUrGe9IWCPweVAUQJqhb+leqddMaF
X-Received: by 10.55.145.129 with SMTP id t123mr7744699qkd.130.1474641241222;
        Fri, 23 Sep 2016 07:34:01 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-16.NATPOOL.NYU.EDU. [216.165.95.5])
        by smtp.gmail.com with ESMTPSA id l187sm3979757qkc.8.2016.09.23.07.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Sep 2016 07:34:00 -0700 (PDT)
Date:   Fri, 23 Sep 2016 10:34:00 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>,
        Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: Re: [PATCH 6/6] builtin/tag: add --format argument for tag -v
Message-ID: <20160923143358.cl3he5bg27mfxwoy@LykOS.localdomain>
References: <20160922185317.349-1-santiago@nyu.edu>
 <20160922185317.349-7-santiago@nyu.edu>
 <xmqqeg4b39ye.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cl5xuexb3ue5ebz5"
Content-Disposition: inline
In-Reply-To: <xmqqeg4b39ye.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cl5xuexb3ue5ebz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> OK, you said something about for_each_ref() in an earlier commit,
> but what you meant was this one, which takes each_tag_name_fn.

Oh yeah, sorry for the confusion.

>=20
> The function for_each_tag_name(), the type each_tag_name_fn, and the
> function of that type verify_tag(), are ALL file-scope static in
> this single file, builtin/tag.c.  It seems to me that it is not
> necessary to make the format string global at all.

Oh, ok. I was thinking that this was preferred over changing the
signature of those functions. (I drew my conclusion from log.c). I'll
take this other road then.
>=20
> ...=20
>=20
> There are minor implementation and design issues I spotted, but
> overall I think the feature the series attempts to add may be a good
> thing to have.
>=20

Thanks for the review! I'll re-roll shortly.
-Santiago.=20


> Thanks.

--cl5xuexb3ue5ebz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX5T1TAAoJEEaPEizoFiKV1CkP/RLdjl1PZjDWH775+SOfU6EX
tBtmUVj20V3lj/hL4i1tSApKrWI8ug2+1T+wpBCV0mnust2D+4U7/pa2B69bcVV+
fYO0Pu7QQ4jD1IRn8/C/ftgXGhJOVhaBSuV3ByBpDMDW59bhhmgvYWcWGWOG0zSB
JkDIVazqURUH8yF7j7LpYcUEwXwohoId29Nvz3B/LUGJnOf1O52NoeHWzndKJ3Vr
4V/dlDZt9zfhwUgIxsuHadX30b6M+DmSOl7LS1fdKqpxDH4Gr2zIDhX67Uy0cH9n
kHNGz8Y3t5KiaQbWO2jyhIn64RFHAlrqBFeA2rKrTw1m2IZuT1Wh1J3Br9v1zXHI
JucqQOP4l6FB49tQVdmejipxp36ljUiWY7IJL1tsfUU7HwOO5/jWhFrTs3mNekbc
GyKvR08IWEn+qebb2pXtOEKdDU8XWNUCjK38jYKd1dgDr3qu4bRW9ofDUagiP2nK
ZfpvsJNaI3gjKIeIIhXGDa3XdRBIukU4EimexlOBNGMpLUUEuq2bdoVzYSK3tqKr
7XrNTDv07XmBtBxYQXu53uSvcY/nIPT7di+15cGXa5YIsOgmxXaT/wRx1hl9Rn/Y
o814HwPdpsxILXgYP1sYbkBDPCbElfvZ6R1kpR6hTwBcKhly594Fq1m4qLq4oFYV
iV3Rf3ehejC5JhlnfAHM
=06Or
-----END PGP SIGNATURE-----

--cl5xuexb3ue5ebz5--
