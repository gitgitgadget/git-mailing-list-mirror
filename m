Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C587B20756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750922AbdAQVRd (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:17:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53706 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750952AbdAQVRc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:17:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 060556179D;
        Tue, 17 Jan 2017 16:16:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z4SjpBlPQsARJKVJWMUsq8lf4hU=; b=euA5pV
        o5kPP9RAxlyu6OBPmyMCLxVVdPol3gbHeu//j5CIq4soTNUCuNPevArB5Df0ZfWh
        7wDd5/2OCXhEJ7N6BOeL/RHNbnuygwqKizzFYbnVE7wiLpOgWzecZx1m0XPdzJP0
        lxSfo5ZyJ5cXjK5tWM95BNce50lKQatLP3DIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AQXVhJJn0LxH0F+WqRS1c0UifkahPeeJ
        tUMDe+7VaVFLbAua3kX59ST7t5Sshm1DGWuO0Ty0LDWrxZVPM7dBnGpXP9iMjPwl
        0BZKl9kt12XN7ZRMh96dtyN8TwT15LTSfX1QlhrqUZt39OVnfVS51HoKXWiJsWMh
        uS87JcKkzo8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F23416179C;
        Tue, 17 Jan 2017 16:16:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DBF86179B;
        Tue, 17 Jan 2017 16:16:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/6] fsck: prepare dummy objects for --connectivity-check
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
        <20170116213204.e7ykwowqzafkexqd@sigill.intra.peff.net>
Date:   Tue, 17 Jan 2017 13:16:39 -0800
In-Reply-To: <20170116213204.e7ykwowqzafkexqd@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Jan 2017 16:32:04 -0500")
Message-ID: <xmqq60lde6a0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CE12444-DCFA-11E6-918E-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +		# Drop the index now; we want to be sure that we
> +		# recursively notice that we notice the broken objects
> +		# because they are reachable from refs, not because
> +		# they are in the index.

Rephrase to reduce redundunt "notice"s?
