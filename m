Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4342320248
	for <e@80x24.org>; Fri,  5 Apr 2019 02:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfDECR1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 22:17:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61126 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbfDECR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 22:17:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14766135F8A;
        Thu,  4 Apr 2019 22:17:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=jTh/GRm3R1Tvv
        yXurJRJhihrhmg=; b=U3IfYPHGl1tz5eUtScSct8BhvOwDPuKTEKTIrONs4udcQ
        WOPMI6/3KwYJfjoKJbRQaBNHRlpuh2bx9J/Cgt/vig/khQ+JVBKOqwCkn8R1JBOh
        ottpJ2vD0c2Uhaj2MZXERLLu0Hle2lL9ndTJRNIsQNI8o7P0xo7tjuI0AnxZTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=SyNJiJ2
        6uJodVPPt0uSPYqz4nABue2NRtgzBob0IGbBVj1twuyKbkGoZJeF7Wt9CsmFEXxl
        ctPyLwhUIKoO/Q81LXbQK4vw8WTrOQT/eqgTEdmPZbBXi4U+N3ybKFHg+Q4ZOrag
        ZzLVnOyedkVcSgAj+Yvr68bZUK4OzOx/sT8g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BAB0135F89;
        Thu,  4 Apr 2019 22:17:24 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78A28135F87;
        Thu,  4 Apr 2019 22:17:23 -0400 (EDT)
Date:   Thu, 4 Apr 2019 22:17:21 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190405021721.GS4047@pobox.com>
References: <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
 <20190324162131.GL4047@pobox.com>
 <20190325150633.GC19929@sigill.intra.peff.net>
 <20190325190041.GM4047@pobox.com>
 <20190327010603.GR4047@pobox.com>
 <20190328000612.GA12419@genre.crustytoothpaste.net>
 <20190330180014.GB4047@pobox.com>
 <20190330210457.GC12419@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190330210457.GC12419@genre.crustytoothpaste.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: F2E7566C-5748-11E9-BC70-1646B3964D18-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On Sat, Mar 30, 2019 at 02:00:14PM -0400, Todd Zullinger wrote:
>> Thanks for the very useful docbook5/xmlto details!
>>=20
>> The hard-coded use of the non-namespaced stylesheets in
>> xmlto is unfortunate.  I hadn't gotten far enough along to
>> run into that limitation of xmlto, so many thanks for saving
>> me from finding it myself.  I'm sure it would have taken me
>> far longer.
>>=20
>> If it turns out that docbook5 causes us more pain than it's
>> worth, I suppose we could choose to use the builtin manpage
>> backend when using asciidoctor >=3D 2.
>=20
> I suspect this will be the easiest way forward.  If we produce
> semantically equivalent manpages, then this is also a lot nicer for
> people who would prefer not to have a full XML toolchain installed.

It's a good end goal.  There are a number of differences in
the output when using the manpage backend directly verus
docbook and then xmlto.  The way links to external html
documents are presented is the main one which comes to mind.
Maybe we can adjust that via asciidoctor-extensions.rb or
something, I don't know.

Elsewhere in this thread, Jeff made the very valid point
that we're probably wise to keep using the docbook/xmlto
chain as long as we're supporting both asciidoc and
asciidoctor.  Unless it turns out that it's more work to
coax asciidoctor (and the various 1.5 and 2.0 releases in
common use) to work with that same docbook/xmlto chain than
it is to do it directly, that is.

>> Or we could see about adding a docbook45 converter, which
>> upstream noted as a possibility in the ticket=B9 which dropped
>> docbook45 by default.
>=20
> Another possibility, depending on how responsive the xmlto upstream is,
> is to add some sort of DocBook 5 support to it. This shouldn't be
> terribly difficult, although we'd have to disable validation. DocBook 5
> uses RELAX NG, and libxml2/xmllint's support for this has some bugs,
> such that it will mark some valid documents using complex interleaves a=
s
> invalid. Still, if this is the direction we want to go, I have no
> problem adding this support.
>=20
> Since we'd have a quite new Asciidoctor and a new xmlto, distros should
> have both around the same time.

Good point.  It can't hurt to push for improvements across
the tools.  (Well, other than time being a limited resource
and time you may spend on doc tools being time you can't
spend on the hash conversion, which I imagine is a more
interesting project.)

Thanks,

--=20
Todd
