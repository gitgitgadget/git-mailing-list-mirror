Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0101C20281
	for <e@80x24.org>; Sun,  1 Oct 2017 09:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751012AbdJAJIm (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 05:08:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61560 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750983AbdJAJIl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 05:08:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81DC1969ED;
        Sun,  1 Oct 2017 05:08:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BviDPQ818aZc6jUu9peM8N5ia5g=; b=QmeLk+
        m3x8cMwKSc+hUJqWs8tX8TlylnE+TCt469/oQSwJdlWO8HD139aEbd9fHxLfnDuK
        RlzGXeNZm60FWDRWSMGU55fNqXoEjQX8zQvJLNZxjHCq7OGPB8yJf9AVHcOGoHD9
        LAv+8qwVAFIrdH/30GqBQOsVYFw7c72pJUbpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QhGyzRSbH15FkciqOlekuHyDnc5UmQ9R
        kRJeB+aePaZ+N3UzIBthm4YtnCiUOK2/ajdNPWSyMQJU9yxQZmaez6WfIxnxBuo5
        q9v2eKECF8LqcpRO2kp7UhS8Ku+9Jg8jsKA467MlW8GBnGV80aQskoy858cqveiy
        7mgqbLLGXms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65D03969EC;
        Sun,  1 Oct 2017 05:08:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83D81969E9;
        Sun,  1 Oct 2017 05:08:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] ref-filter.c: use trailer_opts to format trailers
References: <20170930062238.87077-1-me@ttaylorr.com>
        <20170930062238.87077-5-me@ttaylorr.com>
        <20170930072143.h4mbd5c4hskvcrl3@sigill.intra.peff.net>
Date:   Sun, 01 Oct 2017 18:08:39 +0900
In-Reply-To: <20170930072143.h4mbd5c4hskvcrl3@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 30 Sep 2017 03:21:43 -0400")
Message-ID: <xmqq7ewfutew.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DE7B6C2-A688-11E7-A614-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This patch didn't apply for me on top of the others. I get:
>
>   Applying: ref-filter.c: use trailer_opts to format trailers
>   error: patch failed: ref-filter.c:178
>   error: ref-filter.c: patch does not apply
>   Patch failed at 0004 ref-filter.c: use trailer_opts to format trailers
>
> And then with "am -3":
>
>   Applying: ref-filter.c: use trailer_opts to format trailers
>   error: sha1 information is lacking or useless (ref-filter.c).
>   error: could not build fake ancestor
>   Patch failed at 0004 ref-filter.c: use trailer_opts to format trailers
>
> Did it get corrupted in transit, or did you hand-edit it?

And the corresponding patch in v3 seems to have the same issue.
