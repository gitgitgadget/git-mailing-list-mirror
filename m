Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627B61F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 05:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeKUPsg (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 10:48:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61264 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKUPsg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 10:48:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C74C3327B9;
        Wed, 21 Nov 2018 00:15:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vijxVC45m+XUMew25p0dItJrRd4=; b=JsKBK5
        pnO6b3Ku85u3lvQtIR45xE1TuhmyrHgGs3N+fZSprfFupv4eSM7ux+/c7IoaiYBJ
        F2s5gBf9eYdykcFkhjaJFale9a8WI3HMUTWySfv/WL9+mHVKU+y2pjT/Gb8UEAjv
        T8nzNVQ400BXBHDkoU+D1D05SDFzvW+BK4ou8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BVySDW05V+yBpK0G7sEzBEik3/L0TGMj
        EPVI2LXp/YNP9w5uDT1JoOnzVY8xCH3zh+sRQ3Pj2GAPvGIC4EVMWu/afQLvtLqX
        T3yWBbJvUkTLgOJlN6P7Cu3szOsmKxOfbe7ystRLd5nSS2P3LX3XwUFX/q8664fx
        WtTi+A63M+g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BEE7C327B8;
        Wed, 21 Nov 2018 00:15:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D19FE327B7;
        Wed, 21 Nov 2018 00:15:37 -0500 (EST)
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
Date:   Wed, 21 Nov 2018 14:15:35 +0900
In-Reply-To: <xmqq36rv81nr.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 21 Nov 2018 14:01:12 +0900")
Message-ID: <xmqqtvkb6mfc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B6BF2AC-ED4C-11E8-99F1-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As the deployed versions of Git will keep sending the wrong message,
> I do not mind applying 1/5 and 2/5, given especially that Ben seems
> to be OK with the plan.  I however do not think 3 thru 5 is ready
> yet with this round---there were some discussions on phrasing in
> this thread.

I ran out of time looking at the surrounding code, but I think 1, 2
and 4 form a set that would give us immediate benefit to fast track
to the upcoming release.

I do not know if it makes sense to have 3 and 5 separate; I suspect
a single patch that does "clarify the warning, and allow those who
have no choice in which version of Git to choose squelch it" would
suffice.

The phrasing in 5 received a couple of good concrete suggestions
already, so it is not ready in its current form but need a bit of
wordsmithing.  I also do not think a new "trace_printf" would
particularly help.  If I stared it a lot longer, I may spot more
issues in it.

But what that step does primarily would help long after the upcoming
release and in that sense can wait a bit longer than 1, 2 & 4 (which
I am hoping can be merged in -rc1).
