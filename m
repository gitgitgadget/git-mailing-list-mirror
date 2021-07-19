Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD4C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5AE60FE4
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349376AbhGSQVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:21:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65163 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343663AbhGSQTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:19:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D4CB132AE5;
        Mon, 19 Jul 2021 12:59:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cCvDe7EnPf75fy0o/K/ZaA6wOwQeUK2fY8mR4e
        xaBJM=; b=OfKS6eLkpgLuRVsQ0FKgcsVCN4KkLA2CeMqiQixuyRZELHMdmoD6+6
        uDRxb8Bk/xmVYDgRKiifQGYdtcUdafJs85jBjxtqX+cuo0wNL/j7yFz9KRmbfKH0
        iOETJNnKEQpk03Zgq+gxqIps+aM74T8naPJF2UkRI1jSNGU9JjbKo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54822132AE4;
        Mon, 19 Jul 2021 12:59:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 89508132AE1;
        Mon, 19 Jul 2021 12:59:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs file backend: remove dead "errno == EISDIR" code
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
        <YO8PBBJZ2Q+5ZqFs@coredump.intra.peff.net>
        <871r801yp6.fsf@evledraar.gmail.com>
        <YO9wCqetxHii+TvK@coredump.intra.peff.net>
        <875yxczbd6.fsf@evledraar.gmail.com>
        <YO/EpxU0NG+HVSlx@coredump.intra.peff.net>
        <xmqqk0lppw49.fsf@gitster.g>
        <YPJBY8LjiwYRyDOu@coredump.intra.peff.net>
        <xmqqo8aynwd6.fsf@gitster.g>
Date:   Mon, 19 Jul 2021 09:59:41 -0700
In-Reply-To: <xmqqo8aynwd6.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        19 Jul 2021 08:42:29 -0700")
Message-ID: <xmqqzguime82.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6EDFD02-E8B2-11EB-A8D0-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I did not check the v2 thouroughly myself, but read it enough to
> convince me that it would be good preliminary clean-up steps to come
> before the main series (modulo typoes and nits, as you pointed out).

I've came to the same conclusion as you did.  The patches themselves
are good, modulo typos and some inaccuracies in the comment string
and commit log messages, that would not hurt immediate execution of
the resulting code but they need updates to help future developers
who need to interact with these commits and its results.

Thanks.
