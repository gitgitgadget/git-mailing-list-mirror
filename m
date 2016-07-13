Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C6C2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 20:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbcGMUny (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 16:43:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750975AbcGMUnw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 16:43:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 445A62B19C;
	Wed, 13 Jul 2016 16:43:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CmmBRBJQx6ISJA+RYQkiMkk36qs=; b=b6N0dr
	BNBf8raljfD8MrieONHAbBouy4faX9e/UBxnolMQTqkP79i5RXoYLZ7a2oNNHva+
	xRkquiZe13XwiukwO+Vm0UEFlG7FRjUDnQARRCD2yAli2YpIVz5nhKH2fDROZSoq
	b2Ea+eK3106cwaMDnYzKlLFnHtt8kY7pelmIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ubR8E0uwZ75VTBXCTrsqsB0Hpjou5VvZ
	lp+saC3pyNUWL4DXRqIG7d7BzXyZxf6wOGyy8FyFu5go4x6vSH8SATLccXp8LVNy
	oSQ4hIS5pUNrFYOyUdsa3jJfWCK6+/5bAmMIjEcxiEl9gNz1VaEYvjERg0Vn3K35
	CzvKLSbHiaY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C0F32B19B;
	Wed, 13 Jul 2016 16:43:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B5E5B2B19A;
	Wed, 13 Jul 2016 16:43:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
	<87lh17kgdy.fsf@linux-m68k.org>
	<20160711235417.GA26163@sigill.intra.peff.net>
	<xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 13 Jul 2016 13:43:48 -0700
In-Reply-To: <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 11 Jul 2016 18:59:51 -0700")
Message-ID: <xmqqmvllz2t7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 814CD028-493A-11E6-A994-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It is somewhat disturbing that nobody seems to be regularly building
> on 32-bit platforms these days, which is the only reason I can think
> of why this was never reported until it hit a maintenance track.
> This should have been caught last week at f6a729f3 (Merge branch
> 'jk/tzoffset-fix', 2016-07-06) when the topic hit 'master' at the
> latest, and more preferrably it should have already been caught last
> month at 08ec8c5e (Merge branch 'jk/tzoffset-fix' into next,
> 2016-06-28).
>
> Those who care about 32-bit builds need to start building and
> testing 'next' and 'master' regularly, or similar breakages are
> bound to continue happening X-<.
>
> Volunteers?

We might eventually see a volunteer or two but that hasn't happened
yet, at least in the past few days.

Does Travis CI testing have an option to run our tests on some
32-bit platforms?
