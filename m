Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B39C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABED60C40
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhG2TeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:34:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63067 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhG2TeE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:34:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 880A413A6A5;
        Thu, 29 Jul 2021 15:34:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vvy3cIf9OGlVURzAMHSaAJ0N9OIwlbLo40JRVP
        R76Lo=; b=RYZRQYff0YEAIrARcE3RXL1wM/USVmr992S5lW4kczMIhd7q3unWu1
        rhGoCVXLjQ5Ta23IdDgULIAeyodrd7cR2N4xm/fQLI5Tn6Iv4Dxp3bRPTDfqhnyc
        J6aBGFAXitmUtxUcpAa3oOMmI0YXjDE2g+1dvZFOT1ozNmuHAbdcQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8140B13A6A3;
        Thu, 29 Jul 2021 15:34:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C2E7213A6A2;
        Thu, 29 Jul 2021 15:33:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Daniel Knittl-Frank <knittl89@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Using two-dot range notation in `git rebase`?
References: <b3b5f044-8c76-ec71-45d6-1c7fea93c519@iee.email>
        <CACx-yZ1Je+tnZdJ21gDPeuQa-QTuY2t9mDujNr7wqJWFMwwzxA@mail.gmail.com>
        <dc7668ff-37ad-1d9e-fc92-df432549b4e2@iee.email>
        <YQKBNXsMdroX3DfY@coredump.intra.peff.net>
        <xmqqr1fh59go.fsf@gitster.g>
        <YQLldzh5OEY+mPLY@coredump.intra.peff.net>
Date:   Thu, 29 Jul 2021 12:33:56 -0700
In-Reply-To: <YQLldzh5OEY+mPLY@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 29 Jul 2021 13:29:27 -0400")
Message-ID: <xmqq5yws6hjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB037E52-F0A3-11EB-B18A-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Potentially it opens the door for stuff like:
>
>   git rebase ^A B C D
>
> but I am not sure if that is helpful or horrifying. ;)

It is the "you might be forgetting that 'rebase' is a tool to rebase
a single branch, and is not a tool to replay a history on a commit"
example.

The "multi-pick" variant of "git cherry-pick" probably has a lot
more affinity with the idea of specifying general sub-graph of
history to be replayed, expressed in the "externded SHA-1" syntax, I
would think.

Thanks.
