Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C27C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5671861249
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhGLVaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 17:30:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60656 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbhGLVaX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 17:30:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65298CD4F0;
        Mon, 12 Jul 2021 17:27:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O1ST+FwS5vwkub2HA13EFQdF64v+H+uCrXXHOE
        1kOIk=; b=Nzp5r7pWATdI6Z3kZE85VY+8fxvKKAGU4K7oMMbcSZnLtOIeQZBtCp
        upguMviQIQhQ4TWLH84Ea2U3T4tFrQpEvuVRR9/AdbLFQQz7XquQsz1yyjsGqeGF
        nXVHquZtFHwBj7F/dbfwsgHwjNCOqRIBWJShNq0+yxgKdjFb+5jig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C2A7CD4EF;
        Mon, 12 Jul 2021 17:27:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3EC2CD4EE;
        Mon, 12 Jul 2021 17:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] doc: clarify documentation for rename/copy limits
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
        <7dc448df6ec6edb41464a4115017064cf41b2d83.1625964399.git.gitgitgadget@gmail.com>
        <c25e29a9-3a15-4079-43fd-b77746927b16@gmail.com>
Date:   Mon, 12 Jul 2021 14:27:33 -0700
In-Reply-To: <c25e29a9-3a15-4079-43fd-b77746927b16@gmail.com> (Derrick
        Stolee's message of "Mon, 12 Jul 2021 11:03:09 -0400")
Message-ID: <xmqqh7gz2pfe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8B950A2-E357-11EB-841E-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>   merge.renameLimit::
>       The number of potential inexact renames to consider when
>       performing rename detection during a merge; if this limit
>       is exceeded, then no inexact renames are computed. Renames
>       where the content does not change are excluded from this
>       limit. If not specified, defaults to...
>
> Feel free to take or leave any of this example.

Phrases like "finding inexact renames" and "finding which files were
moved with changes" may tell what we are spending cycles on to the
end user, but I have to say I agree that "quadratic portion" would
not resonate with the intended audiences at all.


