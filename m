Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A3C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbiFMWPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiFMWPR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:15:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B82C67D
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:15:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C9CE137C2F;
        Mon, 13 Jun 2022 18:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Ytv/NpXCrCvF16o6TgIBiakm00aB+AcN6wCJ7
        NrHg8=; b=v/FYG1qJLG7wwiQ+MrU8+VvXAyCbdhDENGuIJ5EhwnXx/GsB3N13vC
        q59WB+sZlaSrn6cEwVV0POq4tH2TycWNdKlnwRUGYHncwjfcfsT77Debir93xaHB
        T0luK24r1myY3PIWG+i01ORlfkBKuVrfQwirM6g4apoAmpaPW+zho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03A61137C2E;
        Mon, 13 Jun 2022 18:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B968137C2B;
        Mon, 13 Jun 2022 18:15:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v3] remote-curl: send Accept-Language header to server
References: <pull.1251.v2.git.1654756523475.gitgitgadget@gmail.com>
        <pull.1251.v3.git.1655054421697.gitgitgadget@gmail.com>
        <xmqq1qvs5jx4.fsf@gitster.g> <xmqqedzs43o0.fsf@gitster.g>
Date:   Mon, 13 Jun 2022 15:15:12 -0700
In-Reply-To: <xmqqedzs43o0.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        13 Jun 2022 15:08:47 -0700")
Message-ID: <xmqq7d5k43db.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C67855E-EB66-11EC-9C42-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> +#define RPC_STATE_INIT { 0, }

Make it

	#define RPC_STATE_INIT { 0 }

Curiously, the former form with trailing comma makes sparse unhappy,
while it seems that the latter is taken as a special form "idiom".
