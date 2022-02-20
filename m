Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D10C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 07:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiBTHxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 02:53:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiBTHxH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 02:53:07 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654F4617A
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 23:52:46 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8756E174A21;
        Sun, 20 Feb 2022 02:52:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UBtW5SfKq5tq
        tSK5jKrrOsi15GAv9jgwrGl7ViBdCHs=; b=q9YPb4d6R59KTWO2Yh2Hkt9rEtI3
        s8CkcbJ7cSHpRGE1l084E6Dzsgd/3Dvp83KEIQt/nQWdtwqCDt93NEsM/tNi45w+
        PtGgyNel/+sW1bozW48xpaXt2ap6A1ikPV7gIUapYDCF6CWlb4FctbYxtudWy2MY
        4Cnge34X3Hd7JJg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 715A2174A20;
        Sun, 20 Feb 2022 02:52:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE9AC174A1F;
        Sun, 20 Feb 2022 02:52:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/4] test-lib: add GIT_XSAN_OPTIONS, inherit
 [AL]SAN_OPTIONS
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
        <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
        <patch-v2-1.4-01e63a72231-20220219T112653Z-avarab@gmail.com>
Date:   Sat, 19 Feb 2022 23:52:42 -0800
In-Reply-To: <patch-v2-1.4-01e63a72231-20220219T112653Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 19 Feb
 2022 12:29:40
        +0100")
Message-ID: <xmqqh78uvut1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 16142D4C-9222-11EC-BBD9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change our ASAN_OPTIONS and LSAN_OPTIONS to set defaults for those
> variables, rather than punting out entirely if we already have them in
> the environment.
>
> We do want to take any user-provided settings over our own, but we can
> do do that by prepending our defaults to the variable. The

do do do?

> libsanitizer options parsing has "last option wins" semantics.
> ...
> +# If [AL]SAN is in effect we want to abort so that we notice
> +# problems. The GIT_XSAN_OPTIONS variable can be used to set common

As we say GIT_ prefix, we can just drop X.  "Git's sanitizer options".

