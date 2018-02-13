Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D48B1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 15:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934279AbeBMPof (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 10:44:35 -0500
Received: from grym.ekleog.org ([94.23.42.210]:59142 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933594AbeBMPod (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 10:44:33 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id bb87d5ca;
        Tue, 13 Feb 2018 15:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=aWijtg7equukGHrXz1rtNqwjPks=; b=z7qOLMoKOo5GU6
        zrsl9GGl7RbZlPOMdUEdVY12TUPgZwyzuB5ae7XE1ZyCV20L9rtZQexaPV4rzM2B
        hqJs+xag+uY/tWvX27AUMvsamAaavEuZhmHdtwcPJp7UH848LDbzsI3nAoMjrr7e
        m+YLmf/vxCZe4ndVujp5PlfwkRWKs=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 7a105f3b (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 13 Feb 2018 15:44:30 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <20180210122131.GB21843@sigill.intra.peff.net>
 <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
 <20180212192327.GA209601@google.com>
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <461e515c-350a-50f2-bc13-6a976df489fd@gaspard.io>
Date:   Tue, 13 Feb 2018 16:44:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212192327.GA209601@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/12/2018 08:23 PM, Brandon Williams wrote:> Maybe this isn't
helpful but you may be able to implement this by using
> a remote-helper.  The helper could perform any sort of caching it needed
> to prevent re-downloading large amounts of data that is potentially
> thrown away, while only sending through the relevant commits which
> satisfy some criteria (signed, etc.).

This looks like a possibility, thanks! I'll likely try to implement it
this way if there can be no consensus on the features wanted for a
fetch-hook (as the current state of discussion looks like to me).
