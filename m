Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751B0C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 18:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489B82078B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 18:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NlpQAKW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389632AbgDBSHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:07:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51279 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389205AbgDBSHY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 14:07:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADE14CC051;
        Thu,  2 Apr 2020 14:07:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9DMlE3BMmlRR
        qbA49ya3Q59yHZA=; b=NlpQAKW3LW2+QZDDwFNGHJxZQaLuokcYusPwdRL1WkY1
        Tg6VzwHENtIru3hHn6494rfVSC1Pq4Yt2unH/vDfsdhdUQAExODwCCFGgpIuk3+v
        1IHAyLU2lwZHzxyg+XUDm2QRjwpgwZOKWbj/haa434GgtOyEOqVAnBTfOC9UFiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Eoi4ov
        AbYkv38cOiQBbRbhrGWrShqI2jCWhbQW8uDH/L2UwH2dV0ijDGquTLWsS0Quab1d
        PGXCs1dVyXPH3u/vZrvu6xSnDizNsVJ4OmNGmR5jKW1q42hMPUxrBRNidgxjzOlp
        1aFbbscbS2w82QD0IKL1UzIuuG/srzqdfSKic=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EB99CC050;
        Thu,  2 Apr 2020 14:07:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C8752CC04F;
        Thu,  2 Apr 2020 14:07:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] Documentation: document merge option --no-gpg-sign
References: <20200331064456.GA15850@danh.dev>
        <cover.1585821581.git.congdanhqx@gmail.com>
        <d35dd89c52e427861c38d17e43c61fca149dbfd5.1585821581.git.congdanhqx@gmail.com>
Date:   Thu, 02 Apr 2020 11:07:19 -0700
In-Reply-To: <d35dd89c52e427861c38d17e43c61fca149dbfd5.1585821581.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Thu, 2 Apr
 2020 17:15:34 +0700")
Message-ID: <xmqqo8s93go8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CBDA58C0-750C-11EA-9EB3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  Documentation/merge-options.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
> index 40dc4f5e8c..c46e4fe598 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -61,9 +61,12 @@ When not possible, refuse to merge and exit with a n=
on-zero status.
> =20
>  -S[<keyid>]::
>  --gpg-sign[=3D<keyid>]::
> +--no-gpg-sign::
>  	GPG-sign the resulting merge commit. The `keyid` argument is
>  	optional and defaults to the committer identity; if specified,
> -	it must be stuck to the option without a space.
> +	it must be stuck to the option without a space. "--no-gpg-sign"
> +	is useful to countermand both `commit.gpgSign` configuration variable=
,
> +	and earlier "--gpg-sign".

Shouldn't [4/5] also add '--no-gpg-sign' to the header like the
above?

Other than that, all patches were pleasant read.
Thanks.
