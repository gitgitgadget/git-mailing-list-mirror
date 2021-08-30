Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECDDC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA9860698
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbhH3R5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:57:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60909 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbhH3R5L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:57:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB011E56FC;
        Mon, 30 Aug 2021 13:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z4MhhgObFTlh+ymgDY3JtBl8T9/Id+dMgorVRt
        ra2iQ=; b=gCpy7w9PkyiDPDa2EAE/KN9gOgOndbE0d0hJF6Q+gmUNwqtYPc8kAa
        HSJhSd1U2UvMuY4bhHXVDplZS36oxizLzXGjLci9cR7kgnoqwXdo8TwXb1nXLc4e
        6mNhwEpMS6UrpTggFl2LURVfcP67h/QhFaFqKVoOUmTIbnCzF6Ym0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3970E56FB;
        Mon, 30 Aug 2021 13:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 447AAE56FA;
        Mon, 30 Aug 2021 13:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
References: <20210830072118.91921-1-sunshine@sunshineco.com>
        <20210830072118.91921-4-sunshine@sunshineco.com>
        <xmqqwno2505w.fsf@gitster.g>
        <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
Date:   Mon, 30 Aug 2021 10:56:16 -0700
In-Reply-To: <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 30 Aug 2021 13:41:03 -0400")
Message-ID: <xmqqeeaa4y0v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9317328E-09BB-11EC-8ADC-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The trailing whitespace is unusual within the Git sphere, as well as
> unsightly if you happen to have your editor configured to highlight
> trailing whitespace, and just "feels" sloppy.

But we are discussing this in the context of format-patch output,
where patches that change lines near a blank line will have a line
with a single SP on it in common context ;-)

I do not feel very strongly either way, though.

> [1]: I suppose mechanical extraction of notes may be one such
> scenario, allowing for simple-minded (not necessarily robust)
> extraction mechanics; i.e. start extracting after the /^Notes:$/ line
> and stop at the first line not indented with four blanks.

Yup, that was what I had in mind.
