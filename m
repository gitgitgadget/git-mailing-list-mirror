Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054FDC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 15:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F29610A4
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 15:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbhHMPBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:01:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59763 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbhHMPBF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 11:01:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32562E46D8;
        Fri, 13 Aug 2021 11:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=333VbUt6X+AeREEQUjGPZqI9S8zIqz5KB775Hx
        n6lV0=; b=jdr0DYdXNjFVD46wfiF0R5jQjIEsEz1ZWoXGrd8g0GDVWRBsFMVXaB
        r6dR3+Ga9+C/7hZFQ5c3W5KeB24ziaIDMQVjEPJD3jgoCmAiwbDRtS6KWIYOWYLF
        FBfwiHJ4PHbdFcQcHpGui28LTiLq/74OcAI+pUoPvDySHkIrBgLUw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 263BBE46D6;
        Fri, 13 Aug 2021 11:00:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7EAB0E46D3;
        Fri, 13 Aug 2021 11:00:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com>
Date:   Fri, 13 Aug 2021 08:00:36 -0700
In-Reply-To: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 13 Aug 2021 10:22:19 -0400")
Message-ID: <xmqqmtplxucr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37E1FF06-FC47-11EB-A143-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> 2.32.0-rc2 passes on the NonStop x86 platform. ia64 is slower and
> still running. The test failure is t9001 because there is no
> sendmail on the platform. Is there a suitable dependency that I
> can use add to bypass this test?

I do not think of any offhand.  I usually use GIT_SKIP_TESTS
environment variable for things like this.
