Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B85C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09A42077D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ctixt5Ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGJUYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:24:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55285 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJUYS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 16:24:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97A9AD1F45;
        Fri, 10 Jul 2020 16:24:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=566RTib9VkhxADuwIS8ADpXbBVQ=; b=ctixt5
        IkkhZ99emsN9w4cZrNSWV2GL9BD/zFttp8VSluA8VMMTqoVdG3b9tshVI1qVYjow
        cf8hPyRPCpI+cG0GKILgBGES6iHIYki7DX3deI3tU45CCZhCRVCCXiMDiYetMrD6
        2TZfcZNV//nPZ3Z+lg6MoLXKIRaBIsXXaKvCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pOqxs3/ohmx5z/ZR6jFnXedduV1o405J
        qJnGzUcX0urneqeCaYISwMui5pFNC/xnf1d6YfHYugT4I9ZLX3JNqIzGa90HKiJM
        5B1fYnHZ41KqCZwJRmL7iBeJvPaCWBbduSTm4gjS0vnsEBT6Dj54lYzW8EexUA7v
        /oxFxIsuTDk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90814D1F44;
        Fri, 10 Jul 2020 16:24:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D600BD1F43;
        Fri, 10 Jul 2020 16:24:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 1/3] Documentation: clarify %(contents:XXXX) doc
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
        <20200710164739.6616-1-chriscool@tuxfamily.org>
        <20200710164739.6616-2-chriscool@tuxfamily.org>
Date:   Fri, 10 Jul 2020 13:24:10 -0700
In-Reply-To: <20200710164739.6616-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Fri, 10 Jul 2020 18:47:37 +0200")
Message-ID: <xmqqblknt8yd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50EB3C1A-C2EB-11EA-9940-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Let's avoid a big dense paragraph by using an unordered
> list for the %(contents:XXXX) format specifiers.
>
> While at it let's also make the following improvements:
>
>   - Let's not describe %(contents) using "complete message"
>     as it's not clear what an incomplete message is.
>
>   - Let's improve how the "subject" and "body" are
>     described.
>
>   - Let's state that "signature" is only available for
>     tag objects.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-for-each-ref.txt | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Looking good.  Thanks.


> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 6dcd39f6f6..b739412c30 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -232,12 +232,24 @@ Fields that have name-email-date tuple as its value (`author`,
>  `committer`, and `tagger`) can be suffixed with `name`, `email`,
>  and `date` to extract the named component.
>  
> -The complete message in a commit and tag object is `contents`.
> -Its first line is `contents:subject`, where subject is the concatenation
> -of all lines of the commit message up to the first blank line.  The next
> -line is `contents:body`, where body is all of the lines after the first
> -blank line.  The optional GPG signature is `contents:signature`.  The
> -first `N` lines of the message is obtained using `contents:lines=N`.
> +The message in a commit or a tag object is `contents`, from which
> +`contents:<part>` can be used to extract various parts out of:
> +
> +contents:subject::
> +	The first paragraph of the message, which typically is a
> +	single line, is taken as the "subject" of the commit or the
> +	tag message.
> +
> +contents:body::
> +	The remainder of the commit or the tag message that follows
> +	the "subject".
> +
> +contents:signature::
> +	The optional GPG signature of the tag.
> +
> +contents:lines=N::
> +	The first `N` lines of the message.
> +
>  Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
>  are obtained as `trailers` (or by using the historical alias
>  `contents:trailers`).  Non-trailer lines from the trailer block can be omitted
