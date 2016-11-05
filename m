Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56F02022A
	for <e@80x24.org>; Sat,  5 Nov 2016 05:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbcKEFAV (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 01:00:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65056 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752523AbcKEFAU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 01:00:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E1B847193;
        Sat,  5 Nov 2016 01:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bsxRyvz8n37zrAP+zGRD/XyMao0=; b=XDJfRS
        XGCzglx/4yajnulMpdVDdjr31cN4hc2aFbaD8gK/s/M1ol9m0FfVXzdCvsjXSC67
        KpHG4A0JoIqJwwNdlIEcR0QSCx1RrZAIRTq3lEI9Tv86lh0BU6ahR89GN2eW7wCE
        D42XhNgksBDF5NUl2O30792tmqM36mxp/52D0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gbEj3qxxK9BV1TJmVZYeEJKq9lnm1PX5
        kimkcKbmHd2LxvTbUybWmq9m7tB0Nf8vHsNtK+cZl2OvwjgTk8i9Z/NaBsSRMpp7
        snpJ9p/YPpAhWBCKInBQqNgVCDHdUm53GiRAH25WkcKm2R9BZ3hlhv4BZKCSev1W
        loWaH4L2je4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86E1447191;
        Sat,  5 Nov 2016 01:00:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F3F647190;
        Sat,  5 Nov 2016 01:00:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Regarding "git log" on "git series" metadata
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
        <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net>
        <xmqq60o2edy5.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 04 Nov 2016 22:00:17 -0700
In-Reply-To: <xmqq60o2edy5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 04 Nov 2016 21:41:06 -0700")
Message-ID: <xmqqwpgicyhq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFA67DF4-A314-11E6-B4BB-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I think the main complication is that the reachability rules are used
>> during object transfer.

One should not type after spending 20+ waking hours on plane and
airport.  I missed it when I wrote my first response, but yes, the
reachability that originates from inside a tree object indeed is a
problem, as we do not dig into trees while doing the want/have/ack
exhange.

