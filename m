Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF26820248
	for <e@80x24.org>; Wed, 27 Mar 2019 01:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfC0BGL (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 21:06:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60225 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbfC0BGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 21:06:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 164DE4A415;
        Tue, 26 Mar 2019 21:06:11 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=c4S2pMKnygrPnRWagG1NdWq6NUY=; b=Lw7Muni
        d/g+cK6Y1QWhWtZ8JNNHePHBXwtkC4aJpnme6o02f9rjk+vMHGh48cc+XrLH+wHp
        KnKbUow2N32mRvQ8coZLPTVKBu5X/ogTMXWSniPYdSbavgz2xel+rS425uvYRp0h
        0hgND7G2z3/39nCD4c2R26J6OP7iSvN5yVnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=vFHnZMlJffoS9z57Lx4RrcD2/Etpkc6MG
        Lo+zPCRnG3F3JeU2OmQXQbmCVU5XGDWnN9hf9woN/JK/pwHCs7sTOLMBtSuM3sYv
        ty/h442nYy0fKSRfQXdP7qmbXMuihP5VWmFXuLbXE90qHEtwlk84J1i5SzEGlQif
        6F8FLpuZOU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E77F4A411;
        Tue, 26 Mar 2019 21:06:11 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4638C4A410;
        Tue, 26 Mar 2019 21:06:06 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Tue, 26 Mar 2019 21:06:03 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190327010603.GR4047@pobox.com>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190317194431.GY31362@pobox.com>
 <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
 <20190324162131.GL4047@pobox.com>
 <20190325150633.GC19929@sigill.intra.peff.net>
 <20190325190041.GM4047@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325190041.GM4047@pobox.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 7FF2C8A8-502C-11E9-936A-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I wrote:
> Jeff King wrote:
>> That seems like a bug in asciidoctor, which ought to be quoting the "<".
>> We certainly can't quote it ourselves (we don't even know that our
>> backend output is going to a format that needs angle brackets quoted).
> 
> Yep, it seems so.  I filed this upstream:
> 
> https://github.com/asciidoctor/asciidoctor/issues/3205
> 
> I updated to asciidoctor-2.0.1 this morning to test, in case
> it was one of the issues fixed since the 2.0.0 release.
> Alas, we're the first to hit it and report it.

Dan Allen fixed this upstream and released 2.0.2 today.
It's very good to know that asciidoctor upstream is
incredibly responsive.  If anyone runs into Dan at a
conference, please buy him a beer. ;)

There's still the matter of 2.0 dropping docbook45.  I'll
try to get around to testing 1.5.x releases with docbook5 to
see if they work reasonably well.  If not, we can add a
version check and set ASCIIDOC_DOCBOOK appropriately.

One other issue that crops up with docbook5 is that the
xmlto toolchain now outputs:

    Note: namesp. cut : stripped namespace before processing

as documented at

    https://docbook.org/docs/howto/howto.html#dbxsl

It's mostly an annoyance which we either want to strip out,
or pass an alternate docbook5 xsl, I think.  But I'm not
very familiar with the guts of the xml/docbook toolchains.

-- 
Todd
