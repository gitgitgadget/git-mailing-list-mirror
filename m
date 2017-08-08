Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A1320899
	for <e@80x24.org>; Tue,  8 Aug 2017 16:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbdHHQrY (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 12:47:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50576 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752059AbdHHQrX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 12:47:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED6629A4B0;
        Tue,  8 Aug 2017 12:47:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gG0uqttOW+dCV4FchhHgigPtXv0=; b=qTumnG
        VIAwgdkomyQ2zWITr8Nqdc3rY98B3ECF190sVpFAIpPJNo7EQ3a1HoX3uBS/wfBC
        wIWZ3XqP5/a0rg8cX7dK7ygpmo4Hv6jh9xWX3IWdy+jl+aTymzRsJ7VX9Ljn3E8X
        xPJJfaZ+G2IcdR671oWcAfqQHoQUzaPw6vpBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i9BuJgIMyIll8cGoRRcfZwHmIQQuLoal
        T2uCsJeD6k4jcQb89VVkfgFUDE5tohABcUsQKVpbQ9IgGzM10tZjtyd7ASribdP9
        ZnMUSVvUIe6BAVfanOdJlBm3Rf72w/nVkqNw6hoq9sKQY3V+l28Z/yzTyqNgiqt9
        cf3omATAZ8c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E55779A4AF;
        Tue,  8 Aug 2017 12:47:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 382A39A4AB;
        Tue,  8 Aug 2017 12:47:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Can the '--set-upstream' option of branch be removed ?
References: <xmqq1sp2q1cc.fsf@gitster.mtv.corp.google.com>
        <20170807143938.5127-1-kaarticsivaraam91196@gmail.com>
        <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com>
        <1502197230.2071.3.camel@gmail.com>
Date:   Tue, 08 Aug 2017 09:47:13 -0700
In-Reply-To: <1502197230.2071.3.camel@gmail.com> (Kaartic Sivaraam's message
        of "Tue, 08 Aug 2017 18:30:30 +0530")
Message-ID: <xmqqo9rqc8ha.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BA173E6-7C59-11E7-BC55-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Just to be sure, you mean "die() with a good message" when you say
> "fail these requests, telling them that the former option no longer is
> supported."

Yes.

> It's pretty surprising it takes almost a decade to *stop accepting* a
> bad option though many users are confused by it.
>
> "It's easier to do things than to undo them!"

Yes, that is why we try to be extra cautious when adding new things.
