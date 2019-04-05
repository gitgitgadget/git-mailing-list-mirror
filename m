Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8731C20248
	for <e@80x24.org>; Fri,  5 Apr 2019 01:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfDEBUK (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 21:20:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51730 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDEBUK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 21:20:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25B3212ABF8;
        Thu,  4 Apr 2019 21:20:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=BUFYYq4Lps69F
        /7rDjp5PR7vldA=; b=sWkJcPTlXN1aN/hq3ZCYmUDX2t+jqaFGLZO/aI6DiLZnw
        MAuTO6uUCGlfdRkjOlxN9dnHWWEIk6WHyYRi8YFeeuZkQMstzxO7za2joM4wdGig
        QZVYu+lEZ+kDqSLw5EhTsA601Vi48Z6ao3PWzUFlcCg/F7kWKUtzXWQ5HxeE6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=T6S7jHj
        LzcB2olNspOyO992kQrRlQU9O8Xo4uFxvbrxYoYFmWulptu60bw731mbp0z4Ygii
        n3mAh3VSeePm+0ABeQefuASKcjwoxlvRCKTXx4sjJON+jRRa3sNsH2wam8+ZKds3
        CvMg1AB2167L9ZZ8fjYnVJqhzgwl1e0vsiRU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BD3D12ABF6;
        Thu,  4 Apr 2019 21:20:05 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70BE112ABF5;
        Thu,  4 Apr 2019 21:20:04 -0400 (EDT)
Date:   Thu, 4 Apr 2019 21:20:02 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v1 1/2] Documentation/rev-list-options: wrap
 --date=<format> block with "--"
Message-ID: <20190405012002.GO4047@pobox.com>
References: <20190330183001.16624-1-tmz@pobox.com>
 <20190330183001.16624-2-tmz@pobox.com>
 <20190401130804.GA11664@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190401130804.GA11664@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: F10ECE5E-5740-11E9-B12C-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Sat, Mar 30, 2019 at 02:30:00PM -0400, Todd Zullinger wrote:
>=20
>> Using "+" to continue multiple list items is more tedious and
>> error-prone than wrapping the entire block with "--" block markers.
>>=20
>> When using asciidoctor, the list items after the --date=3Diso list ite=
ms
>> are incorrectly formatted when using "+" continuation.  Use "--" block
>> markers to correctly format the block.
>>=20
>> When using asciidoc there is no change in how the content is rendered.
>=20
> This seems like an asciidoctor bug, though I think this kind of
> list-within-a-list stuff is inherently a bit heuristic-driven just due
> to the syntax.

Indeed.  There's certainly a limit to the changes we want to
make solely to work-around issues in either asciidoc or
asciidoctor.  When the work-around is (at least arguably) an
improvement, then it's probably worthwhile.  That's how I
thought about it, anyway. :)

> I do agree that the result after your patch is more readable, so I thin=
k
> I prefer it even if the asciidoctor bug were fixed. I suspect we could
> be using "--" blocks for readability in more places (I don't think it's
> worth going on a hunt to convert old spots, but something to keep in
> mind as we write new documentation).

Agreed, that sounds perfectly reasonable to me.  The
Asciidoctor user manual says:

    If you=E2=80=99re attaching more than one block to a list item,
    you=E2=80=99re strongly encouraged to wrap the content inside an
    open block. That way, you only need a single list
    continuation line to attach the open block to the list
    item. Within the open block, you write like you normally
    would, no longer having to worry about adding list
    continuations between the blocks to keep them attached
    to the list item.

https://asciidoctor.org/docs/user-manual/#list-continuation

I imagine it's "strongly encouraged" both to help consumers
avoid these sort of oddly-parsed continuation issues, as
well as the Asciidoctor devs from having to field as many
bug reports.

--=20
Todd
