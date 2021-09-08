Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F57C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4296113C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350207AbhIHSvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 14:51:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56722 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349162AbhIHSvj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 14:51:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F66514CCBE;
        Wed,  8 Sep 2021 14:50:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Y4M1oYYzBWHX
        G2/7ZUrRccHC618MglPKOaIylsDmKiw=; b=Qd7i6QWUcCrRa0iD8kC1XtmG4wg6
        h0lkmxrDcuRNaGYb0snh48yg4wJd6HKYInxcvhB+JNNDiIQVZGFbdB9auYpgkITn
        Bi2CvopbX3t1kUQpyhWRYEPfNzvgLPDZP1llhJzBQrwLBbXH7Bk4kGGzIsOvjKts
        vDwFejwQh9EKE0I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17F0914CCBD;
        Wed,  8 Sep 2021 14:50:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 630E014CCBC;
        Wed,  8 Sep 2021 14:50:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, hanwen@google.com
Subject: Re: [PATCH 0/4] fixup for hn/reftable
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <20210908074557.38141-1-carenas@gmail.com>
Date:   Wed, 08 Sep 2021 11:50:26 -0700
In-Reply-To: <20210908074557.38141-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 8 Sep 2021 00:45:53 -0700")
Message-ID: <xmqq8s0652bx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2A151FA-10D5-11EC-ADE4-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> DEVELOPER=3D1 wasn't working well in OpenBSD until cb/makefile-apple-cl=
ang
> (which just hit next), so I missed it in my previous run.
>
> hopefully it is not too late to fix this, otherwise.

I haven't merged them to 'next', so it is easy to accept a
reroll.

> As usual they should apply to the patch they refer to and are based on =
the
> last reroll in seen (tip 1427aef0bd as of e881a4ab6c (Merge branch
> 'hn/reftable' into seen, 2021-09-07)
>
> Except from the last patch (and two other minor refactors I couldn't av=
oid)
> they could all be one single change to move the declaration for the zli=
b
> compat function to some place where it could be visible from the two fi=
les
> that will use it, but it was spread on multiple files to easy autosquas=
hing
>
> Carlo Marcelo Arenas Bel=C3=B3n (4):
>   fixup! reftable: reading/writing blocks
>   fixup! reftable: utility functions
>   fixup! Provide zlib's uncompress2 from compat/zlib-compat.c
>   fixup! reftable: utility functions
>
>  compat/zlib-uncompress2.c |  3 +++
>  reftable/basics.h         |  1 -
>  reftable/block.c          |  9 ---------
>  reftable/system.h         | 10 +++++++++-
>  4 files changed, 12 insertions(+), 11 deletions(-)
