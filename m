Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0BEC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 18:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F0461108
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 18:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhDHSXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 14:23:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57324 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhDHSXM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 14:23:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D3619115590;
        Thu,  8 Apr 2021 14:23:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iH62TPBo80i+
        knBuw65ResK5EcM=; b=E4drteHj5tbjTl8D0rNmNXAtHex4KFNb5vXL/Xz6CWzv
        GTSN+AKm7xIhxhpXU5ylfBnhxdT84AkjpVfuplmLOsvLXZLmR4koaW1z7iaN9EmT
        a8QcPl5d8NtCRSZzHO5IHs06e2qgS1KNKQytQwPjNwQ2q7KrfX8Br00+EiWf6K4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ahdoro
        tXBuveFJ58EArXRkck9uxEKPYXwET3CuPoinaS94cS/UB1gTLrslDzMgnGgBgRmG
        miQabcJR6V1G+hMt+xf3bUtQiTSJMw7iEa9Iu/y8mHZPgP7VyKvjuIJRs8A5zWwL
        AsIexQCzv3DCZHAbJD+nBQ3OGMZvPP43ITX34=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC1FF11558E;
        Thu,  8 Apr 2021 14:23:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6FC411558D;
        Thu,  8 Apr 2021 14:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 3/5] git-config: document --bool-or-str and
 --type=bool-or-str
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
        <patch-3.6-8aa59b3118-20210408T133125Z-avarab@gmail.com>
Date:   Thu, 08 Apr 2021 11:22:56 -0700
In-Reply-To: <patch-3.6-8aa59b3118-20210408T133125Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 8 Apr
 2021 15:34:27 +0200")
Message-ID: <xmqqeefktz3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 71AD3C46-9897-11EB-BDCB-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Document the new "bool-or-str" facility added in
> dbd8c09bfe (mergetool: allow auto-merge for meld to follow the
> vim-diff behavior, 2020-05-07).
>
> Unfortunately that commit also added a --bool-or-str option, even
> though we've preferred to deprecate that form ever since
> fb0dc3bac1 (builtin/config.c: support `--type=3D<type>` as preferred
> alias for `--<type>`, 2018-04-18).
>
> Since we've got it already let's document it along with the preferred
> --type=3D* form, and change our own code to use the --type=3Dbool-or-st=
r
> form over --bool-or-str.

It was a mistake to introduce a new option that is immediately
deprecated X-<.

Thanks for spotting and correcting.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/git-config.txt | 3 +++
>  mergetools/meld              | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.tx=
t
> index 4b4cc5c5e8..4ae9ef210c 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -187,6 +187,8 @@ Valid `<type>`'s include:
>    1073741824 upon input.
>  - 'bool-or-int': canonicalize according to either 'bool' or 'int', as =
described
>    above.
> +- 'bool-or-str: canonicalize according to either 'bool' (as described
> +  above), or emit the value as-is.
>  - 'path': canonicalize by adding a leading `~` to the value of `$HOME`=
 and
>    `~user` to the home directory for the specified user. This specifier=
 has no
>    effect when setting the value (but you can use `git config section.v=
ariable
> @@ -202,6 +204,7 @@ Valid `<type>`'s include:
>  --bool::
>  --int::
>  --bool-or-int::
> +--bool-or-str::
>  --path::
>  --expiry-date::
>    Historical options for selecting a type specifier. Prefer instead `-=
-type`
> diff --git a/mergetools/meld b/mergetools/meld
> index aab4ebb935..8386e0574e 100644
> --- a/mergetools/meld
> +++ b/mergetools/meld
> @@ -59,7 +59,7 @@ check_meld_for_features () {
>  	if test -z "$meld_use_auto_merge_option"
>  	then
>  		meld_use_auto_merge_option=3D$(
> -			git config --bool-or-str mergetool.meld.useAutoMerge
> +			git config --type=3Dbool-or-str mergetool.meld.useAutoMerge
>  		)
>  		case "$meld_use_auto_merge_option" in
>  		true | false)
