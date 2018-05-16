Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F6B1F406
	for <e@80x24.org>; Wed, 16 May 2018 17:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbeEPRmB (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 13:42:01 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45650 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeEPRmA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 13:42:00 -0400
Received: by mail-qk0-f195.google.com with SMTP id a8-v6so1337405qkj.12
        for <git@vger.kernel.org>; Wed, 16 May 2018 10:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=aiHj3ldshb/pHcqws+2hiVyG8B/6Sivxbj/ubiweFoA=;
        b=gH6MH5g87aVbGva7ttkdkhppBWL8T2VfW1gaK9b/4wkNVA/m4VN+GdsmXmEhiJU3RE
         5cDSjgNW+GDLUgl4t4wm9aQoJC4283NnPSg6mJP/N2mGafYiT9sL2Flg4EigWNncGYzv
         lvu3KuvLI76s8Hs1M+1nK7shD9/v15LgTEqn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=aiHj3ldshb/pHcqws+2hiVyG8B/6Sivxbj/ubiweFoA=;
        b=LkCPqEmd/FoDphHgOcOIUy/nauEJlLBPP4vX/o9Tjp2wYaZbdddAcceH22DnZplTB6
         jywCtIU7GrZKHfozT10dp7xu6RJrlNDj4TiclIdULqME/RR6yjumyXkaFufnZr1NIPTV
         a3iqyfntV2NvQdt3jAl1TLBBXORb4hTgKLH6OJeSyMqy0k3oqHJqKCjig8GLnqWmDneb
         r8j2DEkQ1d5guqqK3F/kfZ0WDcE/HTUJqgpv82Pmvl9z2SpSQEFjIs7Aumk42UMJwrFe
         6qlYyA4m4jxAAqAhEK7iJ9wPFRdKvCINfSDsy74FRzpOOIOJbF3UXiLqTNWVEQd5BD+2
         ZOEg==
X-Gm-Message-State: ALKqPwe+BVlU4otmeap4Qy8RQqfmkiuHS2d7DOR/f87PyV8KVwNgplEL
        3FR1e7Coys4lPVNdWK3DYOC7IQ==
X-Google-Smtp-Source: AB8JxZqPjLh5zpUKQR4XVMuekYDW9c0e/LBEdQATJoD7pYB2XgqCX35nfsPIvOzlvkB0tBkucCZb1g==
X-Received: by 2002:a37:14e8:: with SMTP id 101-v6mr1835201qku.243.1526492519156;
        Wed, 16 May 2018 10:41:59 -0700 (PDT)
Received: from [10.137.0.22] (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id o14-v6sm2576341qta.23.2018.05.16.10.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 10:41:58 -0700 (PDT)
Subject: Re: worktrees vs. alternates
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
 <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
 <5972145.OdP4kjFpBj@mfick-lnx>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <099ff2bf-c0f8-60fc-7833-9b129dd4dffe@linuxfoundation.org>
Date:   Wed, 16 May 2018 13:41:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5972145.OdP4kjFpBj@mfick-lnx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d4XntEVUqLxFaiTVdpiwHBU2VdRY86zqp"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d4XntEVUqLxFaiTVdpiwHBU2VdRY86zqp
Content-Type: multipart/mixed; boundary="1PHPHRxHHcH9oPm1FlEGm8auosDzjaWnb";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Martin Fick <mfick@codeaurora.org>
Cc: Derrick Stolee <stolee@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Lars Schneider <larsxschneider@gmail.com>, git <git@vger.kernel.org>,
 Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Message-ID: <099ff2bf-c0f8-60fc-7833-9b129dd4dffe@linuxfoundation.org>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
 <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org>
 <5972145.OdP4kjFpBj@mfick-lnx>
In-Reply-To: <5972145.OdP4kjFpBj@mfick-lnx>

--1PHPHRxHHcH9oPm1FlEGm8auosDzjaWnb
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 05/16/18 13:14, Martin Fick wrote:
> On Wednesday, May 16, 2018 10:58:19 AM Konstantin Ryabitsev=20
> wrote:
>>
>> 1. Find every repo mentioning the parent repository in
>> their alternates 2. Repack them without the -l switch
>> (which copies all the borrowed objects into those repos)
>> 3. Once all child repos have been repacked this way, prune
>> the parent repo (it's safe now)
>=20
> This is probably only true if the repos are in read-only=20
> mode?  I suspect this is still racy on a busy server with no=20
> downtime.

We don't actually do this anywhere. :) It's a feature I keep hoping to
add one day to grokmirror, but keep putting off because of various
considerations. As you can imagine, if we have 300 forks of linux.git
all using torvalds/linux.git as their alternates, then repacking them
all without -l would balloon our disk usage 300-fold. At this time it's
just cheaper to keep a bunch of loose objects around forever at the cost
of decreased performance.

Maybe git-repack can be told to only borrow parent objects if they are
in packs. Anything not in packs should be hardlinked into the child
repo. That's my wishful think for the day. :)

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--1PHPHRxHHcH9oPm1FlEGm8auosDzjaWnb--

--d4XntEVUqLxFaiTVdpiwHBU2VdRY86zqp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWvxtYwAKCRC2xBzjVmSZ
bK6HAQCJLiHwq/Kxfc0bn84hF5OnSWl6vmQFa4MHK0gwnAor5AD9G7X8zeE/7Rcp
sWgXfO30BPsqQCMKVMtbFTNzsetkaQc=
=m/Rc
-----END PGP SIGNATURE-----

--d4XntEVUqLxFaiTVdpiwHBU2VdRY86zqp--
