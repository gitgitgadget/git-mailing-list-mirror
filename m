Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0558C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 20:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiADUfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 15:35:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51339 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiADUfy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 15:35:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A71A0F9838;
        Tue,  4 Jan 2022 15:35:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n9/7VLwMsvBmpSa738CN9IfrStQCeZLMbJym5z
        LTYz8=; b=S2Vk6YW7IbNRJCqI2VcQj3w5oKU9PjQVFcYqI50BPu+XxF2Z/Xj/Ue
        NA1mF095leEHk2XAWqEQ6YKE3K/KsiRS2sIRofCYOpX+Z1S3g05NGLv1CM8DP7GQ
        eKDoJt0SqtFXPty9zY75jWw6pg9ago+6p2mELH4tIwg8tgtaEHLOc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98E4AF9837;
        Tue,  4 Jan 2022 15:35:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB5ADF9836;
        Tue,  4 Jan 2022 15:35:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/1] push: make 'set-upstream' have dafault arguments
References: <xmqqy23wduxp.fsf@gitster.g>
        <20220104132839.1209-1-chakrabortyabhradeep79@gmail.com>
Date:   Tue, 04 Jan 2022 12:35:51 -0800
In-Reply-To: <20220104132839.1209-1-chakrabortyabhradeep79@gmail.com>
        (Abhradeep Chakraborty's message of "Tue, 4 Jan 2022 18:58:39 +0530")
Message-ID: <xmqq35m3ck7s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E90700F2-6D9D-11EC-AD5B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> * For push.default=upstream, If an upstream is already defined then
>   'git push -u' should only set that branch as the upstream of the
>   local branch. This already works in git. But if an upstream is not
>   provied, it should throw error. So, I am not sure whether 'git push
>   -u' (with no upstream information) should create a new branch with
>   the same name or not. What do you think about that?

I think erring on the side of caution is more sensible than blindly
assuming that the user wants a new branch with the same name.

Thank you for working on the topic and thinking its ramifications
through.


