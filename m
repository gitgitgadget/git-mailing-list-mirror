Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF1BC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E7061418
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhDTXfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:35:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58744 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbhDTXe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 19:34:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 305E4BA328;
        Tue, 20 Apr 2021 19:34:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ykkad/xKN6C89nxzL9bnOl69rUM=; b=xCppQO
        7Y6543IkdLt287suDrIYpY5It8RWnhagpzfNEChjmq1LpKt8edRg+bMvU5CZe/RG
        KpV9WlAlH3AtkDnRAEm9joQuUFKSdgDY5NRf6nvS883DCA8NQ0dJrh30erFhzy52
        7te2sxdtvUiCGBjVWc2B0CA85IDUsEpY5mw4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sQQSqksD6vqe3HWRkc7sNjlRHoRzK/Km
        GiHJ2ejJqRfmuMo5oo9uX4psNNAsNZGSBBBndf3b5nNx0GMGPpdjaScbgjUyEKHo
        44PeZYRHwz6fWf3cW4YY8UD58oe5PN2GYC1Xo1UvebahZk0EUl9YJCh2Y2Evdani
        HDmkIXv/Yzo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 297B9BA326;
        Tue, 20 Apr 2021 19:34:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ADA88BA325;
        Tue, 20 Apr 2021 19:34:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Document how we do embargoed releases -
 improving mail template
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
        <pull.917.v2.git.1617025385.gitgitgadget@gmail.com>
        <565d7982d870fb1b7644a9777aef6be7ee174dba.1617025385.git.gitgitgadget@gmail.com>
        <robbat2-20210420T193302-520335089Z@orbis-terrarum.net>
        <xmqq5z0g4oc9.fsf@gitster.g>
        <robbat2-20210420T223619-939869983Z@orbis-terrarum.net>
Date:   Tue, 20 Apr 2021 16:34:25 -0700
In-Reply-To: <robbat2-20210420T223619-939869983Z@orbis-terrarum.net> (Robin
        H. Johnson's message of "Tue, 20 Apr 2021 22:45:32 +0000")
Message-ID: <xmqqsg3k1qf2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1693758-A230-11EB-AC2A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> Alternatively, publish byte-exact reproduction steps from the tags to
> the tarballs, so that we can generate them locally for co-ordinated
> release.

What I meant to say was that there is no byte-exact reproduction
steps.  There is a build procedure but the design goal of the build
procedure for the doc tarballs does not include byte-exact
reproduction at all, as the doc tarballs are not considered as
sources.  It's meant as a mere convenience for those who lack the
asciidoc(tor) toolchain, a semi-binary distribution.

