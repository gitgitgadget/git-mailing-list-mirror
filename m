Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9624EC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53208206E9
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lRQVfmN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgGGTTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:19:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54305 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgGGTTr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 15:19:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28750DF1B7;
        Tue,  7 Jul 2020 15:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y9WBoqXy6yoeU+xnX22eQ5fD7mQ=; b=lRQVfm
        N4a316YO5JPhBhJv3IbNAeib0diuF/PjNwP9YGsyTtr0G5Kv18pATsE3j/pnTRB1
        A/8VZSpwfScFnQOji9uNtJR5BDbTFC96csK00uwiK8RQ+SOSvvE5DOzB1VliJh2p
        4new7VVXC5jFVUvyIZkjY2qoPowvnEFNArdYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t6hw6+khEpNXFDB1vR9eUOX5XLa3s/IW
        +NsacVGzCfw6yF45g0mKaMMwVeFYJpGrVsdkr7scBAl95WhCBdS//qK0qzddj72y
        YPR0BPFJaYadf9d+dMu43gKOQV2j91uu1ykGNdPsAmE6UU6fq5v0DbTBx5XQEcFv
        bO5U4z7OCQA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20BD1DF1B6;
        Tue,  7 Jul 2020 15:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 696C5DF1B3;
        Tue,  7 Jul 2020 15:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 2/4] Documentation: clarify 'complete message'
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
        <20200707174049.21714-3-chriscool@tuxfamily.org>
Date:   Tue, 07 Jul 2020 12:19:40 -0700
In-Reply-To: <20200707174049.21714-3-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 7 Jul 2020 19:40:47 +0200")
Message-ID: <xmqqwo3f3zg3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF4FEC98-C086-11EA-9216-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> In Documentation/git-for-each-ref.txt let's clarify what
> we mean by "complete message".
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-for-each-ref.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 2db9779d54..788258c3ad 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -232,8 +232,9 @@ Fields that have name-email-date tuple as its value (`author`,
>  `committer`, and `tagger`) can be suffixed with `name`, `email`,
>  and `date` to extract the named component.
>  
> -The complete message of a commit or tag object is `contents`. This
> -field can also be used in the following ways:
> +The complete message (subject, body, trailers and signature) of a
> +commit or tag object is `contents`. This field can also be used in the
> +following ways:

Hmph, I regret asking what is "complete", i.e. as opposed to what.

The above makes it even unclear if things like "signature on commit"
is part of the complete message.  I _think_ you meant the part after
stripping the object header, so "signature in a signed tag is part
of 'complete message', while signature in a signed commit is not",
which feels somewhat strange.

But then, it may be easier to understand if we said

    The message in a commit or a tag object is `contents`, from
    which `contents:<part>` can be used to extract various parts out
    of.

without introducing "complete".

In any case I think patches 1 & 2 are definite improvement.

Thanks.
