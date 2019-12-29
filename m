Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE2DC2D0C0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 23:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC0D207FD
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 23:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wifGz/QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfL2Xa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 18:30:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53157 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfL2XaY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 18:30:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE86A9779E;
        Sun, 29 Dec 2019 18:30:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7hRDZpBuOZAEnFxpqHCEru1K5nQ=; b=wifGz/
        QKBeO7WgdpLek/wMI+QRGNfTGRMvTTNMsHWxn1EZQ5w3VCj9FebrOXaTBOmXLQdN
        UQa7l6EiQyf0JGz3B+lzZK4DtSc3uzlhK939DU5FVf61UKASmD3W7PzTs1ABrVqK
        jpBaEo7K4CVBrc519AY/KhdeE/KWAEo2j5EhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MyVy7QiKOkElxPbrfGPJi8gzM4iLNdhG
        8tBZzMM4G7RRsc9XImkyzD+sVL8KKg/UDWYSUliIZg+a5YGRPkPhvkPcDB6IakzW
        T4X3UGkzAyeLJonngrOwGUs8897pmBzr6cze3Dl2trOQb2wMI/gqFfFiATvcw7if
        E5YX8orTRkQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E67199779D;
        Sun, 29 Dec 2019 18:30:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1795E9779C;
        Sun, 29 Dec 2019 18:30:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Autotools version
References: <CAH8yC8kwsnnvmo2Oyx-NDN17KGWTgDB+_CwNqsqJQWWe47sf3Q@mail.gmail.com>
Date:   Sun, 29 Dec 2019 15:30:17 -0800
In-Reply-To: <CAH8yC8kwsnnvmo2Oyx-NDN17KGWTgDB+_CwNqsqJQWWe47sf3Q@mail.gmail.com>
        (Jeffrey Walton's message of "Sun, 29 Dec 2019 17:25:06 -0500")
Message-ID: <xmqq4kxiiuba.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D8EFA18-2A93-11EA-BE5F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> Hi Everyone,
>
> I'm trying to build 2.24.1 from sources. It is failing on an old
> Fedora machine with the error:
>
>     Autoconf 2.59 or higher is required
>
> The irony of Autootools checking version numbers is not lost on me
> considering I only run configure, make and make install.
>
> Would it be possible to drop the Autotools version back to earlier
> versions of Git?


Hmph, because the primary way to use our build procedure is to tweak
with either command line or config.mak file without using configure
at all, and because I don't use ./configure at all, I didn't even
know that our release procedure was adding ./configure to the tarball.

I wonder if it would help for me to stop shipping the file so that
anybody who wants to use 'configure' can do so using their own
version of autoconf?  That way, there won't be an issue like this
that may come from autoconf & autotools versions, I guess.

I dunno.
