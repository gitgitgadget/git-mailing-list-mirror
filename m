Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F58C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 00:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352227AbiDDAbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 20:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiDDAbL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 20:31:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AA3BA3
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 17:29:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11E5911E43D;
        Sun,  3 Apr 2022 20:29:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9Etv0AuaoTDF
        5v5LCzfwWWi6w2aGMa2TnLt5BFNl3OI=; b=XiImVhW/2usaJXB51iKgCaNnZy3R
        TDPopWZMKoAs5YH4RjVW7smkFt6zEkdsIvPWVVzkk9p0/W9VvGCHStF0dM2o693j
        6/GOT85ljw6zo/eRRW8zDVKMfld+3uvq2o4JGkXx4LPOCmJ7j+7EYQmFl9+QOzpb
        Bvern4Xg2yyS2kM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07FAD11E43C;
        Sun,  3 Apr 2022 20:29:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AA2711E43B;
        Sun,  3 Apr 2022 20:29:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 0/4] Importing and exporting stashes to refs
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220403182250.904933-1-sandals@crustytoothpaste.net>
        <xmqqtub9soew.fsf@gitster.g>
Date:   Sun, 03 Apr 2022 17:29:14 -0700
In-Reply-To: <xmqqtub9soew.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        03 Apr 2022 17:05:59 -0700")
Message-ID: <xmqqpmlxsnc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 41FEF5D8-B3AE-11EC-86DC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> Changes from v2:
>> * Fix uninitialized strbuf.
>> * Avoid C99-style initializations.
>
> Thanks.
>
> [1] is a CI run of 'seen' without this topic, while [2] is the same
> but with this topic.
>
> t3903.115-117 (stash export) are not very happy in the latter.
>
> e.g. https://github.com/git/git/runs/5808828105?check_suite_focus=3Dtru=
e#step:7:6623
>
> [References]
>
> *1* https://github.com/git/git/actions/runs/2086776970=20
> *2* https://github.com/git/git/actions/runs/2086887176=20

I think this is coming from a mismerge, conflicting topic being
=C3=86var's revisions leakage series.  I'll push out an updated
resolution later today.

Thanks.
