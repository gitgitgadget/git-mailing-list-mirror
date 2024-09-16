Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E01D554
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499353; cv=none; b=smdp4kQWhj4jTf11SUEETrr6NJv6dRLNigzQids/pn1e/y5oTzY9yd8jac5WjRGxoS4EKz7c0jR9FVVtSib/owjU1X7JoTKW9EAeyF9hnS2tcSTza76Xr44ZwDu4Tkyk6+3SC4rp2BBKexVEr5RGhp7EIEILhYVN36Pvzy2y9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499353; c=relaxed/simple;
	bh=regMov7mt6YV1qC57MPQ/aUlc04LCD/O964uAn97xn4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YcU34rYKv0hULxkreOG0/THmTyg/qZIhMoDuZxgqoL+zMWrOg8g+tGVPpmc18scKCXLvB/HWcrDr4cKaXgVdYKNtgcDRqWNm1Cw6U7VM1HLVb3UHn4mR95E8W5lYdGTYejbSMByozQurb6jqBmDzqD4HCC0bDg6WYidhg5FYTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=precisioninno.com; spf=pass smtp.mailfrom=precisioninno.com; dkim=pass (2048-bit key) header.d=precisioninno.com header.i=@precisioninno.com header.b=c3zfpKZ3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=precisioninno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=precisioninno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=precisioninno.com header.i=@precisioninno.com header.b="c3zfpKZ3"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2da4ea973bdso3795463a91.1
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=precisioninno.com; s=google; t=1726499350; x=1727104150; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2lJwxI5DeGQDhlnHayGXNDCnmg/Rk9OSFfvXIqIOSs=;
        b=c3zfpKZ3WU2odZwG4QwFLfpg6Ej5k63uyv8i/u/dmbCtKIWREzModELd4Ja/tPp5Fv
         z7lqlJtFniwEGtRkBCc5oCULVumoi3nHR88QHrwJMukxvgdrjYahUekbBrTMIjSy/alv
         Ct7BP0k0NQOQJTdaZeapiwczLnwIOMKnCx40QGyjVn7hNMT4+vqmqs3IBsnaCp5Rh+tr
         ij4a+cLZ6CHziUJ86zBBQGOftv2/iL4esqxMtRijSEtr0BZZif/+tnwhfr49VdYR6CLa
         4ICzOSJRzbiZrgcjhNDMd06n/i4PNdB/OVySAUqOc8A0iwh1Bb+opYCXyvtgpLmQioFa
         OzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726499350; x=1727104150;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2lJwxI5DeGQDhlnHayGXNDCnmg/Rk9OSFfvXIqIOSs=;
        b=aRiEkHLMhrA4vUDLe0YhRl3Evko/DCLUz/iOlvvfJtw2tY4sNSHgrKNezsY+yEkxFv
         nqrT3P5mQ1Xv8WrVri9JqWZMh2ua3dqHpMLIEhQQKsonIQ54ogPXAhzOBWf/jCmTloJw
         4Y81QjW/XGTOX37oA19iBKlnJvtZedffk0O14/07kee75LuikEJ775lvkTOINrb/dip7
         LCPguVqNLmlrpJdNiQe3ANRKIOelmB/kyZKBc3jO7K87MNr7aeWzCubb2SQNTe8nwJun
         ToS40AX6Rpr0e3PcWfN+l52GwA1Uend1p9EyayxcqMVAp2sGkjxBuIV7+1QSdmmmuQGT
         BXtw==
X-Gm-Message-State: AOJu0YzDAMJMOq87cBpcqYyj6fGGRZj452HugM9z9ygyvE0IsKhoEBv1
	AHj4xx92BXddR89OG2JLpfquybS9xqo75fgx1moEaokkBjUg/MV4ROUC18VpBtfbKN+KfTeMRPx
	3VpkBrCvHvRcssp10aXOMiNDx1DTcqD9AFFwf0NrQ5l2fh2M2HwU=
X-Google-Smtp-Source: AGHT+IEYk2sIjdp7bCNIys48JN8jZqaER6jOCUznd0LxjlccpIHsXyczi3c7e3QpO6smUX0uXooZeczyp3jM2RO5ASw=
X-Received: by 2002:a17:90a:8c07:b0:2db:ec3c:8a0e with SMTP id
 98e67ed59e1d1-2dbec3cbd39mr3126651a91.35.1726499349788; Mon, 16 Sep 2024
 08:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matt Liberty <mliberty@precisioninno.com>
Date: Mon, 16 Sep 2024 08:08:59 -0700
Message-ID: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
Subject: fatal from submodule status --recursive when used with grep -q
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

I have a repo with submodule, like:

% git submodule status --recursive
+834b7a0fb6de03c8e584256af2ecb7889b568343 tools/OpenROAD (v2.0-15587-g834b7a0fb)
 aafee90f8a21bf7867cef2e159929440cf45b2e5 tools/OpenROAD/src/sta
(v2.2.0-1106-gaafee90)
 ef5389d31526003c2ebd7e6d6d6fe3848a20f0a2
tools/OpenROAD/third-party/abc (remotes/origin/HEAD)
 80ba43d26264738c93900129dc0aab7fab36c53f tools/yosys (yosys-0.44)
 28d955ca97a1c4be3aed4062aec0241a734fac5d tools/yosys/abc (yosys-0.44)

If I try to grep the output I get a fatal error:

% git submodule status --recursive | grep -q "^+"
fatal: failed to recurse into submodule 'tools/OpenROAD'

I didn't expect any output but did want the return status (0).  I'm
guessing git is unhappy that grep -q exits on the first occurrence of
the pattern.  I don't feel fatal is appropriate here.

I can work around this by writing to a tmpfile but would like to see
this addressed.

Thanks!
Matt
