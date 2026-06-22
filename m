Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D70343D9D
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152545; cv=none; b=ETF7swUl29ozqIFDRqiQookzCXqKU+Xh2SsM356zzV7664LSpITyh3PvpCTGuxdDDzGInIZ0/TYuyWnG+B0fH7R6huh+9+/0RI3xIHwAPAZsJXFTzyefFvEpoDe5IX6LiaFEod+hi8+bbXIrZeS7WHzwZOkzu7fHIRaJyMIPMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152545; c=relaxed/simple;
	bh=MI7RzZYHKWOubOWdSuKvXC1vr6Y40hthUHT/UJhO1VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dee71VfRY8xwIO6J6xxapcWdE/nBv3ENcp/8KD+iSeJcwF5YliY/HDlcmfZkDNAubLUfIDY1W9GSXDlTIAjU/rjq41flyYuAntmot/qfWQ8InT+q/O6jsOxY0wg9yQT7lWxYT8PKS80Qg0fVKqGxAp9WkCbB3+FxkpAeCp9b00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYkyjElx; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYkyjElx"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8debb065e01so40897766d6.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782152543; x=1782757343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BS2MKXLYSoefcUP57QToVwcTA4BqvdGhWUNOURdAV/0=;
        b=YYkyjElxgSzNp8iE1oF8Mzc0wxruebo8/XgKvR+ccvEp6jPDiH0WtbtaPtnOtHB9nE
         V/z26KETr+tgYzPrf8FWPC1sHADuWaR57O8sC76+1L0hWHwDLxouI13WuvFP7BHUfoF9
         oCUnsquH1Sia9Dd3mt34R4nLYEmAW82jGypUX5ZSQQvLDWuHy6ZKk8r8MP93bNostnDJ
         eqcW6OxrTWslYgOqyWgn2VlMGByrzw3BLFdG0O0/00hWVTycoynTlAvXDR8Wm4cjGqDX
         G67NEH71z2jp4+IKUe3lOk/0w0tUySNLz/IsE13u4Y4L6gq4zFoNjS+zVFLYwG8430Og
         9Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782152543; x=1782757343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BS2MKXLYSoefcUP57QToVwcTA4BqvdGhWUNOURdAV/0=;
        b=iyMh81fWSDjsUaQdU7GxzxCRNDtxpy3YcphKt673XmIIWQ4wsXzpY4nrISLk6MdrhV
         awgDCvUqG4AuXilt76DkzQDQ+z8i+8LzNSwi5K8+7Vzy5oNAEpB6aWM7l3y/vgBN9Uq6
         dFh5mRdhRIwl+7BZvyk8ugR68/FcBI4c+O6H0MlXde0hpwumVFXhvaYQxhtgIz76VSF6
         nfDb9m9SbixmPYNIWrL+oGf0hwMaWz17PSR2XPFW77ZowUnWciOylnTVAMzE+aFd8IfU
         0o8cp5P/vIDwMvbp5UT1KkLZVhF6ItXFO17h6QZfVp/EmWW7onWAPlYyZlw0EKsF1YXp
         KFGw==
X-Forwarded-Encrypted: i=1; AHgh+RrczAztR70yw5alcgpIJ1Pxo+h9nNuNXDnmLAo/ELS9Ll5ZWtLkG7j59NjYRyynqMhFtf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzeT2Nu0GZVrqc4P/kXG/bA0HK5WrzMabIxR8KPmA3o7QiU7L2
	WzJR6Cgv5lD/lOITFUOGXdjjSf1QxqqxBxrruwbuy6VCgvVW46YyIuOR
X-Gm-Gg: AfdE7cnw6z2hrptpEClmnHQb1u0SgjifAm7j6fcCiObfX6G94b/Jul51878cuwAVRU4
	ZTyD5DY5JkBXdj+OTrQ8Fj73BqHAEri30O9N/EMGZBLqXOdPLhOT2qrRJumZDWn6iGbEJw6XFCy
	2xF5scDYtbeBr/4BOEAjsqW92nXZrSc3cdTzrEXra5F+Tk90dHdmue2y/MCau4DcNI9IeStYG2/
	ZbFpWsdPMyBhA95VoVFjD5KrhcQpVX05DFH1TWao67VJ2vz3Ni9ZnZFd+vn+2dWj3MXs6U0wllV
	aIsp+8AHiH7NdpkyNHVzKiKXzoOefUytuaCfZigYNvqTHuozkgQ9FB6DAcPXWY2zYzKLnLAlKEC
	IBDZJ7XSfC1O4AIr9cbsoAjO82sj1QagsV4zE4MDH/7fGZqKW5okaKD6Nd5I+LmTcetTV5z3vLr
	dNU8Ot/xDppouL11Zg0yYzLDn6VDw7M2Qm7rQ6WJT90sT+3Bkf7oBvRIgw3A==
X-Received: by 2002:a05:6214:1c8b:b0:8bd:6baa:6aab with SMTP id 6a1803df08f44-8dea2b1d4efmr234338646d6.17.1782152543294;
        Mon, 22 Jun 2026 11:22:23 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde319sm102987916d6.31.2026.06.22.11.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 11:22:22 -0700 (PDT)
Message-ID: <a800f1cf-0ba8-49c4-acb2-40b370e33663@gmail.com>
Date: Mon, 22 Jun 2026 14:22:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 0/6] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/2026 6:36 AM, Kristofer Karlsson via GitGitGadget wrote:
> Hi,
> 
> This follows up on my RFC [1] with a concrete proposal. I expect the design
> to still be scrutinized, but that may be easier with actual code to look at.
> 
> I tried to make this easier to review by splitting into atomic patches. The
> first two patches are the meatiest parts, though they are pure refactoring.
> The behavior change is in patch 3 and is in itself quite small. The last
> patch adds technical documentation to support future development.
Thanks for putting this together carefully.

I gave some feedback on the specific code and the patch organization.
Overall, I believe that this implementation is functionally correct
and everything I have to say is about presentation and data gathering.

I look forward to a non-RFC v2.

Thanks,
-Stolee
