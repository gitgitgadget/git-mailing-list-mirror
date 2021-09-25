Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25B7C433F5
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 06:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D034F6127A
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 06:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhIYGrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Sep 2021 02:47:11 -0400
Received: from ikke.info ([178.21.113.177]:50816 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344146AbhIYGrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Sep 2021 02:47:09 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id BF52E440136; Sat, 25 Sep 2021 08:45:28 +0200 (CEST)
Date:   Sat, 25 Sep 2021 08:45:28 +0200
From:   Kevin Daudt <me@ikke.info>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, 'Jeff King' <peff@peff.net>,
        'The Grey Wolf' <greywolf@starwolf.com>, git@vger.kernel.org
Subject: Re: ANSI sequences produced on non-ANSI terminal
Message-ID: <YU7FiMwLYdrhSc0P@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, 'Jeff King' <peff@peff.net>,
        'The Grey Wolf' <greywolf@starwolf.com>, git@vger.kernel.org
References: <20210923052122.2F655CE@eddie.starwolf.com>
 <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
 <xmqqmto3x8ik.fsf@gitster.g>
 <038801d7b0c6$f9345a90$eb9d0fb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <038801d7b0c6$f9345a90$eb9d0fb0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 06:04:20PM -0400, Randall S. Becker wrote:
> On September 23, 2021 5:55 PM, Junio C Hamano wrote:
> >Jeff King <peff@peff.net> writes:
> >
> >> On Wed, Sep 22, 2021 at 10:21:22PM -0700, The Grey Wolf wrote:
> >>
> >>> Anything else you want to add:
> >>> 	I searched google and the documentation as best I was able for
> >>> 	this, but I am unable to find anywhere that will let me disable
> >>> 	(or enable) colour for a particular term type.  Sometimes I'm on
> >>> 	an xterm, for which this is GREAT.  Sometimes I'm on a Wyse WY60,
> >>> 	for which this is sub-optimal.  My workaround is to disable colour
> >>> 	completely, which is reluctantly acceptable, but it would be nice
> >>> 	to say "If I'm on an xterm/aterm/urxvt/ansi terminal, enable
> >>> 	colour or cursor-positioning, otherwise shut it off."  If this
> >>> 	seems too much of a one-off to handle, fine, but most things that
> >>> 	talk fancy to screens are kind enough to allow an opt-out based on
> >>> 	terminal type. :)
> >>
> >> Git doesn't have any kind of list of terminals, beyond knowing that
> >> "dumb" should disable auto-color. It's possible we could expand that
> >> if there are known terminals that don't understand ANSI colors. I'm a
> >> bit wary of having a laundry list of obscure terminals, though.
> >>
> >> If we built against ncurses or some other terminfo-aware library we
> >> could outsource that, but that would be a new dependency. I'm hesitant
> >> to do that even as an optional dependency given the bang-for-the-buck
> >> (and certainly making it require would be right out).
> >
> >I was wondering if Gray Wolf can run screen on the Wyse, and then wouldn't git see TERM=screen which is pretty much ANSI if I am
> not
> >mistaken ;-)?
> 
> Would something like switch in .gitconfig make a difference? Like core.colourize=false. There are situations where SSH sessions come
> in from automation, like Jenkins and Travis, which sets term to something other than dumb by default. Coloring makes a mess of the
> output. The ability to turn off colouring off by user might be helpful.
> 
> -Randall
> 

That already exists: `color.ui`:

> This variable determines the default value for variables such as
> color.diff and color.grep that control the use of color per command
> family.
> [..]
> Set it to false or never if you prefer Git commands not to use color
> unless enabled explicitly with some other configuration or the --color
> option.

Kevin
