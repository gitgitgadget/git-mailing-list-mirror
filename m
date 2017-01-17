Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96DBD20756
	for <e@80x24.org>; Tue, 17 Jan 2017 19:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbdAQTjf (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 14:39:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62970 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751139AbdAQTje (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 14:39:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CB396017A;
        Tue, 17 Jan 2017 14:39:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9UAjd2VR0sAnSB8rzX4huloErAQ=; b=gtIGV6
        Yhp6TL5nJiKTScEzIIsjV/wYpNBsXYGsiQfw8/jFkryWPrc9UxaHB7/hIo7sJOma
        jXONzFHKgAvmqpU0UN/if7Fy/otfmpZHoRrkSeyVV0oPAxeseJimktHm5pTpfBuV
        CijAgFtyDA+jG1L7tEFhSMUMJgny1ncm7u51s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qiv7HsA0XmxQ6T35o+dv5GEauMNOYe31
        88UBqRj5vhAyoCqMmlK+0fJIP0688hyGyyOlw2aAS9y3LX8Yc+6/KYqGC/aYVP1a
        HIf9jAhyvNSzNOR5oam3PFdySck88Ea6rZlhyzhfpp6mzL3UA9CMryV8TWP0QqJO
        kep+Zontfg8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 850F860179;
        Tue, 17 Jan 2017 14:39:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED10460178;
        Tue, 17 Jan 2017 14:39:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: clarify multi-line brace style
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
        <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
        <alpine.DEB.2.20.1701161251100.3469@virtualbox>
        <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701161746200.3469@virtualbox>
        <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
        <20170116220821.4tji5mrfcdbdpfuo@sigill.intra.peff.net>
Date:   Tue, 17 Jan 2017 11:39:31 -0800
In-Reply-To: <20170116220821.4tji5mrfcdbdpfuo@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Jan 2017 17:08:21 -0500")
Message-ID: <xmqqfukhfpcc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB8C0502-DCEC-11E6-8B0B-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I think this is pretty clearly the "gray area" mentioned there. Which
>> yes, does not say "definitely do it this way", but I hope makes it clear
>> that you're supposed to use judgement about readability.
>
> So here's a patch.
>
> I know we've usually tried to keep this file to guidelines and not
> rules, but clearly it has not been clear-cut enough in this instance.

I have two "Huh?" with this patch.

 1. Two exceptions are not treated the same way.  The first one is
    "... extends over a few lines, it is excempt from the rule,
    period".  The second one, is ambivalent by saying "it can make
    sense", implying that "it may not make sense", so I am not sure
    if this is clarifying that much.

    If we want to clarify, perhaps drop "it can make sense to" and
    say

	When there are multiple arms to a conditional, and some of
	them require braces, enclose even a single line block in
	braces for consistency.

    perhaps?

 2. I actually think it is OK to leave some things "gray", but the
    confusion comes when people do not know what to do to things
    that are "gray", and they need a rule for that to be spelled
    out.

	When the project says it does not have strong preference
	among multiple choices, you are welcome to write your new
	code using any of them, as long as you are consistent with
	surrounding code.  Do not change style of existing code only
	to flip among these styles, though.

    That obviously is not limited to the rule/guideline for braces.

> -- >8 --
> Subject: [PATCH] CodingGuidelines: clarify multi-line brace style
>
> There are some "gray areas" around when to omit braces from
> a conditional or loop body. Since that seems to have
> resulted in some arguments, let's be a little more clear
> about our preferred style.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/CodingGuidelines | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 4cd95da6b..0e336e99d 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -206,11 +206,38 @@ For C programs:
>  		x = 1;
>  	}
>  
> -   is frowned upon.  A gray area is when the statement extends
> -   over a few lines, and/or you have a lengthy comment atop of
> -   it.  Also, like in the Linux kernel, if there is a long list
> -   of "else if" statements, it can make sense to add braces to
> -   single line blocks.
> +   is frowned upon. But there are a few exceptions:
> +
> +	- When the statement extends over a few lines (e.g., a while loop
> +	  with an embedded conditional, or a comment). E.g.:
> +
> +		while (foo) {
> +			if (x)
> +				one();
> +			else
> +				two();
> +		}
> +
> +		if (foo) {
> +			/*
> +			 * This one requires some explanation,
> +			 * so we're better off with braces to make
> +			 * it obvious that the indentation is correct.
> +			 */
> +			doit();
> +		}
> +
> +	- When there are multiple arms to a conditional, it can make
> +	  sense to add braces to single line blocks for consistency.
> +	  E.g.:
> +
> +		if (foo) {
> +			doit();
> +		} else {
> +			one();
> +			two();
> +			three();
> +		}
>  
>   - We try to avoid assignments in the condition of an "if" statement.
