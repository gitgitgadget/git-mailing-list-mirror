Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9560C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EC4613F6
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhDTVQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:16:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64979 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhDTVQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 17:16:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCDFE137435;
        Tue, 20 Apr 2021 17:15:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Uq5HfM0Spfp/
        xzrW0CoEV/u7ki4=; b=VWAqISSKnmXjJPDUtVNCbSmDcnm8Qp/mQd/TtNgZ/uoA
        iPk5coZ7jsXglrsjdQM7n4s+3LCI6XM4gk3norizm1XOCHlYYyyOx/w3DK5wd5b0
        B617QVWZ2e1J6p5OKvWPCLUz7tN5RVqkMKzojfM29ldh+2xfl7oh+NQmKtOd8FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DP+ZZo
        L4IY7HgIdzM9710Y8C3GI0JBzzgLetnMyIcTgHSNMshSIRMHgugAjByvcN0DXigG
        8s6pNmkhJDjICk7S6eN6csboGIaTPD7n232cGmX6z77p6rX6wE/XIC+TAIfgSJ+I
        siQtxYDF1r42PchgMcvO3kcHJ1AFDBjDy6IsQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4D80137434;
        Tue, 20 Apr 2021 17:15:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DEBE8137433;
        Tue, 20 Apr 2021 17:15:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBD?= =?utf-8?B?w7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 3/3] test-lib-functions: remove last two parameter
 count assertions
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
        <patch-3.3-8fd51861b5-20210420T122706Z-avarab@gmail.com>
Date:   Tue, 20 Apr 2021 14:15:43 -0700
In-Reply-To: <patch-3.3-8fd51861b5-20210420T122706Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Apr
 2021 14:29:30 +0200")
Message-ID: <xmqqfszk4pz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 926CEC80-A21D-11EB-9EF4-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove a couple of parameter count assertions where, unlike the
> preceding commit's migration to 'test -$x "$@"', we'll now silently do
> the "wrong" thing if given too many parameters. The benefit is less
> verbose trace output, as noted in the preceding commit.
>
> In the case of "test_file_size", the "test-tool" we're invoking is
> happy to accept N parameters (it'll print out all N sizes). Let's just
> use "$@" in that case anyway. There's only a few callers, and
> eventually those should probably be moved to use the test-tool
> directly.
>
> That only leaves test_line_count, I suppose I could leave that one
> alone, but since it's the only common function left that does this
> assertion let's remove it for the brevity of the -x output and
> consistency with other functions.

Unlike the previous step that did not entirely sacrifice the "test
writers are human and they need our help in detecting their
mistakes", this step feels like "shortening '-x' output is the most
important thing in the world, and helping test writers is much less
important."

IOW, I am not convinced it is a good change.


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/test-lib-functions.sh | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index f8f5bf9de1..e128b341ff 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -827,10 +827,7 @@ test_path_is_missing () {
>  # output through when the number of lines is wrong.
> =20
>  test_line_count () {
> -	if test $# !=3D 3
> -	then
> -		BUG "not 3 parameters to test_line_count"
> -	elif ! test $(wc -l <"$3") "$1" "$2"
> +	if ! test $(wc -l <"$3") "$1" "$2"
>  	then
>  		echo "test_line_count: line count for $3 !$1 $2"
>  		cat "$3"
> @@ -839,8 +836,7 @@ test_line_count () {
>  }
> =20
>  test_file_size () {
> -	test "$#" -ne 1 && BUG "1 param"
> -	test-tool path-utils file-size "$1"
> +	test-tool path-utils file-size "$@"
>  }
> =20
>  # Returns success if a comma separated string of keywords ($1) contain=
s a
