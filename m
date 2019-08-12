Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49ADA1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 16:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHLQEo (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 12:04:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55959 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLQEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 12:04:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D958A7D373;
        Mon, 12 Aug 2019 12:04:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ffw4NwAwSPzW2iPN9plHNRG04zk=; b=LIQbAJ
        4xU62kTsH2wj1UjdMn5TDCEu1T0PQO0+Kmcf/JYflwiy0kC5TZkH8USQnItYmb9v
        Rk7H2+ja9sePpo3GDW1skJtcv3a1y0ktrBT5xPYWt19OizM3j1KGT39ov+bmDvRX
        EVQr4nIOr/7p5Gta31wL+EdtlcPGCaummXDSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jyQcMI086SU/3RXV9k/8jM+g7C3RhxkN
        l48E9PLcNTeXDtjohAteVns5eZjGl9P4S2qTWQ1kEdcXN+m4k/mqE4LdKUxRcuCg
        CoIWB4tZWJFoToV4vqvTu//i5CyrFIfm/O/A+8lt51K5LrEeVhpJm+/w4ckXAHQp
        lFM/JDHQxIQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CFC897D372;
        Mon, 12 Aug 2019 12:04:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 063B07D371;
        Mon, 12 Aug 2019 12:04:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t/perf: rename duplicate-numbered test script
References: <20190812155803.GA25161@sigill.intra.peff.net>
Date:   Mon, 12 Aug 2019 09:04:36 -0700
In-Reply-To: <20190812155803.GA25161@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 12 Aug 2019 11:58:03 -0400")
Message-ID: <xmqqftm6bca3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3387A24-BD1A-11E9-A405-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There are two perf scripts numbered p5600, but with otherwise different
> names ("clone-reference" versus "partial-clone"). We store timing
> results in files named after the whole script, so internally we don't
> get confused between the two. But "aggregate.perl" just prints the test
> number for each result, giving multiple entries for "5600.3". It also
> makes it impossible to skip one test but not the other with
> GIT_SKIP_TESTS.
>
> Let's renumber the one that appeared later (by date -- the source of the
> problem is that the two were developed on independent branches). For the
> non-perf test suite, our test-lint rule would have complained about this
> when the two were merged, but t/perf never learned that trick.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is meant for 2.23, but obviously it's not hurting anything if it
> doesn't make the cut. I double-checked that there is no conflict with
> anything on pu, either. :)

Thanks for being careful.  Will apply.

>  t/perf/{p5600-clone-reference.sh => p5601-clone-reference.sh} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename t/perf/{p5600-clone-reference.sh => p5601-clone-reference.sh} (100%)
>
> diff --git a/t/perf/p5600-clone-reference.sh b/t/perf/p5601-clone-reference.sh
> similarity index 100%
> rename from t/perf/p5600-clone-reference.sh
> rename to t/perf/p5601-clone-reference.sh

By the way, do we feel differently (e.g. more risky) when we see
100% rename without the "index old-oid..new-oid mode" lines and when
we see 99% rename with one, with a one-line change?
