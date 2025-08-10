Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D929CEB
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754837566; cv=none; b=FLHaTt6qJcLyj0VzaG0n01FlkEQZWyluKJHczNaJRWNq4p7tsYx0yM2jMbD3QsVyPzYNvwaE+GAOQJoq19roy0D6c0bnmFwIJ2fM5M1FJwhVA2GnaxLa6bMGEoPJ982W21A9oFvDMNds4Bke9XvQT1uDjfbnMHnzlwgXAoZ/VKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754837566; c=relaxed/simple;
	bh=HtaPmvfhlGRCr1GLuVn4flqBr4JGYOTqPLpw33RVgi0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=jLyA2BgbM4MEn5Z43moi1y7XrewXO4HRRcndiL6WBIr9RDYfLdHnMXTca3KnIqrBw3iKXA2EMc7cicqT8DQ2uiDC8l8j65aWsG1hEqFcmukumAJt5RxqWg34nDtw2qXOatCGgEnuGrk1Gavb8NBL190k4N1umRz3Ec8aWuJXG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T++zklOa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T++zklOa"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-321895391b2so1255508a91.2
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754837564; x=1755442364; darn=vger.kernel.org;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahfO5fsxZ5N2BvC/IaId5idaslmHSPLq7li8reduhM0=;
        b=T++zklOaEgDKr5P7OF9UKyWrLSPQN/efzp8+YxPg99ZXGPTDt7mIAl0y0Zxe8lcd1N
         BlbZGHPAsA9HJ0mfePxF7FXtzIm7Tj8pfKZcT3/4MDVsAD674TCd7iZrKaudjFln4lB4
         v3XNJn+eqQJEIy6ud8pqNB3IJmNoDZwjypxNSQ+JRTIxgrlEEqUSgCAa7AaODM24yvxH
         /vvApuDeEnGrjom6bAzgYjyNrLXfwZAliAElGaaUUViiTwRHKvE/XXc1R9oynVV+0Xaw
         LjZvvwg6W4Vu24GyJHSXoa28t0QxtvqpAmkIiYZmy2D/0NGiXl/3JXqP1bROK7MEM7p3
         Zz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754837564; x=1755442364;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ahfO5fsxZ5N2BvC/IaId5idaslmHSPLq7li8reduhM0=;
        b=ON3yJbLcYhd4xGDxW2lIQwuE9dx/xtD/HTWqR1eDeLT1CQpUBMQK6+PnTJan4JuN1G
         khV6FXPHtQUBpQ7lGG1y0K8DTtylWbkTI5OcPviJrKa5XxY56Y+I0WdfjzpmQEl3M74r
         HjFhEOlzNzdAITPHcuUXNDQKFhvI2hJIP7hseAO0oKYScp+5RASqkK0Ygj5avcxQIaB/
         d3Lytp3+fB7wKL8OaWun2Hu0Gu9xUaLKh1RHW75RUGaoqUI/PwolD/6T7rMLbQDf9ZZ2
         oDpoW7OiMMrItPUxJfbHLwwAAe59ROx/pzO690sOPFDd2XNglBKTSGZmv5Efu/wxwl5g
         6R5Q==
X-Gm-Message-State: AOJu0YxOLSMommBfSeupIbsn5lUOM+Wirw9Dg+n3GHhrHSUJrqOm48RN
	h8SsYAwhOMoYz+OTk+BbCtfn7ntREJV9mGy6DGNrrlj8mXHO74LfVA4+uVx27Nyc
X-Gm-Gg: ASbGncuegkwujUrLi81JRQ49wY17m0hbvmy5rwBkf/SVL222ibiGahRSAWNXA195tTQ
	Y/dR2vV281rTtQ2PZhDZTSN+6d0eUVQ0LtyEgdkCDRopje2AXcJ0pz603eI0og3+XcVmqJLwvDb
	sxhZg9hc20IE89xTz/Q3C/O342x+CvShIj0zv/0WnU0TUPrp00G6Aav5N8zhCSQ2ykD7hgcJGdx
	NeMkzA1+4uHyzfWAci44Je5/cxnaMqzMG5aBPyZo1WMeoG4DY4M6um+bML5TfY8xLKKnmycANLx
	4kdDJlnGUI71OdBKr5jBDejuMCOAxBpGPS5fqNxoMM/9zENqlIdfCPjD7TBEuez6r297fFNXs5k
	UWZMBUz5GINx+7IvAPt+dujVNcvxhBM9TxssLMFvwSE+gCJA04WoizpJVuQ==
X-Google-Smtp-Source: AGHT+IGSFNu+geyTLFyn5PMyyle/PSWnDB0GLfIR/foOGR6Ht8CXWgLY64ZPeu4B9ueA5RkeTYxbrw==
X-Received: by 2002:a17:90b:1f84:b0:313:b1a:3939 with SMTP id 98e67ed59e1d1-32183a079c4mr2228825a91.15.1754837563761;
        Sun, 10 Aug 2025 07:52:43 -0700 (PDT)
Received: from [192.168.1.105] (23-93-88-48.fiber.dynamic.sonic.net. [23.93.88.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422baedf5csm21171814a12.47.2025.08.10.07.52.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 07:52:43 -0700 (PDT)
Message-ID: <b37629c6-b730-45ce-b839-e782aafe238d@gmail.com>
Date: Sun, 10 Aug 2025 07:52:42 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jon Forrest <nobozo@gmail.com>
Subject: Minor Bug in git cat-file (git 2.50)?
Content-Language: en-US
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(Sorry if you see this more than once)

I'm using 'git cat-file' to show the example. This is probably not a
command-specific problem.

The problem is that using a deliberately ambiguous object ID produces
surprising output. This is a minor issue.

% git --version
git version 2.50.GIT
% uname -a
Linux fedora 6.15.9-201.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Aug  2 
11:37:34 UTC 2025 x86_64 GNU/Linux

% git init

# depending on where you run the test, might not be necessary
% git config --global --add safe.directory /tmp

Initialized empty Git repository in /tmp/.git/
% echo a > a.txt
% git add a.txt
% git ls-files -s
100644 78981922613b2afb6025042ff6bd878ac1994e85 0       a.txt	
% git cat-file -t 78981922613b2afb6025042ff6bd878ac1994e85
blob

# All is well so far.

% pushd .git/objects/78
% ls
981922613b2afb6025042ff6bd878ac1994e85
# create a new file with the same name as the file that already exists,
# except change the final letter to something else.
% cp 981922613b2afb6025042ff6bd878ac1994e85 
981922613b2afb6025042ff6bd878ac1994e86
% ls
981922613b2afb6025042ff6bd878ac1994e85 
981922613b2afb6025042ff6bd878ac1994e86
% popd
# use an ambiguous SHA1 prefix
# why does the next command produce two identical hints, both of which
# are incorrect?
% git cat-file -t 78981922613b2afb6025042ff6bd878ac1994e8
error: short object ID 78981922613b2afb6025042ff6bd878ac1994e8 is 
ambiguous  # this is correct
hint: The candidates are:
hint:   7898192 blob
hint:   7898192 blob
fatal: Not a valid object name 78981922613b2afb6025042ff6bd878ac1994e8
# I would have expected:
hint:   78981922613b2afb6025042ff6bd878ac1994e85 blob
hint:   78981922613b2afb6025042ff6bd878ac1994e86 blob
# using the supplied hint doesn't work, which is no surprise
% git cat-file -t 7898192
fatal: Not a valid object name 7898192

Cordially,
Jon Forrest



