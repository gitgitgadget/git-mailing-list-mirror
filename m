Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046737C0F2
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887527; cv=pass; b=iIjpGNIqnwOtaoSSBljmOU46vqPxaBbvIrezbCnUmxvMweJFSR2OrhDNuRad3DKgbFRFbunT2xR0H6GgrdyzLhxIaALp38auRmDFzTnEw8yKxJtPX9QNk23dAhSrKbjNdEfw1E72hPkpOD96Z6ioVpYWRg29YFN7wqRMSOqLP7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887527; c=relaxed/simple;
	bh=Cb/1vz2mgv3iH08Ju00FuXTepobEk218rELNkhc0R1E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KYR9AExgyM0Ro6x2QDl7+EmiV3a3aA1ZYMRexmmI30IAKvKA2ztTA+aJB6bFSHWSn8+7OG6RlXJUqZq777tGT7lYgxRO+ytsshUQlVoVahgVtcrYDGoOgC2gyHcoTVOYyjHSOJpAlr6S6r3guIflkGkmmUOqoFaAnJ5HH0UsQ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdyO96Lz; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdyO96Lz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48370174e18so26414385e9.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 14:58:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771887524; cv=none;
        d=google.com; s=arc-20240605;
        b=h58xok9tRXsnM9EzVIeI500FzEGSEbkOBRYDx2smxx+ctKB2ESc5Z7RW6kRPoeAqXm
         S5nVyMMItc4tJfvlQRMTHl7CmeB/KatGvvSgXX+GgVqs4FNwwHGV+7XoIMdF6+nQTaCK
         9lSDxr6+EMngENKrJiPRZQDAZB7PGeBcnYUPKeQYNXGBPo1A/5uiWp8BfQVeRN++Eb22
         q4HFUtWECtf6HnmCnok7TLG0CaYsaLi69x1YUxd0SLEPYTIaU6VC+Vbc63tXRPk8+YGj
         ve9T6grkrExNdttUj+zJzKuJK+IDj+29THQGzDvIS5i1w3NAJg6gL8GUnWAiOl15o5bp
         xrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Cb/1vz2mgv3iH08Ju00FuXTepobEk218rELNkhc0R1E=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=MSWbdaMBHBaZj50U3JQCdVIpEVcQMfGB5NzVMA+kZR7LXmiOQWS5Cd/fWF1/SfB0am
         NtX+1eehy18ffE673OG8QDdazWAWGRUAJyTjyyGh0jCufFYRihJ2UZFRqo4ziWTuZimI
         0damppYI06t+FQbsgyrtuBOVqHLBDPrkGMmbBovDDvzhuM6Ee9CTgqM5HzxiCTMISSyR
         ZtwiJXxEDbX8nyAnTMrW7PWl+BjLyyNp+rLy2+oLI5gzH+sF8ryC6fc1M1KIA7AcR/dv
         EntjtXAMbr70/TnPVwhMwu764Lxqsr6ZSlKzCFp4mAdgwnBSalfrVFHmYCAYHS3Ir1Sv
         XVoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771887524; x=1772492324; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cb/1vz2mgv3iH08Ju00FuXTepobEk218rELNkhc0R1E=;
        b=BdyO96LzD95tXz5FBTkSBFkVfXXwTX7LLGa/QN0BnXPLB7mEIBUsG8GKDgH4o9s2gU
         ED5MsCBpJACScI8PSt0czIyC85UTnQ/OSQlo/3fxtkuj+9Mza0qHk5go8+SjgbumAEk6
         xWHM2OTmpxiDGW7R1LKag7iv+3eqjQzWxexkccirOpXgi1eDI1IGGRaB10w/e/TRUsEb
         TuCDNaHbzqXTZHJYm3WdMmNoLgW7KTZQYIyLm4q3x8KKWI2uFwPS/M9nxttm7QWogaqb
         rsu+WRcTwwpUnH9e/TSSzMlE6ywgHEf2OM2PH9GyvFzG0TXi+9Jb2VD/T8y/RgEPWdSe
         /1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771887524; x=1772492324;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb/1vz2mgv3iH08Ju00FuXTepobEk218rELNkhc0R1E=;
        b=sKlHR8+6z2qFIjl3VURTYrWVAfjZ39I4Kv17GljzrSxOvAC6kGQrbYCFqW3qyM1dpd
         tlJuDY3EoUoXMD96MdurK4/3WuS4O64BdsXGnMgvR1GXlVz4w/71tj8F4UlrUUR1MKJG
         HKWMxyzz511ILLExf0zqcCexVeWnWhT+64/cpwGCA7nt9A0oxSoXl3vYqvvRyxcOkdi0
         KGfCvwzkwgRvUPW4j8kLbTWykdSHz1zYahMkHyOw9yPlmf4l+ARZkGWOrRUD1hnfzn2w
         fAfylko3xCsXvRAn7JHxaFs6r0Qe/E2Gn2LgisAv85mmU3+Qz+bzTcW/hRAIGQeO/kH4
         et3A==
