Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004B1C433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 18:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiERSJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 14:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiERSJR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 14:09:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AB6146429
        for <git@vger.kernel.org>; Wed, 18 May 2022 11:09:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 006C918C4EA;
        Wed, 18 May 2022 14:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Uj/EyB7EH50ljKwvZrARdwbg7KZY8+wBaFUJIS
        FYHjg=; b=kGox8JSoDFJX6ZQI2LGJJXWsG8/2Xoyfrp/C807ObiIdbz02dYVW6G
        WL8toU7f96bplbbFwjq0LsOzX0SXafsuTULpsPdXfXpwmGNUff4Kqja2TuZpRfjw
        +RCOCz4GI4eXAx1//EWSN/zBBMGzCgNPeepxygw1QljWDDw7DBZzE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DEEDC18C4E7;
        Wed, 18 May 2022 14:09:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A5B718C4E6;
        Wed, 18 May 2022 14:09:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Plato Kiorpelidis'" <kioplato@gmail.com>,
        <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>,
        <avarab@gmail.com>
Subject: Re: [PATCH v2 13/15] dir-iterator: option to iterate dirs in pre-order
References: <20220509175159.2948802-1-kioplato@gmail.com>
        <20220509175159.2948802-14-kioplato@gmail.com>
        <88421b18-0fa0-236a-b74b-c5ee3ef53279@gmail.com>
        <20220518173947.4qabalu6mjmzumen@compass>
        <016201d86adf$5a4e1eb0$0eea5c10$@nexbridge.com>
Date:   Wed, 18 May 2022 11:09:10 -0700
In-Reply-To: <016201d86adf$5a4e1eb0$0eea5c10$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Wed, 18 May 2022 13:47:27
        -0400")
Message-ID: <xmqq35h6ww55.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E61001A-D6D5-11EC-8607-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> Could this be a fallback position where nftw() is not available? I am not
> how broadly nftw() is supported but it appears to do what you are looking
> for.

Yeah, nftw() sounds like a better approach than what we have been
doing for the past decade by writing our own iterator.


