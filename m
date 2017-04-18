Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55CBF1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 04:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdDREJx (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 00:09:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52344 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750954AbdDREJv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 00:09:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E7FE76044;
        Tue, 18 Apr 2017 00:09:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=et/B7a4XEgEAMGTjKVG8/+Mmw0Y=; b=x8/6gm
        g9R0qn9LzRSRQl2FH6qv95J46w5+tGrquvBRI67JnK07XWlF/8x6dg6elSs3tBqo
        CZkL666nF1+TD47uoh//cPCvaT5wzUt8zD0jz1LHPqM8fNwOXylE5nW+tG4tkZ/Q
        YWTyDf3VByny5QGx5GfSuw89hUD0p8paYCik4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fydCT9J8ML6/Pgb/EuhRe44Gdsu5t0Di
        5Dsv5SOBqdoQ+Z8/e4y9E3zps8Dm2OgVY86q95x6fDDuGBwrlbOvBSDRA0hnq0C1
        6usW1rHNOg9NO45TVmAO7PhEMdUiw44VvQUFnQbFZWzo7r4Lws5fENKzdsl+6ed3
        K8LNZHVF/Mc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 278C476043;
        Tue, 18 Apr 2017 00:09:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80D3176042;
        Tue, 18 Apr 2017 00:09:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v9 0/5] [GSoC] remove_subtree(): reimplement using iterators
References: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
Date:   Mon, 17 Apr 2017 21:09:48 -0700
In-Reply-To: <1492462296-4990-1-git-send-email-bnmvco@gmail.com> (Daniel
        Ferreira's message of "Mon, 17 Apr 2017 17:51:31 -0300")
Message-ID: <xmqqmvbefjar.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD9D8FA6-23EC-11E7-A512-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Ferreira <bnmvco@gmail.com> writes:

> I think this is the closest to a final version we've ever gotten. I
> followed all of Michael and Stefan's suggestions on top of v8, and with
> Michael's endorsement made dir_iterator_begin() return NULL and set
> errno appropriately in case of an error.
>
> On second thought, maybe the extra code complexity required from
> dir_iterator_begin()'s callers might be actually an advantage as
> dir_iterator grows to tackle more complex dir traversing challenges on
> Git. After all, we might want some special behavior depending on what
> the given `path` is instead of always considering it valid and later
> behaving as if it was an empty directory.
>
> Thanks again for the reviews.

I had a bit of trouble with phrasing here and there, but other than
that the series was a pleasant read overall.

Will queue, anticipating "Yeah, this is good as the final version"
comments from reviewers.

Thanks.
