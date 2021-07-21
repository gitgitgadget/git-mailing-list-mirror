Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DDBC6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEC86121E
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhGUWnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:43:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57877 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhGUWnL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:43:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97571DF27D;
        Wed, 21 Jul 2021 19:23:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=USCoZy02NomS
        PCezTpY8QPBjyY7axSdnHH2wZFwD0Oo=; b=oOJMzKlngx9ShPGZp5ztRXefhFQP
        Xmr9g6biDuf0nfYWUZ/19D9nuZ3e3zy4LX9PJ48h5l1ttla9UD/nwmFUSUKPOUYn
        OA7qSzhc3HkvG515X61E2Cfky6EPe12kAZq4Tg66u9eZvgwq7OSS54H/JKv+Abat
        PQBn/iRZTRtiYn4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F3E1DF27C;
        Wed, 21 Jul 2021 19:23:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 09E37DF27B;
        Wed, 21 Jul 2021 19:23:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/8] test-lib tests: split off subtest code in t0000
 into lib-subtest.sh
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
        <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
Date:   Wed, 21 Jul 2021 16:23:45 -0700
In-Reply-To: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Jul
 2021 00:57:39 +0200")
Message-ID: <xmqq35s7b69q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B2253B7C-EA7A-11EB-B31C-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The v1[1] of this recently started conflicting with the cooking
> jk/t0000-subtests-fix and ps/t0000-output-directory-fix, and got
> ejected from "seen". This v2 is rebased on top of those two, so it
> merges cleanly with "seen".

Thanks for noticing and proactively updating before I got around to
asking you ;-)
