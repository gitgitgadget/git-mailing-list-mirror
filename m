Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F8C433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 18:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BC9223AC
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 18:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mtxOgBZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgJSS03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 14:26:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58126 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbgJSS03 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 14:26:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91CC2EFBAF;
        Mon, 19 Oct 2020 14:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wzoWdqx5hJ76Qo8LppiVwkGkYZU=; b=mtxOgB
        ZrLBkYcRLcjridoBpPHXgWwwA+mKERJhGvufl555aOWq1o4u3uJ92ljHzjTegNfT
        Vmv1UEIKsszeGdmXu+wo9wiQcGq/l6yTnqA079C60LlGsAG+KHb3GAy8Dg18p4CT
        yADtgFgiyIC/86lLtDaFF9pNHPhYF4z6kEEjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bDdX1x98v9OOe4QW1Na4lu2WJ6ITAszy
        QGo3UAipbT11kiQEOsNr6oPL73QA5JPPamvFUeRiyDFqFDicyu3XuR9WBTgf1Ron
        iniSRvyx9XGlnRkAa0VzuSUBWKEW9JQXa1bhOBst8WglC/bUK8nloh9XFM7lqlQG
        vJvC9cJPiww=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89F95EFBAE;
        Mon, 19 Oct 2020 14:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C6684EFBAD;
        Mon, 19 Oct 2020 14:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jeff King <peff@peff.net>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Clarify and expand description of --signoff
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
        <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com>
        <CAPc5daWenXds=0BW0CXa=4MOF2UxDeQ8DF2+7V9-WkKwCFCDBw@mail.gmail.com>
        <20201016015937.GA3335046@coredump.intra.peff.net>
        <xmqqft6eewc5.fsf@gitster.c.googlers.com>
        <xmqqh7quaqwb.fsf@gitster.c.googlers.com>
        <20201016201119.GA3356073@coredump.intra.peff.net>
        <xmqqwnzn73og.fsf@gitster.c.googlers.com>
        <20201019155338.GK181507@mit.edu>
Date:   Mon, 19 Oct 2020 11:26:23 -0700
In-Reply-To: <20201019155338.GK181507@mit.edu> (Theodore Y. Ts'o's message of
        "Mon, 19 Oct 2020 11:53:38 -0400")
Message-ID: <xmqqmu0it6ls.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9857A1A0-1238-11EB-A444-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Theodore Y. Ts'o" <tytso@mit.edu> writes:

>> > You said "squashing", but I'd suggest keeping it as its own patch on top
>> > of Bradley's.
>> 
>> OK, let's do so.
>> 
>> I recall I read that Bradley's patch needs a bit of word/grammo
>> polishing?
>
> Well, I pointed out a missing article ("a") in the line *above*
> Bradley's change in two man pages.  It's a minor nit, and it's
> unrelated to his proposed change.  I have no opinion about whether
> it's better to do it separately from his change or as a separate
> commit.

Thanks for reminding me.  In any case, an updated version that ended
up being a 3-patch series is now on the table.  I think they are in
good shape to be merged down.

Thanks.
