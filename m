Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834ABC433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501082071B
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IjkpCaHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgGPRjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:39:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50936 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgGPRjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 13:39:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBB3D7848E;
        Thu, 16 Jul 2020 13:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p5wnfMxnFKP/7jKgz6ZAF2jT+Mo=; b=IjkpCa
        HiVoliYCLuud9ZYXz0x0FCdUVE8hgMuwV6X54Z7CmPB1g9yveSWXSC4cO1+XNbzH
        k4mkRTgw4rl2UVDxAakA4expw7EPCmYcbEQda4oNg7Tw31yzGfLl3YwktZMmw6Yg
        qAlfQrtw3lPtG1ONRoTQdRXKj3o4O+QLubhNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dDRA9TN2ogWrDwnhz69OP+g76lbGWUr0
        rOKZlDnomxRd5VAoWv4dwSsiqIS1BKt/QoGqvFUwxM+9jEOSGoYFCT3Vx8XkMGaR
        3cxiV/sc8KSAx7Ols3G6kdUVAQqh/gMpqthxwAJ+hIw9KP6dGlvCg5N1FkXSa60P
        Y14qW6KnI4w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E31797848D;
        Thu, 16 Jul 2020 13:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59BBA7848C;
        Thu, 16 Jul 2020 13:39:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v7 0/5] cleanup ra/rebase-i-more-options
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200716173221.103295-1-phillip.wood123@gmail.com>
Date:   Thu, 16 Jul 2020 10:39:12 -0700
In-Reply-To: <20200716173221.103295-1-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Thu, 16 Jul 2020 18:32:16 +0100")
Message-ID: <xmqqft9rgy0v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 436D9F5C-C78B-11EA-A5A8-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> format-patch and am could do with having their similar messages
> updated in the future

That's a good #leftoverbits topic.
