Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46446C433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 17:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbiERRfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbiERRfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 13:35:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6989912AD7
        for <git@vger.kernel.org>; Wed, 18 May 2022 10:35:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8FCF13E5B2;
        Wed, 18 May 2022 13:35:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kk9qFzzEETFX
        khXNDps1mIah+CRVgRVsQCfpsdCQjks=; b=tW4xVRsu0g3BT41+qXB+pBGhtIZN
        8nztKRMpLG5DdApTiyCRUbZ5ACznojg6oh6q68kypcXIk0yuwmxfTyLcGiYgdFjf
        /UXe/HQ1lbfeqtEPHPTLc0dCYGueLwLC0aJWngxTEh0yIiGPCinRnSXnh3jT+GA/
        Hfzt4RvaMa1p5Wk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D40313E5B1;
        Wed, 18 May 2022 13:35:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 928CA13E5AF;
        Wed, 18 May 2022 13:35:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 3/7] scalar: validate the optional enlistment argument
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <da9f52a82406ffc909e9c5f2b6b5e77818d972c0.1652210824.git.gitgitgadget@gmail.com>
        <220517.867d6k6wjr.gmgdl@evledraar.gmail.com>
Date:   Wed, 18 May 2022 10:35:11 -0700
In-Reply-To: <220517.867d6k6wjr.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 17 May 2022 16:51:59 +0200")
Message-ID: <xmqqbkvuwxps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DF1A91FC-D6D0-11EC-A6A4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +test_expect_success '`scalar [...] <dir>` errors out when dir is miss=
ing' '
>> +	! scalar run config cloned 2>err &&
>
> Needs to use test_must_fail, not !

Good eyes and careful reading are very much appreciated, but in this
case, doesn't such an improvement depend on an update to teach
test_must_fail_acceptable about scalar being whitelisted?


