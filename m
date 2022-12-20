Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F472C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 23:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiLTXMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 18:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiLTXMO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 18:12:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4591B9EC
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 15:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671577917; bh=gn0wby/xyk+eqFDbQejYoTmPzRJPlksTRl2SHySJhKU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=uYqvUx8vcPbyTgM0TFgYQjWVAMf31LCYMq3uK2aCjoUTVkBwqfMjEhWNheqy4RmY/
         cV5oKfyeWOG8k7zyKklDM+ijwSaAN8hNpsd8O3VRrYPoLqsNTMVzPIOY2wRMYj49ud
         4+Rt10cfJrsgAQQDmhoHmExRn4tsaYtnn7Qi8ftLNCZdi4+k/Lnfg2AiyJovW6FkM7
         j3v2t9zxjSdDOgb63oGR1HAPTg9BE170h9nmVSqJQQ5CSNak5879SOEFriJxsdyoXF
         qskawl/v5ml3OavYV9BGyUBsE2ZVhvgJXb7ylkEUaqCgYU/LvF1g7B5JJakSHEkgEG
         mn22MvpOoUGnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.64.45] ([89.1.213.120]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNh7-1ogAJn3KtL-00hwGf; Wed, 21
 Dec 2022 00:11:56 +0100
Date:   Wed, 21 Dec 2022 00:11:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta <edecosta@mathworks.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #03; Mon, 10)
In-Reply-To: <Y0Vq3iGifYeBxPbn@coredump.intra.peff.net>
Message-ID: <92cc457a-d267-d20f-b516-295646b989ca@gmx.de>
References: <xmqqlepnz1vu.fsf@gitster.g> <Y0S7/jA5tNeoQ2Hm@coredump.intra.peff.net> <xmqqczazx7dn.fsf@gitster.g> <Y0Vq3iGifYeBxPbn@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pYPbfqj/4CuEdzsPveoyvS42CnoK3bJT/GeaIJnL/HvTHW4mgNG
 Z2uaaSdDBbNSS/bQk1exX2WFJqgfxi61WLJIKUC4k6KdM1fUxAxZ+3+Or/kpGuiT5RDws4W
 AWa+STu24lwiCAAIB6jZkqb/AAjTq2YHpUfEz5hGmiiCY/rhXl0Bv1XThIt3IyeMIDsh92+
 fzwhks149l7DMFLo5e5Ww==
UI-OutboundReport: notjunk:1;M01:P0:B3ZTWBKbHxY=;uiYeu5Di/CMvc2G8K4RyJxgRCqd
 nz3l0ersCmSHeB5DUeaPeMA5ZbrOrAXd84G8cHn701s5X+gz40afsRFVrSM3K1RI4QOLZ1ShM
 951MLsmSzsJ968ofZf62YnoSMg/01+yZLXg/glf1GKNfCDwe2bfmxHPixJOXYS2fg3kDlACrs
 1pZ3O6AbybQ0eCiDQ/327dsS3T7nV+YZ6lSnDyo16Zwnq/mntR7eeEP+JJz5BBCYwP7jN4G5X
 U6LWYhO+vGRy2oyYmZPHZ+VGQq4GOcqF0qmF3YNgMSoVuPxhSC8dtbyMqb0A7QQwzMD2VCnKJ
 Br+S2SIDkl97fT2D1pLUy0NKXJ72ZI0kUIlBSMopkiek2LGAQLvcyE9bgfqiz/2BxY4YDaBhz
 AoKxi59d7+7rJiPlnOG5uIG29yZCTk+b+Be5YTagIWGovvtqy4sRO/6EOVotXdT3HlGv5Qzj7
 06umfby6tfx7XeZi3qJpIPQVihUosulT6E9ooj28xUjHMog0hKKzO3+dW59z6gVddf2JQhqs7
 iMn4caGA9NYxlIa/qgp3UYob/Vvn0JQTUTR0Q6+RIlYfaXBv5RITenvUwv0sba7mQS+5F80S+
 OkC9u6QvVXkxOE4jPa++H/uykOgxC2AQFs25J2DzZFJq8EVOGfyItnJqtpQ/qjsULyBPtzjDi
 K6RjuJFB8/TKXZWKs8YgMyd8GiwQd+ZuVerKR9g+BoQ3qyhV5rrcDGiLKHXd2z/8CjkHPfol9
 7nPFk5tNSRQGE4YdFBumINMhcq3fGkQo74jP08/Psyp17CQNrnvsnhNCNtbMsWxd5eAp9QZUi
 4aPYul16dRMkwpDRSGNA9iBTLk0TW6Pw6gLctyHKcNgzgJ8+qTWyB6uKw56nJm5cA8+ppxTf/
 Z5XozGIpVBV23TDrKAFzWYdrERlukUakV/dznYmzZer32U2b5oPhKTUhDK0bBc4dTWS0yFFYf
 KlVHnQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 11 Oct 2022, Jeff King wrote:

> On Mon, Oct 10, 2022 at 10:21:40PM -0700, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > There's a tiny leak in this one. Here's a fix that can go on top.
> > >
> > > -- >8 --
> > > Subject: [PATCH] fsmonitor: fix leak of warning message
> > >
> > > The fsm_settings__get_incompatible_msg() function returns an allocat=
ed
> > > string.  So we can't pass its result directly to warning(); we must =
hold
> > > on to the pointer and free it to avoid a leak.
> > >
> > > The leak here is small and fixed size, but Coverity complained, and
> > > presumably SANITIZE=3Dleaks would eventually.
> > >
> > > Signed-off-by: Jeff King <peff@peff.net>
> > > ---
> > >  fsmonitor.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > Is there anybody else who is reading Coverity reports, I wonder.
> > This one is a clear positive.
>
> I doubt it.

As I mentioned to you previously (e.g. in
https://lore.kernel.org/git/3896n74p-0r16-866o-r668-70q6pos078n9@tzk.qr/),
I do have a look at them, usually a closer look during the -rc phases.

> My personal fork still has the coverity github-action which I showed
> last year[1]. We could merge that, but giving access to the project is a
> minor pain. And of course the full list is full of false positives. One
> nice thing about coverity is that it marks each defect by date, and
> tells you how many new ones there are. So when I push up my
> next+personal branches build, I usually just skim over any new ones it
> reports. I'd say about 10% of them are actionable.

That 10% number does not match up with my experience.

In the v2.39.0-rc period, I looked through over a hundred new issues.
Pretty much all of them were strvec/strbuf false positives, and even the
remaining ones were not actionable. (I typically glance over leaks such as
the one you reported, in favor of focusing on bugs that may cause crashes
or other serious problems.)

I also recall that
https://lore.kernel.org/git/pull.1264.git.1655336146.gitgitgadget@gmail.co=
m/
was the result of more than 150 new alerts that I sifted through, with 11
actionable ones, some of which were later decided to be false positives
after all.

Ciao,
Johannes
