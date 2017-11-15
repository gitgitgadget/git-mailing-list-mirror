Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D8A9202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 04:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756419AbdKOE2d (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 23:28:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60939 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755106AbdKOE2b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 23:28:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA606BEF78;
        Tue, 14 Nov 2017 23:28:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UpdU1zA/XdV6b8cnrIZXiruVRuw=; b=o+dWM3
        8brWokWsOLl5reqi1oU/txDXfTT3FN2UoEF7orrBhHOYTY5NmOC3iE0d7aclMO20
        xkHZqKvuU/67AdijmQlBrHYbA8Dn/v9Od7YgfPWk3nTdZuOP/HRD9i5Gtlc7/kUe
        6FZbKa7mM5xVOYaPVYQDfWQqLzwS/u+QtME5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UC0v0vu80IR+TIoQ7sTT393YijWerWrV
        EWaBNJ+cBHjsObXi1D6HzLvbizH38pA2czELmWIhjn1Ab/GOu6rV9CkuFj5AYVBV
        RZ13DyZ3VvG7ycnYNBpfYdX2cocEyJ8NDKZMVxrtz/sXu1agbKW70vRR01OIGq1Q
        /tAri0egX6k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2184BEF77;
        Tue, 14 Nov 2017 23:28:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 336F1BEF76;
        Tue, 14 Nov 2017 23:28:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] diff: --ignore-cr-at-eol
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
        <20171107064011.18399-1-gitster@pobox.com>
        <20171107064011.18399-3-gitster@pobox.com>
        <alpine.DEB.2.21.1.1711071345430.6482@virtualbox>
Date:   Wed, 15 Nov 2017 13:28:24 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711071345430.6482@virtualbox> (Johannes
        Schindelin's message of "Tue, 7 Nov 2017 14:23:00 +0100 (CET)")
Message-ID: <xmqq60ac17yv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BC6B890-C9BD-11E7-9240-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

I notice that I left a few things unanswered even after giving
answers to the most important part (i.e. "what is this for was
sold incorrectly").  Here are the leftover bits.

>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index 89cc0f48de..aa2c0ff74d 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -519,6 +519,9 @@ endif::git-format-patch[]
>>  --text::
>>  	Treat all files as text.
>>  
>> +--ignore-cr-at-eol::
>> +	Ignore carrige-return at the end of line when doing a comparison.
>
> I am not a native speaker, either, yet I have the impression that "do a
> comparison" may be more colloquial than not. Also, it is a carriage-return
> (as in Sinatra's famous song about Love and Marriage) not a carrige-return.
>
> How about "Hide changed line endings"?

That felt like a good suggestion when I saw your reaction,
especially with only the parts visible in the patch and its context,
but after reviewing descriptions of other --ignore-* options, I no
longer think so.  The existing description of "--ignore-*" matches
manpages of GNU diff and they do not say "hide", either.

>> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
>> index 04d7b32e4e..b2cbcc818f 100644
>> --- a/xdiff/xutils.c
>> +++ b/xdiff/xutils.c
>> @@ -156,6 +156,24 @@ int xdl_blankline(const char *line, long size, long flags)
>>  	return (i == size);
>>  }
>>  
>> +/*
>> + * Have we eaten everything on the line, except for an optional
>> + * CR at the very end?
>> + */
>> +static int ends_with_optional_cr(const char *l, long s, long i)
>> +{
>> +	int complete = s && l[s-1] == '\n';
>> +
>> +	if (complete)
>> +		s--;
>> +	if (s == i)
>> +		return 1;
>
> What is the role of `s`, what of `i`? Maybe `length` and `current_offset`?

I'd agree with that sentiment if this file were not borrowed code
but our own, but after looking at xdiff/ code, I think the names of
these variables follow the convention used there better, which
consistently names the variable for lines they deal with l1, l2, etc.,
their sizes s1, s2, etc., and the indices into the line i1, i2, etc.

>> +	/* do not ignore CR at the end of an incomplete line */
>> +	if (complete && s == i + 1 && l[i] == '\r')
>> +		return 1;
>
> This made me scratch my head: too many negations. The comment may better
> read "ignore CR only at the end of a complete line".

Perhaps.  "incomplete line" is a term with a specific definition
(and I think by "complete line" you mean a line that is not an
incomplete line), so I do not see the above comment as having too
many negations, though.  If you feel strongly about it, you could
"fix" it with a follow-up patch.

>> @@ -204,6 +223,14 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
>>  			i1++;
>>  			i2++;
>>  		}
>> +	} else if (flags & XDF_IGNORE_CR_AT_EOL) {
>> +		/* Find the first difference and see how the line ends */
>> +		while (i1 < s1 && i2 < s2 && l1[i1] == l2[i2]) {
>> +			i1++;
>> +			i2++;
>> +		}
>> +		return (ends_with_optional_cr(l1, s1, i1) &&
>> +			ends_with_optional_cr(l2, s2, i2));
>
> There are extra parentheses around the `return` expression.

Yes, everybody knows that return is not a function that needs a
parentheses around its parameter.  I would drop them if this
expression were not split into two lines, but because the expression
is split at &&, I think it reads better with the extra parens.  So
I'll leave them as-is.

Thanks.

