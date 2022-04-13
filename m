Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68698C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiDMVqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiDMVqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 17:46:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7143ED37
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:43:54 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B71212C696;
        Wed, 13 Apr 2022 17:43:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L44xRH/yFOs+Ohbs9MIuvVqLE7sArMVW2zu+KH
        bOBe0=; b=gbOujvs01El8MQvye/q/5ix2oMAXb9OrwL/gEJZgeiNrrTw1MbxLv9
        GGqVel9zXhyrHo5CWTbNlMCUtaOxF5jy/e/Z3/VPlIWEdJr9te0Z4cKDMttMqYTE
        56+Q7hJdyI7oBJOnejW/ioO989Xdl/UjbFpg/YrUTfy47HEekoBhA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 128C912C695;
        Wed, 13 Apr 2022 17:43:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A2D812C694;
        Wed, 13 Apr 2022 17:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 4/4] builtin/stash: provide a way to import stashes
 from a ref
References: <20220407215352.3491567-5-sandals@crustytoothpaste.net>
        <20220412201435.803424-1-jonathantanmy@google.com>
        <YlYjgLcnNH8V1yj0@camp.crustytoothpaste.net>
        <xmqqzgko7nj4.fsf@gitster.g>
        <YldBlydglKkBhR9y@camp.crustytoothpaste.net>
Date:   Wed, 13 Apr 2022 14:43:52 -0700
In-Reply-To: <YldBlydglKkBhR9y@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 13 Apr 2022 21:33:11 +0000")
Message-ID: <xmqq1qy07j6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D030A47A-BB72-11EC-8B85-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> For example, since our throwaway commits are empty, it would seem
> bizarre to users that someone pushed a commit with an empty tree, but if
> they see that the commits are stash commits, that may help them have
> useful context.

Understood.  Also recording the tree of the state the stash entry
represents the working tree state (instead of an empty tree) might
make it easier to see.  Then even in UI like GitHub web interface,
the users can inspect how various paths in the tree looks like.

> I'm happy to add a few more tests for this in a followup series.  I'll
> likely get to it this weekend and can include some checks for the commit
> message and some improved verification of commits in the testsuite.  I
> don't think this should hold up the rest of the series, however.

THanks.

