Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6B91F829
	for <e@80x24.org>; Sun, 30 Apr 2017 16:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424831AbdD3Qc2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 12:32:28 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:20235 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164592AbdD3Qc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 12:32:27 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wGCkw47vsz5tlG;
        Sun, 30 Apr 2017 18:32:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C96A743E;
        Sun, 30 Apr 2017 18:32:23 +0200 (CEST)
Subject: Re: [PATCH v3 0/5] archive-zip: support files and archives bigger
 than 4GB
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <3df2b03f-ab86-09ac-0fc8-3c6eb10c6704@web.de>
 <edf33657-f74b-3cd5-44a7-8e16231bd978@web.de>
 <e30554f3-1aa3-acea-500b-6392fce902be@web.de>
 <d8a1edfc-e4d6-2bd2-7b07-a1a10d89490a@web.de>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Peter Krefting <peter@softwolves.pp.se>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <9f6cb421-db61-51ca-6a4b-ea7c94bd513e@kdbg.org>
Date:   Sun, 30 Apr 2017 18:32:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <d8a1edfc-e4d6-2bd2-7b07-a1a10d89490a@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.04.2017 um 09:53 schrieb René Scharfe:
> @@ -178,7 +182,8 @@ test_expect_success EXPENSIVE,UNZIP 'zip archive bigger than 4GB' '
>  	"$GIT_UNZIP" -t many-big.zip
>  '
>
> -test_expect_success EXPENSIVE,UNZIP,ZIPINFO 'zip archive with files bigger than 4GB' '
> +test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \

Why is LONG_IS_64BIT required?

> +	'zip archive with files bigger than 4GB' '
>  	# Pack created with:
>  	#   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file
>  	mkdir -p .git/objects/pack &&
>

-- Hannes

