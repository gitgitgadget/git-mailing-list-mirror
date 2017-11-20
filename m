Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543BD202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 23:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdKTXva (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 18:51:30 -0500
Received: from avasout04.plus.net ([212.159.14.19]:56564 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751195AbdKTXv3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 18:51:29 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id GvqYejy60zbmWGvqZeC1rL; Mon, 20 Nov 2017 23:51:28 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=fFWYPnE7F0dn5gEAs6IA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v1 1/4] fastindex: speed up index load through
 parallelization
To:     Ben Peart <peartben@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net
References: <20171109141737.47976-1-benpeart@microsoft.com>
 <20171109141737.47976-2-benpeart@microsoft.com>
 <xmqqbmkahhar.fsf@gitster.mtv.corp.google.com>
 <7e5a9fde-67fc-2bb9-51b6-54bdaed162db@gmail.com>
 <xmqq7eut8y36.fsf@gitster.mtv.corp.google.com>
 <7428e41e-b705-f377-1951-b11af851c4d5@gmail.com>
 <xmqq7eus3nr2.fsf@gitster.mtv.corp.google.com>
 <73fd93cd-91f4-1286-732c-cd8185fe2027@gmail.com>
 <xmqqwp2s1h1x.fsf@gitster.mtv.corp.google.com>
 <9ba23d2c-2198-55d7-5a02-69879fbbb3cb@gmail.com>
 <xmqq1sl017dw.fsf@gitster.mtv.corp.google.com>
 <92b0b0ff-6878-003a-b26f-3b4c2c857be3@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <63053f5d-0089-4165-0470-ed0d88a87e9e@ramsayjones.plus.com>
Date:   Mon, 20 Nov 2017 23:51:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <92b0b0ff-6878-003a-b26f-3b4c2c857be3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOKnS7sXwRRh8ZFJYSdX8XQ6moQSjg69WVhfkEQPqrDBIenYuvi23Sibr4Ep74wj9in6Ou8Dj+dOXhRzxIMPKwxMvVfdF7ElG/ivHWVxBaoef3eQdIuk
 78tGC1ZjHyXJPOdgFpSA0bCcIxjDheJqC+q+HnYSgs4LVbL1MeFWdChG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/11/17 14:01, Ben Peart wrote:
> Further testing has revealed that switching from the regular heap to a refactored version of the mem_pool in fast-import.c produces similar gains as parallelizing do_index_load().  This appears to be a much simpler patch for similar gains so we will be pursuing that path.
> 
> Combining the two patches resulted in a further 25% reduction of do_index_load() but with index load times getting smaller, that only resulted in a 3% improvement in total git command time.  Given the greater complexity of this patch, we've decided to put it on hold for now.  We'll keep it in our back pocket in case we need it in the future.

Since you are withdrawing the 'bp/fastindex' branch, I won't send the
patch to fix up the sparse warnings (unless you would like to see it
before you put it in your back pocket). ;-)

ATB,
Ramsay Jones


