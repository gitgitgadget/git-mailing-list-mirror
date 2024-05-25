Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA171487A5
	for <git@vger.kernel.org>; Sat, 25 May 2024 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716662991; cv=none; b=Vy0pEsnzh0nsXS13XWD5u140ZpMuKw0C/ZgptTAPtHYj8aR9FFLkMrlIV+r0so7cvGsGPFRRWE9LOILXDV8wdetiTw5/cREudjjCqdCaVQQiYuBIP018ss4A1OOAInOQ+mWLJZowuQt1oWhe6jngz7PDG67tnSVxd+X06OMhykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716662991; c=relaxed/simple;
	bh=8rf1udCXZhEWDLWDBPFUW36VQQnjGWirimlo5+RlMgM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qzfkuMBqBj+7kdto1XfqK+DWuRApUF/ri1AJvUHn1a31OMEgQkC19ispJ33KwicjAlfmek3Uro0JD0MNU0gYk4/5eQLJe5WxSqRunFQ23sXbQT0R43lU33/vcb3pUILyYO48hMKUIQI0W/wjjif0iTCsiQJmys0E2QBr0c2M1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVo9tF6G; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVo9tF6G"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24fd96c5490so189389fac.3
        for <git@vger.kernel.org>; Sat, 25 May 2024 11:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716662989; x=1717267789; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8rf1udCXZhEWDLWDBPFUW36VQQnjGWirimlo5+RlMgM=;
        b=VVo9tF6Gkn2pSSnkZBe2+wb/J0UA9ZmaSd6SiN7N/l1eyymV4H11PSUuJzWhnGmMd8
         FoYmmv/Ks1SiCtRWalDfo9eSJHuAWCerE2Hre4jw0ZtQvkxuARaJaKIl6OGXK/8hCmzk
         c93RhU5XU3JZyItFDY7J0EjJlV9ipYTTzshFyV59Wi1uJhGunUd6aHvVqabn6VqNw3uo
         YQtfz76JF5RQEKxjGftlQ1HO0JLgks4M+i7hneWIwF4Wu3e8iNIC4Pp58xNNkNKiWWp5
         NMcQJlPuHZlp/nwlbyLQZvIlEzMdDIFKh4G7sd9OHA44TBlffaNQ4yUQcBBWRtJdjhmX
         gmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716662989; x=1717267789;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8rf1udCXZhEWDLWDBPFUW36VQQnjGWirimlo5+RlMgM=;
        b=dBiQ4GxMaog/7o4d3Ld143MnMaRfXfkmO2R219CjaEjXh+tEEWIyLO5/aFNanUjRFj
         s8s9Q0nFTCEFcSOD3MDiX3NVmxZ4nqsnc0Qblb677nH3nCeFMaC1QzAM+FoKaWhjFTcH
         jjyk0q+YRG6jxgggA/i/vzoQ4fY3KgdBV+t4Z0EQqBtLcJGc1pXazT/yfqIaGEO3O7PV
         IgQxtzzyojy9g+MnGP7kMxnt9baEmf5T3NGw7yERy3m2AEdrMV2YxjhUAqwwwiWM8zIM
         CwU39q83SatA57f/ENoP3ElOqGMfPPy4MBT10goN4ayd4/6lvKKQTaYWPD7SvFMZs1yZ
         8KEg==
X-Gm-Message-State: AOJu0Yx3L4qpzhQAHnZQFDJ39f69CHu2yyh+0InOkvAbnNoGyteLIUjh
	bTZ3KLw1VgbTSmQ4WNS21dTN/cfROr9r860lGe66uC6CIDHGlAo8svwv4HyeAxOhyD0+PufnGAL
	sj5QvcBx2B1c1rXf9DJSE1/o57ZwdcwGQ
X-Google-Smtp-Source: AGHT+IFT0E1HtOkWIBJi2sfCeqNaFKGkWBIhXHMF+8M0hbbvitnHJfORIRhGUCCRXfdMhDBBYfhIsJ+Yfn6R5piJiUQ=
X-Received: by 2002:a05:6871:331f:b0:24f:d6c1:692 with SMTP id
 586e51a60fabf-24fd6c10b6amr1769892fac.29.1716662988491; Sat, 25 May 2024
 11:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: William Ruppel <wcruppel@gmail.com>
Date: Sat, 25 May 2024 14:49:38 -0400
Message-ID: <CAHa7PX8THmTAYFVwAtjimgcenUPC4A5BF2OHExC82Cnrdtbn=g@mail.gmail.com>
Subject: Git "safe directory" not working correctly
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.


What did you do before the bug happened? (Steps to reproduce your issue)
Upgraded to git 2.25.1.windows.1
Now when I pull from my remote I get: fatal: detected dubious
ownership in repository at '\\bill\gitmaster\Src'
So, I ran this to whitelist everything: git config --global --add
safe.directory '*'
However, this does NOT solve the issue! I am still getting the same
'dubious ownership' error!
So... what, is this some sort of bug where UNC paths are not being
recognized as safe?? Or...?


What did you expect to happen? (Expected behavior)
Pull should succeed without security errors, since I whilelisted *


What happened instead? (Actual behavior)
git craps out with a 'detected dubious ownership' error.


What's different between what you expected and what actually happened?
I cannot pull changes from my remote!


Anything else you want to add:
Please provide a workaround.


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.45.1.windows.1
cpu: x86_64
built from commit: 965b16798dab6962ada5b0d8cf0dca68f385c448
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19045
compiler info: gnuc: 13.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show
