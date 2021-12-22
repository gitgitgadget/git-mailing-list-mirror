Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6649DC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 22:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbhLVW5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:57:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54768 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhLVW5C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 17:57:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 226EA151EF3;
        Wed, 22 Dec 2021 17:57:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Eo/JgmmOEdpzk+CGXpYR90JU/dpZluOyslkoe
        qcE5w=; b=xVY8yB7ddFK8EEDtGjEwzd2TJYyn+kN1wEtbLu2tspL6Jc96Yyy8eM
        ST+QsgMl9SqJlOHYDRPDFu0IQrapZzPHLs76f7lCNZ/QFoxCs99bOaU0C6+BuHCb
        zfGycOK29fyg8V98eC/LqmYIRoh9PpfT8l/BifoI7OVPZzkuSVuvQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A4BF151EF2;
        Wed, 22 Dec 2021 17:57:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 68FE3151EEF;
        Wed, 22 Dec 2021 17:56:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/9] trace2: defer free of TLS CTX until program exit.
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <e0c41e1fc7895ba67d7536115cd8c1598439ded1.1640012469.git.gitgitgadget@gmail.com>
        <xmqqlf0equs3.fsf@gitster.g>
        <a6f2a38b-926a-4b47-fd3f-b1327a7c3fcb@jeffhostetler.com>
Date:   Wed, 22 Dec 2021 14:56:56 -0800
In-Reply-To: <a6f2a38b-926a-4b47-fd3f-b1327a7c3fcb@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 22 Dec 2021 16:59:18 -0500")
Message-ID: <xmqqwnjwdz9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 778C0AA8-637A-11EC-8B8D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I hadn't really thought about the term "TLS" in the context
> of crypto -- I had "thread local storage" on the brain.  I guess
> I've spent too much of my youth using Win32 thread APIs. :-)
>
> Let me take a look at removing those terms.

Nah, it may be just me.  As long as what TLS stands for is clear in
the context, it is fine.
