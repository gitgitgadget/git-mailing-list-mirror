Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6AB501F43
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903912; cv=pass; b=m8l6QBzA1nHkb35kzx3ns8PK1fzZiJEkrcqVyi64CnlbD7272Z9uz8F0A0B3BM1GiqTXC4qO4++AzUFWYMWUJU+QNrwcrz0HIxvR8dt+tRZIOqifvbXSSSaT7hmcw5ZXSs8u0Lm6y5g1509JxkVHWYg8PCzo7FUTscqJMM/KWaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903912; c=relaxed/simple;
	bh=+Fg42M11Vk6RRgo9cyK1HMT5sHQzZsKWCk+hNTwsvJM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OYYwzWX/ijtfr38lHH2Wb4kEcehQqpAv8E3aGCojcwfjCrv3DsZfMkOgkupGPJVXEgz/TyGItQcUUKTyfO7yETq5RRAbfkA8XDK3QWa8UgMumbQwDfNqfeqV/DjNNnw1xB6F54bLXw3f1sl2bNGukJHuOtocr9i5J/y7jf9DQR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK1jS3Cu; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK1jS3Cu"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8a83d2706fdso165417b3.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 08:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791903910; cv=none;
        d=google.com; s=arc-20260327;
        b=P+TzHDp7bowhWXwCDUlgoSgq2DKCj2TTKhbz9BXB1zXWCgLEEiFwLkKuk7aOcEUIk/
         g7zFTCAtLbkIkcKO4/AAFU6vfX2j0PH9h9uB2ClJcPWZ7+ezwCQyZFPWOXDVBEU2gbku
         4pbUIcxVNgZJMrKSLnLMEVPZrqvZ8QC1SCMad6GfGz3adQzyVVo8CeUz/JKgA2uLs5lC
         7FGim2aPIg757rd7s2EnNs4fW8Hl0X2dTmcbQyuYrKpmqrrLh4ugVDS5PW0I3AEozRdp
         50h324mxJ0xhwL5mOyowi8b3BiIyIUCAplqOwKpyBjeG27ReXMlbWrM2SKCkBHU5c7qY
         hMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=+Fg42M11Vk6RRgo9cyK1HMT5sHQzZsKWCk+hNTwsvJM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=j/TYMPgTPWjhwdG6ukquOremi3Vke9itnyss/AdXQ3IHbB/YI1X1rilrmi6pGn/5uy
         sgwP9Qen922zPI5tjpNo8ehB4b/s2pBotYFIO9yQP2xVWQKbmegTe4oF2tU6yhRGxZW2
         ogRMxRQS+T8rQSdGdMauvGUL+n/Sg30Z8W3/CtLpx8Db6ee1nAsTA+eTLw+c6FQGhjHN
         iA62xgiihp8b8RzaOatUfVrC9T8TvGesf6Gvpm8HLt4KlfXNo1ihcq5R6IJfvXs2njcj
         LPRTh7NNzZHGb/huc0mZQJVwyxv4O0+oJJLNO/axLJsdchsyQHXNQTmC171qHO2HAhNq
         X/PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791903910; x=1792508710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Fg42M11Vk6RRgo9cyK1HMT5sHQzZsKWCk+hNTwsvJM=;
        b=GK1jS3CuJeyhdEPbBFkTkXZEpNm+7oKyAx7OZ0KLjVAD7RJJnwVoXNKAIvyQaqLTfZ
         MJNI7l+pKhvjTNXjOWTgflswH+9NwQADZyEnAtsCF7CVjS0mfrJywpNYdYwi6DX3SaPh
         pXDyJPogfbW7ClYtD64F/HBI3kZ10md7tywJfagp8l0JR1xs3gliMKschNLiJHcM3OMz
         iyt6XRCM72VLjnUbAil56qAIz+ncccAswIG60qZNJcSJvy9ImfajP1HkmoV3tw7GPwBH
         R6xdgerLXuH7yxGfWSB51f17E4kw/oSfQOEwoK5hwuB1Q06KFA4FOUO3oStSrv1x1lCm
         tUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791903910; x=1792508710;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Fg42M11Vk6RRgo9cyK1HMT5sHQzZsKWCk+hNTwsvJM=;
        b=NeakNQ+kPsFw8EWBPFZ1+h6wutJ4MD6e2k9y95ZQu9DFr4dcSZtOUiUoaZoRluVPed
         0H1um4L1mBcGlI2db/IaaZnxpAEkLminjtNyeyV8IYJsvsXkrhao2lkv4PMpsnFl/F62
         /IfzeurEgSek1KO/uEynOXhWbGM48KG+IAbGECraruPXtDKlDP6UTUGdAPbbSF7ps+os
         CFTzj+ZeKrrjzaBb5QFPhV++BZYs6oVOJpDZrIzVjTJ6JtPYKiUY7vepwLpJVzojcT9z
         NUlFYg29mhKSKfsPIFpB0mmgBLPXmyvD9FVrFpNf+FWv/HCVHiuk8D6wMgw13vGIvoE4
         v+5w==
