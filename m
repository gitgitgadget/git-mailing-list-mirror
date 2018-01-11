Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D54F1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 23:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbeAKXOY (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 18:14:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53216 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeAKXOX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 18:14:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE17BC67D5;
        Thu, 11 Jan 2018 18:14:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oXO0RKmxwBgkMq+Gom8EbsCQ+y0=; b=hPcwzs
        +6SES339v0aCLm6vK/SrQv4JZTmRoOUuMxzUgaFpmqxloUG1H600EATfzBTA6GeO
        laeGo3lSsyEnhbL1c/KLbuxYurGZVHLdpJyi4kZO/5Kr8HeNVidAqaLpW7AIKWPA
        AAN4+exbaWOZLfOW9fKH4tpTLOc3cO1rmcd9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=myuvKFarP0yz3A2DB0qY8CT7SS2hK5vK
        N2oU9HqZqpdJV47wJ+qI5WPOwZbAXG9NqhnuOceWnht2UOcK/3aEOQYj3pVkp2FI
        k9dWFdIxBv1BDIDC3pQoaICXMYZ1EacAozfSa3XahhrPrua9QEwjJ+F11LBjGuIA
        au7rx4Y7gNo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6B9CC67D4;
        Thu, 11 Jan 2018 18:14:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 226B2C67D3;
        Thu, 11 Jan 2018 18:14:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Andreas G. Schacker" <andreas.schacker@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc/read-tree: remove obsolete remark
References: <20180109153034.22970-1-andreas.schacker@gmail.com>
        <20180111104914.GA5897@sigill.intra.peff.net>
        <xmqqbmi0z0b7.fsf@gitster.mtv.corp.google.com>
        <20180111222155.GA13570@sigill.intra.peff.net>
Date:   Thu, 11 Jan 2018 15:14:07 -0800
In-Reply-To: <20180111222155.GA13570@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 11 Jan 2018 17:21:55 -0500")
Message-ID: <xmqqd12gxa2o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20A42510-F725-11E7-8D2D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 11, 2018 at 11:02:04AM -0800, Junio C Hamano wrote:
>
>> >> ---prefix=<prefix>/::
>> >> +--prefix=<prefix>::
>> >>  	Keep the current index contents, and read the contents
>> >>  	of the named tree-ish under the directory at `<prefix>`.
>> >>  	The command will refuse to overwrite entries that already
>> >> -	existed in the original index file. Note that the `<prefix>/`
>> >> -	value must end with a slash.
>> >> +	existed in the original index file.
>> >
>> > Is it worth mentioning in the new world order that the slash is not
>> > implied? I.e., that you probably do want to say "--prefix=foo/" if you
>> > want the subdirectory "foo", but do not want to match "foobar"?
>> 
>> Doesn't "git read-tree --prefix=previous HEAD^" add paths like
>> "previous/Documentation/Makefile" to the index, i.e. instead of
>> forcing you to have the required slash at the end, we give one for
>> free when it is missing?
>
> Yes, I think it does what you'd want with that path. But it would not do
> what you want by adding "previous-file". Which seems like a gotcha that
> should be mentioned.

I am a bit puzzled.  

Do you mean a user who types "git read-tree --prefix=v1- HEAD^" may
be expecting to see that the blob object "HEAD^:Makefile" added at
path "v1-Makefile" etc?

