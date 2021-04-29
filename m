Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B0C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA2661446
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbhD2IVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 04:21:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57070 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhD2IVO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 04:21:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B966EB9CE1;
        Thu, 29 Apr 2021 04:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yGAZhJcdZD4TuXx4lmxTW0zOzjnYsz8HbfORCx
        idKIU=; b=t4CslMqJhM5LsJBeAJCKtT+VAeLUwlRerFY9uQpBc8duDnyCQ5pygO
        cWBuPj8n0kZ2rg0mbeZVWwt1vtfB51NiguNm+Y/ar3TPsioAJ0jCYnU5zGBvFerw
        8/wg8ltUygubWX5Gh2rr8yyhecALC5fF4Pu8nUt5Catm6onBBXirk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0309B9CE0;
        Thu, 29 Apr 2021 04:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40406B9CDE;
        Thu, 29 Apr 2021 04:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Trygve Aaberge <trygveaa@gmail.com>
Subject: Re: [PATCH v4] t6030: add test for git bisect skip started with
 --term* arguments
References: <20210429072451.38422-1-bagasdotme@gmail.com>
        <CAP8UFD23Wvm-SpoAoFZZWXfXO_KGPdT5vwa4gWXMbtgL66me=w@mail.gmail.com>
Date:   Thu, 29 Apr 2021 17:20:26 +0900
In-Reply-To: <CAP8UFD23Wvm-SpoAoFZZWXfXO_KGPdT5vwa4gWXMbtgL66me=w@mail.gmail.com>
        (Christian Couder's message of "Thu, 29 Apr 2021 10:05:11 +0200")
Message-ID: <xmqqim45h585.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0DE19D4-A8C3-11EB-9B70-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> I am not sure how safe it is to use the hash of a commit that is in
> seen but not yet in next. I suggested using "a previous commit"
> instead as I thought that both the fix and this commit should be part
> of the same branch, and then it would be obvious which commit it is.
> Maybe we should wait for Junio to come back from vacation and decide
> about this.

It is totally unsafe.  Besides, I do not think it is worth to make
the fix and the test as two separate commits---can I ask you to help
coordinate co-authorship between Ramsay and Bagas to come up with a
combined single patch?

Thanks.
