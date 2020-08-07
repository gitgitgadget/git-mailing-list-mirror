Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E2C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799AA204EA
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="roNiMSBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHGUuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:50:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59605 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGUuW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 16:50:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94A3087AE2;
        Fri,  7 Aug 2020 16:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6DCmGn7NQKLv
        pXTBLjRCKaCtY3w=; b=roNiMSBM5UFIG5SV+tfq24uj8TYgNA5E1P+xpSzOidJh
        utiUSdjjIRtnat0UrBtdwBZUjdEZC2qT2tIZPFvVGkmF2PbBLNn2yL5gwQuQIKd7
        k5H+TekcaqQ35HHyz44dKIKUPRw3aNdx5VGob9n23bPuFxPw/pgJ/qC4d9z3exA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yafqJ4
        g9/jQX2BWq2sVJfd+mM0vu18oeVM5zIIQ5eFpqyn70h6UJIZd9v1iCEcVkgSlhF0
        I0ETHZXnAcGr0KqWFEv38jwHiWIwjRE/pV4Vl2X6U0sStq36Fy1tkR50PKDhtHIp
        wEGfZWQQiZBKGLErpXwGGyagKLpCZbBp749kw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C1EC87AE1;
        Fri,  7 Aug 2020 16:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EC3387AE0;
        Fri,  7 Aug 2020 16:50:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation: mark `--object-format=sha256` as experimental
References: <20200806202358.2265705-1-martin.agren@gmail.com>
        <20200806230837.GA8085@camp.crustytoothpaste.net>
        <CAN0heSptiJL9d86ZeNPMUaZeTA68juwTyf3K-uWR=K-vt=1Hrg@mail.gmail.com>
Date:   Fri, 07 Aug 2020 13:50:17 -0700
In-Reply-To: <CAN0heSptiJL9d86ZeNPMUaZeTA68juwTyf3K-uWR=K-vt=1Hrg@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 7 Aug 2020 16:08:10
 +0200")
Message-ID: <xmqqr1sifaeu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9A0B61DA-D8EF-11EA-B41D-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> I'm fine with marking the functionality experimental for a few release=
s,
>> since it is possible we have bugs people haven't found, and adding a
>> note about interoperability after that point, since I think that's a
>> fair and valuable issue.  I think if we go a few releases without any
>> major issues, we can change this to the following:
>>
>>   Note that a SHA-256 repository cannot yet share work with "regular"
>>   SHA-1 repositories.  Many tools do not yet understand SHA-256
>>   repositories, so users may wish to take this into account when
>>   creating new repositories.
>
> With respect, I think that's too aggressive. By that time, we may
> conclude that, e.g., the "v2 pack indices with SHA-256" file handling i=
s
> robust. But I'd be surprised if using `git init --object-format=3Dsha25=
6`
> in June 2021 won't cause *some* extra work for users or ourselves
> further down the line compared to using a regular SHA-1 `git init`.
> Pushing to a SHA-1 hosting service will become *possible* at some point=
,
> but maybe it won't be *efficient enough to be practical in the real
> world* until some time after that.

IOW, you question "if we go a few releases without any major issues"
part?  I tend to agree that for a large change like this, a few
releases may not be sufficiently long time for a feature that is
marked as experimental in big flashing red letters to get exercised
enough to get major issues noticed.

> All those other, *new* file formats outlined in the hash
> transition document won't exist at that time (at least not in master).
>
> Now would probably be a good time to update the hash transition
> documents, first of all to tick off what we've already done, and second=
,
> to reassess the rest.

Yes, it is a good idea to stop and see where in the overall large
picture we currently are.

Thanks.
