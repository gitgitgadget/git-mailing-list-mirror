Received: from mail-oo2-f37.google.com (mail-oo2-f37.google.com [74.125.231.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353283BADAA
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502914; cv=pass; b=o1/tf2Mq/Ngjn2Bovmei7/z266zndJZ/3k9dyvBbbrasNZ+VaemDLxbePoNawLSdRMjZwCVfk03+pJ9MKeMosNntTqBh38mjZa8buxy/tel/NUfI/phARgEuJe+DkxSr1JQddXSWeXwwlVl1duoX9O84IEAl9aCU2e5VgIEmOiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502914; c=relaxed/simple;
	bh=qOT2ayhv8nTGBhb5j1EvypLoQ4tT3M6dk99yfDovhIQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CGAEs9u0R9HnTCqJQiMC8Rs8nSCCcjPbHzWKANkqq0O75p4kC8ATg3WXx6E7dDOHonwGShzihzD4g0N5RWgmcn4WyFlWPjB9f2mhA4UL8fRuj6xaLih6tf1+ZvrQ0ytgvhvmJSqr5ttqvHD3tym/7PhI3tX5buYFgjfdP6lSlNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqZBb/z2; arc=pass smtp.client-ip=74.125.231.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqZBb/z2"
Received: by mail-oo2-f37.google.com with SMTP id 46e09a7af769-80032c08611so1766527a34.3
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 02:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790502909; cv=none;
        d=google.com; s=arc-20260327;
        b=JJDAZ0axWZuitXQtWsLt0IoTJr42XCE2KAwM5yuEU9FQPUMXkubyQbnrBRXb2gUKZ/
         sAaNNx+lt2ClTyjYMeIIgTKlfoBfgZnIgosGGr4uGBgEwfigWc6f/rDN7Ksf/tr90KWB
         PfhLoWJQgAdhgU4nOkkH8Ky/pqnrY7O+03fEXY0efdhPZIZ3DAcdw6g5VPMWyVtmtZqv
         hj+cOZ9JpXDGOPyjR9Qr2sUOxewM+7ityXO6+fzqCZkhDIfjoXsbLPoyoWst86JCMvja
         i2o0d+zzTxS8cIMKSrAO/D5xWTcQTT12pnJFzRoztTAmFL1urrgDzZLQsm3TXwNvI6X9
         ysTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5LnTPSHdc67FRpBANyroM8KR/AgOWiB7E5ItwgmZg9Y=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=f1qDx7cwFZvT0lmcAPT/EurIiJaMqZrP9OL55b6BtUn9AIY5kPvtXt84jPISsleF9P
         KV2qFzqwbxnKx+0aSw5Eo/KmdcgMNT40Cmawp9HMMxL8jS7DUzQdeB0JxYZI/6UBb+3+
         JhLjM3vG37XUdw58bb7XDsQoVJzH/KV7pqJ0SgTQVWF1V4/PW5amz/+mUE1p3KKg7Rjs
         JwOnrcn4MSdEfUeWoO0wCAO6RkILkPPRXitxaH/em46PR9MjMUXoNEKyn9K/edL9GheC
         dek1rkdDf/Dv0+60/Pel9zqgfDOHhI/OZij+g8xEUg1jYdQ6QETLj1+gJCRg2tl0oEHr
         75Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790502909; x=1791107709; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5LnTPSHdc67FRpBANyroM8KR/AgOWiB7E5ItwgmZg9Y=;
        b=KqZBb/z2gGGsGu2pR57qMDgrWBU/Mhhn4C9BHqsnn6T5lZTq+UfMh7kSB337q9sEiZ
         KfezliYG3ZD8jub0o83NvZduiNcRKAydtOuA7uNU0NypLIFZGr1SWXjLgw06OWSdSAj6
         SEILGD8NhWLRhvonOgBMvjkf9nDHqTPY7PeJQcdUfkfgLLwezsrCyjnnLTLHua11zC5K
         fKT/+HpAA9by1RNEJkWiJ0hUAstRnVEHPROKlLdLohsdB6hU/9nB3sLdAxZk2LWTa7fn
         CuJpm9TSHjMKsfbyljeh0UrRuUxQh5OmSD5FwfHv7LvQOINBfOXJLetj3qClUiJBGbRl
         gb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790502909; x=1791107709;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5LnTPSHdc67FRpBANyroM8KR/AgOWiB7E5ItwgmZg9Y=;
        b=qM9H0MkVAt49rUA5cwPSiD37JbSfyJ5BzsXWWjBId+5UAA7yRlS9YA4IEjC1JK8MiG
         EX7JXPF3QvJu31RIqzMHW4QpdqknmFDTgrXEnxKytllwKUaPO+L+vOO1vMmFRVXdfkW8
         ISqntpayHJN8u1QtHnAoC++f4OGwV5s0XcPTF63LRxy/SPXB7a8l+UiAN9U8ABO1rRTu
         TDOckjWL3tPddR8srj0sbnwJ6kpQ2uA8By5FW2eJIStIbiEMnjTyVb1rr57ctirycycS
         vd/O4hvwAkD1pcFyX9qPz7jLHF4hpesCN/NxcQVZeoeEcCKUXe1XiQNzf36jYn03OEbv
         6XVw==
X-Gm-Message-State: AFuF++mOA4rfx8rD6jP5Cj56i+/9Ogy7oo1Vrh/8RBJq7qS8H79x77yD
	RxuehcO0bKIoYTr3LG+wkDr8VsIoZGpTBUiKPk9QRJNyhfp5WKt2cqUn+sb5zbo2JckCPCq5U6/
	De0g6anGITXcw3Ek+fqVp7Np4G0AcjAjWl0pmsow=
X-Gm-Gg: AYBFou2MWXXyTTHj7QQnxTWlMvA6j2ZTWmfr60L93LNGy+v7157VHjPeAJmhYNsDP1x
	Fe+CPSvML79eEgAunxCY8ebLljGPYfMF+flGqAC8iaAnYlXd9uXbKvVCzTnQhguGaJkPv5jQZnj
	hnYvsbSF5Be9jdW8bD2w5XUKlym2SGXfEuLyM5XTlBMUW4ZIZLVARImtBYxG4WdxjB1cTEogZHV
	1NXN6xpEiZys0drJwP9soSj9vT+lUFkoS+xlxPyY/VEepglE9rOninB2nYCBuVyDTlnCmN6HLvr
	pvexJeygnzeTMDJcqZJa/oZlsxAbtgfsmGBswHltMVjXQNfWf/W+feVmwA==
X-Received: by 2002:a05:6830:3488:b0:7f6:705b:ffe7 with SMTP id
 46e09a7af769-81782b85155mr9945998a34.14.1790502909153; Sun, 27 Sep 2026
 02:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jyotish kumar <jyotishkumar725015@gmail.com>
Date: Sun, 27 Sep 2026 15:24:58 +0530
X-Gm-Features: AclHuK-Pcoxy2J6ehQF8OOy6TMLEwjeqnev6ERhWpbYy3RUNuuae15HztUvJ3kk
Message-ID: <CAGjZMyTrA4Fre7kaTq_=QGyobdEgC0a7U6-94n4qehBWMwn3uQ@mail.gmail.com>
Subject: [DOC] name-rev: --annotate-stdin docs still describe SHA-1
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I noticed that the documentation for `git name-rev --annotate-stdin`
still describes the input as 40-character SHA-1 hexes:

    Transform stdin by substituting all the 40-character SHA-1
    hexes (say $hex) with "$hex ($rev_name)".

The implementation of `name_rev_line()` uses the active hash
algorithm's hexadecimal size:

    const unsigned hexsz = the_hash_algo->hexsz;

and uses `hexsz` when determining the length of the hexadecimal
object ID rather than a hard-coded SHA-1 length.

This hash-size-independent parsing was introduced by commit
1c4675dc57 ("builtin/name-rev: make hash-size independent"), which
says:

    Use the_hash_algo when parsing instead of GIT_SHA1_HEXSZ so that
    this function works with any size hash.

There is also a related SHA-1-specific description under `--name-only`:

    Instead of printing both the SHA-1 and the name, print only
    the name.

Would it make sense to update these descriptions to refer to the
object ID length used by the selected hash algorithm, rather than
specifically referring to SHA-1?

If this is considered a documentation bug, I would be happy to prepare
a small patch.

Thanks,
Jyotish Kumar
