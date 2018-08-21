Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C901F97E
	for <e@80x24.org>; Tue, 21 Aug 2018 20:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeHVACp (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 20:02:45 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:37344 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHVACp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 20:02:45 -0400
Received: by mail-qt0-f181.google.com with SMTP id n6-v6so21900987qtl.4
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=EL7Mp2slKp7eRa5EeyDx0Gsb2KUdD5i0S7a8okZW3SI=;
        b=NASIMeH5OevjhletH+MgCxmXNUC44TTruhGwr28JIPhYgMNbzL8pADwWDPKJTk+ZNz
         0mtDzZfdSNlI1lqg+iCgKNSdJCzFnKQFxhrNgBHcIDMQVl7cfAntfXVkkmwvsZx51IvT
         W1VkBgNyqeIEjLC2nDr9xY1Tktxu8kJbyD5/KOuMFrVW/kIEjjNHnk/kh9dCc6x2d2yY
         WT/KdxFaYF66+A2mCAIXGLF7V37uR8zGcnN/vDF8/ejVakmHZHPlyIv2+ePI2Hai2TAf
         PnNsTTyL6cU8DM5uh/m+uKYVB0TlzAeFryXoXKALsQBxWTRrj3TYkMdp6cwm8ZCw3OzG
         ovwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EL7Mp2slKp7eRa5EeyDx0Gsb2KUdD5i0S7a8okZW3SI=;
        b=mpScCWUjBJjPUraw0ol3/hXrZ9Eaw/L0JJmJ0WbFQXxqxRlWIebuXe7s/UdydKewPK
         /Q8YdQvBrOkYSkxHk3bJmvLg8iNhQBevcQb+eSaTOdvUh3mxBOff7q1+UigBPrr9b83V
         7PUyd/tNYKqV2bhUUJM9ii97eDkGr3R71bz0G5iC7m9su9+oEZhdiwliDxE6y36WGIVt
         cYYikDj2uDPxiVDaIhJJeYDIeY9aaXEdTyy4fRj1Jy8i3IcrGY86x23ucoaAcRIop0lm
         nsAH120AgeU5/iuEr+hLPyyRINIQpDPiFU5nbZjYzUSj7/pgz0+1nih1Orcj19Ca4TID
         fCsQ==
X-Gm-Message-State: APzg51BYgIloLksGP5YgIZQbYwfSjfGQB6gMSoJdw7cVy0Lf7Pxf1HtS
        Ys0Kb7adWORqF8tyk/kIJr7BEYyu
X-Google-Smtp-Source: ANB0VdaGgcVgvAHNkryWzOGmyUAfTk1lcacGaxFxky13g+9LSsTioSWnHc+mKrAtWOQTqq8DAb3EOA==
X-Received: by 2002:ac8:1b5b:: with SMTP id p27-v6mr4475601qtk.99.1534884063423;
        Tue, 21 Aug 2018 13:41:03 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bcc1:4ea1:6a05:dc2a? ([2001:4898:8010:0:a5f7:4ea1:6a05:dc2a])
        by smtp.gmail.com with ESMTPSA id l23-v6sm2175494qta.30.2018.08.21.13.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 13:41:02 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
Date:   Tue, 21 Aug 2018 16:41:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2018 6:13 PM, Junio C Hamano wrote:
> An early preview release Git v2.19.0-rc0 is now available for
> testing at the usual places.

As part of testing the release candidate, I ran the performance suite 
against a fresh clone of the Linux repository using v2.18.0 and 
v2.19.0-rc0 (also: GIT_PERF_REPEAT_COUNT=10). I found a few nice 
improvements, but I also found a possible regression in tree walking. I 
say "tree walking" because it was revealed using p0001-rev-list.sh, but 
only with the "--objects" flag. I also saw some similar numbers on 'git 
log --raw'.

Test v2.18.0             v2.19.0-rc0
--------------------------------------------------------------------------------------------
0001.1: rev-list --all 6.69(6.33+0.35)     6.52(6.20+0.31) -2.5%
0001.2: rev-list --all --objects 52.14(47.43+1.02)   57.15(51.09+1.18) +9.6%

To me, 9.6% seems out of the range of just noise for this length of a 
command, but I could be wrong. Could anyone else try to repro these results?

(This may also not just be tree-walking, but general pack-file loading 
and decompression, since I computed and stored a commit-graph file. 
Hence, commits are not being parsed from the pack-file by either command.)

Aside: the perf results were not all bad. Here was an interesting 
improvement:

Test v2.18.0             v2.19.0-rc0
--------------------------------------------------------------------------------------------
0002.1: read_cache/discard_cache 1000 times 5.63(5.30+0.32)       
3.34(3.03+0.30) -40.7%

Thanks,

-Stolee

