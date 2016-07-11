Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A4D1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 19:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbcGKTQR (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 15:16:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751779AbcGKTQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 15:16:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 102DD2C434;
	Mon, 11 Jul 2016 15:16:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MEGQyJSKxiaIF3eujDDMtiFVHgU=; b=odi/ad
	0TSn0DN3vkpsH8V6gCViqr9Z2jgTENFCccPuNnvTR3WhHRRje0m8jkQdXyyK7BYz
	9Aq+glrxy4eduBuxAmbSPvNcXGQgcxoHIOqezMZX80NCCsMMwdeH/WH1ptha6fPQ
	kC6BsHTd3i0/DrrG/71AqfZQUbAhX0o8DhlYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NPgRw76n9/zjEnReXMlFp5qL6v5z/gyV
	RGcc9ySY32WpnH3ZedOgBWt54jeRUs/TRFCkVlG7yliUnjrxsolJuf8sAx6IKGbL
	6VjI12aoi2BCB65r8aoaHGPJ2hj/OrNMgIc7QBvApegkycdJpoeUavEy5YQ+hSUz
	rcxQEscYxgw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 081252C433;
	Mon, 11 Jul 2016 15:16:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9953C2C432;
	Mon, 11 Jul 2016 15:16:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com
Subject: Re: [PATCH v4 2/6] t6030: explicitly test for bisection cleanup
References: <20160626122356.28999-1-pranit.bauva@gmail.com>
	<20160706202523.9850-1-pranit.bauva@gmail.com>
	<20160706202523.9850-3-pranit.bauva@gmail.com>
Date:	Mon, 11 Jul 2016 12:16:12 -0700
In-Reply-To: <20160706202523.9850-3-pranit.bauva@gmail.com> (Pranit Bauva's
	message of "Thu, 7 Jul 2016 01:55:19 +0530")
Message-ID: <xmqq37ng9e9v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF94BC6C-479B-11E6-BBD7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Add test to explicitly check that 'git bisect reset' is working as
> expected. This is already covered implicitly by the test suite.

Without fuzzy "this is not an improvement but it helps" that sounds
like making excuse, the above reads much better.


> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>
> ---
> I faced this problem while converting `bisect_clean_state` and the tests
> where showing breakages but it wasn't clear as to where exactly are they
> breaking. This will patch  will help in that. Also I tested the test
> coverage of the test suite before this patch and it covers this (I did
> this by purposely changing names of files in git-bisect.sh and running
> the test suite).
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  t/t6030-bisect-porcelain.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index e74662b..a17f7a6 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -894,4 +894,21 @@ test_expect_success 'bisect start takes options and revs in any order' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'git bisect reset cleans bisection state properly' '
> +	git bisect reset &&
> +	git bisect start &&
> +	git bisect good $HASH1 &&
> +	git bisect bad $HASH4 &&
> +	git bisect reset &&
> +	test -z "$(git for-each-ref "refs/bisect/*")" &&
> +	test_path_is_missing "$GIT_DIR/BISECT_EXPECTED_REV" &&
> +	test_path_is_missing "$GIT_DIR/BISECT_ANCESTORS_OK" &&
> +	test_path_is_missing "$GIT_DIR/BISECT_LOG" &&
> +	test_path_is_missing "$GIT_DIR/BISECT_RUN" &&
> +	test_path_is_missing "$GIT_DIR/BISECT_TERMS" &&
> +	test_path_is_missing "$GIT_DIR/head-name" &&
> +	test_path_is_missing "$GIT_DIR/BISECT_HEAD" &&
> +	test_path_is_missing "$GIT_DIR/BISECT_START"
> +'
> +
>  test_done
