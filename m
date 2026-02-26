Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65233944F
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069638; cv=pass; b=VtW1FkbWzMI5xnoEuvZb+nx7+ytnWCiPbByTyUuCAHqDBtAIaGam4aXqZ0SMlIf1zlYACmkiS5Wd+ihOJXygLiH3aDBFj9gREPQhGnHilh+yfHPXqAolPLChNzlX3onQa0ipSxBi0RasxWOR/X1eba1O03j4CaP+d9OHcMLS8ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069638; c=relaxed/simple;
	bh=+S1XxyJxJ9rXe9f86f//Q2SvvImCmlE0jDZwBqJrAcs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=O7/ccKwjmGAT8G8zzFSqVZcZIkfQw7j4r7EosZMEY3bA/2PJg164oJ6kbVabL/ZjwY5Z2IWXVPGMr5GuxQ+DP4FifQGgsI7vIacPdJAp0Sl5EM3F0FsVDC9ee8ZdhY08iq4d57OcwXuGGVP5EpJ5EmMXe3oWf5SE7EiU5pKiuNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/5QHNxy; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/5QHNxy"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-794719afcd4so2762337b3.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 17:33:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772069636; cv=none;
        d=google.com; s=arc-20240605;
        b=T6ngSrqtnvzwc1NBJ7fCY3rw7MrQe3EUFd8ob6q+PtuTJyz3saILhRsxfzCDc1BeeI
         sIWu2EysZ95q7oD6fsmbeY7pu9CGpxvACgQHkXBRSoklJ5JSkxOxYqJuRmL/75hGxijZ
         10u27IM5s0bnl9HsV5A8fSzC+z26g1Y/161nJ+qAm67laAzAnjK/CYv+yCKQz0v7PMTh
         gStwM7PW+/cSxSRgfFcI21caZLZNe1YRYqQO4QcHBmzI55TxdTsH2dXjDPoLpsmEZTKu
         pBIO1Km2LQHX6DWEqSpHvKO3SkhbprSnEaJ9Whgpae/XmLQECnDjbuh4zLw9BNCeCKmf
         a7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+S1XxyJxJ9rXe9f86f//Q2SvvImCmlE0jDZwBqJrAcs=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=LcBO6rNfql0C5S8FoXBo+BtWa0RS3VrxPlkTIh/Dnlf3f4ezljb1e4OTQVWgfBGqKo
         AzGCMKMjmKk03ApuB2C1lZRuHchf6gOG/C1qgKtUVuUNo2/kb/HWhV0YarvxtU1ZM98i
         OSX86xnyYFvVG8xuSQ3cQmNCV9uo1k/bPRvsA2d4XDaQRoX0zy6UCByWGH0iyNRtkfBI
         U9DDUb943Ln1vUDIJhx8jACWQzauMVmTTwm6eAJPxeF5CGqq0r4UefGcLgEJO5k7c8jq
         aSWMWjP+SBEFk6M6W7Fq7YuAKPLwMJXCzhjHif19NgRmx9TEPScbY83TkEe890L7Iyml
         GkPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772069636; x=1772674436; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+S1XxyJxJ9rXe9f86f//Q2SvvImCmlE0jDZwBqJrAcs=;
        b=A/5QHNxynCVCK9NxmRdT40BvfK6uGymXZuMHiaxxLMECy2dJi4/zqD37+qkFNEvAar
         J/gehnqcuMzonh8hVLXlYV7S72iWqPRw1+ua3Itst2aXPMV86fXC/khJmouQtbhFWP2D
         uPCDjdFXf9UoQWCRAlwzSW5BYgkkKUoomXDzguGAwAynCMINcJqV5f2Ex+FDafbuf3FF
         w1iOna3ikRkN9oJfInTTSOWWLV9hQoiWkt8K4Kk0JiK8CpixLXW7o199BwQgPGtx3i63
         +tcQP5yDOva8Ym4puq7e4PdfA91OfRIZgc9vldBCkskPRPm6EZbzARPfjNAejluzz2vp
         BBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069636; x=1772674436;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+S1XxyJxJ9rXe9f86f//Q2SvvImCmlE0jDZwBqJrAcs=;
        b=kBN4kda4fWq0caYVPAJK6usg70fDo/FVQpe/ReTvCJo/YH75VxFNvbZ41i1C/sZ+XZ
         zPRck6U8yZKHo329PP1jsiR8gMPg/H3OKwBubuZx4wR7/w9kmnoKeut5oJwQ5ZhOm/j5
         ZQD+Lj33BMQ8xpJeDeA3MBHOMoTY87XnMc2bcddEVNusF2v2TfGeoPIzr6hk3ynrBcT/
         chzkoQ8euV/UFqqf9hKErtlYUNKhGQnNwgvdUZEpoVIc7gVWzJ9PTOnNsVAaCDgYa3i5
         ZqsCPoWceFlTtlOIH0ODIbE1imPJlsuMGAZ6wsDnaWt3dhV2XT4kGb5YBEdl3B+cGeEI
         WUjA==
