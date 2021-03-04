Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB47C15509
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCEA64F38
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354545AbhCDBDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:03:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63816 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453130AbhCDAsF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:48:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EED9110F5DB;
        Wed,  3 Mar 2021 19:47:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=im+UYsqvBvSS5WKiUmYHPqCQ9qo=; b=Sg4x/b
        AyFesqJeekgR5KL6uGyRoP1M2fyYRn/pR2Dc5y3xFGjyzv7jwclG06XOQs0TEIqP
        vOmK09EQMJli/W9Kstfwyj9pORmgFLxRhaM7Ix5pjzkJe8aBJQdMLXR8/4fBrJB4
        n3UOYARPcw1GJZaPEoHRrJa8PGsKmDBxm9260=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l2Wn2MYu9mqIcEBh/R5QabwXpA+/zPgZ
        YjdWGtoomAlHEOpn0Xtn9f2uy8p6evvGMmN+bkeuXW7F7JecBqG2vnif4PJXPbwa
        oGn3N6E2uVfqmw5QScbVT2fK/lC75gXfWcrpOBe2ZUBMkQq1n8KreqAV5fUBIOn9
        q+1WMwZI1TA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E792D10F5DA;
        Wed,  3 Mar 2021 19:47:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 37E2D10F5D9;
        Wed,  3 Mar 2021 19:47:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Joachim Schmitz <jojo@schmitz-digital.de>,
        Matt Kraai <kraai@ftbfs.org>,
        "Randall S. Becker" <randall.becker@nexbridge.ca>,
        git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: Re: [PATCH] config.mak.uname: enable OPEN_RETURNS_EINTR for macOS
 Big Sur
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
        <YDXaJHnZ5LgCj9NX@coredump.intra.peff.net>
        <xmqqzgzuyqli.fsf@gitster.g>
        <YDaY/M3Rw+6xwZlf@coredump.intra.peff.net>
        <YDiRywyld/0OTT5U@coredump.intra.peff.net>
        <xmqq8s7ascby.fsf@gitster.g>
        <YDy0C9sRvboGXQ7P@coredump.intra.peff.net>
        <xmqqczwimnps.fsf@gitster.c.googlers.com>
        <YD+SCtzmtWgFArwW@coredump.intra.peff.net>
Date:   Wed, 03 Mar 2021 16:47:20 -0800
In-Reply-To: <YD+SCtzmtWgFArwW@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 3 Mar 2021 08:41:30 -0500")
Message-ID: <xmqqv9a7g2xz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E30CEC2-7C83-11EB-829C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks. I guess we're a bit late to make it into the upcoming release.
> Certainly we have survived for many years without this particular
> bugfix, so in that sense it is not urgent. But I do wonder if we will
> see more reports as more people start using the new macOS release. So it
> might be good to keep in mind for maint, if we cut a minor release.
>
> Or alternatively, we could include _just_ the first patch. That's low
> risk, since you have to enable to knob yourself, but it gives people an
> option if they run into the symptom. But even that is probably not that
> urgent. People can also cherry-pick the patch, after all (and a
> distributor like homebrew can probably include the patch in their recipe
> if need be).

True.  The topic is forked at somewhere mergeable to 'maint' so
distro folks who are interested can merge them down later.  I think
it is small and safe enough to merge them both down to the upcoming
release, though.

