Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AF5C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274F1613D1
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhHWQZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:25:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53967 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWQZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 12:25:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EFBBA15787C;
        Mon, 23 Aug 2021 12:25:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WkDR4cIJ6My8kLkE80q9POJKMwZL9gGxM2imv8
        S5EJY=; b=TzMDwe0zo3ezRqFK+41h+IBecwdCM2vlWVGIWs+wjOph0c6uP0HlEZ
        ffvdUbbEtFWIqNxGD8vAFqPUHSUiZlIRYr38agABmSrYY1aq/M1n08IoINHJ4ZBF
        z1ZF9/xqECr8no+xG9xDFgxPNUrEVXPolcQJ3/zV0/1nbAoFkeC9Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8BB515787B;
        Mon, 23 Aug 2021 12:25:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3DE40157879;
        Mon, 23 Aug 2021 12:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Daniel P." <danpltile@gmail.com>, git@vger.kernel.org
Subject: Re: Git is removing . from the last part of user.name
References: <CAL-s8C7makcRT_ufsv4THSrKeDkXfhFoAXSBKSiK5w0anMvZag@mail.gmail.com>
        <YSJuS1OoYsqgpF3j@camp.crustytoothpaste.net>
        <YSKleNynVrWWyyML@coredump.intra.peff.net>
Date:   Mon, 23 Aug 2021 09:25:10 -0700
In-Reply-To: <YSKleNynVrWWyyML@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 22 Aug 2021 15:28:56 -0400")
Message-ID: <xmqqsfz0qgbd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0CA3B42-042E-11EC-AA5F-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On a somewhat lesser note, I'm tempted to say that "." probably was
> never that useful (compared to say, comma, which is the gecos
> separator), and we could probably just drop it from the crud list.

Yeah, the only excuse I can think of using to justify treating "."
any specially can be seen in the contrast between the To: and Cc:
header of this message, where the human-readable part of brian and
daniel must be inside a pair of double-quotes while your name needs
no such quoting.

But we do not remove "crud()" crud from the middle, so that's not
even it (the only crud we remvoe from the middle are newlines and
'<' and '>').



