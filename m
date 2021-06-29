Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57ACC11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF0461C47
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhF2Uvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 16:51:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60203 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhF2Uvv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 16:51:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2027CCD4C0;
        Tue, 29 Jun 2021 16:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=bZ0Z/qiyLSQ17mCxQ8gwkIOSj
        vpvheHvohG1VMmblaE=; b=Vtb4zsQhV1UZ5OT28fcpPLje+SHBZx/M+QLKeHEBL
        ojMhavlk/4qs6yuPxp1A0WJTIwcf7aevX3u9A0TuvXkn6YlKVJIK8AiSHSQuoiRR
        DaC86kcSlY9T1ss/cMVkct5SRibUQ6bij2bOk4IH9V6U3pq04A8C6YFNHAyCz5M8
        SU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1750CCD4BF;
        Tue, 29 Jun 2021 16:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49F0FCD4BE;
        Tue, 29 Jun 2021 16:49:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 0/2] t640{0,2}: preserve ls-files exit status code
References: <20210615172038.28917-1-congdanhqx@gmail.com>
        <cover.1624974969.git.congdanhqx@gmail.com>
Date:   Tue, 29 Jun 2021 13:49:21 -0700
Message-ID: <xmqqim1wwg4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7B7000F0-D91B-11EB-9BF0-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> This is a series to clear false positive when applying Junio's suggesti=
on to
> to a series written by =C3=86var [1].
>
> Not that we have any conclusion on that suggestion, just to clear the w=
ay out.

I do not think the careless and loose pattern I suggested in the old
thread has much value, so any change whose purpose is to reduce
false positive from the pattern is not needed.

But if these two patches are genuine improvement for other reasons
(like "we avoid feeding output from 'git' into pipe"), they are very
much welcome.

Thanks.
