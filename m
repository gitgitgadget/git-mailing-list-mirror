Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652B1C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJKAPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJKAPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:15:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B44456C
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:15:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3460D145621;
        Mon, 10 Oct 2022 20:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ertU/yC7jv5J
        fTbYvUCMTbndvg4i5eIvC02U7DG7qKM=; b=jJPsN/b/uOcZlMVRVymisWWeFUuu
        OqGPeGAu3P5mfZ/fgQITvi0fYJT2ZYocsqlbHLHiQlQvLeADVkrLFXn5wO2ufRW0
        PurtdEMqIONOs4ctH5o8BRcO9QBcNlM3F9HksRo84xmQUmJui7rvxsZE4dJtYDDK
        mknIEF2a5EuUbYo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28AA514561C;
        Mon, 10 Oct 2022 20:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 778D114561B;
        Mon, 10 Oct 2022 20:15:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2] config.mak.dev: disable suggest braces error on old
 clang versions
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
        <pull.1375.v2.git.1665416340806.gitgitgadget@gmail.com>
        <xmqqo7uj35td.fsf@gitster.g>
Date:   Mon, 10 Oct 2022 17:15:17 -0700
In-Reply-To: <xmqqo7uj35td.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        10 Oct 2022 11:13:34 -0700")
Message-ID: <xmqqtu4bxlka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C99FD81E-48F9-11ED-A628-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Looks very straight-forward, albeit a tad verbose, and simple to
> follow.  I think this is equivalent to Ren=C3=A9's original one-liner.
>
> Will queue.  Thanks.

Funny that during the whole time we were discussing this patch, I
never recalled b53a5f24 (config.mak.dev: squelch -Wno-missing-braces
for older gcc, 2022-07-29), which was a moral equivalent of this
change for older GCC, until I needed to decide the name of the topic
branch to queue this patch.

I had the topic branch jk/struct-zero-init-with-older-gcc for
b53a5f24 still lying around.  I reused a part of its name and queued
it on jh/struct-zero-init-with-older-clang branch.


