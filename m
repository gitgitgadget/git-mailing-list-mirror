Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7041C68
	for <git@vger.kernel.org>; Fri, 17 May 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963279; cv=none; b=RSV+YepF/Pllzb3Kr3H6BXITBjB9meCFdlpZMzL3wiWLaU3SpuGMI01wO7xnpW2159TngH8TwfxtC4eqPcTR9KVutca04RGZl6G0Jq03tGcgIE9+smIKeM21U9joDZlDs/HOQXAuVlieZCsx1+K88hh1bllhPhKARYFiZXKhcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963279; c=relaxed/simple;
	bh=OpA7f7m6dRBGmlbYsMn+HtvGBzfdD3W+00yfpl/qMVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvOrZyqE/YnuXUGwlQ3q5S4svD8IyCisgJ8T3YA6tslAZykSHQsAYjH4BE8/bCLV30OpG1AExJzMlhpSunEKbk2HQeZ6+8kaW32tPC8zP6BM9zZQv4ayhIswCmEl4k3zD08p6aIkLmPyskLSXhEuOq5oUGMp0erTPuZBM8xZX3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMLmiAbc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMLmiAbc"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4202cea9941so2578205e9.1
        for <git@vger.kernel.org>; Fri, 17 May 2024 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715963276; x=1716568076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gmuXMczf7FmiRUVibgndYfqIdViNHuD6gZ8iexJGFw=;
        b=BMLmiAbcA4ob0GHY/MgoxsvX6Y9LCIMLZzHIiRkGsfSa32YflqopPa9zxmsv7Mhj3T
         y+afKflozyuQts3jwKQAEawxXLkC16CI7xDMSZyLPDjNFM2LoMY9VQlaSAPrFkSuo8tj
         GtAzVPkLSG7Z5vf2SPjSVVvNagU7mxuQD3DNoKipyNn86ebtQa8V21IljWC8A2xTM1oW
         gAYy5aqpNRYRSf/auoFmXsTUJAYQ94fexuKBXH4Ix7CkCXc+iHeoLPDfG4VED7/KZ98S
         GHCOyi6M89+UEnk4Q7kqII1ibyXHUpTLj0Y1De91g7Q9HmsF2mj0cVZ6ijBRWExJygQe
         J6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715963276; x=1716568076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmuXMczf7FmiRUVibgndYfqIdViNHuD6gZ8iexJGFw=;
        b=sML4fd79SwusCtBoVnitJ17h5DMBE7jkFG2VdAgsh++34VfHSTjyLwAJ/en+wWfwdX
         cpRmX4Be/dJZKfJqLVBnrQStqmMIB2y1wtcyHf76eeWlqLiYOI6QXux9L3ebmt5hiAUW
         UGnVHsBcS8h1Sifj28z0JrCYRj6QyULXjAmRdse1eo3fPmHlakRyW+dP8sKW4ktZs5uA
         W82SRbRe6W+CZYx2EtoLoCJ31OFTA+1iK80/ui+8C9a6edChjUdCDo0Svs6TIR7+rgEw
         9boQ1bRA80YBoU0P47+9ZtFxbrHyHWSF/W1evy+Ro781dnJTe+ZyYW6F7jRh4W2vzDeR
         NUjg==
X-Forwarded-Encrypted: i=1; AJvYcCXeRc88wjka+y3G2avmL1dqZjkGLwHuD4Km6qameRbPCHNFb6ivJAEKh+rXZSWqmi2ksRI66/p5YBR5Xe142M+qK/27
X-Gm-Message-State: AOJu0YzBW4xwu1P5QANGWNk4ed9oCQ1rf8rqf5LxeKYe6jyDSBcmsAte
	KlFZY66yu3HSuyYkhc5DsxgNoW6h3PGO1Z9ltHXhkmmaIX5pGU3y
X-Google-Smtp-Source: AGHT+IEuVk+iWW9hVMz0HBBEjS58zZRQb9gwd+G1Ku4Aj9I946lRkxJP/cdl6zmRI+9RHTZ4gJIVNw==
X-Received: by 2002:a05:600c:4f83:b0:418:2ccf:cbc7 with SMTP id 5b1f17b1804b1-41feaa2f473mr163282645e9.2.1715963276235;
        Fri, 17 May 2024 09:27:56 -0700 (PDT)
Received: from gmail.com (93.red-88-14-199.dynamicip.rima-tde.net. [88.14.199.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad04dsm22031054f8f.81.2024.05.17.09.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 09:27:55 -0700 (PDT)
Message-ID: <c48488d1-3135-493d-a9e8-2f787bdd2b4c@gmail.com>
Date: Fri, 17 May 2024 18:27:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] completion: adapt git-config(1) to complete
 subcommands
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <e0039edb9b7dce1e33c4cb6e964c50281c815e97.1715835356.git.ps@pks.im>
 <8d43dee33289969a5afbbf7635ac40b7312d8e19.1715926344.git.ps@pks.im>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <8d43dee33289969a5afbbf7635ac40b7312d8e19.1715926344.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, May 17, 2024 at 08:13:36AM +0200, Patrick Steinhardt wrote:

>     ++	__git_resolve_builtins "config"

The __git_resolve_builtins() function executes "git config
--git-completion-helper" and caches the result for future calls.  And
on return ...

>     ++
>     ++	subcommands="$___git_resolved_builtins"

... it populates the ___git_resolved_builtins variable with the result:
the available subcommands for "git config".

>     ++	subcommand="$(__git_find_subcommand "$subcommands")"

Then, we look for a subcommand among those returned, at
${words[__git_cmd_idx+1]}, where a possible command must reside.

Nicely done.  This looks good to me.

I wonder, if we might consider the possibility of having "list" as
a default command:

-	subcommand="$(__git_find_subcommand "$subcommands")"
+	subcommand="$(__git_find_subcommand "$subcommands" list)"

These lines are only meant to express the idea, as other changes are
also necessary and the documentation needs to be updated.  Of course, it
could be done in a future series.

I think that "git config -h" is an intuitive enough way to offer the
help text and that using 'git config' as a shortcut for 'git config
list' can be convenient.

By the way, having used '__git_find_subcommand' instead of
'__git_find_on_cmdline' is reassuring when it comes to having a default
subcommand :-)

Anyway, as I said, this series looks good to me.  Thanks!
