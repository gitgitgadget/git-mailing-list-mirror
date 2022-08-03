Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0102C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 16:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiHCQhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHCQhL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 12:37:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0125A6544
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 09:37:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0937014B88F;
        Wed,  3 Aug 2022 12:37:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=f/bY7H7XDA3M
        V3X1QycZrPqjBcce6snX91nWaZLDVkU=; b=Cz3nIBYRvuVG6qSfcvMi64daHJmx
        0WujIM5jBmRS0wjidXGn7EhjXRC9BI7ZIHWB/XtlEc1dq4oebeUlYSjXkKNOfR68
        o0UhaD2rKqRX2brUsjwoPCA+qzemX7dEPbkjuqJzYJg1vZ29y5MWT9UHT2s4CG8P
        f5ILDu6KwcyV2B8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7B4014B88E;
        Wed,  3 Aug 2022 12:37:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B5AD14B88D;
        Wed,  3 Aug 2022 12:37:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v7 10/10] docs: move multi-pack-index docs to man section 5
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
        <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <patch-v7-10.10-8baf1db4d30-20220802T125258Z-avarab@gmail.com>
Date:   Wed, 03 Aug 2022 09:37:06 -0700
In-Reply-To: <patch-v7-10.10-8baf1db4d30-20220802T125258Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 Aug
 2022 14:56:59
        +0200")
Message-ID: <xmqqiln9b7wt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 83FE33B2-134A-11ED-9343-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat=
-pack.txt
> index 546c99f8871..68328bada6b 100644
> --- a/Documentation/gitformat-pack.txt
> +++ b/Documentation/gitformat-pack.txt
> @@ -507,6 +507,11 @@ packs arranged in MIDX order (with the preferred p=
ack coming first).
>  The MIDX's reverse index is stored in the optional 'RIDX' chunk within
>  the MIDX itself.
> =20
> +SEE ALSO
> +--------
> +
> +linkgit:gitformat-multi-pack-index[5]

I already sais that midx and mtimes may want to be all described in
the main packfile format documentation, but I am OK to have separate
pages for these auxiliary files that supplement the .pack/.idx pairs
of files.  If we were to go that route, we should have a link to
cruft .mtimes page here, next to the link to midx page added here.

I find the direction of the overall goal of the series agreeable.
Thanks for working on the patches.
