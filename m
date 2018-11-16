Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429391F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 03:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeKPNvM (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 08:51:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54865 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeKPNvM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 08:51:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7D072C02A;
        Thu, 15 Nov 2018 22:40:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=v+N4oH/mF568
        L9/jL6nJ/rKcIRA=; b=gYvgBQ9HBOYrPZSm+++XMEkj4wrgxl8JU46lj/M6slsB
        njeVe3+w5mz8CmCqRIwhBW+pNOYQ5kj/XT9J5kKRqCd3cWpC8rRn2yctqkex1ExD
        85ETB2SlOwOLQcjF0dzSwwGE7OcbRLp6yAi1H3X3sThreOOxaJVqXUMtEd0noMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hHCKuA
        wVeGBIwsP86yHT/QoGhGX3vZVR7FHGTmViCvSwbQoSeqw8PJj3n7ADiM4vKpWgbq
        6dxjmtqIA/icwr+39su/jWHhDvY+YPf+pQ5S1eoR2tfTbPF6C679U/PD2Vyu0lS4
        hegGML2wPRR2yzjcNQRaZXKFQT0dkV6lk+eYw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D02642C028;
        Thu, 15 Nov 2018 22:40:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E37A72C027;
        Thu, 15 Nov 2018 22:40:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] rebase doc: document rebase.useBuiltin
References: <0181114090144.31412-1-avarab@gmail.com>
        <20181114091506.1452-2-avarab@gmail.com>
Date:   Fri, 16 Nov 2018 12:40:22 +0900
In-Reply-To: <20181114091506.1452-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 14 Nov 2018 09:15:05 +0000")
Message-ID: <xmqqr2fllmft.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5A2F9FDE-E951-11E8-811F-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The rebase.useBuiltin variable introduced in 55071ea248 ("rebase:
> start implementing it as a builtin", 2018-08-07) was turned on by
> default in 5541bd5b8f ("rebase: default to using the builtin rebase",
> 2018-08-08), but had no documentation.

I actually thought that everybody understood that this was merely an
aid to be used during the development of the feature and never meant
to be given to the end users.

With my devil's advocate hat on, how much do we trust it as an
escape hatch?  After all, the codepath to hide the "rebase in C"
implementation and use the scripted version were never in 'master'
(or 'next' for that matter) with this variable turned off, so I am
reasonably sure it had no serious exposure to real world usage.

Having said that, assuming that the switching back to scripted
version works correctly and assuming that we want to expose this to
end users, I think the patch text makes sense.

Thanks.

> Let's document it so that users who run into any stability issues with
> the C rewrite know there's an escape hatch[1], and make it clear that
> needing to turn off builtin rebase means you've found a bug in git.
>
> 1. https://public-inbox.org/git/87y39w1wc2.fsf@evledraar.gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/config/rebase.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/reb=
ase.txt
> index 42e1ba7575..f079bf6b7e 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -1,3 +1,17 @@
> +rebase.useBuiltin::
> +	Set to `false` to use the legacy shellscript implementation of
> +	linkgit:git-rebase[1]. Is `true` by default, which means use
> +	the built-in rewrite of it in C.
> ++
> +The C rewrite is first included with Git version 2.20. This option
> +serves an an escape hatch to re-enable the legacy version in case any
> +bugs are found in the rewrite. This option and the shellscript version
> +of linkgit:git-rebase[1] will be removed in some future release.
> ++
> +If you find some reason to set this option to `false` other than
> +one-off testing you should report the behavior difference as a bug in
> +git.
> +
>  rebase.stat::
>  	Whether to show a diffstat of what changed upstream since the last
>  	rebase. False by default.
