Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA19EC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 02:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6F023B2A
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 02:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbhAWC2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 21:28:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57175 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhAWC2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 21:28:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81FCB113F47;
        Fri, 22 Jan 2021 21:27:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ori/jwwKTxfw+EJCml9i4/H2Fo0=; b=pWAH5n
        nH9O1gkdN/IoSooyeZ7w5/JOmLF7Zy5hMtGlR/5JxiUcOHxTUePbKeXk9vBlHVSt
        eSje1UhU6uF38lrlb7Cb4LYWyKyrPVB8/Nf+IrYnr42g1/Y9zdE+oxd8jObIHOpO
        4+57LWYfgWw4/VOy5bqaOR62cNd8AN5ddT/5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rWchJODTHO81UGJ8iS9cbCjlwUCAUkzS
        KY99rUdCvLy/VUyATmmYxjtxVyFQ4mTkC/6hhhx2L9Azn3OXYOkSDHYVp9LcC4aA
        aq57vTTz5uAM4T8/SjVkWjlKK0fiaI7DuAwAfheloZ+/EhVK1xAEeXw8gOvAqSv/
        zxJ/0pWwtCw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79EDB113F46;
        Fri, 22 Jan 2021 21:27:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C3909113F45;
        Fri, 22 Jan 2021 21:27:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin von Zweigbergk <martinvonz@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        "Patricia B. C." <pati.camsky@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Can git change?
References: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com>
        <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com>
        <xmqqpn1w95dj.fsf@gitster.c.googlers.com>
        <CANiSa6gEJ8ezVLhHf+TkGpqvEwvb8HhqtU3ETKiopjLQj6E_QQ@mail.gmail.com>
Date:   Fri, 22 Jan 2021 18:27:30 -0800
In-Reply-To: <CANiSa6gEJ8ezVLhHf+TkGpqvEwvb8HhqtU3ETKiopjLQj6E_QQ@mail.gmail.com>
        (Martin von Zweigbergk's message of "Fri, 22 Jan 2021 12:43:53 -1000")
Message-ID: <xmqqh7n85qwd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C3F460E-5D22-11EB-83E4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> This is probably quite off topic for the thread, but I'm curious why
> you think it was a bad idea to have octopus merges in git.git's
> history (there seem to be 37 of them).

Octoupi in our history, at least the older ones, solve no real life
problem; it only gives us "now we have something cool-looking that
other people's version control systems never had", which is of
dubious value.

And their presense makes bisection less efficient than it could be
around them, which is a real downside.
