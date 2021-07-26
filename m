Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E0C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DBD603E9
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhGZWHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 18:07:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55616 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhGZWHE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 18:07:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BB92DEA2A;
        Mon, 26 Jul 2021 18:47:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=duTw9Co4vQLTVM1gTr+73qsnQCXHihOfzATK5g
        NKQNo=; b=C7zsGITCwzi6K6YkMVoATuH/op7LkzJQQbRziDo+PApynGywRBPwGY
        REq7XKiF8ZopypXVcLfBoOs1BMFr6z+gCHf5ykAwatfmUDk7re4WJuzcRdGB/gUJ
        PAdm8KqVkOTMKr1Mns23cdgqBG3bJwByG2auzxkBOghcBqOI4sWj0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 307F2DEA29;
        Mon, 26 Jul 2021 18:47:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57618DEA20;
        Mon, 26 Jul 2021 18:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] Remove unused var
References: <20210726183358.3255233-1-dturner@twosigma.com>
Date:   Mon, 26 Jul 2021 15:47:30 -0700
In-Reply-To: <20210726183358.3255233-1-dturner@twosigma.com> (David Turner's
        message of "Mon, 26 Jul 2021 14:33:56 -0400")
Message-ID: <xmqq4kcghev1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75FFDA5C-EE63-11EB-A2B3-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> Signed-off-by: David Turner <dturner@twosigma.com>
> ---
>  t/t4060-diff-submodule-option-diff-format.sh | 1 -
>  1 file changed, 1 deletion(-)
>
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

Makes sense.  THanks.
