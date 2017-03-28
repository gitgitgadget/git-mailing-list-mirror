Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D0E1FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 16:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbdC1Q7O (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 12:59:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57275 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752585AbdC1Q7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 12:59:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9ACB0752E3;
        Tue, 28 Mar 2017 12:58:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PFu3OUFwps/pL4bLMMCBQGx3KZ0=; b=SmqMMN
        cqtk8Tz/Jv0Tp5fVkeKatqK6CcEYqP9YU66B7Dy0+ilPSBD3PZTmm8JL0npdBDZI
        M+JoSAa+gNE/++aZvAim3ZiTt1KpSqiRBV8B5RBJhcM6dJRfTxjnZ6HeR9LPZtbM
        52unyk/2XNunsQ3+AZU0t41JdluZ/ibx2d7V4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LTykaB0kx9WPSz6PIo9NTboLqetJL9df
        xdfTaR+bo8chHyiuttJ0/whUEUVZdJ55tR8X2/4NM9VRcdXJJRGNwOaHeJLsrziU
        wrO4B54RfD+nL4BzSuO0+bLhuVnkQIWmvluOk42n0NJwSN7+Q/1WPY/wgGU3ZGXn
        KufUP6PXjng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 930BC752E2;
        Tue, 28 Mar 2017 12:58:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0D5A752DF;
        Tue, 28 Mar 2017 12:58:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 06/21] builtin/receive-pack: fix incorrect pointer arithmetic
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
        <20170326160143.769630-7-sandals@crustytoothpaste.net>
        <20170328065123.f4uswxxznv3wyqaz@sigill.intra.peff.net>
Date:   Tue, 28 Mar 2017 09:58:54 -0700
In-Reply-To: <20170328065123.f4uswxxznv3wyqaz@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Mar 2017 02:51:23 -0400")
Message-ID: <xmqqbmsle3sh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D45F3BE4-13D7-11E7-A889-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The patch itself is obviously an improvement. It may be worth graduating
> separately from the rest of the series.

Yup, I will split it out to bc/push-cert-receive-fix that builds
directly on an ancient jc/push-cert topic that was merged at
v2.2.0-rc0~64.

I'll need to drop the duplicate from bc/object-id topic, of course
(which hasn't happend).

Thanks.

