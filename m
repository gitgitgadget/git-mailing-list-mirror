Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F73C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352418AbiDUVmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442210AbiDUVmb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 17:42:31 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD83B4C426
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:39:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7654A196F6E;
        Thu, 21 Apr 2022 17:39:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=f62n0BiZvOD2
        oUxDFBpy0LNJv6g/cVKvvQe6pyWPB4k=; b=vhAtxWGRVxDf/V1oHyVCvD4AlMBE
        KM5z/qujvu7EqZyJ44y5m56CUSXgPDVgqfF0Aqx5EnQIy1DjKSr7rxb7MWknz0Wq
        cflIvXI66xL4b+0pSoFT0z7SKo7yUafUhEDICLaovG+8w+1j1f2XSI2BPPAG26Rf
        o1nv/EclbvIUoyo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6EF05196F6D;
        Thu, 21 Apr 2022 17:39:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA056196F6C;
        Thu, 21 Apr 2022 17:39:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] CI: don't fail OSX tests due to brew v.s.
 perforce.com mis-matchy
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
        <20220421213024.xzkzuy3l7q5assxo@carlos-mbp.lan>
Date:   Thu, 21 Apr 2022 14:39:35 -0700
In-Reply-To: <20220421213024.xzkzuy3l7q5assxo@carlos-mbp.lan> ("Carlo
 Marcelo
        Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 21 Apr 2022 14:30:24
 -0700")
Message-ID: <xmqq35i6f754.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8A966900-C1BB-11EC-B7EC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> On Thu, Apr 21, 2022 at 02:53:50PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> For the past days we've again had CI failures due to "brew install"
>> detecting a SHA-256 mismatch when trying to install the perforce
>
> Since the only reason why that is a concern is because it aborts the
> rest of the run and is a recurring problem, wouldn't it be better to
> tell the script to continue regardless and therefore skip all perforce
> tests?
>
> Sure, there is a window where that integration could be broken which
> will be only visible once the perforce cask gets fixed and perforce
> installs again, but wouldn't that be less intrusive and overall safer
> than the currently proposed change?

Good suggestion.  Care to come up with an alternative patch (or
two)?

Thanks.
