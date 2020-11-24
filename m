Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B82EC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759DF20715
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jgNw8ZjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbgKXVvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:51:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64766 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731557AbgKXVvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:51:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D642F2DB3;
        Tue, 24 Nov 2020 16:51:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v+KnuOfIVyc4ydp2bUGP/zAdtu0=; b=jgNw8Z
        jP6JI75dkOOB8TMhmlhE352rE8ktJd7i/YSSjD4+hY9Wc33yQAK5+aC/yLEjAlPS
        96IBZqOrN/yp/Yw7fzZXGJf3dC3iKCUs5PxPT+nhS59FHqRRJxDXboHjw3N3B9vm
        KOpBEnR8DzxP9LvMnihFMjIYDQWhrGhErssf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qbl1HGbn17gRhOToVXfUIPRfMKFEdokX
        taXIvRJCI73qoKOLhojhvSMCAtgmGGG1qcFy/gOxrXu+v9AZZE8hqdKhrqKzRE10
        Fuv28qLNQhlva0GR1WKeJ/60jU7SLVpNpZzmryR/ioV3S2pARZq8KfNUjgDgBloG
        D89Fsd44gkg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A27BF2DAA;
        Tue, 24 Nov 2020 16:51:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 833C2F2D9D;
        Tue, 24 Nov 2020 16:51:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] move sleep_millisec to git-compat-util.h
References: <pull.922.git.git.1606245012068.gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 13:51:16 -0800
In-Reply-To: <pull.922.git.git.1606245012068.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Tue, 24 Nov 2020 19:10:11
        +0000")
Message-ID: <xmqq8saqifu3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2ED843AA-2E9F-11EB-94CC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The sleep function is defined in wrapper.c, so it makes more sense to be a in
> system compatibility header.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>     move sleep_millisec to git-compat-util.h

Makes sense.
