Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750CFC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5597361074
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhI0Ui3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:38:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52761 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbhI0Ui3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:38:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB960141370;
        Mon, 27 Sep 2021 16:36:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PHi74evSXMEed7lPkMG0hcyT8fXJ5g/N1xykL0
        hH9XU=; b=w3rZSAPLW8IbinpJF5QYZyot+S3bRP15s8vfwFSkvc3tohhATjYSm4
        ZKxsIFCPEKwzFPMtdpjGWA/pvqf2tvxjfzelAF23cBDOo/MRzK9ZO0p5lBjn6bos
        mj6EcHP+i8N/XQvdgv1qm6qngVS6e2Vcf1ALc3DxXo74EHwMAYmhg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B319114136E;
        Mon, 27 Sep 2021 16:36:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2482114136C;
        Mon, 27 Sep 2021 16:36:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/11] Fix various issues around removal of untracked
 files/directories
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
        <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
Date:   Mon, 27 Sep 2021 13:36:46 -0700
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Mon, 27 Sep 2021 16:33:37
        +0000")
Message-ID: <xmqq7df1pxgh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A31A80BE-1FD2-11EC-ABCB-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v2 (all due to Junio's request to consolidate
> unpack_trees_options.dir handling):

Heh, don't blame me.  I even explicitly said it was merely an
observation for longer term, not a suggestion to include the first
step for such a move in this series.
