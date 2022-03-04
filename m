Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF3C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 22:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiCDW1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 17:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCDW1d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 17:27:33 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1358C1C8871
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 14:26:45 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72860112693;
        Fri,  4 Mar 2022 17:26:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6eTNjG1n96IBuGWEsmSC/oHtvO4lIUb5/4lnhf
        C8hJU=; b=j5h1zSLMHZTBMgEBhIN+7L7J5eOAxOZLsWGIo+lChpfWxqruxJZXQA
        y1HKdadsi8suzazDg2ltvs+Wmkeb7YjVdZuYutZvjNPjzr6FEwseDKmP21yPTGnF
        i2ZhXOEgUjbFHf0tYpX3VhdcusfPvSEQQlwU3ov1Y+wcUMCHjmGfw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A557112692;
        Fri,  4 Mar 2022 17:26:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B2F5112690;
        Fri,  4 Mar 2022 17:26:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 04/11] pack-bitmap: drop filter in prepare_bitmap_walk()
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <888774f6f28b291c928041a32c3df360cee13d10.1645638911.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 14:26:42 -0800
In-Reply-To: <888774f6f28b291c928041a32c3df360cee13d10.1645638911.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 23 Feb 2022
        17:55:04 +0000")
Message-ID: <xmqq5yotz74t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B8D149E-9C0A-11EC-8D3C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> Now that all consumers of prepare_bitmap_walk() have populated the
> 'filter' member of 'struct rev_info', we can drop that extra parameter
> from the method and access it directly from the 'struct rev_info'.

This step is a logical consequence from the previous few steps.
Very pleasing.
