Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6723120899
	for <e@80x24.org>; Thu, 27 Jul 2017 15:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbdG0P0j (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 11:26:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52004 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751030AbdG0P0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 11:26:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8CF89CFF4;
        Thu, 27 Jul 2017 11:26:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QcrGnZDc/hOP+k1bA5P5RJv6Tf0=; b=rRVQQq
        UD2Z3k+o/N8TfMLQBE5t6OE8B1Hr9uvX3aSblm4c4G3G0A5x/5JZT4AoEpUMlvWZ
        Si2EUWIqeAcoM6WeU9MXUVbyZ4YE8YDZZuTy8We1Fp143X7j3t/d924ICOXdFNE2
        aRrTvZq5xnTCsEDl5T/73WRriH2Xiszd6DIHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hDqqj/i0ze0fPsgE/2OeGIxUFqcSLMp7
        xMkALC7CP/AazkcPEkvjYMxiUDMmdVq5hNYFzFZzucp7E7mawbEBPBPjBwDcZ3cz
        5rFcslXR19iTHDROQk2t/Uics9cn1LHM8eBBVk92H1XZU3iJHefj2oS2CKCZu26N
        MnfaJBrcaB8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF4669CFF3;
        Thu, 27 Jul 2017 11:26:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 407DB9CFF1;
        Thu, 27 Jul 2017 11:26:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Fwd: Should "head" also work for "HEAD" on case-insensitive FS?
References: <87ziclb2pa.fsf@gmail.com> <20170704071909.phs4bf5ybdord2lv@tigra>
        <87van8boe9.fsf@gmail.com>
        <20170705083611.jgxbp4sqogicfwdb@sigill.intra.peff.net>
        <xmqqshiaizhz.fsf@gitster.mtv.corp.google.com>
        <xmqqo9sxdwjp.fsf@gitster.mtv.corp.google.com>
        <CAMy9T_FmE=8xzjRJJRxLwQjoMStJx5sYO_xtODv2OEZm54DurA@mail.gmail.com>
        <xmqqa84c6v41.fsf@gitster.mtv.corp.google.com>
        <CAPc5daXj4sBuWP0r6t0nArXt1DJW+9byT49M_g8LcjrqBMJnRg@mail.gmail.com>
        <20170727143507.bezad7dnthx4nqtc@sigill.intra.peff.net>
Date:   Thu, 27 Jul 2017 08:26:29 -0700
In-Reply-To: <20170727143507.bezad7dnthx4nqtc@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 27 Jul 2017 10:35:08 -0400")
Message-ID: <xmqqlgn9oq8q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6D90C2E-72DF-11E7-A04E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 26, 2017 at 05:49:47PM -0700, Junio C Hamano wrote:
>
>> What I saw was that a test have ended up with .git/%46%4F%4F when it
>> was told to create a ref "FOO" (which indicates that "FOO" was
>> passed to the files backend), which later failed to read it back
>> because the pseudo_ref handling refs.c wanted to see ".git/FOO" on
>> the reading side.
>> 
>> Perhaps it is only a bug in t/t1405-main-ref-store.sh?
>
> An interesting related issue for pseudo-refs: if you encode HEAD as
> .git/%48%45%41%44, how will we recognize that directory as a git
> repository?

Yes, that is a valid point.  I may have forgot to explain why the
sample change in my message upthread special cases "HEAD" and leaves
it untouched, but it is done for this exact reason.

>   1. It should say "this is a git repo, but not a vintage I understand".
>      Not "this isn't a git repo, I'll keep looking".
>
>   2. How does a git version of the correct vintage decide "this is a git
>      repo, so I'll check its config for extensions.refBackend, and a-ha,
>      they _do_ have a HEAD". There's a chicken-and-egg problem.

Yes, exactly.