X-Gm-Message-State: AOJu0Ywv3IWfqo7tWosetUlo6ywKUQSB6M5Ne6tXmoQprFPZjPiKy80C
	SRlq++yi2yfhP6RmyWxGe2WkOQlmpIGCHML5ViJELEHswUP9o570dBYq7HEZDVvvPvuaFeYeLK1
	ZMGsqvDdf3FTbmybrMNO8fGgwTQY8maeDUO+h6MQ1v+Ld
X-Gm-Gg: ATEYQzwx0/vZ74fpzyDjDsnNWquV78e+hpBklT54ssbGAEVJns5TkQaHLKh//GA/jDB
	I4Jwaz8FxCIEUXn2Fh20Rv81wtVcaLTAXhbiLhwFKBvQH0qWkxqb9HxDYULu4WIiTGcDdb3k1Eh
	cUBoNXsFZibVvG7FYdfUju+wzXwSyRz6uo0K/IICs3F41C1wo1hIAwBnJMKGSFbeRKraz9KKqxp
	0UKwaZNYUJ+WDjKwJyZHnbTB4WhuOaqPzcpVyRhHkYhQHoOH2SoSgiHBD31thuNlj38As90CpyG
	aZZ2ueU4DEpsiupoHPllv8HFFrahQ/avT3End12V1lY7dJP8VA==
X-Received: by 2002:a05:690c:f02:b0:796:4f04:bbc1 with SMTP id
 00721157ae682-79828ff3631mr166607427b3.36.1772069636041; Wed, 25 Feb 2026
 17:33:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Santiago Leal <santiagojoseleal27@gmail.com>
Date: Wed, 25 Feb 2026 21:33:45 -0400
X-Gm-Features: AaiRm52q6xtiz8vH6SjsQF_WE6CbV3gasJxynIHahpMpiUyEHiD1GlTuMMpYjaE
Message-ID: <CABFJD6-7_bkixVA4Oj_JV1N5hMqFXFqBvK4KBAjM5hqcgC=_rg@mail.gmail.com>
Subject: [GSoC 2026] Early Introduction - Interested Contributor
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Git community,

My name is Santiago Leal, a Computer Engineering student (3rd
semester) at Universidad Gran Mariscal de Ayacucho in Venezuela, and
I'm interested in participating in Google Summer of Code 2026 with
Git.

My technical background includes:
- Languages: Python, JavaScript, TypeScript, Rust, C++
- Frameworks/Tools: Tauri, Node.js, Electron
- Areas: Desktop app development, scripting/automation, web fundamentals

Some relevant projects I've built:
- A cross-platform inventory desktop app using Tauri (Rust + Web frontend)
- A sales record management system in Python

I've been exploring the GSoC project ideas page and I'm excited about
contributing to such a foundational tool used by developers worldwide.
I'd appreciate guidance on:
- Which project ideas would be most suitable for a newcomer with my background
- How to set up the Git development environment
- Any recommended beginner-friendly contributions to start with

Thank you for your time!

Best regards,
Santiago Leal
GitHub: https://github.com/SJLS27
LinkedIn: https://www.linkedin.com/in/santiago-leal-970a423b2/
