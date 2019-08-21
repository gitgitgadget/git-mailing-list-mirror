Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE421F461
	for <e@80x24.org>; Wed, 21 Aug 2019 16:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfHUQrv (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 12:47:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65414 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbfHUQrn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 12:47:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9726916CD09;
        Wed, 21 Aug 2019 12:47:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RdvikXMXEvFw+sopYzp7OasGCmI=; b=d6WB6Y
        aBSiLb0t2205tngBr5/QA/gnxyulS2b6W7Y1VM9gSJYoZV8kLJOGzFcDE+CHSYWu
        1G4nAv/nzc/VT3TgiStz6kQhk5cYv0eTSBO43WDJH3QljSU2WZl3f9zZDfgaEFrO
        TtnitoQhzTHJtmFGT6p5tMvB6t4VQ1zE04O0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rSgJ8Pb5f90ZEdm4s1Q9mEkZNVncmMxm
        2Aed4PcMk4MCTVbNbwCLjeUcACxTazuikL3Q/E8crQeip1A3tiFfDgEfvHamkFPD
        mKV0lyz2xBCn9sQXzU92k/zfTCn6M5/uGEu3YvCvJaWYc2YcUbEbxS3gEpqryali
        eG9C8zRXdF8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9001616CD08;
        Wed, 21 Aug 2019 12:47:41 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0477C16CD07;
        Wed, 21 Aug 2019 12:47:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 1/1] commit-graph: add --[no-]progress to write and verify.
References: <pull.315.git.gitgitgadget@gmail.com>
        <da89f7dadb0be2d4ada22dd3e2d1f5524c73f70d.1566326275.git.gitgitgadget@gmail.com>
        <CAPig+cSR-ab_8AeZ9fJX2G8h6x_V_NUG01pXWQAgF+_pgmR2fQ@mail.gmail.com>
Date:   Wed, 21 Aug 2019 09:47:39 -0700
In-Reply-To: <CAPig+cSR-ab_8AeZ9fJX2G8h6x_V_NUG01pXWQAgF+_pgmR2fQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 20 Aug 2019 17:13:06 -0400")
Message-ID: <xmqqy2zmsbx0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63ED155C-C433-11E9-91C5-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This synopsis shows only 'verify' accepting --[no-]progress,
> however, ...
> This is misleading. The --progress option does not _toggle_ the
> setting. ...

Thanks for a careful review.
