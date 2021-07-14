Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BE9C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FF4613CF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhGNWXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:23:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58610 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGNWXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:23:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68CCFD2616;
        Wed, 14 Jul 2021 18:20:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jNfjARX4KJ5jJ10UCw66J/M9i6o0wf5WOVjPVt
        3Ropk=; b=m1W2wK9YTVtCU52jT0hHZyssX9Pef9i+DkRmMqlFtE2dBLCvSJML8m
        yl/ror4E2MQZ0vR1zOM5x9bpeVaQCi7oqlaOMxTO7lDUWOyXHqViOjvZhbkU+L2A
        nLAuHzgk8h8BvGkUk5I0bqL3cLO8siIZjk6Ldq5MfDqPD56RdY22s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FAFFD2615;
        Wed, 14 Jul 2021 18:20:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1AE5D2614;
        Wed, 14 Jul 2021 18:20:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] ci(check-whitespace): stop requiring a read/write
 token
References: <pull.995.git.1626300577.gitgitgadget@gmail.com>
        <b54c137cb14527c14bd7c990f9cf32dca50ba5dc.1626300577.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 15:20:43 -0700
In-Reply-To: <b54c137cb14527c14bd7c990f9cf32dca50ba5dc.1626300577.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 14 Jul 2021
        22:09:36 +0000")
Message-ID: <xmqq1r80v8p0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAEECB1C-E4F1-11EB-850F-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> However, the `check-whitespace` workflow threw a wrench into this plan:
> it _requires_ write access (because it wants to add a PR comment in case
> of a whitespace issue).

OK.
