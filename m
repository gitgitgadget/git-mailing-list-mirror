Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC161FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 18:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbcLASUy (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 13:20:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52144 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751301AbcLASUx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 13:20:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22D7653DF5;
        Thu,  1 Dec 2016 13:20:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PvrrPbUL2d1hVL5ZcycGtBLZOtw=; b=LBgsRN
        EgmJXNBr5gm20Zsqj45xsViU//1gOKnVjHkQThMrULsdxoL6y2kSNwJFtguKohiD
        cFN/O9I2CqBy5T5mVnHFeYznM/rSEkgY/wzzu07vrEnXki8r9qEYoQXvtsrPtV6S
        JAGG2F+CDX2DV1sFVMsmgM8cvBaajSByXxuwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YcycQrbWrTP/rIIASlCFxnJbr2FKPW4E
        h2wyqTOc8Jppa7TcjLpYISGyUfLqL+fI15Rz8ADJvt8o+QxwJx51HwwPzRxl0Qqq
        Hu+/y+BwPZai/RGIdsgi68wZw2vj3x4rqeDt4UhxK1LvI2rsDy3HjwF7ewITSgV0
        qA7mSEyOnjI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A25053DF0;
        Thu,  1 Dec 2016 13:20:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8ADA353DEF;
        Thu,  1 Dec 2016 13:20:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
References: <4ddad7ea-5ac8-20b2-da9e-5843c486878a@ramsayjones.plus.com>
        <alpine.DEB.2.20.1611301204020.117539@virtualbox>
        <29abc89b-9ca5-930f-8e90-ca446ac2b96a@ramsayjones.plus.com>
        <xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com>
        <20161130212510.ihcmvig7jq44p3nx@sigill.intra.peff.net>
        <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com>
        <20161130231848.v5ge6otytim2t6d2@sigill.intra.peff.net>
        <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com>
        <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com>
        <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net>
Date:   Thu, 01 Dec 2016 10:20:50 -0800
In-Reply-To: <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 30 Nov 2016 23:02:34 -0500")
Message-ID: <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3F4F7D8-B7F2-11E6-AFA7-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't have a preference on which direction we go, but yes, right now
> we are in an awkward middle ground. We should do one of:
>
>   1. Drop -Wno-format-zero-length from DEVELOPER_CFLAGS and make sure
>      future patches to do not violate it.
>
>   2. Declare warning("") as OK.
>
> I still think the warning is silly, but (1) has value in that it
> produces the least surprise and annoyance to various people building
> Git.

What is most awkward is that "make", with no customization out of
box, suggests to use -Wall in CFLAGS and triggers the misguided
warning, and DEVELOPER_CFLAGS, partly because it adds -Werror to
turn warnings (including this misguided one) into errors, disables
it with -Wno-format-zero-length.  As a result:

 - Casual builders that follow our suggestion get warnings.

 - Developers do not notice their new code may make the "casual
   builder" experience worse.

That is totally backwards.  That is probably what you meant by "the
least surprise and annoyance"?

I also still think that any_printf_like_function("%s", "") looks
silly.  I know that we've already started moving in that direction
and we stopped at a place we do not want to be in, but perhaps it
was a mistake to move in that direction in the first place.  I am
tempted to say we should do something like the attached, but that
may not fly well, as I suspect that -Wno-format-zero-length may be a
lot more exotic than the -Wall compiler option.  An obvious second
best option would be to drop -Wall from the "everybody" CFLAGS and
move it to DEVELOPER_CFLAGS instead.

diff --git a/Makefile b/Makefile
index a379738db2..137c10e257 100644
--- a/Makefile
+++ b/Makefile
@@ -391,10 +391,9 @@ GIT-VERSION-FILE: FORCE
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O2 -Wall -Wno-format-zero-length
 DEVELOPER_CFLAGS = -Werror \
 	-Wdeclaration-after-statement \
-	-Wno-format-zero-length \
 	-Wold-style-definition \
 	-Woverflow \
 	-Wpointer-arith \


