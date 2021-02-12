Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63626C433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 22:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C98864E00
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 22:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhBLWiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 17:38:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62473 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhBLWgc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 17:36:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F3CB7119AD9;
        Fri, 12 Feb 2021 17:35:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oA3GwEPO2yex
        Hm77ZtrMZi0SPzY=; b=xTMMC3lNbemthochoCpIyOO/DvRbBAPYR0BexrtMa0tE
        r9vTXdzN2a8GTpnIIgOGfJdS64q8JIAhgU/PJc/uGSYdQT5FTXTjMKLjKTODuNDr
        /OFvUqqZJFEXn5Mm6qFk/5y7z+ojlnRzI38N6cdvP4pqEu9seOfsV0CHz9dq/UU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QzuliO
        54wOl8ltGTdFvYpXeo7TdhZ8TQrucS987sfAk5386MmfvVq89iVGQ1O5wuUe1MNB
        /aqjioF1EIkH/tFU7OzqbsWDZBOMQyzhej4jhLaT0tGQPIYEEg/zR6xp/RKU+JmS
        TvsIPCeuz8p+1000z6K9uJIDdEndmCPOofZnA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED171119AD8;
        Fri, 12 Feb 2021 17:35:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3B16D119AD7;
        Fri, 12 Feb 2021 17:35:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 00/11] test-lib: misc improvements
References: <20210209214159.22815-1-avarab@gmail.com>
        <20210212132942.17325-1-avarab@gmail.com>
Date:   Fri, 12 Feb 2021 14:35:42 -0800
In-Reply-To: <20210212132942.17325-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 12 Feb 2021 14:29:31 +0100")
Message-ID: <xmqqim6wvrr5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A4C6CF7E-6D82-11EB-B77E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fixed a missing SOB and dropped the 12th patch.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (11):
>   test-lib: remove check_var_migration
>   test lib: change "error" to "BUG" as appropriate
>   test-lib-functions: move test_set_index_version() to its user
>   test-lib-functions: remove generate_zero_bytes() wrapper
>   test libs: rename bundle helper to "lib-bundle.sh"
>   test libs: rename gitweb-lib.sh to lib-gitweb.sh
>   test-lib-functions: move function to lib-bitmap.sh
>   t/.gitattributes: sort lines
>   test libs: rename "diff-lib" to "lib-diff"
>   test-lib-functions: remove bug-inducing "diagnostics" helper param
>   test-lib-functions: assert correct parameter count

Will replace and queue.  Let's declare a victory and move on.
