Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E890C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 04:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 101F761D9E
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 04:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhF2EzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 00:55:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64939 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhF2EzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 00:55:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8C2CC6645;
        Tue, 29 Jun 2021 00:52:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=KGMhuhuY5TrmlXCzRd16NLoEV
        gVsxKCWHz+7xqGrHp8=; b=HhcQjBWOg6tCHglraocaLzxHV8oNJHW74g9PmA/PK
        pyperLxLQDAOeX3ofdVhGrsTSlnH3MJwH6RU65F9xq5sqaXJxyZbiAU+Ekjo+r8X
        4PQ1R1aEgd6V0zE7271miXWageAthtA2Ht+HBu4fM6suGgl1mybLS2EaWxyItFLy
        ww=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E4A5C6643;
        Tue, 29 Jun 2021 00:52:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15E91C6642;
        Tue, 29 Jun 2021 00:52:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/3] bundle doc: rewrite the "DESCRIPTION" section
References: <patch-1.1-bc6a6d8922-20210607T165507Z-avarab@gmail.com>
        <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
        <patch-1.3-2824133f423-20210624T193730Z-avarab@gmail.com>
Date:   Mon, 28 Jun 2021 21:52:37 -0700
Message-ID: <xmqqwnqdz2zu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D3DBF50E-D895-11EB-90CD-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +Create, unpack, and manipulate "bundle" files. Bundles are used for
> +the "offline" transfer of Git objects without an active "server"
> +sitting on the other side of the network connection.
> +
> +They can be used to create both incremental and full backups of a
> +repository, and to relay the state of the references in one repository
> +to another.
> +
> +Other git commands that understand protocols such as `ssh://` and
> +`https://` can also operate on bundle files. It is possible

I'd rather drop "Other", especially given that it is irrelevant if
"git bundle" understands "<scheme>://" or not.  Instead, I'd somehow
limit the "git commands" to those that are meant to "read" from the
other side.

IOW, "git push git.bndl master" would not make sense (yet).

Thanks.
