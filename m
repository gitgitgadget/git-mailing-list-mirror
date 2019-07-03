Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361831F461
	for <e@80x24.org>; Wed,  3 Jul 2019 17:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfGCRWf (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 13:22:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64517 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfGCRWf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 13:22:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 120AE15330D;
        Wed,  3 Jul 2019 13:22:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OUWm6hGUN9RcRL+6StAnejhJyAQ=; b=Ne77A6
        tLJGEduLXw8QxrcPMP8N6j1q7enwSaJxZHyTn3OL2EWbxj+LtgzrF13lFxF+vi6a
        ZGwrM7l5NjVgxN0fnaMXKObMr1i85rBkJO6xMo5bZTljdJ6h2n2EbsAkrn4X0wes
        aSDvxZDOtN7rkjry4K3AbqI95jgc0tPlchmlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eHU8dfIzp/xZlE7VLPW4m67A52B0+KO+
        DDW94h5PnE4RPnnP6ucYjPwxN7P704VVWpGPHmCau4S+vGA6eCKtqzSbFMUEHzH7
        SCIJYiF8Zl4jjRigq21haN1ysLzPqZo0TeOdREgYZMUbO32JD4dgVcGpePPNVM2V
        5IqmCUJL2a8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B71015330C;
        Wed,  3 Jul 2019 13:22:33 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74A4915330B;
        Wed,  3 Jul 2019 13:22:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 12/14] test: completion: use global config
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
        <20190621223107.8022-13-felipe.contreras@gmail.com>
Date:   Wed, 03 Jul 2019 10:22:31 -0700
In-Reply-To: <20190621223107.8022-13-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Fri, 21 Jun 2019 17:31:05 -0500")
Message-ID: <xmqqsgrn119k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 244A4674-9DB7-11E9-8100-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> When appropriate.

It is unclear what makes these (but not other use of test_config)
appropriate.

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 7bef41eaf5..3dbfef6960 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1497,9 +1497,9 @@ test_expect_success 'git --help completion' '
>  	test_completion "git --help core" "core-tutorial "
>  '
>  
> -test_expect_failure 'completion.commands removes multiple commands' '
> +test_expect_success 'completion.commands removes multiple commands' '
>  	offgit &&
> -	test_config completion.commands "-cherry -mergetool" &&
> +	test_config_global completion.commands "-cherry -mergetool" &&

This feels more like fixing a bug introduced by step 11/14 in that
(besides doing "offgit" that affects global test environment outside
a subshell) we want to do this test outside a repository so there is
no appropriate "local" configuration "git config" (hence test_config)
can touch.  IOW, shouldn't this have been done in the step 11/14 when
"offgit" was added?
