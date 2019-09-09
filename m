Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7121F461
	for <e@80x24.org>; Mon,  9 Sep 2019 18:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfIISRq (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 14:17:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55329 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfIISRp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 14:17:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D56B2B3AE;
        Mon,  9 Sep 2019 14:17:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0bTf073SjS8Z
        QifvyuBEMtp6UQM=; b=VrENjqfZ4fi2ZlH1RrcLikRMqVdBIlfnmaD3xO3Oh69M
        mGY2TPGV+wfa96EwsNevI5hhYdDkVfOVnoYbXQueEeYsYRrwF5r494sb4xkS67Qi
        qpc1pwEYYYEBo9wD+NUz5tvX9NIAiFJtKc7ZcBWhC+5Do0sELAz/M2h/0BOPDg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IjxiLa
        dOds5+eB621tBNGz2Tu5q1ZacqOGfTe0O3gxyqKhwJYBdxCPK+fVJnxIViNdqAUG
        S6VluaZEV1EQ/m2R45Pfsgql7XK79N/bXoe6767ZodL3JKamjrUY2h4z3ns0rKsX
        NaFBc9biQ83C2XKYAMNI6KUL3i3E+fFMqAhD8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54AD72B3AD;
        Mon,  9 Sep 2019 14:17:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2B322B3AC;
        Mon,  9 Sep 2019 14:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?Q?=C3=89tienne?= SERVAIS <etienne.servais@voucoux.fr>,
        git@vger.kernel.org,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: Re: [PATCH 1/2] log: test --decorate-refs-exclude with --simplify-by-decoration
References: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
        <37283d4e-3f79-a6b1-425a-f90704fbcce2@web.de>
        <xmqq36ijl6qu.fsf@gitster-ct.c.googlers.com>
        <5de287e9-a8e8-780a-7d39-2229b61914ca@web.de>
        <xmqqh86zjmcg.fsf@gitster-ct.c.googlers.com>
        <64bc5556-b098-7991-b7c2-3483277bb73c@web.de>
        <xmqqwofuia0x.fsf@gitster-ct.c.googlers.com>
        <ea3fed37-a465-6a26-1035-6885015261b7@web.de>
Date:   Mon, 09 Sep 2019 11:17:41 -0700
In-Reply-To: <ea3fed37-a465-6a26-1035-6885015261b7@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 8 Sep 2019 19:58:41 +0200")
Message-ID: <xmqqlfuxjpve.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1D723FBC-D32E-11E9-B78E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Demonstrate that a decoration filter given with --decorate-refs-exclude
> is inadvertently overruled by --simplify-by-decoration.
>
> Reported-by: =C3=89tienne SERVAIS <etienne.servais@voucoux.fr>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  t/t4202-log.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Looks vaguely familiar ;-)  Thanks for resurrecting it.
