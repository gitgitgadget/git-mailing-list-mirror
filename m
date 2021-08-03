Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DCBC4320A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470216105A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhHCWlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:41:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54282 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhHCWlp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 18:41:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0100AD71DD;
        Tue,  3 Aug 2021 18:41:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gDXVYIHFoSjfez/lR4pdfCsxdaX32/Uo9/XEna
        q9iUw=; b=vZ/iqOTIKJMgQiwFLPZNrqKurldoDV63mHYvzSIx9u4yFY0K/D30+X
        IoTJlnM5k13/b5MFHZd+6xlVZatjBM2Fw19k6mvEQfg4K80WekaN6e6IxV3NPnYO
        pTR6AeNhGdBStr2EexeGylVfJdPqfdxucbWk+u1y93bL7FxFmmaDo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBDCBD71DC;
        Tue,  3 Aug 2021 18:41:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D213D71DA;
        Tue,  3 Aug 2021 18:41:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clone: update submodule.recurse in config when
 using --recurse-submodule
References: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
        <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:41:30 -0700
In-Reply-To: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com> (Mahi Kolla
        via GitGitGadget's message of "Mon, 02 Aug 2021 23:23:06 +0000")
Message-ID: <xmqq5ywmtalh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2D0A96E-F4AB-11EB-A5F3-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When running 'git clone --recurse-submodules', developers expect various
> other commands such as 'pull' and 'checkout' to also run recursively into
> submodules.

Some developers might, but "developers expect" as if we speak for
everybody is a bold statement to make that needs to be
substantiated, I would think.  Is this something easy to make
opt-in, e.g. "git clone --recurse-submodules=sticky" or something?
