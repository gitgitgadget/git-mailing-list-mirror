Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D83BBFC9
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684378; cv=pass; b=cgxHioHaSoSOJXL2gtaI/Qii6A2KwaZRcDWjC30n14Aet6dfWmEkPd+vJhWarEpn5RafNmEkt5mCbFk9EB9ifzzb5YOxvedI74NEgQsvl2a+TKN0tXDYrOQW5snI8M3jpazawZutZwYG69GiO/hD88qwilQGR5vpQw3vyXBu7ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684378; c=relaxed/simple;
	bh=wOdbLZsPfGvorgKpGhhuFVchiLiFuLzq9QIR1PhRfHs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rn83fhs/9IhsY88c3Y8xfGwPO4ZqZvzrg5k3OQ+BavkbmWQZAq3sxCEw+/xQlUDN64XRhto6CV8tIC99u2+T9R065tL1dLOizvLgxJ2VgNKNv1uavnJMUx78E65OHEVxwNJIyZrHj5/eCZ4oOcEGUKmo6FPzdyh9pEiuP8qZUK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVSKx7Lp; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVSKx7Lp"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b2aab18795so2117672e87.2
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 08:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785684376; cv=none;
        d=google.com; s=arc-20260327;
        b=Eb668xtQLEA+1BCQj+6HsIdI051+aJ8Urq0WWhy08PNYk9PrtxkJcapFmkjUyQHWsd
         IAHvP1njtTQVKHgWOYokTv/fgkuBxW9eqjpEZz9hegY5KqW4wY2vJexQRt0+0d9nwb+j
         SFp+r1HwmEKF+MdXtu+/Lb9TtULgjy8mGgo/gbXHUyiZqs5XggGQ9dDCrMm9e0s4SWkM
         ssSOq0Kw4jO9jrhZh+1hM4j1QLgvk0aOiByQadj98/nJlWmAd1uyNB6wkYEn4o+W0zH0
         IlJsRQF5LotWea1Aw0qHMEvQZ1evIYtIkPlT8zA/82EfPEwbYd11/yTH9iHm1csfzjR0
         e/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=wOdbLZsPfGvorgKpGhhuFVchiLiFuLzq9QIR1PhRfHs=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=oRUPfExJQQC8xUr7KliILa+R1FWZuD//BEIMnEfQo46DiZrHUjjFYy8zMBk6jnPjTw
         uPGZ/zPKYwV9IXhtjDbheVlu/eeX5D6BGP0lkxBzb+s2g7RN/EcJpldTWaESy1sESzJ8
         E3mJiTAkoiV7Kot5lAPNy4RUyJ6LZo3j5U0Ldi+E56VFNzCEuPvO5sLMNO6661suRe4p
         EdOKJm5uWHa5jOANgaUm0c+BEbpVJ0Q8gxoQfJDxm6IleuB617g9qsIHa7lIHFFqjad8
         waQs4A2ranDVaJaPmFWx21qI2wQeDZ0JTdvTB+ZFzL9Yk9bSfEhNC3XKq3OiheoWr24j
         j9jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785684376; x=1786289176; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wOdbLZsPfGvorgKpGhhuFVchiLiFuLzq9QIR1PhRfHs=;
        b=JVSKx7LpLJsivm4tBVcUM9PFx0Us+a+rxfgJuULaAXI9BO33jv1WnZDOdy/sWebU+1
         Kbey3QUw70oyJbgLR/v29clMonpFQ0iKskZv4y/7+87PvOdpWV/Vdy/ziVIk/zITPu3M
         gOl6LJdc6DO46wnYPhysL6eNnZhJZsPBipDk4wMmS4ImuBOV6HvHPAxNhx63xJ+P5Rvw
         3uoWOJfyeZRQpLC1BAbmfawZ+tBb1SYlMs8L7MIETumgltZMOdErMazXyLCIe0VbDjv3
         KE3ni3cJqmPydjwJOI4K9ONLpogmMIAiXQ4UUYXOifcaCOp69vELondi91rM4/g8zPFM
         bgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785684376; x=1786289176;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOdbLZsPfGvorgKpGhhuFVchiLiFuLzq9QIR1PhRfHs=;
        b=Dacg5hjHVpFyApxRIVHdiPpPi4EkY9hnkDdg3ZaEBXGsgCk8eEXaz6NfM27hJBME6f
         ilcfwKH8c0s6sU2DAitjeBkLLF6FXZL1UnkMPejQtge0fmfLOhE6/J1zj0OselB7DA/N
         OrFzT3kNAW3e4sXcXWNly+D+On49uWuPLP6AAWWDeMUTlwP9yE9VGlmveF90BHS998+q
         fv8G9jriMpr8y4CFFn6si4iJX7g2RY8CWYOPCeoHvFH6hEaddJSvW8G3G4e7DCzxwSVB
         whwUMXkDpukUodRPqwAU2FIK0d6DBYXGPqF2sDxdxEoIzRS/xZrbTEqknezNHgrF3teL
         SV2Q==
X-Gm-Message-State: AOJu0Yxy0LMy4/SILHba5nm09Tdu2e9Jv1fuYouw8Q8qt3jeA7l1QDqu
	gEHU9/rj26FH5xOvYxPgmsoiKFA3WZHCogEpH8/TbLkOk207Xf0wHx7+7BHLKLgwtCtenEYBCwm
	zx5ubT684oEn/3efb/mR8QtsF8nLAcmafMBqOgOQ=
X-Gm-Gg: AR+sD13PyuP031N+xCyjtDNr7PcyU3ylQL8DDPJhYK5Li5I4RWwx9YS7g1VHpNG7KYc
	8igNWMTYfAMtQpA0mG2E678exjW8nKMigGo/AeHXnN3FtFZ8cshknRFiyX3t5Sp6TvGEjWgA+7x
	1Yvk1Bg6BkwqrQcf7kxVr6MBN6ealdA4JwxJsD+T5dGr/nxUybUtn1oWzUPoBJaT5kuSBR1lHJg
	t9qj8Ggt1q5XV0gJXz2QNn/yb0fKFsFVoEU2VdptEmhxE6qz9TJISHXqYSOzPMWa4PGKAUfCJvj
	b/gAevXcGI9GPC76yDxGPUC1J/4Mh4t8kUk3xsodbA==
X-Received: by 2002:ac2:5469:0:b0:5b0:1b78:495d with SMTP id
 2adb3069b0e04-5b2e4f33494mr856866e87.24.1785684375457; Sun, 02 Aug 2026
 08:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhonghua Zhu <secondsquare@gmail.com>
Date: Sun, 2 Aug 2026 23:26:03 +0800
X-Gm-Features: AUfX_mx-E2NSaCM7_QwCvFZEJpDaNvu7T4sA5fU8jPSWkJcn9KC4Cr0k5hEcjKY
Message-ID: <CAMkxerjdKYz7crNChsQyPeBCw0ZQVqeZNqtX47ZzJcaUyYjpGg@mail.gmail.com>
Subject: =?UTF-8?Q?Proof_of_concept=2C_is_it_possible_to_use_git=2Dremote=2Dx?=
	=?UTF-8?Q?xx_to_support_mono_repo_efficiently_like_perforce=28p4=29=2C_maybe?=
	=?UTF-8?Q?_better=EF=BC=9F?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is just a mini project, trying to use git in mono repos through
git-remote-xxx

Link: https://github.com/zhuzhonghua/blackgit
