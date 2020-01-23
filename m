Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AD7C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 06:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F3C217F4
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 06:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MvcNr7yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAWGoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 01:44:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56738 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgAWGoL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 01:44:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30DB93E949;
        Thu, 23 Jan 2020 01:44:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7r4LY1T2wzm/zW6ePwgzKYDMQio=; b=MvcNr7
        yiw8RQCg08NIk7MfQhAQk49pHn8ttwQUlapRkLGnJKzUT7WRfXr6FLB0LhiRrlpz
        5sXg7qa/acL8idU5KHDMc8GYSjv46kv1l3TbTtUYmSg4ztWu4Z/IwAhF8du13PHR
        R3ezlQnhHUFCGa/qYuZfIYKyf3jP/Dlal6+2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BSPai0xn6XYgyBvJ51wudyY10sRHYEnj
        c8CRZ/+g1ryl+8qoC7oRkAzUZXhQiBF3b+ttUtLN18xM1lT0ZkS58+fmGXbCL0r+
        h2mP0Pi02qdkK7T0duTRSY3FsAIDSvo3hAFloqhdOslzjiCIO0uuv/v2wCiKoFYT
        R/sK3dqSkIY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27CBF3E948;
        Thu, 23 Jan 2020 01:44:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 879CF3E947;
        Thu, 23 Jan 2020 01:44:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH] git: update documentation for --git-dir
References: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
        <20200123025521.GA126375@google.com>
Date:   Wed, 22 Jan 2020 22:44:07 -0800
In-Reply-To: <20200123025521.GA126375@google.com> (Emily Shaffer's message of
        "Wed, 22 Jan 2020 18:55:21 -0800")
Message-ID: <xmqqwo9i4qq0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1A49548-3DAB-11EA-8DB2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I feel biased. I want to say, "In many cases, -C=<path> is easier to
> understand than --git-dir" instead. :) But my goal with sending this
> task to you was "convince people to use -C instead of --git-dir unless
> they're really sure" - which may or may not align with the sentiment of
> the rest of the list.

Ahh, OK.  

These two are options for completely different purposes, and I tend
to agree with you that most users when they misuse --git-dir the do
want -C instead.
