Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E126738C
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149558; cv=pass; b=qfIexigbp8ET6p0ppXRoIl7g12nNDoFaalA4dOxCreilAipacIAieWH5H4tySQMEGkBKMVe+IDlmVy9ucQRG8zHeNF4xX7MMZqQll8W3wbQdLlYbnQFrXI2ow6cw3g5rVlXVPol7Cu/Vw/IYvWQOfea+lonkOkOG70j3BBwUZ4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149558; c=relaxed/simple;
	bh=qbaiVgf+FPhg9ry/RsD0C9yh5wWMVw6jOEGioOdbWqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tkm/GVLlZ5bk0zhqeVg76pBc+UuM2yw9VhffpL9rnjYLRK/9mapG6ASwsaaclZIwo2+AONjLMQNweDpERz39urkvOokxT2Vv7woDFW+64aqEJO/jsKypWh/5EAWTq4/gJsemlB/XP+fESI51VjlxToOLQ2+qNxwZc7KIFnOtJxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNxsZ1ar; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNxsZ1ar"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ec58fa3e01so680103a34.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784149556; cv=none;
        d=google.com; s=arc-20260327;
        b=GJXFpFJVk+STxUrVFO7j7Jq7expPQLp10Apjqk8lLHbyJW90RJnCaESioX/tWLvzYB
         YJDrqegjDGUkjrD1HEQ8JwiO2KU0FUg/pkzCmOqRQEpcmu08qHxA0diou2sGcBCLin27
         6pMjRVeevdASXX1OzOq2c/H3wZ3NnB3lvFPjqJ7GSqcAKpEGavto+AvocQXIxZ01p7pQ
         9NUJ8okclFGpLGwHY1bdEa5qVIGX31vYpRdHHcc8wrkHv9t5+K1ILuapmCXbQMfVafo9
         bm96IoW3KgBfTgcEbm2DU9Jr+pvB3nxi8rVRLYjNzv/qTz1Osy14Ld48DOjw3LvkaAsX
         Cslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qbaiVgf+FPhg9ry/RsD0C9yh5wWMVw6jOEGioOdbWqE=;
        fh=3U59T2LJERovslFjo8KYC165koXFV0/zxFfHdLTCzxk=;
        b=qHcAi1EByqUCR3F2xXEJdkRBacmLX10mPC91Hc48UbR+gicwglRkdDK23NPZ7+M3Zt
         fYESlgh/57m3zjuTAWJdrOt/bLDyH/VCERLoL4AgExGtrPjlRiZRqnSOi5Yvmoc046E9
         Xq4EaH9pIR+J5QECulD9MNWMZq6+xNIEmbCfm9GP3WMUzXjlqMA8rwf+BXRfiH1OAyxt
         ApJJQ28n/UiHuZy6+iElGZ8tszMUZYKi/M92hJ4F/kly9gpFyPRKp9nxz88D3o2MF1U+
         ynGDGnGk2mXEV3BNM9jzAeKalqHUOzrGEBQi7vwrI+4x2uFs4F4HnHROit9o378BLDZy
         L0KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149556; x=1784754356; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbaiVgf+FPhg9ry/RsD0C9yh5wWMVw6jOEGioOdbWqE=;
        b=qNxsZ1arfcjWj+jQapECFSrXRQVzfpB34Nqhpnr3ApOh84hnCdPkeONHW4dj9vOmnX
         lgt4xOvHfUTGynog/wwvf8ZcIBqb+O59o97SL25M8qxNv7ic5tXraygE78/iYlZyr+jm
         NemL6XWLBXAqAKnaTTgbPSQEF1ft/2usCPJiwVrKihtxdoS5V/PuDtU7SNxBYPcPJU+1
         g0wpNDVXmitlI+0wPdplqVXa6u6Lrz1nHxmiEzmiI9GtYEd42P9QZbA08TvipscPyH8r
         WIiFnzzTQJ6VO/SoPVNTpwKermV0DFuR3OKtCjhj7GPkTJtruUhtbQRI+RbwgnaSBVSR
         DhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149556; x=1784754356;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qbaiVgf+FPhg9ry/RsD0C9yh5wWMVw6jOEGioOdbWqE=;
        b=Adg4GSLvqDGtOCyyF+0TLzGBju+IA64w2TjKe9rhkmuLC8mWd/l4stm0BQH1o59/7A
         X07IVmSK9+AqKguCugZWWUlmGNumB/Cg07kFle41OFFvrf+n95+aU2lYUhTEyWEdXhxm
         AhtrD7JDkdzVeWOW4YdEew388kvN0GljC79w3hFmQcsIJ8Lge/j5lFk8yTJJWcbPUBOI
         kyY7pxORqqEaTODrbEhknHF/Y3/Q2xvI/M7ZXfWlE+whhcUAhGovduBOhaPgNnLAGaxP
         zjz+atqEgWztJSUqWHC+GjHY7raGpIhL+eG21Lb/Qald7gUEApzpCjoitW+UcrAJo90/
         yGhQ==
X-Gm-Message-State: AOJu0YyTVP0XbO9jBC6clqMRbM95Gj1Qir7FS2feZGbF/DKwT/965HY3
	ZKbumgOviVla5D224orMcokTBrwKoJvjNT2BI6/43bIxcJ85UxEGSRs6NMq82jgFZjE/crbSEgV
	a6nyXjVy2KGY9MDTN613MJDlXCmhfjPFMew==
X-Gm-Gg: AfdE7cmJipnMY6f/MuNcgCjfzLuEh8Uo4rBBKX3PHIWu10TKxbXdIbaVYJKzJyUDZ1s
	1MJzocryfE2zI7JGhpxT24qjWiLoMDy1t2Z1MxS7kp6fJKAZbhRK4IwDg2qw7p8d93taKno/AZX
	0swA06fUQpekiwpkLJ+ggVZ9DYIbZjxchfZh0LnBPTQ8gg/Hsp8O7OGEgolmKF5W884wk+vFcD0
	0+N+CWI5ggCwZL+eio6mBtPliLZbANqy4YCOIWIL0bPmqcvCAMujwCQOLaq6TvbGDrvHDppr8Ug
	ORv0LyS9yyBpKxI9yGf3TlGZnzhEu7Z7dOHzOhiYqKgkRQ55Yr95S/FTEuDMl6iN/ZIPL6Tvas4
	Ern3I
X-Received: by 2002:a05:6820:1c81:b0:6a3:9215:3b75 with SMTP id
 006d021491bc7-6a39a918325mr10961866eaf.66.1784149556061; Wed, 15 Jul 2026
 14:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 15 Jul 2026 14:05:44 -0700
X-Gm-Features: AUfX_mwxGjw7JGZPlLnn9fw_IoyM-A8YfrLn8gH2W14nsQI8r3NzCCxQL7eld10
Message-ID: <CAC2Qwm+MPs9Pyf6q-MAt9U2fQGOxrnHf=dSEhdVZOV6LYX1p7A@mail.gmail.com>
Subject: Re: [PATCH 0/7] line-log: range-scope stat, check, and -G under -L
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Friendly ping.
