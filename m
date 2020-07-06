Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1937DC433DF
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 21:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3ABD206B6
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 21:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kHpAaxww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgGFVew (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:34:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63803 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgGFVew (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 17:34:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39F2ED6274;
        Mon,  6 Jul 2020 17:34:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qPyrHlsFuGZxCo/6lfG+UcaQbUk=; b=kHpAax
        wwNcVwIxc/EYiNvKt1sSi/MsljnOMFiCFTbTbcL6kbryQ0HbTQ0iY/AK08mWRQTh
        mHmYz8e7wBretpUAaRkeiL2rW/ix/WqhUVFb2DazkD2m2Wrw1AxPEcMI/1WnVz/l
        fZnDSxwSQu80QSNHdcFSNse6f2xZDz92tzxl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iiinn53eAp4zDxj+z4vp//h4k07QezAX
        QSbIrDCtV5f/SLEpw96sn2qTJ1bOsYmbp0vVjwg4yGVr33Pr47Fs0Au0SLytIl9o
        fGR3mJmJWgtIUNowZLBiGW1gxVJ/Lxt86aCmgYJePNK+BS28SUJYc3DrymbLrv5K
        Pj4MsgP8DII=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31E49D6273;
        Mon,  6 Jul 2020 17:34:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C2DBD6271;
        Mon,  6 Jul 2020 17:34:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/2] Documentation: clarify %(contents:XXXX) doc
References: <20200702140845.24945-1-chriscool@tuxfamily.org>
        <20200702140845.24945-2-chriscool@tuxfamily.org>
Date:   Mon, 06 Jul 2020 14:34:44 -0700
In-Reply-To: <20200702140845.24945-2-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 2 Jul 2020 16:08:44 +0200")
Message-ID: <xmqqa70c9vkb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 834D9D2E-BFD0-11EA-BE53-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Let's avoid a big dense paragraph by using an unordered
> list for the %(contents:XXXX) format specifiers.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-for-each-ref.txt | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Nice.
Will queue.  Thanks.

>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 6dcd39f6f6..2db9779d54 100644
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
> +The complete message of a commit or tag object is `contents`. This
> +field can also be used in the following ways:
> +
> +contents:subject::
> +	The "subject" of the commit or tag message.  It's actually the
> +	concatenation of all lines of the commit message up to the
> +	first blank line.
> +
> +contents:body::
> +	The "body" of the commit or tag message.  It's made of the
> +	lines after the first blank line.
> +
> +contents:signature::
> +	The optional GPG signature.
> +
> +contents:lines=N::
> +	The first `N` lines of the message.
> +
>  Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
>  are obtained as `trailers` (or by using the historical alias
>  `contents:trailers`).  Non-trailer lines from the trailer block can be omitted
