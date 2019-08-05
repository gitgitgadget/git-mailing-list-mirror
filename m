Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C701F731
	for <e@80x24.org>; Mon,  5 Aug 2019 18:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfHESty (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 14:49:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51999 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfHESty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 14:49:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8180C7AD69;
        Mon,  5 Aug 2019 14:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+kutCUI8kLrx/WYSB1+hLuggAas=; b=AM/lCC
        qXyeBKbrb13V0nBshIahz3jugIRdoqZ61MNRNHA0Kt5qHinU0SfygkIKWq1fNv0H
        P86Vc6BTy4pyASE/lu88VjOxQZLj9YYmhWvzo5n44+4E7VCQx1KteHu+l80L0uJU
        3U1EJ/TfS3VFA3OpSezpEMa4Xo579a8mYljig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DA2hXmlZldeLtaAwPv1lv1/UkgbqqaDV
        EMUg6aS5nNmEnll+ZIpeH1b8RYXTf7YjC8OpgRDZdLeAD3HUVSPqzXTc14B71x1E
        iDYB5xfNbL+40ovdlwosxU6U7DjmCYKx+tdP/pqX/KnKsESoROvTERLK0um2cugr
        Z77lJFC1kYs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A1667AD68;
        Mon,  5 Aug 2019 14:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 994877AD66;
        Mon,  5 Aug 2019 14:49:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2] l10n: reformat some localized strings for v2.23.0
References: <20190730033512.7226-1-worldhello.net@gmail.com>
        <20190803195907.3124-1-jn.avila@free.fr>
        <20190803234522.GA5417@sigill.intra.peff.net>
Date:   Mon, 05 Aug 2019 11:49:46 -0700
In-Reply-To: <20190803234522.GA5417@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 3 Aug 2019 19:45:22 -0400")
Message-ID: <xmqqv9vbmoqd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCE91FDA-B7B1-11E9-8C3B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
>> -			   N_("where the checkout from")),
>> +			   N_("where the checkout is from")),
>
> I think your original "where to checkout from" is better.

Would we even want to do s/where/which tree-ish/?

> translators, but note that the output will be different. The original
> would be something like:
>
>   warning: Fetch normally indicates...
>   warning: To re-enable...
>
> where now we'd get:
>
>   warning: Fetch normally indicates...
>   check has been disabled...
>   or run 'git config...
>
> which might be a bit harder to read because the wrapped lines lose the
> prefix. For advise() we nicely pick out the newlines and prefix each
> line individually, but warning(), error(), etc, don't do that. Maybe
> they should.

Yeah, I'd be surprised that nobody thought of doing that, so perhaps
somebody tried and failed with a possible fallout.  I do not offhand
see any downside of teaching them to do the prefixing.

For existing multi-line warnings that uses a single call to
warning(), I think the preparer of the message manually indents the
second and subsequent line by a run of SPs to match the screen width
of "warning:" prefix (and expect translators to do the same with
their language), and we need to get rid of that kind of "hack" when
we insert a middle layer between *_builtin() and vreportf() to do
the line chomping to produce output similar to advise() code.

> That's too big for this late in the -rc cycle, I think.

Agreed.
Thanks.
