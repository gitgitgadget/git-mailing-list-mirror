Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A442CC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 16:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiGOQx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 12:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiGOQxw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 12:53:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D667DED0
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:53:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A62511A8A64;
        Fri, 15 Jul 2022 12:53:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=b8W7FwOEprTs
        10JcZgIBW7+fclg3BZlm9D5wj8nAT5M=; b=PG7O32pcDqo3OfKsnnThpZW05tQb
        yqb/ANzHfnTAhT2EvwlN8uPS/tBvyXrGCMS6wpbjX2dhx9icO8WgfduJ2dwrl19G
        81/Im+7Twuy91Gbf1VF855CYU4V0jXXLCBd2WwXd/lz2ohuszaEAZ9L01bIDeOn/
        aSdRJBICVMcLqSI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F6421A8A63;
        Fri, 15 Jul 2022 12:53:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4D9D31A8A62;
        Fri, 15 Jul 2022 12:53:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-repack doc: remove discussion of ancient caveat
References: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
Date:   Fri, 15 Jul 2022 09:53:46 -0700
In-Reply-To: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 15 Jul
 2022 09:51:28 +0200")
Message-ID: <xmqqsfn21fmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B1B6A6FE-045E-11ED-A2B0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The backwards compatibility caveat discussed her hasn't been a concern
> for anyone after Git v1.6.0. Let's simply remove it, I daresay
> nobody's concerned these days with having git clients running older
> than 2008-era git.

For the purpose of this message, Git 1.6.0 has no significance.
Anything newer than 1.4.4 should be able to understand packfiles
that use delta-base-offset, even though they may not have used
delta-base-offset when writing a new one.

That's all academic.  I wouldn't have written the above if the
proposed log message stopped here.  But with the rest of proposed
log message that hints that the above statement is backed by a solid
study of history, it is wrong to write a wrong version number there.

I agree that it is safe to say that anything before Git 2.0.0 is
irrelevant at this point (I would actually say before Git 2.16.0,
i.e. anything older than 3-4 years).

> See b6945f570ac (git-repack: repo.usedeltabaseoffset, 2006-10-13) and
> 9f17688d93c (update git-repack documentation wrt
> repack.UseDeltaBaseOffset, 2010-02-04) for the commits that previously
> introduced and adjusted this documentation.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/git-repack.txt | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.tx=
t
> index 0bf13893d81..fe1eac37090 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -218,16 +218,6 @@ CONFIGURATION
>  Various configuration variables affect packing, see
>  linkgit:git-config[1] (search for "pack" and "delta").
> =20
> -By default, the command passes `--delta-base-offset` option to
> -'git pack-objects'; this typically results in slightly smaller packs,
> -but the generated packs are incompatible with versions of Git older th=
an
> -version 1.4.4. If you need to share your repository with such ancient =
Git
> -versions, either directly or via the dumb http protocol, then you
> -need to set the configuration variable `repack.UseDeltaBaseOffset` to
> -"false" and repack. Access from old Git versions over the native proto=
col
> -is unaffected by this option as the conversion is performed on the fly
> -as needed in that case.
> -
>  Delta compression is not used on objects larger than the
>  `core.bigFileThreshold` configuration variable and on files with the
>  attribute `delta` set to false.
