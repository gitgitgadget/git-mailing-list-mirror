Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEF0C63777
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 16:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04E7206D5
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 16:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgK3QRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 11:17:35 -0500
Received: from siwi.pair.com ([209.68.5.199]:48618 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgK3QRf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 11:17:35 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E53003F47F9;
        Mon, 30 Nov 2020 11:16:53 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C7E0B3F47F8;
        Mon, 30 Nov 2020 11:16:53 -0500 (EST)
Subject: Re: [RFC PATCH] usage: add trace2 entry upon warning()
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20201123190412.101265-1-jonathantanmy@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8b4d2300-5c55-fab5-af39-4c5921a6ea9a@jeffhostetler.com>
Date:   Mon, 30 Nov 2020 11:16:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201123190412.101265-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/23/20 2:04 PM, Jonathan Tan wrote:
> Emit a trace2 error event whenever warning() is called, just like when
> die(), error(), or usage() is called.
> 
> This helps debugging issues that would trigger warnings but not errors.
> In particular, this might have helped debugging an issue I encountered
> with commit graphs at $DAYJOB [1].
> 
> There is a tradeoff between including potentially relevant messages and
> cluttering up the trace output produced. I think that warning() messages
> should be included in traces, because by its nature, Git is used over
> multiple invocations of the Git tool, and a failure (currently traced)
> in a Git invocation might be caused by an unexpected interaction in a
> previous Git invocation that only has a warning (currently untraced) as
> a symptom - as is the case in [1].
> 
> [1] https://lore.kernel.org/git/20200629220744.1054093-1-jonathantanmy@google.com/
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

LGTM

Thanks,
Jeff

