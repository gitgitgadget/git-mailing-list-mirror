Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A6B2BE033
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203550; cv=pass; b=lAXxTBYBM6gdU1j5u6tdcXGy27sZOTDauFMwLGlzDcy4oRlh1qIA0Z8Jh1INZU+duTVTSaQtPbYUEF3MwvQlARhMd9YGnjhRy/dI5o9sROgnVNPzGDxY6Dm1M19GZuMUkskgyJDImEWTesgrV8zwm6zac74lrYWGFGQML+oSaD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203550; c=relaxed/simple;
	bh=xnwR8rbZQ4uWfRbG7+kUx/5gT3gxpFa9z4aAKQ39h4k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Lwly+f/Kd7NdUxn1I1JTKCmOovF0pE2w8WDHeG9Cqiyva70fl7zqSQ8gok2GJtDzRF+rbrf6Xr3L2OBMMnhALFIwmmkH9G1vBl/bww74HV7P9mhT5D1Wm/PZOwKhweZIcKZcvcpPCUr2j1IMoxGJVLLjWzlt80oX2uh9THAcMV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7IJGzXe; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7IJGzXe"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso2953537a12.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 22:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787203547; cv=none;
        d=google.com; s=arc-20260327;
        b=LacqFLU3EOmWZmM7x7cIVnfFi+oTYjYr0Em6eIAivQcinfOhJaFPKc9IcEsY6kkpjP
         fxvXISI83B2UVUhduiFRCxbeGlSZP/fco0C7y/Wou5rHOIAzIZLJvSD1MYqjNpk6KJr0
         KTZxNGSMrMpRz+QQEQYGEoM1KudGl+BCRRKUqiTzcab2jR8JVt9O41qjJ0gkvg/36Gda
         toXAOmn5RUjXIlLvRRKbfVgw293IJSRKPbcgXruA1x1dT/PCA8Z9wqyG+R+8lTPnDUH1
         eextWkzSQJFfId5ZoFwjiD6aDHhaNAbIWm8Zqm5kM8xX9PNFalVnyBjcB2Tu54k9qWgg
         LtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xnwR8rbZQ4uWfRbG7+kUx/5gT3gxpFa9z4aAKQ39h4k=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=kpWOEklETYv8VJUFJ2dtnIwd2+gI+NI8RUQIXSMwhrAOs80tTp0835w3T56uAM+iAB
         /3pFjblmUwqKPcWRpeNZ83jutTJr09h33M9Fu6CFLiZTQEvzeV7sHOLsE4nxydLiC2D+
         i8JYZvCV7f18H1Dl8AIGAHEjGqtwA2JRuATZYsGNlPig1WIY5oTZ52yEx4eL41LB5yZ7
         mJAs6q2KJE/3uNAWVMxREOVk4FVLarUtj8m8WnAKe0Eu8069VRqq0b/IRWGQcaUXgTmK
         Y2Puq04+Xwq0s0wvwRwkx3dzymQcmf3bgaK5gmY8ciQ4VIKGvqY0kcDCeSclt5/8Us7V
         1FuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787203547; x=1787808347; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xnwR8rbZQ4uWfRbG7+kUx/5gT3gxpFa9z4aAKQ39h4k=;
        b=h7IJGzXeVE98075NdqENIerxNbSnWeybvCy+vtZjZEcHZDyVUT6LVLbiY8zQ9E6V2R
         IqflUJURARfkde2U10S1dWMDYdOr3j8IoMfz6+rBJMoE8PuWcxg3ZAggAI8YNU0nK0Gs
         GeYPkAbejbmHbtetr/dEQwBASvEre4HAC+eEVKXvVWX/4A6nkAzk9S/yix2jL+Oi+FLP
         lkQy6K+JdMeksNbcaHTcAd5d5JDy+tPkWCI0zCPTCF7buRSRzhDB/txdLc5/WICYUu6Y
         2eoqmYdQ7QiFX/aoHlzjaa+kQYkNxTTrXqTaNifdBfGsKSwjWv/gLQfi3n9PDYbc00og
         oldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787203547; x=1787808347;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnwR8rbZQ4uWfRbG7+kUx/5gT3gxpFa9z4aAKQ39h4k=;
        b=Jet/nhi+x9crF1H9KZPwm7AOPqbTCwy2f2oZO/jWY+ZhN12PmBBlYcPhGKHH5qHckp
         E7PdZk2bVp+W+k1d2/3Z6d7CCdIXwUr1UdeIw4VNxPIOsMZmxmkknca3JINhu6HJDFeY
         VTuXFffzc06zlzHXeSAJlvtl0K3NzWjS3uAA0gEUK+Av3/f64Dc1Cjg0b+eoUAFeCCWq
         NyS/+QlNNBXeoDTsitBd1QyLlEvf7o925nSpJqwo8lYtCRODI6zg/GT6Iq1c4I9ndG0F
         e0FF8E/3aaRuscJh2h4xPCVi/FOTN7KfZ2Wn4Y21yPm4Eol6oq7AHlZqqZkpjTfEwhqu
         HRBA==
