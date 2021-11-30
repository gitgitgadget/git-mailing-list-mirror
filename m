Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFCDC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 06:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbhK3Gut (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 01:50:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51263 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbhK3Gut (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 01:50:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08E6BEA837;
        Tue, 30 Nov 2021 01:47:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W7urBauzKXzjBfsO4lTTEO43Wr5sA1NUd/1WAj
        o490U=; b=uvbtcg6ij3h9k3GlSfMmW3EHxrb5zumMl4A4c/peyxFgkoKOBToFvg
        4VLO6BSOqpfAcV5lnbJZrFafSmT5yW4LQ5SKffj38ClHQLrqTKPl0dC65z7TjMIN
        7qvkn/GC32NH6P2nL3SXq3kIWzGK39GQyU6rOrUI2SRoAnkMjGaWo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2C14EA836;
        Tue, 30 Nov 2021 01:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66906EA833;
        Tue, 30 Nov 2021 01:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 01/11] t2501: add various tests for removing the
 current working directory
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
        <a45b3f088025795d11a78055f90b8632d435d74f.1638225434.git.gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:47:28 -0800
In-Reply-To: <a45b3f088025795d11a78055f90b8632d435d74f.1638225434.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Mon, 29 Nov 2021
        22:37:04 +0000")
Message-ID: <xmqqilwa2l8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63076B5A-51A9-11EC-9A06-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +		# Although we want pwd & git status to pass, test for existing
> +		# rather than desired behavior.
> +		if test "$works" == "success"

Don't double "=" here.  We are not writing for bash.  There are a
few more instances of the same mistake in this patch.
