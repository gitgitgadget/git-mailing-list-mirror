Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF00C433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 18:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380011AbiD2Sxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 14:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357909AbiD2Sxa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 14:53:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C293B2
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 11:50:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A23711B553;
        Fri, 29 Apr 2022 14:50:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7PvzrqIoHBuOF4XAJZ3ENXvKyo21nmXMQDD31Y
        WeClI=; b=lk92cc6Fn3w4A7PPTKN58MXrI2IV4fIQNV503pdZKL394OVdSOaOoe
        MAl8tX4E1pmmV+4UeuNhwGQkkFFXW0PzjeOMl3JigZt4yflTcffv18oY3mg7O50r
        tp57Me4tqNAPDHx4FDuGDgw41BeR4ZjI/8LmvtUsh3y4ZfLcekcoE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8F5A11B550;
        Fri, 29 Apr 2022 14:50:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 204DB11B54F;
        Fri, 29 Apr 2022 14:50:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v5 0/3] New options to support "simple" centralized
 workflow
References: <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
        <pull.1161.v5.git.1651226206.gitgitgadget@gmail.com>
Date:   Fri, 29 Apr 2022 11:50:04 -0700
In-Reply-To: <pull.1161.v5.git.1651226206.gitgitgadget@gmail.com> (Tao Klerks
        via GitGitGadget's message of "Fri, 29 Apr 2022 09:56:43 +0000")
Message-ID: <xmqqk0b7bu77.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F9B5F8C-C7ED-11EC-9485-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patchset introduces two new configuration options, intended to be
> consistent with and complementary to the push.default "simple" option. It
> also improves remote-defaulting in "default push" scenarios.

Thanks.  I still do not know offhand if the 'simple' thing makes
sense without thinking it through, but I think that the 'missing
origin is fine and we can use the unique remote if exists' is a
really good idea, especially if some push strategies already do so
and some don't, which seems to be the case.

Will queue.
