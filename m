Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C317A586
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570845; cv=none; b=jZi0NhptZRzo3f/D3gpG8n+9NtPzU4aM/gS22RLrfi7pItbhcToCYowvsvb2dcDouR7TfpaIqOH+ZbJtQgXhnHXzuenlOHPaXBdyDkheyr6xpvAW/tRtkkaUcG6VqJgCqVaz8aXifdAZ9gPFOHN23IyObRMquH7KAhNOlMOCs8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570845; c=relaxed/simple;
	bh=0ZelB46v9bVkcRByj0dMdZX7TFua2vObiaPynW/mXn8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y78MP8cMiK/jhecmVvFju0NHa67hd+4GDc87kB2fXuvzORVzQlwf+JpAMxy8yA5Nljq98iDyuzp+svjH2hrznSev3EplljUOS4uD4KD97Txh0CsPqeaQ+BZ6oro5yJx6AbWb4M6FoEKeh6XCS4RKf+blAyrrF2MOhax3eEmS0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiC+A86y; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiC+A86y"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476ac73c76fso36947951cf.0
        for <git@vger.kernel.org>; Sun, 13 Apr 2025 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744570842; x=1745175642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAi+Exwk1znFoqoLcjVPc1W1wsluWdrP7GMSuSGnxwE=;
        b=OiC+A86yzKwH7a7qUUT7UQbzzNWhcNB4XzJXen+MlRR4c7PH9nP4q2WX5nLPQSqHuE
         wOONgmdT4yjIewrcjSfOEy7VVWcerjjyE2lcrwYd9w7Hc9BBL2JR8QxqXqsVdslOQ3fM
         wLoWcToLjJlg0gZEO5ivjjswk/wiLr9OseV6u0ON4URTj0s+RoGaOQoFgtBxtxrIdaZj
         aAbVHsFTT6RPMBDzOSUmB3aTj6K8JM7/wiRDWvjiJQiIeO8q5j/sX27pbpg4j1hMd7XK
         mopC0F1SXEcFHGzL+/3P1XjdtynHS4hT7Njmn51bq7B0D6YLOJsF1UHLXl4pgcb9gbwm
         JKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744570842; x=1745175642;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAi+Exwk1znFoqoLcjVPc1W1wsluWdrP7GMSuSGnxwE=;
        b=oP2/Mbf8UirG0V09fcpkj2XZvlfO8NKF842KjmkVe8p+4kt0TyjGlhHn9jK/E9Xfbp
         HHmacJTf2ZIZzUWIUgtaLHHuGxrXkk9xE5N1efwsKlHHpBY4DUV2jcc+aCSdT52uudGf
         t4do0AubjXRCFMNZv08T4KOqltpP6rq5bqDyIoqoJr8PDXbE/we1mF1uEJEBOM7aveJ3
         5Vn2aPmxh50U4ocy2lmZXhEkE+EretxVJUVF1U/QyuB/vL3fnLObZOqO/C4YVIpMIrG/
         vbss3Tgldk4Ooyyd6ibbboehgpXoARRn5RmAR63x+P3vZ7oYQfD14IV5vjoetmG7FzcA
         QTIA==
X-Gm-Message-State: AOJu0Yy4PYa9l2qsFEGl7SbwoHaKyNjBKcwIFurTCtAhG9PsbTNEG/+F
	tjQUDxKsqNYAN4omPTg1vvmMplt5FtK1yah5GbEVVr9TP/IR69S9
