Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167D0C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E755D60EFD
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhGWRDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:03:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60127 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGWRDw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 13:03:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3477BD494E;
        Fri, 23 Jul 2021 13:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PEHoDOus20IOBkV6ZfuvsaKQ5PXwdKfYCUVufo
        0wABg=; b=fLqROZ6X297iUCdJyjwdBoMBZePBmDQ4vFYyNFXE4OMl3hhsdeEHcJ
        hIFrkUywf38Iva/NjsKJsRhHsKUxcVGZo6A8noZLRQKXOULqszz7hWKScg4CvLoI
        BWc10WF+fTTe4CAINSXg6NX109nsir+4CExJ2Dqt4sfJoNV6cx7RA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B7E0D494D;
        Fri, 23 Jul 2021 13:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB0E8D494B;
        Fri, 23 Jul 2021 13:44:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 00/11] Fix direct filesystem access in various test
 files.
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 10:44:24 -0700
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Thu, 22 Jul 2021 21:28:36
        +0000")
Message-ID: <xmqqbl6tncw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EAA6A90-EBDD-11EB-82F1-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This fixes a few test failures in the reftable series.

The early part is already in 'next', and the new ones looked mostly
good.

I didn't quite understand what was going on with "ls -1" though
(what does it even mean to "ls -1" enumerate only the filenames in
.git/reftable directory)?

Thanks.
