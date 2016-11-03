Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5FC82021E
	for <e@80x24.org>; Thu,  3 Nov 2016 20:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757714AbcKCUxi (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 16:53:38 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36733 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756589AbcKCUxh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 16:53:37 -0400
Received: by mail-qk0-f179.google.com with SMTP id o68so73679373qkf.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LVDKSKxoocwwHrfLZ4ExIesQsDh27PCSTmihEEuOH9g=;
        b=Vq9YvY+454CzmFcWlM8Q8/gw0MXRroLmetQcFcN+peTaxHZh+/IuCNo650i+1AnYPA
         UJEAhytb0cvglx3MIrd+WZ13zJWRE8bW32bJvckXChyGcsvoxQTBNHV5sfs15go2XoHI
         PRGM4jeJZfCp72AC1g11Hry6/SacZtkehbR4zvO0I5qV+hqUfY9QNB+DM0jxgDggbKGx
         RA5p4QW+6Q4+zzHFpc1FkVhRF9vyzJ32NodiSksEy4fsM9vuH8iIbjCQ0clo4XFg6fBB
         Bl+zQT1rb4gG0FKZ7rDfOBCka0xQhp4KnbqrQZ/LFU9bCE4+EGUMFgwriqVwLdQ6cYVS
         EHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LVDKSKxoocwwHrfLZ4ExIesQsDh27PCSTmihEEuOH9g=;
        b=hxeSL9Uuoaaabho4/tR7kuWqPmJCVWVMkFJwbZhevlSER4w8vk20eL9N26JmD3zfWn
         uRrcYS0X2zaPy1lgc8aiWphkW7EIcy7yJlRD57jezN/XeA07yW+LO+IQFJPLZW37ZNzE
         agN8RBUO4c0tHrxYVjbfywUuRPv+l7VBdpMPINa/albfJAMi7IP5dKqtbHyxAwh/zVJs
         siJ+Ya9PIPp50otsGoYzvf7mUgXIxMMH07sqSmEkwBRt+z1SxLD9MKMD6CxiA/UEKpF7
         FTkMmsPjDbw/HpaOuoUA1c0GFPo6TXp7Ga3FP4VXHLIm2L4Hpw4hZ1V50BDYO5nlBeqi
         On9g==
X-Gm-Message-State: ABUngvdWZWGeLy41I3IBTRnsvtlDVpe6l1bLwoA/+0VfPFG6I5ScIFDjU1ulcHyUe5HtHPYzv+23M9nXKtHiMx6t
X-Received: by 10.55.16.147 with SMTP id 19mr9568476qkq.255.1478206416524;
 Thu, 03 Nov 2016 13:53:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 3 Nov 2016 13:53:36 -0700 (PDT)
In-Reply-To: <18e8d0bb-ceb0-17dd-1318-f07585f8709b@kdbg.org>
References: <20161028185502.8789-1-sbeller@google.com> <18e8d0bb-ceb0-17dd-1318-f07585f8709b@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 Nov 2016 13:53:36 -0700
Message-ID: <CAGZ79kZy2O+hDqmeZGMT9FP3nb+7z+VtrH00=68GqmYdA=iz_Q@mail.gmail.com>
Subject: Re: [PATCHv2 00/36] Revamp the attr subsystem!
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 3, 2016 at 1:47 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 28.10.2016 um 20:54 schrieb Stefan Beller:
>>
>> previous discussion at
>> https://public-inbox.org/git/20161022233225.8883-1-sbeller@google.com
>>
>> This implements the discarded series':
>> jc/attr
>> jc/attr-more
>> sb/pathspec-label
>> sb/submodule-default-paths
>>
>> This includes
>> * The fixes for windows
>
>
> I've tested the incarnation currently in pu (1928fcc65dc6), which also has
> these fixes, and they work well after a cursory test (it at least passes the
> 3 test scripts that the series touches).

Thanks!
