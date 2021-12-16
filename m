Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C30C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 19:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240872AbhLPTQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 14:16:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62439 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbhLPTQk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 14:16:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D974C17749D;
        Thu, 16 Dec 2021 14:16:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F42J2Yade07tITJ76SgOuPrR9Ndf0diOpBOx1D
        fW/bM=; b=E9zaZUxDh7uFUjVvbW2ikhrtwfu8D/IeS50yYhPNF/rY1x+yeJMgRZ
        dTZj+thL5mpDz1gwgMRhawYpk8Pqxk4if0u8aqQj16GlFXDLJb9OjFcBcGkOmSRm
        AuGtoWcUGWh8VH6NmhtIBjOS3t1uMR5sjDiHoRmZEToWbIuXcrO3w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2F6917749B;
        Thu, 16 Dec 2021 14:16:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 278A4177496;
        Thu, 16 Dec 2021 14:16:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/3] sparse-checkout: fix segfault on malformed patterns
References: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
        <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
        <xmqq5yrp61lw.fsf@gitster.g>
        <e0f90c01-f987-1c9c-cd93-393d0dc6e0dc@gmail.com>
Date:   Thu, 16 Dec 2021 11:16:34 -0800
In-Reply-To: <e0f90c01-f987-1c9c-cd93-393d0dc6e0dc@gmail.com> (Derrick
        Stolee's message of "Thu, 16 Dec 2021 09:24:35 -0500")
Message-ID: <xmqqo85gbbsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFFB92BC-5EA4-11EC-974A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> Thanks.  The segfault fix matters even more with Elijah's "we can
>> flip between modes" feature, right?
>
> Generally, I think segfaults are a higher priority, but this one is hard
> to find in the wild, I think. I'll send a v4 today and hopefully it makes
> it an easy decision for you.

I agree about the priority and I was assuming that the topics do not
have semantic conflicts we cannot reconcile, but I do not offhand
recall what the other topic did when there patterns unsuitable in
the cone mode when transitioning to the cone mode (or vice-versa for
that matter).
