Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2953EC47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 03:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BDC60FEA
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 03:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhFIDla (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 23:41:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65290 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbhFIDl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 23:41:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29C76D31FE;
        Tue,  8 Jun 2021 23:39:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w1b/phmZ3B8ddhIVOeVqz0B+jHBbgRLToriPDN
        8iwII=; b=cKxmBzI0cixqD0oDrluhKWLG9mFcXsfRvyfjk+FTrJ1GDBUg066QBr
        stNpamRlA+u5jbsZZN+QjEu7u1YwlixI7J8i1zGNVeSIMQT3+nlCMqFnqyMvZJWO
        VxlZxd3x/ODRWIiiC7GOXYIcH9LtGXv/feZyEhuXRK6j3VOszu+vc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2221FD31FD;
        Tue,  8 Jun 2021 23:39:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2965D31FC;
        Tue,  8 Jun 2021 23:39:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 0/4] [GSOC][RFC] ref-filter: add %(rest) atom
References: <pull.976.git.1623163082.gitgitgadget@gmail.com>
Date:   Wed, 09 Jun 2021 12:39:33 +0900
In-Reply-To: <pull.976.git.1623163082.gitgitgadget@gmail.com> (ZheNing Hu via
        GitGitGadget's message of "Tue, 08 Jun 2021 14:37:58 +0000")
Message-ID: <xmqqtum7ln9m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EDF9318-C8D4-11EB-96EF-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In order to let git cat-file --batch reuse ref-filter logic, in this
> version, the atom %(rest) is added to ref-filter.
>
> Change from last version:
>
>  1. Deleted two commit about %(raw:textconv) and %(raw:filters), their
>     construction will be after letting cat-file --batch uses ref-filter
>     logic.
>  2. Exchange the order of the definition of "cmp_fn" and the declaration of
>     "a_size" and "b_size" in cmp_ref_sorting(), to avoid breaking
>     -Wdecl-after-stmt.
>  3. Delete --rest option, "git for-each-ref" family will reject %(rest) by
>     default.
>  4. Add GPG prefix to some %(raw) tests.
>
> ZheNing Hu (4):
>   [GSOC] ref-filter: add obj-type check in grab contents
>   [GSOC] ref-filter: add %(raw) atom
>   [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
>   [GSOC] ref-filter: add %(rest) atom

Thanks, will replace.
