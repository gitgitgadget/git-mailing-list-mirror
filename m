Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D2C1F406
	for <e@80x24.org>; Wed, 16 May 2018 19:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbeEPT3r (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 15:29:47 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:54012 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeEPT3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 15:29:46 -0400
Received: by mail-it0-f53.google.com with SMTP id n64-v6so4846978itb.3
        for <git@vger.kernel.org>; Wed, 16 May 2018 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=6g9BmaUVrP1awbwei3QOQkXdCKNrPhUf51HVh74eRuE=;
        b=fRGayMr/zqO5suxo8UhgbugYG06t9vvkKjYscuhBpiERX2K4EHSRGPZPRwT8y64CCa
         ep1lE2Io6WYyH0/3MhOe8qL7hYg6wEuPGPwd2y2sdBJrCAoKJGnI3SqxTjGVJe4YXPbu
         NgzzJM7UT8+feBiNG/r9n2J00Xu8AkPXWi1m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=6g9BmaUVrP1awbwei3QOQkXdCKNrPhUf51HVh74eRuE=;
        b=HUWVi/mnZCYQMygSA3+WX6rhejseqWgW2DnYYL+qthqlEa2j+1Az27iaOBmixX3pDS
         wb8pCgV9IMI/CNLKBjJFUfx7Rv4r96/ruco0AOnOT+K8Qi6PEjk59Q2PdiEOcSsKFu1F
         2jSkVvT1Ie/7Ov0qObrDDjzGva2KPVmUdUhs757DvswCSKB+bp9NuX+vUzCPN1zrid03
         ovGdTNPgPLfrFXVbOE3xlfFXIGSEjIpMYNIiE7CD0ucyk8CTHRkzVBeOOH3IItfQAlz7
         IaLIO0+QSmLPyWThk398lk9px0cnkOPmuAhIbLZKNCfnP7iQWd1iG+I8DT8TGcXlfMOo
         4nzQ==
X-Gm-Message-State: ALKqPwcbvphtU4gI2Y+2QDCh4ZAldgS7ZRhxC9Bd+rCgf+lFkVWKRA1Q
        FiY5vxXLr1FC4VX16aGA4DjKiA==
X-Google-Smtp-Source: AB8JxZqlfJT6xuo3I9clzenUwUW8kN1DRF03zD8ErnfPn741GqLbqdE+9yGjB/dw1tXAnkI/JsIDkw==
X-Received: by 2002:a24:aa4f:: with SMTP id y15-v6mr2764927iti.144.1526498986226;
        Wed, 16 May 2018 12:29:46 -0700 (PDT)
Received: from [10.137.0.22] (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id n89-v6sm3501062ioo.45.2018.05.16.12.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 12:29:45 -0700 (PDT)
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
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org>
Date:   Wed, 16 May 2018 15:29:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180516192343.GB3417@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nGFZtulpQinh5fisV6ySUFodNKQuYrcqd"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nGFZtulpQinh5fisV6ySUFodNKQuYrcqd
Content-Type: multipart/mixed; boundary="NpDRZk4fEI1PLPEFg16HIY81q78y5uxZ7";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jeff King <peff@peff.net>
Cc: Martin Fick <mfick@codeaurora.org>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Lars Schneider
 <larsxschneider@gmail.com>, git <git@vger.kernel.org>,
 Duy Nguyen <pclouds@gmail.com>
Message-ID: <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87h8n7bhro.fsf@evledraar.gmail.com>
 <a933cb3a-6c04-d963-aeda-b5850ca8994c@linuxfoundation.org>
 <1950199.Z2x8tXoTfI@mfick-lnx>
 <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
 <20180516192343.GB3417@sigill.intra.peff.net>
In-Reply-To: <20180516192343.GB3417@sigill.intra.peff.net>

--NpDRZk4fEI1PLPEFg16HIY81q78y5uxZ7
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 05/16/18 15:23, Jeff King wrote:
> I implemented "repack -k", which keeps all objects and just rolls them
> into the new pack (along with any currently-loose unreachable objects).=

> Aside from corner cases (e.g., where somebody accidentally added a 20GB=

> file to an otherwise 100MB-repo and then rolled it back), it usually
> doesn't significantly affect the repository size.

Hmm... I should read manpages more often! :)

So, do you suggest that this is a better approach:

- mother repos: "git repack -adk"
- child repos: "git repack -Adl" (followed by prune)

Currently, we do "-Adl" regardless, but we already track whether a repo
is being used for alternates anywhere (so we don't prune it) and can do
different flags if that improves performance.

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--NpDRZk4fEI1PLPEFg16HIY81q78y5uxZ7--

--nGFZtulpQinh5fisV6ySUFodNKQuYrcqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWvyGpgAKCRC2xBzjVmSZ
bFvXAP0VuPXPdZteIueIsmQdbGgbDd3RcsN8LXS7ZlZPROyE7gD/REzxoviJ+kvp
J54GMtybTYuUKI656Jq5bmhI6BR08w0=
=meIN
-----END PGP SIGNATURE-----

--nGFZtulpQinh5fisV6ySUFodNKQuYrcqd--
