Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 405522090A
	for <e@80x24.org>; Mon, 20 Mar 2017 20:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753232AbdCTUjP (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 16:39:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52271 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752673AbdCTUjO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 16:39:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C9E67CE25;
        Mon, 20 Mar 2017 16:39:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j2J5x/wSo0jOYOKzFDIUBNDYcFA=; b=P4Wyej
        wzmaMBExPI0ZpNkr0a7kLVgvLz+HFYahrq+jltvgFvp4fD1NnCdKFEk7gn/c8FRc
        zF4dclCtv6ZaNcUzaFy3YfSZ0xxsX5gdQXU8h6R6wusra5lnoMt5nXaTprs12aa5
        8U1qfmBVRyo+Mw4KbYZYjk8wiML/ZgfSM8f3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bQYPcOB7ZohwTdI3aPmjB6hYBLS1q6c3
        VJOYXHMf33eLqNBT4juNnadqUSoDn1ByeEs/pUYacbRg24SyKVHNSvKO6H/YotoG
        zOGyLv7OEC/cWrlrR62LpTQSOU3mWDTn3psq5r/cQ4ddO/CTYVRaQyxH74OswTM8
        jpsXFFBtvwI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 146FD7CE24;
        Mon, 20 Mar 2017 16:39:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CFA27CE23;
        Mon, 20 Mar 2017 16:39:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     sourav mondal <souravcristiano502@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1] adding word_regex for go language
References: <20170320193555.6656-1-souravcristiano502@gmail.com>
Date:   Mon, 20 Mar 2017 13:39:11 -0700
In-Reply-To: <20170320193555.6656-1-souravcristiano502@gmail.com> (sourav
        mondal's message of "Tue, 21 Mar 2017 01:05:55 +0530")
Message-ID: <xmqqk27jvg28.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46B0F218-0DAD-11E7-A345-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sourav mondal <souravcristiano502@gmail.com> writes:

> Subject: Re: [PATCH v1] adding word_regex for go language

Perhaps clarify the title with what area this change affects, e.g.

	Subject: userdiff.c: patterns for "go" language

cf. Documentation/SubmittingPatches.

> Go programming language is one of the promissing language now. Adding built-in driver for the same. This patch contains word_regex for go. As the language specification this has alpha-numeric and under-score for identifiers. It covers all types of number system decimal, octal, hexadecimal. Also can specify signed or usigned number by using "u or U", long number by using "l or L" and exponent term by using "e or E". The following lines cover all types of operator ex. arithmatic, logical, bitwise, assignment etc.. 

Wrap long lines.  Also unless there is a good reason not to, we tend
to write our log messsage in imperative mood, as if you are giving
orders to the codebase to "be like so", or giving orders to a patch
monkey to "make the code like so".

>
> Signed-off-by: sourav mondal <souravcristiano502@gmail.com>
> ---
>
> I'm working on go language patterns and will send it soon.
> thanks & regards 
> sourav
>
>  userdiff.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/userdiff.c b/userdiff.c
> index 2f8e078..99f5539 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -148,6 +148,13 @@ PATTERNS("csharp",
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
> +PATTERNS("go",
> +	  /* word_regex */
> +	 "[a-zA-Z_][a-zA-Z0-9]*"/* identifiers */
> +	 "|[0-9eE]+[lL]?[uU]?|0[xX]?[0-9a-fA-F]+[uU]?[lL]?" /* numbers */
> +	 "|[-+*/%<>&|!^=]="/* operators */
> +	 "|--|\\+\\+|&&|<<=|>>=|\\|\\|"
> +),

PATTERNS() takes three arguments, the name of the pattern, pattern
and word_regex.

Please do not send an incomplete patch that does not even compile
without marking as such (i.e. request for help or early comments
from those who are willing to help even on an incomplete work).

Thanks.

