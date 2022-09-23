Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F161BC6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 15:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiIWPzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiIWPzf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 11:55:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438EC12C697
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 08:55:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E7E3142EBE;
        Fri, 23 Sep 2022 11:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5o8Fjwjjc3SK82OCuSWGkT711vE9379cB4VjUV
        VdoW0=; b=h+P68njy8qLv0ZTnpvPuZ4rpz1Nm/+BQzokcMYJEGJcvtbcss8qMMs
        H0dipdlohW0HJCnjXHszxbHfB36rFz0DDyIpRhL3a5/Z43knc6mYkBKDVV+OhFqn
        BcQDPc8mJetzR6IL8VTnD8N7VMFxQOr3s7HtX8ZS2RU1wzgHV5uKs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96E92142EBD;
        Fri, 23 Sep 2022 11:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDE42142EBC;
        Fri, 23 Sep 2022 11:55:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, chakrabortyabhradeep79@gmail.com,
        me@ttaylorr.com, kaartic.sivaraam@gmail.com
Subject: Re: [PATCH] pack-bitmap: improve grammar of "xor chain" error message
References: <20220922025158.415969-1-alexhenrie24@gmail.com>
Date:   Fri, 23 Sep 2022 08:55:24 -0700
In-Reply-To: <20220922025158.415969-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 21 Sep 2022 20:51:58 -0600")
Message-ID: <xmqqv8pew0er.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23AB52FC-3B58-11ED-B51F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  pack-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 9a208abc1f..9d5205055a 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -723,7 +723,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>  		ALLOC_GROW(xor_items, xor_items_nr + 1, xor_items_alloc);
>  
>  		if (xor_items_nr + 1 >= bitmap_git->entry_count) {
> -			error(_("corrupt bitmap lookup table: xor chain exceed entry count"));
> +			error(_("corrupt bitmap lookup table: xor chain exceeds entry count"));

Thanks.  This will affect the l10n team, and the change is obviously
innocuous, so let's merge it down immediately to the 'master' branch
to make the life of l10n team more predictable.

