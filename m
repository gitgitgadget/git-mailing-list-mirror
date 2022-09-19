Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6325ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 18:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiISSQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 14:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiISSQq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 14:16:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42BF4663B
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 11:16:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5159140892;
        Mon, 19 Sep 2022 14:16:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hETucSEW70LGpq3mB3dSyl5B8RpIjjWB4TM838
        K8EGk=; b=AgWsjx12E38weO23EdSZRbqdr2AnoM0S2unrXT67MmlFAV3RXH2fGL
        EwNR7fWaa1jeZdb6/AdejVn9hekIchF6+sYq26wLxpj8e5oSc1GoLh7VivjMZz+z
        CCEsjF7HzEfe5tdgGuZ9eUtzv8PSlSjavYAh72sGmDRO9ftZuW3uo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC132140891;
        Mon, 19 Sep 2022 14:16:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4EE43140890;
        Mon, 19 Sep 2022 14:16:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v2 2/9] bundle-uri: use plain string in
 find_temp_filename()
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
        <ee6c4b824c276364b77de0b85b54f428c236de00.1662734015.git.gitgitgadget@gmail.com>
        <xmqqczc4l9di.fsf@gitster.g>
        <a492902d-7227-3172-9f73-3ddea51cf2c5@github.com>
Date:   Mon, 19 Sep 2022 11:16:30 -0700
In-Reply-To: <a492902d-7227-3172-9f73-3ddea51cf2c5@github.com> (Derrick
        Stolee's message of "Mon, 19 Sep 2022 13:54:35 -0400")
Message-ID: <xmqqmtav9qm9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FC24C44-3847-11ED-A236-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> ... something deterministic based on the URI so
> we can restart downloads that were halted, even if the process needs
> to restart. But for now, this change helps us to remove the strbuf
> from the remote_bundle_info struct.

Yay for a bright future ;-)

Thanks.
