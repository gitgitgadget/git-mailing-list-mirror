Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340861F858
	for <e@80x24.org>; Wed,  3 Aug 2016 19:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758307AbcHCT6z (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 15:58:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758295AbcHCT6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 15:58:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BA5F308D0;
	Wed,  3 Aug 2016 15:58:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4zsvI0TZsLatug7uJI6WkaeIkSI=; b=Zl6Qre
	LRHF/BUXm3wcSOD86pPv77TEwL4L15KxHoL2gHhv2ophTqKG0KVf0DVvuwMem2jm
	Higk4G92XQkM2k9hMg8hFells/SDIlPlCByfRuqqgux0qpM74NrJnuaOtPgypibO
	jfmtpWSnqoVsC+K75CiHEU1S5blZ1ZRE5/Zaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HH3dp2JEXJJ8+iX1wbxHRIck0zTB4dsH
	TpXy6UA3KTEnGZHaASDoRaC868KEFpF5SHLIPMuHiRzY4BdxwSQJfrNNWGioNRvW
	8sN/oelemdg/j0/0W/IVTi6AvXtWCvxabj5+wuQGYE1X90CoFEfCpeCO3rH9ORmZ
	LLzlbjj3t74=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53AB8308CD;
	Wed,  3 Aug 2016 15:58:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3A2B308C8;
	Wed,  3 Aug 2016 15:58:43 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pass constants as first argument to st_mult()
References: <579CEF77.9070202@web.de>
	<20160801164723.mober7em6znt56w4@sigill.intra.peff.net>
	<xmqq8twgi4qp.fsf@gitster.mtv.corp.google.com>
	<20160801211131.6ernsu74ohod2cin@sigill.intra.peff.net>
	<xmqq60rkglym.fsf@gitster.mtv.corp.google.com>
	<20160803191334.jflia6cqxqx2uqjx@sigill.intra.peff.net>
	<CAPc5daVABao1UZdPk0BnJNkTtYYV74Tw_0CZ9-uj9sK92h+x7g@mail.gmail.com>
	<20160803194913.cz6xiai3g5r3sghq@sigill.intra.peff.net>
Date:	Wed, 03 Aug 2016 12:58:41 -0700
In-Reply-To: <20160803194913.cz6xiai3g5r3sghq@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 3 Aug 2016 15:49:13 -0400")
Message-ID: <xmqqh9b18w0e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE81E896-59B4-11E6-9099-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 03, 2016 at 12:41:30PM -0700, Junio C Hamano wrote:
>
>> On Wed, Aug 3, 2016 at 12:13 PM, Jeff King <peff@peff.net> wrote:
>> > On Mon, Aug 01, 2016 at 03:31:45PM -0700, Junio C Hamano wrote:
>> >
>> > I think in my head I rewrite any multiplication like "N of M" as having
>> > "N" as the smaller number. I.e., it is conceptually simpler to me to
>> > count five 30's, then 30 five's (even though I do not implement it in my
>> > head as a sequence of additions, of course; I'd probably do that
>> > particular case as "half of ten 30's").
>> >
>> > I have no idea if that's cultural or not, though.
>> 
>> Now, when you say "count five 30's", which one do you have
>> in mind? 5x30, or 30x5?
>> 
>> If you meant the former, I think that _is_ cultural. I am pretty
>> sure that I was taught in school(s) to read 5x30 as adding 5
>> thirty times.
>
> I think I would say "30x5" in that case. But I'm not sure where that
> comes from, and I'm not even 100% sure that I would say that (after
> thinking about it, it's hard for me to figure out what I would have done
> if I _hadn't_ just thought about it).

By the way, reading "30x5" as "count five 30's" disagrees with
calloc(nmemb=5, size=30), which wants to add 30-byte necessary for
each member 5 times to allocate 150 bytes.

Anyway, this tangent is long enough ;-)


