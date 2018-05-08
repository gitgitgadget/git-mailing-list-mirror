Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDA71F42E
	for <e@80x24.org>; Tue,  8 May 2018 10:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbeEHK0T (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 06:26:19 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:50449 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbeEHK0R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 06:26:17 -0400
Received: by mail-it0-f50.google.com with SMTP id p3-v6so15583989itc.0
        for <git@vger.kernel.org>; Tue, 08 May 2018 03:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=TKIwr6TPAXZPY/C9dsl3M7hqY7J1+m+lLtXUP3FjpiU=;
        b=IFliP1r2lCTI7YTcppp4YYIAlKToUQOE3EqGpsl6BXX1tZgavpzEsTxX3OeLsJ+9zy
         iQnE1e8FmwPobWZ1TqyNeXo/RpjiHiqsGvrcBrhBd5XEONdXzt4JYf/cKujwNjXebx9O
         DFNvtnNrAz0zTIa8RGLrgqBZAA5YE5ZD4naivgsqxwb5K0s2cGBjM716DJs+37TgHMNi
         i0talNGqL15QOGhY0b/r4dBBSPXDFYCOEn0MteQDaT2fE7KtninDza+wGmkerjJn4fa4
         SeN+F+vEPAPww/6bs4u3x2Uj63WYxUZLzEdELs+y5+FS6vXbIwZxwy3IZxNl881gdMOF
         BHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=TKIwr6TPAXZPY/C9dsl3M7hqY7J1+m+lLtXUP3FjpiU=;
        b=d4/gQ9khoReYtvOdtgLkzrdrCpEy22do2Hi4FT7363Qh7EAP8iO7FAWclDctZpih6f
         nSp2TE+OV63TRxOBRi+CgxaiH1y1+KGI7QHphnSnQNXNhuESzxflcTderuKE4h9Gm4el
         LJ1YjPJ6A0AqLxqGgKL4chitzP8g1486+Sj93ra/ZiJF/wa+fup1hPv89XyhYXsiqVgW
         CoeIRpzO5Q2ww9Vxnxr5mi5snxktYYD3Aq9QHHHovGGXTnkCO1d2NEYR8DrHFIBwp0RF
         0lurqZS47Mm43RLU7Pm+JTjN68crIGxzRimvLg6qeRKmIsvMDJei7hGTXrT8zM4ur5c1
         /vFQ==
X-Gm-Message-State: ALKqPweUQzTRDy63o5T+xHuRbYDTYfXL+AKd+4Ea5LXiXG3r+v01mlOr
        CGfWDyP3C8V4MD3h7SpfGsE=
X-Google-Smtp-Source: AB8JxZrWhX2lzFUuTIUf8LaZTkiR/bioJG9itJu2Rcus4g/R6LDDLG3xbFClJ31IIjLM4gN6gCzOYw==
X-Received: by 2002:a24:709:: with SMTP id f9-v6mr5324340itf.11.1525775177045;
        Tue, 08 May 2018 03:26:17 -0700 (PDT)
Received: from [192.168.206.100] ([117.209.132.10])
        by smtp.gmail.com with ESMTPSA id g1-v6sm5561947itg.27.2018.05.08.03.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 03:26:16 -0700 (PDT)
Subject: Re: [RFC PATCH v4 1/3] Teach remote add the --remote-tags option
To:     Wink Saville <wink@saville.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20180501165931.25515-1-wink@saville.com>
 <20180501165931.25515-2-wink@saville.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <5d61da6d-fa90-e25d-2bde-6f7f93f39c2f@gmail.com>
Date:   Tue, 8 May 2018 15:56:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501165931.25515-2-wink@saville.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kcbOhD7ras7StQcHRM7kRk0BGyzkKMVdg"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kcbOhD7ras7StQcHRM7kRk0BGyzkKMVdg
Content-Type: multipart/mixed; boundary="8SGVGxbFQTpRhnWmlg1UUcTSIqgotzYn1";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Wink Saville <wink@saville.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Message-ID: <5d61da6d-fa90-e25d-2bde-6f7f93f39c2f@gmail.com>
Subject: Re: [RFC PATCH v4 1/3] Teach remote add the --remote-tags option
References: <20180501165931.25515-1-wink@saville.com>
 <20180501165931.25515-2-wink@saville.com>
In-Reply-To: <20180501165931.25515-2-wink@saville.com>

--8SGVGxbFQTpRhnWmlg1UUcTSIqgotzYn1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 01 May 2018 10:29 PM, Wink Saville wrote:
> When --remote-tags is passed to `git remote add` the tagopt is set to
> --remote-tags and a second fetch line is added so tags are placed in
> a separate hierarchy per remote.
>=20

I find '--remote' in the option name to be redundant given that it is an
option to `git remote add`. I guess '--namespace-tags' would be a better
alternative as it seems to convey the meaning more directly to the user.


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


--8SGVGxbFQTpRhnWmlg1UUcTSIqgotzYn1--

--kcbOhD7ras7StQcHRM7kRk0BGyzkKMVdg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrxe0IACgkQveda2sPW
GWlJ/Q//QRr4+rXmgCAXAmWMx8PGdpWrSEKONzqeyypeTzlchkoelKeouWriX6o5
6B/4RurotNCfIteSOCpam8kAiwojOfng8nbBQEiZ89qdKU0YK8ZPxFm5OFGh5oEx
L+uMWYEZjdQQeWC+ShzGNMZpR4I/NT6a3YYbvIbWxJAUNuYy+bS4H8A+9p5nT7R1
1TNv8yHHm7wnKSYIoO23HQgsXpeBMezp2GL68t7Rs5qKcyqosVfWzI0Et0E96jtJ
CnjpOMlBg+M53tDCSllSlnbOFHmrHCqZ6oRh1gQH6QC6Oqlst2+MwlY95H2/W/p9
0Mf0l/leWt60REBk7tcCxooyijLv3/z9boF3e/H/29vy5Pt8YQ0BVVwejKVk6xCt
SPrVAzG7P1+g3FiMMSqpKUOuf0xPfpP2hMyJti0KsNzHwklScsWUsxWXU6PxZski
aK315yCcM9VbL++3GJLqQM/rBik+V+lq2PQlFNFru3gQXrejv8berftLr+itgJp8
Wi75YXBSvdKUAU6BaIvpAWB4GvYYB8ljVtLBEL6ZKgs6GZhy1A1DkMugjvzSXpvl
foLRdX9njrwC/3Ol+x2KEQYk/5FI+I/zM3WlX+As2M/fi5g3PoopX3JX3LAnmxzO
MPkoqdw78HmhWzVBIipCxeRzk8nNJLUITYv+cDwveowYlr41Fs4=
=6kvV
-----END PGP SIGNATURE-----

--kcbOhD7ras7StQcHRM7kRk0BGyzkKMVdg--
