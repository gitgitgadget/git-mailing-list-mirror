Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1681F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 18:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753666AbdKJSvd (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:51:33 -0500
Received: from avasout04.plus.net ([212.159.14.19]:42747 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753566AbdKJSvc (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 13:51:32 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id DEOneCopGzbmWDEOoe4tKf; Fri, 10 Nov 2017 18:51:30 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8 a=rnfx8Af4Ce3DLWxXZc0A:9
 a=2ql6NW3GjeEi1Nc2:21 a=HqnyEsLZIc-5_uaW:21 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/9] commit: move empty message checks to libgit
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171110110949.328-1-phillip.wood@talktalk.net>
 <20171110110949.328-3-phillip.wood@talktalk.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <dbdb4990-e539-42d5-df0a-3d5f4a993faf@ramsayjones.plus.com>
Date:   Fri, 10 Nov 2017 18:51:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171110110949.328-3-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCNDFxNp4OLGAqCdvSqfo9jVv9lulczkY1nLVDjGJJM/u+fa4T+FDv+Y/kwvLUnikPG2/7nBBH7VKigy/SoTibEASydl2gRSdXnR9Pvs//AURpcY1rrn
 o73cX0AM7lPl2qeaTJ5YGSL8TO+s8hYMYTvNF3EIakvm+q5l4Pt9hxlvNB3ok4HlFxO827YfDw9PsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/11/17 11:09, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Move the functions that check for empty messages from bulitin/commit.c
> to sequencer.c so they can be shared with other commands. The
> functions are refactored to take an explicit cleanup mode and template
> filename passed by the caller.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> 
> Notes:
>     changes since v1:
>      - prefix cleanup_mode enum and constants with commit_msg_
> 
>  builtin/commit.c | 99 +++++++++++---------------------------------------------
>  sequencer.c      | 61 ++++++++++++++++++++++++++++++++++
>  sequencer.h      | 11 +++++++
>  3 files changed, 91 insertions(+), 80 deletions(-)
> 

Just an idle thought - why are these functions moving to
sequencer.[ch] rather than commit[.ch]?

Similar comments for other patches in the series which moves
code from builtin/commit.c to sequencer.[ch].

ATB,
Ramsay Jones


