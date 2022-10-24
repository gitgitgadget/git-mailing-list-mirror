Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C54FA3741
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiJXU3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiJXU30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:29:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966F62A8A55
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:42:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63DBB1CA2E1;
        Mon, 24 Oct 2022 12:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PcpbHnR2W0Y3SDsrdkPD14Od/hNIKJ1/0NJmll
        cQ9u4=; b=fp+hditXnnnf8fXot0Ykjy210d8Rd25O8IaObfeA1q+Jl0yx+alAWw
        J182PUIyg0Hun6VXZlOzl+Z4A8lpShbtS772rcDnYwCcVFjhY/GDD7I0LWWwkvFo
        6zW9dIMcgR1P8JG9rTAGF6u//jgTp/WGU6+mnT0FLIBrC/nnfjyiw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B5351CA2E0;
        Mon, 24 Oct 2022 12:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 830691CA2DF;
        Mon, 24 Oct 2022 12:57:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] fsck: remove the unused BAD_TAG_OBJECT
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
        <f32ff5dc4eed5bffe8bb0759c408c3d0861ddb50.1666623639.git.gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 09:57:26 -0700
In-Reply-To: <f32ff5dc4eed5bffe8bb0759c408c3d0861ddb50.1666623639.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Mon, 24 Oct 2022 15:00:37
        +0000")
Message-ID: <xmqqwn8ptb0p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0B23FBE-53BC-11ED-A507-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> The BAD_TAG_OBJECT msg-id is not being used anymore, so we can remove
> it.

Do you have a ready reference to the change that made it no longer
needed (or stopped detecting the error the message was meant to be
issued against)?


> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  fsck.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fsck.h b/fsck.h
> index 6f801e53b1d..7d99f6ea337 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -24,7 +24,6 @@ enum fsck_msg_type {
>  	FUNC(BAD_NAME, ERROR) \
>  	FUNC(BAD_OBJECT_SHA1, ERROR) \
>  	FUNC(BAD_PARENT_SHA1, ERROR) \
> -	FUNC(BAD_TAG_OBJECT, ERROR) \
>  	FUNC(BAD_TIMEZONE, ERROR) \
>  	FUNC(BAD_TREE, ERROR) \
>  	FUNC(BAD_TREE_SHA1, ERROR) \
