Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C373A1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 05:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeKUQEF (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 11:04:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54983 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeKUQEF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 11:04:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D07E199CD;
        Wed, 21 Nov 2018 00:31:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qcrFqsSAsFiWqHlC3vOHSbwZw24=; b=s5qY4+
        bI5aenjOXp2l5oSP18Hw8RVXJ+GYHkX2Me9yngEH97JwnsCHmTB9uHuaR+sma/wd
        90LOAiBx1NtUap1uMnosJr6vkF9vqneL6+GC2T+RUEp++ExqG8jVwQvQNjOGYYRo
        4f5cpgqpI7Q5I0IDk0LPpv6epZNzZzltL8N4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xBK0xuHhLd/4rqvNJOCTx1P3QC/gGbMQ
        FzvatrtHeunXC9xwiJ9fMreOjIXGFqIRktrtelz9+hVGz+NIrP4/Z4W4iSXdWz0T
        r8/TBuUjr4qztNpY58FOkXLhvSFlNVH241G1OuxmOMTwtgZhZJnnlkvh5cryPe/5
        +hB8dVdO4GY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6542D199CC;
        Wed, 21 Nov 2018 00:31:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 79DFB199CB;
        Wed, 21 Nov 2018 00:31:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com
Subject: Re: [PATCH 5/5] index: offer advice for unknown index extensions
References: <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113003938.GC170017@google.com>
        <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
        <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
        <20181120060920.GA144753@google.com>
        <20181120061544.GF144753@google.com>
        <87sgzwyu94.fsf@evledraar.gmail.com>
        <cabd2e37-7389-ac74-6626-629eab7da53f@gmail.com>
        <xmqqefbf9t4j.fsf@gitster-ct.c.googlers.com>
        <20181121003912.GC149929@google.com>
        <xmqq36rv81nr.fsf@gitster-ct.c.googlers.com>
        <xmqqtvkb6mfc.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 21 Nov 2018 14:31:01 +0900
In-Reply-To: <xmqqtvkb6mfc.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 21 Nov 2018 14:15:35 +0900")
Message-ID: <xmqqpnuz6lpm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A324ED9C-ED4E-11E8-B75E-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not know if it makes sense to have 3 and 5 separate; I suspect
> a single patch that does "clarify the warning, and allow those who
> have no choice in which version of Git to choose squelch it" would
> suffice.

I actually do not mind two patches for these, but I think the
separation presented in the series is wrong (first to kill the
canary completely, and then add it as if it were a completely
separate advice).  

It would make more sense, at least to me, if 

 - the earlier step is to clarify the warning on two points
   (i.e. this is safe to ignore, but you may want to know that you
   are using a stale Git when we see evidence that a newer one has
   already been used here) and then

 - the later step is to optionally make it possible to squelch it
   for those who do not have control over what version of Git they
   are allowed to run.

But again, a single patch to do all of that is also fine.
