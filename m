Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B65AC2BB1D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCF3206E9
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FMFGULAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgCKSft (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:35:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53849 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbgCKSft (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 14:35:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55108BCBC2;
        Wed, 11 Mar 2020 14:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yxm2liXGlPUaWTCbYRxCgoy3e8A=; b=FMFGUL
        AG6Pg3/6ory0XQOJWAlVgEcK1lKnwYmQFTk/10+WHATmHllAk57+WEgdeQPDmXR6
        qNofSiQ0YSc3ILIrYz37EhmpX02wd5nc+LfgMh9HNoY8MVo6tsE3+PswT12UsrvF
        nPnb2iCDqQ4zw3U2d34tsbeSmxd+LziKKZeq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=poE+XYEkKnezbi/wUiHtzlM3g3UJtU3K
        O4JH/JT3f89e09Bzc3YDfrsD/NdCVazZ5zTq573PegseQEOFDSpXc84QWuAM8UDS
        MUhu+VnCW4uJ2PiuWu6mh6392K9pL/GVy7jUG5dyCaJDOuwlspO+ma1JZM/mxaZh
        gQDnSoGPb5w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EF51BCBC1;
        Wed, 11 Mar 2020 14:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95C3ABCBC0;
        Wed, 11 Mar 2020 14:35:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     =?utf-8?Q?J=C3=B6rn?= Engel <joern@purestorage.com>,
        git@vger.kernel.org
Subject: Re: new file mode 160000
References: <20200310184111.GD1443@cork> <87lfo8m3fu.fsf@igel.home>
        <xmqqo8t4hu0n.fsf@gitster.c.googlers.com> <87h7ywm0p2.fsf@igel.home>
Date:   Wed, 11 Mar 2020 11:35:44 -0700
In-Reply-To: <87h7ywm0p2.fsf@igel.home> (Andreas Schwab's message of "Tue, 10
        Mar 2020 21:09:29 +0100")
Message-ID: <xmqq1rpyivsv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F7F449C-63C7-11EA-A5D3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

>>> 0160000 is S_IFLNK in MiNT
>>> <https://github.com/freemint/freemint/blob/master/sys/mint/stat.h>.
>>
>> Yeek.  That sounds like a ticking time-bomb.
>
> configure can detect that (NEEDS_MODE_TRANSLATION).

Thanks--I totally forgot about that one.
