Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13BCC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFA3610CA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhJ1QBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:01:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61786 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhJ1QBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:01:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 714BEF76DC;
        Thu, 28 Oct 2021 11:58:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UYya4Nc1v0hhZ8KvvsltirSTGEUGda8fM662e6
        wAdfw=; b=x1sfsILeyn97FlyXmtu2n5h5ecTXBur4zvioEXrZ6wHj29/Pe5wnH5
        3oRMaRdZAZAePaOjOApMFasV6C3VFko/ktpYKswW8LRx+cvpYDzooQNBmoabcWCK
        ev2gnCSorB4CgkmNcIVthx+t/3e1MWfXCt7CPoTbvfDqAhyzKi/2I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67D8CF76DB;
        Thu, 28 Oct 2021 11:58:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0F75F76DA;
        Thu, 28 Oct 2021 11:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        newren@gmail.com, vdye@github.com, derrickstolee@github.com,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Sean Christopherson <seanjc@google.com>, l.s.r@web.de
Subject: Re: [PATCH v3] add, rm, mv: fix bug that prevents the update of
 non-sparse dirs
References: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
        <b203cc8866b1a8d8397554aa17f918878b8c1133.1635430822.git.matheus.bernardino@usp.br>
        <adb3e031-fe82-37ce-0967-a28aecb07035@gmail.com>
Date:   Thu, 28 Oct 2021 08:58:42 -0700
In-Reply-To: <adb3e031-fe82-37ce-0967-a28aecb07035@gmail.com> (Derrick
        Stolee's message of "Thu, 28 Oct 2021 11:06:03 -0400")
Message-ID: <xmqqh7d1ta31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED4BD8FC-3807-11EC-8C8A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 10/28/2021 10:21 AM, Matheus Tavares wrote:
>
>> Since v2:
>> - Added comment about executing only one iteration on cone mode.
>> - Split for loop line for better readability.
>> - Stopped loop through "path" at first element to avoid an undefined
>>   behavior.
>
> Thank you for these changes. I'm happy with this version.

Thanks, both.  Will apply.
