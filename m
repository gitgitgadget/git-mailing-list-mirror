Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54836C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D6C2313E
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgLJAtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:49:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54677 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgLJAsv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:48:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39517102AA9;
        Wed,  9 Dec 2020 19:48:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HpJtTNL6osaAqjKqu3HHLh5iCCI=; b=OCa9XX
        1+MBYbKgD3RqN4B4XCNZzw9sw3u1B/Pip4Yt9Pj3hYRYGkU3HLLmErpkMzFLQA3R
        cnw9oGl3zRjeMX4qzv9+Wk4qWWmYVKFB96W5BwB9Kmel8WB2y3tEtoz/hJtMWydB
        8veTLfDmGKoSzpZa516ek7c0IS3jDj9gEXzqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PhuA3+JJQ14cWxs9tI9mx6vRwAl6adcE
        XLh0ePPhSXBcs1o41xqm3AOXDKpuFEKmh9ED/KmwnYr7KLki8cTCZOKbVcHYJJLR
        8duMz/+Fdg9s9QN6CYlf588QiOXgG9VbayYRr7magDdu+y6lfD/T2KuX86u8HNC7
        qbKFEmidfP8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32A82102AA8;
        Wed,  9 Dec 2020 19:48:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 81E1E102AA6;
        Wed,  9 Dec 2020 19:48:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Julien Richard via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Julien Richard <jairbubbles@hotmail.com>,
        Julien Richard <julien.richard@ubisoft.com>
Subject: Re: [PATCH] doc: 'T' status code for git status
References: <pull.930.git.git.1607501616914.gitgitgadget@gmail.com>
        <X9ELRf7s9sBcs9CD@coredump.intra.peff.net>
        <xmqqsg8e20b8.fsf@gitster.c.googlers.com>
        <X9FCUseRteZ1n7ec@coredump.intra.peff.net>
Date:   Wed, 09 Dec 2020 16:47:59 -0800
In-Reply-To: <X9FCUseRteZ1n7ec@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 9 Dec 2020 16:32:02 -0500")
Message-ID: <xmqqlfe6zdts.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AEABAD4-3A81-11EB-9DCD-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> TBH, I find the whole table overly confusing. But then, I am completely
> comfortable with the notion that it is really showing two diffs, with
> their results collated. To me it is simpler to just discuss the two
> sides of the diff independently, and then you do not even really need a
> table at all ("M" means modified no matter which column it appears in).
> But I may not be a representative Git user.

Me neither.  I think the folks who originally wanted to see the
table was curious about what combination of X and Y are possible.

For example, if a path is deleted in the index, there won't be any
intelligent thing we can say about the path in the working tree, so
after "git rm COPYING" we'd see "D COPYING", not "DD COPYING", and
after "git rm --cached COPYING && date >COPYING", we'd still see "D
COPYING", not "DM COPYING".

It is unclear how such knowledge would be useful to the readers, so
I won't shed tears if we got rid of the table; the bits saved might
be better used to enhance the description in the list of mnemonics.

Thanks.

