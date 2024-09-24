Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002041B85FF
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 03:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727147659; cv=none; b=ZT9ZNbfliufNFGbmRgzHg6r1R8aQuAwHD0gOqsf58QSruylnTxHzQIUXlY93aPWi63tbN6lqQ7IdYBGqkRuSrFV/2cc8+kF14gWTvWM2/VUN0UhvOKy/j63KdAvxJmHziudWFT698DP29bCxisuFPsOKxhozHU+H3/izpum50/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727147659; c=relaxed/simple;
	bh=59G84gWRVJ7TWdV+MKL/CaLaREE2B3JW9lBpFu44WkU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CAipEfOO3nW9uFEXTHsl0P0AvoQ1tTly1nz16RltXl6B3VGCrK7QGLKY4lbPn4/AoYuu7HpgcySkc42AK4aY5mSeCqke8oM/rmVh0FGt9GHmKBneq/2F0BCc3FeqneM497rKl+2H9/z8fE5tfKGLZ6WzEXwesoNDzh4LxxZPLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcVzZ9U6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcVzZ9U6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-207397d1000so45765245ad.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 20:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727147657; x=1727752457; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdCFg7xxpqD9IC2A89Zhy+xpWoV63DKMO5yaNGjAHQ0=;
        b=mcVzZ9U6FjROhsxMaMPTgxYRbWIy+hfqo0cHkFnFy36fNYfMZtSj7osXsL4or1Djat
         6ANI8m9BtNiY/bSA4/3oKUwB9HGYbMHeNiFdV5dqspEOtr/hKHuJm97OAgYa2OZ6G4t/
         OxZ1np+fwphfqf4epw10/mB3/oUHVT67WksVmF6HXuInZj5caF/I7n8SidayTD82lSxs
         B+hjkUw0IzQ5QigfF3+EX0EAn5UossgPz/pmVFS1ilWrTTYByabgqoEqdltDOoLAY2kF
         SA2TNXjNoaYp04FUGPqQnQr9J9xDDw2H2G38CrjRHaDdqkN9bsu/O2k0I/3m/xTFFPaZ
         r1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727147657; x=1727752457;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdCFg7xxpqD9IC2A89Zhy+xpWoV63DKMO5yaNGjAHQ0=;
        b=tn7Uhd/yZh5kS9wuwR/UhnGBdwJF0Kmwro+EcpSdEhxLwQ5YuIzubA+lxJsBrlUYxc
         1etrSyLm2hXyCzO24rPB0uTXNd1Vg7lNjzE2LhWUrqdeoEovJi7HAbpNkynFO/61GCAj
         tplp5ArCT5lauSYgSR6Z+RZiljvre2AvwC6dNTEPGhz9Qd31qZdBD73fvjrE5vavUae9
         XZ8YMrsU+n5iS63Ft3uk5q2jdHu8pxoXstjXAWT944oRvHBozPrQUcgPy6MRh0w5Mkta
         3KawagSSDSzrNgDVYI6nbd5hzTNdmmjSP9rk4yH+296iMpXAb2eNlFHvOtA3JZNIg9er
         W8/A==
X-Gm-Message-State: AOJu0YyWzKB81670wXv15We9ndDbld9mOZ/tam3UKaTXgc8k/gySQZqj
	rez6Np2tNivRuQKiJUjh98anwXl7DPdtz5bVTRnLFODjcfXF6LeUIwwWX5ke
X-Google-Smtp-Source: AGHT+IEZbTHF//lPgyxNUzNm/w4+qUgU0cQShduNr6Vr9P722Xb4KicPQ/gZZ694vs+gBDAVGaa+Yw==
X-Received: by 2002:a17:902:e5c5:b0:206:8f25:a4f with SMTP id d9443c01a7336-20aed0c3213mr24206405ad.16.1727147656977;
        Mon, 23 Sep 2024 20:14:16 -0700 (PDT)
