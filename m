Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFDFC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 04:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47ED3611CC
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 04:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbhKRE4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 23:56:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61252 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbhKRE4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 23:56:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 846F5173DC1;
        Wed, 17 Nov 2021 23:53:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=9IPgButPVtEnSWoa0zKSWcmaK
        dxXXqISMRUKlNOIGZw=; b=la2Fbcmly2l1Xc973SDM2YAwNQjxj2Usj0oExu0Rh
        R+frbfxDB3vV47bFMGakAVRd2v4p35+mRbRoIiXUMxZk/FPtAaezZJFyk4cds8zY
        VnL0uyiZh1xkGQ1TTZSxVU5vhypUir7CPIY8VTdl9BUzRJ5P0SaPr6ETH9nRCg9H
        kI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 704CF173DC0;
        Wed, 17 Nov 2021 23:53:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C1994173DBF;
        Wed, 17 Nov 2021 23:53:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 2/8] receive-pack: lowercase error messages
References: <20211113033358.2179376-1-andersk@mit.edu>
        <20211113033358.2179376-3-andersk@mit.edu>
Date:   Wed, 17 Nov 2021 20:53:38 -0800
Message-ID: <xmqqwnl612ul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F4B9B2E-482B-11EC-ADBB-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> Documentation/CodingGuidelines says =E2=80=9Cdo not end error messages =
with a
> full stop=E2=80=9D and =E2=80=9Cdo not capitalize the first word=E2=80=9D=
.  Reviewers requested
> updating the existing messages to comply with these guidelines prior to
> the following patches.

The same comment applies to this part.  Reviewers may make
suggestion to help polish the topic, but it ultimately is the
author's achievement.  More importantly, we write our log messages
to help future developers to learn from.  The fact somebody asked
some changes made is much less important than the reason why such
changes are desirable, so that they can craft their future topics
following the same pattern.

    Documentation... says X and Y.  Clean up existing messages, some
    of which we will be touching in later steps in the series, that
    deviate from these rules in this file, as a preparation for the
    main part of the topic.

may convey the intention better, I would think.

The patch text looks good.  Thanks.

> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  builtin/receive-pack.c          | 6 +++---
>  t/t5504-fetch-receive-strict.sh | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 2d1f97e1ca..a82b60f387 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -170,7 +170,7 @@ static int receive_pack_config(const char *var, con=
st char *value, void *cb)
>  			strbuf_addf(&fsck_msg_types, "%c%s=3D%s",
>  				fsck_msg_types.len ? ',' : '=3D', var, value);
>  		else
> -			warning("Skipping unknown msg id '%s'", var);
> +			warning("skipping unknown msg id '%s'", var);
>  		return 0;
>  	}
> =20
> @@ -1584,9 +1584,9 @@ static const char *update(struct command *cmd, st=
ruct shallow_info *si)
>  		if (!parse_object(the_repository, old_oid)) {
>  			old_oid =3D NULL;
>  			if (ref_exists(name)) {
> -				rp_warning("Allowing deletion of corrupt ref.");
> +				rp_warning("allowing deletion of corrupt ref");
>  			} else {
> -				rp_warning("Deleting a non-existent ref.");
> +				rp_warning("deleting a non-existent ref");
>  				cmd->did_not_exist =3D 1;
>  			}
>  		}
> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-st=
rict.sh
> index 6e5a9c20e7..b0b795aca9 100755
> --- a/t/t5504-fetch-receive-strict.sh
> +++ b/t/t5504-fetch-receive-strict.sh
> @@ -292,7 +292,7 @@ test_expect_success 'push with receive.fsck.missing=
Email=3Dwarn' '
>  		receive.fsck.missingEmail warn &&
>  	git push --porcelain dst bogus >act 2>&1 &&
>  	grep "missingEmail" act &&
> -	test_i18ngrep "Skipping unknown msg id.*whatever" act &&
> +	test_i18ngrep "skipping unknown msg id.*whatever" act &&
>  	git --git-dir=3Ddst/.git branch -D bogus &&
>  	git --git-dir=3Ddst/.git config --add \
>  		receive.fsck.missingEmail ignore &&
