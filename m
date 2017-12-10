Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D081A1F407
	for <e@80x24.org>; Sun, 10 Dec 2017 22:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdLJWgo (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 17:36:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61093 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751263AbdLJWgo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 17:36:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EF79CB79B;
        Sun, 10 Dec 2017 17:36:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mQZmFA7Nu0eilpmJZnYIFDb4CjA=; b=vr9r/U
        zI8v0/s/MrqDjXG+VKE2DZlejeXZkutn3BDhHW3VIE8eMJKKHkn3qSYSiFauuSq+
        +3JB0pA28sPyjUQrgItxhnnbJgmX1zhsmKI3zenKWfJiYkcHF7oHdS7YHvqnWT/y
        RC+exHmmDQgvgBGxAwSA8nHnXdUEtFlQFE/Vw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y/QOz/wA5RJDVYSysIR2DZgJDHT1oxKb
        8bhD07xG/LRc4bkgxAiXAD+IkW/wQ1HwMr4JqIgTzlqOXPTPvRNsYPrJ0P2ohrVa
        WDKgksH3cMRtIUZ45uNZ6Ndg6073zJvfytz603MZjgimuGJzXSBGYovg1nadg0Nq
        3bJIqhB4wVA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 460EACB79A;
        Sun, 10 Dec 2017 17:36:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4AA4CB799;
        Sun, 10 Dec 2017 17:36:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH Outreachy 1/2] format: create pretty.h file
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
        <xmqq7etx9kzq.fsf@gitster.mtv.corp.google.com>
        <20171210145354.GA20367@sigill.intra.peff.net>
Date:   Sun, 10 Dec 2017 14:36:41 -0800
In-Reply-To: <20171210145354.GA20367@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 10 Dec 2017 09:53:54 -0500")
Message-ID: <xmqq8tea5hxi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98769742-DDFA-11E7-88D5-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Dec 08, 2017 at 09:40:09AM -0800, Junio C Hamano wrote:
>
>> I see you've "standardized" to drop "extern" from the declarations
>> in the header; I have an impression that our preference however is
>> to go in the other direction.
>
> Can we revisit that?
>
> I haven't see any compelling reason to include the "extern" in a
> declaration. And all things being equal, I'd prefer the thing that makes
> the source code shorter, and is one less thing for authors to remember
> to do.

Surely, but there is no point revisiting.  I simply misremembered
what we did at around 1354c9b2 ("refs: remove unnecessary "extern"
keywords", 2016-03-31).

As long as we know which way we are standardizing, I personally do
not have strong preference either way.  I appreciate shorter-to-type
(i.e. missing "extern") but I also appreciate the more familiar and
logical declaration in a header file that indicates something exists
somewhere (i.e. explicit "extern") ;-).

Thanks.
