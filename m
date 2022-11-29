Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89609C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiK2BDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiK2BDT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:03:19 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C262629365
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:03:18 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g10so11885117plo.11
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ao+YkYF1yhQ0SGnLj1d2eIluMDfGZ6rDWtUSUpJwJGA=;
        b=csc97ztSgz3ll/6sG4KxVqAr7t7vLBhv0z2TUZmHYiyt+uo/Ad3dYl2eygUwi6cL49
         NIwZBqSUCG8h/IiB2u0oP6Yh4mmPBCHb/GxwjP2j1CoffS1naHBskF0YTwSgxXZTBs/6
         1WkTJG7mxYNjz982f2F2EkI2arkcdMA69Mzb+6xRwVOdxgGk7pSfqMScEsd4NHqoNMbe
         lkjFLQnKCp+kzoBw+ZImznyIMv+YVlaXcqNYN2m6+OfLtApBcqFZLWlK2U2KYH+OAYuO
         FoTOzVfPnx/FGc5BIj2fpTwNpLjY9bKop5Rq+8MplT3euxDhSECiLFeLHcxsz/0URj4l
         dw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ao+YkYF1yhQ0SGnLj1d2eIluMDfGZ6rDWtUSUpJwJGA=;
        b=O4Q8+WwBK6e6YdENMp45+Ye2zkCBJVWSzyPHc6CDftoRU23DwLWf536AuXLXZDZtF1
         Efp1RxTyP5bHV7B/006rzv7z52+UukU5S7SNpQFQbM1q7xCoPGJ9XBTzFn4n1WrqVAtF
         gJCFEjDn5ijrabC9HP0jFAqiQLO5HjAVKTFfXH3E0nyZjgTyMQLx7JQVk58tv3fRe/3U
         m2M+CuUO/hosaoBHzFZwN2XhjoBxLg6vGEBSafCMJ//Hy+uh+vc9hEBRkZEyyDSKtPqv
         /Mf4/MBE429GA0esAgkd4YP1PCxusI0rEGUyJkbbvPnE1IehZVwuhdUsDAPCIDh9N9KC
         w3uA==
X-Gm-Message-State: ANoB5pl6VfnB/6iBpzU5PoQacz22uh4j3DYJCcAR1rewnxq2VBeElzz/
        ukcFZHzQ599rRvWV9xxWcYsm
X-Google-Smtp-Source: AA0mqf5NE27tXaZq8ssTZQVSoYRPaih1GOZVGD2JPTMjVBh68oa2s+AO0t/uaqH9sgVkAh61DSAaQw==
X-Received: by 2002:a17:90b:2689:b0:218:a059:1c71 with SMTP id pl9-20020a17090b268900b00218a0591c71mr46303347pjb.7.1669683795722;
        Mon, 28 Nov 2022 17:03:15 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0017e64da44c5sm9384802plb.203.2022.11.28.17.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 17:03:15 -0800 (PST)
Message-ID: <4ec06afa-d804-16b1-f140-dfd9ebd912e5@github.com>
Date:   Mon, 28 Nov 2022 17:03:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 5/9] bundle-uri client: add boolean transfer.bundleURI
 setting
Content-Language: en-US
To:     =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <933974689312bbb130236c81550ee3467f295a43.1668628303.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <933974689312bbb130236c81550ee3467f295a43.1668628303.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
> From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
>  <avarab@gmail.com>
> 
> The yet-to-be introduced client support for bundle-uri will always
> fall back on a full clone, but we'd still like to be able to ignore a
> server's bundle-uri advertisement entirely.
> 
> The new transfer.bundleURI config option defaults to 'false', but a user
> can set it to 'true' to enable checking for bundle URIs from the origin
> Git server using protocol v2.

Thanks for adding this, an "opt-in" approach seems reasonable for
introducing this feature.

> 
> To enable this setting by default in the correct tests, add a
> GIT_TEST_BUNDLE_URI environment variable.

This makes sense. I'm less concerned with this environment variable than
those in patch 2 [1], since it's in line with the test variables that
enable/disable whole features ('GIT_TEST_SPLIT_INDEX',
'GIT_TEST_COMMIT_GRAPH', etc.). 

The only thing feedback I can think of would be that this patch could be
moved to earlier in the series (that is, immediately after creating
'transport_get_remote_bundle_uri()'). That said, I don't feel strongly
either way.

[1] https://lore.kernel.org/git/ca410bed-e8d1-415f-5235-b64fe18bed27@github.com/

> 
> Co-authored-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>

The implementation and documentation below align with the commit message.
Looks good!

> ---
>  Documentation/config/transfer.txt     |  6 ++++++
>  t/lib-t5730-protocol-v2-bundle-uri.sh |  3 +++
>  transport.c                           | 10 +++++++---
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
> index 264812cca4d..c3ac767d1e4 100644
> --- a/Documentation/config/transfer.txt
> +++ b/Documentation/config/transfer.txt
> @@ -115,3 +115,9 @@ transfer.unpackLimit::
>  transfer.advertiseSID::
>  	Boolean. When true, client and server processes will advertise their
>  	unique session IDs to their remote counterpart. Defaults to false.
> +
> +transfer.bundleURI::
> +	When `true`, local `git clone` commands will request bundle
> +	information from the remote server (if advertised) and download
> +	bundles before continuing the clone through the Git protocol.
> +	Defaults to `false`.
> diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
> index 000fcc5e20b..872bc39ad1b 100644
> --- a/t/lib-t5730-protocol-v2-bundle-uri.sh
> +++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
> @@ -1,5 +1,8 @@
>  # Included from t573*-protocol-v2-bundle-uri-*.sh
>  
> +GIT_TEST_BUNDLE_URI=1
> +export GIT_TEST_BUNDLE_URI
> +
>  T5730_PARENT=
>  T5730_URI=
>  T5730_BUNDLE_URI=
> diff --git a/transport.c b/transport.c
> index 86460f5be28..b33180226ae 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1538,6 +1538,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
>  
>  int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
>  {
> +	int value = 0;
>  	const struct transport_vtable *vtable = transport->vtable;
>  
>  	/* Check config only once. */
> @@ -1545,10 +1546,13 @@ int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
>  		return 0;
>  
>  	/*
> -	 * This is intentionally below the transport.injectBundleURI,
> -	 * we want to be able to inject into protocol v0, or into the
> -	 * dialog of a server who doesn't support this.
> +	 * Don't use bundle-uri at all, if configured not to. Only proceed
> +	 * if GIT_TEST_BUNDLE_URI=1 or transfer.bundleURI=true.
>  	 */
> +	if (!git_env_bool("GIT_TEST_BUNDLE_URI", 0) &&> +	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
> +		return 0;
> +
>  	if (!vtable->get_bundle_uri) {
>  		if (quiet)
>  			return -1;

