Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB65C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6577360EB6
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhGWVEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:04:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53714 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGWVEM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 17:04:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2C89C2632;
        Fri, 23 Jul 2021 17:44:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MCrQ0golZraiwviAMCIh1maZnMr7WMW9lasXEg
        YZcEA=; b=cc0Gb0/kFoc+5V+6PC73AeajhINjh0FSnOfXWnJZVO3FuzJ+o+WV6Y
        Nh6kssfDPPd0/iJwTxTlRb3tccnhOsL6mTyvEb4Y2mLWER55NHTnpevp76vDDo/j
        XLj3vMMKeNXjSUhuAAy0b3sRHVSVG0Bi2rvty+otnhHbStPaqdPFc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA202C2631;
        Fri, 23 Jul 2021 17:44:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41522C2630;
        Fri, 23 Jul 2021 17:44:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] doc: pull: fix rebase=false documentation
References: <20210721221545.1878514-1-felipe.contreras@gmail.com>
        <xmqqy29z9r94.fsf@gitster.g> <xmqqtukn9p0g.fsf@gitster.g>
        <60f8c8c92a215_1d0abb20859@natae.notmuch>
        <YPpwIazVxL4GoLbC@coredump.intra.peff.net>
        <xmqqwnphowdx.fsf@gitster.g> <60fb0a916c9cc_defb208eb@natae.notmuch>
Date:   Fri, 23 Jul 2021 14:44:43 -0700
In-Reply-To: <60fb0a916c9cc_defb208eb@natae.notmuch> (Felipe Contreras's
        message of "Fri, 23 Jul 2021 13:29:37 -0500")
Message-ID: <xmqqo8asln78.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3165D3EE-EBFF-11EB-AC5A-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> But that does not necessarily mean swapping the parent order would
>> produce the history of a right shape, either, even for those with
>> the "first-parent chain is the trunk" worldview.
>
> Why not?

I gave detailed write-up in two discussion threads linked already in
this thread from 2013 and 2014; as I said, I do not think we want to
debate that as part of the discussion of this documentation fix.
