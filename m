Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79B81F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 11:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbfJVLe2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 07:34:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57816 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388698AbfJVLe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 07:34:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2649D2E757;
        Tue, 22 Oct 2019 07:34:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lNEosA2Fuz6BkfjJft9AydmQS+0=; b=KCTTM1
        E0E7p7WM3SRV1lPU2Q401gHQ4wBy4uKHyx3LLxeHxpWaZqd4iO+nqtCT8dj/g1JZ
        KlPclP3Co8P4VqUOJP8KE8rApmyxRVhhBwA12A2ZBlAnzR0AKgm+ku3agbH87w0b
        60oR6jpK+nt8zja+YU5F3yik8h5PkuUWuiE70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h5CpAOQQ8gvI/UU+/ilHZMoBtGWALGF9
        2A1YuBh+bSXUKgZ9x2d41Zs83EgPXVyD7mjLlFDwZMEfwruXlngERVgdE863qEu9
        xaehxRb2w/HluixCpGBbFW1DhWkyrns9qu/hzuw/JRkREfkzPS4ltrhqCpu5Dtq3
        Ch8732gtirY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E9EA2E755;
        Tue, 22 Oct 2019 07:34:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 827DA2E754;
        Tue, 22 Oct 2019 07:34:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [RFC PATCH 1/7] Makefile: alphabetically sort += lists
References: <cover.1571246693.git.liu.denton@gmail.com>
        <02a16f9bdf740841d9a4be765e72b9fa5ae5d75c.1571246693.git.liu.denton@gmail.com>
        <xmqqimon6yar.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910212043200.46@tvgsbejvaqbjf.bet>
        <xmqqblu9lw00.fsf@gitster-ct.c.googlers.com>
        <20191021195413.GB3959@sigill.intra.peff.net>
Date:   Tue, 22 Oct 2019 20:34:24 +0900
In-Reply-To: <20191021195413.GB3959@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 21 Oct 2019 15:54:13 -0400")
Message-ID: <xmqq7e4xko8v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E68E3BE6-F4BF-11E9-92BC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> ...
>> I agree with you that it did correctly sort them in ASCII order.
>
> What's the purpose of sorting them, though? I thought it was less for
> aesthetics and more to to keep lines deterministic (to avoid two
> branches adding the same line in different places, thus causing
> weirdness when the two are merged). In that case, I think we care less
> about the exact order and more that anybody can easily reproduce the
> same sort (by running "10:!sort" or whatever you weird emacs-types would
> type).

In the ideal world, "sort" would have a handy option we can tell it
to reshuffle the ASCII table in such a way that all punctuations
come before alphanumeric, making sure "/" and "." are the first two
letters in the alphabet, and everybody can use it to sort the lines
reproducibly and also readably.  But I do not know of such a widely
used implementation of "sort", so...

If we had known better, we would have used such a custom sort order
to sort the index entries, making sure that slash sorts before any
other byte ;-)
