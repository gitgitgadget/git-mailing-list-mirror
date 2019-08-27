Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC44E1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 21:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfH0V5C (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 17:57:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64417 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0V5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 17:57:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F16416D9FC;
        Tue, 27 Aug 2019 17:56:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w8awimXey74OL1oAF/E6a2eT5VQ=; b=O88Mgl
        tTQLSHE3HZhwlYnnSojr7nV/8U16uEW0ujg5E10zwe7w/3XbvnmTbf98svGXOll3
        AYDLE38CBbL+9p9SOrTgfuAmUNDdgDnhk/+HOgZr/3lI/Zh8FHD7k0dZQWaReWgq
        vpiRxf7ThghM6UNozf6s78wiy50e3lCMVVxMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ff8D5CcpyVz6p/utdBHJfUN17KCweZe7
        EKb4m2MkYFSEEdhvkO1VkfffBV2HmVPpMg6QhOT1GJWPAPn3jgN47cDLwc8v9VSa
        P41qPugvqlmKj11QR8EEkIvWtDZQZjbdGjNzW9Uoo4SjSR1Xn88N3KwArS2rfUT6
        5UTRc78o3gw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 459D116D9FB;
        Tue, 27 Aug 2019 17:56:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A78A916D9FA;
        Tue, 27 Aug 2019 17:56:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] status: mention --skip for revert and cherry-pick
References: <cover.1566637431.git.liu.denton@gmail.com>
        <cover.1566880835.git.liu.denton@gmail.com>
        <be64ce1e92c60f9587b137d36e98532604d4a1ff.1566880835.git.liu.denton@gmail.com>
Date:   Tue, 27 Aug 2019 14:56:57 -0700
In-Reply-To: <be64ce1e92c60f9587b137d36e98532604d4a1ff.1566880835.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 27 Aug 2019 00:45:41 -0400")
Message-ID: <xmqqef162rx2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97A2944E-C915-11E9-A847-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When reverting or cherry-picking, one of the options we can pass the
> sequencer is `--skip`. However, unlike rebasing, `--skip` is not
> mentioned as a possible option in the status message. Mention it so that
> users are more aware of their options.

Is this a good thing, though?

Giving up (because you do not have enough time or concentration to
finish the cherry-pick or revert in progress) with --abort, and
committing to the resolution after spending effort to deal with a
conflicted cherry-pick or revert with --continue, are both sensible
actions after seeing the command stop due to conflicts.  Is "--skip"
a recommendable action in the same way?  Doesn't a multi-commit
series often break if you drop just one in the middle, especially
if the series is sensibly structured as a logical progression?






