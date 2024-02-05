Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A3828E1B
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149804; cv=none; b=lXWD3YXOXWetDSJTIU1clG29d5NpMQSPsJnvFwvvK13ktWSi35LOVVaX14lM6GCzu1GvUvsBiDMJCxcB+GUMJKH+BXot6sXqDg+xj6/jsGeQSTG2zYqA3Ot1fbNHFo8w7nYeu8h0HQF8tDBpOmOl6YFdV+2HcVhDJVhK1n6lCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149804; c=relaxed/simple;
	bh=B6zt2l5anuhky63f1zsT24Of3PiVSgvMpGQsY3bXx/Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=vEEn24N9uArhO99gD+YHKK2G4qBeMmvxFrASYU3aosJhsv/B7bb9AeuZelqFGKHEFd5j96+rfWZ2jiqo4v4jbH3qgOU4xBUWUnZ6LVfTFaw+GyVA64Ks+SpP5BSNeq3sWe7Zk5JOLWcD5gvL7uWvY/2tKGnrnk4Y9+TUpXF4aHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTD+Xfqq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTD+Xfqq"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fb804e330so41970645e9.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 08:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707149801; x=1707754601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ipbfzFoq+yoLETNup7NLDANVqPeJsGY51Lt+VBF9S8=;
        b=BTD+XfqqLDWA8xEc866GibiRFkx+K5s6UqSSa9qs0bnPOQohrZY5GPqJhwm6aXblLK
         bFcUqOmWBzj2u/3A0FTZwoNpK4X6aOVfp5xFvxJV/QlX2aEBwFA1QJtu9ZYZd+j67quY
         jFwpBiFXW1a1gYz0v2EaL6lMwvGv1lPOAI5Ook2sm78TDAQuduuRD1obs+6WG9hAhMc9
         iuQZi1mamlfxs3k0OuHjnTKxQEutL7ld7CIseo5BR3byGj8L3E7y4oec914Bdjv5olg6
         w/4vXtWNDfLYyIiVGTC0jNj+qiG1//xdJCq5D7odCi+AAHSNggc2R2UHbquQCbBJ6J0N
         zcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149801; x=1707754601;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ipbfzFoq+yoLETNup7NLDANVqPeJsGY51Lt+VBF9S8=;
        b=vQQNf5DXxdemXGRTALJdvi2JW2Vp40duw84NyBZ86HQQza5sDjmAKqNCfQ+BgXPCBW
         oH+HRMizftfAHx5Ze8t3ENeo2ChTeN07FJXWIyeSB+Ch4NgQhK8JzuxpRIA7WUc5TX1+
         xmCUuKlhdsx8SKrRiDGeh4wzwRip0x10z6zsoYcLplD/Upz1WIkDMWQRPKkUvQRQRSFN
         km8RBc2GFGbNjXGCwh/mAYTBVc0m89LWmvyXOPHhIIoxcOf4ryvAMMYgJ3HR+FZuQ4Dq
         hXp99U9Pr2aLsAL+gL2Q3L34+Hc+hvR2rUANHbFvoa/woW1exp2x8MiAkV18KEbBVe03
         9qgw==
X-Gm-Message-State: AOJu0YwiB1mm/DtgFOgMbjuEyCzqqYcEwnPmC/3AKxgzMpTa4M20hYl/
	22fP12fLkFCmE2LwJr3SW+5EUFS512XCqnTZwBFh7jTF7/e1nHYU
X-Google-Smtp-Source: AGHT+IFfbtuaz7guGA3pOEtB73OYfWAfCj3Wh3MtjdtWu1pTaPXMwegtOuWiAjh1jOcMfVLLcLVc/Q==
X-Received: by 2002:a05:600c:1d8a:b0:40f:5c3a:bbb0 with SMTP id p10-20020a05600c1d8a00b0040f5c3abbb0mr153746wms.23.1707149800535;
        Mon, 05 Feb 2024 08:16:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWcG5W5OHZC8LRXXyfQfVit/s9xQqnk9ICroPpoNkmuc/CsW8eiO6BlueXkCqHUyIcVaObB5KLPZNHebS8WDTj6/22XoQSzNEZNiMoRa82ySPmDq4lEaaMI0d6N7115kVua2Z2n2enzclDKjy8lfbEMV1YaG5W/Pph4510pGqY7ENE=
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b0040ef95e1c78sm9183287wmb.3.2024.02.05.08.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 08:16:40 -0800 (PST)
Message-ID: <4e2cbadd-1e0c-4526-a50f-9ba8600e7788@gmail.com>
Date: Mon, 5 Feb 2024 16:16:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 4/6] test-tool run-command testsuite: support unit
 tests
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk,
 gitster@pobox.com
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <b5665386b56df91fa5d95ee5b11288b5853546f0.1706921262.git.steadmon@google.com>
Content-Language: en-US
In-Reply-To: <b5665386b56df91fa5d95ee5b11288b5853546f0.1706921262.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh

