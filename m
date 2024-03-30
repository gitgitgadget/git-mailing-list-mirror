Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1196C1C0DFC
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711785013; cv=none; b=WL7JmxhDYXGFLVYsteqIHt+KtNhF+vrwz/wLQ+yyQFqUp36yfTcAlM/nAW7NhiLCKw4GbY8cJXMhuoxS7YuhnkA6NJXbM/YUY+4A4hdeSLBp1c4uQl17i2lbPnuAd98ACzZ5doJpya2erUanfMWOrXS9Lh4u2eJrtJb7lhWeIUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711785013; c=relaxed/simple;
	bh=UkQi1wSSKbZRXSv1cVu5i0yfM4/ghI9PFUcU9uMsxi0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZNn7hfqRslY1EhvkNDwJaQ7EqbrayncvnbWLDiaYqfYgNTTUdxoxRO2KLbBVc/wiA2zYSpkHIpgnz8X22a1jIyJT733L4qqoNB2Vj0No6CgKTvpiV9WOc2taZEzyn69AjH6Hg9TLrQs1JntLfWTX2pFuv/Zic8kAORtTNGKodrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRlSZlVu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRlSZlVu"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3662feb90a8so19726555ab.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711785011; x=1712389811; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wC4KZQ6yI5+2dGaN9lg1zuXduD8/BM0c8x+W1YC/opU=;
        b=kRlSZlVuTp4q0DCKzfZkNtLmsvO3otdAVw2WbZpCEUNmKQn+NmOS7revUDE+Vp0E8h
         9aKyJfQxVkwkP8eAwC+xquYTCuUV2IB3ebxdSsDvaN0Ioh1FDX1zKmm9ec5Nxv0Ak0PZ
         RW0baYb2aj80JCXMajDwXmHd8a7lO79VNXbEoDhtAN3rwWgg3/4MwXus79ay0u0n4DNG
         PNIFMdrSDSj7LVRkZ/0eTOqUMhCR0nHx5TOMtzV6185wHn73XuhrzFrrXCazJ6b5xk1F
         RuDZ0vHJ3eQT4a3Nt3pxm4A5JmzHpOr+vub6QzSfG+wuf0sl3YkAzY1WSG8mvbsQXKQa
         beAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711785011; x=1712389811;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wC4KZQ6yI5+2dGaN9lg1zuXduD8/BM0c8x+W1YC/opU=;
        b=ivol1dIIICj4EX4PE8fN3tbRwjP3EhzNN615aE7TY2NfaztYbTQDcONWjrY3zbb90u
         rL/+cLI4xAVUiuLvfHX7u+IQY/NQAbw8oIKq13p6reGQYwR9IlIou0Ts/aVDHWXgv9mX
         TJ/4jkSTFmUjkuuXuwHC/Sm2l0if7vTiwClFI5v3fwsU/11NfTstMBM+IgPyInMl6iXf
         LNqgeI82PniigtqJs3HoJvP4sBnkRJ92xt4MgmUl4ICQC344cuhUDKJQnyo9zOdQ5CIx
         OQHa4ctdk8e+JQFikuTk95S8AleL3aPcyXzqaq7TwQoOe1rv910HSj7ydkSTIGn+mRLF
         9p7A==
X-Gm-Message-State: AOJu0YzOdv1gVjZdFnBPN/mkfSehoNX5HppJLEkmSqlXGRfiYoYSYWsf
	m6F5KLwyOr4vZRZLI6b3eHRChKvbZ5NIxwv7pWb5gdGgWsOudWu21tGzAJ1pmIjc3mHyqtPlXBF
	2wi6f2hdV7Qk/f15LO+VpIc5jB7ZROpH9A0/GJg==
X-Google-Smtp-Source: AGHT+IGVJhPnR2tiwjJ7KN+sgJ8wHYcXZTwQ3FxybEygT/2TpJ5gXMgMLX7uhZk0dWI1jy6mb2Iga290qRKbRodbCrg=
X-Received: by 2002:a05:6602:2be1:b0:7d0:898a:d567 with SMTP id
 d1-20020a0566022be100b007d0898ad567mr4223403ioy.12.1711785011166; Sat, 30 Mar
 2024 00:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mirth hickford <mirth.hickford@gmail.com>
Date: Sat, 30 Mar 2024 07:49:58 +0000
Message-ID: <CAKcCxfAVGr2QoaXiT81gVZ0mfq3zJs7TywRhJzevwKX7wChJ4w@mail.gmail.com>
Subject: Bug: `git switch --detach` gives inapplicable advice
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Is this a bug? "Your branch can be fast-forwarded" doesn't apply to a
detached HEAD.

> git switch main
> git reset --hard origin/main~1
> git switch --detach main
HEAD is now at 5a07c3bde Refactor...
Your branch is behind 'origin/main' by 1 commit, and can be fast-forwarded.
  (use "git pull" to update your local branch)

> git pull
You are not currently on a branch.
