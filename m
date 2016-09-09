Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8BD1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 17:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbcIIRtF (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 13:49:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50213 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751438AbcIIRtE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 13:49:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB04A3AA41;
        Fri,  9 Sep 2016 13:49:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Q24UxXFMVM1uUyxN9priKI1k2Y=; b=p7Yoqm
        qe43m4OqPVlLLQ8kOBJeJpM1iIS4vViR4TqCutTuQltwOEeL9oIlKkceNzgqpdgV
        KRiPiOhown8fgmYvUDsT+1bsiA9GcUCYz5qkn/5sH6hJsiL45XBynCdZPcLD8UIt
        e9ZXQDDiq2l8zAMcz470DIA4497v3w1Tkol70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jVeMbfM4XUXwcuTdpVpj24wxQNUdNRxo
        9rs62fObd3gwx2BUy4dK2KdFKTTCi/3EmAmXxJz58aDr9bTQDmH78ST0Eue5yEkw
        s2KNcy/99w7Ezi4AL84r6j6QZALFo6vvmoAvQxmB9Xwl9MtprxR74cBvVeB0A0Lw
        pv20jfi0h68=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B51833AA40;
        Fri,  9 Sep 2016 13:49:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 442C03AA3E;
        Fri,  9 Sep 2016 13:49:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] Use the newly-introduced regexec_buf() function
References: <cover.1473319844.git.johannes.schindelin@gmx.de>
        <cover.1473321437.git.johannes.schindelin@gmx.de>
        <d0537819a3676fda6928e7ad3282aa71643f0755.1473321437.git.johannes.schindelin@gmx.de>
        <xmqq1t0ujp2f.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609091151510.129229@virtualbox>
Date:   Fri, 09 Sep 2016 10:49:01 -0700
In-Reply-To: <alpine.DEB.2.20.1609091151510.129229@virtualbox> (Johannes
        Schindelin's message of "Fri, 9 Sep 2016 11:52:50 +0200 (CEST)")
Message-ID: <xmqqfup9c6b6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B23D9EB2-76B5-11E6-8A01-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Also I agree with Peff that a test with an embedded NUL would be a
>> good thing.
>
> This is something I will leave to somebody else, as it was not my
> intention to fix this and I *really* have more pressing things to do right
> now... Sorry!

As I said a few minutes ago, I think we can stop _before_ worrying
about an embedded NUL, which is something we haven't handled before
anyway so it is a new feature that can be built later outside the
scope of this series.
