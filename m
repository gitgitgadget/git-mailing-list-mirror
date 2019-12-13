Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AB8C34983
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDB424804
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qsqH6mVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfLMTwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:52:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54495 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfLMTwy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:52:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB5DD23841;
        Fri, 13 Dec 2019 14:52:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rP6esF6h4rpu
        TSoxxNxNcX1DIDY=; b=qsqH6mVoe9E4Zz/Q8lZPIJ8y+kZtCVQp/vSCTrkZNAuB
        6f4qeLRCpeYVl6zhYrH+CyCYaSta8BKRFcC1Bk5fyhxx5L3i1J9Of5ZrseuJtSQm
        h2ZerLI0AjYWQD0/fr678ghPfvCaj6klmDYZe5X81i6qB+Dq0AGyCaPfRk1wIfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YCzLlD
        SBuAV30ETp51NGT9RUAp6EzEXH/ze0jOn1127h5vBLY7i5mjz0A5cBb2G6Kbqcm8
        Wjc0gzPWnlcNrbkIjEkwvmi5bTkw4kaPK/NBRHpGUCw6PTD6ne/5eFQdJftMAaKY
        VLbUFiFocnKC/gWGgLbHkTsz2tm5Ed/8pbH+Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E353C23840;
        Fri, 13 Dec 2019 14:52:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 523822383F;
        Fri, 13 Dec 2019 14:52:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: reword -B option of diff into something sensible
References: <20191212204655.10425-1-jn.avila@free.fr>
Date:   Fri, 13 Dec 2019 11:52:47 -0800
In-Reply-To: <20191212204655.10425-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
        message of "Thu, 12 Dec 2019 21:46:53 +0100")
Message-ID: <xmqqo8wcj94g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 237E4A14-1DE2-11EA-B7B8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

> The sentence seemed to miss a verb.

Yeah, that is entirely my fault.  What is worse is that the
description is full of overly long sentences.  The result of
applying this patch may be more gramatically correct than the
original, and it might be easier to read than the original, but I
think it is still too hard to understand than it should be.

Perhaps we should consider a total rewrite of the paragraph (no pun
intended).



> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  Documentation/diff-options.txt | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
> index 09faee3b44..350d0a2fb0 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -452,14 +452,14 @@ endif::git-format-patch[]
>  	create. This serves two purposes:
>  +
>  It affects the way a change that amounts to a total rewrite of a file
> -not as a series of deletion and insertion mixed together with a very
> -few lines that happen to match textually as the context, but as a
> -single deletion of everything old followed by a single insertion of
> -everything new, and the number `m` controls this aspect of the -B
> -option (defaults to 60%). `-B/70%` specifies that less than 30% of the
> -original should remain in the result for Git to consider it a total
> -rewrite (i.e. otherwise the resulting patch will be a series of
> -deletion and insertion mixed together with context lines).
> +does not appear as a series of deletion and insertion mixed together
> +with a very few lines that happen to match textually as the context,
> +but as a single deletion of everything old followed by a single
> +insertion of everything new, and the number `m` controls this aspect
> +of the -B option (defaults to 60%). `-B/70%` specifies that less than
> +30% of the original should remain in the result for Git to consider it
> +a total rewrite (i.e. otherwise the resulting patch will be a series
> +of deletion and insertion mixed together with context lines).
>  +
>  When used with -M, a totally-rewritten file is also considered as the
>  source of a rename (usually -M only considers a file that disappeared
