Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D648BC4743D
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 06:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC85F60FF4
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 06:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhFKGeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 02:34:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50566 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKGeA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 02:34:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA60ACC753;
        Fri, 11 Jun 2021 02:32:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ju7m7KgvokbL8SRrUNKJfYUklGuUNH3pMYnptk
        HvINM=; b=HCdmpSo9qGzCGd1n6onFVzybb6QVyUP69z/7veOKjYW2etRPaiwyD4
        N8yb+Wamno6dK3VfHRdr+zsN7hQoRuHk+fKKa6jvx4JVpM8fXyinI0Ae/4I11CwD
        vnlml9bQJDJWhgSUTILGigHdYty5hqTfhr2SiDeXh8itiYMI725A8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2FCCCC752;
        Fri, 11 Jun 2021 02:32:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28F93CC750;
        Fri, 11 Jun 2021 02:32:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 10/28] t/helper/fsmonitor-client: create IPC client
 to talk to FSMonitor Daemon
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <d21af7ff842c2a2642ae42df7b972a8817b8a3e8.1621691828.git.gitgitgadget@gmail.com>
Date:   Fri, 11 Jun 2021 15:32:01 +0900
In-Reply-To: <d21af7ff842c2a2642ae42df7b972a8817b8a3e8.1621691828.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Sat, 22 May 2021
        13:56:49 +0000")
Message-ID: <xmqq35to52u6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB4AB9BE-CA7E-11EB-87D1-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +#include "test-tool.h"
> +#include "cache.h"
> +#include "parse-options.h"
> +//#include "fsmonitor.h"
> +#include "fsmonitor-ipc.h"
> +//#include "compat/fsmonitor/fsmonitor-fs-listen.h"
> +//#include "fsmonitor--daemon.h"
> +//#include "simple-ipc.h"

Please never commit a commented-out code.  Comments are for humans
(and they shouldn't use the // style in this project)---use removal
for machines.

Thanks.


