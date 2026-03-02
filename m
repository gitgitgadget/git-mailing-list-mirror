Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085413FB06B
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465513; cv=none; b=smn5MW6I3Gvv+YB+dA7y+Ds0JKY17VPnLaddUzBu2dLT+9A3ohKBLZakJwyZ+MuRuGVLEy5AVLzRB03CmVwx/UxtlvS5VuHks/KkOKWF8gpbXzYX76SakJQ3Uqu/XiqfP3QosOVy2b/VAre8Ev5evM0polfXo8fgzKq+d3lDuCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465513; c=relaxed/simple;
	bh=03CKK824jhpNZz2pX0g9bcnWZHL8r7V8DOA5Q1fzdVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTlkRF6yq/QMHnh8uySGw79sdB3ju6eub2JGwG/jcHRcBtxWO5Ssm4Z1xqFErPyyAZLQdg0m8dAiWsTcSLCRCqrFtequ20dDfmdQPFK9FPUA9tE0s0p4caWEQ08Q+lRKuCgzwCL5LdBM5qn99xOFVaFB9Oh2l7k66P6t2z11H80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQg9TAy/; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQg9TAy/"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-94dd06a96easo3070308241.2
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 07:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772465511; x=1773070311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyOfm+ZR+ctr2LF//8gqOhHp3TS/5lFDBDufMZEh6YQ=;
        b=GQg9TAy/o2QAsYQuGIkthemFVfjHrhGDRDAJ2kuQ/mjcVVkc07Amy3R8Xp7Iy3AlFe
         eNucwHgR11IPdB0xNGh151H6pDOSax7MWFYWymBFUxafvU1KL+3A1N5NLJrUeV4yCz7e
         tmn80C3yZMkhqd090wNqoy6uKcqRVhkGS8ZIHtCLzMDmr/4YqA8XlIe3WFRFmrlhfwkt
         4HnAL8KI5GK2wPrtFzQ6v+EFmQcsIm8qEhBeEcj3yU/t2TMB3UM2J+QWwR+UchvElyK0
         /F8XCzY9ckUPXcu54jOOZ1v8/3L9EmDGtEqlvNIaz9ahNVYcU/dHItb9NDA5tHa/mDIb
         ALtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465511; x=1773070311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyOfm+ZR+ctr2LF//8gqOhHp3TS/5lFDBDufMZEh6YQ=;
        b=EUCkLC2qkaQKiprAquJzkKBPpovhwYFYqUHlSE+ZjODDBFHPRSF1C/WFA4NqF2Ljid
         NHfe54GULQkBk9TuSAijn3ApQadw3yc9mXSZh+Lj3p06HaMVYPYAesW//CI7Ukdy2mpP
         1YkGQQd+eHP9108FxbLkACdq7EoHs9BMaXduey8vkK+c8xA7LLXW06KSKUOyW2yesekK
         EzXSV3LPlzw0lT4sO92P/2CuKDxY2vNFpHojZR5mrvHwh7kCscP0/9A+vwnw4A+1yXnF
         vVZH1fb2Q9vjJHEgVwhtW57wWAUwUm5uWOBFR0oXaK+uJKuNg2LrPAB3GXMBpKZxTaAX
         Gi7g==
X-Forwarded-Encrypted: i=1; AJvYcCUelUu506HH0DFnWl/w8X2Sen2BsMbEHEcJbjHXw9QK0VmOstP69c1XZcdoW+A8SPLtlT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfYdmEqFh+bPTy3qQt5838Q/Wi2nDykzmrGM7R1gAtOP7X9NF
	kMqmZMUKwGO7Mnk/6I2Xmrqlq0iEMRNpYDf4AzpoqGCIBLP+gNBgA0DF
X-Gm-Gg: ATEYQzzs2GKbvct3T5k5Rba0GQC6yuw4Ym7amkinR7QfO6S7VKJlpRrvLZeQF+i3DVN
	UeEpGlYfKbXg+JZrbVVGAJny9dht4C/Rq4dCmsCnyNJwDOcYVxPoO+uv+MXVTSV22mtRqeCHnhx
	wxOBDGKONi5KEv4rLPXPiBMKtdxtKuR/wpyGj0sX7Q3bRglsgm9cj/mU1T64fhRdBq5z531QNxx
	ZekSjlU5w1I7Qnx0Abh0ZYbndcr4hY4w2EkmJt+iPjPNLtsuYQc1SUI5vBxatAyNH36xBLPqf4N
	f+tmkriQ67iK4ePJxmks5a0ReVeU5+qJi+jpiOqI2cFdrhDc1Xl9LRKs0ASkk7wFeTnqcMV41K+
	ycr4EXFF6WHoTjsSe/wELFybO2sPgVkFApZqYFo3bzv+j3qcbCm2wZdV/gq5IelFurWHocCI0n+
	6xyeKp4B/ELLwkSbdYw9Ifwi8J3Qv+1hbdIrV70dWbIyAbiYNzORgcaJHdzKMo7OR8Z649bQ==
X-Received: by 2002:a05:6102:548a:b0:5f5:5c93:8733 with SMTP id ada2fe7eead31-5ff3227ca52mr6133265137.6.1772465510512;
        Mon, 02 Mar 2026 07:31:50 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf564c27sm1171502285a.0.2026.03.02.07.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:31:49 -0800 (PST)
