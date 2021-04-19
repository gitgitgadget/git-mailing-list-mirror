Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A32DC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F252961363
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhDSVzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 17:55:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51267 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhDSVzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 17:55:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 425E4C8962;
        Mon, 19 Apr 2021 17:55:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=iSuxn8X5QV9PA0CbPK6grFwutPE=; b=Zj2Aw5CdghCFM8IFWyje
        HU5Gv84Pi7TGjjiheBgj6mceB83e1Srki9L+6yuiKvE/cmCN56F7fg+saBXw4dmp
        TIuFZAKz0jMRB3A1l4NqSdmFzlEuZUhs9h68gaueQaOHTQtI+L74I5XD5yXIA8E8
        Pe1Br6dYgT2ZDYCDY17P8BM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ZGKu6mYtig22eeCTVl2IIr+2zaNG3nG8ZPhpn8lNg3wkCz
        QmBgNtISDwjtjGuVFqq+HEoNpKnWZkz13bKzkTx1J9uRLi969m82badJywCkI64C
        YhNhM1+1aIAYSgJlFNOWzDhAp6bdHnSDVm8+oeMgIOHRshfJBa4MSPnvtYVhw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3A6DC895F;
        Mon, 19 Apr 2021 17:55:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EBA2C895E;
        Mon, 19 Apr 2021 17:55:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 0/3] config: allow overriding global/system config
References: <cover.1618297711.git.ps@pks.im> <cover.1618835148.git.ps@pks.im>
Date:   Mon, 19 Apr 2021 14:55:01 -0700
Message-ID: <xmqqlf9e7xe2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E542AC16-A159-11EB-AF49-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> this is the fifth version of my patch series to provide a way of
> overriding the global system configuration.

Hmm, this topic has been in next since April 15th.  It is
preferrable to fix things with incremental updates (the reasoning
being that while in 'seen' the issues are "mistakes by the author
alone", which may not necessarily benefit others to learn from, but
what is in 'next' are supposed to have got enough review exposure,
so any mistakes found are both of the author and reviewers, i.e.
trickier than what is found before it hits 'next' and are more worth
documenting with incremental "oops that was wrong for such and such
reason, which even our reviews missed, and here is a fix").

But I'll have to go offline for a while soon, so let's make an
exception, revert the merge of the previous round out of 'next', and
queue this in 'seen'.

Thanks.
