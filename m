Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0817C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354507AbiFUWmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiFUWmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:42:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B9326E5
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:42:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7954F197EE6;
        Tue, 21 Jun 2022 18:42:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LeUhnpKGLtz/
        IE7MSBB9U7zMJcbjo6MoDkAGE4RRMKc=; b=tRXgknC/ffOyhaDL+5LzTUAgE/hB
        2LA6sH2kPc7nZiJAVhwE2zi/NSVPaU62kMoamt2afF94kBaL8rDYnBewF/J61S+T
        QGnNPxGeH1RTSkao+SelIQZvaK0TjWBB8oOOqt6CdxRdfSBnu+nJMms7Qv1ZwMHg
        vgyIXE6nz8IoAuU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71876197EE5;
        Tue, 21 Jun 2022 18:42:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 046BB197EE3;
        Tue, 21 Jun 2022 18:42:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] tests: add missing double quotes to included
 library paths
References: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
        <patch-1.3-05ba5e7f837-20220621T221928Z-avarab@gmail.com>
Date:   Tue, 21 Jun 2022 15:42:10 -0700
In-Reply-To: <patch-1.3-05ba5e7f837-20220621T221928Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Jun
 2022 00:21:38 +0200")
Message-ID: <xmqqzgi5ej0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 63F9445C-F1B3-11EC-B026-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix two inclusions added in d42bab442d7 (core.fsyncmethod: tests for
> batch mode, 2022-04-04) that needed to be quoted, and the same sort of
> issue in a242c150ebb (vimdiff: integrate layout tests in the unit
> tests framework ('t' folder), 2022-03-30). Both were first released
> with v2.37.0-rc0.

Describe what symptom you may see if it is left unfixed.  IOW, if we
consider that having a whitespace in the path to the build directory
is just as crazy as having a single-quote, it would make this patch
unnecessary,  Make it easier for readers to decide, by saying
something like

	As TEST_DIRECTORY is (typically) path to t/ in the extracted
	source tree, it can have funny characters like $IFS whitespace
	in it.

at least.

Thanks.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t3700-add.sh            | 2 +-
>  t/t3903-stash.sh          | 2 +-
>  t/t7609-mergetool--lib.sh | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 8979c8a5f03..8689b48589c 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -8,7 +8,7 @@ test_description=3D'Test of git add, including the -- o=
ption.'
>  TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
> -. $TEST_DIRECTORY/lib-unique-files.sh
> +. "$TEST_DIRECTORY"/lib-unique-files.sh
> =20
>  # Test the file mode "$1" of the file "$2" in the index.
>  test_mode_in_index () {
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 20e94881964..2a4c3fd61c0 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -9,7 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
>  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> =20
>  . ./test-lib.sh
> -. $TEST_DIRECTORY/lib-unique-files.sh
> +. "$TEST_DIRECTORY"/lib-unique-files.sh
> =20
>  test_expect_success 'usage on cmd and subcommand invalid option' '
>  	test_expect_code 129 git stash --invalid-option 2>usage &&
> diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
> index d848fe6442b..330d6d603d7 100755
> --- a/t/t7609-mergetool--lib.sh
> +++ b/t/t7609-mergetool--lib.sh
> @@ -7,7 +7,7 @@ Testing basic merge tools options'
>  . ./test-lib.sh
> =20
>  test_expect_success 'mergetool --tool=3Dvimdiff creates the expected l=
ayout' '
> -	. $GIT_BUILD_DIR/mergetools/vimdiff &&
> +	. "$GIT_BUILD_DIR"/mergetools/vimdiff &&
>  	run_unit_tests
>  '
