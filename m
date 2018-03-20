Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29021F404
	for <e@80x24.org>; Tue, 20 Mar 2018 18:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeCTSks (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 14:40:48 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:42164 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTSks (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 14:40:48 -0400
Received: from [192.168.2.201] ([92.22.3.164])
        by smtp.talktalk.net with SMTP
        id yMBhepNcJC0WbyMBiev4Ub; Tue, 20 Mar 2018 18:40:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1521571247;
        bh=nImiSxmUR7n4YXTVzEeoQQzb6uOS3TWhzYxS23SA51U=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DdPmxsP1yzKd2/yyXzKSZVXBjcs+uNbbT6etqa5jIywnaepNQ84u4au/bVBdjj7V0
         l3eOzEoNhE6SJtfrJQF0/TwOV6vIhdJMh4C4M5J7fLJg2k6tDGkXFOI65vLjVkQJRU
         L9Py8Z/j/1VCvUeXceQQJ6fmbvidHr3QE6XXkYVQ=
X-Originating-IP: [92.22.3.164]
X-Spam: 0
X-OAuthority: v=2.3 cv=Q+T8Hb+a c=1 sm=1 tr=0 a=8UrjQVoXl1ilnsKy4/PEMg==:117
 a=8UrjQVoXl1ilnsKy4/PEMg==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=N_HvZNR8x4QQv6NvXKgA:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] rebase --recreate-merges --keep-empty: don't prune
 empty
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180320101114.17663-1-phillip.wood@talktalk.net>
 <nycvar.QRO.7.76.6.1803201639540.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <e306f33a-3cd9-b753-ed61-66b7ff614087@talktalk.net>
Date:   Tue, 20 Mar 2018 18:40:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803201639540.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBwbnbGTKhwioLxSBe07gNAgZ5KzwgLquY5M01HFmknjTNAeljCub0BNpnGncBZqX8RF9aCJd9axN9ShpHav5guMVN0YfevYI9wMMkqBvWv+kc1zWT1o
 5h8l3J2J44zz/caNo5J/j0V4np8WQHIcG5o6EdlPp2ZkSXCIojOn3U8I4AACYfhoYZ7KNsl+eVkti9BABObViaGE6ZC6USkNXRGgrXWDJkXgb4ZyhHsl2OxL
 iRE2DWAGEhz8nCXljT2mA7EM7SpRtlB0Cwy5Vcuk+4JMoPhy6TyoHXtTU1OmA6Jr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/03/18 15:42, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Tue, 20 Mar 2018, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> These patches apply on top of js/rebase-recreate-merge. They extend
>> the --keep-empty fix from maint [1] to work with --recreate-merges.
> 
> As indicated in another reply, I'd rather rebase the --recreate-merges
> patches on top of your --keep-empty patch series. This obviously means
> that I would fold essentially all of your 2/2 changes into my
> "rebase-helper --make-script: introduce a flag to recreate merges"
> 
> The 1/2 (with s/failure/success/g) would then be added to the
> --recreate-merges patch series at the end.
> 
> Would that be okay with you?

Yes, that's fine, it would give a clearer history

Best Wishes

Phillip
