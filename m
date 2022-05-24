Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C4C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 16:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbiEXQAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbiEXQAO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 12:00:14 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB99AE6B
        for <git@vger.kernel.org>; Tue, 24 May 2022 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1653407997;
        bh=6Ra2q8YijfGhI/mMoUKoH/FHQiKskTxQYXIhiGVsuw4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MNzJW10de5zis5BywmDn7BdrkVRYBIgWi315hmoeL66yStagG7v0GV+53rUZYTDHW
         qcDvRIadYVC6SY1CJ+nylp+1Q5Vzg084ryAZdn/PJdILpdpmR362n22P5yruYJ6zbt
         FtA7ONgdmc+NZ/5VaYK4IGHSDQ2Lq16jjRF/4HfM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mo6Jl-1nVo6I0UkV-00pM2f; Tue, 24
 May 2022 17:59:57 +0200
Message-ID: <972c3c82-0c10-ee95-9a7f-082de02a49c0@web.de>
Date:   Tue, 24 May 2022 17:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] nedmalloc: avoid new compile error
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
 <8963c6fa625bbaf5153990939ea06742304ddcd2.1653351786.git.gitgitgadget@gmail.com>
 <220524.86bkvnxsm5.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220524.86bkvnxsm5.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MQQOR5E7iIts9lGOrB2fOvx7bz8RJSdHd93+zlGgXr3VEzi8rcM
 BxI/8/eS4xed781fzItw3V+29KkdOHMD9NQj+cKbpIKbqP4esoq8aWGX1gIPHNi6xh8A6lu
 vV1KmbsZj+O7R/SeM5acwhgy4JymxCkLI/9PtPSKfOfgByeauc/opP8L7RVP9hUtKrhRjR0
 J91hNX80n98I0cg0CNRzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YfAR8Gp+wno=:aQE++NmZxl9zFqeQG0/vVr
 wOiQkvEPv2cmmifPMdpspyLELeLmagkhP80aNLHOtBlSGF5Ne4JpptAlTnsMC3kZGbULkBvtR
 26yuxN5HSnpsNl/4HNyIhRZ9xBT7VcA2igz5y89qdZpNV3bgDRzAKTGABHlxdtn8t25GP4nBH
 Im296mjAHsjKrmQxuDAtiZ+tJLL1BiZE80BDPq6wAPWFmElNw9Xhq8F7de3RGm5TwjUUj29rv
 wbPFXwiYMb8iO2NbgLuJ5IqfNZ+HUeHpwqiGstkHYndwFO0XM+ANgDFDCTOQ/r2s1vvqdxOSM
 LVxLgeK2MBIsrLvtXlzRv4oF/wZkhS6j2GMhFa5ThPnpYxbRiw2pfLSSR9vX0rdMf5hY+xXBM
 UTOc67iphXP5xTMmRInOrnQocZ4L+9FGzTH98yvN0suuNtDdu0yn/5Jvz4sYqrRMXzEi7Cidr
 /Vx8Gjqdn2dpidb90cE8qWtw824FLObKbmaKSR/H+q061c38/rOFqjuULDaN5WFiOJ5pyv2x6
 F+iRnGGigYWOpHS9tzy15fLy8SkaLyFkbJG1Hx9K4wcINe8zfoxGWUD94wN38HIeHwzOu7GbU
 MaLh+iBQa0d1CYhVWXrW1WO68fQZHEWO8vVSF5f3pGZD0M53SjOF6yWDGJpHic8pJEzkKJjwc
 hRR0dvWchjobnt3XtzGSJbZTjpX75lLovltJl/EODEpEMuD10m1A/aJn/hTWxPm74w16YUnCW
 gGtL6xLkEIMh5ygJORVRvRL42yELGFZYpTRAeQ1yc2N19G6g52+WpmqJlL5Z8zK8DhxLeiYyP
 NQuk9RybmgTJdyXUZjDhxfla0e3fGAkAcMtKNVQte4535sG4UweACo0ZkQxlRwcGAs4ztqvgm
 ypTWn3WL9d2Lq4rDEaPrDHEB8GQXXEPaJonBpzMILJRJRrsoDlx3hVuNuceghL7dVoTRVx8gK
 vgLWld9EjT7RaQCD+d26MoxEnjUSI4HFxHxP0GnjiIWefeqZj8YEbOHz5gQFRR7yui6Iway4Q
 csmFchuUZ/dSKsiqHMVjoO+3MVer38a5DA+OMAyji710q0390pE7xVdCjQlBfoYjaFj7bwLDj
 oAWTUKYif7s0twryVTFfvIcqm5BtNRdV0SA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.05.22 um 10:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> This seems sensible, I thought "why not submit it to upstream",
> i.e. see:
> https://github.com/ned14/nedmalloc/blob/master/nedmalloc.c#L1298
>
> But that repository was last updated in 2014, I wonder if it's just
> because nobody's submitted a patch since then, or if it's inactive. Have
> you tried making Njall Douglas (the nedmalloc author) aware of this
> issue?
>

https://github.com/ned14/nedmalloc says at the top: "This repository has
been archived by the owner. It is now read-only.".

Ren=C3=A9
