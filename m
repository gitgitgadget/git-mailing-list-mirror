Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157FDC433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 17:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiF1RAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbiF1RAT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 13:00:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F622251C
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 09:59:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5647C196DFF;
        Tue, 28 Jun 2022 12:59:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Tl6VdSL0D5WQAjZ7SdCM/a7t+fUaq82zpUi/G
        GWTNk=; b=DQEVh8WlZWCfCi+PHniuKvqE/mAGajmJK6bIazMM/tvlAtTn7i30WU
        5GekNKHV9mSKt4U7tr5kSDO3rzlMqYeRDARDnV6TS7W07o/kAwQR+eSLazoPdR03
        /XUiu2yqDl2SKclwZkzLZV1F1QwtUWllBGXSVC7KXseJUVRtJO1QE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F006196DFE;
        Tue, 28 Jun 2022 12:59:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D79F3196DFC;
        Tue, 28 Jun 2022 12:59:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, Johannes.Schindelin@gmx.de
Subject: Re: Rendering back-ticks in plaintext docs (was Re: [PATCH]
 git-rebase.txt: use back-ticks consistently)
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
        <220628.86k091f5fy.gmgdl@evledraar.gmail.com>
        <a01c1ff7-74a7-b32f-1a1e-a8f2e840ae31@github.com>
Date:   Tue, 28 Jun 2022 09:59:40 -0700
In-Reply-To: <a01c1ff7-74a7-b32f-1a1e-a8f2e840ae31@github.com> (Derrick
        Stolee's message of "Tue, 28 Jun 2022 09:20:24 -0400")
Message-ID: <xmqqfsjolo5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4078F1C-F703-11EC-A641-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> I see Phillip spotted some of this already, but the "exec" change here
>> looks unwanted, i.e. let's use double quotes there.
>
> This is definitely an issue where I was looking at the HTML formatted
> output, which respects back-ticks. Thanks for pointing out that the
> text docs just ignore back-ticks. This seems problematic, in my opinion.
>
> Is it possible to update our doc formatting to convert back-ticks into
> something like single quotes? That would help these plain-text documents
> point out these places where exact strings are very important.
>
> I also have no idea where to look to make such a change, and it would be
> very wide-ranging. I just think that the plaintext docs are currently a
> lossy medium and we should work to improve that.

Looking at "man -l git-rebase.1" output, not the "doc-diff" output
that renders to pure plain text by deliberately losing font
information in the roff output, I think this change is OK.  IOW,
"git help -m rebase" shows these marked-up parts in bold on the
terminal (and on the paper, but who prints manual pages theres
days?), which is what we want.

If there is something we found in this episode that we might want to
improve, it is doc-diff, I would think.

Thanks.
