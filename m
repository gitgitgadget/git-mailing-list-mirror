Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E5DC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 17:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C654D206F0
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 17:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VxvmeePz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbgAXRfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:35:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58350 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbgAXRfx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 12:35:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B25F7BB7D2;
        Fri, 24 Jan 2020 12:35:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pu8v2K/HWs/ce/ga36JeMMAWC4I=; b=Vxvmee
        PzngbjS3zPrUc4eUWUiVjTsT9y/0u0J4LAZAhMPs1iv7Ybu4ytkoVTUmobr9Lhe9
        bPVngWHgqIHreJf5VjwCKxqZRuDeccgyLFrqX3bG92o2HdY9czhi2Ed8SkyR8DO5
        jdbVl3YbPF6Mpx7FyfXEhuqkYVWar2svwOkNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wKDDWRcCpFdzB5R8LtqN80Bi16j6mK5W
        RuROCm82JfV3nDeGv5qKes3TdXnnuoj5fBWs12m6eurRtjLj1jd8XW5FJZDiQVqu
        dGhxy9iJ5C3P29E/LLkKna79jvjw/Og7ImjuYBMn/r0NbyXxSxbkuxgEIHaxDbsz
        aKHwcamZfRc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9EB6BB7D1;
        Fri, 24 Jan 2020 12:35:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1A20BB7D0;
        Fri, 24 Jan 2020 12:35:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Kaestle <peter.kaestle@nokia.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, pc44800@gmail.com
Subject: Re: [PATCH v3 1/2] Testcase for submodule status on empty dirs
References: <xmqq4kwl512y.fsf@gitster-ct.c.googlers.com>
        <1579862044-29847-1-git-send-email-peter.kaestle@nokia.com>
Date:   Fri, 24 Jan 2020 09:35:46 -0800
In-Reply-To: <1579862044-29847-1-git-send-email-peter.kaestle@nokia.com>
        (Peter Kaestle's message of "Fri, 24 Jan 2020 11:34:03 +0100")
Message-ID: <xmqq7e1g3ggd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5A7129C-3ECF-11EA-B5A4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Kaestle <peter.kaestle@nokia.com> writes:

> Subject: Re: [PATCH v3 1/2] Testcase for submodule status on empty dirs
>
> Test that submodule status reports initialized but not cloned
> submodules as missing.

Let's not waste the findings you made and the description you wrote
during the review of the previous round.  After all, the reason why
reviewers ask questions and you write responses is not because we
want to satisify curiosity of the reviewers, but to polish the
history we leave to the future readers, both in the patch text and
its explanations.

How about explaining this step more like this?

    Subject: t7400: add a testcase for submodule status on empty dirs

    We have test coverage for "git submodule status" output in
    various cases, i.e.

        1) not-init, not-cloned: status should initially be "missing"
        2) init, not-cloned: status should be "missing"
        3) not-init, cloned:
        4) init, cloned:'status should be "up-to-date" after update
        4.1) + modified: status should be "modified" after submodule commit
        4.2) + modified, committed: status should be "up-to-date" after update

    but the cases 2) and 3) are not covered.

    Test that submodule status reports initialized but not cloned
    submodules as missing to fill the gap in test coverage.

Thanks.


>
> Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
> ---
>  t/t7400-submodule-basic.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 7f75bb1..2e84914 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -399,6 +399,14 @@ test_expect_success 'init should register submodule url in .git/config' '
>  	test_cmp expect url
>  '
>  
> +test_expect_success 'status should still be "missing" after initializing' '
> +	rm -fr init &&
> +	mkdir init &&
> +	git submodule status >lines &&
> +	rm -fr init &&
> +	grep "^-$rev1" lines
> +'
> +
>  test_failure_with_unknown_submodule () {
>  	test_must_fail git submodule $1 no-such-submodule 2>output.err &&
>  	test_i18ngrep "^error: .*no-such-submodule" output.err
