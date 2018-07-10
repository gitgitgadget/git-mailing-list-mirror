Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B068D1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 07:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeGJHew (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 03:34:52 -0400
Received: from s019.cyon.net ([149.126.4.28]:36638 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751103AbeGJHew (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 03:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2ih0FCwQFwnEPUHiabCzIzIN5ceveql7kM8wpa1XJtQ=; b=cUSO6mT6a6D8aUYmsr0fU1XX2F
        0QAoY/5F4su1stePUN3db/N/vAK7IVPvxsprFeI0mOHwPenSqOTSbmGhv6CdZ7cU9EMR/gbk8M6JO
        DKbfO57o0tnUzcaquI3/QsZwJcQhtfH/HHeN3Yd4ZtPUhdbOcTp+PiLoDYKktFqTO0eQ6GQeqi0fp
        UlucdCpapBubP3SxIVVBqzvbSTgnnD3D63Ow6wNCJBpeu+1eX7P8y+GiAdspUsRipdaGJLWQQvzU+
        vQDK7DEufQqBJhSIyY6fyoqgfLmLADi6nUtmuEPnV4V8HF9/5/94/TWfI+mg+2Vif69jYArgN2TMh
        N73nQn3Q==;
Received: from [10.20.10.233] (port=45520 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fcnAe-00G4cz-Ki; Tue, 10 Jul 2018 09:34:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Jul 2018 09:34:48 +0200
From:   Beat Bolli <dev+git@drbeat.li>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>
Subject: Re: [PATCH 0/6] Compile cleanly in pedantic mode
In-Reply-To: <xmqqd0vwaxrq.fsf@gitster-ct.c.googlers.com>
References: <20180708144342.11922-1-dev+git@drbeat.li>
 <20180709192537.18564-1-dev+git@drbeat.li>
 <xmqqd0vwaxrq.fsf@gitster-ct.c.googlers.com>
Message-ID: <3f0ab3f42606d2251a6574d6fb45bf11@drbeat.li>
X-Sender: dev+git@drbeat.li
User-Agent: cyon Webmail/1.2.9
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

Am 09.07.2018 23:45, schrieb Junio C Hamano:
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> While developing 6aaded550 ("builtin/config: work around an unsized
>> array forward declaration", 2018-07-05), I have compiled Git with
>> CFLAGS="-std=c99 -pedantic".
> 
> Nicely done.
> 
> With these 6 patches and the USE_PARENCE_AROUND_GETTEXT_N hack, the
> forward decl of the unsized static array you dealt with separately
> becomes the only remaining violation in the codebase, which is good.
> 
> Will queue.  Thanks.

Should we add a "pedantic" flag to DEVOPTS that would simplify building 
pedantically? It would also have to set USE_PARENS_AROUND_GETTEXT_N so 
as to not overwhelm the developer with too much output.

Beat
