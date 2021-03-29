Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04003C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE0561987
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhC2Vgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:36:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56530 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhC2VgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:36:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F18A125831;
        Mon, 29 Mar 2021 17:36:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=inV/dpFL4L9dfEat7klDnDfOyiM=; b=uvHFyQ
        c7NmHFrDFz6CgaYtc4dS+RT78RPrAgmtzmmic1tn7cd/VI+KZDUpPoUVyEfuKKfz
        A8d8SBEjKdgEtuZfEUEsCnJRHdDY6dsst8/PQlwm7tOi12/iohukNViD/OY8Ns30
        vW5m7ArGM8evODRLUUIgjPSgslTuOAg2HwV20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ATEc3EUHVP0A2ElYCD99PtPGKrFkwWsE
        56NthRmHp4ugnpW8ohRbg7STCBam5V68ZPcm0SontyYaaZJZsFW4cC8SCxeuxD6q
        6ijvGzkMA0WMYOVILexiL9Np231C1wlG/XuQZwjklOY4fc5Xzjcps97PtZwhI+kn
        B7ChtJJN0wA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 375E5125830;
        Mon, 29 Mar 2021 17:36:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72FB912582E;
        Mon, 29 Mar 2021 17:36:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v8] builtin/clone.c: add --reject-shallow option
References: <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com>
        <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 14:36:20 -0700
In-Reply-To: <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Mon, 29 Mar 2021 10:19:04
        +0000")
Message-ID: <xmqqa6qliqwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE61C2CC-90D6-11EB-BF18-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Changes since v6:
>     
>      * use _() for warning/die statement

This round tweaks a few test titles and drops warning() that was
given in v7 when the feature is not in use.

Comments from other reviewers who are more familiar with the
transport layer than I am?  As far as I see, this version is
done cleanly enough to call it ready for 'next'.

Thanks.