X-Gm-Message-State: AOJu0Yz+rteB201Us3IDw4pdioPfsdFg3XRBesXedentRhknD0aOLjrw
	Jl57VU96TQ9YLwX8EhADuL6TL+lLzBFgsraX72ezh4r6T7Wut6nF3dq46/35JW45LVfXGgBFvt2
	5P8ZP/Vk3Oy3isZWine/NjtlcitnuW9a9/jFJ
X-Gm-Gg: AR+sD11davDMejKYnLuuuv+HDPY04HvsVvmQCS9anPwxX9JFaJ1YHWbIm+UN/IBq7ng
	kHDFPt6B/v1lm8++vFEZaPe99bCcR1v12B+3E+J7OvMk9RLuuQtiWQdoK/z+WA8PyZwCrZwWVly
	HphPg8uTdwazh+uusI24zYF3CB2rLGN21ykVVK7AP4HSA/mjVMxACbCt5DDx/aXHFo6sA1XM31X
	r7xsU5c/Hpwylwu629ItyO5K2xv+7z1u758tVdVz0wIja9ubxZwDSYMkWVxXJZlnd5lM/zB2W5o
	6DxgH9RJHVPJsu89/LsKlN836JmlQeNASHoKLKhuIT+c
X-Received: by 2002:a17:907:c789:b0:c1f:29ce:76a1 with SMTP id
 a640c23a62f3a-c23f93018a9mr718631766b.19.1787203547039; Wed, 19 Aug 2026
 22:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gahtan nahdi <gahtansyarif@gmail.com>
Date: Thu, 20 Aug 2026 12:25:31 +0700
X-Gm-Features: AcwNN1WiveIAgyYGnlnviDkrdjec2aJSqL-p4oOUlBW9dfX7CVNcUQr2OVDiN_k
Message-ID: <CAD2gDY0=heAhqP1wr8dcuXz0-sEim1M9gV6TMb=UCZJuSCDuyw@mail.gmail.com>
Subject: request-pull prints false warning when given commit hash as argument
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I noticed what appears to be a bug in git request-pull when the <ref>
argument is given as a commit hash rather than a ref name.

For example i did this:
git request-pull 5a12652e
https://github.com/gahtan-syarif/fast-chess.git 1ccb9f6e
which caused git to produce a warning:
warn: No match for commit 1ccb9f6e66dc1eb7afa7bc782e7631b4fe39d505
found at https://github.com/gahtan-syarif/fast-chess.git
warn: Are you sure you pushed '1ccb9f6e' there?

However, that commit does exist in the remote repository.
This only happens when I give it a commit hash in the arguments
instead of a ref-name.
Might not be a major issue but I thought it's worth reporting nonetheless.

git version 2.43.0

Regards,
Gahtan
