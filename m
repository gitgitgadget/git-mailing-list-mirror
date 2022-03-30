Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D8EC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 21:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351420AbiC3Vyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 17:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344614AbiC3Vyx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 17:54:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1C96A40D
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 14:53:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC7EB17CB2C;
        Wed, 30 Mar 2022 17:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hkUQUbfAKZRGlVQ6EjopHZuDV7txekyQ4NoBOY
        5khKs=; b=wK+UvHKPtuzC9/hJpIdSGVyC1Ov0W1nKREtszfY9bXC1rNMv07Nd4a
        YkqomRySkK7gTFumR/8ZVCcSfd6GV8H0uUKBTJuUKtqQuyXCTeqhBVlJAeCBUWgX
        kC2LpFQs/wkIKdm+8vzIiITlpG4QcdeD+QMYM5xeT20H1XomKeLDQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C3CE917CB2A;
        Wed, 30 Mar 2022 17:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1327617CB29;
        Wed, 30 Mar 2022 17:53:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Garrit Franke <garrit@slashdev.space>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] cli: add -v and -h shorthands
References: <20220330190956.21447-1-garrit@slashdev.space>
Date:   Wed, 30 Mar 2022 14:53:03 -0700
In-Reply-To: <20220330190956.21447-1-garrit@slashdev.space> (Garrit Franke's
        message of "Wed, 30 Mar 2022 21:09:56 +0200")
Message-ID: <xmqq5ynv6rb4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6938216-B073-11EC-A8F4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garrit Franke <garrit@slashdev.space> writes:

> Change the behavior of "git -v" to be synonymous with "--version" /
> "version", and "git -h" to be synonymous with "--help", but not "help".
>
> These shorthands both display the "unknown option" message. Following
> this change, "-v" displays the version, and "-h" displays the help text
> of the "git" command.

Sorry, but it is unclear why it is a good thing.

> It should be noted that the "-v" shorthand could be misinterpreted by
> the user to mean "verbose" instead of "version", since some sub-commands
> make use of it in this context. The top-level "git" command does not
> have a "verbose" flag, so it's safe to introduce this shorthand
> unambiguously.

Again, it might be safe right now, but it also closes the door for
introducing global "verbose" option.  What in exchange are we
gaining?  Are these short options worth it?

I am not convinced.

