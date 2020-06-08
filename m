Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23EFC433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 17:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C897208A9
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 17:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KHXlwZpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgFHRjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:39:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55287 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbgFHRjt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 13:39:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4802273EA8;
        Mon,  8 Jun 2020 13:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HZwTIuu+V53k0JfrZYTfK+0v/lM=; b=KHXlwZ
        pbliFI7WNsN8dWw6LQYftvMOIxqLy/XYvZ68JxlE/10An18LNYYnxMwNjEAAS8ta
        Pfz1W77afcTQaGKWyA8sPE6M83HReZlX8U2+G68ZX61swiWVl053MHJ0umZVuYEV
        M6CZMIDanINkDq7D5TRRKBT2rollR1k+Q3VKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UIyCberq+PetHKAwAx8quTnus7UR6z8O
        FAErZxH9AiM/pYtkswV7nMwQ39OlxjpMoc7xZnomFKLxf8cLv1Wc1hY6+EMoYerY
        phHS/3lG41VfdG4AsY/D/kSqiLVcQCXcviffVHfqCNvgXtScMkeGGDW/0C0ZKY6y
        M1mBVJSid44=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F78873EA7;
        Mon,  8 Jun 2020 13:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A7B673EA6;
        Mon,  8 Jun 2020 13:39:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, szeder.dev@gmail.com,
        jnareb@gmail.com, peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/10] Szeder's commit-graph cleanups
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
Date:   Mon, 08 Jun 2020 10:39:45 -0700
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Fri, 05 Jun 2020 13:00:22 +0000")
Message-ID: <xmqq8sgxlan2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B7B9300-A9AF-11EA-9243-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is based on ds/line-log-on-bloom.
>
> Since Szeder so kindly shared his alternate Bloom filter implementation [1],
> I thought it worth my time to start the process of updating the patches to
> apply to more recent code in Git. Here is the effort to update the almost
> obviously-good commit-graph cleanups that he presented in that series.

Very pleased to see collaboration.
