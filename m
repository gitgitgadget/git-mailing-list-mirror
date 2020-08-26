Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC788C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 690152074A
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iAiAP6NX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHZQYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:24:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50462 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgHZQYX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:24:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52F8CEBF61;
        Wed, 26 Aug 2020 12:24:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FI+/YHOiphsGIOo1qV+mIKJ9k00=; b=iAiAP6
        NXXB6ish06TFG3Ai2So9HvimZWWKcyLThbNOvrENO7OeGzVA1Hz6urduv53xW6Vz
        OMTqf24+KYp1ihxs0HX0eBjzWcLedYTHYDyVGeleQ00tZPVN+lO83oPsF6AIGRhz
        tHkZRlKOIyr6bUQELXAqEKBde7chQRRaCvAdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ArPltqlqzdfFyPVf9xSSe9bvsfBVRlI0
        oHLw2D4y6Dk3aeQIp9x9Zyb6ogM2oZdmJbIc8ojN2aVPqoBVX6S90UXpaKhnejP2
        bxIX7+67uJEaA6zH++HpoIosJgv8lFFt6otFECQkEVT5WkbA8A0oSUCqxJ+sbYKm
        xhRNgBJL9D0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AA05EBF60;
        Wed, 26 Aug 2020 12:24:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 887E3EBF5F;
        Wed, 26 Aug 2020 12:24:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ci: stop linking built-ins to the dashed versions
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com>
        <20200825134714.GC25052@szeder.dev>
        <xmqq364a3f6r.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2008260615280.56@tvgsbejvaqbjf.bet>
        <xmqq5z95xu5f.fsf@gitster.c.googlers.com>
Date:   Wed, 26 Aug 2020 09:24:16 -0700
In-Reply-To: <xmqq5z95xu5f.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 26 Aug 2020 09:13:16 -0700")
Message-ID: <xmqqtuwpwf2n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 973FF25E-E7B8-11EA-9BA7-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Actually, `SKIP_DASHED_BUILT_INS` does not _only_ have an impact on `make
>> install`:
>> ...
>> See how `git-add.exe` is linked in the first, but not in the second run?
>
> OK, that is one more reason why we do want to have 3/3 applied not
> for all tasks in the CI , but for subset of tasks that includes the
> Windows task.  If we had multiple Windows tasks, it may even be
> better to have only to some tasks, and allow other tasks build
> git-add.exe, so that both can be tested for the primary intended
> platform.

In other words, something like this squashed in.

 ci/run-build-and-tests.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 1df9402c3b..cfb841d981 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,12 +5,16 @@
 
 . ${0%/*}/lib.sh
 
+BUILTINS_HOW=
 case "$CI_OS_NAME" in
-windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
-*) ln -s "$cache_dir/.prove" t/.prove;;
+windows*) 
+	BUILTINS_HOW=SKIP_DASHED_BUILT_INS=YesPlease
+	cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
+*)
+	ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
-make SKIP_DASHED_BUILT_INS=YesPlease
+make $BUILTINS_HOW
 case "$jobname" in
 linux-gcc)
 	make test
