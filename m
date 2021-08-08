Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_C,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8742BC4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 00:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575D360F25
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 00:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHHAnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 20:43:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61145 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhHHAnB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 20:43:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 696B3DE9B2;
        Sat,  7 Aug 2021 20:42:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=xE6hAfnGuTpVzD0Mv0J1WMXWUpc0QijOrcmkr6hHWLo=; b=CzE5
        H4XGLvahozQ8uD76YA4UImPZwRKgM01VNuUgy8BVKXBlwoKup/hKWeB3zPApgbRn
        D8PBh3+lDvfAzhZ6X5+ByEojvalXXFtVYL5sGTxPi54jyXhXPFaDHyev2T+EbL/N
        Ls9e/m/kKCgd5iKLCgR9UNSgClPk/1x3tvEIZ44=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60874DE9AF;
        Sat,  7 Aug 2021 20:42:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DDB3BDE9AE;
        Sat,  7 Aug 2021 20:42:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Sergey Organov <sorganov@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com> <YQyUM2uZdFBX8G0r@google.com>
        <xmqqh7g2ij5q.fsf@gitster.g> <YQ3n9Z2nH35429mC@google.com>
        <035b4e99-e708-f31b-2f13-e255d99dea33@kdbg.org>
        <YQ6P0OWPPksWG5Hf@google.com> <xmqqv94hi3zw.fsf@gitster.g>
        <YQ7MGoNswyZJHjkZ@google.com>
Date:   Sat, 07 Aug 2021 17:42:41 -0700
Message-ID: <xmqqy29chim6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89F71DEA-F7E1-11EB-B0CC-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Please don't treat this as an attempt to be argumentative:...

I won't.  I asked you what I didn't understand in what you said.
Answering the question is not being argumentative ;-)

> What's relevant is not whether the script author was in the wrong or
> in the right.

I do not agree with this reasoning at all.  Only if vast majority of
users incorrectly used the command and the option, we may need to
consider such a move as an exception, but not as a general rule.

But "stash list" example shows that "log --first-parent -m" without
"-p" in a script has a valid reason, and a change that hurts those
who correctly used a command and an option in a way they were
intended to do _is_ problematic.

Thanks.
