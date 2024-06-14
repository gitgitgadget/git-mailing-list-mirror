Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DEB17C72
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392939; cv=none; b=oQVnf4DMSaiw5E4m4M6T98TxDhE26/BOopuD/Fh+KHmx8wHnClkFaaF39qlAdsBlLG26pGsrg5XxJhWGSIFXyjT3oudsV5flMz+FH38/owCVHw8sT/6ryaaQ29/kMBTkndPCoZ2H5FvXkvKPqgkvN8Wsu5nPtYDP7VN/VM5A4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392939; c=relaxed/simple;
	bh=NO6MqiqiKyRGipQdNiiZcfnOBed19pOm4GlW0NEjOjg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gR2GjHrvstERcYlpG31NECJuKeAuXGAFo6v0j4PNM/SZGjcvTZsZ1KZq48GNOXqp1meBD3bNLhSjaQWln5wkrQkqss3Zn0pUmBUX51n+PADB6I/mO+1cC85uwNGYs3J2xAByW2ixaNmR35MERENZcWlNYAeYz8UaStH6v4yfn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlD0C3QD; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlD0C3QD"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so2592995a12.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718392937; x=1718997737; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PfgDQN6Rk9cJXyKwixs1Jl6tk8zE2eAr7UOKzBUa00s=;
        b=KlD0C3QDjUySqoF2NsdM0Pod3d0EX8bcHgAMYMWL9O9/fcQazUhpP395mx6/VzYKDu
         j6QEgipwEWxf1K7iTYLlrUzqC7AIwUalO7+jqkcnMMU3gidoTI5BKYVbQNUFC5e+wMPy
         tnSWhTu5pJkgLqHH3SZ0CeNeszajKgsJHAluAPVUCCL7JDcFSqIrK7zHmrvAZ/At5P8J
         Gfv0VPvfmdjOeB4oLEf3ed2IlxWSgeIdSObveRJ1l1rLMbwgLVaRkL8jvlSMCDlqTTNu
         g0eIgOStIODsWqPSujbRUe56/0fJFzMhmYXs7iWAtDGQLsbtKY08dPGdh79kbIlZB18Z
         kmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718392937; x=1718997737;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PfgDQN6Rk9cJXyKwixs1Jl6tk8zE2eAr7UOKzBUa00s=;
        b=LvGiPwtIGHJliM+Eelz8vjxO0QGzks/tiZtejP1/jakxJb7G43FeHXbmBuFQkv5ZpO
         4fDPtpITMAYC7sJBgs1UJ18z+BHGY4+Ca0E1/q7tie4T0YXqsa0UZHFGVk5ccY2zAoPR
         W7DKJejQswadbM8/FzqScjQ5tzJAZbBhPxjmWVOxJpsZNwxoNGrVWCa9wbvK9PsT1L2+
         xmBRSwM8VSHureZcNH+rfk8BA6xURKXfvDy2WZYqiV5VKdK5Wl1RfmLwkpQ1hrMzX2xt
         mvm8AQERJYJQi2mdBoUsk/dO1zReu8AdwC5tYxWUDJXrDBSfAbW9YQ8uUngYUUm6pKDc
         7X7w==
X-Gm-Message-State: AOJu0YyQf6RphQh2S+ldbLoXZcfz/l9gMMy1tUiBSFJ/lBtaGzJNubFh
	ZztOg9Wvd8jw2wW9KQpCL4a1ZxEMPc+M2GcjWz2kanb7VxA6L/JNYEEJjyjtffIlMx7GvQvDlUF
	7hP0DbbDXfMaqAIjqCDU9reMNQYbl4Ekb
X-Google-Smtp-Source: AGHT+IGvTN5xyzpkYxQN+O44W+J3+BdGd8DpOQATYwbNL261N4y1wb/sGU1aT7kJdgdkqx/NNCEcU6BvkFTQJVyc2YQ=
X-Received: by 2002:a17:90a:d301:b0:2c3:2f5a:17d4 with SMTP id
 98e67ed59e1d1-2c4da524c78mr5690215a91.4.1718392937043; Fri, 14 Jun 2024
 12:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rickard Andersson <rickard.a1992@gmail.com>
Date: Fri, 14 Jun 2024 21:21:40 +0200
Message-ID: <CALyzih__9sZD31SVMECcxk55+MAMjkfgpLzecoHo0xUoauerqA@mail.gmail.com>
Subject: git grep bug replacing - with :
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
   Added 2 files to my repo with words in them
   text-file.txt
   text-file-file.txt

   I did a git grep for said words that exists in both, and used
argument `-l` to only
   show matching filename
   ```
   git grep -l ExtremelyInterestingWord
   ```

What did you expect to happen? (Expected behavior)
   I expected to get the following output
   ```
   text-file.txt
   text-file-file.txt
   ```

What happened instead? (Actual behavior)
   I get
   ```
   text:file.txt
   text:file-file.txt
   ```


What's different between what you expected and what actually happened?
   It seems that when using the argument `-l` the first `-` in a filename is
   replaced with a `:`. It also seems that it is just the first one as the
   second file keeps it's second occurence of `-`.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.0-35-generic #35~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC
Tue May  7 09:00:52 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /usr/bin/zsh
