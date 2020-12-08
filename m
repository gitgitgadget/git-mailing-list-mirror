Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EEEC2BB48
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B74222B3
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgLHWEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56034 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730608AbgLHWEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFF5895D90;
        Tue,  8 Dec 2020 17:03:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TO2uGbvmy148PH62K06OSQnCNfs=; b=uCJ5Mc
        KfBNwzWBEt1srSdoqJ75ugNJP4nrZkRLlmhxjKfj5RqtYiju7D48YnRJ4b5L3Bm1
        AtKQT/cQdG2kuYC2fYo2bTk0aom1RqlcJbmxIJ/qiBHxOm+fSorRyUoG1S0q+9Y4
        Q/ITp7hYvbBsggD8XFJXz/Adu72514da84YsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s9MMxCazIfqnvnrOF+7lRYj5FZdYDqqE
        b4hfu7CHFDr2UqtKqEp5U9OrZmfi2tBnbrn4jLSzN4DnxSfIimLUkztfjncT13Vx
        UmP1Jdin5CLyNJfDg5DNsRWVeRoHxVrFACG0sh+2XbwBEufKcWuwysnzCaQAHn1W
        g2eWgAWVevs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C736D95D8F;
        Tue,  8 Dec 2020 17:03:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C5C095D8D;
        Tue,  8 Dec 2020 17:03:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        dstolee@microsoft.com
Subject: Re: [PATCH v3 00/24] pack-bitmap: bitmap generation improvements
References: <cover.1605123652.git.me@ttaylorr.com>
        <cover.1607385833.git.me@ttaylorr.com>
        <xmqqmtyo6mqi.fsf@gitster.c.googlers.com>
        <X8/qG70Wgd7xInq+@nand.local>
Date:   Tue, 08 Dec 2020 14:03:49 -0800
In-Reply-To: <X8/qG70Wgd7xInq+@nand.local> (Taylor Blau's message of "Tue, 8
        Dec 2020 16:03:23 -0500")
Message-ID: <xmqqo8j45516.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40B8931A-39A1-11EB-BB0F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> That seems reasonable. Another approach would be to leave these patches
> untouched and apply Dscho's fixup on the end, but I'm not sure which
> you'd prefer.

I'd prefer not to see known breakages that are found before the
topic is not yet in 'next' left in the topic, and fix them at the
source before the topic gets merged.

