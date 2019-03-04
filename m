Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4151020248
	for <e@80x24.org>; Mon,  4 Mar 2019 11:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfCDLIy (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 06:08:54 -0500
Received: from mout.gmx.net ([212.227.15.15]:48911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbfCDLIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 06:08:53 -0500
Received: from [10.49.208.72] ([95.208.59.9]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1Fe4-1hGNZC0Nh2-00tDiV; Mon, 04
 Mar 2019 12:08:42 +0100
Date:   Mon, 4 Mar 2019 12:08:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
In-Reply-To: <20190303171951.GD23811@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903041206300.45@tvgsbejvaqbjf.bet>
References: <pull.130.git.gitgitgadget@gmail.com> <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com> <20190301213619.GA1518@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
 <20190303171951.GD23811@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qbBiI6LaS6rYqOt++J2UldEMnbfL93svekyscFbfTSuXOLXzYTE
 iUdSOMhaK5bLMXBnmwLup9165bX21kEcWl1WrbIccghvvZ1lU9PLt37oXC5/0RxPJKs7e2/
 qzxirIIhkE1VCGqbtueoIm6dwrqIxDOPMT8o/nF7FTVJV/r+NPZrvAY3aiEY6WmLZRNw4sw
 YCPBv89KoP2g7bW7Jlu0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XnUvYssrfdA=:Dw9kxfjZjcr/vjDC+LWVfM
 racmskg7olr8Y34ArcIycZLSK19coAMJHOdqpwfIh2CNQfyc3efUEsO0h5pLfBX/OcBSETUrQ
 3iHiUtGQdEuGeUCXmRA9MjcV55zhWCVZfz0VTeCwCNfjTnNUyiWkHJRecLa3pRJP25k1vxmks
 leKcS3wvnY4tIb2Ka4L/iPilui/kT44/gnn1nU7BLHuxMuQV0DeNVrFYrquYT3mJ0DrGzWbNJ
 SoA6iKejBPQSNJ1y2Dye4rwSJGXsFdTWrJ1njBE4DYNsshiO0axLKcSisGLQOMF+0L2y/9AHa
 MCiN1wxif/B2yRSjCeGRD44bpiWFDu9tcoBbPZnZhF7ig/eMNhl7hjm9HKV0mr37DhhyQkVtA
 ouuSg/GahOqcWj6awxXdb3qg/kvVDXRpW5cR+onYNYph+PmAIqyHFHbpkxk9lyyj+gTGKWzLH
 zG1ZqgbIMtH6aMasG6Bi6uUbv2jAwRFiNtNi1eQ+APUpK3LEXS4Rl5X0JojPD3Sr6revyhHyx
 7i32YkBXSz3+4PY5kmVLqlZOL1RI+TuMuWK8kL23CrHLbKdAng6+YCilAXJsMHrvHyg6RKBYG
 IC+yYlTuWVK1LMTR0aW2HLQ8SBiYuPwI2Glyc6ZR/d/kleI669FHiXJC9irehfbcqu8MVeaYF
 MEmDpZtfsBM36TzRk79Du0eVcrcvZFI17YA1IbWu+IAT6M/B4FhyUFr1r/y2hy5VzREAo38nN
 aC7wZFtY35mKoIgEdXbh0Ejon5gJptQCPThVEiFcn0P8jlTrh9plbASdqWMS4ebEKEllrUPQy
 RTSrADMgzLrVwjkfgagCW0SrX1YxjgjM4M1aaHIH+Um+hAVj/utuWotAiytQbbyYU4JdNAWRT
 hN6K9CVRtF3Z9E3VCAA/qhlI2uAm+oibOF+RXPtl/VJkuKl0042FFcG8a2VCtnOqHbR9CdCW8
 u2l/8JY+uOw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sun, 3 Mar 2019, Jeff King wrote:

> By the way, "make hdr-check" already fails for me on master, as I do not
> have libgcrypt installed, and it unconditionally checks sha256/gcrypt.h.

Oh? I thought it'd fail only on Windows, so I have not submitted
https://github.com/dscho/git/commit/fix-hdr-check yet:

-- snipsnap --
From c13d9985284d4b452db0d95b6949e02c533db634 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sat, 23 Feb 2019 20:38:40 +0100
Subject: [PATCH] hdr-check: make it work on Windows

On Windows, we define a specific set of pre-processor macros, among
other reasons: to avoid including syslog.h (which is not available on
Windows).

The hdr-check target did not use those definitions, resulting in a
failure to include said syslog.h.

To fix that, let's let the hdr-check target make use of ALL_CFLAGS,
which does include the pre-processor macros that would e.g. skip the
conditional block including syslog.h.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c5240942f2..b9f00f0ea0 100644
--- a/Makefile
+++ b/Makefile
@@ -2741,7 +2741,7 @@ CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
 HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
 
 $(HCO): %.hco: %.h FORCE
-	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
+	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -include git-compat-util.h -I. -o /dev/null -c -xc $<
 
 .PHONY: hdr-check $(HCO)
 hdr-check: $(HCO)
-- 
2.20.1.windows.1.1576.g37ac248661.dirty


