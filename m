Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE5271468
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139554; cv=pass; b=EJyisQEVaUwLosvRzy1mVWmzSpxtuAS6hHc5W9NN9/qj1QXV5V6dYM20kNdrlPZ7mlB2YkFIcxDU1gAKLvH42mecWhY/vF8MOirHgboIT1pQwGg0oNYWOi12HJ6C4qY6uMN9aRD9+LcruarcFdDxKqvik3X9s1c+vJyudd8F5Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139554; c=relaxed/simple;
	bh=Nz8EfJ9TpWZI6OUm4vdEJbnvZcebA4FPdRhtECWJ5E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBNB6L7eyHuVtTdsNQTucrNhwcirtStkFoOz9Q7em/aEwm39mn2tGqSa+5diKwSkh6GjB3qBE+72iYK+R+5YpO0SCskq+4LpmKoQURaf1Onah5YulwyN2Csfv7FJO1SdFA7B4uHTsNBpLH5WLKJ65MmuVEww5jhhcyEDPdecSeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5bPNLIw; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5bPNLIw"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-600404dbea3so307149137.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 03:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773139552; cv=none;
        d=google.com; s=arc-20240605;
        b=JyFeMu6wJZvHC7nz9drOfFL6fwHfVmy/1uTAs3aeu7ztCJ01ax5SnfuABHTJV1Tkh8
         Xo71AnhasDEnDrKtPz3zIFYqRpmlz+BhWvhYVIpm8WXPl6DWGBdj/0KbcACFvHIv2r1T
         lWwRzMa7vdYzlMRXGY38TiJwJP30zkqS74u2LcEjE57vdG9sAiYYeXfP/6Rx5ZUsjX+o
         VP6tasva6mKKv0MB1Y/EK7aC7zLaG8bt2R6nCeXylR8Y1E42HL+YKj+y+MUFoTD3W83E
         ZiRo+HW1fyC93J6bktQ3hct4ui4XPu9ErBZl9LaSnWRxoyWm0wY1q9w4lkr8vRPon7uH
         N5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Nz8EfJ9TpWZI6OUm4vdEJbnvZcebA4FPdRhtECWJ5E8=;
        fh=WjQoJRz8Ogzp92fmPNl+iTSSOovLW6Hz54m1k9zWV/M=;
        b=GvYdv023yeu5Z7SoronVLqrtasf4TRefF19W2dDD2AaQ5s6k30WGazs0t4X1L0Lw/4
         N0n3Wg5OBtv9d0xHbTZCHEC6FQkdog/dH9kkpAfVUpbzTHGlIsKPQB9ua6bkki0M/04T
         S/3nmjb3umlspUkGpfqioo3UaWyUNpORDn25pOlcK73p/02V2OgNT+/9PEvAk03FIiZg
         rR/HoxLHjt2hcKEpUkjnuD1ejihhYBiZhQ26mNiRGLVttGbx9pIfywEbZLMr5djC9eaY
         lytIYcNjrqrE2k5denyv3h4IbroPnn1ivH3vLNGeyqgcx1vRzTg6htXL7gOm4xPPxDq+
         b4bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773139552; x=1773744352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz8EfJ9TpWZI6OUm4vdEJbnvZcebA4FPdRhtECWJ5E8=;
        b=D5bPNLIwP03fAgRNYNiPEl14MYRJh8MtmW1Q+8n3wuoPsjBY/pYlLnXl9Rq5I/owjc
         x9J/o165GySMedj8IpRnTEwaDfrooBwnEIa+vBu1Bqs7KPigB39f+w0W3frt5SKCMvSa
         HuztBdg5edLxk6iy+pKc17s45dFBfyGK+l7bmcuZpce7R/tKvSVr6tEMls8W1hGGWjCs
         aDUuGZX0r5Itt7IGoNFSfHvMETd/x0UnZHp2LRZZtgG1iyY9d2ygTSnAnjJCCqYzg/E1
         X613qJ0Ot022UFQSTFRe1RmiDP9TlfTfdQIBkybn2zNsqLU4pukN0nLp0OXMzAP7mGPJ
         XF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773139552; x=1773744352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz8EfJ9TpWZI6OUm4vdEJbnvZcebA4FPdRhtECWJ5E8=;
        b=AzoNjxcFCWvBAVj2gBKq14RRRoJJgV+oVT15bYj629HjbCy+z03JfSfNnf9Pv2EIsD
         awmclDsqgYL1k8MjyoK+X6Tie1mLTjXR1zUR4Q2wo2kRsJWy9NDn4928au+pHlVCXvx6
         rakaEwD6n+lPoK6u0w416ckWjcKCGYStwmvQ5wUtm5O5xXRdQR3KJsACCK2gW+tPZ+jK
         pBJlP8DYx8t3f+lp939gqYh01OHguSi6+vt7mN/DFCuE0iQeSZzONMyBD4UMzqEuz65t
         f4Tvz6A+9HdnbdQQAEhU5KEj5QcC0vEFW7C63ZfxjV3YYhdW3/x124F5BQAv+o0A7ZLn
         xDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnTLQOhOVgaqcp1wyTYCOrwbHuTX5JisSnwbk+gvess8YS18uYdHJAePc9qFCg0/AXiYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGagubD+S7XlsfAfPg7awm33AoMH6tq+mB4x9xjosQuZcvWNRE
	DTabKy142g95KAI685FsWzywd8ipzAouVDzV8unNpzjEvJ6w/sMVWAvHXb663J8S2R2it/kpEd+
	4xqx5T7lv/qnl+zCQo1PIh++0grZs260P0EwDms4qOg==
