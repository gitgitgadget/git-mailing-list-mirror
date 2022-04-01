Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D209CC433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 16:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbiDAQ1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbiDAQ0i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 12:26:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538F2158791
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 08:56:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92D4812DD5A;
        Fri,  1 Apr 2022 11:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CSZfHq43XJpzReCG5f7g+2CT+Pt2F97opo+0FC
        JBR/M=; b=XWe+JtSrGKjml46qLqst51MA52RM+L2lDJ4NPM/3KhCyNJjZ77Xic2
        6YOgnY7Eepqp+p8B82g60TKTXbGQ91MmbBVP0yr45MSOM/khLsrmgM1TyXIn4AVk
        1HfcHv1IMMghiA1vuG29LpVxlIVh8B5y9isa1bdMwWRRrouhb6b1o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A27A12DD58;
        Fri,  1 Apr 2022 11:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFB6712DD57;
        Fri,  1 Apr 2022 11:56:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 04/14] core.fsyncmethod: batched disk flushes for
 loose-objects
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <9e7ae22fa4a2693fe26659f875dd780080c4cfb2.1648616734.git.gitgitgadget@gmail.com>
        <xmqq4k3f9w9s.fsf@gitster.g>
        <CANQDOdd-G0VHOKWjWQL75jAJ7Az4izB33HKzayqnk-F-nkHj_A@mail.gmail.com>
        <xmqqtube2e1d.fsf@gitster.g>
        <CANQDOdcVnyEo1Om=Odutix1ZT4vbNiZX29_Zo+=PfxnssmUM9g@mail.gmail.com>
Date:   Fri, 01 Apr 2022 08:56:18 -0700
In-Reply-To: <CANQDOdcVnyEo1Om=Odutix1ZT4vbNiZX29_Zo+=PfxnssmUM9g@mail.gmail.com>
        (Neeraj Singh's message of "Thu, 31 Mar 2022 12:18:57 -0700")
Message-ID: <xmqqy20oyezh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4592410E-B1D4-11EC-975D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> ...  Now that I flushed it left I'm
> getting better output where the follow-on paragraph has a "normal"
> text style and interior backtick quoted things are bolded as expected.

I was reasonably but not absolutely sure if that works inside
bulletted list.  Thanks for experimenting it for us ;-)


