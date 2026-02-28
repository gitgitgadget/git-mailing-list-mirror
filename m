Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9FB175A83
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772312024; cv=pass; b=dENNQuEYjEDb9ARXgxhbs3xWYAmn1E1/M1a5IOC9D5k3UZ0IAG7wpJgP1v20ELYhIBE/N337fKLdB3jSxibZXFkeLycw2bDi0NLl493dRTatAaXJLy7qMEgqw4KY4vPo4JHMoBocg25JfVBEEPTdc451qGMm6hryvTDI8qbBXPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772312024; c=relaxed/simple;
	bh=/Pt7GJlUsuqNls5juqjLBTrMuQWNSJGFlOs0uecptf0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TqABmtMx+bCHzq0CfQzJ0wmpOywhm3DQKgwmk86L5deRGV9gzWpgE+zBooWzg8nwwdNOmIXqxzFRxuIGtG9cZDeAUYG+8sJdTyuwGdlDdis59pVX5/QZVbEX8wUZJjlFb1GJdnpcBOwMhp2YVre2L8nkrUpSOl4iWY0AOIeSybQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBz3GlSx; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBz3GlSx"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ade574f05eso22021595ad.3
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 12:53:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772312022; cv=none;
        d=google.com; s=arc-20240605;
        b=GF9al5/rs0iuGs5wBhZxZUKQZscaMgZt0DGAJS/P3EYpdaktlT5bs0PRE17KUYCZo+
         HV7lUqtz9Lw+/cbPYIP0OubJd7tL2aYHiR9DVGb5SxOFoqnslSvIAS9TDjPXyBwAJWZw
         xgGdVEwPyPg7UwVuNJfgjlW6vmPjuamByoOyVWKYc9ZH9862XNg0rOkXxIFYGo5l++6E
         N5iDrRcPSCL13uVPNhQ/CGiZW7LIIBTwSudKr0EDtBdHcSaPhV1LNgBOdjWMf/hguwq2
         wI314PAD2VQr0j0EXBn3a1uPsH8byWFSvdafmcHhKDy+QjB/l/uUU+LpJUZcBiARjALY
         F3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LrTTqf52Ql4Z3/FbsxtlXZ1iuYOguyi6iaY6Ns96V0M=;
        fh=WfJB1YkHjfxkSMCsogHMbYc3pvCTmQRpLXh1eGJSZoM=;
        b=h1dA3/GQcNGkYMenOR4AMDOB6p1LB8EqCoslKmof+dZBmlNAghnDuU53Io3FRSGwQc
         WxBVlWLx1T3XrWOj06MBKuekHwl6JbfXkscRsKWRo4hMjYhERJggiOxATaofsJYUliYW
         Bag+xMYpSEmOeJouoWrtNUJgX+y96JN4L/hULZKhquVBTeFyAxOtlJHt34IQOGHjySJ6
         GVr4Fx3J+YVDYRmqmk2OIfldsznSd9CVnD3QJ2Ciz1sJqX8ZNQQ3NLGUmPCGb6KjEcot
         WzV0oXa/9NnMh2xXloU9DJVhBLb3wOjkyfZF5PuuZBnk9fnfZQmYR0GTizr0ty4QBMwY
         QlWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772312022; x=1772916822; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LrTTqf52Ql4Z3/FbsxtlXZ1iuYOguyi6iaY6Ns96V0M=;
        b=UBz3GlSxsMn6s4dwae+6absm25/mLOEE+yP/edFdoMu+K0AJNMCIF+ZH1d0hDCBwGM
         NXJMRRu9LB5dvXgAMH9JtSnIjOCohqSwkhIwLLebID13AMumURCUdjkAEEqnRNCI/dMw
         ZOAt7VX1YjtdBRb6jVhBXZBySIRFQE/lsiHVmckN9/JPhju24xnGsG6RsmGxHfjhYmWL
         qf0qfvoppA+dljtc6I/huRCea7jubeZ9YIP7DJA2NdUDp4j7+0gQqRl3YdE2rt1g1iXV
         R+MWHCimx0YrRMbTpuRZRTzwx2PUonLlKFOh7SWholphp+CMlM5ERE3rZM/l8trPXb7h
         qaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772312022; x=1772916822;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrTTqf52Ql4Z3/FbsxtlXZ1iuYOguyi6iaY6Ns96V0M=;
        b=kl/wg0VEYOaifj3ZJdo3bgaSTxZGy1TV8bD2lYh6aHz1cpaVOOX7r3wEOeZTI3TOOu
         V+FOUWunNUgIbcD9hRG5cPgDCtWPJH6VnvHT9x8qeaXOiTNibQkPZrXu5F+z+hKIr8CH
         tP0tKLxFDYVQTTyxr3uOloiV6123ZtwQtfbggve4a2wh4rHyRRw5L5hMwLULNBMwY4we
         fUhZ4VLjqG+qhajAx6rZz3Tn0YX4Kk3U8n6o4WKeDJpeNqJT0X0E0VjZaStVlpul3NgU
         +z7fd0bywObkQDfeEYI23goDAwZtCE8DWnpJaUUXM3+LMJ2jwkDLy6qYwR6e9MEuar4G
         W4uA==
