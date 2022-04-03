Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196E8C433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 22:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357793AbiDCWbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 18:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353009AbiDCWbS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 18:31:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8864325C4D
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 15:29:22 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D533A11D64F;
        Sun,  3 Apr 2022 18:29:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DKGj8jWZ6G/p
        YNdiasP4iUU/6C1azJ1AmT1WP4NZFOE=; b=Hi/T8QxX2AgJyqu6K6GJ7OVrGp8X
        P43AEy5WwY7Pmz42lsEq397uEkAiLeSS5SVJRekD5du3blcGvDIzzqrNQV7HFbfU
        mQ2isD54/D9SL3iawv14BTR4GCqeVM7c2SbAL9hGo2QivYZRIqrXgC+OmV2wTOVL
        BEDVqx1gXwruMKA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC3B611D64E;
        Sun,  3 Apr 2022 18:29:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43E1211D64B;
        Sun,  3 Apr 2022 18:29:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 5/6] i18n: factorize read-cache error messages
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
        <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
        <1888778902aa1d0d2cf118cfb7fe4b2e407953c6.1648915853.git.gitgitgadget@gmail.com>
Date:   Sun, 03 Apr 2022 15:29:18 -0700
In-Reply-To: <1888778902aa1d0d2cf118cfb7fe4b2e407953c6.1648915853.git.gitgitgadget@gmail.com>
        (=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Sat,
 02 Apr 2022
        16:10:52 +0000")
Message-ID: <xmqqlewlu7gh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 80C04C24-B39D-11EC-8CA7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  read-cache.c     | 8 ++++----
>  t/t1600-index.sh | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 1ad56d02e1d..639765e8ff1 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1735,8 +1735,8 @@ static unsigned int get_index_format_default(stru=
ct repository *r)
>  		if (r->settings.index_version >=3D 0)
>  			version =3D r->settings.index_version;
>  		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
> -			warning(_("index.version set, but the value is invalid.\n"
> -				  "Using version %i"), INDEX_FORMAT_DEFAULT);
> +			warning(_("'%s' set, but the value is invalid.\n"
> +				  "Using version %i"), "index.version", INDEX_FORMAT_DEFAULT);
>  			return INDEX_FORMAT_DEFAULT;

Not the focus of this patch, which (I am guessing without the log
message) is to prevent translators from touching the constant
'index.version' by mistake, but I wonder if the message is helpful
to users.  When I see such a warning, how would I figure out what
to fix so that I do not have to see the same warning again?

We should somehow at least hint that we are talking about an entry
in .git/config file (or it may be coming ~/.gitconfig by mistake, in
which case telling where we see a funny version string does help the
user even more).

At least, telling that index.version is a configuration variable may
nudge the user in the right direction, or is it too obvious and
everybody who touches Git instinctively know when told that their
qfwfq.zfzfz is set to an incorrect value, we are referring to their
configuration variable?  I dunno.

> @@ -1745,8 +1745,8 @@ static unsigned int get_index_format_default(stru=
ct repository *r)
>  	version =3D strtoul(envversion, &endp, 10);
>  	if (*endp ||
>  	    version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
> -		warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
> -			  "Using version %i"), INDEX_FORMAT_DEFAULT);
> +		warning(_("'%s' set, but the value is invalid.\n"
> +			  "Using version %i"), "GIT_INDEX_VERSION", INDEX_FORMAT_DEFAULT);

Likewise, but this is for an envirionment variable.

	The environment variable '%s' set, but the value is invalid.

may be overkill and more importantly makes it impossible to reuse
the previous message, but the latter may be an improvement.
configuration and environment variables may have different
gramatical gender or something, perhaps.



