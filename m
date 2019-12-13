Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFD4C4D2D5
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6F62477D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AHx/FUcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfLMT6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:58:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53306 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfLMT6q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:58:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72FB5A7C4F;
        Fri, 13 Dec 2019 14:58:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H5EHBHn6VSBIJyi74nt/9BPmeMw=; b=AHx/FU
        cTDvrkoi9wtlnkLRLVH+beD+lmvqqnTLdPQKxWTAyV2JB0bADa1GwxVm8ygG2Fh+
        3DRZIjW4ydAjdXAb6wVen2D3c/Nm+jz68KXhCpW2HlMSumL2FsBr4HVeNR/DmKP5
        isDLURj0OjCbV2epw/nA1P1/Lm2STrUlEjcGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fx5AVizsKsD94u9Q1kwuyTFpZ3Sd9O1F
        5HUF63QuiiBDtdb0euEiOueiL6lKLoe8Cy0fYuI514coeggz5AkCrPvJbeRhVxFS
        oMm4eOcjM8d2aFevgtH+6x5T2xGY7KejPGqMT5E5KfHjILP1Y7rm1TknwS1gGGde
        OVwXpHqcNHE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5332DA7C4E;
        Fri, 13 Dec 2019 14:58:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 776B6A7C4D;
        Fri, 13 Dec 2019 14:58:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 0/1] sparse-checkout: respect core.ignoreCase in cone mode
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
        <pull.488.v2.git.1576260593.gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 11:58:40 -0800
In-Reply-To: <pull.488.v2.git.1576260593.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 13 Dec 2019 18:09:52
        +0000")
Message-ID: <xmqq7e30j8un.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F695BD7E-1DE2-11EA-9881-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> case-insensitive check when core.ignoreCase is set. Because the performance
> impact is much lower than I anticipated, I no longer think it is important
> to add a new config option to enable/disable this logic.

Nice.

Thanks.
