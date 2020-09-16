Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B62C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19AF206CA
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x/es+bPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgIPWNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:13:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61459 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIPWNv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 18:13:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94CBAE8D37;
        Wed, 16 Sep 2020 17:15:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6TLXN/dtjDlr
        tF1Ae7zQvXyp/C8=; b=x/es+bPxE+oFoxlJ4PyW6+z9pw4l3a0f/Ycc8XijAEld
        sqYKRozV9biNgEa/c8QdVXaUDcWC902WCktgqrd6JQu+TgZSBy3Ico3av6SEJegw
        3/M/xpgPsDBZTA9DyWxB8K/boINzaBDFWhLB41C7jc4x/nrfSSqPmu8vOS2lfi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uSa3fp
        rz+t+JJBEan7ru+wKNXgSkzBFYBvg3J9RDpHt7k8BvP7MCBhOLY54Ve5sI14PUqh
        w697OacELrakss91R7xmfOp12ZKfXN7wfofN4GdHFDFQMRJQ8RCP1BIS9MgrWRs3
        VYZf5VzkIBNfbp+REeE/FqpNE0oMGkn06Guyw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B421E8D36;
        Wed, 16 Sep 2020 17:15:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB6FAE8D34;
        Wed, 16 Sep 2020 17:15:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Subject: Re: [PATCH 09/15] remote-mediawiki tests: use "$dir/" instead of
 "$dir."
References: <20200916102918.29805-1-avarab@gmail.com>
        <20200916102918.29805-10-avarab@gmail.com>
Date:   Wed, 16 Sep 2020 14:15:00 -0700
In-Reply-To: <20200916102918.29805-10-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 16 Sep 2020 12:29:12 +0200")
Message-ID: <xmqqwo0tv2y3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AEE29880-F861-11EA-B195-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change UI messages to use "$dir/" instead of "$dir.". I think this is
> less confusing.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  contrib/mw-to-git/t/test-gitmw-lib.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/=
t/test-gitmw-lib.sh
> index a466be8f3f..aa04ebfd0f 100755
> --- a/contrib/mw-to-git/t/test-gitmw-lib.sh
> +++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
> @@ -343,10 +343,10 @@ wiki_install () {
>  			"http://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/"\
>  			"$MW_FILENAME. "\
>  			"Please fix your connection and launch the script again."
> -		echo "$MW_FILENAME downloaded in $(pwd). "\
> +		echo "$MW_FILENAME downloaded in $(pwd)/ "\
>  			"You can delete it later if you want."

"$(pwd)/." to keep the full-stop of the first sentence?

>  	else
> -		echo "Reusing existing $MW_FILENAME downloaded in $(pwd)."
> +		echo "Reusing existing $MW_FILENAME downloaded in $(pwd)/"
>  	fi
>  	archive_abs_path=3D$(pwd)/$MW_FILENAME
>  	cd "$WIKI_DIR_INST/$WIKI_DIR_NAME/" ||
