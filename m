Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C00C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 20:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEAE24125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 20:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VW0NhV8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAUUaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:30:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50765 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgAUUaA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 15:30:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 247CEA2FF6;
        Tue, 21 Jan 2020 15:30:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UpA1Yy5/gchO4ujcbwg15ErDUuA=; b=VW0NhV
        8Rgvb8EZX6ZqBDsa6BR52BXH1BF92LWJM9YE4ovUtw91r2Tw8I7ghbWgDdZnBind
        wda2oR5AoqjOY/ZmtV2U+u0UiLk0Be87HR7COl0g0FLBw2Pe1JGMQOhPlkEAVmkV
        p9I0Gb/Oa2WL6VE5SXN7fRatuEeL1mIKX5hy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BvIcjd0xWKN8R5vgUzflPgUXtWUBFwta
        2mIJFhe7Q4pgGzn0i5SAZA8/e1xooWpnLN6LKz05bBXYmjN25SAoOEHqlSNk0mck
        Pd8qcLuOkuxEVFUGTAcJ0cO6i2Xdm8dmVYAHyvhylRKksjqciqxbt43zcMyLiLBS
        vB4Y4EceM7s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A6BCA2FF5;
        Tue, 21 Jan 2020 15:30:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3EEE2A2FF3;
        Tue, 21 Jan 2020 15:29:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 6/8] doc: stash: synchronize <pathspec> description
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <5e17a0c470ec576d9dc4c24acecbad5ac2ddd9ed.1579190965.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 12:29:54 -0800
In-Reply-To: <5e17a0c470ec576d9dc4c24acecbad5ac2ddd9ed.1579190965.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Thu, 16 Jan 2020
        16:09:23 +0000")
Message-ID: <xmqq36c8a6yl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA252E50-3C8C-11EA-908F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> This patch continues the effort that is already applied to
> `git commit`, `git reset`, `git checkout` etc.

Makes sense.
