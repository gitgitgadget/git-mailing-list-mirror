Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CB8C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7D660E53
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbhHDRdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:33:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60132 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbhHDRcy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 13:32:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2CC431304CF;
        Wed,  4 Aug 2021 13:32:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7XJpFDsIuXlPYhNE0loctA9/8DouLUgcrF6QVK
        bGdbQ=; b=T97fwRaqp8IHwNyV90eFbF+RzNS2Jq4/JmB3j+oZnZ1FJhUc1yncdS
        zE5AXzvMB6wGp+/M07zc6gabUxpV3Q9AAdVS4malCoxPIXozXna28+f4XfaWN8qC
        hRi5eeuTUU6vDEY855vaoZGOaJbsM97J0pz+WC92Qu8DTokpnZ5JY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2401B1304CE;
        Wed,  4 Aug 2021 13:32:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9E431304CD;
        Wed,  4 Aug 2021 13:32:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 6/9] ssh signing: verify signatures using ssh-keygen
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <dc092c7979618d252f7a5a0a5bbe497d8011fd5b.1627998358.git.gitgitgadget@gmail.com>
        <xmqqzgtyrszl.fsf@gitster.g>
        <fb7c504f-90f7-9a79-1903-e3942f43e808@gigacodes.de>
Date:   Wed, 04 Aug 2021 10:32:36 -0700
In-Reply-To: <fb7c504f-90f7-9a79-1903-e3942f43e808@gigacodes.de> (Fabian
        Stelzer's message of "Wed, 4 Aug 2021 11:01:53 +0200")
Message-ID: <xmqqo8adp13f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F64A63E8-F549-11EB-9DC2-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> Generally i think a broken config should die() early as it does in
> this case with the return.

Yes, I was just making sure if somebody took a look at the callchain
to make sure it dies, as I didn't ;-)

Thanks.