X-Gm-Message-State: AFq9FYLB7VKnb6NXorpeZxQKHx3Mqit6/INAyksxMvN+wMYcG7/3nxEn
	5C+jTJD5zvUgNJkXyhmhZ7/LAQkSLXaB5FpqkQKCyAChQuXyRvANS9aoHwWVGpuQDVz1F4NCMfi
	iPycgmBsfmBuPYf2o6pxl0lhV1rpruMLLVkev1L4=
X-Gm-Gg: AYBFou0qTRnXUbR22f2M4kCiwHPYHjjwSNARtiw6vffNlSVI4ZZbMYIB50XoZMQDa8+
	a+Y64JhahfT4Tb/gn7V5PMAhMzLxrIGk4S2YtL/1M5eNeVVyV3Ml4s3549xeViv9/QJwekbJm1g
	pOAhFk9XxKUD9mbrKOPWSrtfkHPr8wPztQQmX6taYPCTDPpGuh0DzRHwl2mi/og7bKznN0cpHr9
	Ts17KSXSfjVLK6BVIuBtwE994EU1D8uzbyL1xNLWJNozwPnhi6PgUZcqaNl4ppieGglfLV0zgE3
	K/PJfwCWCOsly1ppw+khJlLIzzyldPSvKotT6LZxr1Zcn+PYZjtzFghYWQ==
X-Received: by 2002:a05:690c:18:b0:8b0:8e9a:a4d4 with SMTP id
 00721157ae682-8b08e9aa983mr33795227b3.6.1791903909591; Tue, 13 Oct 2026
 08:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Tue, 13 Oct 2026 20:34:50 +0530
X-Gm-Features: AclHuK_dDAU2VOvOVvvX75eqHkuNd04rUrWDdF1rA3sA_B9sF4NNkX-WcpAZRog
Message-ID: <CABh_KWjjVPGwLPxvUZsFzaSBPBvhMNeaVbTdk1WEZ7bruYWU2A@mail.gmail.com>
Subject: [Outreachy] Microproject: Modernize a file check in t2030-unresolve-info.sh
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git developers,

My name is Srujith, and I am applying for the Outreachy internship.

I would like to work on the micro-project =E2=80=9CModernize Test Path
Checking in Git=E2=80=99s Test Suite.=E2=80=9D

I propose replacing the assertion

test -f .git/rr-cache/$rerere_id/postimage

with

test_path_is_file .git/rr-cache/$rerere_id/postimage

in t/t2030-unresolve-info.sh.

The goal is to use Git=E2=80=99s test helper for clearer failure diagnostic=
s
while preserving the existing test behavior. I will run the relevant
test and review the patch before submitting it.

Please let me know if this is a suitable micro-project or if you
recommend a different approach.
