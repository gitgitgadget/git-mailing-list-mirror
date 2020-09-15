Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9461CC433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 20:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41880207DE
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 20:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hLazDtYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgIOUcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 16:32:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64513 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgIOUbo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 16:31:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A06427E83E;
        Tue, 15 Sep 2020 16:31:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WvBiOoeeXh6coSv7Dm6oc3pfRlM=; b=hLazDt
        YXCkSrmJs9M9Zs6J2C0Tvh9ND7nu11AmoexbW4guyGy4bmvrBwytW6CkI3NgASrh
        U7B9YvjhMgGN0hTZiLojMP2GATpeUzTQSKUx/DBiufc+LIJXXE3kPNasO8RkA3CY
        eYuvGdDcTObHAMdxfHzHCh5Ta9wr8OmBdYFOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hHY1nWd1CC5zRx7jKl+i4WN+Cj/GULOh
        //Wj9P6BFsby+J/XZxbF50IuqluBfBkjNNbeue1Xek+VsU2XtQwA2cVePgKTw3Ld
        Fn9c6nSCakbB2DiOGPgeXDW9IvXYFwlVZPnKK1RU6NBlFn4DUEGCdBw61e+9XRBz
        RbjJG07kVek=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9782F7E83D;
        Tue, 15 Sep 2020 16:31:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D2887E83C;
        Tue, 15 Sep 2020 16:31:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/2] t5534: new test case for atomic signed push
References: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com>
Date:   Tue, 15 Sep 2020 13:31:38 -0700
In-Reply-To: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com> (Han Xin's
        message of "Tue, 15 Sep 2020 17:58:26 +0800")
Message-ID: <xmqqv9gezsr9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 752C874C-F792-11EA-BC06-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

> In order to test signed atomic push, add a new test case.
>
> Reviewed-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---

Thanks, but nowhere in the above it does not say what is being
tested.  By looking at 2/2 (by the way, these should be a single
atomic patch, not a "failure turns into success", as it is not even
a bug fix), readers may be able to guess that you want to enforce
that with even broken implementation of GPG, an immediate failure to
push one of the refs will be noticed by looking at their refs, but
it is unclear why that is even desirable---if you combine the two
patches, you may have a better place to argue why it is a good idea,
but a test-only patch makes it even less clear why the new behavior
expected by this test is desirable.

>  t/t5534-push-signed.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index 030331f1c5..d0fcdc900e 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -273,4 +273,21 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
>  	test_cmp expect dst/push-cert-status
>  '
>  
> +test_expect_failure GPG 'check atomic push before running GPG' '
> +	prepare_dst &&
> +	git -C dst config receive.certnonceseed sekrit &&
> +	write_script gpg <<-EOF &&
> +	echo >&2 "Fake gpg is called."
> +	exit 1
> +	EOF
> +	test_must_fail env PATH="$TRASH_DIRECTORY:$PATH" git push --signed --atomic \
> +			dst noop ff noff >out 2>&1 &&
> +	grep "^error:" out >actual &&
> +	cat >expect <<-EOF &&
> +	error: atomic push failed for ref refs/heads/noff. status: 2
> +	error: failed to push some refs to '"'"'dst'"'"'
> +	EOF
> +	test_i18ncmp expect actual
> +'
> +
>  test_done
