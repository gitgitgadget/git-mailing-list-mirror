Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8B5C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 19:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiHJT6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 15:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiHJT6T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 15:58:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5C832DA
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 12:58:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7944813299A;
        Wed, 10 Aug 2022 15:58:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aU43j5p2RNABuMejJ78FaSQm3lZk62yDk2KiSY
        RpUMg=; b=EWyOcn0hhJZqJtw76PBw1cT4acLInfj57liThNYh1kZM9OQbIQ12UH
        y/umQMOKMtJLt5ikXO/Qt6TTCw9qjeV4lHWDmuzgIGCrRfwt3TZBcitDyIm5wK6H
        kZ10akEak+w6SpKK33Xxu81cot+ExfB2wXIFzN2f4zgbbsdp0Mnjg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70219132999;
        Wed, 10 Aug 2022 15:58:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D34A9132995;
        Wed, 10 Aug 2022 15:58:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script
 in C
References: <cover.1659291025.git.matheus.bernardino@usp.br>
        <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
        <xmqqr11zoe6i.fsf@gitster.g>
        <439p713r-32o4-5187-n8nn-r81n3007s4pp@tzk.qr>
        <xmqqtu6kkkr6.fsf@gitster.g>
Date:   Wed, 10 Aug 2022 12:58:16 -0700
In-Reply-To: <xmqqtu6kkkr6.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        10 Aug 2022 11:37:33 -0700")
Message-ID: <xmqq4jyjlvl3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C703F97A-18E6-11ED-A02F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Checkpatch is OK, but IIRC, you cannot ask to check "only the code I
> changed in this patch" to clang-format, which may be the show
> stopper.  Otherwise, I would quite welcome an automated "pre-flight"
> automation, like "make" target, that submitters can use and GGG can
> help them use.

Let me step a bit back.  I do not think any automated tool would be
free of false positives, so it is OK to configure the tool loose and
have "judgement case" still be dealt by human reviewer, but if the
automation is overly strict, that would probably waste submitters'
time too much.

You would need to accept that the new contributors are human and are
capable of learning and configuring editors on their end, and after
they get reminded of the style rules once or twice and they get used
to the process, they would also help coaching yet even newer
contributors.

I personally feel that the level of style issues that need to be
pointed out among the recent list traffic is not overly excessive.

Thanks.
