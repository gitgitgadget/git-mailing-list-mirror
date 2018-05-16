Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4D21F406
	for <e@80x24.org>; Wed, 16 May 2018 19:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbeEPTLw (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 15:11:52 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:39240 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEPTLv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 15:11:51 -0400
Received: by mail-it0-f50.google.com with SMTP id c3-v6so4794645itj.4
        for <git@vger.kernel.org>; Wed, 16 May 2018 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=hb5S28Uo0fAh2JgcBuWlMwPhdYxEjWv0vfoeyzFlqYk=;
        b=OPMgnCFY+gczCcIjOp2fKRpOfNhPpA7WOuuN5sfcWZ9CDMc6qQm9ZmlHbSR+9X3S+7
         uhGezUH92IamwpA5BjtWXpJOfX0PRj5aq+wlhR2UF+y6UkRutWaUeZp/OI2RT731o0S3
         qKglCeCczjvCJdSLXWRjw+bdOtSbil/fIhsoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=hb5S28Uo0fAh2JgcBuWlMwPhdYxEjWv0vfoeyzFlqYk=;
        b=LopbYDsz7Gh4P/oUSyz7S++R2S5bwyenjrrKo+CtG+nrJpXMrx/3gPcnvApM6WQHO9
         GkATmcxiuKxDALG3vRUBBKBmCmL7stafF/3zxKxDFfRaoeSYccWKdzqiw58kFxfwnP9h
         4k1xmXJtyZWSZQNZzKd7Du4hVyLp8+iESl4wrUAobaj5VWjCZFMyM91M7iPPmd/SlvBm
         2OLe6ckl7g7ZL/UeCDIF0PzabYBSfW9FJgZ7gpdLrRqRYS3yFufORRMOsvyV9/6giTmN
         sZeIPpGrMmHwDOEgOIOzyoTOqdxfnM5C/hrzXADcaeCE/7wr5CJvB38O9bg5fT37b1Mp
         dqvA==
X-Gm-Message-State: ALKqPwfo0qXCrviyLeQz1w/gOET7RY01vrn8TnlFDhkV2J5PLfaJs5KF
        0oNidpXpKWjiREMJHp1eMSUZBuiJAxM=
X-Google-Smtp-Source: AB8JxZpGnrhS8B2BOSWLyf2hP5JAz2cWkGrJnfj6udnOCrWFyWIbjCMi75UuZ1yERhrxVJoxsHDrVA==
X-Received: by 2002:a6b:821e:: with SMTP id e30-v6mr2431277iod.264.1526497911054;
        Wed, 16 May 2018 12:11:51 -0700 (PDT)
Received: from [10.137.0.22] (ca2x.mullvad.net. [162.219.176.251])
        by smtp.gmail.com with ESMTPSA id i12-v6sm1912109iod.85.2018.05.16.12.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 12:11:50 -0700 (PDT)
Subject: Re: worktrees vs. alternates
To:     Martin Fick <mfick@codeaurora.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <1950199.Z2x8tXoTfI@mfick-lnx>
 <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
 <2828274.Q9q2dc6g5t@mfick-lnx>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <4a18e167-8cec-0141-fe2c-4e0a35f16daf@linuxfoundation.org>
Date:   Wed, 16 May 2018 15:11:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <2828274.Q9q2dc6g5t@mfick-lnx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v0Rwi5o1CH3dN3gcOiIth0o1ZXL5suwuV"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v0Rwi5o1CH3dN3gcOiIth0o1ZXL5suwuV
Content-Type: multipart/mixed; boundary="PeIxoodKx8CVTVdFgLbaxdCQbYyyVfm5o";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Martin Fick <mfick@codeaurora.org>
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Lars Schneider
 <larsxschneider@gmail.com>, git <git@vger.kernel.org>,
 Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Message-ID: <4a18e167-8cec-0141-fe2c-4e0a35f16daf@linuxfoundation.org>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <1950199.Z2x8tXoTfI@mfick-lnx>
 <e8776c83-ea57-456d-5bc8-ca2fc990bed0@linuxfoundation.org>
 <2828274.Q9q2dc6g5t@mfick-lnx>
In-Reply-To: <2828274.Q9q2dc6g5t@mfick-lnx>

--PeIxoodKx8CVTVdFgLbaxdCQbYyyVfm5o
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 05/16/18 15:03, Martin Fick wrote:
>> I'm undecided about that. On the one hand this does create
>> lots of small files and inevitably causes (some)
>> performance degradation. On the other hand, I don't want
>> to keep useless objects in the pack, because that would
>> also cause performance degradation for people cloning the
>> "mother repo." If my assumptions on any of that are
>> incorrect, I'm happy to learn more.
> My suggestion is to use science, not logic or hearsay. :)=20
> i.e. test it!

I think the answer will be "it depends." In many of our cases the repos
that need those loose objects are rarely accessed -- usually because
they are forks with older data (hence why they need objects that are no
longer used by the mother repo). Therefore, performance impacts of
occasionally touching a handful of loose objects will be fairly
negligible. This is especially true on non-spinning media where seek
times are low anyway. Having slimmer packs for the mother repo would be
more beneficial in this case.

On the other hand, if the "child repo" is frequently used, then the
impact of needing a bunch of loose objects would be greater. For the
sake of simplicity, I think I'll leave things as they are -- it's
cheaper to fix this via reducing seek times than by applying complicated
logic trying to optimize on a per-repo basis.

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--PeIxoodKx8CVTVdFgLbaxdCQbYyyVfm5o--

--v0Rwi5o1CH3dN3gcOiIth0o1ZXL5suwuV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWvyCcwAKCRC2xBzjVmSZ
bE9lAQDI46ywhAZLAun1M+pqPvlvr1QxMqsojsLoK90+w/iPwAEA8UyvhjwXIFmU
fmQZxqP6nY/4rDz9x3le0bsl02DoNAM=
=oLRx
-----END PGP SIGNATURE-----

--v0Rwi5o1CH3dN3gcOiIth0o1ZXL5suwuV--
