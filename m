Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CFCC4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiK2B7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiK2B7T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:59:19 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55815450BF
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:59:17 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 9so12289808pfx.11
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCyTdrhk1yo/d0muVxMeHzAC9b1+08XRetUwKFhuxOQ=;
        b=DtK40+xjhsqFzhVvP27R6ROfsJDjlgMiLtslcK3S3DFHPh/s+IOZb4h1Xf+5CGUlSt
         HAy0hhxpBVGzw0XC93zhWHrLhBLadTWLUln7jTahWoRofQumk8RxlRTJVPdJXuyRDE/R
         mz5I6kZ9cKpbK2cNi0WQHmzWNHxjMcgqG7UB4i7vQBKzBO1YcN+YHFJOpwfWol81qfBT
         GSSrnxOHhyWg5ZZf3UDp2nDeaeAjSuSRhSQC+SGyOGVHeWIhq2Po8hg2r6+hfXkO3QpJ
         K4SBlCMZAE51h7b28BJ4iG6NuvVJVljao56Of4pR16UXuPTP5/3HW/NQLcMQLcXxC1dq
         Q0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCyTdrhk1yo/d0muVxMeHzAC9b1+08XRetUwKFhuxOQ=;
        b=QTcfQE/WIP6Mycm1eAQVWpOX1xeIa6Cy3yDvDbbXFTnpZnYVjL0pcMFl0xvViFBR4A
         YtoELJlyetVcCttrOYoCc0tCmzxKeH85dM6eH1uLILaigB6mWC+wR0gGnzKMCjKrL870
         Dso2wuU8AVsH6XhrpZFiT8i2Rwx4EWBgjWAq8kPI9CIOAXD9FCSWg+p3BUjJFsTQkuP0
         uVWdCtYShTmb7EfcQ0IPpyroPPfkoUheDkYPElgx1jWK9FYrSe+Os0QPsbt1TlUzRGYt
         RKD3F6r+BPQDH95ER5r4SdQu1ZhRusol3D17W7OIgN0dbj55gCm5PztmGUWJjqct370G
         KH2w==
X-Gm-Message-State: ANoB5pmmWJKd1rA9a4CeMrtRyE8K4lzMmZbHYuqL6cOxnDzynv2StC8V
        /FriUoXYk9XozO7wfn5890Ou
X-Google-Smtp-Source: AA0mqf5zo6WzkQ26mKC2L4fQRdw/EHMHpY0pIOiMVTOZO7BCVNxZlSxUZUHmhYLjcFj7CMGE/uX8ew==
X-Received: by 2002:aa7:95b7:0:b0:548:4e65:348d with SMTP id a23-20020aa795b7000000b005484e65348dmr34660771pfk.56.1669687156836;
        Mon, 28 Nov 2022 17:59:16 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id y75-20020a62644e000000b0056ee49d6e95sm8658946pfb.86.2022.11.28.17.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 17:59:16 -0800 (PST)
