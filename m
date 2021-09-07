Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AA3C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 17:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50599610C8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 17:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhIGRgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 13:36:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64452 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhIGRgp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 13:36:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5475B143340;
        Tue,  7 Sep 2021 13:35:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zeD8xrOVtO0QINXB3KvXAgJatPTkpCfJiCEkoF
        g2cuU=; b=JGK+yDmP0PRN/x2RGPlwHMjkhwcH+DGcD6OEhOBOz9xGPYrxO0xyXO
        HtcKnAZtg+MusheMlWp7Gqcz7y4gjyTVtK7yp07EGw517SiRQNoYSZSTDglYjoky
        cZhnBCXPKYoEJI7kJrKZVYBWepOIu+WT2LA3Ly6KWviXvIyj+8y5M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CA2214333E;
        Tue,  7 Sep 2021 13:35:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 92E9214333D;
        Tue,  7 Sep 2021 13:35:36 -0400 (EDT)
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
Subject: Re: [PATCH v7 0/9] ssh signing: Add commit & tag
 signing/verification via SSH keys using ssh-keygen
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <xmqqczpv99u4.fsf@gitster.g>
        <9075cdd1-e34d-5dcb-f2b8-69ae4abf587b@gigacodes.de>
Date:   Tue, 07 Sep 2021 10:35:35 -0700
In-Reply-To: <9075cdd1-e34d-5dcb-f2b8-69ae4abf587b@gigacodes.de> (Fabian
        Stelzer's message of "Mon, 30 Aug 2021 12:35:07 +0200")
Message-ID: <xmqq4kawcmqg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02E54CE4-1002-11EC-9853-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> I have this prepared but not ready for submission. I wanted to wait
> until openssh 8.7 is released (which happened recently) to make sure
> their api for this newly added feature does not change.
> I will be on vacation for the next 2 weeks but can submit it afterwards.
> I have a few additional features in mind but wanted to wait for the
> basic functionality to settle before piling stuff on top.

Reasonable.

In the meantime, people seem to be finding issues with OpenSSH 8.7's
keygen, so before doing any *new* things, we'd like to see an update
to make the stuff already posted and reviewed to work with the newer
OpenSSH.  Hoping that the fix for the incompatibility with 8.7 is
small enough, I am planning to keep the version we already have in
our tree (in 'next' but not in 'master'), so that an incremental
patch will be able to highlight what the differences are when the
bug is fixed.

After the dust settles, of course, trust on first use may be one of
the first sensible thing to add, and there may be other enhancements,
but let's see a solid base to build upon.

And please continue enjoying your vacation ;-) Looking forwared to
hearing from you when you come back.


[Reference]

* https://lore.kernel.org/git/CAPUEspgnRFNRoFuEvP1hpY3iKukk3OnF4zk85wkdkmiVuPuRTw@mail.gmail.com/
