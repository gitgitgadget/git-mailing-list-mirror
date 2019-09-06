Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7B51F461
	for <e@80x24.org>; Fri,  6 Sep 2019 21:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404819AbfIFV6B (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 17:58:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58003 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404212AbfIFV6A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 17:58:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97D8534965;
        Fri,  6 Sep 2019 17:57:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Lulfc/hS5NxNGghK543Qs/wJkI=; b=riudYs
        HVayPMGMObQPfH9DNDbeEJS89L2ttJw3/yP/9NiGOWSFJ/haiW8hsJ7bvwUh4nS8
        MDVb99Quvv8ersk4cC9317mLVZ0gglOrwpzfBbZX+M+UlrZco5AZHn/IGFyVtXbM
        gdT2jyjX4KpzAxIe5gCldzo5aR7oaAw/+0rgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qTghTeCbt8bAV/WSiElN+D/616C+mWCQ
        8bWCUUsGYCMQZK7v7UBUdeFm0eN+CwNSUoEbiGD/OVj2qrK7G7Vbx7eNWSggU5CC
        wHxi2QU1e1HYCKk8CAqYBktxL51o3HWlhcSGcECLRR94R4YTfyRFqfOjemaRbvUH
        hPaag+70rxk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ED9734964;
        Fri,  6 Sep 2019 17:57:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFC7C34963;
        Fri,  6 Sep 2019 17:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
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
        <xmqqpnkdma0g.fsf@gitster-ct.c.googlers.com>
        <25ed1562-dc74-1ebc-46ff-d6cd643504a4@gmail.com>
Date:   Fri, 06 Sep 2019 14:57:55 -0700
In-Reply-To: <25ed1562-dc74-1ebc-46ff-d6cd643504a4@gmail.com> (Derrick
        Stolee's message of "Fri, 6 Sep 2019 17:04:17 -0400")
Message-ID: <xmqqh85pm6jg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6266148E-D0F1-11E9-84B2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/6/2019 4:42 PM, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>>> I suppose so. But I think the "stock git without any other job
>>> infrastructure" case would still benefit.
>> 
>> Oh, no question about it.
>> 
>> I did question if an automatic writing would benefit the side that
>> receives a push when you brought up the usual "fetch.* and receive.*
>> for separate configuration, transfer.* when want to rule them both"
>> convention, which is a good idea if only for consistency, but the
>> question was if it helps the receiving end of a push to the same
>> degree as it would help the repository that fetches.
>
> I think the "stock git without any other job infrastructure" is
> a very important scenario. Putting the simplest version of
> "commit-graph writes in-line with every push" seems to be ripe
> for failure under load. I'd rather think deeply about what is
> best for this scenario.

As to what to do on the push side, I suppose we can afford to let it
simmer in the back of our heads while moving this topic forward.
Whether we'd later decide to have receive.writeCommitGraph (in which
case we would add transfer.writeCommitGraph, too) or not, this
change on the fetch side can independently be used, right?

Thanks.

