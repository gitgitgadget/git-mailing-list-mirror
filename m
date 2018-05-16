Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A53A51F406
	for <e@80x24.org>; Wed, 16 May 2018 20:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeEPUC7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 16:02:59 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:38404 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeEPUC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 16:02:57 -0400
Received: by mail-qt0-f178.google.com with SMTP id m9-v6so2792550qtb.5
        for <git@vger.kernel.org>; Wed, 16 May 2018 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=zisRqfBdDkOruFrUFDLjyRbWAImP5Ym5RU3G7i8MTIc=;
        b=KV9LWutiNV1Df5RfiSGlYbMBlhHvNAvjLRYj/SlGNzO1sBEIGJ8Xj0CkLDd/6YnI9K
         DeI2lKAc8WZmelgL5rk3pHdhskWQCkChJQ1EqtkcYu29bdBMDPlaHDYyGxW91b2Rt8ZV
         4Mh6XYWmNwXc3uKQVSbMCSOyfoFbBDlHtwX+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=zisRqfBdDkOruFrUFDLjyRbWAImP5Ym5RU3G7i8MTIc=;
        b=p18qt8k70vx9MAVwgy3OrRvOwuCPpkdisbVf+nZdCKI3N8cV097KbBjcRvX0HtMvbw
         YI0HKaoGVWoW6r6VnnEdFttapqUToNU3QyDPp9SCX8zMz78f0XA8CvX6lNnKDj4JIO1T
         /N/Yh5yJ+EgyOATBJShcD2OnOBHudpYKw9Ut7wWp5YIEwW3fuDsNNSPSLny7/aXXFyd5
         di4bwoI9OiHW738OZ3vzC6yqAzklqugXdG7EEiIEAPNCjSu330bqeIdpAf9e2faLnYH4
         cI0uokOd0sRH78AdityfFSIIAxEjLEcv5rxAtYSvnyZ9zmWR6odcb9A/KjqzkdS3xyaz
         4Dag==
X-Gm-Message-State: ALKqPwfpWkhGr2RvEL0UPUX6jHWU3WWXcdFNFAtUAod+1bNUQUfx05v1
        tLxdZLFSAGEg/YmuYfFdM+F98w==
X-Google-Smtp-Source: AB8JxZqV6bMn1BCfz+mi9gaq27UItvA8L2PPujOBg15TvjaOxSxKh9t1gC1huKrUvL8VUWDDjk0l+Q==
X-Received: by 2002:ac8:3633:: with SMTP id m48-v6mr2559134qtb.255.1526500977054;
        Wed, 16 May 2018 13:02:57 -0700 (PDT)
Received: from [10.137.0.22] (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id y9-v6sm2692613qth.76.2018.05.16.13.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 13:02:56 -0700 (PDT)
Subject: Re: worktrees vs. alternates
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87h8n7bhro.fsf@evledraar.gmail.com>
 <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
 <1950199.Z2x8tXoTfI@mfick-lnx>
 <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
 <20180516192343.GB3417@sigill.intra.peff.net>
 <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org>
 <20180516193744.GA4036@sigill.intra.peff.net>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <5156717b-6fc9-b792-dfa4-1ba48ac50333@linuxfoundation.org>
Date:   Wed, 16 May 2018 16:02:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180516193744.GA4036@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="69nc1hmW3aEHoZ9Ad546FlAMzJMq6y57n"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--69nc1hmW3aEHoZ9Ad546FlAMzJMq6y57n
Content-Type: multipart/mixed; boundary="bkciST5I4qD3QALHYl2cyhlrQ8Rr0cK5M";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jeff King <peff@peff.net>
Cc: Martin Fick <mfick@codeaurora.org>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Lars Schneider
 <larsxschneider@gmail.com>, git <git@vger.kernel.org>,
 Duy Nguyen <pclouds@gmail.com>
Message-ID: <5156717b-6fc9-b792-dfa4-1ba48ac50333@linuxfoundation.org>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87h8n7bhro.fsf@evledraar.gmail.com>
 <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
 <1950199.Z2x8tXoTfI@mfick-lnx>
 <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
 <20180516192343.GB3417@sigill.intra.peff.net>
 <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org>
 <20180516193744.GA4036@sigill.intra.peff.net>
In-Reply-To: <20180516193744.GA4036@sigill.intra.peff.net>

--bkciST5I4qD3QALHYl2cyhlrQ8Rr0cK5M
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 05/16/18 15:37, Jeff King wrote:
> Yes, that's pretty close to what we do at GitHub. Before doing any
> repacking in the mother repo, we actually do the equivalent of:
>=20
>   git fetch --prune ../$id.git +refs/*:refs/remotes/$id/*
>   git repack -Adl
>=20
> from each child to pick up any new objects to de-duplicate (our "mother=
"
> repos are not real repos at all, but just big shared-object stores).

Yes, I keep thinking of doing the same, too -- instead of using
torvalds/linux.git for alternates, have an internal repo where objects
from all forks are stored. This conversation may finally give me the
shove I've been needing to poke at this. :)

Is your delta-islands patch heading into upstream, or is that something
that's going to remain external?

> I say "equivalent" because those commands can actually be a bit slow. S=
o
> we do some hacky tricks like directly moving objects in the filesystem.=

>=20
> In theory the fetch means that it's safe to actually prune in the mothe=
r
> repo, but in practice there are still races. They don't come up often,
> but if you have enough repositories, they do eventually. :)

I feel like a whitepaper on "how we deal with bajillions of forks at
GitHub" would be nice. :) I was previously told that it's unlikely such
paper could be written due to so many custom-built things at GH, but I
would be very happy if that turned out not to be the case.

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--bkciST5I4qD3QALHYl2cyhlrQ8Rr0cK5M--

--69nc1hmW3aEHoZ9Ad546FlAMzJMq6y57n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWvyObQAKCRC2xBzjVmSZ
bLgTAQDJwV2d8mcbGFDhoNoxht+dpQmXRNgUx/koL7FZ31qsVQD+Ox0FL6BVvNzM
h2h6POfcl1lbdD52qZT9tJVp/idbjAU=
=uExR
-----END PGP SIGNATURE-----

--69nc1hmW3aEHoZ9Ad546FlAMzJMq6y57n--
