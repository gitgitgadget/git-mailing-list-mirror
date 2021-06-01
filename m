Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A850C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 22:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C60610E7
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 22:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhFAW3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 18:29:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57041 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhFAW3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 18:29:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53A8413FA72;
        Tue,  1 Jun 2021 18:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GM2umB//oXD9JOYktUWngA9mDBQqtiaBuiixaP
        2NG9E=; b=CHVMfUB9Ax2EIF5VpzKLywg9eZHLC9LERi5TrR9wD4A2gaf/UQPrS0
        P6qiJbBkq5ysq0bPKcS7OEXrND7iHb7ffc5nOd+lVlCUr8R81/SPxywtpYy6jw32
        vUTC3uzFPb2SNVGzV7IC6gpiTJ1z7DZTI2rez2tYDQVhFpy+MKymc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CBCE13FA71;
        Tue,  1 Jun 2021 18:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 948C613FA70;
        Tue,  1 Jun 2021 18:28:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
Date:   Wed, 02 Jun 2021 07:28:02 +0900
In-Reply-To: <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
        (David Aguilar's message of "Tue, 1 Jun 2021 14:56:48 -0700")
Message-ID: <xmqqzgw9qky5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1D6B12A-C328-11EB-84E4-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> +1 for merge.conflictstyle = diff3, rerere.enabled = true, and
> log.decorate = short from me. I noticed others already mentioned
> these.

As the inventor of rerere, I agree on rerere.enabled.  It was made
opt-in only because I thought it was somewhat risky when the feature
was introduced, but it has been stable and useful, and it is long
overdue to be enabled by default.

I do not think of any downside with conflictstyle being diff3 (and
think of only upside).  As to log.decorate, I see it as mostly
personal preference and the current default of "auto" seems more
appropriate.
