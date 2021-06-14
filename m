Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17076C48BDF
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 02:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EFE6134F
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 02:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhFNC6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 22:58:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63049 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhFNC6K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 22:58:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48E92BD9E5;
        Sun, 13 Jun 2021 22:56:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CsnvmjOYit/VNH0cqxUD8noxhcNzaYuXTDasJe
        B5yvE=; b=A4Rq79dbkDFFIpE9TXP6EDcym+gsCXISGrBgwXGsqftHF96aBvQq+H
        OH9hS4W3GkdemOrguIa7jIWaGEYO9Nc5qTnKa7hLqvLSrwsbx02BL2aaELUG1ujW
        IyUcKee9yIcOxgaDR28YGYkHdNySZvudX9LmFfOC02h90ysqj2Bp4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28781BD9E3;
        Sun, 13 Jun 2021 22:56:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20E07BD9E2;
        Sun, 13 Jun 2021 22:56:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
References: <20210612042755.28342-1-congdanhqx@gmail.com>
        <20210612042755.28342-2-congdanhqx@gmail.com>
        <87bl8928q9.fsf@evledraar.gmail.com>
        <3ab4f29e-987a-c7de-0cca-a64c3bf4be47@gmail.com>
        <CAPig+cRFjBXpm_WwSGBYu75z8TabCDZodYi=wKgTamB1a3aGmg@mail.gmail.com>
Date:   Mon, 14 Jun 2021 11:56:05 +0900
In-Reply-To: <CAPig+cRFjBXpm_WwSGBYu75z8TabCDZodYi=wKgTamB1a3aGmg@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 13 Jun 2021 19:43:34 -0400")
Message-ID: <xmqqy2bdyx16.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 102689F6-CCBC-11EB-A1AD-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> ... However, the article does seem to say that such idioms and care may
> still be warranted. In particular, the epilog gives an example which
> is still relevant on macOS today. ...
>
> At any rate, for those of us who are old-timers, the `"x$foo"` idiom
> is habit and only costs a couple extra characters, so I for one have
> no problem with its presence in the proposed patch.

Yes.  I think it is prudent to use the x-prefix idiom, especially
for the case cited upthread like comparing $1 with an exclamation
mark '!'.

