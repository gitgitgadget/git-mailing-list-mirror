Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD6C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31832610EA
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhDAUqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:46:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54346 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbhDAUq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 16:46:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38BE9127AFD;
        Thu,  1 Apr 2021 16:46:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7vMl+Tt7D7QK
        beksSGKuY9Tj2g8=; b=nXIJVkHKkE+SWnS8nWQtDAHpCFE3Hqa+rCWWUx+FelzY
        ZlVQD9Hd5CmXhpLZz2mPXdCSV/whvPy2ZmH8/cYwn9vqZhtdsSXaHfHxVA+b3iWI
        f1KUnvjdwt/jFUeBrxzgbOrsOXUxoui/EgNo8RqQTci4hn73ANM+Lhj6W2toQaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Qkdgo0
        +oCOxEnwTiu5efO1Y4jCHzkxFp4n5LTLAIaMPGQOJTH++JGOP80yXiMF7SpZQkI0
        dfXv22XVs67nrtaDh0M/4BxkJXPdqFp8ZXuAd7wZCNjRBvuXCYMSWSASDGoxEp32
        NWAESYbvuYFKCq/X9AJ36BiyAonw7RLIZ8AI4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30EF2127AFC;
        Thu,  1 Apr 2021 16:46:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 61044127AFB;
        Thu,  1 Apr 2021 16:46:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 17/18] tree-walk.h API: document and format
 tree_entry_extract()
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-17.19-dc895822828-20210331T190531Z-avarab@gmail.com>
Date:   Thu, 01 Apr 2021 13:46:22 -0700
In-Reply-To: <patch-17.19-dc895822828-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:45
        +0200")
Message-ID: <xmqqv99520o1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 52A1865C-932B-11EB-8CA0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Document and format the argument list of the tree_entry_extract()
> function in preparation for eventually adding a sister function.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  tree-walk.h | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/tree-walk.h b/tree-walk.h
> index c60667cba8f..52eb0d6b5b3 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -38,11 +38,17 @@ struct tree_desc {
> =20
>  /**
>   * Decode the entry currently being visited (the one pointed to by
> - * `tree_desc's` `entry` member) and return the sha1 of the entry. The
> - * `pathp` and `modep` arguments are set to the entry's pathname and m=
ode
> - * respectively.
> + * `tree_desc's` `entry` member) and return the OID of the entry.
> + *
> + * There are variants of this function depending on what fields in the
> + * "struct name_entry" you'd like. You always need a pointer to an
> + * appropriate variable to fill in (NULL won't do!):

There aren't.  At least not yet.  So if you want to build a series
like this that does many little things in each step, stop this step
at updating SHA-1 to OID and do nothing else, until you introduce
different variant.

What is missing in the current description that is more worth
describing for those who are new to the codebase is probably the
fact that this is meant to be used in pairs with update_tree_entry().
You call extract, which does not change the entry at all, and when
you are done, update knows (from the data kept in the entry) where
the next entry is in memory and the entry is updated to point there.

Thanks.

> + *
> + * tree_entry_extract(): const char *path, unsigned int mode
>   */
> -static inline const struct object_id *tree_entry_extract(struct tree_d=
esc *desc, const char **pathp, unsigned short *modep)
> +static inline const struct object_id *tree_entry_extract(struct tree_d=
esc *desc,
> +							 const char **pathp,
> +							 unsigned short *modep)
>  {
>  	*pathp =3D desc->entry.path;
>  	*modep =3D desc->entry.mode;
