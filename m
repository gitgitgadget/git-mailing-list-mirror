Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299D0C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5E86190A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 16:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEKQlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 12:41:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:54918 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231162AbhEKQlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 12:41:09 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 880AA3F47EF;
        Tue, 11 May 2021 12:40:02 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3486F3F47F0;
        Tue, 11 May 2021 12:40:02 -0400 (EDT)
Subject: Re: [PATCH v2] trace2: refactor to avoid gcc warning under -O3
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
 <patch-1.1-782555daade-20210511T130231Z-avarab@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c595d021-5fc2-ded7-d462-51ce7495739b@jeffhostetler.com>
Date:   Tue, 11 May 2021 12:40:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <patch-1.1-782555daade-20210511T130231Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/11/21 9:04 AM, Ævar Arnfjörð Bjarmason wrote:
> Refactor tr2_dst_try_uds_connect() to avoid a gcc warning[1] that
> appears under -O3 (but not -O2). This makes the build pass under
> DEVELOPER=1 without needing a DEVOPTS=no-error.
> 
...


I suppose if we really need to paper around a compiler bug,
then this fix LGTM.

Thanks,
Jeff
