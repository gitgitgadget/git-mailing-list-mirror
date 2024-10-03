Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9214A4F9
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956836; cv=none; b=XtaGtHqfhtgKLmTxqbah/Ppoobvbqn77iE690VgLNilwXgMe1Nsy02qClPGgCEf1VOTWEL82rgE1W4/tEoggq16pZ7HYEd7gMADYCNA2oVlKZH4TEMyc8AmmQE7kfVq1hGIpXXbeNFQbLRTbsFOnNPF+GdyKror+bhI82lCxIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956836; c=relaxed/simple;
	bh=5yKsJ2gGf2iaqUEOSyJAhMXaf+ncKKiMrwwnOIJQYiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wi0PZQaFQ1XZb1YbcM6vedU46TB8cJ1bOl5wLKUbl/6KYnCP0MgLvQIuzejWWnqsZsQRepHTbH4j5wQiEDqlsbteV+qsIlG1jLApGDA0rAnxhbG5zdwsVxRjWcqTL5feo2csPbnXQLEPAIXa5HYOwoSBCqSaLr0REbU0jdRKwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juncr7P1; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juncr7P1"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e77c6ed92bso512878eaf.0
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727956834; x=1728561634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ds8b6IvGPlIiJbpALud4dwxpvfaGav39uMvaqMmtt/4=;
        b=juncr7P1wGZnJK9ys5KrpijGFwFwKWE2AHQQ30XsGkp8td7xlTWDMG9485h4/Pyuwc
         4yqDdPx1nstSRNrodUxXxdZP/HXksveNZQlZkAQCXt8Y/KR1MBiq5Uraly+70AEdrFyN
         Ffo5qsQVQk/TTsrhP3VKo0Rj/peidY3s8cqDcwzh22IHniNTo4Skp/zEVSiMdf8Tzgql
         Yj2wc+jpAcyXDug8pTdgOrl0CfdRcpVjKpHFiA7v8ajskPy8ee/9JkL7dX2MGYMNOj61
         rgN5xBq4qErdl3op7eNox9lKdKOkihAYCAL9lGCSSLwEiHw6zvGEHndy2zlX0ZRi0Ki8
         IEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727956834; x=1728561634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ds8b6IvGPlIiJbpALud4dwxpvfaGav39uMvaqMmtt/4=;
        b=Nt3TokBpcj2IUJb+bIejU8j7UhKIYLTDOrO0LlKvif2q+tsCQpB1DkW0737SdU2rN0
         VgEX+emO6hGHWPeJIrKcyb5cfepwHaAZ1H0A0cAl/v8AL2L85XLA2jV+1m2Ta5pAk5IQ
         K6MQOKUutSFojjcaSNwTKvLkJSVRwK7UBEknIMT6qPuClNhWth24hduN/TjG+3ipHzd8
         N8a2VhnbIEXrJo7qy/dxCkNfJi6TVlOI/W85Asfr22M47tFar8rgCo3OBJHANh6yf8+F
         6WdCUJNwlQXp46ALYo2TboARg3M0EqkbDXKQWIwk2IpIAAJ8ykAUNwOJo4U+UNGhLnKB
         zaPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCLHGIIftUZ2THgJsdScc+cLkJGbIhbnZM4rP9D4sUe3mUbAKY9tmTxjeq2BD92B1oqGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9wFU7095NkvrtBiiUCWf0T2Y+OpPfjpm3n0Zi4+J6d/ZaI6JE
	GNBs0Xy9owwQQj54/Y3fob712SdtODl6vvtED44pOolDh6m2t2KO
X-Google-Smtp-Source: AGHT+IFZnVGGkXaq1sgN6oK/gOMly41bv3dwyF3O7ZZxkkqiGSQDiPm6CDctMNZtXCi4vteTOczweg==
X-Received: by 2002:a05:6820:1ac5:b0:5e5:c0a0:2b51 with SMTP id 006d021491bc7-5e7b1e4c378mr4161729eaf.6.1727956834358;
        Thu, 03 Oct 2024 05:00:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:b038:cb50:a5ce:b021? ([2600:1700:60ba:9810:b038:cb50:a5ce:b021])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7c0ec427asm317893eaf.36.2024.10.03.05.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 05:00:33 -0700 (PDT)
Message-ID: <4328e3ca-f1e8-4537-8302-30fa7d062e38@gmail.com>
Date: Thu, 3 Oct 2024 08:00:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: add a note about staggering of maintenance
To: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>
References: <pull.1794.git.git.1727945877922.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1794.git.git.1727945877922.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 4:57 AM, Shubham Kanodia via GitGitGadget wrote:
> From: Shubham Kanodia <shubham.kanodia10@gmail.com>
> 
> Git maintenance tasks are staggered to a random minute of the hour per
> client to avoid thundering herd issues. Updates the doc to add a note
> about the same.

> -tasks for that frequency. Depending on the number of registered
> +tasks for that frequency. The processes are scheduled to a random minute of
> +the hour per client to spread out the load that multiple clients might
> +generate (e.g. from prefetching). Depending on the number of registered
>   repositories and their sizes, this process may take longer than an hour.
Thanks for this update! I'm happy with this version.
-Stolee
