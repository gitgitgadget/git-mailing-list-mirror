Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50D81FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 19:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966693AbcLVTGH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 14:06:07 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:43584 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966682AbcLVTGE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 14:06:04 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tl1Fk3Dn5z5tlW;
        Thu, 22 Dec 2016 20:06:02 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 196A61B85;
        Thu, 22 Dec 2016 20:06:02 +0100 (CET)
Subject: Re: [PATCH 4/2] t5615-alternate-env: double-quotes in file names do
 not work on Windows
To:     Jeff King <peff@peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
 <d9d2580c-a2e5-d9f3-1f56-6814b2b2285d@kdbg.org>
 <00b6235d-c1bc-30c2-6539-6c78c4ce9eb0@kdbg.org>
 <20161221224222.6fn6irefmd6li6oa@sigill.intra.peff.net>
 <4e66fba1-d881-6a96-1e4d-da9c897353ac@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <54ba9cff-b6f7-7660-261f-393cd5181da6@kdbg.org>
Date:   Thu, 22 Dec 2016 20:06:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <4e66fba1-d881-6a96-1e4d-da9c897353ac@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.12.2016 um 07:13 schrieb Johannes Sixt:
> Am 21.12.2016 um 23:42 schrieb Jeff King:
>> Hmph. I explicitly avoided a colon in the filename so that it would run
>> on MINGW. Is a double-quote also not allowed?
>
> It is not allowed; that was my conclusion. But now that you ask, I'll
> double-check.

Ok, the point is that I get this error:

mv: cannot move `one.git' to `"one.git'

I don't feel inclined to find out which of 'mv' or the Windows API or 
the NTFS driver prevents the double-quotes and come up with a 
work-around just to get the test to run in some form. Let's leave it at 
the !MINGW prerequisite.

-- Hannes

