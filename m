Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3214C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B836E2073E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F3J2w6r4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgHJV6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:58:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54825 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgHJV6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:58:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47299EB6A6;
        Mon, 10 Aug 2020 17:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HIDjCT2CwmED
        yvuutdxFxXOgMzM=; b=F3J2w6r4tBJ+KXRVNYFQ8U1Xt8LYrTylqZ0ouqqNUyzI
        TLT7C16dTirw0EwMTq3PyJ3IlPATuTlo8R+yDneJFzYJ0NVMoGs1xFAi15G5RgGx
        71JIR3UDz0kHQuDCbcNu/aQbKIA6bqTHKkAljNX1+mo5zDHlMGPKdUqs5ZHAPIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KwjLcu
        R/ZMyfYblous7pi/hyiPvS91jUbC6HDn7nUotdOOQL7jKB1nlE1sFP3XU/kEvvH8
        HpUsx7KLD4z0/QXoyY67d60ySYcnkfByDqKi22oT1COC41f/+dAtumE70WvJAw2q
        rKaYTrHOfZ2pcJlzJoBTChEK70sAW7gjr/1wc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 405F8EB6A5;
        Mon, 10 Aug 2020 17:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 84858EB6A2;
        Mon, 10 Aug 2020 17:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] progress: don't dereference before checking for NULL
References: <20200810194748.1483784-1-martin.agren@gmail.com>
Date:   Mon, 10 Aug 2020 14:57:57 -0700
In-Reply-To: <20200810194748.1483784-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 10 Aug 2020 21:47:48 +0200")
Message-ID: <xmqqo8nib1ui.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8E132E5A-DB54-11EA-898B-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> The progress API handles NULL just fine, but
> that's the NULL-ness of `*p_progress`, e.g., when running with
> `--no-progress`. If `p_progress` is NULL, chances are that's a mistake.

True, true.

Thanks.