X-Gm-Message-State: AOJu0YzksC1Bv9MRHKkS/TpBMF7fnbmSKDYhc3bhxxoLdfUInCQsCpWW
	QC8yyxnEzrhj90NTiVqel/z7IwVJIFMxITO9mRTYP9farYB9ziB+R5XEGwctbGmx6nPnUw828tR
	wQSZYnAPM5Jx1E7lXktA1peCYaoXPt/rJrw==
X-Gm-Gg: ATEYQzzltyZJBoTB/1fQRHdm+b2GnvOx8zF5bEY4KHaMQSoQt66cnLoXnlfkTQ1DmBU
	Tzovep6/b2R22q+CzSqgC0X8wBvq7ipTZuhjm9Hyoje2BU0QO6GR5pwTxFckcu/DT2bqnnMkH1G
	Uv8OBSPIBc9fYr8imnGUrNP4ql4BP/paMXYUuAAeRZs5hogbwLQKKtKVS4FTY0h6yEDLTEkX6Pg
	H4mB47Y0b8coV3PmcSEpxkjE+2su7tjj5Wv1LWmWFWMesdQir+r9GOuDx78QbspYwIkrATXVT2Y
	huF+jedznUl2uNgGZmluGYghDIcoyXrAHI+czHiURNHK0CDrv0cBd2Zvp5v/qd6go0eKgVxDafB
	81f5Vs55ymKIhT3XkbGdxrJBMgbQKFrdNx9Mr3A==
X-Received: by 2002:a17:902:f551:b0:2aa:d29f:1441 with SMTP id
 d9443c01a7336-2ae2e3e0da6mr70095325ad.2.1772312022328; Sat, 28 Feb 2026
 12:53:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 28 Feb 2026 15:53:31 -0500
X-Gm-Features: AaiRm53pVtCDg4zINplZNfpGEZJkb5Z_DnCdyYRTckuQkVbXxxHNkgAvxzyyNYk
Message-ID: <CALnO6CBKGh=izxL2zZ-3Arsmja=Ttm1DBJf3_attLCez=57OVw@mail.gmail.com>
Subject: submodule.recurse, fetch.recurseSubmodules = on-demand
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I have just noticed that the order of these options in the config
matters (latest wins), even though they seem slightly separate to me.

Going just by the documentation, I would expect "submodule.recurse =
true" coupled with "fetch.recurseSubmodules = on-demand" of the other
options to imply --recurse-submodules=on-demand; today, you can get
the equivalent of "--recurse-submodules=true" depending on how you
order these options in your config files.

This appears to also affect push.recurseSubmodules, since the code is similar.

The code, of course, just writes the same internal config variable
when it sees either option; see builtin/fetch.c:git_fetch_config and
builtin/push.c:git_push_config.

So I suppose I should ask: was this intentional? I didn't see much
discussion on the mailing list thread for v2, v3 of the series that
introduced submodule.recurse.

Would we consider it a breaking change (therefore a no-no?) to adjust
option parsing for these 2 that the more-specific values can win? Or
should we document somewhere (?) that the order matters?

-- 
D. Ben Knoble
