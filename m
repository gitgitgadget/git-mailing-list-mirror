Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732B1C4361B
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292FE2389F
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 07:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgLTHd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 02:33:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60968 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgLTHd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 02:33:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02095FAA09;
        Sun, 20 Dec 2020 02:32:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JHJq+S2x9lv50wuin8/JcjYdilo=; b=Q+/2Jy
        Ge5TGnNy88hxEzx/blFBfjAbv6yRHMk60ErPvk7atA6Kdc+m9/sWSVYwMUFl5Bq/
        DP6BZ3OR0P+qUrKiCsWHyqSUFbL9oR7pWl3z5gu+XqHOn2Ue0cklfB1lb96aTbRm
        xcIV8BcVDnj20M+VlnMfaClmuoZRZDmo3+MZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wAl3X2TttuGAAJ8a/xYuAdLbQq22AAvh
        yXvvTq35O++yN+9MMYJOxDkFyrA+Tar9mEMai0r43t4zgw9Sn4rECOXlb6EQbtWN
        azpRWF4m5wu8kGP26UVwqPJe2EpVGhGcNQ75W3kncW2sjZzmwM6D53YE5s7Oy0aL
        R7zrSzBfNlI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EFFF5FAA08;
        Sun, 20 Dec 2020 02:32:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3A7EFFA9FF;
        Sun, 20 Dec 2020 02:32:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2020, #03; Fri, 18)
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
        <CABPp-BFoSz40-1mNLrxCgMTccYqLOg6ifX5PeLDutbimF9ysPQ@mail.gmail.com>
Date:   Sat, 19 Dec 2020 23:32:39 -0800
In-Reply-To: <CABPp-BFoSz40-1mNLrxCgMTccYqLOg6ifX5PeLDutbimF9ysPQ@mail.gmail.com>
        (Elijah Newren's message of "Sat, 19 Dec 2020 18:19:50 -0800")
Message-ID: <xmqqblepnd9k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AE1D4C2-4295-11EB-B2F9-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> What do you mean when you say these two topics are tangled?

When two topics are "one builds on top of the whole of the other",
my tool labels "uses" vs "is used by".  All other cases where two
topics share a commit are labeled as "tangled", as I couldn't come
up with any better phrase.
