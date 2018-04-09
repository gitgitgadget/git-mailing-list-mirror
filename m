Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7186F1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 07:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeDIHfY (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 03:35:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:60809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbeDIHfX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 03:35:23 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjIel-1eUSHc3lGB-00dVwY; Mon, 09
 Apr 2018 09:35:08 +0200
Date:   Mon, 9 Apr 2018 09:35:07 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 08/15] config: introduce an optional event stream
 while parsing
In-Reply-To: <20180406212227.GA7870@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1804090924060.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de> <a38025bcbc07b83b578ff2f1cde786bdca0c918c.1522772789.git.johannes.schindelin@gmx.de> <20180406212227.GA7870@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0m1uYjUtFgReoAI6mqEqDhpNSPLWQ/E4Vxmp96ApGd9yUpDiOgu
 x0Pxq9YCEBMqDW0dAWZ0+SfhH0a/ZuC7Zxi3MV7cmXOx2yGyWSemYuS1icrKGyf1aUvY0A6
 C3mITsHODol7d66sOymD/oi+SfH9qpik12SPzw2+2YyMD0qzfms7ITl3xtcnYlEaP5cvi1e
 cYEwkMawKEpC2U+cbCgww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ughX/+G10Vk=:I3Q/9r3B2eEmsO5Sol1boV
 X5DO+pQTD4GbjsPfgli9lckqWGdHm/T1x001tdPfy9cqb0mRTie5Mmpp4Y8gqk9TwIUBEv+6j
 DEYUOxtIHeWDIphKRsw54yQhw+BzdMCpy+A+BuHP/nerQ/ZPPiWRV7MeLMiPGI+7rDvokc7Qv
 tPlNpx0uY2P0UgDPOLUsdhybKiZUmIBdSyA2KUR+dmHR/KCcaTj4NHD2KHloT/TMP6PAsyCDF
 2Zq+SifIn/jqsQIrj7hyV8OMXeY3SZ7oMFVW4pEcWb3JGfsxpOY27X/fKpcyzgK/I0XbmkA8+
 N+JRe6Gn0Q19e6RYn0HToAvoAcLdoJU1EMbd+n7HKwffpcSnIJ5QLbTkKJujN1fBc1jAVhnkz
 STkcqr1IhnxXNC8iaTbFqPwZK21VCZXhPYQ+hzk659CykPP1z1UfbWqnSNkTRx3NXtHeNDZdm
 QZHtADbMTkK8Y4FySqvtPaGwG429LuocXfLOXMTenrGTFT7ShwQerTv10QSEDj58nsFXUHyJG
 9eWxkduQBWkH/6JiBsZq6GIW7glLgHMsPIUoJNlhEq3kNYHuzS2ntSDCDHomKmlRofoAYBd+6
 OXhLeqbPXCHvT/inxfpyvc3fO93kuT8x4hmBcGCkrdxlQKHv52H+Iu9XxL17BBMw3l0XAL7Dv
 0whsu6He1HuGrC7/yF7qd7znDFJK1MLqwZuK2WR6rGzXS5Bi0LpUkq10f5sIP8FdoLfRcd+yP
 BtZ5/awu7Mb1km0IUADu+2hqRqyq21g+XkwYSL2cAFq2tzG1HNlq1C0Ym8uknSQ/hIrvEyCuv
 DxDiTcVmyc4C0XSuuN29FSn1kC8g3s87Kck0SCL6aHIKOjEh3A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 6 Apr 2018, Jeff King wrote:

> On Tue, Apr 03, 2018 at 06:28:29PM +0200, Johannes Schindelin wrote:
> 
> > This extends our config parser so that it can optionally produce an
> > event stream via callback function, where it reports e.g. when a
> > comment was parsed, or a section header, etc.
> > 
> > This parser will be used subsequently to handle the scenarios better
> > where removing config entries would make sections empty, or where a
> > new entry could be added to an already-existing, empty section.
> 
> Nice, it looks like this didn't end up being too bad to go in this
> direction. It seems like this is an optional "also emit the events here"
> function you can set.

Yes.

> I think in the long run we could actually just always emit the events to
> this function. And then we could wrap that to provide an interface that
> matches the existing callbacks (just an event-stream callback that sees
> EVENT_ENTRY and calls the sub-callback).

Well, not precisely. The event stream was implemented in a minimal
fashion, in particular *not* emitting enough information in the event
stream for that. To keep things as little intrusive as possible, the
CONFIG_EVENT_ENTRY event is only emitted *after* the config_fn is called,
and at that point we do not even know the key and the value any more.

I fear that it would make the code quite a bit more complicated to change
it in the way you suggested.

Side note: a slightly ugly aspect of my patch series is that the
CONFIG_EVENT_SECTION event *also* does not provide the interesting
information (in this case, the section name), but that it has to be
inferred from the cf->var field (which is file-local to config.c, and
which has been set to the section name followed by a single '.' at that
point). Again, this keeps the diff simpler to review, and that's why I did
it that way.

> But that might end up quite a pain, since we have a zillion entry points
> into the config parser, making wrapping tough. So I'm perfectly happy to
> stop here for now.

Right.

> > +static inline int do_event(enum config_event_t type,
> > +			   struct parse_event_data *data)
> 
> I'm not sure if "inline" here is a good idea, as it seems to get called
> quite a few times. If we're trying to make things fast, bloating the
> instruction cache may have the opposite effect.

Good point.

The reason I declared this as inline function was that I test whether
either data->opts or data->opts->event_fn are NULL, and whether we are
continuing to look at whitespace, for early returns from that function.
Which I wanted to avoid doing in a hot function (I'd rather skip calling
the function if it is pointless to call it).

However, the config code is hardly performance-critical, as we do not
expect to parse hundreds of kilobytes, right? So that "inline" was a
premature optimization.

Thanks,
Dscho
