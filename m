Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA459C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD2A22B43
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgLUTaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:30:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61486 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgLUTaU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:30:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EF0098DDC;
        Mon, 21 Dec 2020 14:29:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wCs0wkK7qTWtlDNXX/9hofEXqSY=; b=WjxOgw
        wOiHj4vmj4tDv6A4oxgSwdj/ggzLqfJovNj3jlXsanMjyNd4NrEAoTzWzQDpfdo+
        PuIJePbHw9xoPkViPvk5S48nvJVFg82CvNhrHYIzJX+97h848xlCtJCWG8edukcd
        I9K6+SmeiAZUHkQWJxcGKUUYc7/Y4qEIHRJMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eG58NTcpJyxnmPn9bdbNFj50vpuRc4Bv
        168h7nA/bp4g8eE0lJTZmXj/xu1w97KxnGmeXVYza1zOiR5NagrprHe1pYC2616L
        zFuScNIDMrmwcMydOVRCuTc9X2Wbpr80HYcfhqQO2jm7afWPeVHwQG1LmTZyMT0z
        iB4kb8rJdWM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 367FC98DDB;
        Mon, 21 Dec 2020 14:29:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9EBF98DD9;
        Mon, 21 Dec 2020 14:29:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Re* [PATCH] diff: suppress --name-only paths where all hunks
 are ignored
References: <xmqqeejsdv7x.fsf@gitster.c.googlers.com>
        <20201216231840.3163806-1-aclopte@gmail.com>
        <20201216231840.3163806-2-aclopte@gmail.com>
        <xmqq4kkl1atq.fsf@gitster.c.googlers.com>
        <20201220223435.tmo5ty5tzwu7et4d@gmail.com>
Date:   Mon, 21 Dec 2020 11:29:38 -0800
In-Reply-To: <20201220223435.tmo5ty5tzwu7et4d@gmail.com> (Johannes
        Altmanninger's message of "Sun, 20 Dec 2020 23:34:35 +0100")
Message-ID: <xmqq1rfjlzz1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDBCFDB0-43C2-11EB-AC7D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

>> +test_expect_success '-w and --exit-code interact sensibly' '
>
> Maybe 'exit with 0 when all changes are ignored by -w' though either version
> is fine because I think the intention of the test is already obvious.

Yeah, 'sensibly' is a zero-bit phrase and the letters are better
spent on describing what we deem sensible more clearly.  Thanks.
