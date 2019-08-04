Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 279E51F731
	for <e@80x24.org>; Sun,  4 Aug 2019 19:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfHDTKm (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 15:10:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:37895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfHDTKm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 15:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564945826;
        bh=t4ZptpMXID9+WTRL0GZ5zMftTZV5d97rkQcYAnF2Gek=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KPHXHepglR5POq2HZqxgrTHL+XoTFvtU4BInqJ51qftQgzpijao1z0uD++Ss9idIe
         6RFA5G4anCjiBlZ5/aQEOzGwiYI18IQJKrMn+wHhFWJizxnPipyMs0QwKVfanM2yrV
         QVgqywgoGlMN9271nfVp1uLwbVKDKHi55s9JrPPc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LikE1-1iUUvv2dbB-00cwC4; Sun, 04
 Aug 2019 21:10:26 +0200
Date:   Sun, 4 Aug 2019 21:10:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Mark Levedahl <mlevedahl@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
In-Reply-To: <1489be05-ab18-a3e5-dd38-3d5729ebe67a@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1908042058340.46@tvgsbejvaqbjf.bet>
References: <20190728151726.9188-1-me@yadavpratyush.com> <20190728213634.GB162590@genre.crustytoothpaste.net> <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com> <20190728224943.GC162590@genre.crustytoothpaste.net> <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
 <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com> <nycvar.QRO.7.76.6.1907312132190.21907@tvgsbejvaqbjf.bet> <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com> <nycvar.QRO.7.76.6.1908021414530.46@tvgsbejvaqbjf.bet> <a68f09be-949f-b16b-a585-9ca2a1991a4f@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1908032225510.46@tvgsbejvaqbjf.bet> <1489be05-ab18-a3e5-dd38-3d5729ebe67a@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fXXjvBbLNOlq+/b+mRCe2LXYVSGKLe6ndeDnXhS2l1DanuJpSvh
 4CyeHXU2a5uL0mh85c+n4lgqZnPZd02CqadIGEyUVMDNfpPE/x7uUD/FN1Hu3X63qD4SJG6
 tWVJsQ0PfT6HUGM+ScTCHqLygu0PHu+bCVs31dEJ63vNxHslPwiZaBBwJLTRP62ua8w9awu
 uYoP8A3S0gMxmatbQByxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eDZL/l9Ry/o=:KRRQ6eLadwO2NkrRMFLBki
 JitmUlcQzYHTbCYQRcEOugRyFRqOLujV/AX+jGiMVpxY10vIwC4t1UfsXOGCJg6P76R/Y2/Qe
 EpT0dhWIlWLzeyrm0xqLvT9Ulcc8ezAcqBgm61SiJfGRQyL0iCExK4fwHICENxvpydD0HlSo8
 JTR5fr9bUmA0VQBnGPwcDVRpuRlZAQSmlPn8JkWYF2dRNrWRNVfRtqfZl+4WNMXF7Z/mfJd2K
 X+ictta/M9xetfBlPkFgw30Pzl07D//L0YE3WHKeQBWbAISUONrkKY7vL9YVRAOIGy0t6qNJJ
 rJZG9T+7iIizutThoFwDIQqsPT5BJFYNSQuID263RedoDJeFhOtPGM0bU1VjD/4yLrjdGz43c
 HzO9ZsQufDPD/RRY0VCyUdQx0N8CbITr9APysms4JrLjk7zkEQsE6TYBYwVv/Es3jXNf8SsIx
 VLuUc434/BZ5eSFfmRM2/OYmAR7qs23/x0BCmmmfd9d+oAIbK75yDGIcBpvkN2LPBWjMKDQpG
 bkw6pRzD9WIQusoltwV1WVx0etwsNej9TKVrh38giJSNZFO+UPEF2g5rlmDJLNoE2P8ljC59Z
 hYsAApPP6JC7xxZUe5idvTvSQPhnKunr2pEsZOrN6oAWPY6tBSQfPxcRtgm6MmhFN0xhhTkAt
 ieCABcbOS3OanlLovX5JWBv0giw/r3vh25oTvVLcOfgw0Fj8K5xaG7AdK3MtcgMaVGviWkULv
 GlJRXMTyqSM+B7SamJlS4kn2GCY8oCBeyz1V2+EHesFuYYWkiF6h5SksRmWgUgmeDXGaVbfIF
 Uf2hH7wzGGdoig5mMGKXjxNeWzSPvV7cYhs6Z/OW86wQiUF+ctrI8vOSLy+KjMPNrnmuSEhQG
 cYeBn3m1TlK/DDOv0EwEiZeasgAhCrg91gQ00+MlwiAD5pHthgUyFc7sZGNrNn24pb6i+MnvZ
 Xg70wHAsP+KGXS0aLoOUzO3eRbNA3ZQdIpEr41H1Z60JheUgsQNdf3A4Z0iHpPwihHOhIco11
 xj81Vr/BEmi4ZU+cr3xVzYriXMpvRxNxI3ogNVuFQ8SH8Ckq8//SWQ4GqYQDoFtB4+d83lh3/
 E+tGDT1Wt4uTHfIEqiJ0U6rRtsFHjeKO0nA1ijV3g1n1H2tJgkSTlEcOtK2iQZe1SmQtMkgTY
 siAiU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 4 Aug 2019, Pratyush Yadav wrote:

> On 8/4/19 2:04 AM, Johannes Schindelin wrote:
> >
> > On Sat, 3 Aug 2019, Pratyush Yadav wrote:
> >
> > > On 8/2/19 6:09 PM, Johannes Schindelin wrote:
> > > >
> > > > On Fri, 2 Aug 2019, Pratyush Yadav wrote:
> > > >
> > > > > On 8/1/19 1:12 AM, Johannes Schindelin wrote:
> > > > > >
> > > > > > I would be _extremely_ cautious to base an argument on one
> > > > > > particular setup, using on particular hardware with one
> > > > > > particular OS and one particular repository.
> > > > > >
> > > > >
> > > > > Agreed. That's why I asked for benchmarks from other people.
> > > > > Unfortunately, no one replied.
> > > >
> > > > What stops _you_ from performing more tests yourself? There are
> > > > tons of real-world repositories out there, we even talk about
> > > > options for large repositories to test with in Git for Windows'
> > > > Contributing Guidelines:
> > > > https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md=
#performance-tests
> > >
> > > I thought the point was to not base all data off a single setup?
> >
> > You misunderstood what I was saying: a single setup is bad, and you
> > can make it moderately better by testing _at least_ with a
> > moderately-sized repository [*1*] in addition to git.git.
> >
> > So yes, it would still not be enough to test with, say, the git.git
> > _and_ the Chromium repository _only_ on your setup, but if not even
> > you can be bothered to test with more than one small repository, how
> > can you possibly expect anybody else to add more testing?
>
> All right, I'll see what repos I can test.
>
> But my internet is pretty slow and unstable, so my clone of the
> Chromium repo failed mid-way multiple times. I assume we need to test
> on a large index, so is it all right if I use
> t/perf/repos/many-files.sh to artificially generate a large repo?

Why do you ask me for permission to just try this? I feel very
uncomfortable being put in such a position: I am not your manager or
gate-keeper or anything.

> > > [...]
> > > > I wonder, however, whether you can think of a better method to
> > > > figure out when to auto-refresh. Focus seems to be a low-hanging
> > > > fruit, but as you noticed it is not very accurate. Maybe if you
> > > > combine it with a timeout? Or maybe you can detect idle time in
> > > > Tcl/Tk?
> > >
> > > Hm, I don't see a better alternative than file system watches.
> > > Timeouts are a heuristic that can potentially be problematic.
> >
> > Let me stress the fact that I suggested a timeout _in addition_ to the
> > focus event?
>
> Oh, my bad. I thought you suggested using timeouts exclusively.
>
> But I'm not sure I understand what you mean by "using timeouts in additi=
on to
> the focus event". My guess is that you mean we should activate a
> refresh-on-focus-in only after git-gui has been out of focus for a certa=
in
> amount of time. Is my guess correct?

I am _not_ telling you what strategy you should use. You really need to
come up with hypotheses about what tell-tales for committable outside
changes could be easy to detect. This is your patch, and your project.

My suggestion about a time-out was to think a bit further than just mere
Tk-provided events to detect whether the user might have changed
anything outside of Git GUI that might make an automatic refresh
convenient for the user.

I do _not_ want to engage in this project, it is not my pet peeve.

> > Yes, using a timeout on its own is stupidly problematic. That's why I
> > did not suggest that.
> >
> > > If you do a refresh too frequently, you hog up the user's resources
> > > for little benefit.
> >
> > Indeed. You want to find a heuristic that catches most of the cases
> > where files were changed, while at the same time not even _trying_ to
> > refresh automatically when probably nothing changed.
>
> Like I said before, the best way of doing that that I can see is file sy=
stem
> watches.

That's not a heuristic.

A file system monitor is doing a lot of work in this case, for dubitable
benefit.

Take for example git.git: Let's say that I run a specific test. It
creates a directory under `t/`: the filesystem monitor triggers. It
creates a repository in that directory: the filesystem monitor triggers
_multiple times_. The test then performs all kinds of I/O, eventually
removing the directory when all tests passed.

Note that none of these filesystem changes correspond to anything that
would update _anything in Git GUI during a refresh.

Of course, this is something I did not mention before because I took it
for granted that you would always try to weigh the benefits of your
approach to the worst possible unintended consequences.

> But maybe we can get reasonable performance with a combination of
> timeouts and focus events.

Please note that I would not be surprised if this heuristic _also_
resulted in a lot of bad, unintended consequences. That's for you to
find out.

> > Footnote *1*: I don't expect you to test with the largest repositories=
,
> > as you are unlikely to have access to anything approaching the size of
> > the largest Git repository on the planet:
> > https://devblogs.microsoft.com/bharry/the-largest-git-repo-on-the-plan=
et/
> >
>
> Ah yes, I read about it a while back on Reddit. Having a huge monolithic=
 repo
> sounds backwards to me. Using submodules sounds like a better idea, but =
who am
> I to judge. They probably have their reasons that I'm not aware of.

This statement just sounds to me as if you never have used submodules in
any serious way. My experience is that software developers who tried to
use submodules offer opinions that read very differently from that
paragraph.

Strong opinions usually do not survive contact with open-minded exposure
to reality.

Ciao,
Johannes
