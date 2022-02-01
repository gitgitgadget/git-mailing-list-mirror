Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632FAC433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbiBATTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 14:19:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57206 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiBATTt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 14:19:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DEAF116ECF5;
        Tue,  1 Feb 2022 14:19:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PtwJKaypoWgrqvi4AA9aBF+CDrhPsrzcCF0r2H
        khwPA=; b=kZaW4lIXjdhln9FPFvb1xpBLj6fcx/G4TViJId9ltE7w6Ny1NlKPW7
        qWv6Dbd2hGCIukjPw9qiGa5sBHknpc5wdNlbac9vpc7kaEUmkTNnd9tSjmudE111
        kuQ90ND01pyXc7q67yD3P7rZtvKHvyy8n75IdVC0LSrY1eYhh498c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6F3116ECF4;
        Tue,  1 Feb 2022 14:19:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4D5EE16ECF2;
        Tue,  1 Feb 2022 14:19:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>
Subject: Re: [PATCH RESEND] subtree: force merge commit
References: <xmqqpmqy12u0.fsf@gitster.g>
        <20220201172601.262718-1-aclopte@gmail.com>
Date:   Tue, 01 Feb 2022 11:19:45 -0800
In-Reply-To: <20220201172601.262718-1-aclopte@gmail.com> (Johannes
        Altmanninger's message of "Tue, 1 Feb 2022 18:26:04 +0100")
Message-ID: <xmqqtudics32.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EABD0778-8393-11EC-8F88-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> BTW is there a good way to tell "git send-email --in-reply-to"
> to prefill "To:" and "Cc:" based on the message I'm replying to?

I do not think there is, and I do not think it is readily feasible.
Given a message ID, how would you figure out these two values?
Hardcode the URL of mailing list archive and the rules to find these
values given a message ID?  What if you have a local mail archive
that you'd rather use instead of going to the public internet?
