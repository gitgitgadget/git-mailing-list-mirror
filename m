Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3BCC433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 01:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DDBD61208
	for <git@archiver.kernel.org>; Mon,  3 May 2021 01:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhECBO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 21:14:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58779 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhECBO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 21:14:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CB9313A2E4;
        Sun,  2 May 2021 21:13:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wV5Q5EgijP4v+28a8hnW0F+1tygEr0mGRWuyIA
        C/STg=; b=RvVpTC7R4WtATbLwJupwJh0lVrq6y5BgxeNUZ75vuDIS9WZvR3avwM
        PXa/WhlFruFFiw8UEGPoj640e6hhkKAObCzBxbAtoDfM2mcu7hqGpSYblDbFRjrZ
        RMslr16o1gVJohzRH/PiO+7fhKXUyP6ouyZWCHbv+Hqysg/zyPVuE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1595213A2E3;
        Sun,  2 May 2021 21:13:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E78A13A2E2;
        Sun,  2 May 2021 21:13:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Josh Soref <jsoref@gmail.com>,
        "gitgitgadget/git" 
        <reply+AAQFMLC42KHLQTLKSC5H3XV6TILQ3EVBNHHDGQXBRY@reply.github.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [gitgitgadget/git] git-merge: rewrite already up to date
 message (#934)
References: <gitgitgadget/git/pull/934@github.com>
        <gitgitgadget/git/pull/934/c830744540@github.com>
        <CACZqfqA8u8cRM5xSdnArUW7tGOJX9dVO41FsmQU4-d2NyiNCiA@mail.gmail.com>
        <CAPig+cS+b-SV6SUkhWMui7_vTEeJYumDDDM10DdrkNqpgm=z_A@mail.gmail.com>
        <CAPig+cSz6TDs6=URFcmi8w0zdvTKV9k2346LHpiWbqKm4tXzRQ@mail.gmail.com>
Date:   Mon, 03 May 2021 10:13:29 +0900
In-Reply-To: <CAPig+cSz6TDs6=URFcmi8w0zdvTKV9k2346LHpiWbqKm4tXzRQ@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 2 May 2021 19:19:37 -0400")
Message-ID: <xmqqa6pcbow6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C639D080-ABAC-11EB-AD01-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On second thought, I don't think I will make this change since none of
> the messages in `notes-merge.c` have been marked for localization yet
> -- and there are a lot of messages in that file -- so wrapping just
> this one message in `_(...)` would be inconsistent, and marking all
> messages in `notes-merge.c` as localizable is outside the scope of
> this series.

I looked at the neighbouring code when I gave the "grep" output,
because I wondered exactly about the same thing, and I agree with
your conclusion here.

> So, at the moment, I don't plan on re-rolling this series, and
> hopefully Junio can pick it up as-is (but, of course, will re-roll if
> someone spots something which needs fixing).

Thanks.
