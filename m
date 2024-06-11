Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480898488
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718139175; cv=none; b=pABftpzagp2rL+f+SWB0Aw8OLVlZtbxWHFRq6XYByU0F0FRtRDdTEc38ADOV67eX4KyKFt5wNdr3kTS+LwmcrgaFH48wvc3hry21tVbDtOb9T/j+YsltRMT5j+iSFusUfsCbMgQUS8MI8oy/eqh8bRll5zKWUSCNGEfIN/gQsp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718139175; c=relaxed/simple;
	bh=MkFUwlDck2aDXVj8VfKXHyx3qyj4WtCNvWyspYesgM4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=t+RC/IP5iBqlDG7OvEgRPN9ibHgzmqO++OWi3ckplCuwWsiNyFSRV2hPalqf0iTYRIfEc2cRyy5uLwD/xoO7D5F+m8eh9pO99NDYFGwPFdX9z9Pumpol0VM2iWl0qZjwULFev/mgJpA3fb6ESFKHrqLmEjt0vpmUSNWWHGoA3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtHfZNAa; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtHfZNAa"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7e21dfbc310so257892239f.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718139173; x=1718743973; darn=vger.kernel.org;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9iz516ZpIoajkjxDLlmRLOIMyx1iIzCJ6OHuyq1ugA=;
        b=UtHfZNAaMp/9bFYaMyExeVnnYh5ewe3+ioH0fE8XRaEEuyEz2yd62SzbNAb51+6xnt
         rcGySCFq8s4w0OHrYYNHpBuAWpfhxdXW1YXksfNOPP8GSIJqGhzZmu1+ESifHfRYi778
         VwfsMXts1tIJKC64ynYcbRIM3mokJyWcT9ayBEyP5IgLHHcxII4s/ihEIH0GCrasBaIf
         4T2mF5MV7w2hxVgNveJtmdqwumIFye4iheDlo80IarvV0WjxkC3zDvpwnlVvsC18fqYn
         xDrOnQfUgwMFGJt+qRjY+7X/9t/AkEjCw1aUJKf7e5vv8QMDhjv1iOx+0gXASBKknRLG
         10DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718139173; x=1718743973;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R9iz516ZpIoajkjxDLlmRLOIMyx1iIzCJ6OHuyq1ugA=;
        b=tFesrNgcqrGdKmJeqeRiVb5SXZGPiNHFDb5IIdiBSRaDeq0VPn5oUc2Y3DcZjPWPNd
         ttUfj5Yblpb/w/asN4czT8JxXtZxYw1gIQN6VevuOHI0YIx34krb+2Ie7Xzxw0VqQDpo
         dbMv05/SFno8+ngzL1CIreHOaTyk2zEE6REu2plTGAtvW6TLbnGcmIzjzxNzH+0/jo0E
         FCBlGvrY9vMDcpet2fO5O7kMeh4fY2938r3r48ZzHLn7QJnketXYCIONJNUh7x9rTX5v
         XpTd0cX0FKT5FZ63xILYVSUlplvQRwaKOfRaeWha7ThfA97lwCmh1PUf8xpSQJa/wZO9
         KlEw==
X-Gm-Message-State: AOJu0YxzRsSPD/14WkZLPwqioLG/SFZQzpJc/915nSoMqoxULxTguj+s
	V1gL3kHVZhq9DKFM+jwjc6fNlbdwxgkc2jzTrg0pNBAqNpFY9WAETNlYgA==
X-Google-Smtp-Source: AGHT+IHsKWwk1/v+4x69B0cWExEjmgahL+J5e9hPMoWdHRUiRAUcTn2ey6lu85Py1V3sCVKuimJHTw==
X-Received: by 2002:a05:6602:15c1:b0:7eb:b188:1c96 with SMTP id ca18e2360f4ac-7ebcd0e05e1mr11577939f.5.1718139172860;
        Tue, 11 Jun 2024 13:52:52 -0700 (PDT)
Received: from [192.168.1.9] (99-35-164-61.lightspeed.dwgvil.sbcglobal.net. [99.35.164.61])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b931b3af3csm458459173.162.2024.06.11.13.52.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 13:52:52 -0700 (PDT)
Message-ID: <28659397-293f-4706-a0ac-75298673ee30@gmail.com>
Date: Tue, 11 Jun 2024 15:52:49 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Hillman <davidahillman@gmail.com>
Subject: bug: Commit throws fatal ownership error without explanation
Content-Language: en-US
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

        Attempted to commit a change.

What did you expect to happen? (Expected behavior)

        Commit should have been applied.

What happened instead? (Actual behavior)

        Git threw a fatal error with the following malformed message, 
which fails to identify the file(s) with problematic ownership.

"[master 3e58b1d] Updated sans comment
1 file changed, 3 insertions(+)
fatal: detected dubious ownership in repository at '/srv/git/projects.git'
To add an exception for this directory, call:

        git config --global --add safe.directory /srv/git/projects.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.  "


What's different between what you expected and what actually happened?

        If git throws a fatal error due to improper file ownership, it 
must report the offending file(s) so the user can correct the issue.  It 
is never acceptable to die and leave behind a mystery as to the cause.

        At an absolute minimum, the error message must report the 
expected ownership that was not found, not the vague and useless 
characterization of "dubious ownership".  "Dubious ownership" might be 
fine for a warning, but is unacceptable for a fatal error.  In other 
words, this error message should be as follows:

"fatal: The following files have incorrect ownership.

     file /srv/git/projects.git/example/path/to/file/one.pl is owned by 
user123541, should be user434892

     ... [ repeat as necessary ]

"




Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-31-generic #31-Ubuntu SMP PREEMPT_DYNAMIC Sat Apr 20 
00:40:06 UTC 2024 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show




-- 
David Hillman

