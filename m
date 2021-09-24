Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED19C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DA9610F7
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhIXX6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 19:58:47 -0400
Received: from [50.213.99.139] ([50.213.99.139]:65519 "EHLO eddie.starwolf.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhIXX6r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 19:58:47 -0400
Received: by eddie.starwolf.com (Postfix, from userid 118)
        id 158BC55AB; Fri, 24 Sep 2021 18:01:13 -0700 (PDT)
Received: from [172.21.12.13] (topaz.middle-earth.starwolf.com [172.21.12.13])
        by eddie.starwolf.com (Postfix) with ESMTP id 0397455AB;
        Fri, 24 Sep 2021 18:01:11 -0700 (PDT)
Subject: Re: ANSI sequences produced on non-ANSI terminal
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20210923052122.2F655CE@eddie.starwolf.com>
 <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
From:   Greywolf <greywolf@starwolf.com>
Message-ID: <592a799b-0d16-1615-4737-3c634d029d7f@starwolf.com>
Date:   Fri, 24 Sep 2021 16:57:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings and thank you ALL for your responses!

On 9/23/2021 14:20, Jeff King wrote:

> Git doesn't have any kind of list of terminals, beyond knowing that "dumb"
> should disable auto-color. It's possible we could expand that if there are
> known terminals that don't understand ANSI colors. I'm a bit wary of having
> a laundry list of obscure terminals, though.

Oh, gods, I wouldn't have that at all!  No, I just want it NOT to spit out
not only the colour codes, but the cursor positioning codes as it seems
wont to do when I do a fetch.  I'm more than happy to turn coloring off
(conditional on TERM would be a bonus, however it's done) on my own;
in fact, I have done so, but the fetch/pull still seem to be messing up
my screen, with color turned off (unless I'm not turning it off
*enough*, which is entirely possible).

> If we built against ncurses or some other terminfo-aware library we could
> outsource that, but that would be a new dependency. I'm hesitant to do that
> even as an optional dependency given the bang-for-the-buck (and certainly
> making it require would be right out).

Well understood.  Also, not asking for people to jump thru flaming hoops.
Just trying to figure out how to get git to stop assuming things.
(as stated, I am aware it could be my fault for not setting variables
properly all the way).

> Obviously you can wrap Git with a script to tweak the config based on the
> current setting of the $TERM variable. It would be nice if you could have
> conditional config for that. E.g., something like:
> 
> [includeIf "env:TERM==xterm"] path = gitconfig-color
> 
> That doesn't exist, but would fit in reasonably well with our other 
> conditional config options.

That is a consideration; and one I had not thought of.

> As far as generating non-ANSI codes, that's all Git knows how to do.

Just need to have it NOT generate ANSI codes, if requested.  I'm certainly
not requesting the world of terminals to be incorporated -- just some
universal readability.

As far as the suggestion to use "screen", I'm not going to be starting up
a screen session every time I log in. :)

				Thank you all very much!

				--*greywolf;
