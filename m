Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E5C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0D924653
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="czRC4wfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAUWY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:24:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64085 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgAUWY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 17:24:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 386F7A2C57;
        Tue, 21 Jan 2020 17:24:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RCr2W3yCZ3t6ntt9Z5R4OG9pGp0=; b=czRC4w
        fudSzsbjnr8MFa0hMOu6mnayzgLjNVnIQbn6FQdxmBt0r6K2NAYEHams+XdGLDAH
        EUtU575U9+ndU3gMvaeOVRuwhS8ezMe3uedVgZOfXPokewZnMo2/f98GH7Iw/rMo
        3DTI8DXwMBFVkNBH9rIvFXJ5wHCwzdRc4N7Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kFh3XTZSdbBRYTqcVLeXRs4oimcZFHu9
        yLSmSUguYjyoZ2YK8B9PpkOQ6gXkVxPfuBAet61hhw1texjQ4rkyiQqCGxAe2e9M
        jpTxTwh8CHwbieZIrZebWp4ZGMWLVYw+V21tSgJNptdkg0qcq3mT6L/vq2+Pbayr
        51sGXTcNK80=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30B79A2C56;
        Tue, 21 Jan 2020 17:24:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5ACC5A2C55;
        Tue, 21 Jan 2020 17:24:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v4 1/5] doc: move author and committer information to git-commit(1)
References: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
        <20200120173343.4102954-2-sandals@crustytoothpaste.net>
        <20200120175210.GA3989@coredump.intra.peff.net>
Date:   Tue, 21 Jan 2020 14:24:52 -0800
In-Reply-To: <20200120175210.GA3989@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 20 Jan 2020 12:52:10 -0500")
Message-ID: <xmqq8sm08n2j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D924ED68-3C9C-11EA-A70D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  A commit comment is read from stdin. If a changelog
>>  entry is not provided via "<" redirection, 'git commit-tree' will just wait
>>  for one to be entered and terminated with ^D.
>
> it stayed here, so now it's duplicated. Should the old one be dropped?
> Or is moving the new text a leftover mistake from rebasing (IIRC, in
> your original you dropped this whole "here's how commits work" section).

Ah, you spotted the same thing.
