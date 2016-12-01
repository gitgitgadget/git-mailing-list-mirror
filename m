Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BCF91FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 23:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760594AbcLAXet (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 18:34:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65148 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755050AbcLAXes (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 18:34:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDDC1544BC;
        Thu,  1 Dec 2016 18:34:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MastQhW1xKmEP4eUbGbmkdoau/Y=; b=FkdDeE
        8Sdplm4ZmqKj1S/1v/XjwBWYUOqOEg6sbKkV7I/oTbmFM+Ecw2cg0hRKyXwPEsGJ
        nJHZ6H0QKhcgOB3lwTSzkhbao/piFnmowrSjA64WdVtbZcbMVCCszCx7VjXSjQln
        A14QyghdmuOwZpl5fExJVxXj7eqxznouW8TCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OpB83wlhyC/kTEr2IxeDDxuux8uOnnEG
        Yw9hC8/X4yPcc1/2K108pYd/K6wZi3d4UbszXtOVI5JU7NCES+BLfIuanMExtxCc
        o7oi2eQIaeQF4XyzYfuOi6lzFrsa2gj3x625AGHoGUfd+uwuJ661q4tUOBUSD0CG
        lrF57duTeHk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4802544BB;
        Thu,  1 Dec 2016 18:34:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C575544B8;
        Thu,  1 Dec 2016 18:34:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, sbeller@google.com,
        bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to is_transport_allowed
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
        <1480623959-126129-1-git-send-email-bmwill@google.com>
        <1480623959-126129-5-git-send-email-bmwill@google.com>
        <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
        <20161201230738.GJ54082@google.com>
Date:   Thu, 01 Dec 2016 15:34:44 -0800
In-Reply-To: <20161201230738.GJ54082@google.com> (Brandon Williams's message
        of "Thu, 1 Dec 2016 15:07:38 -0800")
Message-ID: <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE390D50-B81E-11E6-91C4-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> I started taking a look at your http redirect series (I really should
> have taking a look at it sooner) and I see exactly what you're talking
> about.  We can easily move this logic into a function to make it easier
> to generate the two whitelists.

OK.  With both of them queued, t5812 seems to barf, just FYI; I'll
expect that a future reroll would make things better.

Thanks.

