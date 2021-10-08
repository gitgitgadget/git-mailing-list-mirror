Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B131FC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B29060F55
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbhJHV4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:56:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64687 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJHV4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:56:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB56AF0209;
        Fri,  8 Oct 2021 17:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1gLuEmuZ6aFv+Nfh+FEgUWsob2FmJx/5jk2OU/
        8bfFA=; b=bCHDkf55Jy9ZgxLOrMf2mmZB4zsa04UTNisx9chsZHVM+UjZhVgWIb
        V0Au8NcRM3vDKsF/wuXx/u3YdLuWifWGjWzWImwTWa2k7gxS2Kfb70eeiJXP15ql
        xUhO+CRU8mn3dxdtQ3lPuIsZLFzHAKQvRe03P9s3qULriKDVALMmY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B21C9F0208;
        Fri,  8 Oct 2021 17:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25177F0207;
        Fri,  8 Oct 2021 17:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alan Mackenzie <acm@muc.de>, git@vger.kernel.org
Subject: Re: How do I get the file contents from an arbitrary revision to
 stdout?
References: <YWCFFcNeNVTYcELN@ACM> <YWCj6NqMrxksN1V8@coredump.intra.peff.net>
Date:   Fri, 08 Oct 2021 14:54:51 -0700
In-Reply-To: <YWCj6NqMrxksN1V8@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 8 Oct 2021 16:02:48 -0400")
Message-ID: <xmqqtuhri3mc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E202F00-2882-11EC-A082-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   git cat-file -p bar-branch:foo.c
>
> (the "-p" is "pretty-print based on the object's type", so the two are
> equivalent).

IIRC, "cat-file -p" doesn't do textconv, but "show" would, and
depending on the use case the difference may matter.