X-Gm-Message-State: AOJu0YyPcI8IwmiG9kfT0O55fgmNw5j5R+/2idhbAB6l6LFpeVqfRfxI
	3p0eNxUbfeKe320KypwGpwo2zsUIXRJ4Jx36kWwMbHYwAd/MrzynqcUp/M5Xna88/8e/3UXZBhk
	nq3AEH+UNvDSX206+BL2ra8gvQDOk56LH9A==
X-Gm-Gg: AZuq6aKBC2HYNrc3/Y7JloheasqUncSY/y+3EM3l7ck3fzigv+8mJaJE4FT5eaJmKtH
	NoFGhNDjqWIgKR9iAzVP8cmLRME5Kbb1n+BVeR/l4IjUN9DucADtWvRE4IoJhYM+qdQJvsbiEPP
	fVxD5c2uFiEuiwwE0gIkoyicAPG8hBOPDDHQ9FSCpnbojoXlxwGkazRnZ7h5fejQxnMNSJaa9WD
	2kEnnD0OKoM+gtjwymK9yoM2KgwFKMAweD2O0OmbR8rLgXoHYWkpps3miNZdCtfMcnnPSYkGsqd
	4h3E3A==
X-Received: by 2002:a05:600c:820e:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-483a95eb319mr180530825e9.20.1771887524158; Mon, 23 Feb 2026
 14:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matthew Gabeler-Lee <fastcat@gmail.com>
Date: Mon, 23 Feb 2026 17:58:07 -0500
X-Gm-Features: AaiRm52IoKTZQsWgYq0oaGud2ROqDWMQm2vGBDaHyPuVUTJZ7Cnr6Y-eC2ZeyW0
Message-ID: <CABpCjbY=wpStuhxqRJ5TSNV3A-CmN-g-xZGJOQGSSv3GYhs2fQ@mail.gmail.com>
Subject: bug: for-each-repo malfunctions in worktree due to GIT_DIR
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I noticed some scripts I have that utilize `git for-each-repo` don't
work if I run them from within a git worktree, but they do work fine
from within other directories, including the parent git clone of those
worktrees. The symptom is that the command I pass to `for-each-repo`
is run as if from within the worktree each time, instead of the repos
fetched from the corresponding config entry.

After a bit of sleuthing with strace, I think I identified the cause:
$GIT_DIR is set in the `git for-each-repo` process, and gets passed to
the child git invocations it launches.

And thus, from within that worktree, `git for-each-repo
--config=foo.bar -- branch` becomes the equivalent of:

GIT_DIR=/worktree-parent/.git git -C /unrelated-repo branch

Which of course is not what the `for-each-repo` invocation would be
expected to do.

Observed with git 2.51.0 from Ubuntu 25.10. I haven't tested
explicitly with latest, but I took a quick look at git.c and
for-each-repo.c changes between there and master and didn't see
anything that looked like it would affect this behavior.

PS: please CC me on replies
