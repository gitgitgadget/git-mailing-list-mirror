Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B7C91F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeCZVbk (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:31:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:37245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCZVbj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:31:39 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LejNC-1eDkYS127C-00qR7V; Mon, 26
 Mar 2018 23:31:34 +0200
Date:   Mon, 26 Mar 2018 23:31:33 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Dan Jacques <dnj@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 0/2] Add Windows support to the new RUNTIME_PREFIX design
In-Reply-To: <20180325205120.17730-1-dnj@google.com>
Message-ID: <nycvar.QRO.7.76.6.1803262331040.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180325205120.17730-1-dnj@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hABmRmdOnmehBf2+DnUf6BxU9Qdly9MYDA6NquzbmjBqFDUUuti
 8Fwn3GIwEwDZ7leCjatx/mFHfLi3h56beoceWH9InmzjscW6K3d5oFUHcHKjDEzYD1+gMIK
 u2WTl1rjwNIsbB/ximPJ2EZ1xACXvB+yRT9z61OykJWE1NLfo7c5mnFVeHcke3PuYcT5R9C
 OC0VwDORKmDwuLQIDKPtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yQmKoC//RdY=:kRtcYAbYjq+Mut16YLDMQv
 M/nuBzSRW++wyW7Xsu0/pesUxTXc5BWaOkAtfhrMhFiiwjBmNn1D1IGGUvlQZ/UqfDWe8jcR5
 YPHUNxAukMuJKZdz4VO26g9t3Uj9K2y0bfTLj4hsiRspDEywjOpvXsPvlZc+hHucdG0fj/e8X
 ZBIPNX8htrG544ZZzqjfoHeld1chw5622NSKxfNjUbmGjgEB3+jFScbTbzvuDjiYuXPQvYzOy
 ZHroM7rCvUP3dKfbRjQHqZZC4RYJwFdgsPtdc/B5OgLetvfOt+ViTEgAsZVwvnelUxRzDLRxa
 tDjd43xymqlAnTGxhkX87jmk+Ne/628YVxW5sKdaDgOYih7PP+lHw0rLrTg+PvOQh+jm1T9PT
 KQq5YvuT85/e7sDejCNaWN+iG/HKsleav+13k7AXdGFeLwZg5v6on8QpcHLulljJyrYj45z+n
 aEb2hY6A7leuOYKC9f8WeQu/GbbDoIntZwkExWrEuj23QOiSpweyd9y7WWbn/csLvcEdraPTL
 eGTKx+x2X+z96luR43h//LWzE14AQKxuIvxF2sgGPYHqJwcH2WudjMMgkyPGUZjbu9KyLk9FF
 wvI1j3GerAGwLBqdzAbSeixhBV/TZ/i6OPGU1nNTj7eRq1QrOcwbBpfKT3llnyVuRDglga6b/
 I9mdtu9bQVzGHqQEEEA/Mb2DxGySoWYbcV0k6LERySTtItFxHRtdrlXiyWe6OcRMmnxGnz7P2
 tT0JK4LrclDs/nxHMqTMOwNOtfhdcjnN3JhYdLM7kzhIQjN6eTkI4HNoX+M+d9VFouEGPYxkH
 dG/9NOE34uBoweN1HcoNTHPESW7oxzLtsk7ZMFF1iMUsHHRU0fVSrlJFaXvcL4BopJ70Dx4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even if the RUNTIME_PREFIX feature originates from Git for Windows, the
current patch series is different enough in its design that it leaves the
Windows-specific RUNTIME_PREFIX handling in place: On Windows, we still
have to override argv[0] with the absolute path of the current `git`
executable.

Let's just port the Windows-specific code over to the new design and get
rid of that argv[0] overwriting.

This also partially addresses a very obscure problem reported on the Git
for Windows bug tracker, where misspelling a builtin command using a
creative mIxEd-CaSe version could lead to an infinite ping-pong between
git.exe and Git for Windows' "Git wrapper" (that we use in place of
copies when on a file system without hard-links, most notably FAT).

Dan, I would be delighted if you could adopt these patches into your patch
series.

Johannes Schindelin (2):
  exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
  mingw/msvc: use the new-style RUNTIME_PREFIX helper

 Makefile         |  8 ++++++++
 compat/mingw.c   |  5 ++---
 config.mak.uname |  2 ++
 exec_cmd.c       | 22 ++++++++++++++++++++++
 4 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.7.4