Message-ID: <9522d667-da4d-6eb0-8f1c-1396ebc0351c@github.com>
Date:   Mon, 28 Nov 2022 17:59:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 9/9] clone: unbundle the advertised bundles
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <b62b4b1748194f0c7b81536701f15aa0df8e1d9b.1668628303.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <b62b4b1748194f0c7b81536701f15aa0df8e1d9b.1668628303.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> A previous change introduced the transport methods to acquire a bundle
> list from the 'bundle-uri' protocol v2 command, when advertised _and_
> when the client has chosen to enable the feature.
> 
> Teach Git to download and unbundle the data advertised by those bundles
> during 'git clone'.
> 
> Also, since the --bundle-uri option exists, we do not want to mix the
> advertised bundles with the user-specified bundles.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/clone.c  | 26 +++++++++++++++++----
>  t/t5601-clone.sh | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 22b1e506452..09f10477ed6 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1267,11 +1267,27 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (refs)
>  		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
>  
> -	/*
> -	 * Populate transport->got_remote_bundle_uri and
> -	 * transport->bundle_uri. We might get nothing.
> -	 */
> -	transport_get_remote_bundle_uri(transport, 1);
> +	if (!bundle_uri) {
> +		/*
> +		* Populate transport->got_remote_bundle_uri and
> +		* transport->bundle_uri. We might get nothing.
> +		*/
> +		transport_get_remote_bundle_uri(transport, 1);
> +
> +		if (transport->bundles &&
> +		    hashmap_get_size(&transport->bundles->bundles)) {
> +			/* At this point, we need the_repository to match the cloned repo. */
> +			if (repo_init(the_repository, git_dir, work_tree))
> +				warning(_("failed to initialize the repo, skipping bundle URI"));
> +			if (fetch_bundle_list(the_repository,
> +					      remote->url[0],
> +					      transport->bundles))

If the repo initialization fails, this line is still executed. Should the
condition be 'else if' to avoid that?

Otherwise, all of the added logic looks good to me.

> +				warning(_("failed to fetch advertised bundles"));
> +		} else {
> +			clear_bundle_list(transport->bundles);
> +			FREE_AND_NULL(transport->bundles);
> +		}
> +	}
>  
>  	if (mapped_refs) {
>  		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 45f0803ed4d..d1d8139751e 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh

Per the commit message:

> Also, since the --bundle-uri option exists, we do not want to mix the
> advertised bundles with the user-specified bundles.

Could you add a test verifying that '--bundle-uri' causes 'clone' to skip
bundle URI auto-discovery? It's clear from the implementation above that
'clone' is currently doing that as-expected, but it might be nice to have
the test for regression testing purposes.

> @@ -795,6 +795,65 @@ test_expect_success 'reject cloning shallow repository using HTTP' '
>  	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo
>  '
>  
> +test_expect_success 'auto-discover bundle URI from HTTP clone' '
> +	test_when_finished rm -rf trace.txt repo2 "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
> +	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/everything.bundle" --all &&
> +	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" &&
> +
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
> +		uploadpack.advertiseBundleURIs true &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
> +		bundle.version 1 &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
> +		bundle.mode all &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo2.git" config \
> +		bundle.everything.uri "$HTTPD_URL/everything.bundle" &&
> +
> +	GIT_TEST_BUNDLE_URI=1 \
> +	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
> +		git -c protocol.version=2 clone \
> +		$HTTPD_URL/smart/repo2.git repo2 &&
> +	cat >pattern <<-EOF &&
> +	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/everything.bundle"\]
> +	EOF
> +	grep -f pattern trace.txt
> +'
> +
> +test_expect_success 'auto-discover multiple bundles from HTTP clone' '
> +	test_when_finished rm -rf trace.txt repo3 "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" &&
> +
> +	test_commit -C src new &&
> +	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/new.bundle" HEAD~1..HEAD &&
> +	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" &&
> +
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
> +		uploadpack.advertiseBundleURIs true &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
> +		bundle.version 1 &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
> +		bundle.mode all &&
> +
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
> +		bundle.everything.uri "$HTTPD_URL/everything.bundle" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo3.git" config \
> +		bundle.new.uri "$HTTPD_URL/new.bundle" &&
> +
> +	GIT_TEST_BUNDLE_URI=1 \
> +	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
> +		git -c protocol.version=2 clone \
> +		$HTTPD_URL/smart/repo3.git repo3 &&
> +
> +	# We should fetch _both_ bundles
> +	cat >pattern <<-EOF &&
> +	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/everything.bundle"\]
> +	EOF
> +	grep -f pattern trace.txt &&
> +	cat >pattern <<-EOF &&
> +	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/new.bundle"\]
> +	EOF
> +	grep -f pattern trace.txt
> +'
> +
>  # DO NOT add non-httpd-specific tests here, because the last part of this
>  # test script is only executed when httpd is available and enabled.
>  

