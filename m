Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D922023D
	for <e@80x24.org>; Wed,  1 Mar 2017 20:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbdCAUFD (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 15:05:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64221 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751106AbdCAUEd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 15:04:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39E147522E;
        Wed,  1 Mar 2017 14:42:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/a8ooZjnyYHMoYAyilSc6nDbzEA=; b=yLQKNJ
        D3iFr7H2a3Ua/6Zd7PWMk5U0PwnYTSxeJ9t7nRUQxJa2zoO+wyZ/NReEa1l5a789
        QOug3lpBWTm/pXaaMjA1EdJj9kcPEJ/KdBHnNaxkR2RH69apv6s/E7l2YRqPW2n8
        PT+IGnw2McAFrjlPMo3FYmhlxGoWqrVCYk510=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nPOQ4dvJosJutJv2sBGbj6P2UNWgW0do
        4bpo5I3DtFYl9opB4uYS6UfhIIspyi7Vvu8X41mQdF88TYrzGp9DU0t+Nb7hFfvl
        /8PLZ6zzhRuuTJ6KYJNWSkF5e5jjcFg5mv/7OBTVII0+z+VeGTYdArj7xg8MyUsv
        FzdBEOVgsGo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3033E7522D;
        Wed,  1 Mar 2017 14:42:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8422B7522C;
        Wed,  1 Mar 2017 14:41:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
        <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
        <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
Date:   Wed, 01 Mar 2017 11:41:58 -0800
In-Reply-To: <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 1 Mar 2017 10:49:55 -0800")
Message-ID: <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22ABF1F6-FEB7-11E6-97B2-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That said, I think that it would be lovely to just default to
> USE_SHA1DC and just put the whole attack behind us. Yes, it's slower.
> No, it doesn't really seem to matter that much in practice.

Yes.  It would be a very good goal.

