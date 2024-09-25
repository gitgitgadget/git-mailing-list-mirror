Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF4F146586
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272101; cv=none; b=VFLVcgOJoDQkex01q4SghfqVRYNQl1C37nc7fDwLj1b+tJEQDrJqE2HqN4HKO7EJpMzmOwtNSmNMkMw4rLMxA3Osy/4Q3pbu/JcPvURFAnooafxsf5a+qonSEPZ7j4EjNmv7Qp+jEN0ajx9YtfhnI/6N8wp6Ui8wO1YuHo4nYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272101; c=relaxed/simple;
	bh=fkuEreXxFjp8PKdOcnHUOD5ut9Wt+j1QoJ1YMR/DhNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKAL5HDMVFNwJaD4E6Dh/TKQAPMC4smUcFDj538jvNtbLSSjPa1hk60JcJodGzmKqzs8fD8QaVg/5998JjlhzD1PHXE+AY26vMrzlxvA6Q6tJC3npxw5Qq2V5fKgm5DhLgwkQHoyvk87WPMORVcoRZDVqgBDlpmyI3/UIYqrAJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh0K63qB; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh0K63qB"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-277df202ca9so3281366fac.0
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727272099; x=1727876899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9PjK+FzuJhPv1Hx7JCX4SVX7DzSzHsAr3Tn4g4w/70M=;
        b=lh0K63qBbC0RARabjhwcFWhkZcyqJo1tLmDkHyzYOmm4hgbyWwLAM+2b0TyhsFB3R0
         K8MgBiaz9YdGWWk76N1hDUb06PGX+5IQUy8LWCcTmvjQN/7tIH8/ZtBRAlAinFO3iF0e
         fVw12geeZ5BEGcoUNrs/QIgoz5rb3/tDhUoxxBh/e3bJrZIyfBW1foUboe9a57qZm/rr
         Gfc75WhZp6tRI3u8ONaAka2JYQDddZv61L8lwagPA+Pj6PqSinJY4K36t6hMuzf6/gq9
         9DtHhLixjhfMgqlkwyFkeCg2Wbo5jATh3fnmH4f9daEQSXUeLTq7tzbEECcKL1G58K8t
         FtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727272099; x=1727876899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PjK+FzuJhPv1Hx7JCX4SVX7DzSzHsAr3Tn4g4w/70M=;
        b=l+eRg+IdhU7W683tPqq0HmpBGipFtpVhfPnzpK7QTZa1zmvgME+WsGvAuTr7i3WeR9
         Nn55cuF+eYjMI2YRflkWUb+5o+RjV/Dw/Bgy9uqrmsV0jl0KHNofgpdeaL4CNONVwL+j
         GK41ls2rt4NXUNddctXxVOQTTlEeGlOl/apHbv/+IKhYd7NCSf/JeVk2QjDyCi+NOoL9
         J5CSIGnIHDms3bMVglY2qir6yBvb6qxVhSCZeOSfcJZxqvQCBRspKbUY76/0/ugqNx7O
         pdYylh06a2mHKv1wlWRB/PcTdZvHRa44ejHVfY1UA1cchD2vY1ERr7S/6wpbd5sx15EM
         gz7g==
X-Gm-Message-State: AOJu0YzYoLunh02vVrvgF6Owo05AN5XyuEnNxigAMBXxRDeIv4e/rpbW
	mOW9uUvV/qemq9LAREBe1bxMp53kFTmrFL92UaGg3flbp07XWC2H
