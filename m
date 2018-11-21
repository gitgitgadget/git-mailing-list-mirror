Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213A81F97E
	for <e@80x24.org>; Wed, 21 Nov 2018 04:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeKUOz6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 09:55:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52171 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUOz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 09:55:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9AE4519388;
        Tue, 20 Nov 2018 23:23:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9CaHu8Qzw4Zvg9g0iguqbTzXEz4=; b=sEX/9e
        gDg+90k5GN7HWA4KA60riKOnRFlIblciaKAKcRGHIEfLwIBjmvAKcrH57FcmmcqF
        1VMsYzsNVcvzP2Hcl0W6zL/v9+aN+SpMDW59crNLJbScQBakgTn0zycUBKNdbI2f
        wQWz7zSWWmFpRPXnvcNPTJMkrrSrImyTCOPBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X0lu7uMjWgEHecTe1DU20NbbtuH0OVD+
        iPLwwc96lZxg+m2DmcJvgwkxS5G5q2Y9cLtvHhxp4CikI3pFlq7SbWtcxb5yrB+i
        e4SuWyLvRmqy+RIiv4S3uRf2pXFazYZUtRWji+Uf5VM9roQDpOpkv5QaxFXeN9r5
        HJqgESsTuPI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9256319387;
        Tue, 20 Nov 2018 23:23:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A2F4619386;
        Tue, 20 Nov 2018 23:23:09 -0500 (EST)
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
        <20181121010309.GE149929@google.com>
Date:   Wed, 21 Nov 2018 13:23:06 +0900
In-Reply-To: <20181121010309.GE149929@google.com> (Jonathan Nieder's message
        of "Tue, 20 Nov 2018 17:03:09 -0800")
Message-ID: <xmqqpnuz83f9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26F3C1C0-ED45-11E8-A2FD-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Now, a meta point.  Throughout this discussion, I have been hoping for
> some acknowledgement of the problem --- e.g. an "I am sympathetic to
> what you are trying to do, but <X>".  I wasn't able to find that, and
> that is part of what contributed to the feeling of not being heard.

I had little sympathy for what you were trying to do, i.e. killing
the coalmine canary that warns users about using older version of
Git when there clearly is a sign that a newer one is available to
them and they have already used it; there was no problem to be
acknowledged.

Not before "why is it different this time?" question gets answered
anyway.

And seeing the same "let's not enable the new extension" patch again
without much improved justification contributed greatly to the
feeling of not being heard.  The feeling is mutual.

