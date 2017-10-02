Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D1120A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdJBANg (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:13:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51627 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751101AbdJBANf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:13:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14CC4A0AF4;
        Sun,  1 Oct 2017 20:13:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MD/zHib8+cncbg+CA19zzlitGhc=; b=eS4b44
        kJzI8pnQUnNLzZblsD4PXZ4xinpR4QsyBOuHSEEZAKpwKSCXvMLFIgcYisPEwvXR
        xjmz+YO7+aqVhRIhdgaknMVjhz2UQR5SBdTGUMTQbW6ROrmvQAvhmVw3Z0M8L9CV
        n8rixzLJi/7O4/tZqP95UzmQyQZB9euyUO3o0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jVZZClyEQqZcTHfREy0EgQ/120bs98xu
        6TEzuPlslWRWnSMLMc8eX6c9Ijtea/r8fK+lqw8yaxD1G508yOlL4yLB+7D2Oxja
        nlWfjPpJC9W6TpDrK6zXZvvAERDnw+w5XJrFXLBfop7O+rjZ8chaCjZNL+fHu8OI
        Mjowy1VyJIc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DC51A0AF3;
        Sun,  1 Oct 2017 20:13:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7AA27A0AF1;
        Sun,  1 Oct 2017 20:13:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 5/6] ref-filter.c: use trailer_opts to format trailers
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
        <20171001161852.84571-1-me@ttaylorr.com>
        <20171001161852.84571-5-me@ttaylorr.com>
Date:   Mon, 02 Oct 2017 09:13:33 +0900
In-Reply-To: <20171001161852.84571-5-me@ttaylorr.com> (Taylor Blau's message
        of "Sun, 1 Oct 2017 09:18:51 -0700")
Message-ID: <xmqq3772tniq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87A067B6-A706-11E7-8135-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +test_expect_success '%(trailers) rejects unknown trailers arguments' '
> +	cat >expect <<-EOF &&
> +	fatal: unknown %(trailers) argument: unsupported
> +	EOF
> +  test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
> +  test_cmp expect actual

I'll have to remember to fix these two lines up before queuing.
Please yell at me if the version I'll push out later forgets to do
so.


Thanks.
