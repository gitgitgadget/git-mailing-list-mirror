Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358A8C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDD6221FC
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MEAJZYfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391606AbgJTUN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:13:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62227 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391350AbgJTUN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 16:13:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 487E4FA3D5;
        Tue, 20 Oct 2020 16:13:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qXvgu1TMTBm9I+raeJHSkC6hV5Y=; b=MEAJZY
        fRkcrL7+2wWM7+29rh4/6c/87uJcn98nJMlrlxFq9nAL+ZNkNqR6l0Gi2nazNSQI
        Qy4Bf3K6XIPg4M21x6u4zV0tUXIq/cqqlXR7rbCmf/JhpUMdLJfH3q5q9sThZ8eO
        Pnd9PMO2DmB/1ywOsYFbqhseJCHn+jFqugpAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JHz7/MCOF9gCZgG605N2OsMsGqTh5ZXW
        vHCP6WsQG1l98AUVQtoKoSsFdzhTjaJUqW/sZWzFaX9BqEKjpMA1WKP7F4bGIG9V
        YAaZ2QDwP5TvQJkzJuQhsu++vHVzjNAKAlfqTUVYWOkvAdlW9e1Lqwj5gg5u1VQZ
        rEKX1AIMQ5Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4092BFA3D3;
        Tue, 20 Oct 2020 16:13:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 890E1FA3D2;
        Tue, 20 Oct 2020 16:13:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com, congdanhqx@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4] t7201: put each command on a separate line
References: <20201017075455.9660-1-charvi077@gmail.com>
        <20201020121152.21645-1-charvi077@gmail.com>
Date:   Tue, 20 Oct 2020 13:13:53 -0700
In-Reply-To: <20201020121152.21645-1-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Tue, 20 Oct 2020 17:41:52 +0530")
Message-ID: <xmqqa6wgbqpq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C71AFB08-1310-11EB-B0F6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> Modern practice is to avoid multiple commands per line,
> and instead place each command on its own line.
>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---

This looks good, but I am wondering what happened between v3 and
v4.  

As you've demonstrated through the microproject that you can now
comfortably be involved in the review discussion, I am tempted to
suggest that we declare victory at this point and move on, but I
don't know what the plans are for the other 4 patches (I guess we
won't miss them that much---the micros are meant to be practice
targets).

Thanks.


>  t/t7201-co.sh | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 5898182fd2..b36a93056f 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -157,7 +157,8 @@ test_expect_success 'checkout -m with merge conflict' '
>  '
>  
>  test_expect_success 'format of merge conflict from checkout -m' '
> -	git checkout -f master && git clean -f &&
> +	git checkout -f master &&
> +	git clean -f &&
>  
>  	fill b d >two &&
>  	git checkout -m simple &&
> @@ -180,7 +181,9 @@ test_expect_success 'format of merge conflict from checkout -m' '
>  '
>  
>  test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
> -	git checkout -f master && git reset --hard && git clean -f &&
> +	git checkout -f master &&
> +	git reset --hard &&
> +	git clean -f &&
>  
>  	fill b d >two &&
>  	git checkout --merge --conflict=diff3 simple &&
> @@ -205,7 +208,9 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
>  '
>  
>  test_expect_success 'switch to another branch while carrying a deletion' '
> -	git checkout -f master && git reset --hard && git clean -f &&
> +	git checkout -f master &&
> +	git reset --hard &&
> +	git clean -f &&
>  	git rm two &&
>  
>  	test_must_fail git checkout simple 2>errs &&
> @@ -218,7 +223,8 @@ test_expect_success 'switch to another branch while carrying a deletion' '
>  test_expect_success 'checkout to detach HEAD (with advice declined)' '
>  	git config advice.detachedHead false &&
>  	rev=$(git rev-parse --short renamer^) &&
> -	git checkout -f renamer && git clean -f &&
> +	git checkout -f renamer &&
> +	git clean -f &&
>  	git checkout renamer^ 2>messages &&
>  	test_i18ngrep "HEAD is now at $rev" messages &&
>  	test_line_count = 1 messages &&
> @@ -237,7 +243,8 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
>  test_expect_success 'checkout to detach HEAD' '
>  	git config advice.detachedHead true &&
>  	rev=$(git rev-parse --short renamer^) &&
> -	git checkout -f renamer && git clean -f &&
> +	git checkout -f renamer &&
> +	git clean -f &&
>  	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
>  	grep "HEAD is now at $rev" messages &&
>  	test_line_count -gt 1 messages &&
> @@ -254,7 +261,8 @@ test_expect_success 'checkout to detach HEAD' '
>  '
>  
>  test_expect_success 'checkout to detach HEAD with branchname^' '
> -	git checkout -f master && git clean -f &&
> +	git checkout -f master &&
> +	git clean -f &&
>  	git checkout renamer^ &&
>  	H=$(git rev-parse --verify HEAD) &&
>  	M=$(git show-ref -s --verify refs/heads/master) &&
> @@ -269,7 +277,8 @@ test_expect_success 'checkout to detach HEAD with branchname^' '
>  '
>  
>  test_expect_success 'checkout to detach HEAD with :/message' '
> -	git checkout -f master && git clean -f &&
> +	git checkout -f master &&
> +	git clean -f &&
>  	git checkout ":/Initial" &&
>  	H=$(git rev-parse --verify HEAD) &&
>  	M=$(git show-ref -s --verify refs/heads/master) &&
> @@ -284,7 +293,8 @@ test_expect_success 'checkout to detach HEAD with :/message' '
>  '
>  
>  test_expect_success 'checkout to detach HEAD with HEAD^0' '
> -	git checkout -f master && git clean -f &&
> +	git checkout -f master &&
> +	git clean -f &&
>  	git checkout HEAD^0 &&
>  	H=$(git rev-parse --verify HEAD) &&
>  	M=$(git show-ref -s --verify refs/heads/master) &&
