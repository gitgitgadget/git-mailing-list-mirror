Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B3CC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DCD16109E
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhIVSpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 14:45:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62502 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIVSpF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 14:45:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97F36157B9C;
        Wed, 22 Sep 2021 14:43:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ckYPvBfchqxy
        HaJLmgmCu4a64Vc+T7HRs2turnnDYJg=; b=QgbfliAj20szZt3dAuTRsxyfIGq7
        ANY8UhHO0h4iUZf7wixVUgV7eoxeCyhS0gGFLv8XiqvwbXOpqcZciuiXmemqn/Sn
        E688u3XiTVI2Y+HtNtMnib4xOKbUseBLeZl/LutEatmnN0TR5WdhCJW3oMWoQNr4
        Vzp9nk3GejmeGBI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91448157B9B;
        Wed, 22 Sep 2021 14:43:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EAC77157B95;
        Wed, 22 Sep 2021 14:43:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/3] difftool dir-diff symlink bug fix and cleanup
 patches
References: <20210919203832.91207-1-davvid@gmail.com>
        <xmqqmto7ay6s.fsf@gitster.g>
        <CAJDDKr6m9kXKSuQhC5g_OkJa52QRMtf8s8Bd0YbRNnzAgudifQ@mail.gmail.com>
Date:   Wed, 22 Sep 2021 11:43:30 -0700
In-Reply-To: <CAJDDKr6m9kXKSuQhC5g_OkJa52QRMtf8s8Bd0YbRNnzAgudifQ@mail.gmail.com>
        (David Aguilar's message of "Mon, 20 Sep 2021 14:43:37 -0700")
Message-ID: <xmqqv92s78od.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC31DFAA-1BD4-11EC-ABE2-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:


> Thanks. Patch 3/3 seems trivially correct so I won't resend that either=
.
>
> =C3=86var had notes about 2/3 which can be split off to a separate topi=
c,
> so that's the only one I'll plan to resend all by itself --in-reply-to
> that thread.

Please don't do this.  Your topic is not the only one I am looking
at, and being able to find the whole thing together is always more
efficient than having to go back, re-read the discussion and pick
the latest iteration of each step individually (which will not work
if the topic needs reordering of the patches in it anyway).

> I see that it's already in "seen". I can send a replacement patch
> shortly ...

Please do not read anything in a topic being (or not being, for that
matter) "seen".  It means "the maintainer has seen it and thought it
might be interesting at one point of time in the past" and nothing
more.  It certainly does not mean the maintainer is keeping track of
how the topic is evolving and knows which piece will be replaced and
which piece is already done.

Thanks.