On 03/02/2024 00:50, Josh Steadmon wrote:
> Teach the testsuite runner in `test-tool run-command testsuite` how to
> run unit tests: if TEST_SHELL_PATH is not set, assume that we're running
> the programs directly from CWD, rather than defaulting to "sh" as an
> interpreter.

Judging from the last patch in this series it seems likely that we'll 
want to run unit tests and integration tests parallel. In which case it 
might be better to look at the filename extension to decide whether to 
sh as an interpreter so that we can avoid having to use a wrapper 
script. Then

     cd t
     helper/test-tool run-command testsuite 't[0-9]*.sh' 'unit-tests/bin/*'

would run the integration tests via "sh" and the unit-tests directly. 
We'd need to figure out how to look for tests in both directories as 
well though...

Best Wishes

Phillip

> With this change, you can now use test-tool to run the unit tests:
> $ make
> $ cd t/unit-tests/bin
> $ ../../helper/test-tool run-command testsuite
> 
> This should be helpful on Windows to allow running tests without
> requiring Perl (for `prove`), as discussed in [1] and [2].
> 
> This again breaks backwards compatibility, as it is now required to set
> TEST_SHELL_PATH properly for executing shell scripts, but again, as
> noted in [2], there are no longer any such invocations in our codebase.
> 
> [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet/
> [2] https://lore.kernel.org/git/850ea42c-f103-68d5-896b-9120e2628686@gmx.de/
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>   t/helper/test-run-command.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index e6bd792274..a0b8dc6fd7 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -158,6 +158,8 @@ static int testsuite(int argc, const char **argv)
>   		.task_finished = test_finished,
>   		.data = &suite,
>   	};
> +	struct strbuf progpath = STRBUF_INIT;
> +	size_t path_prefix_len;
>   
>   	argc = parse_options(argc, argv, NULL, options,
>   			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> @@ -165,9 +167,14 @@ static int testsuite(int argc, const char **argv)
>   	if (max_jobs <= 0)
>   		max_jobs = online_cpus();
>   
> +	/*
> +	 * If we run without a shell, we have to provide the relative path to
> +	 * the executables.
> +	 */
>   	suite.shell_path = getenv("TEST_SHELL_PATH");
>   	if (!suite.shell_path)
> -		suite.shell_path = "sh";
> +		strbuf_addstr(&progpath, "./");
> +	path_prefix_len = progpath.len;
>   
>   	dir = opendir(".");
>   	if (!dir)
> @@ -180,13 +187,17 @@ static int testsuite(int argc, const char **argv)
>   
>   		/* No pattern: match all */
>   		if (!argc) {
> -			string_list_append(&suite.tests, p);
> +			strbuf_setlen(&progpath, path_prefix_len);
> +			strbuf_addstr(&progpath, p);
> +			string_list_append(&suite.tests, progpath.buf);
>   			continue;
>   		}
>   
>   		for (i = 0; i < argc; i++)
>   			if (!wildmatch(argv[i], p, 0)) {
> -				string_list_append(&suite.tests, p);
> +				strbuf_setlen(&progpath, path_prefix_len);
> +				strbuf_addstr(&progpath, p);
> +				string_list_append(&suite.tests, progpath.buf);
>   				break;
>   			}
>   	}
> @@ -213,6 +224,7 @@ static int testsuite(int argc, const char **argv)
>   
>   	string_list_clear(&suite.tests, 0);
>   	string_list_clear(&suite.failed, 0);
> +	strbuf_release(&progpath);
>   
>   	return ret;
>   }
