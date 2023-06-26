Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACCCEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 19:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjFZT6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 15:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZT6p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 15:58:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C039171F
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 12:58:43 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62FF71AABB0;
        Mon, 26 Jun 2023 15:58:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IMzIgRn2XJRmWYA7phoDZfywFeKhG0o+4MQki+
        URcQ0=; b=x9dS1uajigr6wL1zo4i003/vEiev9jlNPygZKZiZRdWae3BJolwea1
        KnWwHzqxPsHnbgJ2zXQYM9VJxvH3jXmX8tU3iJDNndc2Y5QYhv/Nsrz6sBF9Lf3E
        BW/31qvxkJokumIn1xj6jVkBAUgqf2Kn/rL7WuSiu54i3zg6MxjFE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 590271AABAF;
        Mon, 26 Jun 2023 15:58:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA0AC1AABAE;
        Mon, 26 Jun 2023 15:58:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 5/7] attr: expose and rename accessor functions
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
        <20230626190008.644769-1-sandals@crustytoothpaste.net>
        <20230626190008.644769-6-sandals@crustytoothpaste.net>
Date:   Mon, 26 Jun 2023 12:58:40 -0700
In-Reply-To: <20230626190008.644769-6-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 26 Jun 2023 19:00:06 +0000")
Message-ID: <xmqqttuu3si7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9680F72-145B-11EE-B8A7-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> From: "brian m. carlson" <bk2204@github.com>
>
> Right now, the functions which determine the current system and global
> gitattributes files are not exposed.  We'd like to use them in a future
> commit, but they're not ideally named.  Rename them to something more
> suitable as a public interface, expose them, and document them.
>
> Signed-off-by: brian m. carlson <bk2204@github.com>
> ---
>  attr.c | 14 +++++++-------
>  attr.h |  9 +++++++++
>  2 files changed, 16 insertions(+), 7 deletions(-)

I very much like the updated names.  Thanks for a clean-up that is
long overdue for about a dozen years or so.

