Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2154C35673
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 02:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717F820656
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 02:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="APvO4L/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgBXC4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:56:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61051 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgBXC4A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 21:56:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68062C7A5C;
        Sun, 23 Feb 2020 21:55:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xYH4fKutOcs7eZpRheLvCTlwvVY=; b=APvO4L
        /WHqLhciHjoeWD2iW/tVbsWSrLKLV6LC/EDf7VnyU8i0g+CbvmF/QuU9yVOaTPnr
        m75bC4i7HKLvjWzOp/BA9xa6WF3rjGX2wdbTDZJjX+OdruVvbDn9vkxsddkZ8hgE
        3DnqtdyQ9sJlAfs6D+bf/6+uWZ8VVy1KxOhPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CqtrQeaK3q+eUapLsEOgqRha6TdU8BRP
        corRzIuTaP21MWUKN3FKkzChRc8Hl7t/T2uvbLFcXzmgGZDABdVUSjy0Xkrg7Xba
        HPI4cyBrfgiQZBjEG59zkvemyvSZEZbcwxZaHol4vKxaaHoNYI0JEmmtPVn5Oi2z
        TkixBzzfkCo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F3E4C7A5B;
        Sun, 23 Feb 2020 21:55:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 836B4C7A5A;
        Sun, 23 Feb 2020 21:55:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v7 06/15] bugreport: add compiler info
References: <20200214015343.201946-1-emilyshaffer@google.com>
        <20200214015343.201946-7-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2002191521140.46@tvgsbejvaqbjf.bet>
        <20200219224547.GC26221@google.com>
        <nycvar.QRO.7.76.6.2002202306390.46@tvgsbejvaqbjf.bet>
        <20200220233323.GI2447@google.com>
        <nycvar.QRO.7.76.6.2002211621470.46@tvgsbejvaqbjf.bet>
        <20200222000438.GL2447@google.com>
Date:   Sun, 23 Feb 2020 18:55:53 -0800
In-Reply-To: <20200222000438.GL2447@google.com> (Emily Shaffer's message of
        "Fri, 21 Feb 2020 16:04:38 -0800")
Message-ID: <xmqq7e0csngm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D2FCD6E-56B1-11EA-9FF5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> > Sorry, but I'm not comfortable sending code I can't check for myself
>> > (and already muscle-memoried into my format-patch/send-email workflow).
>> > If you send a scissors I can roll it into the series with your SOB.
>> 
>> But you can check it yourself! I worked _really_ hard on that Azure
>> Pipeline backing the PR builds at https://github.com/git/git. _REALLY_
>> hard. You might just as well reap the benefits so that I did not spend all
>> of that time and sweat and stress in vain...
>
> I thought a bit about this. From your Github-using point of view, "just
> check my Pipeline" sounds like "just look at one more thing". From my
> format-patch using point of view, "just check my Pipeline" sounds like
> "ugh, I have to add this remote again... I don't have a fork already?
> How do I make that? Or is my fork just 6 months behind? How do I open a
> PR again? Yeesh."

Sorry, but this is how a typical conversation between two techies who
are more intelligent than good for their social skills ;-)  Each side
is not extending its hand enough to reach the other side, expecting
that what s/he knows should be obvious to the others.

Dscho may be frustrated for you not being aware of what he worked
on, but "I worked really hard" is much less useful thing for others,
who may benefit from what he worked hard on, to hear, than "here is
one pager that tells you how to use it".  Quite honestly, reading
the above exchange from the sidelines, it is not clear to me if it
is a part of, or a completely separate from, the service offered by
GGG from the end-users' point of view.

Can some of you come up with a one-pager to cover the following (and
related but not listed) areas, that can be added as an appendix to
Documentation/SubmittingPatches?  It does not have to cover the
common stuff like style guidelines, writing good log messages, need
for test coverage, choice of fork point, etc.  "Now you have a patch
or a series of patches, but you obviously do not have direct and
personal access to all the platforms Git supports.  But there are
servies to help you test them on the more common ones."

 - How to cause TravisCI to run our test suite with your
   modification.

 - How to trigger the same on Azure Pipeline PR builds.

There may be others.

Thanks.
