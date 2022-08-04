Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439ACC19F21
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 20:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiHDUVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDUVG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 16:21:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F9E24F1E
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 13:21:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C2561BEF43;
        Thu,  4 Aug 2022 16:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eBNZRg236hLqrkFcm/YSppb/Ho9WkmGXdbj2LM
        d4mYM=; b=ptz0FCeQedmejYfSNJzE67EwvQqe3Yy2I/T6NBMPtt4NkwBy0L/1DA
        3QbGTHseP9l+1CQ7W5zxiZ2J4zEKlZFmJMs3JqZX4PHaA/VzvsUWs5gum0gddt74
        Kj3k877hqPmcGN3qwZmczmicGIxpN+YgsLSwcckRBrOKHs51zD2XA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 847991BEF42;
        Thu,  4 Aug 2022 16:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3716C1BEF41;
        Thu,  4 Aug 2022 16:20:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] tests: cache glibc version check
References: <pull.1311.git.1659620305757.gitgitgadget@gmail.com>
        <xmqq4jyr6fuz.fsf@gitster.g>
        <53cffc06-ebb1-ac97-ceb4-4c242a82c68a@gmail.com>
Date:   Thu, 04 Aug 2022 13:20:55 -0700
In-Reply-To: <53cffc06-ebb1-ac97-ceb4-4c242a82c68a@gmail.com> (Phillip Wood's
        message of "Thu, 4 Aug 2022 20:16:12 +0100")
Message-ID: <xmqqh72r4v6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F22ED4A2-1432-11ED-877B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> it. Having just read Peff's message this does not make much difference
> to the test timings and if I'd seen that before I wouldn't have posted
> this.

Ah, I forgot about that conclusion, i.e. while this does look the
right thing to do, it didn't make much difference in practice.

It still is tempting to take it, though :-), if only to stop people
sending in the same patch in the future without benchmarking, as
long as it does not make it worse.

Thanks.
