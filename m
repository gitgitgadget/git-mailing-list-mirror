Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D262095B
	for <e@80x24.org>; Mon, 20 Mar 2017 15:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754403AbdCTP4C (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 11:56:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61427 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754365AbdCTPzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 11:55:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C9277C32C;
        Mon, 20 Mar 2017 11:55:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R/T+T5R01P9+HSv2XBUXCJ4dhiE=; b=Js+c/S
        sV6e9WmyntW++twz+S1XZy28IeVRP/AD5QWdkpLn6XpRq1pztzXPS8HK8prCdzF8
        FiHz4oiXv6Uh1Auexr4okKmJtxZNJxBgNxpiX9Dffrx8Y61PReKyEOPE6us/eNMf
        hgnetXcUAO6qZSv5DdODXNBcVulKWSSG4Mbgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GOnESL+qmVsEJ4nKcGwZX2YnUsU7mKsj
        xH7tuA8vKloEjo61Qfxsx3hPQ67JvnRkGiPa9oaOt0ShilMIjnh2jndAVZ5ZTMw2
        R788BoodQ65Ggt06fWh79sxO6NCm7eMeA12NhLQxOgTAxwlztwuj4YE65+SDCtit
        vKU1zj8/Lh4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1509E7C32B;
        Mon, 20 Mar 2017 11:55:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B0F57C32A;
        Mon, 20 Mar 2017 11:55:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 3/8] tag: Change  misleading --list <pattern> documentation
References: <20170318103256.27141-1-avarab@gmail.com>
        <20170318103256.27141-4-avarab@gmail.com>
        <xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com>
        <20170320034443.wq2uf4yabsxh2nji@sigill.intra.peff.net>
Date:   Mon, 20 Mar 2017 08:55:12 -0700
In-Reply-To: <20170320034443.wq2uf4yabsxh2nji@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 19 Mar 2017 23:44:43 -0400")
Message-ID: <xmqqinn4x7rz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AA6EAD0-0D85-11E7-82E1-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it's expected to work under the usual last-one-wins option
> parsing. A more subtle case is that:
>
>   git tag -l -d foo
>
> would override "-l" with "-d". That's reasonable under the same rule as
> long as the user knows that the two are mode-selectors. I don't think we
> make that explicit in the documentation, though, so perhaps it isn't
> something users should rely on.

Yup, that is reasonable.
