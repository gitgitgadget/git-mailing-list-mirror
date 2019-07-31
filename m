Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D7E1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 17:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfGaRRF (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 13:17:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65401 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfGaRRF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 13:17:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4CDA1597C0;
        Wed, 31 Jul 2019 13:17:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k2NLJotxAkd7BmfgukwrcGBuJeQ=; b=wLAeZI
        AGIeK+G+kVaNfW4hwYXnmwQ9xPkk4H1ZzPkXn5z6UjWNq5UUJuEHKe1lQlPajZ6Z
        +/zSQMLFe69LFqePxJDYBkV4IXkJbyFr33WF9h1GKfUFuYm+gETTT5weQD0RGQAk
        L+85hXLCjz5+3CIsryLq3aBB8Q5MUYJfMaf3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XfFwZagNMcZBo1M4JQgVqZbUi8hHNV7r
        Y341UTTPsC1QrbDTs5M0dbV3gCYfMd0MuNzDdpk1MFDGEyBJQfiMzCUk3t0iACc0
        AaRDvz0o6EqKI5+KrhkFPjVojYpqB1i6DuVKS4KO0wbMbECfmSvB/Kwe4SAoiGpN
        AxE0E1Jz8iI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB3BF1597BF;
        Wed, 31 Jul 2019 13:17:02 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50D971597BE;
        Wed, 31 Jul 2019 13:17:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
        <20190730194938.GZ4545@pobox.com>
        <20190730200203.GA4882@sigill.intra.peff.net>
        <20190730205624.GR20404@szeder.dev>
        <20190731005933.GA9610@sigill.intra.peff.net>
        <20190731012336.GA13880@sigill.intra.peff.net>
        <20190731015917.GB4545@pobox.com>
        <20190731032735.GA14684@sigill.intra.peff.net>
        <20190731035344.GA26019@sigill.intra.peff.net>
Date:   Wed, 31 Jul 2019 10:17:01 -0700
In-Reply-To: <20190731035344.GA26019@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 30 Jul 2019 23:53:44 -0400")
Message-ID: <xmqq5zniqg36.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03133810-B3B7-11E9-8872-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And here it is for reference with the matching change in test-oidmap,
> and the adjustments necessary for the test scripts (from master, not
> from my earlier patch). I think I prefer the simpler "just sort it all"
> version I posted with the commit message.

Yeah, let's go with that version.

I am wondering if we should follow suit to certain language's hash
implementation to make sure the iteration order is unpredictable to
catch bad scripts ;-)  Perhaps that is not worth it, either.
