Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 043741F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 06:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbeCYGy1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 02:54:27 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:46834 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeCYGy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 02:54:26 -0400
Received: by mail-pg0-f41.google.com with SMTP id t12so4331197pgp.13
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=12JzSn8Qfj302PzSh9pJokl70Yd7be4IB7nAXMT7dRU=;
        b=BAxSG61QGlWs3fbKhvUcIO903iGvdogUQeD0st/Bd3vcOYZ2ycEVrjUU8vU0stGj7H
         BNeDSyUZ9dTMIP3COcrZ61BBqdFVD2qh7yYelV2AOLUZuabXBKotSv81AI2U533WZYXQ
         7J4ZFJiUW0siOhPgN7ubNkLEnBUSQbO+Vg2mRGc6cndPpiA1vdGlhVeFz6DXKRTplVAT
         eDosLrxjjaBoMV7VVncm8AcFqhu5Ib0s6NGzPDCsGaNRdvNE4zSF+undLb2tl4Nc8gsu
         goAQfYwpb5euIUbxB1EQhLnf9VEyieEoYVMTUyHGQ0g3TXkC3WFdU/c5JuyI1Wq8/9yq
         c1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=12JzSn8Qfj302PzSh9pJokl70Yd7be4IB7nAXMT7dRU=;
        b=Q1Lh/CZG0eJrFPgxLMa4zmHGtNMeqPBtIRY6w+sTBLD6seZJu1Qzl1YihkXmTe9Vf5
         e8QZx1P6fpUFfaVfjWcBPMX/R95KGSU+jn+gVfKWl+3TK5DGxAwS0y66xvaErA8Kb7lr
         r9WXnHiZy9+HdJK5FFydxG5qBK2wuICG+jiheIRAiywfgmc1FTyqcxA5Mros1U1lQj2n
         p0hpclt6bZ42YBsGDWLJzVM+CHMWtzzKtKOvCdUWpjwQgBeMMSRMWAK7X2j3CiCc83N+
         er+BnkdsDpuJrJw6wQp2RsduQK/Ijd+L+YZoGXMEcsymjQl2ZkS1cy+VNDge0EnDCsrz
         gKxQ==
X-Gm-Message-State: AElRT7F+txXh2vgrjNuzK9dU+1YkCIxT8Hn+Fjg3vtMKFpb0xlsbFDfg
        o84bMRYRgFQImNvXjmouDacgrVrM
X-Google-Smtp-Source: AG47ELuL8Z9TwyIPJvyuUDNVcLVlznEH2IM1CC4xIb3omNsggOBW+npT82w9wa5PWO0efiTTLN8+Lw==
X-Received: by 10.98.178.29 with SMTP id x29mr13530155pfe.44.1521960865496;
        Sat, 24 Mar 2018 23:54:25 -0700 (PDT)
Received: from [192.168.206.100] ([117.246.187.103])
        by smtp.gmail.com with ESMTPSA id k70sm16712467pga.72.2018.03.24.23.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 23:54:24 -0700 (PDT)
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local
 branch
To:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
 <20180325041056.GA22321@sigill.intra.peff.net>
 <CAPig+cRe9AmFv=GCxPOo5vcLGFuT1qdM60M4KV5P6UN+Ai-QoQ@mail.gmail.com>
 <20180325043337.GA32465@sigill.intra.peff.net>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <75722545-fe6e-322e-0485-70ec6b606cbf@gmail.com>
Date:   Sun, 25 Mar 2018 12:24:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180325043337.GA32465@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JlSIbJVKZpX9rVESZU6jyFLkdyLbdQBCJ"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JlSIbJVKZpX9rVESZU6jyFLkdyLbdQBCJ
Content-Type: multipart/mixed; boundary="h52bTRJDcNIElf7Wt5ZBYRHGyyBMfMZur";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Cc: Git mailing list <git@vger.kernel.org>
Message-ID: <75722545-fe6e-322e-0485-70ec6b606cbf@gmail.com>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local
 branch
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
 <20180325041056.GA22321@sigill.intra.peff.net>
 <CAPig+cRe9AmFv=GCxPOo5vcLGFuT1qdM60M4KV5P6UN+Ai-QoQ@mail.gmail.com>
 <20180325043337.GA32465@sigill.intra.peff.net>
