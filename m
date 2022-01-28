Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB5FC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 01:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbiA1B7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:59:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52167 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiA1B7o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 20:59:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D4DA10EBE6;
        Thu, 27 Jan 2022 20:59:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fFRiDpoe+AeBUI7whcSaxNWGlh2sRLHooNeY6H
        /V40g=; b=Kjb1KsDRdWePCNo3Hv/CTHEpUjwt0WG7yWDKc2EK7DkcHBp/NfpLlq
        bBqJ0Agiwwbgq3G6fnqIo8DI45VT26qm2TqscW1rIbmasFoP1dpnVNAeb+9/rkVZ
        /plbvoBOzLJEjGRuGHR2uo+t2UKQtbikYhxvDHL/seB1l3ImltOvc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2579D10EBE5;
        Thu, 27 Jan 2022 20:59:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C01610EBE3;
        Thu, 27 Jan 2022 20:59:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] Really retire git-legacy-stash.sh
References: <pull.1133.git.1643321031.gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 17:59:41 -0800
In-Reply-To: <pull.1133.git.1643321031.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 27 Jan 2022 22:03:47
        +0000")
Message-ID: <xmqqpmocy60i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F58E8BA4-7FDD-11EC-9B35-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> After proving out git stash for a very long time as a shell script, we
> eventually converted it to a proper built-in, leaving an escape hatch in
> place to call the scripted version.
>
> After another very long time, we removed that escape hatch, leaving behind a
> warning.
>
> Now, almost two years later, let's remove even that warning (and a couple of
> tidbits that we inadvertently left in the code base).

Yay.  We probably could have done this when we disabled the escape
hatch, but better late than never ;-)

> Johannes Schindelin (4):
>   git-sh-setup: remove remnant bits referring to `git-legacy-stash`
>   add: remove support for `git-legacy-stash`
>   Remove documentation for `stash.useBuiltin`
>   stash: stop warning about the obsolete `stash.useBuiltin` config
>     setting
>
>  Documentation/config/stash.txt |  7 -------
>  builtin/add.c                  | 14 --------------
>  builtin/stash.c                | 10 ----------
>  git-sh-setup.sh                |  1 -
>  t/t3903-stash.sh               | 15 ---------------
>  5 files changed, 47 deletions(-)

It is surprisingly small removal, but matches the explanation above,
i.e. the actual old implementation was gone long time ago.

Looking good.

Thanks.
