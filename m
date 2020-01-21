Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94798C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 21:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A5B24125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 21:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KK0lsKRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAUV5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:57:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60688 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAUV5l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 16:57:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CE3118B10;
        Tue, 21 Jan 2020 16:57:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bIEaSZ07YLY4c8aEqg2iq8ADtgc=; b=KK0lsK
        Ru4QaFtfBT83yDqCJIzUYvaDnpGovKEmccbEyoQneYngnUJ7rciB/r3YwRVyL5MW
        ty5yxqsXD6KJdcVnfzyDO1tnlddxbobmx+29TMLnbHjpC1QHpPTvQxdNc7IALBkD
        ZGrJTJZCJOnHVqUfqGKeIG7xnb++eyeR8pkiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JKq3fhjy6MHGxOdRu9HQZFfcdoyqE4X1
        phRvkXQDZhoVyqEj5j0Vkp1BOdjxGtrN7YkQg9bq05166NxGofo5ptIY0AooFLTP
        21pwdwrmbPpe8iu/uMQuiREt2zN2OKTEYbe///6FiwvL3a9IGY/Q2yzRYkBdX6Li
        1/vIe77vmpk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5426618B0F;
        Tue, 21 Jan 2020 16:57:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF25D18B0E;
        Tue, 21 Jan 2020 16:57:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 1/2] t6025: modernize style
References: <CAPig+cQX=jB1KTKcOMVE9u0jX-ZXt_vQBndkzqqQWORu5iFxeA@mail.gmail.com>
        <20200118083326.9643-1-shouryashukla.oo@gmail.com>
        <20200118083326.9643-6-shouryashukla.oo@gmail.com>
Date:   Tue, 21 Jan 2020 13:57:38 -0800
In-Reply-To: <20200118083326.9643-6-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Sat, 18 Jan 2020 14:03:25 +0530")
Message-ID: <xmqqy2u08obx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AD0B3FA-3C99-11EA-9A79-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> The tests in `t6025-merge-symlinks.sh` were written a long time ago, and
> has a lot of style violations, including the mixed-use of tabs and spaces,
> missing indentations, and other shell script style violations. Update it to
> match the CodingGuidelines.

Looks good.  Will queue.

Thanks.
