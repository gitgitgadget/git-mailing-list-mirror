Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441F220899
	for <e@80x24.org>; Sun, 20 Aug 2017 17:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbdHTREu (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 13:04:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55580 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753122AbdHTREt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 13:04:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB9DDA2FA8;
        Sun, 20 Aug 2017 13:04:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cipFHyyarVtHkUf6fSE5VXk6x9c=; b=gzAWFw
        qjXs2wGH0FITAmnkewXWXVuRj6QjE0af8WMQYiSul3oTQXA9okGBRdx+HBdJxR//
        R5UYzM8x7Hv6O59k7k5d2bJkqm5kELH2ivRWg2mpf4vsZGXA8wviYsEswVj4PSY0
        iRUGaD9oWoR4i113qydvgSfFbGxmBj0YY5m0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WDee2/fU+ozNzwplyi1dKTH1Jh+8esOQ
        phK6taWGG+yXj+g9i7ZqdkfiVciXML8dpA+69RnbEfIjG8QOdaYNwk1A3Onpdig8
        RUM1jA7bAZqtWO99XoPwrnuRdIoot3HjlTRmsCm+tSB974SZv/S+gyMmkT2gDuU0
        uaWu7DDigFg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4227A2FA7;
        Sun, 20 Aug 2017 13:04:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECC9DA2FA6;
        Sun, 20 Aug 2017 13:04:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #04; Fri, 18)
References: <xmqq60dkbma1.fsf@gitster.mtv.corp.google.com>
        <20170820094009.z23wclpku35txflg@sigill.intra.peff.net>
Date:   Sun, 20 Aug 2017 10:04:39 -0700
In-Reply-To: <20170820094009.z23wclpku35txflg@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 20 Aug 2017 05:40:09 -0400")
Message-ID: <xmqqmv6u6uhk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7E589A6-85C9-11E7-8465-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Aug 18, 2017 at 02:26:14PM -0700, Junio C Hamano wrote:
>
>> * jk/trailers-parse (2017-08-15) 8 commits
>>  - pretty: support normalization options for %(trailers)
>>  - t4205: refactor %(trailers) tests
>>  - pretty: move trailer formatting to trailer.c
>>  - interpret-trailers: add --parse convenience option
>>  - interpret-trailers: add an option to unfold values
>>  - interpret-trailers: add an option to show only existing trailers
>>  - interpret-trailers: add an option to show only the trailers
>>  - trailer: put process_trailers() options into a struct
>> 
>>  "git interpret-trailers" has been taught a "--parse" and a few
>>  other options to make it easier for scripts to grab existing
>>  trailer lines from a commit log message.
>> 
>>  Will merge to 'next'.
>
> I saw that this was merged and ended up with a few conflicts related to
> the other interpret-trailers series (sorry). Your resolution looks good
> to me.

Thanks for double checking.  This was an easy conflict--the only
remotely tricky part was "list.nr -> !list_empty(&list)".

> There are a few leftover bits I think we could do on top:
>
>   - we disallow "--trailer" with "--only-input", because the former is
>     quietly ignored. After the two series are merged, I think "--where",
>     etc should probably get the same treatment (the behavior without it
>     isn't horrible, but it's nice to warn the user that what they asked
>     for is bogus).

Sounds good.  I didn't think about that case.

The implementation would have to add another variable whose sole
purpose is to keep track of "have we ever seen any of these
options?" and flip it in the callbacks that implement these options,
as there is no way to tell between WHERE_DEFAULT that is set from
the command line, from the configuration, or left as-is without
either.

>   - Martin pointed out a typo in the new documentation
>
>   - I just noticed that ref-filter understands "%(trailer)", too
>     (courtesy of Jacob's original series from last year; I didn't think
>     to even check for it). It probably should learn to support the
>     additional options, too. I didn't look, but it probably could just
>     reuse the new trailer.c formatting function I added.
>
> There's a patch for the second one below.
>
> None for the other two right now, as I'm just trying to clear out
> backlog before going offline for a few days (but I'd be happy if anybody
> wanted to take a crack at them in the meantime).

Thanks.  Have a good time (I am assuming you'd be having fun, as
opposed to having to become offline to tend to unpleasant duties).

We probably want some convention to mark the messages with these
"leftover bits that are relatively low hanging fruits", so that
archive search can find them easily.  #leftoverbits perhaps?

That way, hopefully people can look for messages with such mark that
came from those list participants with known-good taste.  That would
be far easier than a general bug tracker anybody can throw garbage
at, and requires constant attention to winnow only good ones out of
chaff.

> -- >8 --
> From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
> Subject: [PATCH] doc/interpret-trailers: fix "the this" typo
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I put Martin as the author since he noticed the bug, but I think we are
> OK without a signoff for this trivial change (normally I'd have just
> squashed, but the topic is in 'next' now).
>
>  Documentation/git-interpret-trailers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 1df8aabf51..2e22210734 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -21,7 +21,7 @@ This command reads some patches or commit messages from either the
>  <file> arguments or the standard input if no <file> is specified. If
>  `--parse` is specified, the output consists of the parsed trailers.
>  
> -Otherwise, the this command applies the arguments passed using the
> +Otherwise, this command applies the arguments passed using the
>  `--trailer` option, if any, to the commit message part of each input
>  file. The result is emitted on the standard output.