In-Reply-To: <20180325043337.GA32465@sigill.intra.peff.net>

--h52bTRJDcNIElf7Wt5ZBYRHGyyBMfMZur
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Sunday 25 March 2018 10:03 AM, Jeff King wrote:
> ...
> but I'd prefer to avoid those kinds of magic rules if we can. They're
> very hard to explain to the user, and can be quite baffling when they g=
o
> wrong.
>

I fell the same too.

> IMHO we should do one of:
>=20
>   1. Nothing. ;)
>=20
>   2. Complain about "-l" in list mode to help educate users about the
>      current craziness.
>=20
>   3. Drop "-l" (probably with a deprecation period); it seems unlikely
>      to me that anybody uses it for branch creation, and this would at
>      least reduce the confusion (then it would just be "so why don't we=

>      have -l" instead of "why is -l not what I expect").
>=20
>   4. Repurpose "-l" as a shortcut for --list (also after a deprecation
>      period). This is slightly more dangerous in that it may confuse
>      people using multiple versions of Git that cross the deprecation
>      line. But that's kind of what the deprecation period is for...
>=20

I think we should do 2 as a short term fix for sure. For the long term,
I would prefer 4 as I think most users would expect "-l" to be a
shortcut for "--list" particularly given the current situation that "git
branch -l" lists all the branch names.

That said, I would not mind considering 3 if 4 has more bad consequences
than the good it does (but I heavily doubt it ;-) ).

I don't consider 1 to be an option ;-)


--=20
Kaartic


--h52bTRJDcNIElf7Wt5ZBYRHGyyBMfMZur--

--JlSIbJVKZpX9rVESZU6jyFLkdyLbdQBCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlq3R5wbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpFNoP/0tpocIDjfifFo1qHb9F
0xdh8BZZRs8j1Y6j1pSQHFnnfvIveQRMW1zPtRgNeIp9uYnd1XT7ogZBzkGxTtSK
MIxT6NpBI1gWbRjJgxpAJsuOGgdEjyN++W++aCDK7AL1SdvfIcpttGDZsnAs/Lc/
A23OVl5U2hIvDjR0I26/4JsJ17paorcf25QSPbYVtH7eYXKbehbN2xv4tEbqyzih
hyoIH8fg6V66fywmdx6qyQ/gcFGQzWr92aLM+Ld9gylcX3uE5cIoR9XMUBHfbTnB
TGEWr7Ndr9K1OODcZ95LQIkdyd29C8xw3xQfdufmGlf1QviAprY6+B/fUy9dt6yl
h6Qwu2SazmKrdY1vxkkp7lUjsnlaaIJA8VqrjUAnqnNNhZF3Km7N3OwaKu2vw7SP
cp2MfIH+zhkKljRHaHt0xX+9119AH2tlf6hkI+HcMNb6uMy0eKHtfujmSnlJKx48
cNZGxKn1MjThYipJ9Bu50B06j/ffd6LAQhTwAuLo6mykLQ9GGmw9xEIwy2QBu71w
gB0MrwtQ2yTA6AJOkmSHVsylrg6CLmx/T5GvtR+rZmJTm4wNPiYN7Iv5sl8uHb6p
qZg8Q350OWkU6tC0riCFGXry9tGa34DH8P9Dupsa+D4qc2P8HmvOlDPrVv0pM8Z9
pgKAfZs6BfbkdjhUuu63gAWC
=1w6N
-----END PGP SIGNATURE-----

--JlSIbJVKZpX9rVESZU6jyFLkdyLbdQBCJ--
