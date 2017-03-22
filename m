Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D894A20323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbdCVWjF (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:39:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54777 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751355AbdCVWjD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:39:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 296247D35B;
        Wed, 22 Mar 2017 18:39:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ah9mMse2+3VafUj7vPsWmvLSL88=; b=gKxRqQ
        vqvgtry6J61gA4YwatOyomY6u//m9VRiho4/efDfPypx5zlfLWUOIJs4gy8plUzt
        m1fMz8ackU9k+h4ACiLyLXcq3oTjC3L8s37zh9D5je/TkbTdbu/csrakagzopoyU
        m7HZea/UuZd3GADIbW7si9krvgiOSNdiROx0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vs2ov/suHWuja8S2ctdICOce67W8ECIx
        XpTMzOZOIocm2xfTkspgavtUuOCuT4xO7hpl51DgvHvXKipir0OspXjUPlIVkBD2
        m6+LACDFhZdMFyaKoZbfR8HAuMdlC3GyvAHbs8lpnz9FCUnE4dqeDpjgPLuD//wR
        PGwd7Kxv3pQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2306D7D35A;
        Wed, 22 Mar 2017 18:39:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E0FD7D358;
        Wed, 22 Mar 2017 18:39:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
        <20170322200805.23837-1-gitster@pobox.com>
        <20170322200805.23837-4-gitster@pobox.com>
        <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
        <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
        <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
        <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net>
Date:   Wed, 22 Mar 2017 15:38:59 -0700
In-Reply-To: <20170322222230.yqqv6x4gokvb4jbz@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 22 Mar 2017 18:22:30 -0400")
Message-ID: <xmqqlgrxgcn0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5893C65A-0F50-11E7-A497-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I worked up the patch to do that (see below), but I got stumped trying
> to write the commit message. Perhaps that is what the test intended, but
> I don't think tag's --format understands "%G" codes at all.
> So you cannot tell from the output if a tag was valid or not; you have to check
> the exit code separately.

Thanks for digging; that was an unexpected show-stopper to me X-<.

> you cannot tell at all which ones are bogus. Whereas with the current
> behavior, the bogus ones are quietly omitted. Which can also be
> confusing, but I'd think would generally err on the side of caution.

OK.

