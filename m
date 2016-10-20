Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C15F1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 18:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933864AbcJTSlh (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 14:41:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52758 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933059AbcJTSlg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 14:41:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4E3F47B2C;
        Thu, 20 Oct 2016 14:41:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1GOoxh8bC5R119e/GW17u8wnJdw=; b=bQORhA
        AyIF6p+fjuKH+u/49/F9HE7XYclR4cisYaPTxb5kIFlIlJ/HPn689lzRXH9gCPh5
        fUuhWsUSezYWANsyNO8mICHLOHPrfAs2g0JhxjKtt0dxFCvJ4F/E0XFOOMOZbTzP
        iADAIIr4FZps8rZYy6y5z9AQ9SccEdSBZZg2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZJwJHJ89I9ufpZygDeZVp2fsLu0grkeW
        EEB8TymFm2AYXFqithp5sbnRoV8UjvZapkdXhzOmk/FRlzkhLvAeVoC8uhuaEVgu
        ao3uOIQfFVWKBsOvzV2l/zVLIXpJ47SyvzgD5bxfRsjScK8XM00uSYyuL40Yu/Lj
        xMGH8KHaSwA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC2DF47B29;
        Thu, 20 Oct 2016 14:41:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A2FB47B28;
        Thu, 20 Oct 2016 14:41:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
        <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net>
        <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
        <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net>
        <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com>
        <xmqqwph2hqdg.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xqbqfCTOHJZJ9ZGXv3oeSvKUdJByc8mdzoAoXRd7UZ6HA@mail.gmail.com>
Date:   Thu, 20 Oct 2016 11:41:32 -0700
In-Reply-To: <CA+P7+xqbqfCTOHJZJ9ZGXv3oeSvKUdJByc8mdzoAoXRd7UZ6HA@mail.gmail.com>
        (Jacob Keller's message of "Thu, 20 Oct 2016 11:13:57 -0700")
Message-ID: <xmqqfunqhnhf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D342314A-96F4-11E6-99AC-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> I am not sure if that is OK.  I think it is less not-OK than the use
>> case I mentioned in my earlier message, in that this is not a case
>> that "please don't do it" breaks.  It however is an inconvenience
>> that the user has to say "git add file" before the "git commit" (or
>> "git commit file") to conclude the sequence.
>>
>> So I dunno.
>
> Hmmm.. Ya ok I don't think we can actually distinguish between these
> two work flows.

What we might want to have in "git commit <paths>" is a new mode
that is totally different from -i/-o that says roughly "Start from
the tree of HEAD, pretend as if you removed all the paths that match
the given pathspec from the tree, and then added all the entries in
the index that match that pathspec.  Write that tree and commit.
Take nothing from the working tree".  I have a feeling that when
people do

	$ git add -p file1 file2 file3
	$ git commit file2

and ends up including _all_ changes made to file2, not just the ones
they picked in the earlier part of the workflow, they are expecting
such a behaviour.



