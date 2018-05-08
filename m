Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C1811F42E
	for <e@80x24.org>; Tue,  8 May 2018 09:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeEHJxI (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 05:53:08 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:38892 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeEHJxD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 05:53:03 -0400
Received: by mail-pl0-f51.google.com with SMTP id c11-v6so1921029plr.5
        for <git@vger.kernel.org>; Tue, 08 May 2018 02:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=qxF7tD5ftWha73B3LlAbl5nkzdLOs3njOrFHCPWc28w=;
        b=IUU+JCvjYA613BZtoRsJ/mIPk/8qSYoqhBh7xFzPxx2aoZxDju4t9y6l3Z7C9JqcII
         mVW0pJO4BosD4f8/b8SzuHo+x5ByllDfZvHsQHFWY6SrzDxdSscda9OrymFq5PFGBGjD
         4OtpTpEoiDOpSFcwkh+bnhl0pTdp01fyEVqi+/1fH2lxaEwyEySHHxhUyaeIqjot3CNd
         2vqjW2KJfqtwic1qVhBRD/juKKVQsO3XNOSgrtJQCIgz/kzC5habr8XN4Y4VDj8iMhFv
         PJPr6bC7dK8KMxxCG0nPAwQT++78OHCn5HBm9i1A099k1aTKo1XdBpLay6wYgJzlbaPr
         qoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=qxF7tD5ftWha73B3LlAbl5nkzdLOs3njOrFHCPWc28w=;
        b=JVvL1I/8gfn05vDNRiiVZclXbQDnN7fPA7jOyjhD/eC4CJeeqTr1TE9e5K+tTJMvQD
         LioIs3XhsVAogn6cXBd4pgVqeiLG3f2fGSwsmPxBMJUuNnUSutfAM/Lv/ZjgUgeZID2v
         dsRdVKAn9ugNLRKRQOhKC7cFFMFhS6jF6ncnktY1P15mmlW04yhP3I2zSXMIhJC2+eCW
         SAQojxaFHO0jka+ux67dcr0wWH8QzbHM6VT9KlSMhSSNr2kUNvuG/zHyBBXBEJVldH/l
         T/GbAF3lSMNM7VvpLnfo01PV83Qbpy3/D88bzN4rJCdlae2ZxbPQixYMF2v/Xvm9juMB
         L8rg==
X-Gm-Message-State: ALQs6tDQjZPpEGLJgFXlkXPWm29cvXdPJUvv20f5vqUwkPZsRQm2jLND
        pexNT/kQC9ZTm8rFylodnYgkAGTm
X-Google-Smtp-Source: AB8JxZrLFqCC5rgwVFfAxYfWWMyr7XtINR6PDfZED98rN1dh5vD9x4EzBUnILaasORV/cE943FDbtw==
X-Received: by 2002:a17:902:341:: with SMTP id 59-v6mr19395769pld.324.1525773182648;
        Tue, 08 May 2018 02:53:02 -0700 (PDT)
Received: from [192.168.206.100] ([117.209.132.10])
        by smtp.gmail.com with ESMTPSA id a6sm44762122pfo.88.2018.05.08.02.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 02:53:01 -0700 (PDT)
Subject: Re: [PATCH 3/8] push tests: add more testing for forced tag pushing
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jeff King <peff@peff.net>
References: <20180429202100.32353-1-avarab@gmail.com>
 <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
 <20180429202100.32353-4-avarab@gmail.com>
 <xmqq8t8uoovn.fsf@gitster-ct.c.googlers.com>
 <xmqq4ljiomvv.fsf@gitster-ct.c.googlers.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <f3b891c3-381f-de42-51d8-24fdfbca91d2@gmail.com>
Date:   Tue, 8 May 2018 15:22:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ljiomvv.fsf@gitster-ct.c.googlers.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OmPzfRtmMgt1vcL70dlvnxM1Oe0e4OxQu"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OmPzfRtmMgt1vcL70dlvnxM1Oe0e4OxQu
Content-Type: multipart/mixed; boundary="H1P9lIDKT1sdVE4XtTDAayckubzh0QcTt";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc: git@vger.kernel.org, Wink Saville <wink@saville.com>,
 Jacob Keller <jacob.keller@gmail.com>, Bryan Turner <bturner@atlassian.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Jeff King <peff@peff.net>
Message-ID: <f3b891c3-381f-de42-51d8-24fdfbca91d2@gmail.com>
Subject: Re: [PATCH 3/8] push tests: add more testing for forced tag pushing
References: <20180429202100.32353-1-avarab@gmail.com>
 <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
 <20180429202100.32353-4-avarab@gmail.com>
 <xmqq8t8uoovn.fsf@gitster-ct.c.googlers.com>
 <xmqq4ljiomvv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4ljiomvv.fsf@gitster-ct.c.googlers.com>

--H1P9lIDKT1sdVE4XtTDAayckubzh0QcTt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 May 2018 08:49 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> I couldn't quite get what you meant by "(but not the other way
>> around)".  Did you mean
>>
>> 	$ git push --force ../child2 refs/tags/*:refs/tags/*
>>
>> should not become non-forcing version because of the (lack of)
>> prefix on the refspec does not trump the --force command line
>> option?

When I was reading the commit message, I had the same doubt about what
"(but not the other way around)" actually meant but I assumed it meant
that "the `--no-force` in the command line does not override the '+' in
the refspec". Maybe the commit message could be updated to clarify this?


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


--H1P9lIDKT1sdVE4XtTDAayckubzh0QcTt--

--OmPzfRtmMgt1vcL70dlvnxM1Oe0e4OxQu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrxc3QACgkQveda2sPW
GWkOhw//ZLewVaKEf9I/k84ABuvi7tFwvQOM3ZXAMtc4K+pOmkfGZIiPfq3EtHBO
GQbpJP4Ry601GgDmMhBIZPJunU4FrW1KNzL6f2WHc8/5ftnyFJOD8iN/8DFesURq
l9ys786ffOPvThfdukIWL6eNy3DNO0/3hCfq78MrJn1vlOUmwyTrDMz6XRdDjX94
ACzKA+mf9JaQfEU9k32QTgnV//izwq9tKqLcnDLGkyBvLiJKuuIEwm/ByysU7jQD
TorS8US8n5DNE4ocUCijAhH5h8f+diBTcMCm/VDKXRcZ3UKUaoIWngOTKI61+JdJ
t00i6fUO53Iko06EWqRBWdS1CA+zuNzbCDIfkECElEZ/f4kvlJt4Qpz6Lt/i6cMp
HO384d2I8u3P2DlNOvcJuhAg/MSkGcODL36e34DGz4wtbHJDtUbi+UfthEdYuRpP
EgIsP9jflM+ZUUP6IlbGzuOIN7lwrkq3myofG8/9VKsxL4DZ4cs9VCLevI6diXmw
EbAYHkZiSFl96VGV6pMLSVm/kKbPS3PNXdtPc2AW0f/8ACB9qIYr9oPc1+N3v+Gn
9v/Jt7EP9uaKT8kzE+q6NvK5DbDStmFxhN3dLnCqEWjx6DW6YoA9YMzVLDaqQqML
neGgL0lcQjrXeh0eh8Gpyk9qilcqPYH/7l3qRgFiW9cMZmECwWU=
=1itn
-----END PGP SIGNATURE-----

--OmPzfRtmMgt1vcL70dlvnxM1Oe0e4OxQu--
