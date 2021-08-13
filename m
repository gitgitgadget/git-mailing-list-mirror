Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6FBC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C3060F91
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhHMUxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 16:53:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51881 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhHMUxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 16:53:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D414156598;
        Fri, 13 Aug 2021 16:52:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9xJAbHsPkWNPAysHDYvntAjBA+ug1KB83zs4Ph
        fmNXw=; b=sBdxB6xVrhs7uVbn6tWVMj7oE0TGX2KOBvn+E9x0J4jmnzdnUaFBzb
        nn/5BMxtfdJAmyM+MpDCK07lHi52z5VkRvEp4sLIW1FghEW0R9QvkxlzoW3iuakN
        QcUJn4udmenDFotC3SPwHlUBT3MO4sNZ8YXFeRBzRMw2cNsSyr5cQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56765156597;
        Fri, 13 Aug 2021 16:52:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A66A156596;
        Fri, 13 Aug 2021 16:52:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
        <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
        <xmqqeeaz70ph.fsf@gitster.g> <YRW0pGXXWnY7C470@google.com>
        <xmqqpmuiynbs.fsf@gitster.g> <YRbU0uBxqinQ1EnE@google.com>
Date:   Fri, 13 Aug 2021 13:52:36 -0700
In-Reply-To: <YRbU0uBxqinQ1EnE@google.com> (Emily Shaffer's message of "Fri,
        13 Aug 2021 13:23:46 -0700")
Message-ID: <xmqqlf55ukx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64F80F04-FC78-11EB-9AAF-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Yeah, since writing my reply I was very helpfully reinformed on the
> convention around 'feature.experimental' by Jonathan N off-list. Thanks
> for being patient with me.

You may (or may not) have noticed it, but the entry for the topic in
the last "What's cooking" report pretends as if we have already
concensus that it is a good thing to do and be made default.  As it
seems to be valid use cases to have submodule.recurse not set to
true even when you have submodules (a clone of Rust Jonathan N uses
you mentioned in the other message, perhaps?), it probably does make
sense to initially make this opt-in and also keep opt-in, not as a
candidate for future default, but we'll see.

Thanks.


