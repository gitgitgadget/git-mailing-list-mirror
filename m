Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB101F437
	for <e@80x24.org>; Fri, 27 Jan 2017 20:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbdA0UoK (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 15:44:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57976 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751189AbdA0Um7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 15:42:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E97A563014;
        Fri, 27 Jan 2017 15:42:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w5UHmK4fI9pHQ8OMNIJvZ3L9Wyk=; b=BizLdT
        S4oWN6NcJksHFI9Xmse8xiqgwBdUVM7wa7CfF0pDp0/mxPi1MW3t3HizTxSfcL5m
        l2npnmkZj25AjVsJYsIkbmJObUW7BkyJ9zI0Td0HKS/MQzMehSDzLFVkrSnygJoC
        XQdtayk8ftq8s9MrtMLWNU0vClF7c5pFeaD0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HTjII5cbZKz4JEfSaEUrExLDixRtkWvO
        JhFs24lfo0fWBQ+EPnhW4bP64PsLo9fu5b5tYnRoHXxnphT6yGtmV5+O0Eg5MGpv
        c+S8OlL7bc6lVekLwSXsBfxBjTVE0b6GUQVHbkcloc1ZzdXPVIsxzYu5UJ46GhVw
        nZQJTJP5Ulo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E27E363011;
        Fri, 27 Jan 2017 15:42:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B1536300D;
        Fri, 27 Jan 2017 15:42:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org
Subject: Re: [PATCH 11/12] receive-pack: treat namespace .have lines like alternates
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
        <20170124004805.nu3w47isrb4bxgi5@sigill.intra.peff.net>
        <xmqqa8aec40a.fsf@gitster.mtv.corp.google.com>
        <148553912610.7898.1319453517642036857@typhoon>
        <20170127175807.4tjxpenu2gk77dhv@sigill.intra.peff.net>
Date:   Fri, 27 Jan 2017 12:42:52 -0800
In-Reply-To: <20170127175807.4tjxpenu2gk77dhv@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 27 Jan 2017 12:58:07 -0500")
Message-ID: <xmqqziicxmib.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CDB40BE-E4D1-11E6-8A78-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jan 27, 2017 at 06:45:26PM +0100, Lukas Fleischer wrote:
>
>> I think this is already possible using receive.hideRefs (which causes
>> the ref_is_hidden() branch above to return if applicable).
>> ...
>
> Thanks for the pointers. I think a "turn off namespace .have lines"
> option would be easier for some cases, but what you've implemented is
> much more flexible. So if people using namespaces are happy with it, I
> don't see any need to add another way to do the same thing.

Yeah, I agree.  Thanks, both.
