Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60DB1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 05:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeKUPeG (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 10:34:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59355 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUPeF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 10:34:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5782910B2DD;
        Wed, 21 Nov 2018 00:01:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3IVDJfxniAztElI3pFxgC+30E+M=; b=U9ZLm+
        8jQZrzqg63nzZiXHuN6kgvTmbbo6JDV+GTTb5XQwfDPkOyGFA3gQmONVqSzS5oAL
        cmQXzt/l9EW+PHnyhOPhu/59rcTODRZdaqzuHOL8seKL2TNJfVlMG2Z0virT1rC0
        3V2RCn9KVKHpdNzqGx+MZmWDTCAYQdLPVF2+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=idNkgKM6H2jJzWQoSsT7QzrAmT2tpv2W
        TzzXTbqES62oH8BcXKg0yr22l1zdR7JoaA+r1s+Ro4KXoMl1JQ0CR1Ne8enp/XpS
        Y1zx4gX7PNbxg6adwBncgEFJAPe2ADGduMV2Hl5tZKQWc1q/889d8lsxQIjbuszv
        nvb/H5sGsc0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F98910B2DC;
        Wed, 21 Nov 2018 00:01:14 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C014810B2DB;
        Wed, 21 Nov 2018 00:01:13 -0500 (EST)
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
Date:   Wed, 21 Nov 2018 14:01:12 +0900
In-Reply-To: <20181121003912.GC149929@google.com> (Jonathan Nieder's message
        of "Tue, 20 Nov 2018 16:39:12 -0800")
Message-ID: <xmqq36rv81nr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 786497F0-ED4A-11E8-B6D7-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I don't *think* you intend to say "sure, you got user reports, but
> (those users are wrong | those users are not real | you are not
> interpreting those users correctly)", but that is what I am hearing.

What I have been saying is "we are sending a wrong message to those
users by not clearly saying 'optional' (i.e. it is OK for your Git
not to understand this optional bits of information---you do not
have to get alarmed immediately) and also not hinting where that
optional thing comes from (i.e. if users realized they come from the
future, the coalmine canary message will serve its purpose of
reminding them that a newer Git is not just available but has been
used already in their repository and help them to rectify the
situation sooner)".

As the deployed versions of Git will keep sending the wrong message,
I do not mind applying 1/5 and 2/5, given especially that Ben seems
to be OK with the plan.  I however do not think 3 thru 5 is ready
yet with this round---there were some discussions on phrasing in
this thread.
