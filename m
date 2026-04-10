Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390A3A7585
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833564; cv=none; b=iKFu3BsIh8ojwCLwq43BJ7GWEe/TgwoHk1vvpSH+Dmy8cd3ePJK0xQEetK016Wj60i0BmFRHo5zde1OeoFArwsd1dAUpQZzvwZvAE3ewpHuPinLXC5sV8Gp68C+HlkGtRLpO//lGZo216ASZ7Kms8OE3ubr0haIr0e0xKR0IiuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833564; c=relaxed/simple;
	bh=eYbsrVY/PvttbJ6YcHB/QskPjFDYn2IxX4NvsG+gTno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W19Oo0m0m/Ny6yGKHqzGY54y5b3/3eI6BXWnLcDADKxZaqIUzFiy6KpLovUXpaAbwHNtAMSK9IztxfJMmuJQwwhcwKJnPLHgotro8D10dpdWJbr5Wgc0dPcNJ83zACU+o76z7fJ7l6yxInQRiMxi8YmQ6wmebfHhlHGGF51QLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnBDijgL; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnBDijgL"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89cc68655f8so23873206d6.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833562; x=1776438362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bY7jp9PK1WeWO9ztTMzzDJvck7pJwv7YEjIEba9IANM=;
        b=pnBDijgL0AZ4xkTgxog30jEBqXB5ohzC5PE3BGRq/cBGTJQZU2AraEidKAfer+wdHg
         oGX+JCsdWU+7KZFtcX3md+r0EBkSWSKIbel9HZjd9vsl4UvHlWHvkRVhe6MlJGgAMQ+9
         rpsybYjCK6FAmetMskAIpBy+Hn5sAse4yCoCSzBpjDXwEQGAJr+s5t99rJ/WgGZgG7I5
         6LOHdoofaNhVoU47qR3ksDEwV+aqMsX/armnRkaVNQJZXC0u5Dd62X5bXBWaGK9N4Qba
         j+sFJiudhqi8hdUHZnxr8qB9rW55FlI6Jw6b3kzPrYNjHGuy9F2/AS+7pE/G46GC4tzM
         wr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833562; x=1776438362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bY7jp9PK1WeWO9ztTMzzDJvck7pJwv7YEjIEba9IANM=;
        b=cPi8eBmtVgbFsin2zIKskYucTSeIwFfBCZ/VINWl1EZmhlbiTXP1NzMBtU6exc5CJS
         PJXkbGZn8z6Hslhcs3Nng3g5FXaj9zQ+2O1VX25kpVtI4reNi/pisITDEzQLMsm1jdVL
         s55mYzugH2HRfRb6ppHdcCFBmO1EHKK2Az9UOCtIiG3E501sJ6QG5gppmIwzgi5qRD1w
         3ANBSI6j9V+B2jx6M0CJtw1DmOEVB1siIZ+n9M8xvTTOZ2IG5N8mxMn84IRC3cyg9oIh
         WdRkR55nXzGAJNLwae1JJdmWGR+lKAvjYDotY+wtUuPZm5TtuAkA18iHNHAjLHou3+Rp
         7gVA==
X-Forwarded-Encrypted: i=1; AJvYcCVzBVESTeSf6PK5CSYI34nMVX2xIIac7iuQXU1Ff1Nsyb783g1zmoOKAytDLUpvBG7We08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0moTzw8og6YDfGHilbL2UEMnhWrkI7Oj/zHbX6ElgukxwjZ58
	yapRYJP2yNiv9eeu+jtmdeY9Cb1oCv2Q84r+uT9FaFQXFtWjxPIcCtaP
X-Gm-Gg: AeBDieuGmpoPvS5NjK4V8TcdFSMrYwZLDLMCURZDXDP0QwvQoVSGUimOXgGCvXlm+dC
	zBm7VKQyLq6ST8ux8jJDd9k6fbpVBizr+cHFiugTbfBJpcUwhzWoQTSu35XcIgtUI6PlTOuGOt0
	mZpZGqrT3y2uAV8tQDgazwaG8aKmaYCnZnz8ct7YG9hSDt2a9mWkQL3l/id1h0d/I+Y8DolfJXD
	scTkbOlbIHHjsSF7EEOkmpXzD6HWVbxr7vhXvikRKNq7ywH4mqd11UGoRR+vQs/xv+xR/8W4lyK
	+yFCeu5t/XtR69Jou9qSLn7asEXFeKM2239YGdm8GWbiCPnGcsu3iXoY4/OtGH4dCEHiAuFRK67
	O9NStOXb0IUrEh8ZOhAkvauGA7NfrgqjVCfzyit7hZ68niILJ8mIgAnXP8v9hbAjUKdOpGoG47j
	y2ZtNEAjkampriVdisQd7rCaR0S5XVm+IdOR2ByGAH7tGIRJvCcjJdQGyMCzTtunZsgmdK2A==
X-Received: by 2002:a0c:be86:0:b0:8ac:9314:a725 with SMTP id 6a1803df08f44-8ac9314a7d2mr110326d6.3.1775833562039;
        Fri, 10 Apr 2026 08:06:02 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849e2891sm32987926d6.5.2026.04.10.08.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 08:06:01 -0700 (PDT)
Message-ID: <6eb384e6-7134-4f99-a6b6-e8608ccc9dca@gmail.com>
Date: Fri, 10 Apr 2026 11:06:00 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Enable Rust by default
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/2026 6:44 PM, brian m. carlson wrote:
> Our breaking changes document said that we would enable Rust support by
> default in Git 2.53, while still leaving the ability for it to be
> disabled.  Unfortunately, we forgot to do that and my time machine is
> broken right now, so this series sets it up for Git 2.54.
The discussion about how to handle the 2.54.0/2.55.0 release details
seems to have concluded, so I went to review the series more carefully.

If we take Junio's patch instead of this series's patch 1, then patches
2-4 look good.

I had some initial confusion about patch 4's references to Rust being
"optional" and it helps to know that there is a mechanism to _opt out_
of Rust builds. So the real conclusion is that we're moving from an
opt-in system to an opt-out system. This is a nice way to make progress
relatively safely.

Thanks,
-Stolee

