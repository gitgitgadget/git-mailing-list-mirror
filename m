Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C431EC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 17:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4D0D610F9
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 17:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJMRFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:05:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63349 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhJMRFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 13:05:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0382B153B7A;
        Wed, 13 Oct 2021 13:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I38mPTBkMCny+5jik5gRXqv5VNzrt+3pB+/pbM
        3MkuA=; b=nQxu8zLbkoUYTWDXdw9RdPuOJVM2lXENqaASFa6VOy0OO/p2vKKFB6
        FwWjIpgWnXp6ibrnwy4VahW/HwKUmJPwCO0UBHqwA1pSk5uswx6U2gMVC326zViu
        QvFec/y5pDW9zOUq8iLhCeHMFKtCCmovv6CdO5PJO0Y9jqalSEnD4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F103F153B79;
        Wed, 13 Oct 2021 13:03:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5EC16153B72;
        Wed, 13 Oct 2021 13:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ssh signing: clarify trustlevel usage in docs
References: <20211013075107.8584-1-fs@gigacodes.de>
        <20211013075107.8584-3-fs@gigacodes.de>
Date:   Wed, 13 Oct 2021 10:03:04 -0700
In-Reply-To: <20211013075107.8584-3-fs@gigacodes.de> (Fabian Stelzer's message
        of "Wed, 13 Oct 2021 09:51:07 +0200")
Message-ID: <xmqqfst4j1rr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EC0651E-2C47-11EC-B461-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

>  SSH has no concept of trust levels like gpg does. To be able to differentiate
>  between valid signatures and trusted signatures the trust level of a signature
>  verification is set to `fully` when the public key is present in the allowedSignersFile.
> -Therefore to only mark fully trusted keys as verified set gpg.minTrustLevel to `fully`.
> -Otherwise valid but untrusted signatures will still verify but show no principal
> -name of the signer.
> +Otherwise the trust level is `undefined` and git verify-commit/tag will fail.
>  +
>  This file can be set to a location outside of the repository and every developer
>  maintains their own trust store. A central repository server could generate this

Perfect.  Thanks.

Will queue.
