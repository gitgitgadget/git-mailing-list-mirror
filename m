Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238CBC00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 16:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiHOQJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHOQJp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 12:09:45 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7471CFDE
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 09:09:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C79F155DEC;
        Mon, 15 Aug 2022 12:09:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G3XpLIY/TkHCLLPmxD4+Vg1YV9u5I/KFzdYm19
        2WZ0M=; b=XL6OBMsTZKbfm5p4M91jcyUIUjD0fvWjk4vKow0hWE1ldjxLubAxQM
        edp3Of/8vIM65BDTrFIwRRda3T8YYmUGJ884D5pInLhwgYKJ4ATnOWyDiG6Gr/ij
        LBQcF01vrZQ4tN4NZTNwLbWRAiOaDZddA1KU32dVZcpxdm7CH924c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33480155DEB;
        Mon, 15 Aug 2022 12:09:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90504155DEA;
        Mon, 15 Aug 2022 12:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Todd Zullinger <tmz@pobox.com>,
        Renato Botelho <garga@freebsd.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git maintenance broken on FreeBSD
References: <226317ba-a78f-216c-764c-52f4e393bd35@FreeBSD.org>
        <YvZnQFVMZZmz9TIX@danh.dev> <YvcdskzUkocUv/d7@pobox.com>
        <xmqqczd4ag8f.fsf@gitster.g> <YvfFUuuydtYeuvRx@danh.dev>
        <xmqqsfm08382.fsf@gitster.g>
        <Yvfg7WwL8oCdxqzQ@tapette.crustytoothpaste.net>
        <1dd29f43-1a8e-eb69-3320-7f5140a0e18e@github.com>
Date:   Mon, 15 Aug 2022 09:09:38 -0700
In-Reply-To: <1dd29f43-1a8e-eb69-3320-7f5140a0e18e@github.com> (Derrick
        Stolee's message of "Mon, 15 Aug 2022 09:22:40 -0400")
Message-ID: <xmqqy1vp32v1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA5A9140-1CB4-11ED-B054-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I agree that the tempfile approach makes the most sense in terms of
> what we can do within the Git codebase.
>
> I won't be able to get to this change this week, so I'd be happy to
> review one of yours, brian. Be careful to test manually when making
> this change, because our tests don't actually interact with the system's
> crontab and instead verify the interaction using replacement commands.

Thanks.  I didn't mean "it's your code, go fix it".  It was "you
are one of the folks who know the code well, any comments?"

