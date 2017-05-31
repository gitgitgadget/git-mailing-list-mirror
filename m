Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3BC71FD09
	for <e@80x24.org>; Wed, 31 May 2017 17:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdEaRvo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 13:51:44 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35176 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdEaRvm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 13:51:42 -0400
Received: by mail-it0-f51.google.com with SMTP id f72so17497420ite.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VHzQWQZ1cU0BxsPeVKeQZr9oquBfDKV6+717Vxwv8F4=;
        b=qKcXbVZ4ApGaWJCyFLhefK7NjPoPVrf1Y2w5SQAGhHeyPFv6fB+1qCnVPG/vCiz45b
         lACer4Z1vjqdZYXHOTgwVSmhZOjNNz2KyhfdUfj/4k0etPEMebY35QiYy6Ktq29sAAvr
         nb5A6pSW/dFiXbpJ1aV0nWe6Y+Ns2bSFAoKAGc48kthqDdJRUsmIRB9qao4li+ldkwer
         8uMRPYGNB4a7EvaK/v28UQgNDoc6WWt6wQ4D+DYEzLiXqfD0k1dpPY7O8QkFt6CM0Gph
         q2JPjB70X1J91543RdvcNxOGWVfQZu1iGyJbVO8BPo4U3l/nIaQ2/MzWq+aQ/owx80JD
         xmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VHzQWQZ1cU0BxsPeVKeQZr9oquBfDKV6+717Vxwv8F4=;
        b=bK+mTP16HrOGdewRtyHsBoHtC+zTEjn1IvjeOVcMrQ7IscY6kvJDy7z/aFSiC5w70J
         ZKaSM0DOQrlbDdudi8lZxKqULdYrOxCZPNv+bRBAcOvOo7hv7NBjlQI4s40ux0CedsS7
         s5tDCuLNSCTSRanideJVU6O95J3R2q4F1+JxSnnZNraBF9nAtdFmHyn3slBHTXTZ3v0b
         GXXnIOzy1hGofeccKJcLDk8xoSYUcaHqGw2wmOr3NCerfntVoEiw05UbMqu4AagOk+Sd
         BBlJZMtCIW0tQPbvFurhwkak1fCv4+Jv+KX5/GdfamT1B5v2NVl/qTAZMfESRANYz5+/
         6PVg==
X-Gm-Message-State: AODbwcCoTo0h/Hl4CjWTd9eAf7YoRR22nKE+iRf80gkEo2BdrAU2o7z2
        6cp+tgDtL97YaikSAfsHiHJ0yNB6xA==
X-Received: by 10.36.138.131 with SMTP id v125mr8449158itd.66.1496253101302;
 Wed, 31 May 2017 10:51:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 31 May 2017 10:51:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705311744170.3610@virtualbox>
References: <20170530051742.3j3yn3ipfmyrrteu@sigill.intra.peff.net>
 <20170530204553.25968-1-avarab@gmail.com> <20170530210530.o5gbz2k24wxrfner@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1705311726110.3610@virtualbox> <20170531153123.atl45b3kbfmqhnta@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1705311744170.3610@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 31 May 2017 19:51:20 +0200
Message-ID: <CACBZZX4NkCgXZaz2+d6SN2ZL_zoh_i3fdwLZdinPNki+hU5ZOg@mail.gmail.com>
Subject: Re: [PATCH 6.5?/8] version: move --build-options to a test helper
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 5:46 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Peff,
>
> On Wed, 31 May 2017, Jeff King wrote:
>
>> On Wed, May 31, 2017 at 05:27:21PM +0200, Johannes Schindelin wrote:
>>
>> > > My intent in putting it into the actual git binary was that it could
>> > > also be useful for collecting build-time knobs from users (who may be
>> > > using a binary package). Like:
>> > >
>> > >   http://public-inbox.org/git/20160712035719.GA30281@sigill.intra.peff.net/
>> > >
>> > > We haven't filled in that NEEDSWORK yet, but I'd rather see us go in
>> > > that direction than remove the option entirely.
>> >
>> > FWIW it also helped Git for Windows.
>> >
>> > The two additional bits we added to the build options (the commit from
>> > which Git was built and the architecture) did not hurt one bit, either.
>> >
>> > In other words, it would make my life a lot harder if --build-options were
>> > moved to a test helper that does not ship with the end product.
>>
>> Cool, I'm glad it has helped already. If you have further bits added to
>> the output, is it worth sending that patch upstream?
>
> Yes, of course.
>
> The day only has 24h though and I am still stuck with other things I try
> to contribute that seem to be requiring a lot more effort (mostly trying
> to make my case that there are certain coding paradigms I find too sloppy
> to put my name on) from my side to get accepted than I'd like.
>
> So yeah, as soon as the queue drains a bit more, I have tons more patches
> ready to go upstream.

Thanks both. It makes sense to discard this patch.

I wasn't sure whether anyone really cared about this, and thought a
patch was a better starting point of discussion.
