Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B3ACA0FEC
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 16:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244939AbjIAQsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbjIAQsP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 12:48:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC8710E5
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 09:48:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 217DD1A3D18;
        Fri,  1 Sep 2023 12:48:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=EHfjCLqQlfVOcOLnx+Uah/LWRBmzUbkagCFxTo
        w8Qm8=; b=OtTLVanMKmOLx+JOxv5iCxNN+InZFGfVwv2YARbGH63D87yBe/FZeQ
        OfN7osswKvgP4O2jzkNRt1pow08yqEfg3WCSi3BMvvSm7ttBFNgvlCtMaEPtjTrd
        OZge/jht7v/gDngFmX6cp51XY/8OfIqKE0P6hARLNGJ0f1cP6YK8E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 196E41A3D17;
        Fri,  1 Sep 2023 12:48:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84B431A3D16;
        Fri,  1 Sep 2023 12:48:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Wesley Schwengle <wesleys@opperschaap.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] builtin/rebase.c: Emit warning when rebasing
 without a forkpoint
In-Reply-To: <4ee8802b-0b54-4ed3-8ead-61e7d7628bce@gmail.com> (Phillip Wood's
        message of "Fri, 1 Sep 2023 14:33:53 +0100")
References: <20230819203528.562156-1-wesleys@opperschaap.net>
        <20230819203528.562156-2-wesleys@opperschaap.net>
        <xmqqbkenszfa.fsf@gitster.g> <xmqq1qfiubg5.fsf@gitster.g>
        <4ee8802b-0b54-4ed3-8ead-61e7d7628bce@gmail.com>
Date:   Fri, 01 Sep 2023 09:48:10 -0700
Message-ID: <xmqq5y4trgad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 562E77FC-48E7-11EE-8483-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> It does seem strange, it looks like the variable was really added as a
> way to turn off the current default. If we do change the default to
> --no-fork-point when no upstream is given on the commandline then I
> think we should consider allowing "auto" for rebase.forkpoint with the
> some meaning as "true" and recommend that instead.

Perhaps.  The current and existing users do not need to change
anything and 'true' should keep working fine, but given that we are
discouraging the use of fork-point heuristics, it is not clear if it
makes sense to entice new users with a new 'auto' synonym, so, I
dunno

Thanks.
.
