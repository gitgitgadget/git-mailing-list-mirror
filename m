Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B76FA1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbeKNO5p (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:57:45 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63759 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNO5p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 09:57:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D43E418E09;
        Tue, 13 Nov 2018 23:56:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EUkfxM0LG7M/5C1lOo8u8uwUpmU=; b=TM6yB2
        13u77rR+iMUCJK5IU7Eejoi7bmOZ5QJbPoGikR9ENfn0Cxl9ZUjJaaDbb8jdbXoK
        VhMbv1FtK1hw8/yypfHEuQoM8sMv4ZlLulwwUB0KEVx3yfhErcfagIIUKLI6TK7+
        q5A+y9Yi/q3YrqbNVTdvRmr57WuZxjfiJXIr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QGK+oHGKIH+c+52BlBDrEsCObX0MkPzC
        WRndvbnyalHatKBwKdrRR/aPhsYxQ03NWsFm92QMXdlh/SrZsTGy9Q2jl0XSeQuM
        lNbR7TzQ0CkVT5M4MUa9NKOWYm37cctTTl95EhRQFsVQ0A3jjiaa1x8bCmUhKWVV
        RrnbcVj9G58=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD92C18E08;
        Tue, 13 Nov 2018 23:56:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E43A118E05;
        Tue, 13 Nov 2018 23:56:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/5] t/lib-gettext: test installed git-sh-i18n if GIT_TEST_INSTALLED is set
References: <pull.73.git.gitgitgadget@gmail.com>
        <eddea552e414964e19413c02fb07167432e8aaa0.1542030510.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Nov 2018 13:56:04 +0900
In-Reply-To: <eddea552e414964e19413c02fb07167432e8aaa0.1542030510.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 12 Nov 2018
        05:48:36 -0800 (PST)")
Message-ID: <xmqqefbop89n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 989A4CB2-E7C9-11E8-BB4D-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It makes very, very little sense to test the built git-sh-i18n when the
> user asked specifically to test another one.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Yup.  Makes sense.

>  t/lib-gettext.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
> index eec757f104..9eb160c997 100644
> --- a/t/lib-gettext.sh
> +++ b/t/lib-gettext.sh
> @@ -10,7 +10,12 @@ GIT_TEXTDOMAINDIR="$GIT_BUILD_DIR/po/build/locale"
>  GIT_PO_PATH="$GIT_BUILD_DIR/po"
>  export GIT_TEXTDOMAINDIR GIT_PO_PATH
>  
> -. "$GIT_BUILD_DIR"/git-sh-i18n
> +if test -n "$GIT_TEST_INSTALLED"
> +then
> +	. "$(git --exec-path)"/git-sh-i18n
> +else
> +	. "$GIT_BUILD_DIR"/git-sh-i18n
> +fi
>  
>  if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON
>  then
