Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E53C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41B02076C
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s9xLmEJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgKVXxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 18:53:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56173 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgKVXxM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 18:53:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54EDB9C44D;
        Sun, 22 Nov 2020 18:53:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p2JKuYiSzcbPLzOS7Mp/gbJujcA=; b=s9xLmE
        Jrj6u7LENASEZYgmzMSFwHzwlexIQTNVqc6qpKg3gPgXzSq910hlAwFvArhvbiVU
        TJKXaOCNTz0+k1AoZFAesLCtZvXvVWO7yjo/0q0avI/8kfoXvsdIl/oHKzMycQ8f
        Uj3pH573OHYPOMCHLrWRGpbgpCEmPgc+MnukU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eZDxmYIy9hweFw0OUI41fch//7lpRyOg
        6VwTuyrJnovGq3dC0n68/F3ipUWmZqjNWvX4vQ3TLBqRlmxH+C3r3wKHj7aD6utf
        R+42FqH+4B6dtjSBm3PBplVgUsovxLlQ8CiCCTL+HK2gC6DgjjgPXcovIN75wtZz
        vxONFUuvvfw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A6EB9C44C;
        Sun, 22 Nov 2020 18:53:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCDB89C44B;
        Sun, 22 Nov 2020 18:53:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] init: provide useful advice about init.defaultBranch
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com>
Date:   Sun, 22 Nov 2020 15:53:09 -0800
In-Reply-To: <253d6706e6ab97e71ec012f6de33c75f3e980701.1606087406.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sun, 22 Nov 2020
        23:23:26 +0000")
Message-ID: <xmqqft51osnu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFDA60EE-2D1D-11EB-B5DA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> To give ample warning in case we decide to change the fall-back for an
> unconfigured `init.defaultBranch`, let's introduce some advice that is
> shown upon `git init` when that value is not set.

I know this means well.  

I however doubt "ample warning" before we announce an actual
decision makes user's life any easier in practice, though.  Until
they know what it will be changed to (if we decide not to change
anything, treat it as changing it to 'master'), they would not be
able to decide if the name is more suitable for their use case.

I further suspect that their choice will be influenced the most by
the choice made by the projects they most often interact with, and
not by our plan.

> +static const char default_branch_name_advice[] = N_(
> +"Using '%s' as the name for the initial branch. This name is subject\n"
> +"to change. To configure the name to use as the initial branch name in\n"
> +"new repositories, or to silence this warning, run:\n"

s/new repositories/all of your new repositories/ as that is the
whole point of using --global option below.

> +"\n"
> +"\tgit config --global init.defaultBranch <name>\n"
> +);
> +

> +test_expect_success 'advice on unconfigured init.defaultBranch' '
> +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git -c color.advice=always \
> +		init unconfigured-default-branch-name 2>err &&
> +	test_decode_color <err >decoded &&
> +	test_i18ngrep "<YELLOW>hint: " decoded
> +'
> +

> diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.sh
> index f2e7df59cf..0ed02938f9 100755
> --- a/t/t7414-submodule-mistakes.sh
> +++ b/t/t7414-submodule-mistakes.sh
> @@ -30,7 +30,7 @@ test_expect_success 'no warning when updating entry' '
>  
>  test_expect_success 'submodule add does not warn' '
>  	test_when_finished "git rm -rf submodule .gitmodules" &&
> -	git submodule add ./embed submodule 2>stderr &&
> +	git -c init.defaultBranch=x submodule add ./embed submodule 2>stderr &&
>  	test_i18ngrep ! warning stderr
>  '

It is a bit subtle that this not only tests whatever "git submodule"
test it originally wanted to do but also serves as a test that the
new advice message is squelched by the presence of the configuration.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 59bbf75e83..772152320a 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1202,7 +1202,8 @@ test_create_repo () {
>  	mkdir -p "$repo"
>  	(
>  		cd "$repo" || error "Cannot setup test environment"
> -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
> +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
> +			-c init.defaultBranch=master init \

I wonder if this should be more like

	-c init.defaultBranch=${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}

so that tests that want a particular branch name would get what they
want?

Eventually we would need to do the s/master/X/ if/when the actual
default change happens.

>  			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
>  		error "cannot run git init -- have you built things yet?"
>  		mv .git/hooks .git/hooks-disabled
