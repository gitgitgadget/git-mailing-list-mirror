Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A106C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 17:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5AB02075E
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 17:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XV11U1l0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgJ3RG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 13:06:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51467 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3RG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 13:06:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F8838552F;
        Fri, 30 Oct 2020 13:06:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=brwLlg1u0yFWyfgCAUu/dvhn0ns=; b=XV11U1
        l0PbiGM+GFQfuK4k6OYTQ5dnF/h+cXIT54CGcRWv/C85IR0mXUdv1sN1/IDbSf9D
        MpcCS7ianxXfh3Cs5nw6sKDpbFK9cg0lgENV48nTNRGfDisxslDnjhCp7kJ0LJ+2
        sgykhUsdmtyZ2ktST24T6DfH4Fd3W6y10OiTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WFpZz5iLk6OK/v3Jyj3qPWAaEUBRYiRP
        0QdVUyV2K9lZylM12yQB83p8LSgl/e7NQIibtYgogR5862VUOTANuTpDnwrWoKCe
        i3uWmwBlVGZqGz5hvcMUhxpMnka0KYsh67PLF02AOSJH2zdvdkpAox4OcZvgROZA
        y5EZZg8umyI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0662D8552E;
        Fri, 30 Oct 2020 13:06:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82E2D8552D;
        Fri, 30 Oct 2020 13:06:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/4] t5411: start using the default branch name "main"
References: <pull.760.git.1603839487.gitgitgadget@gmail.com>
        <f997166db4c29d971a2343f70c9d9a0505a8cc4b.1603839487.git.gitgitgadget@gmail.com>
        <xmqqa6w69l3j.fsf@gitster.c.googlers.com>
        <xmqq5z6u9kkv.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010301559540.18437@tvgsbejvaqbjf.bet>
Date:   Fri, 30 Oct 2020 10:06:51 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010301559540.18437@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 30 Oct 2020 16:04:19 +0100
        (CET)")
Message-ID: <xmqqlffn3aok.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EFC0C38-1AD2-11EB-A48B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Do you mean that this patch, squashed into 1/4:
> ...
> would be much more understandable?

Yes, that was what I meant.  

We could have a "test_skip='under construction'" without any
PREPARE_FOR_MAIN_BRANCH in 1/4 and then replace that with the
endgame state you already had in 4/4, alternatively, which might
already be enough explanation for a short transition period that
lasts just few patches ;-).

> If so, I agree, and I will gladly send off the next iteration with that
> change.
>
> If I misunderstood, can I please ask you to give it another try to explain
> it to me?

No, you understood what I meant perfectly.

Thanks.
