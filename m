Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 056461F406
	for <e@80x24.org>; Wed, 16 May 2018 18:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeEPSMa (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 14:12:30 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36560 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeEPSM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 14:12:28 -0400
Received: by mail-it0-f67.google.com with SMTP id e20-v6so4371585itc.1
        for <git@vger.kernel.org>; Wed, 16 May 2018 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=juOcimYB3akBm25xsd5d7xLTJKdoNrsw2E9hAeiFa7A=;
        b=GvPXi/F5CxIRO6/RXQzZhKuLz1tqDnp5eWa2C/otXRzDVpeo6ngPdZPeh/KoBOWGyh
         PmJSHO56AqzVcMd6Rp4zGI7V3GAYeQLKCMYbUEQ6WErK6q5hj7lCoxjn0C5C2LadYpEU
         vQu9T0dQZeQsotAZF8J4wnmp498AU39ndGynE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=juOcimYB3akBm25xsd5d7xLTJKdoNrsw2E9hAeiFa7A=;
        b=HzsPnUwJxz9KeROhJ357l9xTW26G1rjxoyohnzqgyueZkIjAShotz+WDbn6BTK47ou
         sr+ORdveA1eBGKJ0joI/Xp/6wLR/vbQrMcGl4f5H0AvZZLNtmyyMXSM6KgcjWc6JfxO5
         SJgOMSbC0jxVP1BF7+GZ2fIlVg73yyhomYWf7BHdYjXaTDcfr9wq3y5Tqdubdmyctz/b
         G+XTVUsU2HNeJA7AhSqirY6KzNSdHbqYrdnslSWpw+J4t80iPJUfM+oaV15583Vu9rVr
         4+/xbRz84ZjKIgpVQ2kpqBmgJWxhXFr6pNZtPfMaUSrWo0B3QlDjoXOrcmdzKf1QV4+o
         0LqQ==
X-Gm-Message-State: ALKqPwcOYZp2kRAmlNcfN7q4bqErE10p+9q65LrLo9fF+hwbh4GBNMXo
        U8TUpyueGhWX1cSwoIVdEsALRQ==
X-Google-Smtp-Source: AB8JxZoSiKjuhXoOaqg3VvgQIA2HdySN9+6BCEPKInsVh4SRGUzoz8Dr3UdXkjWt/4g8oG/qf8pj9A==
X-Received: by 2002:a6b:3708:: with SMTP id e8-v6mr2350120ioa.69.1526494347644;
        Wed, 16 May 2018 11:12:27 -0700 (PDT)
Received: from [10.137.0.22] (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id y125-v6sm1740447iod.2.2018.05.16.11.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 11:12:26 -0700 (PDT)
Subject: Re: worktrees vs. alternates
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
 <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
 <5972145.OdP4kjFpBj@mfick-lnx>
 <099ff2bf-c0f8-60fc-7833-9b129dd4dffe@linuxfoundation.org>
 <87h8n7bhro.fsf@evledraar.gmail.com>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
Date:   Wed, 16 May 2018 14:12:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87h8n7bhro.fsf@evledraar.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lnx2DGLFYXPLDfJbKA4fw1qtCul7DOqqA"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lnx2DGLFYXPLDfJbKA4fw1qtCul7DOqqA
Content-Type: multipart/mixed; boundary="PCLd90MbUPt1jsIi3uJT6Fh7HIUsjRx60";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc: Martin Fick <mfick@codeaurora.org>, Derrick Stolee <stolee@gmail.com>,
 Lars Schneider <larsxschneider@gmail.com>, git <git@vger.kernel.org>,
 Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Message-ID: <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
 <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
 <5972145.OdP4kjFpBj@mfick-lnx>
 <099ff2bf-c0f8-60fc-7833-9b129dd4dffe@linuxfoundation.org>
 <87h8n7bhro.fsf@evledraar.gmail.com>
In-Reply-To: <87h8n7bhro.fsf@evledraar.gmail.com>

--PCLd90MbUPt1jsIi3uJT6Fh7HIUsjRx60
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 05/16/18 14:02, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Wed, May 16 2018, Konstantin Ryabitsev wrote:
>=20
>> Maybe git-repack can be told to only borrow parent objects if they are=

>> in packs. Anything not in packs should be hardlinked into the child
>> repo. That's my wishful think for the day. :)
>=20
> Can you elaborate on how this would help?
>=20
> We're just going to create loose objects on interactive "git commit",
> presumably you're not adding someone's working copy as the alternate.

The loose objects I'm thinking of are those that are generated when we
do "git repack -Ad" -- this takes all unreachable objects and loosens
them (see man git-repack for more info). Normally, these would be pruned
after a certain period, but we're deliberately keeping them around
forever just in case another repo relies on them via alternates. I want
those repos to "claim" these loose objects via hardlinks, such that we
can run git-prune on the mother repo instead of dragging all the
unreachable objects on forever just in case.

> Otherwise if it's just being pushed to all those pushes are going to be=

> in packs, and the packs may contain e.g. pushes for the "pu" branch or
> whatever, which are objects that'll go away.

There are lots of cases where unreachable objects in one repo would
never become unreachable in another -- for example, if the author had
stopped updating it.

Hope this helps.

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--PCLd90MbUPt1jsIi3uJT6Fh7HIUsjRx60--

--lnx2DGLFYXPLDfJbKA4fw1qtCul7DOqqA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWvx0iAAKCRC2xBzjVmSZ
bKGlAP40q1U4QzaLF6Tx6YV5vhrOG/ShZvaN3g4aVfShm5HeQwD/aNM+YqWr320D
Vw5gLbX8ohyFuoSRAxqSA3IC0B7ahgM=
=0DJu
-----END PGP SIGNATURE-----

--lnx2DGLFYXPLDfJbKA4fw1qtCul7DOqqA--
