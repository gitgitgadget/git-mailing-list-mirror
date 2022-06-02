Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88044C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 13:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbiFBNLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiFBNLg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 09:11:36 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DB713C4EF
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 06:11:33 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y8so4715190iof.10
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wx38kQnbUn69zvvDHGhkFruoCwt7iOi+nyyrxsOJG0I=;
        b=cTmh/2CvFLeyA6mYYS4oPVs85hLtzGbGxuJOzk+vM0xrorrhiPo8SuY8fA7QQJ20Ka
         l5CvYfzO62zMW21VZZv+eVCKrrcvW04jC/3ksrb2QEC2yw7CnhXzRXc2ptz94MZL5yPG
         6/r8hQGSoKBdbCv2682Z1m6LiNHcfCZB8ivPkcW7aglha4vHDJVDluS4b/tiy3OFVEN1
         VOyfKKj641sdbi/NQ/M6bbWfSxHGTTKP76dgGwM4eBUkzSDxiDozeJsgxmz33DEGiDGa
         sevzB0LKqM+O9lLJpQpbfgDhZ5F36gwTMq9g3MO/8hp8JWFbFUwmrZiAZoKwV63jv3t3
         +beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wx38kQnbUn69zvvDHGhkFruoCwt7iOi+nyyrxsOJG0I=;
        b=mlui4Gi4INTvOwi0ZSLHqEyYJrBwC4rAXUM6sN0L5sa4YrSXsOPRkOcchhC+xdDfqe
         sRQ7ghsKPSHBLYV64au+Q3eQfc19xgfWUEOOIbok5tXXn95Jj+NzuRj/o4H+uA4ErHjL
         OqKt2CabBNuanZbVG/gIoBXo4rUeOCb88a1J4Okgj4bhNd6bDiJoFoIFXiSvV0Le4Kbg
         CE3cHtwmH1YFqoST86YzYzdw6cBREfINMA+8RJaRYsxoH8RtxQa1wPoFrqKBDZIk3p5l
         XiO8iGIhbTEUgvtRf4sylXrt/nnPxbxQAa7bbp97A2W7vCUSdX3BOJ4RYewnQD22Eh0x
         Ihsg==
X-Gm-Message-State: AOAM531t+mDb+ypw5kr2SRH5z4/wAAG/ihApAzuFlFQYn5PuPM2ROv1U
        R0+t/lxzQEHgG/dXrCKhs/Ri
X-Google-Smtp-Source: ABdhPJyjI4DCeO/L5Y8cpP5qHtlwROGg0OaeA9JyILz7/xdd73CzVwQs90gYWZOyuX3oXtXfqGwxCQ==
X-Received: by 2002:a05:6638:2392:b0:330:b264:edf1 with SMTP id q18-20020a056638239200b00330b264edf1mr2924076jat.103.1654175492505;
        Thu, 02 Jun 2022 06:11:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id az6-20020a056638418600b00330a4ed20d6sm1168649jab.115.2022.06.02.06.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 06:11:31 -0700 (PDT)
Message-ID: <7b37f3b7-58c5-1ac5-46eb-d995dc3cc33b@github.com>
Date:   Thu, 2 Jun 2022 09:11:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/5] setup.c: create `discovery.bare`
Content-Language: en-US
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
 <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
 <d5a3e9f98450a0d602cf21790b988c1259a3466d.1653685761.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <d5a3e9f98450a0d602cf21790b988c1259a3466d.1653685761.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/2022 5:09 PM, Glen Choo via GitGitGadget wrote:
> +enum discovery_bare_config {
> +	DISCOVERY_BARE_UNKNOWN = -1,
> +	DISCOVERY_BARE_NEVER = 0,
> +	DISCOVERY_BARE_ALWAYS,
> +};
> +static enum discovery_bare_config discovery_bare_config =
> +	DISCOVERY_BARE_UNKNOWN;

Using this static global is fine, I think.

> +static int discovery_bare_cb(const char *key, const char *value, void *d)
> +{
> +	if (strcmp(key, "discovery.bare"))
> +		return 0;
> +
> +	if (!strcmp(value, "never")) {
> +		discovery_bare_config = DISCOVERY_BARE_NEVER;
> +		return 0;
> +	}
> +	if (!strcmp(value, "always")) {
> +		discovery_bare_config = DISCOVERY_BARE_ALWAYS;
> +		return 0;
> +	}
> +	return -1;
> +}

However, I do think that this _cb method could benefit from interpreting
the 'd' pointer as a 'enum discovery_bare_config *' and assigning the
value at the pointer. We can then pass the global to the
git_protected_config() call below.

