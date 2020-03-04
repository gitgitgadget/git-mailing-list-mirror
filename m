Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E885CC3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 16:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB722166E
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 16:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rutltAqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgCDQpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:45:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51868 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgCDQpk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 11:45:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93CDA5BB25;
        Wed,  4 Mar 2020 11:45:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rM13Jq+QiGh0XU7MFi/9LPa8IT0=; b=rutltA
        qRdxE4OolI6N1izf56l5Wj9dI3zgy7TIH6UkAZXp/nlCcXzY0zvb673Tf8MDUkom
        oDhnOyvClBJ+X2jVaJam2wJJklpylyY/beKrwn5elRfwg4nFfSOpaA6HQKjor3E+
        b29lVE9MviFMlDodySR486KcLDGa+CMWfbAAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oDMdkLuyqgBZ8+RosMQA4fvIaiqCLjwn
        0IdS/KlI3a+A5gHROI/zcoKue3MF78WElifx69QMxHry+e8UZyt/9zvNIoumQ63p
        tmeVhY76xAPJTYGj8/Fa9ByGZKdeFx9ndAvjGPnfvRKF8X5ZtiWmmUN5trc9FAe/
        nQ2Pk+OGC8E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B4EE5BB24;
        Wed,  4 Mar 2020 11:45:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED9825BB23;
        Wed,  4 Mar 2020 11:45:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] t5537: adjust test_oid label
References: <pull.717.git.git.1582834951742.gitgitgadget@gmail.com>
        <pull.717.v2.git.git.1583337192946.gitgitgadget@gmail.com>
Date:   Wed, 04 Mar 2020 08:45:33 -0800
In-Reply-To: <pull.717.v2.git.git.1583337192946.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 04 Mar 2020
        15:53:12 +0000")
Message-ID: <xmqq8skg5as2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91C271C2-5E37-11EA-B4A9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We recently switched to using Perl instead of `sed` in the httpd-based
> tests. Let's reflect that in the label we give the corresponding commit
> hashes.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Follow-up for "ci: upgrade to the latest Azure Pipelines agent pools"
>     
>     This is a companion patch for https://github.com/git/git/pull/714,
>     adding a patch that would not apply to maint but applies to master. It
>     is intended to be applied on top of the merge that pulls in the agent
>     pool upgrade (which in turn is intended to be applied on top of maint).
>     
>     Changes since v1:
>     
>      * Rebased onto master, as it now has all the building blocks needed for
>        this.

A timely update that is very much appreciated.

Will apply.  Thanks.

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-717%2Fdscho%2Fazure-pipelines-latest-pools-test_oid-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-717/dscho/azure-pipelines-latest-pools-test_oid-v2
> Pull-Request: https://github.com/git/git/pull/717
>
> Range-diff vs v1:
>
>  1:  79ad5eaa75b ! 1:  a6e4e9cc6ad t5537: adjust test_oid label
>      @@ -30,4 +30,4 @@
>       +	printf "$(test_oid perl)" \
>        	       "$(git -C "$REPO" rev-parse HEAD)" \
>        	       "$(git -C "$REPO" rev-parse HEAD^)" \
>      - 	       >"$HTTPD_ROOT_PATH/one-time-perl" &&
>      + 	       >"$HTTPD_ROOT_PATH/one-time-sed" &&
>
>
>  t/t5537-fetch-shallow.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index 9e16512fe31..287d2c336be 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -17,8 +17,8 @@ test_expect_success 'setup' '
>  	commit 4 &&
>  	git config --global transfer.fsckObjects true &&
>  	test_oid_cache <<-EOF
> -	sed sha1:s/0034shallow %s/0036unshallow %s/
> -	sed sha256:s/004cshallow %s/004eunshallow %s/
> +	perl sha1:s/0034shallow %s/0036unshallow %s/
> +	perl sha256:s/004cshallow %s/004eunshallow %s/
>  	EOF
>  '
>  
> @@ -243,7 +243,7 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
>  	# with an empty packfile. This is done by refetching with a shorter
>  	# depth (to ensure that the packfile is empty), and overwriting the
>  	# shallow line in the response with the unshallow line we want.
> -	printf "$(test_oid sed)" \
> +	printf "$(test_oid perl)" \
>  	       "$(git -C "$REPO" rev-parse HEAD)" \
>  	       "$(git -C "$REPO" rev-parse HEAD^)" \
>  	       >"$HTTPD_ROOT_PATH/one-time-sed" &&
>
> base-commit: 2f268890c2cd2f115424936bbee27f8269080e5e
