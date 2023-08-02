Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC53C00528
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 22:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjHBWKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 18:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHBWKs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 18:10:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19A3B1
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 15:10:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8425C23515;
        Wed,  2 Aug 2023 18:10:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5qeuaSR6MwDjTzVgBx7/dKJkgEmYtDQKqrGcYX
        73NVQ=; b=hE4k8Kxx0E28KF7Z8SlN1Nt3UhnS+M3jjmUptZpY0Ob2pptPgcx30Q
        lR9Tj2J7FppNx6qB8FoE4DIuWTaw6QLNm1FdC93v7ZU0ZlagDx50T3s3ou/VjAbB
        um2p38V1iRaT8kFmhREUOqLMADW5+krLqKWMFhFFZ080uhbOrw1uY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C10323514;
        Wed,  2 Aug 2023 18:10:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2031723513;
        Wed,  2 Aug 2023 18:10:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/7] rebase -i: impove handling of failed commands
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
Date:   Wed, 02 Aug 2023 15:10:41 -0700
In-Reply-To: <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Tue, 01 Aug 2023 15:23:25 +0000")
Message-ID: <xmqq8rat6qou.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C3C09E2-3181-11EE-9848-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

>   sequencer: factor out part of pick_commits()
>   rebase: fix rewritten list for failed pick
>   rebase --continue: refuse to commit after failed command
>   rebase -i: fix adding failed command to the todo list

I'd really prefer to see the latter half of the series reviewed
(both for the design and its implementation) by those who have more
stake in the sequencer code than myself.

I just noticed that we have a question on the last step left
unanswered since the very initial iteration.

cf. https://lore.kernel.org/git/f05deb00-1bcd-9e05-739f-6a30d6d8cf3b@gmx.de/

Thanks.
