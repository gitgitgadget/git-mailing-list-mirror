Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC743CC9E9
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986297; cv=pass; b=D44E6tGSEAKrWS39yyhpKe76KfuH+6YpBJXs7GO/RWKpqrUXZGjMByAwgMVmIcZioos/Ds4qXEiQ1YnOecr/4o/JaYYgNhSTZArzcRfjTEhdvjWttjtlOex/3f/uWM3MGNqIej93dgx8vCn1XJSinwMauHzIRbH0VBMcooqNKVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986297; c=relaxed/simple;
	bh=T2dksjIWe/sT7NlDr92vxTF1p893UVpxSK5sBp5vBfk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VGPp3eGHuqenAW7rBDsxKyJ3acDr8drUzEFSbFooqr9oLR+RQQZb46hKFYTUGa0Dt/e/aKuFmURFkCihoQv2JBFZ1NHesnKZAU6dqcNFdVPnOcWl0x+6P/5ZeNBwe3JHhWX/D6QaQnnKYZinFoq7v3shiel0KjcMtd5f4UXAZtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4Klivx6; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4Klivx6"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84230ab8857so2260851b3a.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 23:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780986295; cv=none;
        d=google.com; s=arc-20240605;
        b=LZSVm6EPM60jAy8ocKifS6SAMDu4A8KpXmA3mcbsWKsLsROfnh9nBmdPx49OETCjIC
         2m/Kn8WuMsM3xaYOGdFKzUXkZlWRIq4+8I3xUmVWMCrwySmfrIaKq3npo1VyNZhsURu3
         AzhLHbmrJYp7X4ET9/82q4X2Km/4I+wFj1aIxZ0J4F4Lg6QQrLnSrXxSrR0feq99MKCY
         gUH50eVK05I9qqxOgKCwzg+BZ/qUdJQa6C1mE3EO/6a2ZEzqNWZWkolCtTjaBP4bFiNf
         DJXVF+fr5y6BDH/nLIt3Xvn9dyLhEuiPX46OgYQ9ScONRIgEHnmnzmGnYFCYwSf7bfE0
         iiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=wyaCSs1WrpKl2ecChU95d4kJgikdDMzUuYV665O+4/o=;
        fh=mJp7zD/aNhugTOnrL8dQ02PHrLAVRLvBineKoPiKXAA=;
        b=MD2Y7RRCsMb+eg0wYWRWcjSAPl0NBhCtMXshLCHgKNpWwUFtVPLfjRfNw+H/wOEwP3
         KxtQjb69cWpjqz2WsfJDt2ZXEGYrMOlBswv0Y1QQ2hLCBYKJftfm5dCND6Co1eyNRzfh
         dDX9Odf4rfek2hwMCEQvkvxr5vQ1qkBq0DnG0nyGbm+pYQoQTNhJ5aKqM3Q54upGsDCU
         /qQMXWRtzlfhzbWOMWvV5lRMpSWJJtFOE4127V8qEONa/u8XS4mngMiDi+1W3CI1F1Vi
         m7ZDCtl4dqKXmzuZ8sXA5f8mTjUXfObFgk3Ac1Eb7R17UaplWkXyYq7gvx/z1A8rmwPn
         27RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780986295; x=1781591095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wyaCSs1WrpKl2ecChU95d4kJgikdDMzUuYV665O+4/o=;
        b=f4Klivx6J3RIrxQgIPx1rcllloQnkjrxTBfQJLREilJSaOrGpir5DogObg6UqJ79TW
         KexZD+BH5VJmatBtewzm0I3bwmXCbUraY4gBlRFJejQ/jWk52Pr+QBmAd+1wa4ZkOqVA
         jgHmrViUU4ORlOGAXGMvtWNTMFX+/1fc2c3QzLksDjVojmrfFP315mLTiEAkM4eZIqTg
         0Y6rkgmU9mrlHszOZhI3qz12tD1cyNdCf0UeOWcs/XjSNqOQdvrQO6fjjw7GXKvx1haM
         lX36+7GJ39OB2CaDM0NtLEY05KDxd1ObSdTa+52C0FvTOEnItMgNpJQ0BZDDipoywspp
         2ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780986295; x=1781591095;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyaCSs1WrpKl2ecChU95d4kJgikdDMzUuYV665O+4/o=;
        b=XJ2eWwvvS9ZwMrryWUnakSXDnZKScw8Qhnw1I+1GNPeSRFAVRprbtIuzI4z/h5u5wu
         1jftN1nNrq9CD4jJ2Q5cFOzxySYBZ+2r0/J+gUqHWiAhbYS65ccqI3/CApODOIw858RK
         gLVo7G0JYfhQtO2hkXGtD8QP/f0ahfcR5iTkffDR6iiTItP8SawFFu8U61TxlmmKBl1I
         ozxw6hkhVSOvJfPV/oP+2NYFMOtbpE2yyGrpEYtAxdWlVCBECyk2jes9BQh9MuVWZo0i
         MSR8VV8un5kVk8ee3BfTMXqTfgSisArxU2FnFmXFL34q32qyxERSPucv/rbzdXpUHGqb
         E4oA==
