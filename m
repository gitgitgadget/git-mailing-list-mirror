Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0D6C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 18:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiHJSor (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiHJSoq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 14:44:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACF3DFE
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 11:44:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4636A1B520D;
        Wed, 10 Aug 2022 14:44:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NsOBA0Dnt1LE92SkOaoE73FVNkBMij1aLOKrwC
        ONJgo=; b=ks0RGaVe7e7phjFnGtUEF7PnQ08wLkFIdtdTN4NSzYKdVs2olHkNpl
        EN7Y58jyiqNl9PSY/mApDRhU5rlH85GVCt9Nodwng9bqoZvuEZyHa4tRf8PT7th+
        JmHcVfb4ajjlk7DsluOM2M6d88/aU+CQKbbgdx6tbPJWlulWNRsPs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 402BD1B520C;
        Wed, 10 Aug 2022 14:44:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E3A401B520B;
        Wed, 10 Aug 2022 14:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: fix incorrect --write-junit-xml code
References: <pull.1288.git.1657789234416.gitgitgadget@gmail.com>
        <xmqq35f38yeb.fsf@gitster.g>
        <s4s2qr56-2948-p025-rrq7-qq56p9oo844r@tzk.qr>
        <xmqqv8r2smvr.fsf@gitster.g>
        <3qn5r283-3232-4s58-8q9s-n67o407nr816@tzk.qr>
Date:   Wed, 10 Aug 2022 11:44:40 -0700
In-Reply-To: <3qn5r283-3232-4s58-8q9s-n67o407nr816@tzk.qr> (Johannes
        Schindelin's message of "Tue, 9 Aug 2022 10:42:35 +0200 (CEST)")
Message-ID: <xmqqpmh8kkfb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EE98600-18DC-11ED-B089-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The funny thing is that you're usually simply not picking up patches that
> do not get any reviews, but for these refactorings it is somehow
> different, and I do not understand why it needs to be different.

Well, I am not sure if encouraging the maintainer to drop patches
that are not reviewed is a good overall direction you would want to
go in.

But let's try that.  Less work for me, less disruption to our tree,
and the world may be quieter and more pleasant ;-)
