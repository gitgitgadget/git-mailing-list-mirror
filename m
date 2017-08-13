Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1419C1F667
	for <e@80x24.org>; Sun, 13 Aug 2017 18:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbdHMSaf (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 14:30:35 -0400
Received: from vie01a-dmta-pe07-1.mx.upcmail.net ([84.116.36.17]:34988 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751025AbdHMSae (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 Aug 2017 14:30:34 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe07.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dgxei-0004DP-HF
        for git@vger.kernel.org; Sun, 13 Aug 2017 20:30:32 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id wiWT1v0065BuuEg01iWUmj; Sun, 13 Aug 2017 20:30:28 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 07C3545D4512; Sun, 13 Aug 2017 20:30:26 +0200 (CEST)
Date:   Sun, 13 Aug 2017 20:30:26 +0200
From:   Martin Koegler <martin.koegler@chello.at>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
Message-ID: <20170813183026.GC31079@mail.zuhause>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
 <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 12, 2017 at 02:47:25PM +0100, Ramsay Jones wrote:
> On 32-bit Linux, off_t is 64-bit and size_t is 32-bit.

--- t.c ---
#include <stddef.h>
#include <stdio.h>

int main()
{
printf("%d %d\n", sizeof(size_t), sizeof(off_t));
}
------------
$ gcc -m32 -o t t.c
$ ./t.c
4 4

So is that really true?

Regards,
Martin 
