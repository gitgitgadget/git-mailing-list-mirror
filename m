Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D151F42E
	for <e@80x24.org>; Tue,  8 May 2018 10:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754673AbeEHKTu (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 06:19:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33548 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754424AbeEHKTs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 06:19:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id i194-v6so20983519pgd.0
        for <git@vger.kernel.org>; Tue, 08 May 2018 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=4YSzkJmoekNYwfMo0eHS1uFJWC37azoKEeoe+w0Mf8Y=;
        b=HVtRKz9vzb51W1RxUdO+6lw4O5rEJcs3kW7NEuAPvlT1lyOfGLjrc5Rza756K9FW3I
         fZQ6QJl0D71p1lZqGDRVX5EqdM+DAScE7BTqDqj8FzMPYKPKIO/I5Ow7ofNZ3wbT/PrI
         DRu00ib36ArFtZZkwBjz0xf2nqopO2Cqgz4k58+PrmBixlGxSlNF3EvClg4rJsGGLqOH
         tbduYYd8L1cY5UKTp2gUzSNCuvQNmGRaui4+5IxPuvebB53g/6VBipOcjwZmKHlPaQXQ
         vUOqzqvQOPzAxTqJ0OZFNyCJv9Qj90eSwQjK9lA/CWYeYdJb2jRHiijEbnpcYK/DOlIX
         2m1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=4YSzkJmoekNYwfMo0eHS1uFJWC37azoKEeoe+w0Mf8Y=;
        b=C84e/WFT8VG5LBIbAiw4l9oDsxCYXRzeHYkWXcHlkWwAzlWZNukuIC2bYWyv25vVTU
         FxpioVpxfX7YqYiqSwgMlMBpxsDjUkT/yRksXvog3tj4lgB63rijkBIyNYp/cE3x+c5Y
         Mnvzr2m85aazq77FraPT94HURM5+5xI7xgeMICeYumuDh59+MTbwPq/onis2wCd6GFWn
         dZTBiw6tsiMx2qgCBHziavJJisLamBDYV5ScOq6iNgX8N03Ad6Co7f/qlDZcO9pxWCxX
         2nEeDDcSdU6M1Jxi2wblFHUaFXohIMIsaNIIcnLxGlmw0CXUX0QQVH9lRdliBrjBRnx+
         wFuQ==
X-Gm-Message-State: ALQs6tDz3R/aynTMXyrofWvhd4cITSnxCQZQkLeq+G0vqVPSOJYX7DaZ
        Vmm47GMp00cJ4aqMSZIt8GY=
X-Google-Smtp-Source: AB8JxZqSp3kUTRJzyZ1sjTsjDe546p9j5wLXGlAFHPkjYQYr33SgKkscLAH/pHMJNPwg7SttbRb9iw==
X-Received: by 2002:a63:6245:: with SMTP id w66-v6mr32360953pgb.55.1525774787905;
        Tue, 08 May 2018 03:19:47 -0700 (PDT)
Received: from [192.168.206.100] ([117.209.132.10])
        by smtp.gmail.com with ESMTPSA id z62sm56680567pff.57.2018.05.08.03.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 03:19:46 -0700 (PDT)
Subject: Re: [PATCH 3/8] push tests: add more testing for forced tag pushing
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jeff King <peff@peff.net>
References: <20180429202100.32353-1-avarab@gmail.com>
 <20180429202100.32353-4-avarab@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <589400fa-be87-ddf4-f974-5bd9ff43b298@gmail.com>
Date:   Tue, 8 May 2018 15:49:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180429202100.32353-4-avarab@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M9lUH40MM7Nkgo3xT1IZMUIT9O0Beoic7"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M9lUH40MM7Nkgo3xT1IZMUIT9O0Beoic7
Content-Type: multipart/mixed; boundary="uEAP0mW1k3koA2Vb7dSLz5VpMWUmrj1UC";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 git@vger.kernel.org
Cc: Wink Saville <wink@saville.com>, Jacob Keller <jacob.keller@gmail.com>,
 Bryan Turner <bturner@atlassian.com>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Jeff King <peff@peff.net>
Message-ID: <589400fa-be87-ddf4-f974-5bd9ff43b298@gmail.com>
Subject: Re: [PATCH 3/8] push tests: add more testing for forced tag pushing
References: <20180429202100.32353-1-avarab@gmail.com>
 <20180429202100.32353-4-avarab@gmail.com>
In-Reply-To: <20180429202100.32353-4-avarab@gmail.com>

--uEAP0mW1k3koA2Vb7dSLz5VpMWUmrj1UC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Monday 30 April 2018 01:50 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 15c8d5a734..c9a2011915 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -981,7 +981,17 @@ test_expect_success 'push requires --force to upda=
te lightweight tag' '
>  		git push --force ../child2 Tag &&
>  		git tag -f Tag HEAD~ &&
>  		test_must_fail git push ../child2 Tag &&
> -		git push --force ../child2 Tag
> +		git push --force ../child2 Tag &&
> +		git tag -f Tag &&
> +		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
> +		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
> +		git tag -f Tag HEAD~ &&
> +		git push ../child2 "+refs/tags/*:refs/tags/*" &&
> +		git tag -f Tag &&
> +		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&
> +		git tag -f Tag HEAD~ &&
> +		test_must_fail git push ../child2 tag Tag &&
> +		git push --force ../child2 tag Tag

As a person who came to know about the "tag <tag_name>" refspec for the
first time while seeing this patch, I found it a little hard to parse
the following two lines of the test:

		test_must_fail git push ../child2 tag Tag &&
		git push --force ../child2 tag Tag

Maybe some other name than "Tag" for the example would have made it
easier for the person reading it. Something like "foo"/"bar" etc.


--=20
Sivaraam

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky


Sivaraam?

You possibly might have noticed that my signature recently changed from
'Kaartic' to 'Sivaraam' both of which are parts of my name. I find the
new signature to be better for several reasons one of which is that the
former signature has a lot of ambiguities in the place I live as it is a
common name (NOTE: it's not a common spelling, just a common name). So,
I switched signatures before it's too late.

That said, I won't mind you calling me 'Kaartic' if you like it [of
course ;-)]. You can always call me using either of the names.


KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--uEAP0mW1k3koA2Vb7dSLz5VpMWUmrj1UC--

--M9lUH40MM7Nkgo3xT1IZMUIT9O0Beoic7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrxebsACgkQveda2sPW
GWn+Fg/+JdQR8sitmLJxlx3qjDZJRPhekRAYSW2ftF9eCvIwsKHIJAsDkmcrWWnR
ionDHnGVmVzDhLS1pZ8eI5So+EV8QbzoXDe+j0P5alY+magmnCWrJ9tACS0LG9pe
c1Lvra8hRMMdd/q2e6qbusdTtb92/zAvGqmrNXAZmT5lZgRMn27y3V+VIU2P6U5Y
r2cz9ByC8ryPQrzFHqR1Qy1V8tFoDP0yT3rH/mPtoU+uNnOYm/nylhZiOgLTIAO9
OaHFTgCQzY7Lwp625R9gSa595TY8HYTbVNRvNoysTP8xfzze4CbeoWIZSLZlHbRl
C//POMamR84s8toR416bB0nTVc9WwFkBT38Ta9Q8y7Zn5Xu19aHbW5ChCwJe0R9s
rK+7U0to1PEB2sQKA7NcxRyuSVtc3HJLcDMXi/DHyW3jNTBw4WURWKhYer8/3SlF
HkVm8pLwQVgzxvrC2vaPhe9/SV2EBBXVzCtzbgGbUzitbVp9heXR7gp9xGXO6Iw4
gGqeeahDehrJ0kMmCwDJTFY2LJiy5V0r8qKjKY/86tJygLgc7kpuVjtxIhA/Z0e4
iMa+9YKDrq4/ZsDYpVSOdu1blQW75etSnM0HoHW7cvMIXBYWe+XNYAzwu0NAbu7k
3XnCpagv3+aRvS99yYQnZBoWq8Z+b8pYHKRpRZnVNGXaPkRPhFw=
=ikXu
-----END PGP SIGNATURE-----

--M9lUH40MM7Nkgo3xT1IZMUIT9O0Beoic7--