X-Gm-Gg: ATEYQzzpZWx+3FWeLoOFXHozN6sbm72vR//RcGuwaF3tkZPq1Gp95agmqt0r1Mt+YCV
	f7xBoT9AkvZKPXJwHkZjGpGTE1XuKPyY5loApZgo+NqgrhgRqH0fdGm1Qob6iaiO4icUQ1DKd9J
	wrOm5hBJ6ikrW6ohoOE26tMR2yUE5LEOY2ZhxwmnkiCfSDJG+OybU8KCULfDZ15WK7E29lUELPl
	SW7AD+9r86ubVFeD9pvMEXD0Or2oytWI6NmJSls9wW4fqTXi3iCTz6dpUGBpF/FUYnVRxeNI6Qm
	n94Iou0JRcv5tVUle5rHAG4/inzf9sBwzWsMTlOAZ6nXTWDpgfSJcDDqAvbCQJL2sPaXOSdo1TY
	ZJqtEwPaFTluwpNZuZ6Y=
X-Received: by 2002:a05:6102:c86:b0:5ff:a606:3cfc with SMTP id
 ada2fe7eead31-5ffe61248dfmr6873526137.21.1773139552574; Tue, 10 Mar 2026
 03:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <5f100fe0-d601-4ee3-adb9-a2458203d10d@gmail.com> <CAOAgETPnZww2vB1zz37nRNEJnmnDjwWyEPDHjRFuijin3memyg@mail.gmail.com>
In-Reply-To: <CAOAgETPnZww2vB1zz37nRNEJnmnDjwWyEPDHjRFuijin3memyg@mail.gmail.com>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 16:15:41 +0530
X-Gm-Features: AaiRm53dRwZcnXU4g8Cam4kvrGcZfb3vrVOG7AZFqr9C4wh0vnQoBg0BtFj9YIQ
Message-ID: <CAOAgETMM_TTQYb618va9knEcwWMwVKmnY7L6FNVcRvnso8JoWQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Advice on checkout dirty files
To: phillip.wood@dunelm.org.uk
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Thank you for the feedback!

That's a great point. Using "git checkout -m" is indeed more convenient
when the user wants to carry their changes over to the new branch, as it
merges the local modifications into the new branch in a single step
rather than requiring stash, checkout, and unstash separately.

I will update the advice message to mention "git checkout -m" as the
primary suggestion when the intent is to carry changes over, and keep
git stash push/pop as an alternative for when the user wants to
temporarily set changes aside.

Will send a v2 shortly.

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
