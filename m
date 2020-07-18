Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D151C433DF
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 17:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86E920717
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 17:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D/izU6Vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGRR4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:56:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50311 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgGRR4r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 13:56:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A21F8CFB15;
        Sat, 18 Jul 2020 13:56:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cJUFYxVp/W2wk0+cQPUjMiv3Obg=; b=D/izU6
        VxkXds9pGWAk7s8C7ajbJXZZNHZ6bjeWUVKEsgucvXtyJl6pVX1gwHrgDyKeQ51o
        5u4pSvezuB+/aBVVNjUMpWJW8/eZ5Pcc7x79laZv/iUTScnt9hvgd+SFIOCyqkc+
        FC8MueZ5k/5e2hzwWMbxtCVJU1RNcAalFm9sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nuu1Ze7iiiBXIrRK5iuM2Qa5XUAMaTdZ
        ll2QYp/wkTpReTMUnwiS8/5juS83m0ikAQSg5/Hm2b8AhbiNu4Zx9mPUoDaFc97n
        13YzVCPou0m6NDHly/IpBNuDdPXWrBsVNtodj/NteJygDVcZoInKXfKBsgc5j7GD
        0X1L6Qx3skE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BD4ECFB13;
        Sat, 18 Jul 2020 13:56:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C7B00CFB12;
        Sat, 18 Jul 2020 13:56:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.28.0-rc1
References: <20200718011007.6808-1-johannes.schindelin@gmx.de>
        <8ed2217b-f04d-f7f7-4c1d-5010aee92f5d@gmail.com>
Date:   Sat, 18 Jul 2020 10:56:41 -0700
In-Reply-To: <8ed2217b-f04d-f7f7-4c1d-5010aee92f5d@gmail.com> (Derrick
        Stolee's message of "Fri, 17 Jul 2020 21:16:23 -0400")
Message-ID: <xmqq1rl8d7vq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09C63156-C920-11EA-B83F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/17/2020 9:10 PM, Johannes Schindelin wrote:
>> Dear Git users,
>> 
>> I hereby announce that Git for Windows 2.28.0-rc1 is available from:
>> 
>>     https://github.com/git-for-windows/git/releases/tag/v2.28.0-rc1.windows.1
>
> While this (automated) email came from Johannes, I want to point
> out that I'm taking point on this and the remaining releases of
> Git for Windows in the 2.28.0 cycle while Johannes takes a well-
> deserved vacation.

Thanks, both, for keeping the safe bus factor ;-)

