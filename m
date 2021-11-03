Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C053C433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFDE60EE9
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 17:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhKCRqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:46:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51251 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKCRqy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 13:46:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BAF55165CA0;
        Wed,  3 Nov 2021 13:44:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DtujAVH/DxPwL7h0E4ROGCjoFcT6xtPSB8rZvg
        Lahxw=; b=gRWSfjF4SmKXWJMdK2dy19uKRA5rNvw7PYCgsKobnxAGuZFpxCL+1e
        YaMiNljbkmqgVjXzfCyy7feUhqVg+yQ3+GE21gjkuiGTG43h39OfnnKk6uBuB/VL
        edpykDLKXxbMpwGjmyjmkealWtSGrNQj/DHQTLihkKyxR9C+nQRlk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3288165C9F;
        Wed,  3 Nov 2021 13:44:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD110165C9E;
        Wed,  3 Nov 2021 13:44:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>
Subject: Re: [PATCH] rebase -i: fix rewording with
 --committer-date-is-author-date
References: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
        <YYG8aq85UmMMVW4l@coredump.intra.peff.net>
        <101071b2-0b7d-5ee8-ca81-171e08a1ffdf@gmail.com>
        <YYJ1rA8F22SSBeNS@coredump.intra.peff.net>
Date:   Wed, 03 Nov 2021 10:44:11 -0700
In-Reply-To: <YYJ1rA8F22SSBeNS@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 3 Nov 2021 07:42:36 -0400")
Message-ID: <xmqqk0hp6sno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A81020FC-3CCD-11EC-9D76-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm happy enough with it. I don't know what the plan is for the -rc
> period, though. AFAICT the bug is in v2.33.1, so it's not technically a
> v2.34-rc problem. It could wait for the next maint release.

Hmph, if it was in v2.33.0 then it is not, but if it was introduced
between v2.33.0 and v2.33.1, then it is a problem for the current
cycle, no?
