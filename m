Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65DA1F744
	for <e@80x24.org>; Sun, 10 Jul 2016 10:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbcGJKmO (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 06:42:14 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37805 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbcGJKmN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2016 06:42:13 -0400
Received: by mail-it0-f43.google.com with SMTP id f6so35556299ith.0
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 03:42:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dYPzP7CBQwOlPfKGtpCnr10qVXQRGut89Prhf6UFF1k=;
        b=DZ/R5c3UE+8HKtLCsv4rsUkmO8rDWDfrKCwb878OmxmmTfSq+LWcRJSSnUuw75alL4
         HeiNRZuVmEp7sWWIK219tP+hmd9QvTSxujmMHPF062B0s8pZQ7WbmwyMRLr910UGhoFF
         Be3kAoPt9caX0d9u3B1tkenzz7QNdvsj3iPgH6au3mH0hp1xNKXf5AqNLE4SIpgiycjY
         TNGXb7x6gJgt/ZBAMBNLsN2G/ZYF6bRHpAQeUtpsgyfWI6h7mof7RhhdOjikxJr6hFgY
         OH5Lr5+YH7PluagBlzBdFuwvTx/DG92+5V+2lzlwscnItjjKhfYWVt4nzyH6SOfUIjnA
         D/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dYPzP7CBQwOlPfKGtpCnr10qVXQRGut89Prhf6UFF1k=;
        b=Kk+twWQgT0zTPdxK2515DEqOj3PH9TBvEiWlIVEqfOw8MdbPGSs8SOL/2Lk6urmiab
         lWfRPHBBwoIOZwEoJKv9VQ5AVGXm5LvC4GXBXWQAIeZMCR+85M7W3b3sFN2IB8W/P8GV
         eaSrJEhuFyWVmIZctJMRf6O9GfZ6kgtzSZbnWFiTPvuDP2GCDB+fnyZXC6Ku2kvbJRUT
         +JYw33hUvNeeDT29Uy5ApC+CABQg2PxhtdcxyTGVLASbRAnRta88Rdv3pPFad73BR2CE
         Zqu+z/1gAThaktKYiJ7X6btWBOuse9PGb6u8i/rlePpQOwgNYpAcZKWl3I2GoVkcJ0bd
         oWoA==
X-Gm-Message-State: ALyK8tJ1sXZVufUHP3wMhYz25dSXG42u6dq5kpZ3s0B8XFnjSp6EkvzhBf47j0PbiTzN+4FP2nB21uPbScRZsA==
X-Received: by 10.36.81.15 with SMTP id s15mr10964311ita.57.1468147332744;
 Sun, 10 Jul 2016 03:42:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sun, 10 Jul 2016 03:41:42 -0700 (PDT)
In-Reply-To: <20160705170558.10906-1-pclouds@gmail.com>
References: <1466807902.28869.8.camel@gmail.com> <20160705170558.10906-1-pclouds@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sun, 10 Jul 2016 12:41:42 +0200
Message-ID: <CACsJy8CHsMXJOtr14XYLeU8J6eAwk5rahtkppwxV0JpeXL5yWw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Number truncation with 4+ GB files on 32-bit systems
To:	Git Mailing List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Christoph Michelbach <michelbach94@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 5, 2016 at 7:05 PM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Most of the rest seems harmless, except for the local variable "size"
> in builtin/pack-objects.c:write_one(). I might send 6/5 for that one.

This truncated "size" produces incorrect .idx file and makes everybody
else fail to read the (correct) .pack file. So 6/5 is coming shortly.

I also add 7/5 to be able to run fsck on 32-bit systems, but 7/5 could
help improve performance a bit on 64-bit systems too.
-- 
Duy
