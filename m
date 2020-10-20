Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B29C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCA722251
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AovVCYhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438102AbgJTT0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:26:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55028 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438088AbgJTT0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 15:26:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9AD1F447A;
        Tue, 20 Oct 2020 15:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fLML5lTvs6YB1LVpVhBjrRzNR8M=; b=AovVCY
        hVIGtNUnUclzfW7qEfAfwBMcj5ZeRSo/hVYZQelsnA4inu+pzrGXSh5CTwNcvEc4
        RKFePw9MWYLfy/J+8LbgtfsJPR9RSaktNPs8QU11Cx5reoLW3UUlDnWE5Pus6cNX
        CLgU69/6qxmOdGqHhBKQA/nLqj0IN6IeYFcRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=izU52z6dHwobsHrsh2sT8+oKEQVBxEfE
        x5pcZsV0G6ChpWQ9ZtXAPo0ZAxDLyxsTQddoXmY6N1FKDJAkEpGgNZDLXs1Mfqrv
        kQC7ailD3cTSEZfQOXmquVUAMuU31Z+fVP74ua6KqtvFNFFIPCvrx53I6KyqReUa
        gOmvIGSbcFA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3366F4479;
        Tue, 20 Oct 2020 15:26:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2B33DF4404;
        Tue, 20 Oct 2020 15:26:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     caleb.tillman@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [OUTREACHY] [PATCH v2] t0000: replace test -f with helper function
References: <20201020173257.80525-1-caleb.tillman@gmail.com>
Date:   Tue, 20 Oct 2020 12:25:58 -0700
In-Reply-To: <20201020173257.80525-1-caleb.tillman@gmail.com> (caleb tillman's
        message of "Tue, 20 Oct 2020 12:32:57 -0500")
Message-ID: <xmqqimb4bsxl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15D6CE72-130A-11EB-8A68-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

caleb.tillman@gmail.com writes:

> From: Caleb Tillman <caleb.tillman@gmail.com>
>
> Signed-off-by: Caleb Tillman <caleb.tillman@gmail.com>
> ---

Thanks.  Let's declare victory and move on.  You've demonstrated
through the microproject that you can now comfortably be involved in
the review discussion.

I'll keep the copy I queued on the 20th, though, with this title

    t0000: use test_path_is_file instead of "test -f"

which is only slightly longer but is much more descriptive than this
round.

Thanks.

>  t/t0000-basic.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 923281af93..eb99892a87 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with --missing-ok' '
>  test_expect_success 'git read-tree followed by write-tree should be idempotent' '
>  	rm -f .git/index &&
>  	git read-tree $tree &&
> -	test -f .git/index &&
> +	test_path_is_file .git/index &&
>  	newtree=$(git write-tree) &&
>  	test "$newtree" = "$tree"
>  '
