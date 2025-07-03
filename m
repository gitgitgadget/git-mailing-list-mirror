Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E52AF19
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571217; cv=none; b=SZePqGJsYHxGHKpt768pWwlX49ll30x9sInUV0UqT5jiXJJswXcRQsWhJrQu1r+0nYqd13ShisDaBdXui80nmsFj35dl0cZhvbXH+cFpATU7Scvi5L2vPjLqAGfMmcISfjLFGmZ42ngoNXT2xrOdcXs5shGQ8/snn+/ms68ilBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571217; c=relaxed/simple;
	bh=FS/1E/j6SKjDMh+5pC/HS07Az0vfcqY3UG8gD8yyab4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RnN5fmkiCANDmhcyYvtXzGxbsyjNB59ebiJC2G/n4HjdSodooGNqM3vFwGQeXiTWq921Uri4FMErhkvMy7BWlTXC0hLK9jZFqhVcreTuFzs8bA83eqG4JcxME3QjGMFVt/gXMfYdHQXZV4rEuSvxoNALjwD+RvspnRIkgSY25Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so283008a12.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 12:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751571213; x=1752176013;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2m+Q+JY3vJi7zNAjZTDdMF5xkbX/Ydc3K27q11H3EA=;
        b=nsX5rjGDfXyJ+CXqJiKINgtZOtEhJ42kfF7nilFCApyj3HVQrPC6FPkJs/ks9/8PMQ
         nZhUgPsblAJ0a+N9DUdJ+Lo5rvxNDyVco9wHtkynNqYn1c7yiO6y3z7M9PB00CIpYFDD
         yR5ZuDyvHvPKy0B85ZXXjlX1FlK0R2yOiJtiuQUrRPPVblCFnco/4+D2RxsaL7ib5Kd8
         nxqcE6C52CZVet/zf2vVKMpgkBFzqsBgP49Egn3poGJG9kAn+Y/jBWhXcGgMzc6LfUaL
         tYKd0Zo5oEMM00y2s4IKs/bu2sbdKzROsDT9XNp5MyYQ9portTCMrOnwyTwmo1HOCE8e
         4SWw==
X-Gm-Message-State: AOJu0Yx4PgJMR0HZpb4m8GuIkhzHH7RJxXceXPch941x++qiOozuqjyq
	47hwEGsIOHXogN5lbsX4LH+cJZmFfuuhQozwFjyhg9lWgUSqkpsC1Ey0GysSZ0T087Zi6iw3GNY
	2fir4tZXGUt8GsNHy1J+7Xj24VuHsZeQti2Rh
X-Gm-Gg: ASbGncvXAbnKTvitUe0BGH+LQzX4SbxIZE0LJv6xmQvZm1anAQOkI2NmXSyUn2htrJx
	sdVRFH7LmeNXNXkvCZm9VaeWVScX7GoIRwP1t8Pz4/VpzyS8KAjWJoNZ7FpOa+mTFDcNw3l000q
	HFkREcc78mhTuXmMJDfPrcwMbDFm5H2k5MeCnfKCSuuSEm/QH/tg1L
X-Google-Smtp-Source: AGHT+IGdEHYMKWC46XE02KQY8NV5+iW7oySvMEpegxEve0mKF1e/bNFRqMcUc2B9vKeQw7aNeFLt2Ue/OuTSogACFk8=
X-Received: by 2002:a05:6402:26d4:b0:60c:4220:5d7c with SMTP id
 4fb4d7f45d1cf-60e52cc2d83mr7568254a12.8.1751571212204; Thu, 03 Jul 2025
 12:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Per Cederqvist <ceder@lysator.liu.se>
Date: Thu, 3 Jul 2025 21:33:20 +0200
X-Gm-Features: Ac12FXyiSzFAr08LiWYtaPoxlwnKhZfsP3NSNWfT_yUj-nPCOKpxDTJVMQICU_Q
Message-ID: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
Subject: Allowing "/" in the name of a git remote is a strange choice
To: git@vger.kernel.org
Cc: Per Cederqvist <ceder@lysator.liu.se>
Content-Type: text/plain; charset="UTF-8"

Today I realized that git accepts "/" in a remote name.

This can lead to problems. I have a repository that contains a branch
called "master" and another called "chat/master". Just for fun, I
added a second remote in this repository and named it
"origin/chat".

Now, does "refs/remotes/origin/chat/master" refer to the branch
"chat/master" from "origin", or the branch "master" from
"origin/chat"? Git seems to think it refers to both:

> $ git fetch --all
> Fetching origin
> From $PRIVATE_URL
>  + 4e31956300f...30e26ebbb19 chat/master -> origin/chat/master  (forced update)
> Fetching origin/chat
> From  $PRIVATE_URL
>  + 30e26ebbb19...4e31956300f master     -> origin/chat/master  (forced update)

Every time I run "git fetch --all" git updates the origin/chat/master ref twice.

If it was up to me, I'd add a check to valid_remote_name() to ensure
the name doesn't contain any "/" character.  I doubt it is used often.

    /ceder
