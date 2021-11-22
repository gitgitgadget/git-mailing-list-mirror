Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588D8C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbhKVSO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:14:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54675 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbhKVSO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:14:27 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90BFAF3DF3;
        Mon, 22 Nov 2021 13:11:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wRF/wnx1VsvF3RpaghsMRyC5qan+bLutsxKbKF
        H/3o8=; b=cuMHte8Gh0Xfe8GN/SJW80Y1hUyHy3tUu7rLkkjG7cdb4gXykKpuZ9
        clgYjmuW2tg4V5lVBJIHtnBaoi1h/dFiIT2O606l7+tCojClUFakVcWU8jrQ03qO
        wbmE+0K/E84Q0bURDhBPXH6mKfccWsiFMnDNi8VAHgsH2z2/r2Cmg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 819C1F3DF2;
        Mon, 22 Nov 2021 13:11:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2405F3DF1;
        Mon, 22 Nov 2021 13:11:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 0/5] run-command API: get rid of "argv"
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
        <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
        <YZvY+BJhxaFIOdnJ@coredump.intra.peff.net>
Date:   Mon, 22 Nov 2021 10:11:18 -0800
In-Reply-To: <YZvY+BJhxaFIOdnJ@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 22 Nov 2021 12:52:56 -0500")
Message-ID: <xmqq7dd0giwp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97CFAE64-4BBF-11EC-BE0D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm on the fence on how important it is to do these cleanups. IMHO they
> are half of what really sells the change in the first place (since the
> other bug can pretty easily be fixed without it).

Yes.  I actually think these have much better value for their
complexity, compared to the other "half" of the topic ;-)

> But maybe it is piling too much onto what is already a pretty big
> change. The cleanups could be done individually later.

I am OK with that, too.  But I do agree that the series is too big
to sit in front of a fix for a bug, for which a much simpler and
focused approach has already been discussed, to block it.

Thanks.
