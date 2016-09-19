Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590232070F
	for <e@80x24.org>; Mon, 19 Sep 2016 17:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbcISRtW (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 13:49:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56811 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752802AbcISRtV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 13:49:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C3B43F167;
        Mon, 19 Sep 2016 13:49:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v3T83lqXbR2cGoGlvVJTU1cIboM=; b=PThgev
        ZA/dbPLuW6M6+D3D1Row1apLbJfQZuktR0N7mJjPfRtHSrzOFgv/RudQAZOIbgaS
        oEGirn0YUrOIwpLw5scevxDjNw9jUGgZm7aLWKnvSC5ZpPQ2w4xuTkRbEx6CL+z3
        7WyNM4YHYgd4TW299ezf/KAI4D0E/2xCVGqI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e6DeyNzDOu2m+wCjBwmPGR4kpnLJudRj
        E6dQXYM8yT+PcZl3BB+c54Vy/LZgEcBxMxHv4daANPgvjiWNWBR3AoJGdrdhSDeQ
        cBeF0QAiYCQHZ/3E5hFKkjMmy/pA+XBH5IgPAXFyR5jEF49GtNGi1zYvVLaa59iC
        CjbolW64UVU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23B193F166;
        Mon, 19 Sep 2016 13:49:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E7B03F165;
        Mon, 19 Sep 2016 13:49:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] format-patch: Add --rfc for the common case of [RFC PATCH]
References: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
        <3df15bbb-7eac-86ec-2ccb-74a973482e8c@au1.ibm.com>
Date:   Mon, 19 Sep 2016 10:49:17 -0700
In-Reply-To: <3df15bbb-7eac-86ec-2ccb-74a973482e8c@au1.ibm.com> (Andrew
        Donnellan's message of "Mon, 19 Sep 2016 19:17:28 +1000")
Message-ID: <xmqqa8f3g4pu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6421083E-7E91-11E6-A8B5-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> Sounds good to me. Agreed that "RFC" is essentially the only prefix
> other than "PATCH" that I see, at least in the kernel.

Around here I think we saw WIP too, and that makes me lean towards
Peff's earlier suggestion to allow an end-user supplied string in
front of PATCH, i.e. "-P RFC" => "--subject-prefix='RFC PATCH'",
even though I understand that those who _ONLY_ care about RFC would
prefer --rfc (5 keystrokes) over "-P RFC" (6 keystrokes).

>> +--rfc::
>> +	Alias for `--subject-prefix="RFC PATCH"`. Use this when
>> +	sending an experimental patch for discussion rather than
>> +	application.
>
> Perhaps mention the phrase "Request For Comment" for the benefit of
> those who aren't familiar ...

Good point.
