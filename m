Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A5581F461
	for <e@80x24.org>; Fri,  6 Sep 2019 20:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391841AbfIFUnC (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 16:43:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52530 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391807AbfIFUnC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 16:43:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D36F8052F;
        Fri,  6 Sep 2019 16:43:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qFEDUqgisl9RwKnJeqm8NqbMbfk=; b=dMUEKg
        tZtagC/blzw7ojaPqhSadkCKepAr4/j8GXbooYsV5mTMdSpjRasU7lllq8s1/FjC
        7BpvMFv8cQ1kPFtnK2nMpauLTGH38aZYPxz1eVuPZZdz9EbZ+EW9S/dp1q/tt4f9
        JjMsknwrYBGFx/2l+GLbzOx4SDUwBgSEL6SNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kM7RgXPN0Pen3MHmPLe7k5wrG2TxL445
        I6RVuspw4E4WAFiN9KYB3/g9XnZXasbVo8K4mIC230CqQtH3gaJX+Wls91SEmwRJ
        YsbQdwvHI5ZER1G/BaPSQwQU92oxSbx2aaZOkEKV8gWetfRwao8qLV4hlRMNeMS5
        iDfMvXkOz4A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25F368052E;
        Fri,  6 Sep 2019 16:43:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 528848052D;
        Fri,  6 Sep 2019 16:42:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
References: <pull.328.git.gitgitgadget@gmail.com>
        <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
        <20190904030829.GB28836@sigill.intra.peff.net>
        <xmqqa7bipjil.fsf@gitster-ct.c.googlers.com>
        <a697c4de-e269-c330-ece2-8ac7007e6c55@gmail.com>
        <20190906175628.GH23181@sigill.intra.peff.net>
        <xmqq1rwtnv03.fsf@gitster-ct.c.googlers.com>
        <20190906191622.GA7096@sigill.intra.peff.net>
Date:   Fri, 06 Sep 2019 13:42:55 -0700
In-Reply-To: <20190906191622.GA7096@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 6 Sep 2019 15:16:22 -0400")
Message-ID: <xmqqpnkdma0g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E88484B6-D0E6-11E9-94EA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suppose so. But I think the "stock git without any other job
> infrastructure" case would still benefit.

Oh, no question about it.

I did question if an automatic writing would benefit the side that
receives a push when you brought up the usual "fetch.* and receive.*
for separate configuration, transfer.* when want to rule them both"
convention, which is a good idea if only for consistency, but the
question was if it helps the receiving end of a push to the same
degree as it would help the repository that fetches.
