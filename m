Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F8920954
	for <e@80x24.org>; Mon,  4 Dec 2017 19:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdLDTmv (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 14:42:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52680 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751788AbdLDTms (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 14:42:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 840A4CD0A2;
        Mon,  4 Dec 2017 14:42:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UzEEnf6ry+G4
        hBv1v628NIPQOAs=; b=c+cQP79TuUuhb3i1eaLILHk4QuhqLR71Y7+WaIDiuNBv
        XyMETDg9oPv0NK4D/3N+wk8h+2saVMNL+E9Nb3WWiJzZLDJv57IkyGZcf26487zd
        hmO5L1atrbtT1MiFRd1SsS2HgpN+zkkN0K3HiKc9IuoIbniIOIBQJmw3Al+dH8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vpqgXN
        oZPSdfC/yLcpJYQTxk4MJ3s5baWFcsoWc4qByqOLjA+uvzTEaWoGDc4pYfRYCz7z
        +/7ICpzoRaCm/YWfq6lMXW2NXIPR+1Ah5JRZItXEKyN7Eyp8a6jdLluqASEsJgg+
        bDTeL/KfxUVku0iMICApE+M1qoZzsY3FxepS8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B851CD0A1;
        Mon,  4 Dec 2017 14:42:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6217CD0A0;
        Mon,  4 Dec 2017 14:42:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2] Makefile: replace perl/Makefile.PL with simple make rules
References: <20171129195430.10069-1-avarab@gmail.com>
        <20171203115941.16674-1-avarab@gmail.com>
        <xmqqzi6ympi9.fsf@gitster.mtv.corp.google.com>
        <CACBZZX6mEzrTdD=B7gAeLSufPR-ZEj8wO8kXsJmrJFtSbT35yQ@mail.gmail.com>
Date:   Mon, 04 Dec 2017 11:42:45 -0800
In-Reply-To: <CACBZZX6mEzrTdD=B7gAeLSufPR-ZEj8wO8kXsJmrJFtSbT35yQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 4 Dec
 2017 19:08:04
        +0100")
Message-ID: <xmqq4lp6mg96.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4DB94FF2-D92B-11E7-9660-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Dec 4, 2017 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> I did this immediately after applying; please double check.
>>
>> Thanks.
>
> Thanks. Looks good to me. I'll incorporate that info future
> submissions if there's more stuff to fix, but for now if you could
> queue it like that that would be great.

Well the thing is that I cannot queue this and Dan's at the same
time, while both of these topics are expected to be in flux.  For
today's pushout, I tentatively kicked out Dan's relative path series
and queued this one to see how well it works with the rest of the
system, after giving this patch another round of reading.

It seemed that Dan was happy with (an earlier draft of?) this
build procedure simplification patch, so hopefully we can solidify
this one reasonably quickly and ask the relative path series to be
rebuilt on top of it?

Thanks.
