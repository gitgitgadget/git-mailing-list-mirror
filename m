Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC4A1FA14
	for <e@80x24.org>; Fri, 14 Apr 2017 11:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbdDNLMT (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 07:12:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51762 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751305AbdDNLMS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 07:12:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 868BF6E661;
        Fri, 14 Apr 2017 07:12:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p9UWMdpOZd2khdnc8XpzaqVThRU=; b=iTIZib
        U6HvCNEAIueTFUT0ykZ8bJlBievxelXfpuRFK0zNCkSEHNEZ1vLNt2AV5x3C9uyw
        KlaeQnVS3F4Xxjvec0rnDblvErJHnwsl/tiRQ8tXTBdioRqyhY3WnH47767/itm3
        YpFIf6qppCzknShSYgxxWmz3aQgh1qLAfmUEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mpo42FkFgw41IxOpr1SohAuEg5cdeoKg
        rN74t8wdgChk4oJEOjqvs3t1cQzf0lN+OaWmZRHoJk+fhFF5XdSv90T9KSSqGXWn
        bEY1KMxw5SIMUdesQHJAVmIMPodL7U7SaQYMeZTx6Avc8GCcfkqrJlpBjiRiGaoj
        YgKt1jlxd2o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F1866E65F;
        Fri, 14 Apr 2017 07:12:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE5796E65E;
        Fri, 14 Apr 2017 07:12:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Tom G. Christensen" <tgc@jupiterrise.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
        <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
        <20170406092122.titsfyxpucj6xoe4@sigill.intra.peff.net>
        <ef64656b-12d7-a041-e1b9-ce83f8cbd2fc@jupiterrise.com>
        <20170407045427.rqrqdt5mxzudonzo@sigill.intra.peff.net>
Date:   Fri, 14 Apr 2017 04:12:09 -0700
In-Reply-To: <20170407045427.rqrqdt5mxzudonzo@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 7 Apr 2017 00:54:27 -0400")
Message-ID: <xmqq4lxrnsza.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3490E8D6-2103-11E7-853C-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think I'm leaning towards the very first patch I posted, that assumes
> 7.11.0 and later. And then hold off on the others for a few years. In
> terms of "number of ifdefs removed" we could go further, but I think it
> was the first patch that removes a lot of the really questionable bits
> (like silently ignoring security-related features).

I do not have problems with setting cut-off at 7.11.0; I do not
foresee anybody who actively maintains a port for a platform whose
cURL is older than that version would step up ;-)

Thanks.
