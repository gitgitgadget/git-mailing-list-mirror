Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33AD91F731
	for <e@80x24.org>; Wed, 31 Jul 2019 21:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfGaVVb (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 17:21:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56432 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfGaVVa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 17:21:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB2BB6CF07;
        Wed, 31 Jul 2019 17:21:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E+2JH0FqBztSTs5UVTMbX99dbIU=; b=qe9a4d
        vEw//das2bXRv1MLDcOCkf5IiTdsQR3Xa76HGrlCnSUrl+JRplUz04RDmfjHrtXq
        AriYRVjmvkCtlHgQ4w11MJYQL5XrJhhK3rOSsaV7G6ZETtPzj3RyYm0h/ufzZeIS
        refGAQd/fTI+p1tqZUI4ctwnhHOb5zRYx7df4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SqzokLMq0reofdlPKlmbaDbkAmkuiNyH
        WNRkhKuqoGjJrR0gmzJ+4d62GRHctHIX9+kw4YfHCABryilLb8ZvRdZseZH3S29I
        UJQzMwaeztFYxpY3uZrSexDih+U9iSZiQqC7XZkol5Xuee+BueoExf2Ur+EoaxTh
        45HrQ1eQufQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1B986CF05;
        Wed, 31 Jul 2019 17:21:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07DFB6CF03;
        Wed, 31 Jul 2019 17:21:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        git@vger.kernel.org
Subject: Re: Support for --stdin-paths in commit, add, etc
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
        <20190731171956.GA26746@sigill.intra.peff.net>
Date:   Wed, 31 Jul 2019 14:21:23 -0700
In-Reply-To: <20190731171956.GA26746@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 31 Jul 2019 13:19:57 -0400")
Message-ID: <xmqqblx9q4rw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 275216D4-B3D9-11E9-81E0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... But in the specific case you're discussing, it seems like
> using "git update-index" might already solve your problem. It's the
> intended plumbing for scripted index updates, and it already supports
> receiving paths from stdin.

Sounds good.
