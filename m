Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05DCC4363C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7345323A5D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G+TB/42f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgIUV0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 17:26:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59344 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgIUV0p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 17:26:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E89EF60A1;
        Mon, 21 Sep 2020 17:26:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D7cIl3JMBp90hmggjuWOZZN0dWo=; b=G+TB/4
        2fiO9M/ZASmmZI6XPc8oATSuOexVaG51TGH2CF3iwQrqVMvI0qKupPGvXpZzWvWq
        GNaLUGboUpDtJOYhn/3aERwdld9/K42+Ag3zYqS2IdDDdHlJezWdUSsewt7nAR8W
        i+8YGB1+YziRHPxHZuIEkpAZAuFpcc6lt1KJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=np7NzyWGPd3hu9tjo943zaTZpuZ0nPCd
        kzPZm/c/F4HcsEteU6rBEk8igQzKvqy2QB//jHVqVgyHmbf8XmPPDcaYeNwsqu+y
        +W5hlnzLWjZa2JDxxd1BELlel2CVPp4TbvPeBXQ3IJoibOHegrqECtbuFPyRr220
        WEIctZy+uD8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79037F60A0;
        Mon, 21 Sep 2020 17:26:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B52ECF609F;
        Mon, 21 Sep 2020 17:26:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/5] t3200: avoid variations of the `master` branch name
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <2f1d0a2df41f567bc1a8bc446c26e1cb8b6dc36c.1600279853.git.gitgitgadget@gmail.com>
        <20200916211150.GA617237@coredump.intra.peff.net>
        <xmqqft7huzju.fsf@gitster.c.googlers.com>
        <20200916223950.GA1207950@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2009201739250.5061@tvgsbejvaqbjf.bet>
Date:   Mon, 21 Sep 2020 14:26:39 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009201739250.5061@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Sun, 20 Sep 2020 17:43:53 +0200
        (CEST)")
Message-ID: <xmqqk0wmes8g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2392ABF0-FC51-11EA-9A8D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Jeff King <peff@peff.net> writes:
>> >
>> > > I'm on the fence on whether this matters. It's a temporary
>> > > inconsistency, assuming we eventually move to "main" as the default.
>> > > We _could_ push this change off to that patch, too, but it does make
>> > > it more noisy.
>> > ...
> However, in this instance, I think it makes more sense to use a separate
> name altogether. I settled for using `topic` instead of `main2`, and
> `new-topic` instead of `main3` locally.

I think that is sensible.  Configuration does not have to be used as
an escape hatch to make 'main2' less awkward---if we can avoid
'main2' (or 'master2'), that would be sufficient.

