Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE143C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 15:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiHOPIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiHOPI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 11:08:29 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A8C140AB
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:08:27 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F28103F4096;
        Mon, 15 Aug 2022 11:08:26 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:100e:b067:ca0b:40be:ffcf:75ad:b55a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5D7DC3F4090;
        Mon, 15 Aug 2022 11:08:26 -0400 (EDT)
Subject: Re: [PATCH v2] fetch-pack: add tracing for negotiation rounds
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <a16d86e1ced104bb331bb9e7055037a3a2821352.1658787182.git.steadmon@google.com>
 <4390677ec75d51487142adf7c2ab821cbd24a53e.1659477669.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7dae2e8b-1168-3738-8efb-7ecfdfae796a@jeffhostetler.com>
Date:   Mon, 15 Aug 2022 11:08:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4390677ec75d51487142adf7c2ab821cbd24a53e.1659477669.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org




On 8/2/22 6:04 PM, Josh Steadmon wrote:
> Currently, negotiation for V0/V1/V2 fetch have trace2 regions covering
> the entire negotiation process. However, we'd like additional data, such
> as timing for each round of negotiation or the number of "haves" in each
> round. Additionally, "independent negotiation" (AKA push negotiation)
> has no tracing at all. Having this data would allow us to compare the
> performance of the various negotation implementations, and to debug
> unexpectedly slow fetch & push sessions.
> 
> Add per-round trace2 regions for all negotiation implementations (V0+V1,
> V2, and independent negotiation), as well as an overall region for
> independent negotiation. Add trace2 data logging for the number of haves
> and "in vain" objects for each round, and for the total number of rounds
> once negotiation completes.  Finally, add a few checks into various
> tests to verify that the number of rounds is logged as expected.
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>

Sorry for the delay in responding. Just got back from a much
needed vacation.

This version LGTM.

Thanks
Jeff