X-Gm-Gg: ASbGncuJUzidnB91EQ2A85Slp8Te4fO1ryIhTlYiYY+to3zYgmZVhMkw+lQC4Xpwocx
	qvY3kGH1GqPJd4OU+3/89B70T8PxylEM6HCB0EF22L3aJec7/0rgZmw9WMYAF+Bmkx8Z5rMJMYX
	+vjvQjc5tF/OyTJxRNiupZJqMU6ewK8Nlv8AJuoe2F0gUTrDQVcV3DRqlMKO0hz1tSTP0dHsZZ8
	0sKyvpJHSK1tw55x5z7TFjRo/Gk4J4VZIAI7/pgLlMfWLPSDAX3cJ186kfi7dRilJHpi7x+xa6C
	m/eSOfmbhSbHMLYqHxxV+xKO6kq296WoZlOI4a6sXLBbfa7cZdexyOuob/6zQ3/HRx1s8B/xz/O
	CW+eqfCqeRwVYZpl0wZ9uOC2Ey5wKCMog8B2HMnIw
X-Google-Smtp-Source: AGHT+IH8/X4ke4fQki06BukxTgl7l1duO+9FYNWjcsH9mfs+m8P+GPy8SRMelL85VMjf1A1ExYXJTw==
X-Received: by 2002:ac8:7dcc:0:b0:477:8a94:dc77 with SMTP id d75a77b69052e-4797750f99amr105015691cf.9.1744570842252;
        Sun, 13 Apr 2025 12:00:42 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:958c:a05a:bee5:3926:fe34? ([2606:6d00:11:958c:a05a:bee5:3926:fe34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2d020sm59089871cf.36.2025.04.13.12.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 12:00:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] p7821: fix test_perf invocation for prereqs
To: Patrick Steinhardt <ps@pks.im>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>,
 Neeraj Singh <neerajsi@microsoft.com>
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
 <41a093d570a5756f730b069980edafbcedf5c8bc.1743181669.git.gitgitgadget@gmail.com>
 <Z-pD1puYT87YKAd4@pks.im>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <90b3f122-8b94-3b45-08e0-32af95f9cea5@gmail.com>
Date: Sun, 13 Apr 2025 15:00:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z-pD1puYT87YKAd4@pks.im>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Patrick,

Le 2025-03-31 à 03:27, Patrick Steinhardt a écrit :
> On Fri, Mar 28, 2025 at 05:07:48PM +0000, Philippe Blain via GitGitGadget wrote:
>> diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
>> index 61e41b82cff..1d126c7b039 100755
>> --- a/t/perf/p7821-grep-engines-fixed.sh
>> +++ b/t/perf/p7821-grep-engines-fixed.sh
>> @@ -33,13 +33,13 @@ do
>>  		fi
>>  		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
>>  		then
>> -			test_perf $prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" "
>> +			test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" --prereq "$prereq" "
>>  				git -c grep.patternType=$engine grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine' || :
>>  			"
>>  		else
>>  			for threads in $GIT_PERF_GREP_THREADS
>>  			do
>> -				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" "
>> +				test_perf "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" --prereq "PTHREADS,$prereq" "
>>  					git -c grep.patternType=$engine -c grep.threads=$threads grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine.$threads' || :
>>  				"
>>  			done
> 
> "$prereq" can be empty here as it depends on which regexp engine we're
> using. The second case you adapt already looked weird before because we
> potentially checked for "PTHREADS,", 

Indeed, the reason why the second case did not fail even when built with PCRE (which
would not fail the first 'test_perf' since '$prereq' would be empty) is 
that this second test (in fact the whole loop) is only reached if
GIT_PERF_GREP_THREADS is set in the environment, which sets the 
PERF_GREP_ENGINES_THREADS prereq. So just running 'make perf' or 
'./p7821-*' would not enter this part of the test.

> but the first case was correct
> before but is now potentially checking for the empty prerequisite. Does
> that actually work as expected?

Yes, it was correct when built with PCRE, but not without, as then 
$prereq would not be empty. I did check that it works correctly 
before sending the patch, both when built with and without PCRE.

Thank you for the review and also checking that the patch works correctly.
I just checked 'test_skip' which is the function that checks the prereq and
indeed and empty 'test_prereq' is treated as no prereq.

Cheers,

Philippe.
