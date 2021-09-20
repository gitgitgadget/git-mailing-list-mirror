Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BFFC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 21:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5042461213
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 21:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbhITV1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 17:27:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50221 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbhITVZf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 17:25:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3564EF9CD;
        Mon, 20 Sep 2021 17:24:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DVfwTMGVQhEXENQe9ENQ6XADWeFtxpruxNj3A6
        WOj6o=; b=LHMsOGM66jZNINFnu1E3N8lEoVE8PN0WGDzwsCrJuhL2jcL9UoJbEe
        mAuLUQGMUATay5tWHrBOB+r3WdDJHDnXKcjBKo+BULBVNcxQfRNm4ibqhhUv+0LM
        YO1wUenAG7h5BihelwQFHN5fjSLUN+6IpnvpN8MyGVYynh5hgO7ZQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98105EF9CC;
        Mon, 20 Sep 2021 17:24:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53005EF9CA;
        Mon, 20 Sep 2021 17:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH 0/1] commit-graph: drop top-level --[no-]progress
References: <cover.1631980949.git.me@ttaylorr.com>
Date:   Mon, 20 Sep 2021 14:24:04 -0700
In-Reply-To: <cover.1631980949.git.me@ttaylorr.com> (Taylor Blau's message of
        "Sat, 18 Sep 2021 12:02:34 -0400")
Message-ID: <xmqqr1dj9c0b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15E80438-1A59-11EC-941B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> An open question is whether the same should be done for the multi-pack-index
> command, whose top-level support for `--[no-]progress` was released in v2.32.0
> with 60ca94769c (builtin/multi-pack-index.c: split sub-commands, 2021-03-30).

We do not mind too much about "breaking backward compatibility" by
removing the mistaken "git multi-pack-index --progress cmd", I would
say.  It's not like people would type it once every day and removing
the "support" will break their finger-memory.