This is probably over-defensive future-proofing, but this kind of change
would be necessary if we ever wanted to return the enum instead of
simply an integer, as below:

> +
> +static int check_bare_repo_allowed(void)
> +{
> +	if (discovery_bare_config == DISCOVERY_BARE_UNKNOWN) {
> +		discovery_bare_config = DISCOVERY_BARE_ALWAYS;
> +		git_protected_config(discovery_bare_cb, NULL);
> +	}
> +	switch (discovery_bare_config) {
> +	case DISCOVERY_BARE_NEVER:
> +		return 0;
> +	case DISCOVERY_BARE_ALWAYS:
> +		return 1;
> +	case DISCOVERY_BARE_UNKNOWN:
> +		BUG("invalid discovery_bare_config %d", discovery_bare_config);
> +	}
> +	return 0;
> +}

With the recommended change to the _cb method, we could rewrite this as

static enum discovery_bare_config get_discovery_bare(void)
{
	enum discovery_bare_config result = DISCOVERY_BARE_ALWAYS;
	git_protected_config(discovery_bare_cb, &result);
	return result;
}

With this, we can drop the UNKNOWN and let the caller treat the response
as a simple boolean.

I think this is simpler overall, but also makes it easier to extend in the
future to have "discovery.bare=non-embedded" by adding a new mode and
adjusting the consumer in setup_git_directory_gently_1() to use a switch()
on the resurned enum.

> +
> +static const char *discovery_bare_config_to_string(void)
> +{
> +	switch (discovery_bare_config) {
> +	case DISCOVERY_BARE_NEVER:
> +		return "never";
> +	case DISCOVERY_BARE_ALWAYS:
> +		return "always";
> +	case DISCOVERY_BARE_UNKNOWN:
> +		BUG("invalid discovery_bare_config %d", discovery_bare_config);

This case should be a "default:" in case somehow an arbitrary integer
value was placed in the variable. This could also take an enum as a
parameter, to avoid being coupled to the global.

> +++ b/t/t0035-discovery-bare.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +
> +test_description='verify discovery.bare checks'
> +
> +. ./test-lib.sh
> +
> +pwd="$(pwd)"
> +
> +expect_rejected () {
> +	test_must_fail git rev-parse --git-dir 2>err &&
> +	grep "discovery.bare" err
> +}

Should we make a simple "expect_accepted" helper in case we ever
want to replace the "git rev-parse --git-dir" with anything else?

> +
> +test_expect_success 'setup bare repo in worktree' '
> +	git init outer-repo &&
> +	git init --bare outer-repo/bare-repo
> +'
> +
> +test_expect_success 'discovery.bare unset' '
> +	(
> +		cd outer-repo/bare-repo &&
> +		git rev-parse --git-dir
> +	)
> +'
> +
> +test_expect_success 'discovery.bare=always' '
> +	git config --global discovery.bare always &&
> +	(
> +		cd outer-repo/bare-repo &&
> +		git rev-parse --git-dir
> +	)
> +'
> +
> +test_expect_success 'discovery.bare=never' '
> +	git config --global discovery.bare never &&
> +	(
> +		cd outer-repo/bare-repo &&
> +		expect_rejected
> +	)
> +'
> +
> +test_expect_success 'discovery.bare in the repository' '
> +	(
> +		cd outer-repo/bare-repo &&
> +		# Temporarily set discovery.bare=always, otherwise git
> +		# config fails with "fatal: not in a git directory"
> +		# (like safe.directory)
> +		git config --global discovery.bare always &&
> +		git config discovery.bare always &&
> +		git config --global discovery.bare never &&
> +		expect_rejected
> +	)
> +'
> +
> +test_expect_success 'discovery.bare on the command line' '
> +	git config --global discovery.bare never &&> +	(
> +		cd outer-repo/bare-repo &&
> +		test_must_fail git -c discovery.bare=always rev-parse --git-dir 2>err &&
> +		grep "discovery.bare" err
> +	)

Ok, at the current place in the series, this test_must_fail matches
expectation. If you reorder to have this patch after your current patch 4,
then we can write this test immediately as a successful case.

We could also reuse some information from the expect_rejected helper by
adding this:

expect_rejected () {
	test_must_fail git $* rev-parse --git-dir 2>err &&
	grep "discovery.bare" err
}

Then you can test the -c options in the tests as

	expect_rejected -c discovery.bare=always

Thanks,
-Stolee
