Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE904C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 07:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C29860FE9
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 07:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhDAHHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 03:07:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54791 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbhDAHHL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 03:07:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CECC5127A45;
        Thu,  1 Apr 2021 03:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=NyZfJCYyCLyGzyVhRvizXGuKK4k=; b=InE/AzZtMXIjN+EuPmSM
        qnmxGgz9LMZE5Mgb5TkOYDzEcL0RJBj5e/iviKQQmOKcrt8D3AEcAZd62VQ/bF0Q
        8DwM5vv0J6GAPJCwi9/hGFIYAf7eowXe9Pk+QlRv34ApO7sFpt8kjy1dk2yik5Gp
        WzNNmmUDOqr50ATkqQWFJSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=LuY8ANAyJU6kdPp2gH+V/2Zlm9ExfYzM1B57kV0M95XHH4
        7rPDSqwk+UvhG4y1bn+zGfPS50pDheluWygGzcB+yMUALTc9k7VZziiFasiWS/Fm
        MMU3W9h422hEQ5kqHPmRR10awkdIKNMRhBCBj9dFpj/0PklKnz+jkp99NJaGs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7537127A44;
        Thu,  1 Apr 2021 03:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 09D07127A43;
        Thu,  1 Apr 2021 03:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 00/25] Sparse Index: API protections
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 00:07:06 -0700
Message-ID: <xmqqv99632lh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF28CC66-92B8-11EB-82E1-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here is the second patch series submission coming out of the sparse-index
> RFC [1].

Queued.  There were a few conflicts with new codepaths and I've
touched up a few of them (Alban's merge-strategies-in-c moves some
code that needs to dehydrate the sparse index entries from
builtin/merge-index.c to a new file, Elijah's ort has "const"
pointer to the istate that you need to be writable), but there may
be more that I missed.  Please check the tip of 'seen' when it gets
pushed out.

Thanks.
