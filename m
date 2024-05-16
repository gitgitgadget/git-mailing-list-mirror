Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08014533D
	for <git@vger.kernel.org>; Thu, 16 May 2024 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886911; cv=none; b=sakHKvccmgvkbJRzLy/EAqoD79ij62VmZGi9IJAGIcp1RTv8irdXQyfK9Cciiq90Q0EQoLLDhfx7c8chaexfmqxAwh53MZZ77nA9XWI8L0RQdz6pkkr3Yf6YUMTu0LJ7XdgpGQSlDRrh+z9V8SO13hLYW0edkBW34ZqVMaxA3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886911; c=relaxed/simple;
	bh=Zw4MMl8CaAL8nN/9oBvmjJ1C63Qk87yC1MvFPZ9wGFA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Gd26KdKHr2ZFpYdAWqM1gtPSConsGApT9b7HnAKgS+BNba0RhE+HOC2d4yUNxZ7jQnn1po7fK1s30XJ5yKkvVlb+RtHQh/pvyKH/HmWeaUdC1fP2oboO7cYoI4dI1xCb2Y+44gxdL/+1JOI+Eb24PKxF7tNuxl5xffJrrLc41Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyFAzPD3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyFAzPD3"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b37bc39decso446350a91.0
        for <git@vger.kernel.org>; Thu, 16 May 2024 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715886909; x=1716491709; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zw4MMl8CaAL8nN/9oBvmjJ1C63Qk87yC1MvFPZ9wGFA=;
        b=EyFAzPD3NlB10kMP31mxuIjNYCQtegXhx0nK2FvCKKqDq29Z/4DGuxKFXRni0rez8S
         3p8oZM01gibey49BGSRmSVKd7495ciy4y1tDPQCwIn3Zv4+IAQ5SgmzjKlPNWNO0bjbV
         q8HthcP8CgZxT9lIIioD/mTvDQ9bkXlVm61NbICRTtEe7OYN2DsGcejQaDVmfmNtHXSB
         lJvJywVGiUBVzDWf10RlljcBpK6cTbd2fRI0v7LKNH7nYJ/rFCmRnKE/gjlCPB3BbI2y
         1XHS77ftlcqZSEXq9lkTcjAG9bxJyY4hqJu3yCSEvzBOCcnjmqEQy2tyCbwL413EAglr
         LWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886909; x=1716491709;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zw4MMl8CaAL8nN/9oBvmjJ1C63Qk87yC1MvFPZ9wGFA=;
        b=fHwnvKwMTx9v7o+EuWU1WiBS88ul/GiD3Zakiq9t4iOlcOIlGhE5wOzqs3tTQBhtFm
         09XvMmc4JREpappgj828M74ZEIUKYsl+hIim83Z/8KkZj/9o16VUu2yG/kLSnyAOOxwj
         6+072EEEPSriE+X6pZVhOxmyaLyWJFC7/c8izhozE3U6yOoZDpVoi+xdJGEl4fzBormC
         x0mnV1V8mqQlCx6nyA1hmoKFm7yiOZcp5qjURy0TGkj27av4bUaLU9n6eYSwrmCHngwV
         7f5gC9pfjD9Fpq3UBbRVLisXaNexUG2HJbNQnWyP4M+W2wOn4u7sQtOZnLVO6MN5G1pN
         teTA==
X-Gm-Message-State: AOJu0Yx0nAauoWOQRpNl6ehGoox7wFQGY7Ze251i3jGrozIw4xl+q3bE
	n2GQKWvfEPs3G7if/pJI1Vx2dSy3jhKwYyHZKddGTINNPBqs3moeJemV6ohBigUajPz77Gfmhpo
	dCiZVOZQzY26muXYLzSgc4bDudW1ejyRz
X-Google-Smtp-Source: AGHT+IERT5jI3TmHTH1HaC+NnjD9dsdCSpx6u7ylBr2J66LgrATkWu47DgRorf/jAdu6Wap+gYhXbP88wgqUdfOPO+w=
X-Received: by 2002:a17:90a:c68a:b0:2b3:7af1:a9e5 with SMTP id
 98e67ed59e1d1-2b6ccd7cf8cmr17643176a91.42.1715886909144; Thu, 16 May 2024
 12:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Azat <spektrokalter@gmail.com>
Date: Fri, 17 May 2024 00:14:58 +0500
Message-ID: <CAH68kYk-0kaXGeX+ZTXv3MutnX0Y=CmkEK660RC+V7+fXJc-Pw@mail.gmail.com>
Subject: bug: `git fetch origin main:main` fails when main is HEAD
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Clone a repository and run this command:

git fetch origin main:main

What did you expect to happen? (Expected behavior)

Nothing extraordinary happens. The branch is up to date.

What happened instead? (Actual behavior)

fatal: refusing to fetch into branch 'refs/heads/main' checked out at ''
fatal: the remote end hung up unexpectedly
remote:
remote: ========================================================================
remote:
remote: rpc error: code = Canceled desc = running upload-pack: user
canceled the request
remote:
remote: ========================================================================
remote:

Anything else you want to add:

If I checkout to another branch and run the same `git fetch` command on
this branch, the same error happens.

Further, if change HEAD but keep the same branch name, like this:

git checkout HEAD^
git checkout -B main

... then `git fetch origin main:main` fails as well.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.45.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.9-arch1-2 #1 SMP PREEMPT_DYNAMIC Tue, 07 May 2024
21:35:54 +0000 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/sh


[Enabled Hooks]
not run from a git repository - no hooks to show
