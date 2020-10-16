Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8278C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B952065D
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cGWKtIqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbgJPWEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:04:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58417 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732245AbgJPWEo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 18:04:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 88184101E5B;
        Fri, 16 Oct 2020 18:04:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q3UfG9viDIDTHweRonf0XoF1SyQ=; b=cGWKtI
        qpfWXTXoXWziZH+cckGF/zYBeE1bJ4EOKwZBA2d8i1ZQpEezUy/V15P6FRsXCzJR
        +/S/o+9SpwOt7mP490GTrOgxNNj1Ts/wdiTJQ/+NghKnDlUmKkg46utgBSn1QHBG
        6jFb2meajXcgPozjrWXKO2iwyyNdWOGZTZ/xM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TE6KQy5rC5Y4Vq68ejvL5XmZ5AotaI0e
        jaSytI6SX+SADk5bF0hElOB/BGfELQ/KxRVMzwmeLLKjbtDu7zLM6F/E9SKV5+tH
        0nG9e218tkFUtq08X4I/b3DhKeGESxFxzJjDGhsOgxC+Z2rKPWfb9OdWNnPIVllW
        knjYlnC+udc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 803F9101E5A;
        Fri, 16 Oct 2020 18:04:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C2881101E57;
        Fri, 16 Oct 2020 18:04:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: demonstrate difference between 'am' and 'apply'
References: <20201016205232.2546562-1-emilyshaffer@google.com>
        <20201016205232.2546562-3-emilyshaffer@google.com>
        <20201016211327.GC3356073@coredump.intra.peff.net>
Date:   Fri, 16 Oct 2020 15:04:38 -0700
In-Reply-To: <20201016211327.GC3356073@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 16 Oct 2020 17:13:27 -0400")
Message-ID: <xmqqblh1akuh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 965257A4-0FFB-11EB-8308-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it is OK as-is, but it might be easier to follow visually with
> text like:
>
>    Here's a sample patch that we'll use below.
>
>    -----
>    $ cat the-patch, etc
>    -----
>
>
>    We can apply it with `git am`, which will create a new commit:
>
>    -----
>    $ git am ...etc...
>    -----
>
> Especially in the HTML version, which puts the code blocks into a box
> with a different backgrounds, that makes it easy to visually jump to
> each box without having to carefully read the contents.

I agree that presentation-wise the above style is much nicer to
follow.
