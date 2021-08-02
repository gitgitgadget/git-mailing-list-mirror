Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA39C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FF161051
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhHBUHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 16:07:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63578 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhHBUHR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 16:07:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27979158A48;
        Mon,  2 Aug 2021 16:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=68wg0AC9zNj9ym++zWa5rkfuI4lRaffNfizm33
        lkml8=; b=mSY+rHcG1BQ/a+SpQohbVdbFYZ52yiFpgyvBdkB4nqvQUXSyfcpii8
        tbXnmWgEEvJhJhq/KSBHpqBJMlOjTWxdXOM9nt/Mru7XaRFPqb3+dnhNplHo19zY
        80efCAvSSlOzkxeY225JRSEeGipq5GKQbahJ/FrKjIj9QiatjeYw4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FF05158A47;
        Mon,  2 Aug 2021 16:07:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5CDDC158A44;
        Mon,  2 Aug 2021 16:07:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 00/11] Fix direct filesystem access in various test
 files.
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 13:07:02 -0700
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 02 Aug 2021 16:53:25
        +0000")
Message-ID: <xmqqsfzrvcex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34C29970-F3CD-11EB-802C-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This fixes a few test failures in the reftable series.
>
> Han-Wen Nienhuys (11):
>   t6050: use git-update-ref rather than filesystem access
>   t1503: mark symlink test as REFFILES
>   t6120: use git-update-ref rather than filesystem access
>   t3320: use git-symbolic-ref rather than filesystem access
>   t2402: use ref-store test helper to create broken symlink
>   t1405: use 'git reflog exists' to check reflog existence
>   t1405: mark test for 'git pack-refs' as REFFILES
>   t1410: mark test as REFFILES
>   t7064: use update-ref -d to remove upstream branch
>   t6500: use "ls -1" to snapshot ref database state
>   t6001: avoid direct file system access

Thanks.

Unfortunately all of these are already in 'next', so I'll revert the
merge(s) to eliminate what has been in 'next' and queue this round
to 'seen', hoping that we can merge the new one back to 'next'
soonish.

