Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B220C302
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876634; cv=none; b=jMLxJaeXrneb7oZpMOdrfpAuWSrNTD/uZFWK/SRyv3NQCe/amCyJJpOyG8IQodDclbPwRjSv2/Ts7og6zcRXzQMV6gNKcjKCweryGWGYrsWBwX+klb42SAJqcg7IAv8zOmyUqLxxUfnE6sQpNRyvuPhRAiyccGLQF3k1p0AsJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876634; c=relaxed/simple;
	bh=OdDXVlVSuD7bbtK+/LaCQ8JSlo0lFo/SuY3hXdbU+s0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=QEcnWqcTHKGEl9M5OaE+WVoA3iIwtvHnlS/44ncnkX8PZNowfwf0vTX3ZXdUi4mX3Uss5tpzacrBPBXsF1cXma1TIaACUnISQhyl7DCXBq6Sxd6OS7pmCs+AmlwSnzKmZWSAFpwZMDwGilNWa8nNyzrcx84V/zCB3h883mv2Huc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGVrgyRW; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGVrgyRW"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71e5a62031aso1617888b3a.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729876632; x=1730481432; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdDXVlVSuD7bbtK+/LaCQ8JSlo0lFo/SuY3hXdbU+s0=;
        b=CGVrgyRW54i/eM9R1+gfjnBhJfBVT0sVOgj7+cUlVSD1AMmZKycIBZxqb1M2KQFT1p
         +m3Pf8VP0O8DrnSvBjlJZe/Aq0yHSm5hMoZtXXevvUr/BZ11BSEHKqeamRAyPOVTpT5K
         K9zMCwpM8B64IOSR7VQahLIAW1Yx+MJBFLYpY/gVOJeH6fQ1piltXXi19VPXw/iYDZy2
         5bmdU9SZHW8vO4KjhqEaywyQy/IDOOhN4DS6ay0TMjtJomqJhU5LFmWzuC92+kWFVgo7
         DcT1r2h8d1hAdlZFbt5o+fysT4wzH2pJUAShW1RVxCUCp9ij1lHF0/vrFOezV69wzvux
         o7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876632; x=1730481432;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdDXVlVSuD7bbtK+/LaCQ8JSlo0lFo/SuY3hXdbU+s0=;
        b=gfLt9iMI0ZbaqZtnOoEgmH2v54t+k6dkWvvH2DF96DlfGtgvCEd8mfBellJ1B+e2MZ
         Al/PUKTfKu9KYNkH8nqx7cJjIR2mKEhKRhhUnLTLBSJaNzGx28c5SuYClY7tWwVhBqls
         1UXk577uVseRgpcS+DeoTJUeZTnURk8aecpHgdfiJvtAQhzCWS4qBPJfoDb9pT6bA0R7
         gko+biKHIPxxG5v+9Rd1kMsgfniHX+XQ2Ip/BQL8Oq1uQf7iA3dbrbyD+giB+kkBxIWK
         9SYA/p68jhyJWbFG7KLUXWafbYah6ppWedkcmkE+3vD0eI+4y1MgW/nxarSS4yiB5RR9
         /7Ng==
X-Gm-Message-State: AOJu0YzZaXITl7WsJiIRORE76UqntVe67JaSb5jD4rsmHStwckiMDN3i
	IlczPz2otXiVOjBTEr1rLBwiAkHa8N7ZQ96E8rTIwk0QVcegAleP7JlJov4o
X-Google-Smtp-Source: AGHT+IFmo4cUFHozD4ftkdq4j0L4eCmfnNrS6xc2P3N4B71Nec5aUBvT15G4vVrHWd5xuidHJE+6Ww==
X-Received: by 2002:a05:6a00:3a1a:b0:71e:2a0:b0b8 with SMTP id d2e1a72fcca58-72062f4becbmr323450b3a.1.1729876631346;
        Fri, 25 Oct 2024 10:17:11 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057935832sm1303695b3a.84.2024.10.25.10.17.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2024 10:17:10 -0700 (PDT)
From: Josey Swihart <marikoskacine26@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <2095118dfb4f88d71293a44127e6f63ecac083d621775a937128e000cab52d8a@mx.google.com>
Reply-To: joswihart@outlook.com
To: git@vger.kernel.org
Subject: Yamaha Piano!
Date: Fri, 25 Oct 2024 13:17:09 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I am reaching out once more about my late husband?s Yamaha piano, which i am offering to anyone who would genuinely cherish it. If you or someone you know would be interested in receiving this instrument as a gift, please feel free to get in touch.

Warm regards,
Josey