Message-ID: <cd9adbd9-b996-46da-b6a8-d2395be79a0f@gmail.com>
Date: Mon, 2 Mar 2026 10:31:48 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, fastcat@gmail.com,
 Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
 <xmqqv7flervq.fsf@gitster.g> <eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>
 <20260225131344.GA2139176@coredump.intra.peff.net>
 <08c6e203-3444-45c7-9bc9-cc2590be30c3@gmail.com>
 <20260227224238.GA2956443@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260227224238.GA2956443@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/2026 5:42 PM, Jeff King wrote:
> On Thu, Feb 26, 2026 at 10:29:47AM -0500, Derrick Stolee wrote:
> 
>> Great point. Here's another attempt:
>>
>> static int run_command_on_repo(const char *path, int argc, const char ** argv)
>> {
>> 	int i = 0;
>> 	struct child_process child = CHILD_PROCESS_INIT;
>> 	char *abspath = interpolate_path(path, 0);
>>
>> 	while (local_repo_env[i]) {
>> 		/*
>> 		 * Preserve pre-builtin options:
>> 		 * - CONFIG_ENVIRONMENT, CONFIG_DATA_ENVIRONMENT, and
>> 		 *   CONFIG_COUNT_ENVIRONMENT persist -c <name>=<value>
>> 		 *   and --config-env=<name>=<envvar> options.
>> 		 * - NO_REPLACE_OBJECTS_ENVIRONMENT persists the
>> 		 *   --no-replace-objects option.
>> 		 *
>> 		 * Note that the following options are not in local_repo_env:
>> 		 * - EXEC_PATH_ENVIRONMENT persists --exec-path option.
>> 		 */
>> 		if (strncmp(local_repo_env[i], "CONFIG_", 7) &&
>> 		    strcmp(local_repo_env[i], NO_REPLACE_OBJECTS_ENVIRONMENT))
>> 			strvec_push(&child.env, local_repo_env[i]);
> 
> This is slightly different than what prepare_other_repo_env() does:
> 
>   - it doesn't drop GIT_CONFIG_*, but assumes that removing
>     GIT_CONFIG_COUNT is enough for GIT_CONFIG_KEY/VALUE to be ignored
>     (and then also removes GIT_CONFIG_PARAMETERS, of course)
> 
>   - it doesn't consider NO_REPLACE_OBJECTS at all
> 
> I think you could make arguments either way about what should happen
> when spawning a command in another repo. But I'd really prefer for us to
> have a single spot to specify that policy, and not subtly-different
> behavior from different commands. So I'd really like to see this using
> that other function (or the logic from it factored out into a helper).

I agree that it would be best to have a single place.

I was looking at prepare_other_repo_env() and saw that it requires a
computed gitdir, which is not easy to compute. We want the child process
to perform that discovery based on the -C parameter.

However, we can extract the existing environment clearing logic and use
that here. I'll give that a try and confirm that it passes the tests
that I prepared to fix the bugs in this version.

> And then we can consider whether to make changes to that policy.
> 
> Dropping GIT_CONFIG_* from the environment does make sense in general,
> but it doesn't actually happen with the patch above (because only
> GIT_CONFIG_COUNT is in the local_repo_env list; to find the others we'd
> have to actually enumerate the current environment).

It has GIT_CONFIG (the local Git config file), GIT_CONFIG_COUNT, and
GIT_CONFIG_PARAMETERS. My patch was wrong because of the string, showing
the value in having tests to confirm the right behavior.

> For NO_REPLACE_OBJECTS, I think you could argue that it should not be in
> local_repo_env at all. It is more about the operation being performed,
> not the repository itself. So for example in this command:
> 
>   git --no-replace-objects fetch
> 
> I would expect that NO_REPLACE_OBJECTS to make it down to any submodule
> fetches we do. Likewise for other operation-level variables like
> GIT_LITERAL_PATHSPECS, but those are already (correctly IMHO) omitted
> from local_repo_env.
> 
> It looks like NO_REPLACE_OBJECTS got pulled from the connect.c code in
> 48a7c1c49d (Refactor list of of repo-local env vars, 2010-02-25). And I
> could see somebody wanting to make sure that upload-pack behaved
> predictably with respect to replace refs, but it already does: it
> disables replace refs itself as part of its startup code.

OK. I won't special case this myself and will let this be changed
independently, if that is indeed valuable.

>> This comment details my findings from comparing the list in
>> local_repo_env[] and the top-level options listed in
>> Documentation/git.adoc. That's how I was able to find that
>> --exec-path sets an environment variable that's NOT in the
>> list and we want to be sure we don't set it.
>>
>> Should we add the comparison to EXEC_PATH_ENVIRONMENT as a
>> precaution to make sure it's not added to local_repo_env in
>> the future? Or is that too defensive?
> 
> I don't think we need to bother. Obviously adding it to local_repo_env
> would be the wrong thing, but that is true of lots of variables. Trying
> to make a list is just going to result in a list that is out-of-date,
> because there's nothing pushing people to update it when they introduce
> a new variable.

This is where I was landing, too.

> You can imagine a different world, where we had a single list of all
> environment variables, and new ones _had_ to be added to the list in
> order to function, and each entry had a bitflag for "this is a
> local-repo value", then that might force each new addition to consider
> whether it should be added. But we don't have such a list, and I think
> structuring things that way would introduce new complications and
> awkwardness.

This makes sense. In the meantime, having a single place that unsets
environment variables for certain child processes is good enough to
cover what we need here.

Thanks,
-Stolee

