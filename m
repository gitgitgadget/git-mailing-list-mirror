Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6B02035F
	for <e@80x24.org>; Thu, 27 Oct 2016 06:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932129AbcJ0G3i (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 02:29:38 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:5524 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751373AbcJ0G3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 02:29:37 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t4H6l2D2jz5tlC;
        Thu, 27 Oct 2016 08:29:35 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id ED580144;
        Thu, 27 Oct 2016 08:29:34 +0200 (CEST)
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Junio C Hamano <gitster@pobox.com>
References: <20161026215732.16411-1-sbeller@google.com>
 <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
 <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
Cc:     Stefan Beller <sbeller@google.com>, Johannes.Schindelin@gmx.de,
        git@vger.kernel.org, simon@ruderich.org, peff@peff.net
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b5084894-0f1e-2a32-79fb-74ce977b3a92@kdbg.org>
Date:   Thu, 27 Oct 2016 08:29:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.10.2016 um 08:21 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>>> As many codepaths may not even need access to the attributes, I
>>> doubt that would be a very productive direction to go.
>>
>> So, what is productive then? Pessimizing one (not exactly minor) platform?
>
> Lazy on-demand initialization as needed, perhaps?  The on-demand
> initialization mechanism may become no-op on some platforms that can
> do static initialization.

This is the pessimization that I am talking about. I would not mind at 
all if it were only for the attribute subsystem, but the proposed patch 
would pessimize *all* uses of pthread_mutex_lock.

-- Hannes

