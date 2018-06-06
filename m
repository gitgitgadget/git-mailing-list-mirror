Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DE611F403
	for <e@80x24.org>; Wed,  6 Jun 2018 15:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeFFPua (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 11:50:30 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:43317 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeFFPu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 11:50:28 -0400
Received: by mail-pl0-f43.google.com with SMTP id c41-v6so4072913plj.10
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 08:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:reply-to:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=m4suCf+z6WH0fk4bkPwSFDi0dafwOrFxQDCRx0hF1RE=;
        b=MZOzobZ5co6aCUxb0OiAdLxd+5fo8N3f7tG48ULzfxhm19W8Uju/sN2pUfX7ygtGbB
         LdSy3yNOK4r9ZcJO9LUn6Aitc1tEweHwWmyGRhiJfWhBOGP4C/jwRzjHfyCZJhgWI05A
         q/uV/oQm4bc+4/4CLEa18MtSe7F94olIF3Y6MDXtI0avuj0OKhECHtGyPyPCVtFLG2c5
         6iEpHj3O9iRQF5lgDAGXHKu4jyxZg3ZELJEMGeQh3iVEGxsvg+7D7ym06PKUw7f1qE78
         NgRMmlYEWAVZdiwVPfxvDjnVVnHwEhW7CTm4a37n8JhCmjIWjnq6yc8G/0DUO9OmHBZ9
         UpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :reply-to:message-id:date:user-agent:mime-version:in-reply-to;
        bh=m4suCf+z6WH0fk4bkPwSFDi0dafwOrFxQDCRx0hF1RE=;
        b=j51huZQUxwewYEg6aAP2VMV2Sprz4n5vsREv+7rBRlMH8RR70Ncrf/U2haShs68nRE
         qM2vLQn9SjDu/wyE22vWes93M8IqZ/7IwTXyZXp7/L540uOW8UDFT9jVWLQHqEkxicdV
         tWnHyK1xGi2g7JBSxARe0GQUzq4jfy1zt7BrpfzS531mFuZAmhJM+CQRft1ieyfyc6lv
         qSQsPIywXw7n8WU3iigNICrbVaaTMCY2nUqUKWFYvaYugeoKasP9MT/rpzmAZMNxy/p1
         2hikVu8DAXqSoZLUY9JFhuUWKFDQOoNvdqC3fzArNonX5aVQ5JBsM154uBMQoQNelfVR
         wAuA==
X-Gm-Message-State: APt69E34MzzdCA+dWRJoWqeFsFez2OD3BgrA/SV2uMASlNHC8FGyUeRR
        hxKRMIDbZM2N0OuZNJe9iD2IWcGw
X-Google-Smtp-Source: ADUXVKIiyVxH8JZii46n+8t0QsoA/lDpuB+sZJ79Y5kPviphA3vN1rwZtXJQ/Ie8V68r3khDBKKxFA==
X-Received: by 2002:a17:902:6b44:: with SMTP id g4-v6mr3705117plt.390.1528300228126;
        Wed, 06 Jun 2018 08:50:28 -0700 (PDT)
Received: from [192.168.206.100] ([117.209.171.202])
        by smtp.gmail.com with ESMTPSA id s75-v6sm12581841pfj.125.2018.06.06.08.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 08:50:27 -0700 (PDT)
Subject: Re: [PATCH] t3200-branch.sh: use "--set-upstream-to" in test
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1806050712270.10467@localhost.localdomain>
 <20180605112446.17016-1-szeder.dev@gmail.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaarticsivaraam91196@gmail.com; prefer-encrypt=mutual;
 keydata=
 xsFNBFnvIZcBEACjJC0cawLgzPXd2EGPtDQ+HvmrUSLd9TrbUabqiT/YeXGgkYaP3DHwauNe
 LR0cfJhw20cyftoCq7qU6cDtCXcmBb5JzttvrT+4y6RcvoxTsw22i5TYxzZ/O2d9AVov0Jj8
 JH/L00wZfHExhXok8Qlr9wyU70z9N8GLjaABWevzqrN2eNdV6vdNv7wJFZBTNz4SnNNnHQhA
 f2ypBgTFQGzQe8Dq5S8YxOZQm6TMFKjXgK6fQy3AuoIk1yOIXkv5tc7LzOIEoiMAnQZ4u8Bm
 OgyXW7s4Uvw+j9yuhXGEdqfU4Sfd6EaRNHIPXueEXmsErqamBaQ2anomRdVbroife/jILhxh
 VYRnkGe+PzJa98csS7aDXWAYxiHJHYJdlcqSre5XpfqM0Tqf1CWiEEitNCoKciWywa+EC3bA
 0cEug/ckF8YcLO9C9sRCg+20e9PMg1Aa3lhftJBQSG3oQ15bvMVZ7Vx4/H9LUJL/j5+iMRK8
 H0Zrg2m5Bxx/JRzBn0wzdmsEaP+1J0NYRqt56dPNULRIsHdGTP22Ma/irqNxTX7nBTb+vwXe
 bz6PHiO1gm1wu46tosOI0tfFvAvf/2HsgaYUUffltNcTh21IQVtbCjF2TYcYRVeT/rcZ4WpU
 cIE8MP9Y+GIRffveumBm3ymBv8527BKpUdIkUktD823bFUEUgQARAQABzS1LYWFydGljIFNp
 dmFyYWFtIDxrYWFydGljLnNpdmFyYWFtQGdtYWlsLmNvbT7CwZEEEwEIADsCGwMFCwkIBwIG
 FQgJCgsCBBYCAwECHgECF4ACGQEWIQSaunlPpC6CxtSc3Q2951raw9YZaQUCWfnypwAKCRC9
 51raw9YZaX7sD/470YpgttrXPvjhg/kQTu4AGQrLkWLqWXPWLHD5U4eeE/P8N3w0jsM+B2tC
 RDiA41VFWR9yRfVSksQLOlTiHlA5fdmqX0Aho8ZcCW6y3i6TSlSF5ug+AjuEnAVRur7LNCah
 3oPkZpPhQr96EYXYmY+J+fA57MaQk/7BWqxWo/cdZaXu7XfSeFJ3/uxZcmbUXjiBxCZT49CN
 4pN0GcfL+hFKNcv78S3HlDR5/2xdSbRbpxcwwUsx+V4jxI3gQiuu6fxHak5060IJTJ4uX5ck
 fEQo7Md4tgZu3mrHOqojHywHIogOoZ0udmLqmLYBOi7H1aWCi0xhEIvXp3wFlWG4Cs+Zm9e9
 xpwVP/lPe9+LBBfO6FytUI3hrAhVhUwFjfOsugykFJsBKrAXaxkM1fy+ip74NgbEsE6gRTm8
 Ek41lazPOQ0pQOZ6SPX1VNaFV6vz2HWlaCiRLmlsret7U3yMBpcc++PR2gdRUdv2l3krA4ZJ
 LrZITKKKDLplb7GTmkUlbZ/bpuszjjf40+t/0whyhnoqWuquYUsm2Xv6xasAaImloeOkMZJJ
 1Ly20sdSCh8rOzqDFAdwu9JHlu4mUSClwEr8iRzO9yn5bJiFNPNqbBiCtVP2wFrWxRdz6rrk
 /vjTU2lZsIwO4CJZ6ACQsybzhiwNJXOi++mLMMEFyGMT7bQxIc7BTQRZ7yGXARAA4Dll9pMQ
 Ua47gquU+blPhhlqrW4UjGzWe+gjKkxTp1emUaG2fIPfW9ymmDAXQhC8q/eYyHoEmnJ5lyrN
 bzxxcNzd9ugFd70aZBQTtW3qlzfUBeMV3wyCtMkNnE702ZtYJkvzNJxmEem5vPlCW9gLsNuN
 Fwo358lG9iKBIR+oachlikxsN0+tocqe4XG+KAh08FenIAjyWidFoX2LQUvuSXX7O0brUg9V
 bMKTHSTWuZEUqELJUFPjQVV8NlgvLRSgz8xTNI+QVybbay1ZNUrI6hKG6GavRibPuAhtEsJ+
 SMS8lYRk4FkyFOZfpJhKv4uuIbUSO4MBffIsj92qAWw0Xt400NaKwh/UOXYS5Rs8o0MCM/Vx
 a9AYbP5UvhYVb4W4/JDAZXy5o/1myNUqpDw8JG4uXYYtxUpo+OaogdJhWT3n3sb7xwFEod/T
 0Zgttlh3PVnEiXuUsrB+Z0JYZw3/nZXw8rBmh1fC735v4t+U9s5YLKVePWvHr12TSV31aTUb
 ZuHDL6fRi93uEqm96VghmkMbSziv3iX+v8RkM93l+w7pd0rYUy6H3cUDV9q29DLo9BOFCUzR
 9enskWQA4ezSx4AV3boNuVFMsFhxgdDqkyqkm+qsSq/wYnsIT2uvcg2lqgNyIER4CezzPgXj
 7sNcXfvFedyAmsiOARt+oIIFjykAEQEAAcLBfAQYAQgAJhYhBJq6eU+kLoLG1JzdDb3nWtrD
 1hlpBQJZ7yGXAhsMBQkFucBRAAoJEL3nWtrD1hlpPfsP/j4ewvV1q6ZuBx+IAzHCFpZ60+yy
 JmHRlwwxlFjjFe9pV+r1/Zb4WxUNbTSyAP65zlTsOXK8nlR0AKXhtjdnI2mUrMuHcZgug4vz
 3NCDgWVeBy70n1kunQJpNc+FEFYZEdRbPpNGWfaMnr5wVtr/O4aPq4sTxs1IV6/MUL+tyuqD
 pzAnpj3deZ/RsiVHjNNwD0hs6nkRoHOjgmi5rUgrebNbJxxTMhJk8OfLcsxx/FPY+6Myjnis
 3dxFCFR37vjSjm9GSRRTxlI5Mq+jGgvag9Ww/nueTxFMUgXWQ6m/aws/FnXBImA8EC9MNjH8
 ZGUN2oThrnbzlBpBnfkCzriCtKxBjxP1ZeDeBuWoI1eZzeXIa+yx1EbLoRcnNCNVFE2dHgYb
 dhFFzR+lvJOOI0BdvO/wWS6zZRi5vLE0EQJX81Glsj6aY4+sIc83NsTaNpaIqIbYIzp/wNN4
 uUzah6XcnVQCm3OtfhW+scjdqUhvihDeWlf684OUTf7huTfYbWOE+DzAT+hrs0oaEXuVlUBB
 YkZ4Hv7M8LuQGn64pFrm4grbF/wxkmvgeyBTQA/A9WNWndlinlFYiZGmDoiZUAcSKA9oBTPc
 4jXwW/YIfNYwd7SlatiwKjF1QxuL1X0QMMPstR/UoVc3sbiabb4Km5jS2oU9q6KpeikRshMI
 IZ7P/DJ/
Reply-To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <8af183f2-7ca5-86ba-b189-6b6885158453@gmail.com>
Date:   Wed, 6 Jun 2018 21:20:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605112446.17016-1-szeder.dev@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="puJv4Fb674cxZDz6SyvhnbFKJqFUi4jL5"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--puJv4Fb674cxZDz6SyvhnbFKJqFUi4jL5
Content-Type: multipart/mixed; boundary="8WVbJRtcnBABCguCOO4S70lMItWit4XHl";
 protected-headers="v1"
From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Reply-To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>,
 Git Mailing list <git@vger.kernel.org>
Message-ID: <8af183f2-7ca5-86ba-b189-6b6885158453@gmail.com>
Subject: Re: [PATCH] t3200-branch.sh: use "--set-upstream-to" in test
References: <alpine.LFD.2.21.1806050712270.10467@localhost.localdomain>
 <20180605112446.17016-1-szeder.dev@gmail.com>
In-Reply-To: <20180605112446.17016-1-szeder.dev@gmail.com>

--8WVbJRtcnBABCguCOO4S70lMItWit4XHl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 05 June 2018 04:54 PM, SZEDER G=C3=A1bor wrote:
>=20
> Though arguably the test name could be more descriptive and tell why
> it should fail.
>=20

That's arguable, indeed. I was about to send a patch that gives a better
description for the test. I didn't do it as I started wondering, Is it
even worth testing whether a removed option fails? Is this done for
other options that have been removed in the past? Should we just remove
the test completely?

--=20
Sivaraam

QUOTE:

=E2=80=9CThe three principal virtues of a programmer are Laziness, Impati=
ence,
and Hubris.=E2=80=9D

	- Camel book

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


--8WVbJRtcnBABCguCOO4S70lMItWit4XHl--

--puJv4Fb674cxZDz6SyvhnbFKJqFUi4jL5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlsYArkACgkQveda2sPW
GWkMJg/9HxC7Unfx+GBKTmKrX+jdRQUR9eCFFp3Any1nM9TbGbOX4bbNchmN7Mpl
USJ6cisF4Q0qGp/FMuBvtVa54MuEr6svqaot6voY2EemJvv3wUpLYPhpe4oboYf4
GtvTS8IzJG8EpHih0ShBITTmZRCRHDIMIgCtQpG5rHbfcNojKN2s87k9ISM4s+C/
FJ0V/AhGBuVpYwj8dlq0ZMh9ppvIW8ABOi0pCkOTl8wieAfrnyOl1FrBGMPBaoCR
ijTe5bTKRAAvLDT1pHrWORiOtaHaeaZP5qaz//8FZOeEGegepZG0tVdo8sdPLYlL
MouYBmpNmiKbBLA18Hhjvu4p3mSaSDqKi2QgUsmut5GGM9s530V/Vf4C0KmOQ9WN
cMqUStiekYsgoR3OFIlg2Xy4X1jhhS7/E1GaKbrNvEweRwbyhDAv3QitXds4yy+t
L1/3W3usVFpBaJH8t3T2kjMNyKJ79vMcbPa/ULLXa31ywB9+CpcnQsV7opgZ72a6
BhNqrfM5DhFgB3vYUbO8TlTaYUrqhgWVkxeuDBLn3m5XQbnG68Bg72dV26R7k3JT
cQUZAH5g9xI0Npnty4d5La4FBGHPowZIeRBqdeC/Vntc9GcqoUA0M9xK1cqjbn9S
vRxj3Mgt8tvyjNytAa/ZI0RCjq2LzMBwIEGAyh8r00FQf45MYf0=
=QGJy
-----END PGP SIGNATURE-----

--puJv4Fb674cxZDz6SyvhnbFKJqFUi4jL5--
