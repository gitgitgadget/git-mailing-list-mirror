Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61D841F406
	for <e@80x24.org>; Wed, 16 May 2018 14:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750806AbeEPO6Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 10:58:24 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:39089 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeEPO6X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 10:58:23 -0400
Received: by mail-qk0-f179.google.com with SMTP id z75-v6so875481qkb.6
        for <git@vger.kernel.org>; Wed, 16 May 2018 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=mVvO/OyMBTNJ58ZqWwNbFeWY0eGM4iDwRxA8+Xaey4g=;
        b=DzPSTVvy6QyGOAQX02PLVNBkw2JfDA2vaD2X/ipQZ2j7EpKwC8jhBBkbOc4r1MiuYP
         TZ8mgolMob8cK3u1fIlOMbD+ExZnM+ypDZdnM57H7JvdSt1nZ4dD+dudCvftvnxMaBl6
         IpqB68xTiGYvSIEWIECPfOL54HNyphgpxWiCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=mVvO/OyMBTNJ58ZqWwNbFeWY0eGM4iDwRxA8+Xaey4g=;
        b=QS5Ogl1njEtldzsGzWrMYnVVsNnqQgzDRhzFjCmYmrQhcDQRm0OLxyiXD20E3KCJoL
         8qveo2xu/+fCMza/RX/bU8UmDHPejlBTtpt76xGPwVndlTWzk9h37z00X3Tvc4Vz716p
         8i4kpLdUY3vMQD4HSYiyHbknMDynGs9oAud6uuLjbnF8Bzy5IfOx2lKuLs/NIvO717uT
         plbIebmj9cUkqTyWhkQFyKVnamhRoyX8kMQ2tXZjFGodRU50Zy+Kv/33nQG+IUg9kk1Z
         DJYESgEdvyQC+87EozJq9knqQm9XmAtkg8K+HDZfOQp6PzgM9yewItbfI09yrQb3p9iO
         jq7g==
X-Gm-Message-State: ALKqPwfV4lTj3z/589Cnh3DsZ9GEgyyj7o4qNXlZrZcjKrcXdG1mnlU+
        Pmc5MMRF0NK6Oz/vdG1oUmVuFg==
X-Google-Smtp-Source: AB8JxZp2g7U5va2D1SiMFnckfZV60OeMyCMtfXidblAeGhrTpK+Re7UVjl4I2+5QIdQOJnNPutlLgA==
X-Received: by 2002:a37:4248:: with SMTP id p69-v6mr1208433qka.131.1526482702216;
        Wed, 16 May 2018 07:58:22 -0700 (PDT)
Received: from [10.137.0.22] (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id 30-v6sm403929qkv.31.2018.05.16.07.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 07:58:21 -0700 (PDT)
Subject: Re: worktrees vs. alternates
To:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87po1waqyc.fsf@evledraar.gmail.com>
 <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
 <87muwzc2kv.fsf@evledraar.gmail.com>
 <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
Date:   Wed, 16 May 2018 10:58:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X1ysDT4zqJfLnfk57zhj4hQqJ4BaJPniN"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X1ysDT4zqJfLnfk57zhj4hQqJ4BaJPniN
Content-Type: multipart/mixed; boundary="274SyPh7zMklgZc5YNzLX64rlR0ZK7jNR";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Derrick Stolee <stolee@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Lars Schneider <larsxschneider@gmail.com>
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
 Duy Nguyen <pclouds@gmail.com>
Message-ID: <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87po1waqyc.fsf@evledraar.gmail.com>
 <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
 <87muwzc2kv.fsf@evledraar.gmail.com>
 <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
In-Reply-To: <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>

--274SyPh7zMklgZc5YNzLX64rlR0ZK7jNR
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 05/16/18 09:02, Derrick Stolee wrote:
> This is the biggest difference. You cannot have the same ref checked ou=
t
> in multiple worktrees, as they both may edit that ref. The alternates
> allow you to share data in a "read only" fashion. If you have one repo
> that is the "base" repo that manages that objects dir, then that is
> probably a good way to reduce the duplication. I'm not familiar with
> what happens when a "child" repo does 'git gc' or 'git repack', will it=

> delete the local objects that is sees exist in the alternate?

The parent repo is not keeping track of any other repositories that may
be using it for alternates, which is why you basically:

1. never run auto-gc in the parent repo
2. repack it manually using -Ad to keep loose objects that other repos
may be borrowing (but we don't know if they are)
3. never prune the parent repo, because this may delete objects other
repos are borrowing

Very infrequently you may consider this extra set of maintenance steps:

1. Find every repo mentioning the parent repository in their alternates
2. Repack them without the -l switch (which copies all the borrowed
objects into those repos)
3. Once all child repos have been repacked this way, prune the parent
repo (it's safe now)
4. Repack child repos again, this time with the -l flag, to get your
savings back.

I would heartily love a way to teach git-repack to recognize when an
object it's borrowing from the parent repo is in danger of being pruned.
The cheapest way of doing this would probably be to hardlink loose
objects into its own objects directory and only consider "safe" objects
those that are part of the parent repository's pack. This should make
alternates a lot safer, just in case git-prune happens to run by accident=
=2E

> GVFS uses alternates in this same way: we create a drive-wide "shared
> object cache" that GVFS manages. We put our prefetch packs filled with
> commits and trees in there, and any loose objects that are downloaded
> via the object virtualization are placed as loose objects in the
> alternate. We also store the multi-pack-index and commit-graph in that
> alternate. This means that the only objects in each src dir are those
> created by the developer doing their normal work.

I'm very interested in GVFS, because it would certainly make my life
easier maintaining source.codeaurora.org, which is many thousands of
repos that are mostly forks of the same stuff. However, GVFS appears to
only exist for Windows (hint-hint, nudge-nudge). :)

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--274SyPh7zMklgZc5YNzLX64rlR0ZK7jNR--

--X1ysDT4zqJfLnfk57zhj4hQqJ4BaJPniN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWvxHCwAKCRC2xBzjVmSZ
bKwqAQCN63TMF/z1qCrXH83t9xcokXec6bsTvZfjoTLXJVnx5AD/VhH4P8dmYWfd
EEVm7Anh1n0mehaurC4K7kkwL7hVUgg=
=s4f1
-----END PGP SIGNATURE-----

--X1ysDT4zqJfLnfk57zhj4hQqJ4BaJPniN--
