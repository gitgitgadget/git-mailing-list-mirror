Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071B0C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E6423333
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAFXPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 18:15:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63014 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFXPR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 18:15:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB6D1112ADB;
        Wed,  6 Jan 2021 18:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DZZlFCxJcf7Mv8070F/Y7qXLrw8=; b=feWZo7
        s7y//C10exF9uvHgtDub0EHOk0Ke6wJa3nfWHW9dIcZ8R9pOasCJ3qqe5dNXXBjw
        WXr1d1K1gLUbZcXPtDINblk1znzKH1FhvXCiBncok2xYuSnMAItnmiBANZvONxhq
        scTxJs9Kh/8Lg3qUn5Z0nkYb/xR5/xOOtVGTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UVSlUv9HMlA7dwNAQgY9crfh24b+l25a
        lmaf+4yBOTEfX9DtDA0LF3otA7vkfWWacAFApRQI3FmaEFKBMgWIonS5FUmzllIg
        1n/9FFuKiEhFpfybhchgQxk0GiyDcbjp/9Voh4iwhr3hC1DA/GmTEsJ1aiom+b64
        bSkgguU0Nj0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4248112ADA;
        Wed,  6 Jan 2021 18:14:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 17B47112AD4;
        Wed,  6 Jan 2021 18:14:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?6Zi/5b6354OI?= <adlternative@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] builtin/*: update usage format
References: <pull.822.v2.git.1609933875.gitgitgadget@gmail.com>
        <pull.822.v3.git.1609944243.gitgitgadget@gmail.com>
Date:   Wed, 06 Jan 2021 15:14:31 -0800
In-Reply-To: <pull.822.v3.git.1609944243.gitgitgadget@gmail.com>
 (=?utf-8?B?IumYv+W+t+eDiA==?= via
        GitGitGadget"'s message of "Wed, 06 Jan 2021 14:44:01 +0000")
Message-ID: <xmqqa6tlpsiw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF98DE5A-5074-11EB-96C1-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  builtin/am.c                |  4 ++--
>  builtin/blame.c             | 48 ++++++++++++++++++-------------------
>  builtin/commit-graph.c      |  6 ++---
>  builtin/fast-export.c       | 22 ++++++++---------
>  builtin/log.c               |  8 +++----
>  builtin/shortlog.c          | 10 ++++----
>  builtin/submodule--helper.c | 24 +++++++++----------
>  parse-options.h             |  6 ++---
>  8 files changed, 64 insertions(+), 64 deletions(-)

Looks good to me.  Thanks.
