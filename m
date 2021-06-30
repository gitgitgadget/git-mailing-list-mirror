Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D502C11F66
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 22:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6176128E
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 22:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhF3WGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 18:06:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64687 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhF3WGv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 18:06:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9277813BD8F;
        Wed, 30 Jun 2021 18:04:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ia1oeMC9CQYP0Sf1FRlbUhKN1/ooqpdyYxgeE6
        7Tymc=; b=VEb/1wiL20f09pwd7KljSSSrv6YQCEulQsP6KONFaLKTKy38nfdnQ7
        b3rYU5KNFWo1n1CU6WRPm1o8NGhwKpXJkgPJb4TEEFx1VOgbkHdyY7Mc/0wKPI1j
        fJQF+Lq8fEyqZQAjaNZJWMPO21+aQB6InGv8AWmiOoF/iG39hXtsw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8ADA813BD8D;
        Wed, 30 Jun 2021 18:04:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D68D913BD8A;
        Wed, 30 Jun 2021 18:04:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v6 00/15] [GSOC][RFC] cat-file: reuse ref-filter logic
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
        <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
Date:   Wed, 30 Jun 2021 15:04:18 -0700
In-Reply-To: <pull.980.v6.git.1624797350.gitgitgadget@gmail.com> (ZheNing Hu
        via GitGitGadget's message of "Sun, 27 Jun 2021 12:35:35 +0000")
Message-ID: <xmqqbl7nt3fh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E9D4D86-D9EF-11EB-AC3F-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series make cat-file reuse ref-filter logic.

Unfortunately this seems to interact with your own
zh/cat-file-batch-fix rather badly.

