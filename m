Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1E8C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC53F6101E
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhDATUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:20:12 -0400
Received: from avasout01.plus.net ([84.93.230.227]:36445 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhDATT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 15:19:58 -0400
Received: from satellite ([195.213.6.64])
        by smtp with ESMTPA
        id S2rBl3Dk81iLSS2rElK2P3; Thu, 01 Apr 2021 20:19:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1617304796; bh=h7jaWntTJk3FSd24yRLtieyzLirCgQMx+NG4R/WdfTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PMSHrxaHjWEhyhACPq1WmBGkRce4HGsgbNk/WhSeHqZNiiP1GrWmo+L0GdwY0RWPy
         ycSBomjlUv/tQU4PSs6w56BCKdc6AqB5pqDVTxDX15m48wELuU5k60ihEZDmS3XMkV
         r5WkI+UXM1/EuGGdXlzCxuPyUdHpwRZqrGhsSFhHvyUkN9Lwlr/XS/TVMWSgPhS+W1
         Ao7e01MIWjweWIzYz6yB0mqgou1ZhJGcHOB9fLR3X7wpUvK92z7pWAZH9+NZjH14cN
         E3jX9SxMZnPOtXDeyc8KYjH4OETh2KSc57i7e6o07wqBQ1IV1EvgNDmS4IBL8B2nJw
         48vKCC/Oj+Acg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IYUcpVia c=1 sm=1 tr=0
 a=4p6RfT7+14FqdxR8AqC3bQ==:117 a=4p6RfT7+14FqdxR8AqC3bQ==:17
 a=8nJEP1OIZ-IA:10 a=PKzvZo6CAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=JVOydopCRSc03q1muy8A:9 a=wPNLvfGTeEIA:10 a=q92HNjYiIAC_jH7JDaYf:22
 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Date:   Thu, 1 Apr 2021 20:19:53 +0100
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] ref-filter: fix NULL check for parse object
 failure
Message-ID: <YGYc2enwPChDKGsq@satellite>
References: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net>
 <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
 <patch-5.6-2ffe8f9fe3c-20210401T135419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.6-2ffe8f9fe3c-20210401T135419Z-avarab@gmail.com>
X-CMAE-Envelope: MS4wfCcs4d2elm9BzJNSds4TCyISKfhlYO/79zUhki3kfAT+g2wkBQ8HuojhvPdoAegY8o1n/LeyiXyKoTMqwFvn7Cplk3CDF08YkAWiRLnsfV/2qtX2/pL1
 Pnk/v1md5GKY0sbowa4rR45kr8FvgMc0N0J/comBtiB5+f0BeTDju0MG
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 01, 2021 at 03:56:30PM +0200, Ævar Arnfjörð Bjarmason wrote:
> From: Jeff King <peff@peff.net>
> 
[snip]
> 
> A minimal stand-alone test can be found at, but let's use the newly

... can be found at, ... Hmm, missing test number?

ATB,
Ramsay Jones

> amended t3800-mktag.sh tests to test these cases exhaustively on all
> sorts of bad tags.
> 
> 1. http://lore.kernel.org/git/YGWFGMdGcKeaqCQF@coredump.intra.peff.net
> 
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  ref-filter.c     | 2 +-
>  t/t3800-mktag.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
[snip]

