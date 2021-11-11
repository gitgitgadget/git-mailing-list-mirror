Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7D8C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 00:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9287961250
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 00:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhKKAO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:14:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57401 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhKKAO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 19:14:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0837EA091;
        Wed, 10 Nov 2021 19:11:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nEZnuAXU+SX/urCfKhpaINGXp9PLJqTpqSUoh/
        lmw78=; b=GHY4dpu7ILKF+6oFD2me3nPaBsi1x35NPsZhEv9B2QS02vceRwGfr6
        Svjk8gAXIbGeQdUyBpfBBdfvIrqNBD6cu8VJ/mjN3fCug0MGZXJfi2FwIZlEUb7V
        aLdEy51hGKwQXdEeLhsGoXGsEQ/6NQ2cSFA/P1oKPMgM1iqewzwzw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7B2BEA090;
        Wed, 10 Nov 2021 19:11:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F3C1EA08D;
        Wed, 10 Nov 2021 19:11:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Anders Kaseorg <andersk@mit.edu>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v5 1/4] fetch: Protect branches checked out in all
 worktrees
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu>
        <20211109230941.2518143-1-andersk@mit.edu>
        <nycvar.QRO.7.76.6.2111101315330.21127@tvgsbejvaqbjf.bet>
        <xmqq8rxvwp4b.fsf@gitster.g>
Date:   Wed, 10 Nov 2021 16:11:35 -0800
In-Reply-To: <xmqq8rxvwp4b.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        10 Nov 2021 15:46:28 -0800")
Message-ID: <xmqq4k8jwnyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFB6477C-4283-11EC-9D86-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So, correctness-wise, I do not think there is much to tweak further
> on top of this round.  I've always queued this round more or less
> as-is.

Gahh.  Sorry for the typo: "I've already queued", of course.