Received: from [192.168.1.67] (99-36-166-232.lightspeed.snjsca.sbcglobal.net. [99.36.166.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1818c01sm2169725ad.207.2024.09.23.20.14.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 20:14:16 -0700 (PDT)
Message-ID: <9233004e-5aeb-4a02-9fe0-d794e54c1efc@gmail.com>
Date: Mon, 23 Sep 2024 20:14:15 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Eason Lu <aelnosu@gmail.com>
Subject: Git server negotiate fails on first push
Autocrypt: addr=aelnosu@gmail.com; keydata=
 xpMEZmPaFxMFK4EEACMEIwQBosxNI3bH9ttK3ys/b/5uEejqMgy2arRLtta0mytkjo9IYCyu
 9njCmVP0u3/4ASDNIb7gskqXACuQLOLi5MRbWRUA9+gwCjXSmy1tvdGHTG027eWwZVyfxB5t
 NhO4dcBxDB/O7XPTTMUOUO5zHpiOF7KY1aWh2iFujm3uPJtNoviw5k7NHEVhc29uIEx1IDxh
 ZWxub3N1QGdtYWlsLmNvbT7CwBsEExMKAEECGyMFCQp3xikFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AWIQTp1MFPAVvjCQ08b5+l7RexNemAJAUCZmPdoQIZAQAKCRCl7RexNemAJMH4AgjC
 hzVQejPbB5gOU1tUdOLi12kZrUmtlC05gAbVppgPkJv9rg0EOWNoMAkffgqcKlZQ/UPNnD+G
 uJz7w7eLzY0dIQIIg9nuSX8Y0JY5TlXBoh1HUjNDLif/qsIY6EEw1TJ5KtYiXOy/k1+D+Beo
 0UootvAB7Fj3BcirdGJMDmaWZYU+dSvOlwRmY9oXEgUrgQQAIwQjBAFEfbPgK1C206Txwsa5
 3Idz/S6cZT4L4xEWnKHGZc+/7XtEcuzPqmFpfIeOxPTYtkpI4eIIWwyyQam99kFrigT+iABs
 8ebu34+d74Gna6u1/qi75O5n+ok9/Mlq+NYIYnRpXxlv/FYnS9PjmbCdY1uK8Fwzk16U02MX
 Xs5gfmcJMOh+6gMBCgnCwAAEGBMKACYWIQTp1MFPAVvjCQ08b5+l7RexNemAJAUCZmPaFwIb
 DAUJCnfGKQAKCRCl7RexNemAJCjxAgiwPoqIi6LSx4itfubksOLxq2IRHxynKLt2ATIsv78+
 6yRAbtVowKSAfOaIq9pZmpd5TRHK2BTRz4PPx8PYZLPaPQIIzxuC/fXe32qOpxNoyC9l+hEb
 8jQi1ShLno8qogbjQ4n94kZ6fbVmkgvLG1mf0198v/VAKGw3Ue52hD8Mo5p0v/k=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear developers the following is a bug report that I generated and 
filled out using git-bugreport:

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
1. Create a empty git repository on a remote server.
2. Create a local git repository with at least one commit.
3. Push to remote with "negotiate = true" in the .gitconfig
4. Get error like
"""
fatal: expected 'acknowledgments', received 'packfile'
warning: push negotiation failed; proceeding anyway with push
Enumerating objects: 42, done.
Counting objects: 100% (42/42), done.
Delta compression using up to 4 threads
Compressing objects: 100% (19/19), done.
Writing objects: 100% (42/42), 96.94 KiB | 96.94 MiB/s, done.
Total 42 (delta 20), reused 42 (delta 20), pack-reused 0 (from 0)
To gitlab.com:aelnosu/push-test.git
  * [new branch]      main -> main
"""

What did you expect to happen? (Expected behavior)
No error during push.

What happened instead? (Actual behavior)
The push succeeded but with "fatal: expected 'acknowledgments', received 
'packfile'"

What's different between what you expected and what actually happened?
There is an error message and a warning message.

Anything else you want to add:
It does not prevent the push, but the errors are not expected.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version 2.45.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.10.9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.10.9-1 
(2024-09-08) x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

-- 
Yours
Eason Lu
