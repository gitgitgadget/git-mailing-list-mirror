Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE461F404
	for <e@80x24.org>; Mon, 22 Jan 2018 23:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbeAVXXD (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 18:23:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59848 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeAVXXC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 18:23:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 625F4D8838;
        Mon, 22 Jan 2018 18:23:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qLOkVh8JBUc0MjnK0qZY6Jq5s+Q=; b=QEL/LM
        kMLnfJQaJmk5U3mcoimfsaRoi6tJV1QUSpFI9XhrwcL9RsI9M0jAKKKP3U7jjfeg
        UbGsC+JwpFbwU4UhRTK+tjsW608cETStTCw0W6xPfI3XdfdbtYFvR+GvWvQY3xNY
        /P2UP5Y7spQXrnoLb0j6pzDf0v26GJljTw7mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xQsbEHcJWftTVgaHhio93IcLLabcwY8x
        /Sv9UbtkGEo7wKeV14BUqOz6pjvB5NIpv/bzDBOVHfk1jiFpf4kgXatEKxj+wKlo
        vFjAApfo09kItKh6pUJpBxmLxw2ZqDlnT5r1znLFfdTfWutOUDPMI5OHiPtqh6+V
        fF4fn3KRji4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A3AFD8837;
        Mon, 22 Jan 2018 18:23:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D271BD8836;
        Mon, 22 Jan 2018 18:23:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     felipe@felipegasper.com, git@vger.kernel.org
Subject: Re: [PATCH] Fix comma splices
References: <5a656638.LthG4qGgtrvPcSKz%felipe@felipegasper.com>
        <20180122230819.GB21604@sigill.intra.peff.net>
Date:   Mon, 22 Jan 2018 15:23:00 -0800
In-Reply-To: <20180122230819.GB21604@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 22 Jan 2018 18:08:20 -0500")
Message-ID: <xmqq7es9jx63.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30B5FA4C-FFCB-11E7-BF85-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> (To be pedantic, these aren't comma splices. A comma splice joins two
> independent clauses with a comma and _without_ a conjunction).

Thanks for clearing up the "Huh?" I felt earlier when I threw the
patch to "to look at later" bin after finding updated text for most
of them read not much better than the original, at least to me.

So I am OK to take this patch (or an updated version), but the log
message needs updating, I guess.

>   2. Is this Q_() here actually helping? It triggers on "ours + theirs"
>   ...
>      In fact, I don't think the singular case here can _ever_ trigger,

Exactly.

