Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80563C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512882076B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IaWlmeAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgD2WHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:07:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55886 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD2WG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 18:06:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B747E47E2E;
        Wed, 29 Apr 2020 18:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cse9M8ofQn7U9N7r2T1TZdU6qWU=; b=IaWlme
        ASND25MENlaMF/XO3c1Z5XAiM1kt7y9LERa7PtcPEnRrwIBwhvme8b2r67N5jD/j
        9SCCajEPZYIi4tWEn2VVx1ctRigwTkBE9i4NHshz7tTRxjKCk/1IZWxkzRaQCXX5
        0OSHIc9gMLSE8AOxFrlstpjxIoJtowggErwEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DhIArDUj8SpB4WcfiGKL1xQ18GcqAOtK
        8Z8Xwmy8+UE1c7CDGGOT+DAHI16HKAZFOjdQf8RWyQ7cYId5vh20URwFgbgyHkCS
        rComVuJ7kA9vyvYY9vRhXPWz1n5BCa8eUCWXgvUujkGrL3Vjgwx+BxnsXjnajlOV
        l6BUFX9bQ+c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADCCA47E28;
        Wed, 29 Apr 2020 18:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A7AA47E23;
        Wed, 29 Apr 2020 18:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Taylor Blau <me@ttaylorr.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* [PATCH 0/4] t: replace incorrect test_must_fail usage (part 5)
References: <cover.1588162842.git.liu.denton@gmail.com>
        <20200429195035.GB3920@syl.local>
        <90edb162-e035-bdb7-a2d2-ffc6bd075977@kdbg.org>
        <xmqqblnaufyt.fsf_-_@gitster.c.googlers.com>
        <CAPig+cT5DH2KW4nnQxUMaZzLR0JSLovGbpGC=3vYOWY2QWyKsw@mail.gmail.com>
Date:   Wed, 29 Apr 2020 15:06:56 -0700
In-Reply-To: <CAPig+cT5DH2KW4nnQxUMaZzLR0JSLovGbpGC=3vYOWY2QWyKsw@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 29 Apr 2020 18:00:23 -0400")
Message-ID: <xmqq368muetb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDFB1726-8A65-11EA-B646-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This seems like a good addition and perhaps may help reduce reviewer
> burden (not that this comes up very often, but I've recommended it
> here and there when reviewing patches). Here's a possible alternate
> wording:
>
>     Similar to test_must_fail, but tolerate success, too. Use this
>     instead of "<git-command> || :" to catch failures due to segv.
>     To ignore failure of non-git commands, however, use
>     "{ <non-git-command> || :; }".

That is certainly more succinct.  "git grep -e '|| :' t/" gives some
hits that are candidates to convert to test_might_fail, by the way.


