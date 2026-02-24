Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34667288522
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911991; cv=pass; b=ifAQp1S3gIjT80/V2e9KGbi3sp0/lgFQzBjEh67kK+1HYKJiqSUSjcn9f/pIAIOvELSIA5j74w5Ke50f3dRU4pvd7G7uIQa7lyk8WZFmBnezWf3ujA/L7UmQMAVjXx8QuT5nW/afz/spuTWo5ymHhFBmA37ZHHLy0RPkYgK5I4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911991; c=relaxed/simple;
	bh=QZZSNpgZnRSMnhSuafDyvTsLWBxlKNfCFhKkAaBGl9g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ljnCBkDYW1wbiRojKQd3u++sZ3m5TmDS6hBdcn/GYzEk8aR7jkRaaCcMBjYXziNDxH8se3S/du2+MXtfX1BPaMumRzKxL1t85e4GmntY8ryXYdNJNf6ie/A2k9l5HQgSOHedt9QGA5b1wYwjEIznt0IfKTi+t1eMyFuxwiPl7OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xot9iPaB; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xot9iPaB"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f97c626aaso719425666b.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 21:46:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771911988; cv=none;
        d=google.com; s=arc-20240605;
        b=fyf5cmuPQGY/+kOLpY0nFWJgqw7mxi8gK0gQPMRdJ3e/KDw9NUNeN7iAgxM5LQEe75
         lXQnWWrmzcXnPzrXfNlGJlFgR3YQyPwJ+vBhwBzFV0QLcLjdYsgdKccxyTFabGh3vXt8
         V0Wfp151RIE6LKgD/TOREImIbYpkiAUsaDMc8aRJaSto6Dpig0VycWxceR/QTK0yVSqi
         yRcrVGFjj6F4OtXLuj3J4gOBx4fMvppmoBD6T1bDxEYRh883zgrhHfEQH7eaZabPol5W
         3isLDS+BG0qQBI+/0KDgvHVaUx7eCq2Qw8R5ylbl9kH9IRnNrrpuMscbNxLSaKxOtjYo
         73Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QZZSNpgZnRSMnhSuafDyvTsLWBxlKNfCFhKkAaBGl9g=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=QCfzUYBKTWK//5NNf9r/+ihhVApA3uOgOG2iEj6J9s/2d8CkDHvjusx/5gKr82ezHp
         DgbMytEcDwOo6ypj5K3Q31AyDzgxoH5Bw59/EEJTo0zwAiMqZYgeEp6tgRMkEZi+zNez
         kauSlH3noBY/lO2vUzV5ysDn5/gOsTIKXX4YFmCzJTIADbZHnNVIpV9LqX3ke6KkoSz6
         /NR30eRp/sDkJWxyBii231tyoRLi2J8jYMVY+InthpmblWrrd7O7qhwZJKVEWGsYL/ur
         Hpd7AGYiXbzHTCBvGmAt5dQOJa8pUXBVSS+aTSqbley2sDC+cqWi5yqdszKzkeQTbL/G
         nUmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771911988; x=1772516788; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QZZSNpgZnRSMnhSuafDyvTsLWBxlKNfCFhKkAaBGl9g=;
        b=Xot9iPaBrjTbNHge3N7NQam92Xk/pw4zIPfqvGR/k70xR3pwUiXpPRi/I2QIyjdY7i
         RLzYcCmU4Ud0GoWcsCMEknQ8puboz3PZVdP7P77MlSFjo7zcnoGw6mQ2ud8Kfqc77cP1
         +saWE5VwVKgqLO1EEuiBT3EaW0vAoyAzmYRpm9DM8i2Tza2zf0wndKyTGBdHkV6wDPQI
         yKTEO+1ALWNRDQdWtj47saFt//0TlFue+5S5hPBersoAH1aeWnL2ChYIqzorKFax8vJv
         mrZhJxf8Y6u5sJwtIPMYkUUURZUMdPMV/izoBbr86STEai9fMHg+0GsVuiTLGmleV1fx
         T2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771911988; x=1772516788;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZZSNpgZnRSMnhSuafDyvTsLWBxlKNfCFhKkAaBGl9g=;
        b=IdAGvGetpju4qeJcTfgRSI8Bxpr+fwOj8qpmkJUNBdFqUQPs/KF6JeWJ+RYyadEvBA
         481dZeqnWB7h7A1upgrOM45gFu48t7XMwFBUaEH+ne2QAq02JVwdmHDh0TOco+4yYMvb
         +YDcwrZsv5kicEqjEA2Gul97Yii9GKfBLAerPbADvqNTPywjJ/QA1clwdEOr7JJ9sJKE
         O5AIBbSYYpBq7qS9a+mN1sQrL83erVoGsnTFz+hY/BgLjf+U+urWKgb/z4SeAosOHJSZ
         iMePtvhRMio2KoF8WpgfN7O6RE9DVDyjDMgYfPysgfeonqO1S7Yw3f5rAykDoa+/1YxW
         5AaQ==
