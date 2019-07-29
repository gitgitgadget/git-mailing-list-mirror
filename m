Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94D531F462
	for <e@80x24.org>; Mon, 29 Jul 2019 02:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfG2C2P (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 22:28:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46157 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2C2P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 22:28:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id r4so43033643qkm.13
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 19:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:newsgroups:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=leJ/CLOz+NY61Gac4bUeQN/CjZ3xPCz1Qv0NU0xkCAk=;
        b=a+zcJHfEkYnjKUpfHHI+qVRhcBwHhulhSmsiKiCu2CI5j7n0raI8jJV/C0yJrwxHQE
         0UjqWHaP+zeIMw9CAMLSTyYVXe+lVZR89hKf5G+r66P8NVQVkgTcwYosmn0wjnvCqNYf
         TosAELasLsmspCArEk2dHZqg2B8B5Ha4bd8uqJec4fXpJkuJzz7MK/vjhc7+y8dsqgMc
         6LrFyAiwlfcd2QPDfOgozSOrv0wRi/5sER8wDvzKvtkiWhOLTxaRDjT+2MVXPp0Iyb+1
         vu0Hp0kD390/55WYmHZFw6+U1xLGZWwS2ZS7g69Esnn01IXtbEMcPTuod593euaCjRTg
         cZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:newsgroups:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=leJ/CLOz+NY61Gac4bUeQN/CjZ3xPCz1Qv0NU0xkCAk=;
        b=Nqa+8ryxO6+U0zZ7ofgjBgQ8PeV1z9WCPJYmQrgO3dcTKW8M0svhlzvG8DeWAp8aIv
         umVPmo50wBPIhrLFGIz37FNAVA7bA6JA43Lc9zMLGkAjioPe3I4XjoG2t5v7dmVscNBc
         ooPlouZKjraht6idkj1SALw+qxbfZc80kGQUaAy4szjAX27UP18w2P5b0qokI6cdIWbe
         sINxMHIg+tt+f8YbPM3nNKP45nL4K+ebC+9o2IpPSq+V2EzpuAsfhGuCmy0s8/bgXGOi
         FSYHOpBr0OWNaInzu+5zC2Dzej63av73WT+9LWHFh63uUOK/0CTOwSYmUKvh4MSQu8mE
         sdKA==
X-Gm-Message-State: APjAAAVVuBkYMqDCgfqtM9bHfs5BaAPalbBZ5QEMZbD1pSoKhTAN/Hc7
        hgA0G7k8zVcG32k0NwZQofI=
X-Google-Smtp-Source: APXvYqzIT2bikR2OFg55ljJrM/b4J6fccGlcn5W52n7G8k3Id7xRpyuPkLq3XDFc8alMQvC+nQCV+Q==
X-Received: by 2002:a37:72c5:: with SMTP id n188mr64425795qkc.181.1564367293989;
        Sun, 28 Jul 2019 19:28:13 -0700 (PDT)
Received: from marklaptop.lan (pool-74-96-119-181.washdc.fios.verizon.net. [74.96.119.181])
        by smtp.gmail.com with ESMTPSA id e125sm25125653qkd.120.2019.07.28.19.28.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 19:28:13 -0700 (PDT)
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pratyush Yadav <me@yadavpratyush.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Newsgroups: gmane.comp.version-control.git
References: <20190728151726.9188-1-me@yadavpratyush.com>
 <20190728213634.GB162590@genre.crustytoothpaste.net>
 <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
 <20190728224943.GC162590@genre.crustytoothpaste.net>
From:   Mark Levedahl <mlevedahl@gmail.com>
Message-ID: <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
Date:   Sun, 28 Jul 2019 22:28:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728224943.GC162590@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/19 6:49 PM, brian m. carlson wrote:> On 2019-07-28 at 22:10:29, 
Pratyush Yadav wrote:
 >> The function is not documented, and I only started spelunking the code a
 >> couple days back, so I'll try to answer with what I know. It might 
not be
 >> the full picture.
 >>
 >> Running git-gui --trace, these commands are executed during a rescan:
 >>
 >> /usr/lib/git-core/git-rev-parse --verify HEAD
 >> /usr/lib/git-core/git-update-index -q --unmerged --ignore-missing 
--refresh
 >>
 >
 > Great. This sounds like a well-reasoned change. I'll let other folks who
 > use git-gui more chime in to see what they think as well.
 >

I'm assuming this does what is currently done by F5.
A simple rescan from git-gui in the git repository takes about 8 seconds 
on my corporate laptop running Windows, making this happen on change of 
window focus is definitely not a friendly change from my view point.

Mark
