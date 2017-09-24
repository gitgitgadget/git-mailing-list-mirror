Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683072047F
	for <e@80x24.org>; Sun, 24 Sep 2017 12:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbdIXMjz (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 08:39:55 -0400
Received: from mout.web.de ([212.227.15.14]:59034 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752020AbdIXMjy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 08:39:54 -0400
Received: from [192.168.178.36] ([91.20.61.209]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGzFy-1e8jG91UW2-00DpCm; Sun, 24
 Sep 2017 14:39:43 +0200
Subject: Re: [PATCH 1/3] refs: make sha1 output parameter of
 refs_resolve_ref_unsafe() optional
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
 <xmqq60c8j38t.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <047033a6-1e3d-103e-a406-cc89447f4327@web.de>
Date:   Sun, 24 Sep 2017 14:39:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq60c8j38t.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:NOG/9L1NyC5EjtKYGGxEKMW3iM57gIKr3qr2quIUAl8ch0TMDbm
 9a4m6MKrF6O486Me3Ioaervxz+UwnAis9Y0xRSyPTD64gbtuxkqMgvaAeTkCHjilX1A3K8H
 RjQWPFVgk1W2ytQeYf3oWrpsssY0YC70W9flrCAn65zlvshIddImyP1aGR1ZgQV2luLcrIR
 h2nyedzs5IniwFmnYYBZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AekC98LBBVM=:c+xVBH/Z1DpMDjql9X4WjF
 DvYGWY+/oBkpp13Tuu2IEpruTWHCDPayJl/vaNV1lFLG6dUQTz2IlMsNNNYaJ2nPnhA99jECh
 kmXYwmKxVu9ssZZnllfbg0MiG+zVwNeDPKxRF386C8CoH8+69knPx8sWUEBk4269QLw+eDuvN
 gHUejf2MuNm8iVkCzreR98+JPeY1sugT6IACNLtyW/3q/46wMXpC3OK0L7SZF2kiClWhQmN20
 RBumpd/nW04VpKYlGjVu5GL4j8lVYPgYYvSdl7oyJdsUiNrk6pnP7fbyYh1Thc0JUP9wa7QMd
 p27qhch97i91Oh5CMeKNNFIZKOdcV5sQwTR8E5+xgBG7iDxweltChxs29Z0i4Ll9FhgSTrHvG
 qMNnb6NdCVr44kJGcdzhXf+RW1SZV9x++UD7dTWJUb59NTFZc6UL/OIaq05svIg8m3bNhEk0T
 NCKpgV55F8WJnE2qcBFeg8gYdF6HNF988q7PGk2J/Lx/FnLMRCtxu9p4J5+5CxmzPJYw1oFmX
 ReS+/vVRuEvU+/Unqumgqu2PsK7IkIoNPGAzYx+9lV2YhWw44MISyzWTNeWvesU3M0vVJoQMA
 NF8B+PDfbhaFs+cwyn3NrzF/f3NpFONM7MAbOQ79qnLcqtanWssLY4vKvFuwpXDnFgw4bF7B9
 /8WQztwVsm92dLGPgg+8EDnfHjNm/1yyxRohFj/wQcDFAfi6sCgUQjHPNDVsMd0uaXwMbYzd1
 G+3Zx/DArL3r7ABbtoNQedHSXND1MPhyHBWIyVFzhRJAINnu/eYpaYt/dYtvPZNMGxDfv4ygi
 agvFv93t5gtBZMYJfLMMsIBTdkfSAii/ZEn0Q3gQcQB521SeZc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.09.2017 um 03:26 schrieb Junio C Hamano:
> I wonder if we want a dedicated helper for them (perhaps about a
> dozen callers we have that fall into this pattern?) to call for the
> exact purpose, implemented as a thin-wrapper around the
> resolve_ref_unsafe() function, though.

refs_resolve_ref_unsafe() effectively has seven wrappers already:

	resolve_ref_unsafe()
	refs_resolve_refdup()
	resolve_refdup()
	refs_read_ref_full()
	read_ref_full()
	read_ref()

	ref_exists()

The last one already supplies a dummy SHA1 buffer; for a handful of
the others we could add and use variants that do the same.  I feel
that this API would become a bit crowded, though.

René
