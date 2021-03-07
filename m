Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53198C433E0
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 23:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2542064FE9
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 23:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhCGXEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 18:04:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56525 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhCGXER (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 18:04:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 093C398CFA;
        Sun,  7 Mar 2021 18:04:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=60ELcEfMNjC3
        dtc/Eq4YkMG/R5g=; b=BGLhxmEifJd1rx5AbMZAfyGAG9rnaDKEG0k0T2iDcJh/
        k4oa9R1Fdbmrbhp5qSPidMzJhR3tj1BZ3+7kLvzGf5InnIH2zg2pN3C+PcfiUx2Q
        Q2jDg0iF3wmHlJkWWQ0RpH45t2A0RCLfRqfqkdeoFCcITcyeL4zTiORmKUZ21go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xYkwMx
        j99gNWZKYd4b8O0apHmVqWNV+AwJsTxuQ3RxF7FXnx2fvVteEmfE5zP1qpyKBEty
        PXsTNUgrktft8uQHyz//MX3XsECEwACIvijo7rz5L359OrAvUVdgFokheQAfmcr6
        fPmTWbRJNMRkgcxdqyv8kBLvzFKG3qk+MbQ5k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3A7B98CF9;
        Sun,  7 Mar 2021 18:04:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7886898CF8;
        Sun,  7 Mar 2021 18:04:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 00/22] fsck: API improvements
References: <20210218105840.11989-1-avarab@gmail.com>
        <20210306110439.27694-1-avarab@gmail.com>
Date:   Sun, 07 Mar 2021 15:04:14 -0800
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 6 Mar 2021 12:04:17 +0100")
Message-ID: <xmqqtupm7ehd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 70431838-7F99-11EB-A602-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Now that jt/transfer-fsck-across-packs has been merged to master
> here's a re-roll of v1[1]+v2[2] of this series.

It unfortunately is not a good time to review or helping any work on
this series, as the base topic introduced an unpleasant regression
and needs to either probably gain a band-aid (or reverted in the
worst case); of course, it would be appreciated to help resolve the
issues on that topic ;-)

Thanks.
