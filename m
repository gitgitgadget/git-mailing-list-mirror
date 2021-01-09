Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D515C433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A79023715
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbhAIWaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:30:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64627 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbhAIWaY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 17:30:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 49CCC1142CF;
        Sat,  9 Jan 2021 17:29:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hg+9GfbG4rA+ETj8GrWmYQPVzfM=; b=rV6BlI
        SZ30W00GAU/yIQSBzxzd3i7hVrantsx04CqyOG/MNna7OSUwjuaRbvdNfXVKO3Kn
        g8JKjncEfU7G/5r6SI8KFTJIRkAODyLfSGVBMYO4fqblNinUOjP2Mfwy/OoQ/9x0
        IZ38/fM7FxT91FdGFpB5xROfR0vztPw7r/rxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XNqYLJ7R1YMLRIUZ2ILBMPcIvJK/UC8M
        PG5lyFHf1MJAbXXH5tA/m1AtgqoJSzuKMfQpuPINxb7PZX4Xzef3pUETvxbDbT/+
        JxVlA0pDCseebI/Qqlts9EQB9fQLkdpFtXwZPUWIGIxZ5Ug6JsEgpP78icNKuFpX
        p12o+7/hA7A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 432831142CE;
        Sat,  9 Jan 2021 17:29:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA2771142CD;
        Sat,  9 Jan 2021 17:29:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Is t5516 somehow flakey only on macOS?
References: <xmqq35zbgd2a.fsf@gitster.c.googlers.com>
        <CAPig+cQ3U4s0qmzoLL=ZBeSyCZm=QqjWz2P36ZUxMzNAyYn-WQ@mail.gmail.com>
        <X/mGnY3wR1fGoxcf@coredump.intra.peff.net>
        <X/mJ6gHrKVxQqPX4@coredump.intra.peff.net>
Date:   Sat, 09 Jan 2021 14:29:36 -0800
In-Reply-To: <X/mJ6gHrKVxQqPX4@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 9 Jan 2021 05:48:10 -0500")
Message-ID: <xmqqsg79eobz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28D94A54-52CA-11EB-9DD7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Since this issue has been languishing for a while now with several
> "something like this" patches, I've packaged it up into something more
> palatable. I think we should just apply this and move on. We may still
> run into other similar races, but I don't think this one is worth
> spending more mental effort on.

Thanks, will queue.
