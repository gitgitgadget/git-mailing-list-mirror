Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D064F20954
	for <e@80x24.org>; Sun, 26 Nov 2017 03:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdKZDZF (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 22:25:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56509 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751902AbdKZDZF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 22:25:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A31CAE22A;
        Sat, 25 Nov 2017 22:25:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ToXbeAfWJamzgB+r4/o3BaJJ9UA=; b=knYoJC
        mpgH/iCtpKbZzarU07a319HwihXWjsBLCcjJmCNP9WB7rYYMY2uTjutEwuvAtGAG
        UDYUmk07YNHYIFbN+d9d07cofRSuD6fnk3gD3y3IhXM8U+wgUzJK7T7e+EeQ5HMu
        oj2qYQ7YeJL26HYu/WNKbYMcvQjuJb/W9+6LE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xmq99pPEiUvykwXU1BuZ1+/5xANfUtPl
        Gos1zUX9kNyLsfQ/7h9q1YTR22engqioLSjFci08EJcyZOpyH39aZoHK5stvenh7
        L2wnuj0fnvXUPQDjm6KtJ+E97jw70Ckjokwpp5J3BEh1jxel7MQb7ek5mCaohSEK
        LoY74jPeHdg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50E64AE228;
        Sat, 25 Nov 2017 22:25:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76843AE226;
        Sat, 25 Nov 2017 22:25:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v4 1/6] diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
References: <20171119184113.16630-1-bedhanger@gmx.de>
        <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119184113.16630-5-bedhanger@gmx.de>
        <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com>
        <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley>
        <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
        <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley>
        <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com>
        <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
        <20171124235330.15157-1-bedhanger@gmx.de>
        <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com>
        <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 26 Nov 2017 12:25:01 +0900
In-Reply-To: <xmqqd145k9td.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 26 Nov 2017 12:17:34 +0900")
Message-ID: <xmqq1sklk9gy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 645AEC12-D259-11E7-AA18-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  - 5/6: What we see in [v4 1/6] (except for introduction of the
>         helper, which already happened in an earlier step).  Move
>         the promise of covering this new output format with a follow
>         up series to the proposed log message of this step from [v4
>         6/6].
>
>  - 6/6: Realize the promise made in 5/6.
> ...
> For rererence, here is what I just whipped up that would come in
> between the steps 4/6 and 5/6 in the above outline (i.e. split from
> 6/6 to be placed before 5/6 happens).

Just to be sure, I wrote this on top of [v4 1-6/6], so you'd see
that its preimage already knows about GIT_PRINT_SHA1_ELLIPSIS=yes.
In a real reroll of the series that follow the above reorganized
structure, of course that would not appear as "-" line in the patch
;-)

Thanks.
