Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AFFC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121E760241
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhEKUvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:51:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64449 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhEKUvq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:51:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 870D5C3C20;
        Tue, 11 May 2021 16:50:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9svsjgmDCL+08+FNdryTLd+BKUKfPVmxXmykwx
        vKf0s=; b=q5FGwURggogAtaX7QvdAo+lb6y1u9/TEypz5KPkdsqrUAZDpFbEQbi
        3zSQVyNRo4TKdkjyCEmM+5tQ7bKCTtADq1nrTbLZbZ9Oxp3JropOboXT/i5dX7dd
        3hPQQCEop7xmNKzetArqeBlfFQv1AuouOUYNwPKbQpKoJM1b6guls=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FE26C3C1F;
        Tue, 11 May 2021 16:50:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12944C3C1E;
        Tue, 11 May 2021 16:50:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v2] packfile-uri.txt: fix blobPackfileUri description
References: <xmqq4kffy224.fsf@gitster.g>
        <20210511064554.59924-1-dyroneteng@gmail.com>
Date:   Wed, 12 May 2021 05:50:37 +0900
In-Reply-To: <20210511064554.59924-1-dyroneteng@gmail.com> (Teng Long's
        message of "Tue, 11 May 2021 14:45:54 +0800")
Message-ID: <xmqqpmxxknaa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A5BA436-B29A-11EB-A826-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Fix the 'uploadpack.blobPackfileUri' description in packfile-uri.txt
> and the correct format also can be seen in t5702.
>
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>>As for the commit message, limit the title to 50 characters or fewer if
>>possible. Maybe something like "packfile-uri.txt: fix blobPackfileUri
>>description" or something like that.
>
> Thanks for mention this, "packfile-uri.txt: fix blobPackfileUri
> description" is good and meets the "50 characters" requirement. So the
> title is modified. 
>
>>Also in the commit message, maybe mention that the correct format can be
>>seen in t5702.
>
> Because I am implementing another patch[1] about supporting the commit
> object in packfile-uri, I noticed the `configure_exclusion` function in
> t5702, which is now mentioned in the commit message.
>
> [1]https://public-inbox.org/git/20210507021140.31372-1-dyroneteng@gmail.com
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---

It seems that the above needs a bit more polishing?

I am not sure if moving the sign-off higher and inserting a
three-dash line before "Jonathan Tan writes" would be sufficient,
but with everything under that quoted material does not seem to
belong to a proposed commit log message proper.

Thanks.

>  Documentation/technical/packfile-uri.txt | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
> index f7eabc6c76..1eb525fe76 100644
> --- a/Documentation/technical/packfile-uri.txt
> +++ b/Documentation/technical/packfile-uri.txt
> @@ -35,13 +35,14 @@ include some sort of non-trivial implementation in the Minimum Viable Product,
>  at least so that we can test the client.
>  
>  This is the implementation: a feature, marked experimental, that allows the
> -server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
> -<uri>` entries. Whenever the list of objects to be sent is assembled, all such
> -blobs are excluded, replaced with URIs. As noted in "Future work" below, the
> -server can evolve in the future to support excluding other objects (or other
> -implementations of servers could be made that support excluding other objects)
> -without needing a protocol change, so clients should not expect that packfiles
> -downloaded in this way only contain single blobs.
> +server to be configured by one or more `uploadpack.blobPackfileUri=
> +<object-hash> <pack-hash> <uri>` entries. Whenever the list of objects to be
> +sent is assembled, all such blobs are excluded, replaced with URIs. As noted
> +in "Future work" below, the server can evolve in the future to support
> +excluding other objects (or other implementations of servers could be made
> +that support excluding other objects) without needing a protocol change, so
> +clients should not expect that packfiles downloaded in this way only contain
> +single blobs.
>  
>  Client design
>  -------------
