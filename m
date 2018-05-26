Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5E31F42D
	for <e@80x24.org>; Sat, 26 May 2018 18:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032284AbeEZSpt (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 14:45:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32789 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032234AbeEZSpr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 14:45:47 -0400
Received: by mail-pg0-f67.google.com with SMTP id e21-v6so3621928pgv.0
        for <git@vger.kernel.org>; Sat, 26 May 2018 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=Yq7kvE4APqY6V1j94vtvCKrgDMYSvpBrnIM6R+yIIuA=;
        b=bRhINFSzy5g30um4Rmkrckv7kL7Jw8GA+vrLpkSJrkv1/TGip8abGoyyQnOZ6Z5rO3
         56x2K2gccqSc7Ni7k9vxuxdQRxwzecKpTXrig9Xaus56mioNZ3Nx5nTEoNIzmLJ1WmoJ
         x+d2WxmV7xW91KlscboI9RqCrB/TU8b1MD1OHy6CH/hx/fSGVAHkxNMqHy90DEo+Y6km
         rhok2focn/M8C4bMI1jBX2tW/uZTGU5gnBg2wTySPy78NG/ZU4ygUgNm9RXLgUcIRNDJ
         JONdFF8jKY43tOHHWp2ETX5/NFHIJFm5lYXlwyRgE+alypKv1t6rK98gfCl3jTXRPsyX
         WpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=Yq7kvE4APqY6V1j94vtvCKrgDMYSvpBrnIM6R+yIIuA=;
        b=f7q9RM8/DBMQjCrXeEwod4IgcoYp91gCWXWC6bXHU6cPvyWuXOG/cIXtfZDYTZmx0a
         PRkL/8f1QzPD/KRwuxL4+JyPqhZIrWfeeLisrISKhcgDgwpR4j/FRIf0DtpL2YXRqLHT
         eahAf+C+nV9O+DfYM4NV8D8YAaby7ZSkXCNq9YlujQlcXFCBlPhPq/eOAAVFwjFX/L45
         eue7Dj3Nzwx1IhDlJVZu773MPecgvfJIjgO8P7vCESvbVrVM8IZ1UQwyn5v1XjjOIWSX
         IXoywjwMXgqSbSRyMMRJZDgCdGDaAypIqW4slRfuC20+esKg8BKf+ZCmxAsusPktIu7F
         BoLA==
X-Gm-Message-State: ALKqPwcrtHSILdmMuE5Dhl8m5xy5s2esvl3fXuqQVblUJNt7SFm2mUWD
        kugrVNkg59xquWUOCrJNbkBisOO0
X-Google-Smtp-Source: AB8JxZp/9QR2nH2ICC6Il4wzHH0nai+ZuU8u5+v1toj8zjtGWOmD5VwoMkNQj4ZHHHa8e4Eqv8awMA==
X-Received: by 2002:a63:3d0a:: with SMTP id k10-v6mr5795237pga.255.1527360346391;
        Sat, 26 May 2018 11:45:46 -0700 (PDT)
Received: from [192.168.206.101] ([106.203.14.194])
        by smtp.gmail.com with ESMTPSA id k2-v6sm51271032pfg.82.2018.05.26.11.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 11:45:45 -0700 (PDT)
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
 <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com>
 <20180524192214.GA21535@sigill.intra.peff.net>
 <20180524193105.GB21535@sigill.intra.peff.net>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <ae75f388-edbc-8f00-e98c-825027a58c1c@gmail.com>
Date:   Sun, 27 May 2018 00:15:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524193105.GB21535@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4lBsCLPYbpGMcPvv09B790nyK83cOjvCU"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4lBsCLPYbpGMcPvv09B790nyK83cOjvCU
Content-Type: multipart/mixed; boundary="WxSryqncCvlsIMFHWNipsfMlUszRxLDar";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Jeff King <peff@peff.net>
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <ae75f388-edbc-8f00-e98c-825027a58c1c@gmail.com>
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
 <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com>
 <20180524192214.GA21535@sigill.intra.peff.net>
 <20180524193105.GB21535@sigill.intra.peff.net>
In-Reply-To: <20180524193105.GB21535@sigill.intra.peff.net>

--WxSryqncCvlsIMFHWNipsfMlUszRxLDar
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Friday 25 May 2018 01:01 AM, Jeff King wrote:
> On Thu, May 24, 2018 at 03:22:14PM -0400, Jeff King wrote:
>=20
> Hmm, actually, I suppose the true value of the warning is to help peopl=
e
> doing "git branch -l foo", and it would still work there. The "more
> extreme" from your suggested patch would only affect "branch -l".
>=20
> Still, I think I prefer the gentler version that we get by keeping it a=
s
> a warning even in the latter case.
>

I never wanted to suppress the warning message in the latter case. I
just wanted to avoid listing the branches. Actually the patch I sent in
one the previous threads[1] that avoids listing the branches has the
following behaviour,

$ git branch -l
warning: the '-l' alias for '--create-reflog' is deprecated;
warning: it will be removed in a future version of Git
usage: git branch [<options>] [-r | -a] [--merged | --no-merged]
   or: git branch [<options>] [-l] [-f] <branch-name> [<start-point>]
   or: git branch [<options>] [-r] (-d | -D) <branch-name>...
   or: git branch [<options>] (-m | -M) [<old-branch>] <new-branch>
   or: git branch [<options>] (-c | -C) [<old-branch>] <new-branch>
   or: git branch [<options>] [-r | -a] [--points-at]
   or: git branch [<options>] [-r | -a] [--format]


So, the warning message isn't lost. It just prevents the listing of
branches.

Wait, maybe I'm misunderstanding what you mean by "warning". You're
probably meaning something related to the way Git exits in both cases.
With your patch "git branch -l" prints a warning, lists the branches and
has an exit status of 0. With my patch it prints the warning, the usage
specifications with exit status 128. In that case, I still don't think
it's bad to turn "git branch -l" into an error now as it's been
incorrect for a long time now and it's not wrong if we correct it now.

Anyways, if you think it mustn't turn into an error now and only in the
next stage, a suggestion follows in another thread.


[1]: https://public-inbox.org/git/1527174618.10589.4.camel@gmail.com/


--=20
Sivaraam

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - John Sonmez


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


--WxSryqncCvlsIMFHWNipsfMlUszRxLDar--

--4lBsCLPYbpGMcPvv09B790nyK83cOjvCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlsJq1QACgkQveda2sPW
GWlDMg//QOCNdlyHEVeAp9CebzDZNYFEuDUoCOO9AQsDwFGIxVF9eyCEtuDlQlpR
c8BiAfgTe/DGMWHJprFCJX15BEbXqUoOehE4Veo3g6/d0YJYqzVN1IORqUj/dOj8
FSuslCWwvIqRygyJhHklX2zz1I7nd8Lhb5esqt3u19ejoTAgYZC+biOL61k8SxGL
V4R9lWKHup/vTu9qUKu6nceENOpF+C2AIvcKj6gnVG7469H7qjxw8ojh57IxaiWS
5QBk6Flm45eEdffli20dlG92UimAupud3zWbbdCNYzOacBdyHFaUIlqBAOnJ85GW
JTZgB22OMUX1/fB9WFfsZUWyQ5WMbqRfc554l43gI1/dZ4uLd+j9/0dQo8GoNeuu
3/fzOFvGlTnCtpq2ZRBZ6zXZqcI66inaHkcD6C0V085vMPZbsFLIckeIHkxAhlXT
CujyF+sFfXvsdBj/akP1x29axcJdn5hJXaGGxYiyDReawd/L0P/dTQnRX7DyA5d2
E5+VejIP3LF5++2Nob5eJ9U1aQz2auWrrHTF9lW+YS2avOPUEPFIXSBKxOiBImLy
0x0QDhbAT+tgGigysvu352YMsH90u+k/DduqDQVdnNXAa4Or3JXKUzsKyyXu8B4N
Mf5FNpoudjYAOdsi1ixQeqlT3ArmMb3sgVbmAXsrQu0sebo3fvI=
=Z1b6
-----END PGP SIGNATURE-----

--4lBsCLPYbpGMcPvv09B790nyK83cOjvCU--
