Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148D7C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 17:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D177360EB2
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 17:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhHNRAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 13:00:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50505 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhHNRAm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 13:00:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 097B214D4F9;
        Sat, 14 Aug 2021 13:00:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S2WeRNkUY5yu
        eN2JH0kMM5se11ZabMId1IET7ltG+8Y=; b=rFMGZIpKZbL/1sCbboTr0UHyO0g4
        QvUr8jjP+ygvO0pbqMPuSmoHhotjikec/PzWWJqppgGNYVWtZ0TWB3gLsch4CBnc
        aPnTYUxDCscAOOK7xFn66m/scQf7K7BBjHNqLGIKmkAf7pMSknWXCvoUFeiMxMu/
        vzBTwXAupDyAu0s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0254E14D4F6;
        Sat, 14 Aug 2021 13:00:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE6D414D4E7;
        Sat, 14 Aug 2021 13:00:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.33.0-rc2
References: <xmqqo8a37eim.fsf@gitster.g>
        <CAN0heSrPXdpPXTpY3Cdn-HHcuzLvc--Y_L+SgK-QGt5yS8u54w@mail.gmail.com>
Date:   Sat, 14 Aug 2021 10:00:08 -0700
In-Reply-To: <CAN0heSrPXdpPXTpY3Cdn-HHcuzLvc--Y_L+SgK-QGt5yS8u54w@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sat, 14 Aug 2021 10:01:49
 +0200")
Message-ID: <xmqq5yw8ufl3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 15EDD0D4-FD21-11EB-885C-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On Thu, 12 Aug 2021 at 01:23, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Git 2.33 Release Notes (draft)
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> rc1 had a section "Backward compatibility notes" where the recent work
> on "git log -m" was mentioned. That was then dropped because of
> 6a38e33331 ("Revert 'diff-merges: let "-m" imply "-p"'", 2021-08-05), s=
o
> there are no backward compatibility notes in rc2.
>
>> Updates since Git 2.32
>> ----------------------
>>
>> UI, Workflows & Features
>
>>  * The "-m" option in "git log -m" that does not specify which format,
>>    if any, of diff is desired did not have any visible effect; it now
>>    implies some form of diff (by default "--patch") is produced.
>
> This is basically the same blurb. It was duplicated in rc1, and one of
> the copies remains in rc2. I believe it should be dropped.

It indeed is now stale and needs to be adjusted.

Thanks for your sharp eyes.

