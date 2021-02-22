Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57499C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 20:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150BC64E02
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 20:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhBVUDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 15:03:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50870 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhBVUDG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 15:03:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6114A103AF1;
        Mon, 22 Feb 2021 15:02:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cvieZ/h1Ndpdo49ovSXqB7UJ1zQ=; b=tSzuSv
        lFD0sq7RBD8kAZdIRM6uO+y6jQbs5C2UCKNlR0lQriv4RqnKece34wpL7mQS22xs
        WMOgCQCUvKCREDsEBnn99BjP+8UfF068+mKZbmlsnuXp2n/plSEapeXWzM9Kjqk5
        MO3VfxbU+FYiNA2Gs9GXdDlTgk3Wzr//ROveI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ofeS2uRvo/0I5oIZLakOwYeU6YU1RHNv
        0xBoWULnHQ5pTTauY03bfxP3pd9NhH9owmSSqUQIpFGgLEe6spjL+PMwofrBSLmL
        cpyj8JYpA7L2mw6OVYk8dDOfmP7IbKQXuOBuYCcpW731lQtX+KvZfO6BbLOmMmk7
        w7XfyT2MPVE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A68D103AF0;
        Mon, 22 Feb 2021 15:02:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C617103AE7;
        Mon, 22 Feb 2021 15:02:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] test-lib-functions: use BUG() in 'test_must_fail'
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
        <20210221192512.3096291-2-szeder.dev@gmail.com>
        <YDLXf+OoJabrJTWu@coredump.intra.peff.net>
        <YDQBxqTbuYgq1xV8@coredump.intra.peff.net>
        <YDQDX/zdGTI1HmJ9@coredump.intra.peff.net>
Date:   Mon, 22 Feb 2021 12:02:20 -0800
In-Reply-To: <YDQDX/zdGTI1HmJ9@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 22 Feb 2021 14:17:51 -0500")
Message-ID: <xmqqk0qz7twz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E03F0738-7548-11EB-A560-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... Let's also automatically a test_done at the
> end, ...

s/a test_done/add &/ probably.