X-Gm-Message-State: AOJu0YwxWFiXQZrg/Dm1L7xJiOj58TG8N+fnMizq6Louv7Vs+JlcF7r/
	pv+jCZEEWekJi0TD0r/3RKncc3KJgLH3J5OgmkmqUGVvALT0OuAmUiisaMuLTdEKe22XkjWumNH
	y5MzcTU+bQRcqVLCdIMiV1TJhBhudwNc3j9+nUuNQF8A=
X-Gm-Gg: AZuq6aIKC1voV/G/nBZSnCfKWCue/3uc9CGf+Y9TghLWK64WDbAG1clNwO4PsjX3P2s
	o827E/O+AGRMOxa9J7wy7LPF9T/pMyQm/p2+3YKlI8XaFcYtnvZRzJkQA2hT6kJmRpxUzKAiXyU
	qtUtu+hcbi61ovdfqc4EYqBijcHeJQErAHj6ETAcKihjxpG+/EVTXnSkfFVlfS8yrqXq/OVWFLW
	N3zSwltthQTjonotI51m0zqg0+LITpwr3fHnx+yl7YNJHFBXbUWPlGk2BW2Vwa3P+Bz5zX9lExN
	WepujFMIBcLa34egVr7VuXJYEKGfxahqF8gFEFUEN76xtB6LMTLzq5GrWxxSZfDU41Dqz34=
X-Received: by 2002:a17:907:86ac:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-b9081955704mr599408066b.9.1771911988182; Mon, 23 Feb 2026
 21:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mansi Maanu <mansimaanu8627@gmail.com>
Date: Mon, 23 Feb 2026 21:46:16 -0800
X-Gm-Features: AaiRm53NpDoYM8_pVfRCKfLzNeD0RpgQB5wf7gIoTywVpeCRUdRdYNdZGCrDFEk
Message-ID: <CAO_P5U2i5aqGWu9woUPS8GWB1VHpHfwNKUBXoTaQg3DSn9YOLA@mail.gmail.com>
Subject: [GSoC] Introduction - Mansi, microproject t7605
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Team,

My name is Mansi. I'm a Master's student in Information Systems at
Northeastern University with 3+ years of software development
experience, most recently at Nokia Solutions and Grant Thornton
building automation tools and AI assistants.
I'm applying for GSoC 2026 and interested in the "Improve the git repo
command" project idea.

As my microproject, I replaced old-style 'test -f' path checks with
test_path_is_file helpers in t/t7605-merge-resolve.sh, found using:
grep -rn "test -[efd]" t/ --include="*.sh"

All 4 tests pass. Patch submitted via GitGitGadget:
https://github.com/gitgitgadget/git/pull/2050

Thanks,
Mansi Singh
GitHub: https://github.com/MansiSingh17
