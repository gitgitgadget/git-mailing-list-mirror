Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93577C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540E520657
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uEahdJ5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbgHQRau (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:30:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52739 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbgHQQ66 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 12:58:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4303584030;
        Mon, 17 Aug 2020 12:58:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OlcRgnMFWERm8LGma0NizVz57BE=; b=uEahdJ
        5lvnW3tm6Pfj4sbNhoknqINZGSj3gHcKwJrw980dR1ydp2N6vIGAT5270Hq688SM
        tFTVOJU8CEzYxYlMNo1Lv5WQKj1T/b91i0o7oi0S+hUNczn9T/mdQYET+9/OiLan
        4AKTFgRa8m+TTyWZNkxgdRx1+Iyk2E35l8zFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=utRjlJ/m/b6boB60vsYS6JeVquEeoTcC
        wxd0WNv8yH+ytounwyn4JQEZdmGXMe9EqT/A3rq5iT76gdxFdSmOOohT99x1p/SF
        omm8a7DxuoapwKydvcERQsePPw3lRkrTh+TiEUIYcE2N5lv6YPRkFGTn+Iwhb26g
        a2VV+u7dzAc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38BCE8402F;
        Mon, 17 Aug 2020 12:58:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEF868402E;
        Mon, 17 Aug 2020 12:58:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
References: <20200813145515.GA891139@coredump.intra.peff.net>
        <20200813145936.GC891370@coredump.intra.peff.net>
        <xmqqr1sa2znw.fsf@gitster.c.googlers.com>
        <20200815063811.GA628010@coredump.intra.peff.net>
Date:   Mon, 17 Aug 2020 09:58:54 -0700
In-Reply-To: <20200815063811.GA628010@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 15 Aug 2020 02:38:11 -0400")
Message-ID: <xmqqv9hh2oq9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF9CA3B2-E0AA-11EA-8B0A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Where do we want to go with this? After the discussion and sleeping on
> it, I'm still of the mind that we should generally default things to
> being builtins unless there's an immediate need not to do so (like
> extra link dependencies). But I don't care _too_ much, so I'd rather
> eject this patch and move forward with the rest of the series if it's a
> sticking point. Thoughts?

I already said what needs to be said.

I do not care too deeply what we do now today either way, as long as
people remember that we are interested in the version string, build
options and external library versions of the "git" binary (for
built-ins) and non-built-in binaries (like the remote helpers), and
not as much interested in these traits of the "git-bugreport" binary
itself, when we need to split "bugreport" out of builtins in the
future.

Ironically, making it built-in eliminates the chance of sloppy code
to report versions and other traits of git-bugreport that does not
matter and is different from these traits of git itself, but it will
make the technical burden larger if we ever need to split.  It won't
be just the matter of giving it a new cmd_main() and worry about the
optional nongit setup.

Thanks.
