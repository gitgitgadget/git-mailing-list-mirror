Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330E2D7DC1
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810651; cv=none; b=s6rX1AGcMzpIwj+m3cTiSokD7+u6lRSt3xOYvo5ZTe1N3zVv2SnWH+yNFTkAGN4q5exip2kvZduFghzJYqiUFb61p0pnMUVfPdB86gL12PTwzHdEp8d6ZwgxSZOjSJswPvTH5GlDETXyuRMLw9y43EoMaqAY7K3RIK4xkuolbNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810651; c=relaxed/simple;
	bh=eNtrr+WATQlieZ1i6Qg3g8yt/WGQj7mSBI3/qRi4n1k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=oK80InykaLZHZSMBRg9jEYZdfQAsA9l57WflFljzlbsKeU+Nhbzmbs1W1WK+fcrf8ZKVJyy0VT8Xvl9hSfqfI+jWYJWHuQnyimqoBQwezX9kbQ0x9SX8oRn4P4Y1iYBe6OC1QIGf6uxaPmQoLSw9UH4cntpVN0WM7o335ZU/5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geoFPHpm; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geoFPHpm"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-858183680b4so130209385a.2
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758810648; x=1759415448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EjYrMT0bdzOcVyLET65QjkiCQu6e4yTIe/lNZZIink=;
        b=geoFPHpmoox0xo9/GnRCcxgOVYMvAN9W7f6hytu4f6d0mdfkcsk6KJoq/EUx/NkVZ2
         ywOe/O2ZnqWrj3XWOwwM7C3GfApnVN9CFt2DO7DPXIKc9MTmyFalwVnOPc7jeHFTaRfF
         1YBu2H9UtAkE8krMu2tDAMBWB6PlQrqWWbWIs0F6K2TB7JCxJIvlw2NgYq5yiEu7vNKl
         sQI13hi51J0fVVaNggmb+4tT/1BHNE1+0BhRdKRBMLMlkHv7A4dQGfZrGt40EUd1qSGt
         IHsrS+VUIqjovCakJR/tqPnC1bVoN5hVVg15xlpE7iaKGqfKE+5TUXVt9okUE61qXEC7
         BkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810648; x=1759415448;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EjYrMT0bdzOcVyLET65QjkiCQu6e4yTIe/lNZZIink=;
        b=xAMVEn7qcCQojYT4gbXM96xdnJgONh237biiPDQKs3uIqcoY4MOknbkiieEhvorLRu
         gYDucM5QjFXZ822Gflqxh4mJkPKo2IrZK6Jd9Nbsk46F/u9IRco0VLQm4SEZR9aoqC06
         ohlUVkI4EECSr29ng1oqeehR7O97ArqO+p9XbpqEhzPzZYwRgdU2KLAMgmHFQJpUFspN
         qBW2hhrtFUynpiG9NlPWLLhsj+BrH51aC2WO1GAlhq/zKdq6ExUUGU+lzs9buuPgtwjx
         IbrrKN9ObRiJuuUIW3c0ILy2Sa+WldvkBgV/1URyfraY8zy5dEnEo3oIIGi/jBEBAXAw
         5YMg==
X-Gm-Message-State: AOJu0YwRw6IQqaOoCmQKoKHOSS3Sd5Ut4eGCen2lAhi/c7BUKOF1863G
	EkNG03Q1R8kMu0XXhINLsTfNFgbattwvewK4WbMgg3hmoiSE1SHzcAcXWNskzQ==
X-Gm-Gg: ASbGncsW1ya93PeGY9mSh08m0Bo68shHWinTJU8/DTu8FnlPDK4MTOIPbVJpFqf/JJo
	LaJs9tLuXCDraUKHZM5RhWns9GYOIV2YOCxuBcstFmcs6hEPvTBIK+0eFSSqlElywZGav3o01iJ
	DbPfahA9gWyhouIFmXAffIL/RbHstae3c2iAhPFZNMqVjQyGdD+GyqOPzrTVo92pp2aRZiEXM6b
	AX3AEx+9fZ+Wbq+pv4CjstqT5jvcRQUpX94J/v14XcsI5TC3jRaxelbHLCYp61ARvJPkY3CpXXO
	tQG288ZBZYfmURDvPqME25yRi5XLHvDThq5PfelE1ctbFRgwPZZEAm4Zf22Jlbv4PggKP3okXIM
	rGMNQrXOErfsAZJJ5jtaEwG9hAWoAlx/KdP0JEbIThLoq
X-Google-Smtp-Source: AGHT+IGlGet1vTjjii7Gq3yPRDzFNzui8jjKw2rB44IVTFVOzWbsjWaBP57orJ6T3E10gmJgmJURjQ==
X-Received: by 2002:a05:620a:4444:b0:85e:429b:b5c9 with SMTP id af79cd13be357-85e429bb819mr156910185a.83.1758810646984;
        Thu, 25 Sep 2025 07:30:46 -0700 (PDT)
Received: from [192.168.1.174] ([71.192.65.134])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c29ae247fsm117865485a.30.2025.09.25.07.30.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:30:46 -0700 (PDT)
From: Nikolay Shustov <nikolay.shustov@gmail.com>
X-Google-Original-From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
Message-ID: <0905d418-7693-485e-8646-a7e4413e6c0b@gmail.com>
Date: Thu, 25 Sep 2025 10:30:45 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Nikolay.Shustov@gmail.com
Subject: Re: git merge --no-ff failure
To: git@vger.kernel.org
References: <5cbb5c0a-4c51-4d15-816d-6d7d4fdf4fe1@gmail.com>
Content-Language: en-US
In-Reply-To: <5cbb5c0a-4c51-4d15-816d-6d7d4fdf4fe1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Just wanted to add to the initial bug report: the same scenario works on 
Linux fine (when git p4 repo is hosted on Linux).

On 9/25/25 09:31, Nikolay Shustov wrote:
> Hi,
> Git is reporting error while I am trying to run "git merge --no-ff <my 
> branch>":
>
> fatal: stash failed.
>
> Please see attached the bug report, the output for same command with 
> trace2 enabled and output for the same command with trace2 and events 
> enabled.
>
> Cheers,
> - Nikolay
