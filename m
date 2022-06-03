Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D4C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 20:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbiFCUuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiFCUuK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 16:50:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C90E326D4
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 13:50:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF98B19A059;
        Fri,  3 Jun 2022 16:50:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZUtHEzET2L2cdXCinAifdD49h+lCiz088f/Zti
        1g9vc=; b=FDxcrX6ZxUMIiF0flLIqVzMqmHkx0PkZs3kulEgB391ySOC8Dhfo3t
        0JQJdQy8bWoE1/ADk7f4xs0dvsSwVwNNVrEag/kgYDiZwlD4x/hJs6kAn+WCBPmA
        b/gRoaoHKzQwF1C6baflPvrulsnag9Yt4rFtzriBSFmyOZJ48810c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E810F19A058;
        Fri,  3 Jun 2022 16:50:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6947F19A053;
        Fri,  3 Jun 2022 16:50:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v3] git-prompt: make colourization consistent
References: <20220602145935.10512-1-joak-pet@online.no>
        <20220603142521.42863-1-joak-pet@online.no>
        <xmqqy1ydhfcc.fsf@gitster.g>
        <7d391d82-b15e-4a31-5207-c4037fec0bf9@online.no>
Date:   Fri, 03 Jun 2022 13:50:01 -0700
In-Reply-To: <7d391d82-b15e-4a31-5207-c4037fec0bf9@online.no> (Joakim
        Petersen's message of "Fri, 3 Jun 2022 19:23:25 +0200")
Message-ID: <xmqqh751eakm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD63FAD4-E37E-11EC-8B9C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joakim Petersen <joak-pet@online.no> writes:

> That does seem like a much better idea for maintainability, I can
> change the patch to do this instead. I have one question, though: the
> sequence $c$b (bare state and branch name) is a special case, where
> they're intended to have the same colour, should I wrap both in colour
> set, colour clear, or only clear after $b?

If we want to allow $c and $b appear in different places (which I
have no opinion on), I would say we should just color them
independently and fix the test that expects the close linkage
between the two.  I offhand see no reason that they _must_ stay
together myself, though.

Thanks.

