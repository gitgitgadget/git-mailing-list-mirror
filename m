Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9C4C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8A4207A9
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 13:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbhA0NVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 08:21:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56333 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S313587AbhAZWiD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 17:38:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C38F116A7F;
        Tue, 26 Jan 2021 17:37:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q1vuiL4o4NN0D1TjxL8R/zB9Dgw=; b=fIN+N1
        kGCTv7T1DmOhaQIERtczdb/+EB/9zbcng0m5MabiJIRk25DJX5drE2gNqQbK9XKm
        G/K1M/SFpL7fyF2AMxH/Bh7drllSMAdoZmSD0VGGjKBQVZNoXljbUf8hL0UFUVfz
        rJUR0o9FQ8nwFhHH8ZG0Pd4yvNTck7ZC6+39I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z5sVXI4eehLU8iv5wUTnT8cDzYx1wJXs
        CaZq0OtfPeLqYEoFZZPowlws23obsV0qSVbeD2xoNUB8vot/epcVdovXHPUe6DBZ
        C9lT+mPlWAntLwxLB+8fgscL+wkeHv48/iYKoURWTyizS3DUqaoxedLb5r5eY42E
        KX3ja4aVivU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53C6B116A7E;
        Tue, 26 Jan 2021 17:37:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9A0FA116A7D;
        Tue, 26 Jan 2021 17:37:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/17] Refactor chunk-format into an API
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 14:37:18 -0800
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Tue, 26 Jan 2021 16:01:09 +0000")
Message-ID: <xmqqr1m7z5nl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D34785E-6027-11EB-8C41-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is a restart on the topic previously submitted [1] but dropped because
> ak/corrected-commit-date was still in progress. This version is based on
> that branch.

Nice to see that we have an endorsement on ak/corrected-commit-date
topic ;-)

I've scanned this round of the topic and they were pleasant read.

I may have other comments after a more careful reading, but so far,
I am happy with what I see here.

Thanks.
