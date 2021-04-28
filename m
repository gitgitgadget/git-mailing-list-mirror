Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFD7C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 00:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9E9610A5
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 00:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhD1Ao0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 20:44:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62996 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhD1Ao0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 20:44:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12743AD3F5;
        Tue, 27 Apr 2021 20:43:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qcqVmfx0cB6I3zZZIKXeS+imMNex7mePX7ClxU
        5/JGo=; b=kYihHUECazoMwmxdR5fgN9MZzM9btxHhJRjW2xV6W09oErVw3BJLuB
        QB16XV8+i2cQfzmbBHT7BdyWt1D+QXymtQQA4ftfvsofPm0unOMMXJmen4lGd8yk
        WsNnMXdQ2VgJFjqiLVYNjgtlEkmFQ+CE24EKyTl4h+pJJrMycHR60=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09126AD3F4;
        Tue, 27 Apr 2021 20:43:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D317AD3F3;
        Tue, 27 Apr 2021 20:43:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH v2 09/12] mailinfo: also free strbuf lists when clearing
 mailinfo
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
        <217f571f8ef5f3a46c0cbb1ceca022a18e5b43d2.1619360180.git.gitgitgadget@gmail.com>
Date:   Wed, 28 Apr 2021 09:43:40 +0900
In-Reply-To: <217f571f8ef5f3a46c0cbb1ceca022a18e5b43d2.1619360180.git.gitgitgadget@gmail.com>
        (Andrzej Hunt via GitGitGadget's message of "Sun, 25 Apr 2021 14:16:16
        +0000")
Message-ID: <xmqq8s53dyrn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C764A980-A7BA-11EB-AD5A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:
> However, strbuf_list_free() cannot handle a NULL input, and the lists we
> are freeing might be NULL. Therefore we add a NULL check in
> strbuf_list_free() to make it safe to use with a NULL input (which is a
> pattern used by some of the other *_free() functions around git).

OK.

Thanks.
