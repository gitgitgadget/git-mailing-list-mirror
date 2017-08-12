Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A802208C4
	for <e@80x24.org>; Sat, 12 Aug 2017 09:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750802AbdHLJEZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 05:04:25 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:58137 "EHLO
        homiemail-a111.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750761AbdHLJEZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Aug 2017 05:04:25 -0400
Received: from homiemail-a111.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTP id 080513C001C18;
        Sat, 12 Aug 2017 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=jupiterrise.com; bh=2
        +Ilj9N/4kkqH9SGVIeIMuF1JiI=; b=OprsGUieYiQvVkp1eKfIiPjhpxim0UDE1
        vLv7PJx1vZccXKiFyZnPgY4eM73LyMJnUXHlWhsIUvJXA+kE/qnIgvF/JkCF/SKK
        So93EaHJ5Z20NVGQkN0M5PNj9wpKthHVciFHkLpeco3x6F/XT7nzukqXnryoF+zb
        HX+BPSjhAs=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTPSA id C8B733C001C15;
        Sat, 12 Aug 2017 02:04:24 -0700 (PDT)
Received: from [192.168.20.50] (router.tgcnet.jupiterrise.com [192.168.20.58])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTPSA id 36F6360608;
        Sat, 12 Aug 2017 11:04:21 +0200 (CEST)
Subject: Re: [PATCH 1/2] http: Fix handling of missing CURLPROTO_*
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
References: <cover.1502462884.git.tgc@jupiterrise.com>
 <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com>
 <cover.1502462884.git.tgc@jupiterrise.com>
 <4d29d43d458f61c6dabca093f591ad8698ca2ceb.1502462884.git.tgc@jupiterrise.com>
 <xmqqo9rly6dx.fsf@gitster.mtv.corp.google.com>
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
Message-ID: <91420770-f02e-7685-9c0e-f840633f01d5@jupiterrise.com>
Date:   Sat, 12 Aug 2017 11:04:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9rly6dx.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GH
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08/17 02:30, Junio C Hamano wrote:
> This may make the code to _compile_, but is it sensible to let the
> code build and be used by the end users without the "these protocols
> are safe" filter, I wonder?
> 

Git will display a warning at runtime if this is not available but 
perhaps this warning could be worded more strongly and/or make reference 
to CVE-2009-0037.

-tgc
