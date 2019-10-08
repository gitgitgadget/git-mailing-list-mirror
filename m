Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DB691F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 04:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfJHEal (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 00:30:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51110 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfJHEal (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 00:30:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 601ED92115;
        Tue,  8 Oct 2019 00:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QEgXcw8y535j
        ausretyYwUDXer8=; b=IpIlzAFg5BsLBRh/gUCeIy3H2z0ZE3HEKiBi47ZRHWNE
        6COx1zhFQHzRRG05bD4utQtSwfBVDDJR9LeQJKCY73mVZowOdAVeM1XUMMlSgn68
        mQgYUxW+GVQGfXcj9JAcSo2ZHJLZCWVmd7p+BqPpKwdP6iCyapkoAQq5NtwYrtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bk3nNA
        1iW0ahUv6/WQEey16ks1cuGkbQ9J7hOC/Av+K42Rqs4uULjhE+pckgmtKDZ2upMp
        logEBNAImCysNGUtZNRWyQaGfUHRZkMp/+OGTXHFKST6e1RNHpnqj4ExhSJISl4e
        O2a0+NUIfCFsaqD3f2qO09HbQ0Ni6c0BpL7RM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5948E92114;
        Tue,  8 Oct 2019 00:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 822F992113;
        Tue,  8 Oct 2019 00:30:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
        <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
        <20190921121104.GA6787@szeder.dev>
        <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
        <20191007172951.GC11529@szeder.dev>
Date:   Tue, 08 Oct 2019 13:30:34 +0900
In-Reply-To: <20191007172951.GC11529@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Mon, 7 Oct 2019 19:29:51 +0200")
Message-ID: <xmqqk19fn9jp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5FE7DAD4-E984-11E9-8B5F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> 		func(PROGRESS | REGRESS);
>> 		func(PROGRESS + REGRESS);
>> 		func(PROGRESS * 3);
>> 	}
>>=20
>> how caller came about to give 3?
>
> No, they tend to show (PROGRESS | REGRESS), at least both gdb and lldb
> do.

OK.

>  If the enum has only constants with power-of-two values, then that
> is the right way to write it, and the other two are asking for trouble

If the programmer and the debugger knows the constants are used to
represent bits that can be or'ed together, what you say is correct,
but that is entirely irrelevant.

What I was worried about is that the constants that are used to
represent something that are *NOT* set of bits (hence "PROGRESS * 3"
may be perfectly a reasonable thing for such an application) may be
mistaken by an overly clever debugger and "3" may end up getting
shown as "PROGRESS | REGRESS".  When there are only two constants
(PROGRESS=3D1 and REGRESS=3D2), we humans nor debuggers can tell if that
is to represent two bits that can be or'ed together, or it is an
enumeration.

Until we gain the third constant, that is, at which time the third
one may likely be 3 (if enumeration) or 4 (if bits).

