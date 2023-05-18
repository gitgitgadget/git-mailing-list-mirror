Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AABCC77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjERUL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjERUL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:11:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5ECE6D
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:11:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B5A4D209CED;
        Thu, 18 May 2023 16:11:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=PCzZ4rtCTAPSLntPzlrTVIIP+Wfs4VLFBVHS9NK
        iCwo=; b=sXjn0D4QuzVLvJWZOFfLd9QDU/VZwNYalZJsj/UeXiT35ujWswtzhca
        QDuT3gv1FDq6aE+wCQ9ahSpi4ghX7eIM2H8o9D36Peaf7Cc8ZcmkQ2f49yD9mJ0c
        5wukHKfWOG+tHBkhrTKUq87wvV7uICi67kSbYxtKyKhUqg4G9yO8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE1A6209CEC;
        Thu, 18 May 2023 16:11:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC0D3209CEB;
        Thu, 18 May 2023 16:11:19 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 18 May 2023 16:11:16 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [BUG 2.41.0] t/lib-httpd/apache.conf incompatible with
 RHEL/CentOS 7
Message-ID: <ZGaGZACGNLeAsZRp@pobox.com>
References: <ZGUlqu7sP7yxbaTI@pobox.com>
 <20230518184532.GC557383@coredump.intra.peff.net>
 <20230518192102.GA1514485@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518192102.GA1514485@coredump.intra.peff.net>
X-Pobox-Relay-ID: 275260BA-F5B8-11ED-BDD5-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> I tested this manually by mutilating the config directive to "FooBar",
> which would fail even on recent versions. And then tweaking the "13"
> in the version check up to "60" to make sure it properly skips even with
> recent Apache. But testing on real CentOS 7 would be very much
> appreciated.

I tested on RHEL/CentOS 7 and it does what it says on the tin:

t5563-simple-http-auth.sh .......................... skipped: no CGIPassAuth support

Thanks!

-- 
Todd
