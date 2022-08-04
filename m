Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFDAC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 17:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiHDRWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiHDRWN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 13:22:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040F9DDE
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 10:22:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 849BD1BDFC3;
        Thu,  4 Aug 2022 13:22:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GstIqMlzVPKl9UQc0zadPwVAKhygmRl1eZLhQh
        EX0OE=; b=DoPuWZNpge2Ue33A4LXCd8HGO7tR5YXHGH8W0ITrJg33Bv7S2lcmtW
        4MCCu+6SEAMFVqRqe4nZdGOe7sA41DFD9R+oxWmSgqJ1YoOpJvj/MLwytNX6eD3Q
        QdjAayXgpRSez7VjXALwP8A8PX+XEW24O3ASvQqNCyGPuYWHYTuQ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C3311BDFC2;
        Thu,  4 Aug 2022 13:22:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 288961BDFBD;
        Thu,  4 Aug 2022 13:22:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 00/10] Generalize 'scalar diagnose' into 'git
 diagnose' and 'git bugreport --diagnose'
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 10:22:08 -0700
In-Reply-To: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com> (Victoria
        Dye via GitGitGadget's message of "Thu, 04 Aug 2022 01:45:33 +0000")
Message-ID: <xmqqwnbn6i0v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F85AE38E-1419-11ED-9806-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * (Almost) entirely redesigned the UI for generating diagnostics. The new
>    approach avoids cluttering 'git bugreport' with a mode that doesn't
>    actually generate a report. Now, there are distinct options for different
>    use cases: generating extra diagnostics with a bug report ('git bugreport
>    --diagnose') and generating diagnostics for personal debugging/addition
>    to an existing bug report ('git diagnose').

An additional command gives us far more design flexibility, and in
this case I think it may be worth it.  It has a risk of confusing
users between "git bugreport --diag" and "git diagnose --report" a
way to send a report with diagnostic information, though.


