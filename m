Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDA71F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 16:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbcJTQXG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 12:23:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51336 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755935AbcJTQXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 12:23:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09FC446883;
        Thu, 20 Oct 2016 12:23:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y/7ftNoVMr68eqWzva+5dyCw+iA=; b=hZFsyH
        0aF23EXS3j7s8Y9K66oaPUBz4w22CWsaWCJacgMcFy0ngGGxi4nZch7BvyQOSL/a
        PTSYK1akGABtBq1sTQWlRlwkw/F9HDHsF4ch4mdbKtp4SJTASLWomzYqoJ9lCZD+
        1cEYyu5DxsFgwHMxLOYV01CKfER49LLKj3llc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x+HMPRmmMWRA2aKbp2gTcWYbPcd8LAI3
        OmGMSCWkir0fZVMeKSqtY+DEM5ebYvsegLrKqnPN+zsq7wMgRGTPfQD9X2JGOhgS
        K+G0aQjExHdFf3PkGo6fa/iT5lw9HXIZNOIPod63FNaeptcQCOg4+aNqnNI4KnCY
        9gwzlPwHkzQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0277746882;
        Thu, 20 Oct 2016 12:23:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 626B64687F;
        Thu, 20 Oct 2016 12:23:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jan Keromnes <janx@linux.com>, git@vger.kernel.org
Subject: Re: [regression] `make profile-install` fails in 2.10.1
References: <CAA6PgK5vtnZSqqZafMVGoy0Rv38=8e__uQvXaf2SyPePHuPjJA@mail.gmail.com>
        <20161019210519.ubk5q54rrvbafch7@sigill.intra.peff.net>
        <xmqqh988j7oo.fsf@gitster.mtv.corp.google.com>
        <xmqqd1iwj7jf.fsf@gitster.mtv.corp.google.com>
        <20161019223840.j3lvfswazuozxkjo@sigill.intra.peff.net>
Date:   Thu, 20 Oct 2016 09:23:01 -0700
In-Reply-To: <20161019223840.j3lvfswazuozxkjo@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 19 Oct 2016 18:38:40 -0400")
Message-ID: <xmqqinsnhtwa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79A75FF6-96E1-11E6-A6C1-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I usually just try to recreate the actual environment (e.g., run the
> tests as root, run them on a loopback case-insensitive fs, etc) as that
> gives a more realistic recreation.

True.  I just do not want to run the tests as root myself ;-)  I
wonder if fakeroot would give us good enough illusion for that--I
haven't used it for a long while.
