Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B925C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 21:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiANVwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 16:52:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58037 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiANVwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 16:52:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6A90113471;
        Fri, 14 Jan 2022 16:52:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UfAYaLKwdEnr
        txfjrzmoHtu8GnGcATN3vhF/XBCp59s=; b=As5aHH+P0Q4UEPulomjL6ssWgLIP
        1LtBx5cOWXRjFcQmKgPf2E41WtIc/bZJzmQ6HTV+oW3YTRb9Qvrg/WTyQuKJoC13
        U1xV4+oR27XogY6Bd+8RAsBVABl16KWBRazKaj4ZDCqZsZTUbd7kZwEVZVhBZHPv
        NJ0zARP+P7SOckQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEEDE113470;
        Fri, 14 Jan 2022 16:52:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3052D11346E;
        Fri, 14 Jan 2022 16:52:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
References: <cover.1642129840.git.dyroneteng@gmail.com>
        <xmqqfspqeun5.fsf@gitster.g>
        <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
        <xmqqbl0eaw2e.fsf@gitster.g>
        <220114.86y23iqbbk.gmgdl@evledraar.gmail.com>
Date:   Fri, 14 Jan 2022 13:52:11 -0800
In-Reply-To: <220114.86y23iqbbk.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 14 Jan 2022 21:57:33 +0100")
Message-ID: <xmqqo84e9e9g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3B44C3C0-7584-11EC-9520-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> But when GNU came around its option parser was generally happy to acc=
ept
>>> options and args in either order. E.g. these both work with GNU
>>> coreutils, but the latter will fail on FreeBSD and various other
>>> capital-U UNIX-es:
>>>
>>>     touch foo; rm -v foo
>>>     touch foo; rm foo -v
>
> This is only an approximate list, but:

Don't waste your time on this, and instead spend on something more
useful.  What I gave wrt gitcli.txt in an earlier message is final.
