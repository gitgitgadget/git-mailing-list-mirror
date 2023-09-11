Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D0CA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 02:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbjILCIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbjILCC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3F1179D96
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 18:33:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05A0C1AC473;
        Mon, 11 Sep 2023 18:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=wt5M41CjmVWOXtnVHzoM8Shv643BZf5yYPYIVZ
        wMRfg=; b=k6HiWX3g4lZ5ArLkgbEhLGx7XCLkie2XeJaxyp3aJgcBqyae4yZj/p
        ci3BsjWFedMq1PNFcmWqkkDc82N9kgznWy5QuSC7RaK0e+QOS0cq5sdpER/Orts5
        5KdgS/RFRwzR5rooDAP5HHffwojKSR2aiICgUZ8xhnjyRy9FnrOv0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F15151AC472;
        Mon, 11 Sep 2023 18:36:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6DC891AC471;
        Mon, 11 Sep 2023 18:36:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] t3404-rebase-interactive.sh: fix name of a rewording test
In-Reply-To: <20230911122108.199207-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Mon, 11 Sep 2023 14:21:08 +0200")
References: <20230911122108.199207-1-oswald.buddenhagen@gmx.de>
Date:   Mon, 11 Sep 2023 15:36:08 -0700
Message-ID: <xmqqwmwws5gn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A834E0A-50F3-11EE-A505-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> The given test name made no sense to me at all; it seems to be a
> concatenation of two unrelated things. This was introduced by
> commit 0c164ae7a ("rebase -i: add another reword test", 20-08-20).
>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>
> ---
> actually, i don't understand what the test even does. shouldn't it, to
> match the description, actually dirty the tree and verify that the
> operation fails?
>
> Cc: Phillip Wood <phillip.wood@dunelm.org.uk>

As a typofix the updated text looks more correct, but the above is a
very good point, so I'll let Phillip, whose 0c164ae7 (rebase -i: add
another reword test, 2021-08-20) introduced this test, react first.

Thanks for spotting and fixing.

> ---
>  t/t3404-rebase-interactive.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 96a56aafbe..31ee5bc1f6 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -758,7 +758,7 @@ test_expect_success 'reword' '
>  	git show HEAD~2 | grep "C changed"
>  '
>  
> -test_expect_success 'no uncommited changes when rewording the todo list is reloaded' '
> +test_expect_success 'no uncommitted changes when rewording' '
>  	git checkout E &&
>  	test_when_finished "git checkout @{-1}" &&
>  	(
