Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CC3C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A4361A03
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 17:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhKSRTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 12:19:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53783 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhKSRTw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 12:19:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85A97F0844;
        Fri, 19 Nov 2021 12:16:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0vl6nltw9131PAUz89cgdjqDFhrsjBO0vmZfst
        KdmF0=; b=U5W/D6AsvhNGq4H4qedWUWy3xH54MeWMJ4KcrXj20VvXY9Jg47Rops
        a6f9AKqHnytp8y5Oi58KyIukgjeiS73S+AjUlm+l0BEenzoxMGfnqieUCHBw/n6E
        K/YAngbx7MA9JOyMN3lW4xPyjn9fBHdtPhJYxG1Luwm2c8y8FYals=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D084F0843;
        Fri, 19 Nov 2021 12:16:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E52F1F0842;
        Fri, 19 Nov 2021 12:16:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pull: don't say that merge is "the default strategy"
References: <20211118154317.639118-1-alexhenrie24@gmail.com>
        <xmqqk0h5w3qy.fsf@gitster.g>
        <CAMMLpeSuL2k2semwS+K1jxTNZEV79GzCymFZo+1VcsyU6bYTrg@mail.gmail.com>
        <CABPp-BHAqhpK4F2wTRhxZ5DXKOJExMxihbdpx1d2fYqAgtzS9w@mail.gmail.com>
Date:   Fri, 19 Nov 2021 09:16:48 -0800
In-Reply-To: <CABPp-BHAqhpK4F2wTRhxZ5DXKOJExMxihbdpx1d2fYqAgtzS9w@mail.gmail.com>
        (Elijah Newren's message of "Thu, 18 Nov 2021 21:41:22 -0800")
Message-ID: <xmqq7dd4qd4v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B824506-495C-11EC-B5BC-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I was referring to the patch that I originally wrote, before Elijah
>> made the changes that actually got the patch accepted:
>> https://lore.kernel.org/git/20210627000855.530985-1-alexhenrie24@gmail.com/

Ah, with that URL, the extra paragraph would have made sense.  Here
is how amended the log message with this new information.

Thanks, all.

----- >8 --------- >8 --------- >8 --------- >8 -----
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Thu, 18 Nov 2021 08:43:17 -0700
Subject: [PATCH] pull: don't say that merge is "the default strategy"

Git no longer has a default strategy for reconciling divergent branches,
because there's no way for Git to know which strategy is appropriate in
any particular situation.

The initially proposed version in [*], that eventually became
031e2f7a (pull: abort by default when fast-forwarding is not
possible, 2021-07-22), dropped this phrase from the message, but
it was left in the final version by accident.

* https://lore.kernel.org/git/20210627000855.530985-1-alexhenrie24@gmail.com/

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pull.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index b311ea6b9d..20b585a76b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -939,7 +939,7 @@ static void show_advice_pull_non_ff(void)
 		 "You can do so by running one of the following commands sometime before\n"
 		 "your next pull:\n"
 		 "\n"
-		 "  git config pull.rebase false  # merge (the default strategy)\n"
+		 "  git config pull.rebase false  # merge\n"
 		 "  git config pull.rebase true   # rebase\n"
 		 "  git config pull.ff only       # fast-forward only\n"
 		 "\n"
-- 
2.34.0-202-gd9146917d7

