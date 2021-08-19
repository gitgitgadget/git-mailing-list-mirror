Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6504C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 00:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758316108E
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 00:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhHSAMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 20:12:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53994 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhHSAMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 20:12:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0A771306AE;
        Wed, 18 Aug 2021 20:11:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M/r0WIPW5YxsZpNR3208KWfx0OCJESue4WYGA4
        FfhNU=; b=s40fFa8/Sj2iV3PD0eCYz4Sgm+nCiDSGVOYGTyKdVDdr/DDWXQzfQ1
        csCGEC9PcyDInEAqbdApP3zvDhVV7tH9LAOGK0zJW/ywvwK/du+d0AtXLQYm47Bl
        rlx1c4CTtRFp8GtqqmKq9QmpPRPr+rOwqEXeI6mqu6QAlnkPRlsM4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8DC51306AD;
        Wed, 18 Aug 2021 20:11:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E9301306AC;
        Wed, 18 Aug 2021 20:11:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] fixup! propagate errno from failing read
References: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com>
        <xmqq4kbn7l3l.fsf@gitster.g>
        <CAFQ2z_Ni1bvj0Skgp_3p9htQfjn_M=3uF06pyZm_hkXgT_L61g@mail.gmail.com>
        <xmqqo89u61ww.fsf@gitster.g>
Date:   Wed, 18 Aug 2021 17:11:36 -0700
In-Reply-To: <xmqqo89u61ww.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        18 Aug 2021 11:30:39 -0700")
Message-ID: <xmqq7dgi47k7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05A4C610-0082-11EC-AD65-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> So it could be squashed into commit a0731250, or put on top of next as
>> a separate commit (probably with 'fixup!' removed).
>
> I'd try the former first and will fall back on the latter, then.

I've reverted a0731250 out of 'next', squashed the fix in, rebuilt
the topic and merged it back to 'next'.  Thanks.
