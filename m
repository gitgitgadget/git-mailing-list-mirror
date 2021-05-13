Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE21CC43462
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F45561421
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhEMUN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 16:13:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53200 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbhEMUN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 16:13:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18EA5B5E3A;
        Thu, 13 May 2021 16:12:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m5ohWYvNnSt3uEd/Lj8gbJODkSpwCqrhsispEH
        Chwm4=; b=fUqkHvRj9++ZQVr7kIhtZyb6IAasYLE2I1kTrSp0ImtB/5UOb5+YnY
        TM58KpMtmhLFsBaAssfUaDF8m9/4bY48bCTc8QI4r7fA7BVN391Lw4j5qdUfBvf3
        byZK6LGJRzC++equHVjdiE8cezCaezdxD67vJkykcZFv6fWgsTr2g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1065AB5E39;
        Thu, 13 May 2021 16:12:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85A03B5E37;
        Thu, 13 May 2021 16:12:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     dwh@linuxprogrammer.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [RFC doc] Tracking git.git
References: <4591b3bd-1f35-55cb-6eb0-be97810d6e68@gmail.com>
        <20210513144930.GC11882@localhost>
Date:   Fri, 14 May 2021 05:12:46 +0900
In-Reply-To: <20210513144930.GC11882@localhost> (dwh@linuxprogrammer.org's
        message of "Thu, 13 May 2021 07:49:30 -0700")
Message-ID: <xmqq5yzmbdfl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95D8DBCE-B427-11EB-8B0D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dwh@linuxprogrammer.org writes:

> On 13.05.2021 20:05, Bagas Sanjaya wrote:
>>But tracking seen is more like tracking linux-next. We do NOT use git
>>pull because often doing so will try to merge origin (upstream) with
>>our local version, which are divergent and most likely will end with
>>conflict.  Instead, we do git fetch first followed by resetting to
>>upstream by git reset --hard origin/seen.
>>
>>Should the fact above be documented? And on what file the fact should
>>be placed? In INSTALL?
>
> I vote yes. I was trying out tracking the different branches and got
> bitten by this very situation (tons of conflicts) when pulling seen.

I vote checking for existing docs before doing this, though.  I
would be surprised if we do not say "do not build on (fork from)
'seen' (formerly known as 'pu')".
