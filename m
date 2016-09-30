Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCE34207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 04:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932836AbcI3Efo (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 00:35:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50767 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932469AbcI3Efm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 00:35:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFB3B4299B;
        Fri, 30 Sep 2016 00:35:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9NGxeZDZUfFZLEJ4cR0FDTcF9cQ=; b=IiJX/7
        fXuvhJHzb8tt8TgSlkuFKQALa8zX6O9bq3hHsWVkn4tsn6CR9StUdM2FPako+Swh
        0sAu37GFpAc8tU96Ka1usEcEugr231sWSSkMn7qOKnB8VCaVz/b5L+iVF6LSjBMx
        WKSI2cLVU0HGtMsqqzM6IF8CVJI6cnL1vHou8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M1dW1/HbzotNtUcyX8AyHKVsjKH9RkDp
        cFPg3lfJK+1G3N0KrqgPX0aZlWGroUJ0VZli6Us7rrAIyzub80wXtO1dBmDU9V69
        Mvnypf2U7hPr7TIWGUHtjBDfDlSyih7p+413RtEqjW4qoksgiXV83zr8ncCFR4TC
        nzcPK6LaYrQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A65F74299A;
        Fri, 30 Sep 2016 00:35:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D02342999;
        Fri, 30 Sep 2016 00:35:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-5-gitster@pobox.com>
        <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
        <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
        <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
        <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
        <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
        <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
        <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
        <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
        <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
        <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
        <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
        <xmqqtwcyavou.fsf@gitster.mtv.corp.google.com>
        <xmqqoa36auyx.fsf@gitster.mtv.corp.google.com>
        <xmqqeg42au5w.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 29 Sep 2016 21:35:38 -0700
In-Reply-To: <xmqqeg42au5w.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 29 Sep 2016 21:27:55 -0700")
Message-ID: <xmqqa8eqatt1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 574289BA-86C7-11E6-8CCA-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> There still are breakages seen in t5510 and t5526 that are about the
>> verbose output of "git fetch".  I'll stop digging at this point
>> tonight, and welcome others who look into it ;-)
>
> OK, just before I leave the keyboard for the night...
>
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Thu, 29 Sep 2016 21:19:20 -0700
> Subject: [PATCH] abbrev: adjust to the new world order

To those who are following from sidelines, this builds on Linus's
third iteration patch (which is based on his first patch), applied
on Peff's "give disambiguation help when giving an ambiguity error"
series.  I didn't merge the work-in-progress going back and forth
between Linus and I tonight to any of the integration branches, but
it is available as lt/abbrev-auto-2 branch of the "broken down"
repository, i.e.

    git://github.com/gitster/git.git lt/abbrev-auto-2

