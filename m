Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92EB2036D
	for <e@80x24.org>; Sat, 25 Nov 2017 05:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbdKYFBJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 00:01:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59463 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751091AbdKYFBH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 00:01:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA336BBCBA;
        Sat, 25 Nov 2017 00:01:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rCX8ktsud4/ZrwgOzxq1IkQIAo8=; b=YSTJtk
        6CR2uyBdmpVqInWkjgAvgmftAr9XoQ/1xqMtRRUNC4UHn0/b90dHx1MfyLuX1c4H
        ObXaRPk+PdY7j/ZFFxn7hPEyPDgjIa9oJ88JMwmNNmT36ZQ+dcdOO59uzQfwgROK
        SMasaWmWy+wH0FtSw2XtrVOQ0IGMDlm2cqV3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XuHLZLjnbd1hxiLXfLE/zoYtjNJMVsGK
        /LHvd5cbV9hUER0Rl1ibPdoV4cF4tJJIL2ntila6LXyIOJEWrA0Vx3J0/0NBOhEm
        VqHwmyLEO0sy+5nY4pTeuu9HsOldiskuKFpmqMEQFSJK+cFDA8W9dO2PQ21XBQXa
        HV2ZfuBthNU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A31F0BBCB9;
        Sat, 25 Nov 2017 00:01:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2AFF6BBCB8;
        Sat, 25 Nov 2017 00:01:05 -0500 (EST)
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
Date:   Sat, 25 Nov 2017 14:01:03 +0900
In-Reply-To: <20171124235330.15157-1-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Sat, 25 Nov 2017 00:53:25 +0100")
Message-ID: <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A422E244-D19D-11E7-9532-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

> Neither Git nor the user are in need of this (visual) aid anymore, but
> we must offer a transition period.
>
> Also, fix a typo: "abbbreviated" ---> "abbreviated".
>
> Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
> ---
> v2: rename patch series & focus on removal of ellipses
> v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
> v4: improve env var handling (rename, helper func to query, docu)

Thanks for sticking with this topic---very much appreciated, as we
saw many newcomers get tired of doing repeated polishing and abandon
their topic in the past.  I have to go offline now, but will comment
later when I come back.

