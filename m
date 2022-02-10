Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2984BC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 20:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbiBJUPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 15:15:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344155AbiBJUPo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 15:15:44 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314525589
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 12:15:45 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFE96197EB9;
        Thu, 10 Feb 2022 15:15:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kxLVOa84hplIOlBZnIphlRe8BfJxY3NpYM6NFT
        S3w4Y=; b=PYzPEKkoi/AdQoj3zUoOqp0+TgrjA+M8uf3YzFvKi03/7ZhlRDZYeZ
        IGV3Qwquej4veFcmoOp8CmIb7AgVQPFikysYyTH25JoayV7GcqVASnjQnA7v0QVF
        URmXKvzwzkY9CdCV8Lt54+ZT5z/B77yZlOshfdmDB1UgtV5kTL7y4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8E07197EB8;
        Thu, 10 Feb 2022 15:15:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1E7DA197EB7;
        Thu, 10 Feb 2022 15:15:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, paulus@ozlabs.org
Subject: Re: [PATCH 3/3] gitk: set log.graph=false when running `git log`
References: <20220209162350.169971-1-alexhenrie24@gmail.com>
        <20220209162350.169971-3-alexhenrie24@gmail.com>
        <xmqqzgmz7v6k.fsf@gitster.g>
        <CAMMLpeRf=BV3y2AF7AssOw3tOFn-hawsyhFaxLhCrz28kbq+NA@mail.gmail.com>
Date:   Thu, 10 Feb 2022 12:15:40 -0800
In-Reply-To: <CAMMLpeRf=BV3y2AF7AssOw3tOFn-hawsyhFaxLhCrz28kbq+NA@mail.gmail.com>
        (Alex Henrie's message of "Thu, 10 Feb 2022 09:50:16 -0700")
Message-ID: <xmqqfsoqfpg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38ABFFAE-8AAE-11EC-844E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> On Wed, Feb 9, 2022 at 11:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> This may handle "gitk", but what about thousands other scripts
>> people have developed around "git log", I have to wonder.
>
> That's true, but every new preference carries that risk, and there's
> not much we can do about it. Users who set log.graph=true will just
> have to accept that it won't be compatible with every tool in the
> wild.

I wouldn't call something that is known to break people before it is
released to the wild a "risk", though.