X-Google-Smtp-Source: AGHT+IH6xNZn7GPSNr/14tmYgxCA6s+kny1YuS/7ZPxoBXr4E6gbrMaBf7lzb+HXFct49yZWgTDpLg==
X-Received: by 2002:a05:6870:e6c2:b0:27b:71ec:1463 with SMTP id 586e51a60fabf-286e136d585mr2427758fac.14.1727272098621;
        Wed, 25 Sep 2024 06:48:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:1a:6e9e:b1cf:6f9a? ([2600:1700:60ba:9810:1a:6e9e:b1cf:6f9a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-283af8d75cfsm1321004fac.23.2024.09.25.06.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 06:48:17 -0700 (PDT)
Message-ID: <5f4290f6-7c9b-47ee-b867-c9904ce0ccab@gmail.com>
Date: Wed, 25 Sep 2024 09:48:16 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparse-checkout: disable advice in 'disable'
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com
References: <pull.1800.git.1727119882901.gitgitgadget@gmail.com>
 <xmqqr09ayv2d.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqr09ayv2d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/24 4:27 PM, Junio C Hamano wrote:
 > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
 >
 >> From: Derrick Stolee <stolee@gmail.com>
 >>
 >> When running 'git sparse-checkout disable' with the sparse index
 >> enabled, Git is expected to expand the index into a full index. However,
 >> it currently outputs the advice message saying that that is unexpected
 >> and likely due to an issue with the working directory.
 >> ...
 >> +	/*
 >> +	 * Disable the advice message for expanding a sparse index, as we
 >> +	 * are expecting to do that when disabling sparse-checkout.
 >> +	 */
 >> +	give_advice_on_expansion = 0;
 >>   	repo_read_index(the_repository);
 >
 > Sounds sensible.
 >
 >> +/*
 >> + * If performing an operation where the index is supposed to expand to a
 >> + * full index, then disable the advice message by setting this global to
 >> + * zero.
 >> + */
 >> +extern int give_advice_on_expansion;
 >> +
 >>   struct index_state;
 >>   #define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
 >>   int is_sparse_index_allowed(struct index_state *istate, int flags);
 >> diff --git a/t/t1092-sparse-checkout-compatibility.sh 
b/t/t1092-sparse-checkout-compatibility.sh
 >> index eb32da2a7f2..6e230b54876 100755
 >> --- a/t/t1092-sparse-checkout-compatibility.sh
 >> +++ b/t/t1092-sparse-checkout-compatibility.sh
 >> @@ -2355,7 +2355,10 @@ test_expect_success 'advice.sparseIndexExpanded' '
 >>   	mkdir -p sparse-index/deep/deeper2/deepest &&
 >>   	touch sparse-index/deep/deeper2/deepest/bogus &&
 >>   	git -C sparse-index status 2>err &&
 >> -	grep "The sparse index is expanding to a full index" err
 >> +	grep "The sparse index is expanding to a full index" err &&
 >> +
 >> +	git -C sparse-index sparse-checkout disable 2>err &&
 >> +	test_line_count = 0 err
 >
 > I am not a huge fun of insisting that other code in the code path in
 > which I got rid of an unwanted error message must stay silent.  As
 > we are expanding to full, we are presumably rehydrating all the
 > directories that was sparsified, so it might be reasonable if we
 > want to see a progress output during this operation, for example [*].
 > Would it make more sense to look for the lack of specific advice
 > message instead?

I would say that there are generally two reasons why I chose to check
that 'err' was empty here:

  1. Using "! grep" feels flaky to me. If we changed the error message,
     then we could accidentally cause the test to pass because we don't
     see the old message. This is somewhat mitigated by having the same
     test check for the existence of the message, so careful use of a
     common variable might avoid this potential future. Something like:

+  msg="The sparse index is expanding to a full index" &&
-	grep "The sparse index is expanding to a full index" err
+	grep "$msg" err &&
+
+	git -C sparse-index sparse-checkout disable 2>err &&
+	! grep "$msg" err

  2. If the output is currently empty, then testing that it stays empty
     will be a more rigid test. It will help us notice a change of
     behavior here, even if it is an intentional change.

For the progress motivation, I'm not too worried because the progress
indicators depend on isatty(2)[*], so would not appear here even if the
command was slow or somehow GIT_PROGRESS_DELAY=0 was set.

Thanks,
-Stolee

[*] #leftoverbits: 'git sparse-checkout' commands do not have --progress
options, but could. The 'unpack_trees_options' structs have a member
called 'show_progress' that could be populated based on a user option.
