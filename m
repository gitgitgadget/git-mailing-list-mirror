Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D40C83F01
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 06:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjH3GUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 02:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241050AbjH3GUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 02:20:24 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7FFE4C
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 23:20:03 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0F721B4141;
        Wed, 30 Aug 2023 02:19:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lbwffyuSh2BZeScoJVv77kbdxXU/nf4ygPCkOd
        jFUPU=; b=V9IRkQ8J1gmbc/5toGiyOtk8HjMlilNQEtFXIxjUqGPIT53M/Aa/OI
        CBIjeCR2DEqkFExly2gaYstyiCJtJhTt848Al3pQXTvH6owZfL+5ACGVYdZxTdaM
        1xXIKyXmueSxhthlr8po04APi2OJ83Qqk2noMT7dYtP4rt9WAFqvw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C87361B4140;
        Wed, 30 Aug 2023 02:19:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F9991B413F;
        Wed, 30 Aug 2023 02:19:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci(linux-asan-ubsan): let's save some time
References: <pull.1578.git.1693304963963.gitgitgadget@gmail.com>
        <pull.1578.v2.git.1693342048633.gitgitgadget@gmail.com>
        <20230830002801.GB227310@coredump.intra.peff.net>
Date:   Tue, 29 Aug 2023 23:19:57 -0700
In-Reply-To: <20230830002801.GB227310@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 29 Aug 2023 20:28:01 -0400")
Message-ID: <xmqqsf819hma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EEDD484-46FD-11EE-9612-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 29, 2023 at 08:47:28PM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>>     This commit is an attempt to reduce the pain and suffering stemming from
>>     this particular job, simply by deciding that the benefit of running the
>>     Python/Subversion-related tests in that job is far outweighed by its
>>     cost.
>
> FWIW, I am in favor of this patch. I've had the same thought many times
> but was worried I was being too dismissive of p4/svn (which I personally
> do not care at all about). Omitting them from the sanitizer job (but
> still running the basic svn/p4 tests elsewhere) seems like a good
> compromise.

Exactly my feeling.  Thanks, both.
