Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE51C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 21:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E91206D4
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 21:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sPfgu6Sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgIPVGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 17:06:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60949 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgIPVGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 17:06:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BD26E6B86;
        Wed, 16 Sep 2020 17:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dkpDKNHrbiZZ0/FvjDpEDsJ4R3c=; b=sPfgu6
        Sgi9KZB8hBRV5AzSBRWBFxe+zLP9PWSQYNbBeVqDBN5zpOEpTxf0eAm3zD2DgFnl
        rm0lhla4g+GU9WXES2UV7H5hGht5HfNz0FkNL0004e/Fe76kSlT1hlZC9ucqGVid
        LkfcZ3EhDabx0N3Q27U8iZc2TbvzGcb9zSmT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ifeIkdIOMrlsosPH3bbt2eVoA6NI2TSy
        eZkn2FKP881ji8crnNPMILCa3HR8ivvhSzkgvOs/fN9ouySyIBfEkhYR1uD0h79/
        GIEv8KgU01YyyL8JaJyg15vSxMDuFJ4FPhY9LBum46qIi72yuoCMtDU/5S9RFiqU
        LaJwXg0Vnqo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94602E6B85;
        Wed, 16 Sep 2020 17:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3626E6B82;
        Wed, 16 Sep 2020 17:05:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] fast-export: avoid using unnecessary language in a
 code comment
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <587ddca42ae36be3d5b333cefe1f9af768bacc9a.1600279853.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 14:05:56 -0700
In-Reply-To: <587ddca42ae36be3d5b333cefe1f9af768bacc9a.1600279853.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 16 Sep 2020
        18:10:49 +0000")
Message-ID: <xmqqbli5whxn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B35F31C-F860-11EA-8969-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In an ongoing effort to avoid non-inclusive language, let's avoid using
> the branch name "master" in a code comment.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/fast-export.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 1b8fca3ee0..5527135ba8 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -1026,7 +1026,7 @@ static void handle_tags_and_duplicates(struct string_list *extras)
>  				/*
>  				 * Getting here means we have a commit which
>  				 * was excluded by a negative refspec (e.g.
> -				 * fast-export ^master master).  If we are
> +				 * fast-export ^HEAD HEAD).  If we are

Obviously good change.  Thanks.

>  				 * referencing excluded commits, set the ref
>  				 * to the exact commit.  Otherwise, the user
>  				 * wants the branch exported but every commit
