Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5387202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 06:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbdJBGaW (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 02:30:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59007 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750715AbdJBGaW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 02:30:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52A3395578;
        Mon,  2 Oct 2017 02:30:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lcxrMsq1hrpAlyEIsxzeayEZ2rg=; b=x94Xgw
        KuN3R0Qw3BCGjoiLfW1ih/dc5JBiE9rJlmtK8rka4B+74Cyh/KN2sp2DB+NXm/NL
        3rTnRF5Hi3+8cjz0MCBgUoaBIULy6fyKRoQ3hhfx8TRSJr/CdL3OsgCP2NIChHAe
        POeqkMpnVsABrF/IXYB3nGqOdzpOlf23+IyeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fouBuTQzXy0HCUmjVIOmlnv8sktems81
        eXk6mtL5jruh+oa8hn/08xtpNBZydWkIzqhG7ek2uoeoQ6/Iy82OywIMmBPeJNv/
        j2EyIDyPm1JDNwdDWF8G/OMhA++P8FNl1sxzrXy9T3IkwgwPyoHlnrbzAxMkT/wL
        rs77F+7OORo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A90E95577;
        Mon,  2 Oct 2017 02:30:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD4B395576;
        Mon,  2 Oct 2017 02:30:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/11] various lockfile-leaks and -fixes
References: <cover.1506862824.git.martin.agren@gmail.com>
        <20171002062252.didw7guppl4nvxry@sigill.intra.peff.net>
Date:   Mon, 02 Oct 2017 15:30:19 +0900
In-Reply-To: <20171002062252.didw7guppl4nvxry@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 2 Oct 2017 02:22:52 -0400")
Message-ID: <xmqqbmlqoydg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A03A7AA-A73B-11E7-BA4A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I've read through each and with the exception of patches 10 and 11, they
> all look good to me.
>
> For 10 and 11, I think you've convinced me that the current behavior is
> buggy. I do wonder if the subtleties might be easier to understand as a
> single patch, but I'm OK either way.

I found it was not too hard to understand what is going on with
10/11 as separate patches, and I suspect that it would be also OK if
they were a single patch (but I cannot easily "unsee" them, so this
is merely a suspicion).

Thanks, both.  Let's merge this to 'next' soonish.


