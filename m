Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031E51F461
	for <e@80x24.org>; Thu, 22 Aug 2019 13:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbfHVNn0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 09:43:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41919 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387649AbfHVNnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 09:43:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id i4so7668315qtj.8
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iaxI2sQ/DkAPMQOFHOV/bdflWX3zICdE6qq7zj2GTlA=;
        b=ZnmQcFbjmWKilxc2eBKxETNyVqVvoHlSKsP5QEsqmLS7jPOErT0HSSYQSFQ2NtyLoq
         piWKdZNcPRUI2PS5s3879Kbj7kTJXtnqgK194UXBhZpyzLKQQrQr0/Pl2ysWkfOqoIVg
         jS7HMTqONsCV+zKBb3jyKjMt8dECVjE2tTFyS4AUOlBOHh5TbV3mwdMV8/2B3Bj+E9ER
         zI13UotiNNyAB+GCelQs/SYbmeKT9k9WLw3sInWbwtJ8NE7DRbEEJTcM35BEDUGld2kj
         NCFR6RxLybTKC9fUfQRzCR4VDFTGqjupxONRGvbS0MuuUhSnLWr5k5EeVHQRvgXdSX6s
         112w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iaxI2sQ/DkAPMQOFHOV/bdflWX3zICdE6qq7zj2GTlA=;
        b=WIKlHdyyAAhCgZ0A98EwwW/JVJ+fKq3Ho9vb/qZWqRy3UOx1XOoQAszinm9ieUgqDe
         Mef5MEhzvr/BW1x62lK0Lk5UjoYh9okbvtbcn1PIPxTZxLOFXKOLDZJtBlImP/2Ns1ee
         ZMcVCPHLp9+RAE45sqZB5uJ3fDSl/3i/6xH8COc+0AfVFK6wW3syicIv4DAFXfWWlSnL
         qx+5FrjfJYWiyKCHgdHEuNZnTWEiiu/8oijZWEsMzBGmGjlwl6aV0PYR8L1qa/yCw54e
         sKg3ybdgwZLpv2A/HfrtgjJky66X2tNxkMvWyEEvyKQduH+ZqOvTEsJKU4IRg43w+5hY
         jQBw==
X-Gm-Message-State: APjAAAWMWnvEK8gXvgf90Hve+h24WOk/jExE0VcfcP0+YbjGLZgcjifj
        rpG7Y9eUVMG83oYdWsSgr/o=
X-Google-Smtp-Source: APXvYqzYcFS97pXQS8iJtyK0mbXU0BcfJtn4Bsr5y+JpNyiSvHzf0WzyQNh6fYneaGFBt0gIdmebbw==
X-Received: by 2002:ac8:243d:: with SMTP id c58mr36925068qtc.388.1566481404859;
        Thu, 22 Aug 2019 06:43:24 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7dcd:416c:c779:cf77? ([2001:4898:a800:1012:2f01:416c:c779:cf77])
        by smtp.gmail.com with ESMTPSA id u23sm11468038qkj.98.2019.08.22.06.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 06:43:24 -0700 (PDT)
Subject: Re: [PATCH 0/2] [RFC] Revert/delay performance regression in 'git
 checkout -b'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.317.git.gitgitgadget@gmail.com>
 <20190821223158.GB20404@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0c3bdcb6-d742-0182-b8b2-8f12a5b718b3@gmail.com>
Date:   Thu, 22 Aug 2019 09:43:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190821223158.GB20404@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2019 6:31 PM, SZEDER Gábor wrote:
> On Wed, Aug 21, 2019 at 12:18:32PM -0700, Derrick Stolee via GitGitGadget wrote:
>> As we were integrating Git 2.23.0 into VFS for Git, we discovered that "git
>> checkout -b new-branch" went from 0.3s to 10+s on the Windows OS repo.
> 
> Does this slowdown only affect the Windows OS repo with VFS for Git,
> or other biggish repos without VFS for Git as well?
> 
>> This series does the following:
>>
>>  1. Reverts the change that makes 'git checkout -b' slow again.
>>  2. Creates a warning that recommends users start using 'git switch -c'
>>     instead.
> 
> 'git help switch' says loudly and clearly that "THIS COMMAND IS
> EXPERIMENTAL. THE BEHAVIOR MAY CHANGE."  It's too early to recommend
> it this aggressively, and to deprecate any parts of 'git checkout'.

Even more reason why the performance boost should not have been
removed from 'git checkout -b' so quickly.

Thanks,
-Stolee