X-Gm-Message-State: AOJu0Ywz5rT6cbBpEuWgQwln8rHU25vZBB2PswOuQ5dS3GFdKSpTR48K
	dfxREbaubOS8JexzV/50YxlRwLqTr2CeR4KxoA4z32gAasutZpI17awOg2mU3wwPanrKjzRwpn8
	bMSGP8EJP8ikBnwO8dxcep6+aAmeXJdA8XV2u
X-Gm-Gg: Acq92OFY78SaNCnwpiiQEvrq+mRBqw1BLpagGYyye6+6diK0+sxkz8QTwKDgYuJz6/T
	uVGQyd7hqSpFZGzfEYMJz8sVsy84BJnNY+PBf0Ms4xbzgBiWERq/Q77R1iFNhTX1MentkO6hxrE
	1fBKhdFSoF8XIuBuiibhCKBim/TK8F8K+oFPoRp0laB5Ci9872ak8GrX/dSiDbbRRhJLTfsAsO3
	2VBf44aaM/t0lCdh6yIgFWG4jbNa2IdMOr9Sjpz9fcxbtJKxdmND45hdfimuXiBlcuFPPHtEf3U
	kOxBaC/rcqgpRiIB87LAGPEAAeLxrhQbEfixXbc8eK65EfJhKMaix19G69gB1Q3H+zBNMj4W+z5
	/C/kq30fv1ruod2PVosR54B/F/swkqBjZFOazWw==
X-Received: by 2002:aa7:888f:0:b0:834:e882:3280 with SMTP id
 d2e1a72fcca58-842b0f51a46mr20428382b3a.31.1780986295208; Mon, 08 Jun 2026
 23:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Tue, 9 Jun 2026 11:54:18 +0530
X-Gm-Features: AVVi8CeEEEU04Vb4OWvDrSkjL7s1fY_c_MxVgOfaXdcMid-MpQBZshj7Jep5hV8
Message-ID: <CAGWgyh-vOBNvdi8zSCVT7nuZL63v3mBW3Bu09oEBkb=5fbLqaQ@mail.gmail.com>
Subject: [GSoC Blog] Week 1&2 : Improve Disk Space Recovery for Partial Clones
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I have published my GSoC blog about my recent progress
on the project.

I apologize for the delay in sharing the Week 1 update on time.
I am sharing it alongside Week 2's progress.

  - Week 1 Update: https://siddharth.shrimali.info/#post/4
  - Week 2 Update: https://siddharth.shrimali.info/#post/5

Please feel free to review my work and share your feedback.
Always open to discussions! ;)

Regards,
Siddharth Shrimali
