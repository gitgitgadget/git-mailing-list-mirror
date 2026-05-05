Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD536215A
	for <git@vger.kernel.org>; Tue,  5 May 2026 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018837; cv=none; b=rmt0cvWTTZwATCeF+igf6BXqa78RFonam8DFQF54y6yXegQgdnJYiMtA0QbNoqeJBAIoDIFt7bF4dFmlnmAxIFdemlYhY/8+6PPXtYUTVHWdoPo9t9cW1dq6OuatqTXqxBKxr44UcV/1xucz3h7LYsDw7fjhYex0JItEfD4bCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018837; c=relaxed/simple;
	bh=KbFX8qwIE8I8Dy4b5C4P7/1lt5OBtBh1DqHuv3khbVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3aOuoClVZQrBGkiW+qu7H2y6V9uDMY+m/hpnq7Aancqi8hFExGkYPVbWXZcZzPzALzcY5hCpT+5hicyQOUMEy5OxIDsJG8lxZ4hZ786WWcwJW4zzqU9am0qsR//3+78Ch+G0te8tHQY87oe8dtYijtl8pkLEzCuWVRprk22dhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJIoTc77; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJIoTc77"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3938d17d6c5so30361831fa.1
        for <git@vger.kernel.org>; Tue, 05 May 2026 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778018835; x=1778623635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbFX8qwIE8I8Dy4b5C4P7/1lt5OBtBh1DqHuv3khbVI=;
        b=rJIoTc77Vjz2EBtF3TmkPNxdWStyBYZLExCe+xpETNJ7tk6jlPaqBj1dQKrlbRME5S
         cYXEyCQ9y9giDFcYh1brx6F7WtH7F4blPLkoh7A+t0mv0qx5RvGDzBcdmvKBySHyOYj7
         Lu3LeT69eMo7gI3HOSRTnuwUA7ohkAqa1O6lnAGxtgcb+yUCt1xGZCFmQJnD9odPalnq
         /1UwklothPUMuwLDi40Cmjhr3JR2XrXJvn7wigroDSMSTYWCaQ+tDLJ2Fzcu2FenGj9e
         QpRrrhTPYgrit3wshJ1aosY3jwSo9yjP9fqlouo5MbiY91AMq3/uDTx1DhDuLphNOnm4
         YcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018835; x=1778623635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KbFX8qwIE8I8Dy4b5C4P7/1lt5OBtBh1DqHuv3khbVI=;
        b=I1O8TCmIXdhqaIKW2kA/JAnr+dq+WnR5mLd/1zfeHMs/JriOTaW+6MioL+U8rmawND
         uk8QfPnMCowOXPk4Ct6wv5taSaoo8U8bY/cXYlAA/tOzL5TmkGStkcZHm4kWq+d6L98z
         0ZvvtALuTJ9Jg09sA56o3PURVKRNEJJ+Q8wtmQhiDZeDSrStimxsvmFkUjxXi76pHwBM
         buzThfzXSgV4/fiUKl8MFbxF3jV0v+Go8QUsNSCWjOQ73adK2szIeosYTmKh1DH5ZmQa
         1DHHk1w0UpmTNahatO9Qo6DK5diDZACQyf4yZeJBu7YPllTq7JmENXsXfahEaTAso4JE
         4Mlg==
X-Gm-Message-State: AOJu0Yxx2cJaAASbFlK76z2Yl6Lgze+S/H8el3f1yZzjn7SWFitpjwfG
	abnwKiNLy8ePeD6iYQ8XVxW57HSgX+CJCbiIJo1CBJc4T4g2k6JKxqyA
X-Gm-Gg: AeBDieuZ2cZZs+6yO8GWox4N6BqttBMe31+w5Y45BgvQo61GEQ02KPV1do20fXZI7px
	2l45lVwmCOtx23q8AlCsqy+xR0cVzEHcX3V6Qjq1h4/MIEgExjdxY6txSVDPCs9bdedQH2WGsfG
	j2gN7bWNzxMlMB3tTVWVMolFfSU7cYwkxr7nDXH9EwxfJNqrtpzS2CVgtXTNvFPktDV7/1dMTFV
	8Df4PAzrv098jb0SMJqy6yiQXUOMYjAx7IvNJf5tnm8GcbA2xVVhIkOdWezufxZuk37BxISkRKQ
	5kwhq1Cwc1sCSqsxYuKjyb3FNNnjN+d+MwjMRbcXZkTVbNCSBJmkL9jDS9c/nUDqHSJnbYmSJ6M
	GeqkFd/TPsaxQke8yaORvELCIOBXd1jUbUNPxybJrQPtoE6YIlCDmf+hUAbCKchYMZhKDs7kxBY
	TCqERtNa3h+Hf8F32DSFOONm3DRi5Anu88xbGSrWduyd+iV/1KpfVU7+O64P8ptYVkrqpxt/IgY
	tnNkNjATPo5p+KP+yRE/yXGvDs=
X-Received: by 2002:a05:6512:3f10:b0:5a7:49ed:18a5 with SMTP id 2adb3069b0e04-5a887ce62f1mr188692e87.31.1778018834321;
        Tue, 05 May 2026 15:07:14 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a878dd151dsm1563774e87.35.2026.05.05.15.07.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 May 2026 15:07:13 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: j6t@kdbg.org
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	kristofferhaugsbakk@fastmail.com
Subject: [PATCH] fetch: add fetch.pruneLocalBranches config
Date: Wed,  6 May 2026 00:07:12 +0200
Message-ID: <20260505220712.93952-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.6.g690242d89b
In-Reply-To: <1e38fb35-f75d-4067-856e-b5c15f507007@kdbg.org>
References: <1e38fb35-f75d-4067-856e-b5c15f507007@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I have some sympathy for the desire to clean up unnecessary local
> branches, but I don't like the concept that `git fetch` modifies local
> branches, not even as an opt-in. Deleting local branches should be `git
> branch`'s task exclusively (at the porcelain level).

Yeah, maybe that's a good point.


Harald
