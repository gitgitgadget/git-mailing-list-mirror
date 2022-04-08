Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6B2C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 18:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiDHSWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbiDHSWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 14:22:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736BD2DCCA1
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 11:20:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD868109046;
        Fri,  8 Apr 2022 14:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ep8haSTWJnTE
        yEJjGcKZNEcImlXht6x8dGy8BkNsHrQ=; b=k+9rXZ0sVyPH0etzxBnaSw37OuDX
        zTvU8Gi7KJrNb2m87OFCW+Gm0pG+OmsV4Vz6fC89Uqxb5nt0bMZINzOAl2wyWmWE
        nb2qYfZQPkIadNq5LL3IL1Tx7ZZeFVjglJsRl94rrL5b2kxpSRRe+fde3aixxKPF
        Stfdab94UE86xnE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4DD0109044;
        Fri,  8 Apr 2022 14:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B96D109043;
        Fri,  8 Apr 2022 14:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH] ls-tree doc: document interaction with submodules
References: <20220407155231.2528221-1-martin.agren@gmail.com>
        <patch-1.1-183b9639ae7-20220408T155704Z-avarab@gmail.com>
Date:   Fri, 08 Apr 2022 11:20:31 -0700
In-Reply-To: <patch-1.1-183b9639ae7-20220408T155704Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 8 Apr
 2022 18:00:25 +0200")
Message-ID: <xmqqpmlrmo7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 939C646C-B768-11EC-8D66-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Thanks, perhaps this is also worth taking before the release, it's a
> rather trivial inaccuracy in the docs, but something that's new since
> v2.36.0.
> ...
> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.=
txt
> index 8f31e2ee9d4..0240adb8eec 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -151,11 +151,11 @@ names can be used:
>  objectmode::
>  	The mode of the object.
>  objecttype::
> -	The type of the object (`blob` or `tree`).
> +	The type of the object (`commit`, `blob` or `tree`).
>  objectname::
>  	The name of the object.
>  objectsize[:padded]::
> -	The size of the object ("-" if it's a tree).
> +	The size of a `blob` object ("-" if it's a `commit` or `tree`).
>  	It also supports a padded format of size with "%(objectsize:padded)".
>  path::
>  	The pathname of the object.

Makes sense.  Indeed we should have updated it when we added
gitlinks to trees.

Will queue.
