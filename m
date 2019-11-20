Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F199CC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 06:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C3C20885
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 06:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKTGtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:49:00 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:32610 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfKTGtA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 01:49:00 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47HtZc67VBz5tlH;
        Wed, 20 Nov 2019 07:48:56 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DE3304AFB;
        Wed, 20 Nov 2019 07:48:55 +0100 (CET)
Subject: Re: [PATCH v2] userdiff: support Python async functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Holland <anowlcalledjosh@gmail.com>, git@vger.kernel.org
References: <20191119150807.8206-1-anowlcalledjosh@gmail.com>
 <xmqqeey3ci61.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7821ee2c-e778-5760-16d4-eba1a7b64400@kdbg.org>
Date:   Wed, 20 Nov 2019 07:48:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqeey3ci61.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.11.19 um 04:59 schrieb Junio C Hamano:
> Josh Holland <anowlcalledjosh@gmail.com> writes:
> 
>> This patch now includes tests for indented declarations, as well as the
>> unindented versions which were present before.
> 
> Very much appreciated.
> 
> I wondered if something like
> 
> diff --git a/t/t4018/python-indented-async-def b/t/t4018/python-indented-async-def
> index f5d03258af..567c1dafcb 100644
> --- a/t/t4018/python-indented-async-def
> +++ b/t/t4018/python-indented-async-def
> @@ -1,3 +1,6 @@
> +async def not_this_one(self):
> +    return []
> +
>  class Foo:
>      async def RIGHT(self, x: int):
>          return [
> 
> would further help, but if a breakage makes us ignore a start of
> definition that is indented, we would hit "class Foo:" you added
> and notice such a breakage anyway, without additional definition
> before it.  So I think what we see in this patch is good.

Good point raised and fine analysis!

This patch is

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
