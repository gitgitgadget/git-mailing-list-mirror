Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A746DC35240
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F476214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f6pnqeet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgAaU5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:57:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55858 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgAaU5q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:57:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ABD8EACE05;
        Fri, 31 Jan 2020 15:57:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1uowxZ4VyrC5lbJcE/3visZaGDo=; b=f6pnqe
        et9v+J00vz8vnyjxvk8f9dO+vUMcfP+Sq0lSDgpYe+GYG+wyHzTt0bwF8XE1R2aA
        mLLahEAsIufeC90i0gvqI7y2trTzcbBDFJ3eqQfGayNueHqioFU/brpGQjfJBCZ0
        utVDcyrNe7I8wS2ttWobxxozNHF+pDsLCrdLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rjd+xaAV/iMuZbq1OBN3qS9alkd+QLjo
        ik4F4S1orprLmvSaLT/suXGZsShzRZXzZ96HN9KSDIfZH0UX9zIZKIsChZ6EtYdD
        rsaX1FPnHrMwichLTgpyad8k/gobvOUVM8ZYyoYdKVgfkou+wF7ESl3+1Bt11r7c
        0CM1HdxHJmM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A3DD5ACE04;
        Fri, 31 Jan 2020 15:57:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D433FACE01;
        Fri, 31 Jan 2020 15:57:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule foreach: replace $path with $sm_path in example
References: <20200131170843.11130-1-kyle@kyleam.com>
Date:   Fri, 31 Jan 2020 12:57:39 -0800
In-Reply-To: <20200131170843.11130-1-kyle@kyleam.com> (Kyle Meyer's message of
        "Fri, 31 Jan 2020 12:08:43 -0500")
Message-ID: <xmqqblqj9we4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5275F140-446C-11EA-B4DF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> f0fd0dc5c5 (submodule foreach: document '$sm_path' instead of '$path',
> 2018-05-08) updated the documentation to advise callers to favor
> $sm_path over the deprecated synonym $path.  However, the example in
> that section still uses $path.  Update it to use $sm_path.
>
> Signed-off-by: Kyle Meyer <kyle@kyleam.com>

Makes sense.  Thanks for a careful reading.  Will apply.

> ---
>  Documentation/git-submodule.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 5232407f68..218942acd1 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -229,7 +229,7 @@ As an example, the command below will show the path and currently
>  checked out commit for each submodule:
>  +
>  --------------
> -git submodule foreach 'echo $path `git rev-parse HEAD`'
> +git submodule foreach 'echo $sm_path `git rev-parse HEAD`'
>  --------------
>  
>  sync [--recursive] [--] [<path>...]::
