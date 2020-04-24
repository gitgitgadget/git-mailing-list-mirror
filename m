Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E0BC55186
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D356215A4
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="LvGOkGzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgDXQrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:47:43 -0400
Received: from avasout04.plus.net ([212.159.14.19]:58037 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgDXQrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:42 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id S1N2jk3LmpB7IS1N3j63j0; Fri, 24 Apr 2020 17:40:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587746410; bh=7sPsy/A4b4McALzdVv9LATX3rzaRjTY3HD1O43WVa+k=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=LvGOkGzXPJcnjsspQj6EKAWinJDj9dBRiSqPuz3PXjyguMryYm8HZ8ag3BIYVlDnK
         crY87KdEkwzP1cCiclUSqmTGvtn4QqgvQ1bJ4Xf6W296LvFFa6S9INRlqhnEq/SJfF
         RmcG/IfDVFE90sdvRNWk5Gm9+U6hhBT+NCWRkncxOBSW1XbMzc2jfSxnn3qLqwZS1L
         gelotWrWbxAHIdT1cbTtiyfwGe/uiwxd0VgWU6493yrLck/7RBpvFlNKMfoDxjt2+W
         ythJFJVNFjl3yy7VpWveMyVWyUzpsdspPHzk9PvZWOMO+HiefTUgbpsJnTb9SM7dq6
         1/8RylH+eCJ/g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=MKb7ZPRl c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=ORtwwZdZew9jYSCNUAoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 0/4] Fix Sparse Warning
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587740959.git.congdanhqx@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <411ec3ea-162e-8e52-0133-3108e0c38f0d@ramsayjones.plus.com>
Date:   Fri, 24 Apr 2020 17:40:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1587740959.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEMgdK42G7LdQ1QKMRSyKQ//K/hvJ0uiJGoYUWKYwNPM7ee/CF+0d4KZ00gdmTjn92az9G3vQp+mpKJhqhVimDqdKFesPV/mcRcQZE5M+Byfp+7hM2jQ
 jO+NHKzU6ez1uZ/oyErPGrlyYCOMNKqe28k2b88mWmzsnE2FUoXxfJjgnBqbVLDvDBVIs1g1FN/lfw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/04/2020 16:12, Đoàn Trần Công Danh wrote:
> Change in v2 from v1:
> * = { 0 } is an idiom to zero the structure, it shouldn't be changed
> * change in [4/4] for prototype
> * ignore diffent function prototype

Apart from the regex patch [2/4], these all look good to me.

Thanks!

ATB,
Ramsay Jones

> 
> Đoàn Trần Công Danh (4):
>   test-parse-pathspec-file.c: s/0/NULL/ for pointer type
>   compat/regex: include alloca.h before undef it
>   graph.c: limit linkage of internal variable
>   progress.c: silence cgcc suggestion about internal linkage
> 
>  compat/regex/regex.c                | 1 +
>  graph.c                             | 2 +-
>  progress.c                          | 2 +-
>  progress.h                          | 8 ++++++++
>  t/helper/test-parse-pathspec-file.c | 6 +++---
>  t/helper/test-progress.c            | 9 +--------
>  6 files changed, 15 insertions(+), 13 deletions(-)
> 
