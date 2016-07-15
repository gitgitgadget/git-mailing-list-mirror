Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D195203C3
	for <e@80x24.org>; Fri, 15 Jul 2016 20:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbcGOUdq (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 16:33:46 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:34480 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbcGOUdp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 16:33:45 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rrkmk5DWbz5tlG;
	Fri, 15 Jul 2016 22:33:42 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 0A30352D7;
	Fri, 15 Jul 2016 22:33:42 +0200 (CEST)
Subject: Re: [PATCH] git-clean: remove fifo, devices, socket files
To:	Andrey Vagin <avagin@openvz.org>
References: <1468550579-9298-1-git-send-email-avagin@openvz.org>
 <ab717fc4-fd07-53d1-1a88-ceba6155889c@kdbg.org>
 <CANaxB-y6XW7-ps1G2CB=N9CiD0VnSLhSer2nsf+2R4pm5TyswA@mail.gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <3a6cb604-daa0-6d34-3342-0671a0b23032@kdbg.org>
Date:	Fri, 15 Jul 2016 22:33:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <CANaxB-y6XW7-ps1G2CB=N9CiD0VnSLhSer2nsf+2R4pm5TyswA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 15.07.2016 um 09:46 schrieb Andrey Vagin:
> On Thu, Jul 14, 2016 at 10:56 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> IOW: These special files are invisible for Git unless it already knows the
>> names. The latter case is outside 'git clean's domain, and the former case
>> really means that special files in the working tree are left at the user's
>> discretion.
>
> I understand your points, but I don't see any reasons to ignore these files.
>
> What will be wrong if 'git status' will reports these files?
> What will be wrong if 'git add' will returns an error instead of
> skipping them silently?

I can buy that 'git add' reports an error for special files. (And I 
concur with Dscho that the behavior should otherwise remain unchanged.) 
But this is not what the commit message sells even if the patch changes 
the behavior of 'git add', too (I haven't tested the patch).

-- Hannes

