Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D81C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 18:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596CC207C4
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 18:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dfqa2Xn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgI0SPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 14:15:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62113 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgI0SPh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 14:15:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B669D83330;
        Sun, 27 Sep 2020 14:15:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1MlFsINm9siW
        yeFdvHnA5J/eJzw=; b=Dfqa2Xn4bk+dG6VyvmyarYb331WDzJaJk8VfibKyNmJ7
        11wogrbnoDoSQR4ZPB0NfsAbGxHo6WfjUt+ttUNrVbqB/Qmb6qpdAgiTOtbFb8IX
        8+URENPvIHdw1+vYNmDmTIUUf2g0F9FX8Bj3yUH2Q16ytK2dhR+vNIR+iRER7xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Zcv0yk
        4l/mBN7OMytJ+P/fu7EqCwJYqDhws0+w/uTP5S+kM2VSJACWgb0f0/fRMYK2NP8w
        avuRLpM+nMlv1zHpw5dDFvyeuqArtGpW+lma95UzuXqIVzyafDaoLg+ZG+1UdJoq
        lVLHp6HxtfR/cAIqcHTLWlYxg9gAlL2/wbaSU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A22CC8332D;
        Sun, 27 Sep 2020 14:15:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 209A18332C;
        Sun, 27 Sep 2020 14:15:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config/fmt-merge-msg.txt: drop space in quote
References: <20200927140045.9668-1-martin.agren@gmail.com>
Date:   Sun, 27 Sep 2020 11:15:34 -0700
In-Reply-To: <20200927140045.9668-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sun, 27 Sep 2020 16:00:45 +0200")
Message-ID: <xmqqk0wfgk6x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7003E904-00ED-11EB-B679-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> We document how `merge.suppressDest` can be used to omit " into <branch
> name>" from the title of the merge message. It is true that we omit the
> space character before "into", but that lone double quote character
> risks ending up on the wrong side of a line break, looking a bit out of
> place. This currently happens with, e.g., 80-character terminals.

The above correctly describes why the current text is written the
way it is.  The rationale for the change described above looks quite
sensible.

Thanks.


>
> Drop that leading quoted space. The result should be just as clear abou=
t
> how this option affects the formatted message.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  On jc/fmt-merge-msg-suppress-destination.
>
>  Documentation/config/fmt-merge-msg.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/config/fmt-merge-msg.txt b/Documentation/con=
fig/fmt-merge-msg.txt
> index a8e8f74d0a..3fbf40e24f 100644
> --- a/Documentation/config/fmt-merge-msg.txt
> +++ b/Documentation/config/fmt-merge-msg.txt
> @@ -13,7 +13,7 @@ merge.suppressDest::
>  	By adding a glob that matches the names of integration
>  	branches to this multi-valued configuration variable, the
>  	default merge message computed for merges into these
> -	integration branches will omit " into <branch name>" from
> +	integration branches will omit "into <branch name>" from
>  	its title.
>  +
>  An element with an empty value can be used to clear the list
