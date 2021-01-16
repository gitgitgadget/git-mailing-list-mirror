Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D567C433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A5322209
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbhAPVwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 16:52:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62871 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbhAPVv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 16:51:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FADE100DF8;
        Sat, 16 Jan 2021 16:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=1cCjzq6aFpCjYMQ6zn27vhDJy
        eU=; b=O/uiv163CmqebrsEL/SheytRBbjK/wvEifjtvEIZnByRteEZL34YZc5qK
        3J8a0sLY/HJYZiPjjIuF34hKylWDKxWau928PdvCIp6+9BJn20/2h+RXywS/1W2z
        FGmkg+28OYNb8LlPzXmzb/DdJefp4waMxVBk5sA0TR/RiFBSUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=MlBIlj+AF7WnuCoY7Eo
        r3+A7Hs5uP+oeS6OJgSSfOTnThOE2f6POcTO0lQj7cUt0uzWk/8WD+MKboxlXxtC
        345Clb2XkVgbNl6JN/LtFtLrSTqxzo/kqg1rE9sANJAS/R8LNSqTKVtkBQy4EKN6
        03HSpnJNchyaLWCVKdKcd2h8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 386F7100DF7;
        Sat, 16 Jan 2021 16:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7FCE1100DF6;
        Sat, 16 Jan 2021 16:51:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 04/11] git svn mergeinfo tests: modernize redirection
 & quoting style
References: <20210114233515.31298-1-avarab@gmail.com>
        <20210116153554.12604-5-avarab@gmail.com>
Date:   Sat, 16 Jan 2021 13:51:11 -0800
Message-ID: <xmqqim7wo8j4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F3BFE398-5844-11EB-9BD3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Use "<file" instead of "< file", and don't put the closing quote for
> strings on an indented line. This makes a follow-up refactoring commit
> easier to read.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t9151-svn-mergeinfo.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
> index 4f6c06ecb2..59c5847c5f 100755
> --- a/t/t9151-svn-mergeinfo.sh
> +++ b/t/t9151-svn-mergeinfo.sh
> @@ -9,37 +9,37 @@ test_description=3D'git-svn svn mergeinfo properties'
> =20
>  test_expect_success 'load svn dump' "
>  	svnadmin load -q '$rawsvnrepo' \
> -	  < '$TEST_DIRECTORY/t9151/svn-mergeinfo.dump' &&
> +	  <'$TEST_DIRECTORY/t9151/svn-mergeinfo.dump' &&

This is not a new issue, but if $TEST_DIRECTORY or $rawsvnrepo have
a funny character (like "'") in them, the above does not do the
right thing.  Everything would work much better, if swap dq and sq
for the body, because these $variables _are_ visible in the body
that is eval'ed.

But you mentioned "a follow-up refactoring", so let's expect that
things will get better in a later step.

Thanks.
