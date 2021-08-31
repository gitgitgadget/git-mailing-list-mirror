Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2331BC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A8A61090
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbhHaRRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:17:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59207 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240187AbhHaRRg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 13:17:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C5A72155E80;
        Tue, 31 Aug 2021 13:16:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ElijVwkr2E9o2hrnkhcVR4bGv4fBicwM6WcZsdyq3Qw=; b=s1Fn
        wXLNTbpV232aQjzVc0YsTJETd+Yyi6cxrGvXEY6j+DzN9m338PZf5v7M1IpLwcir
        CtGIu30jd4BK1kMO2xoAxeyR+pxmPvnuaHLGSrudjg4OEeLChSABc3dSe9NxIpay
        Y53Kp+q/9TWdpLWVjeEOXIqq6031+Rni8eIrFus=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF783155E7E;
        Tue, 31 Aug 2021 13:16:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 07660155E7D;
        Tue, 31 Aug 2021 13:16:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, novalis@novalis.org
Subject: Re: [PATCH v4 1/3] Remove unused var
References: <xmqqwno2xhmu.fsf@gitster.g>
        <20210831131257.1631316-1-dturner@twosigma.com>
Date:   Tue, 31 Aug 2021 10:16:34 -0700
Message-ID: <xmqqtuj5v8jx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 322B0058-0A7F-11EC-B9F8-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  t/t4060-diff-submodule-option-diff-format.sh | 1 -
>  1 file changed, 1 deletion(-)

Of course this still makes sense ;-)

Let me retitle it to "t4060: remove unused variable" to help readers
of "git shortlog --no-merges", though, while queuing.

Other two patches looked sensible to me, but I'd welcome comments by
submodule users, of course ;-)

Thanks.

> diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
> index dc7b242697..69b9946931 100755
> --- a/t/t4060-diff-submodule-option-diff-format.sh
> +++ b/t/t4060-diff-submodule-option-diff-format.sh
> @@ -361,7 +361,6 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
>  rm -f sm1 &&
>  test_create_repo sm1 &&
>  head6=$(add_file sm1 foo6 foo7)
> -fullhead6=$(cd sm1; git rev-parse --verify HEAD)
>  test_expect_success 'nonexistent commit' '
>  	git diff-index -p --submodule=diff HEAD >actual &&
>  	cat >expected <<-EOF &&
