Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D212BD5BB
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751578215; cv=none; b=BqOR9mhxgFp/kX1HH9LOtbuYg/QgJAwSN4p6beviRFep0h9+wBbKPIUz3G/Eq3JqZ+bKIoUq+BFytYNdTxhUKrlvV0guwKEC7km0BLQ6nXuS0CwFebBvqYuwR038hCBwFp8bWhbglEDDGIufkO5M0zIZnmO32mU4INWgYM1ZD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751578215; c=relaxed/simple;
	bh=EujLNqW/yhNndwlFsWseeDyumsGNicFPrGveMHciL1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftb97vAkDEEMtLEalu+H5kp3reL0PlMvTtZuWtiQyAYAvE7XHKEKSUWzXQmBIwko/9MAhujSPta/hgpLKYgLrE1XzvQgyBLba/r4a/Hi6SeS7De1ZwayhxObbMoaqIkKw4OHhneZx4fcebjulpkZNr1+AzFInBYv10kPdHVcxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ulk5zAHP; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulk5zAHP"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3df2df6a25aso1552485ab.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 14:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751578212; x=1752183012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EujLNqW/yhNndwlFsWseeDyumsGNicFPrGveMHciL1g=;
        b=Ulk5zAHPVRC+QR9i3M3Qs3B5TFwpVUX3xTFux6lmZhyQT8u4889SYl9MJ4CDheQGZL
         ZGAeM2+iOoxP1S+fIJun0AduW598n3OSy7jOnoGmvU3MmJC1D4aKkgIkvJWAh1Wedpip
         2mKoAFZbmCvbGiKB9yICYukx5VbBfIhEijdp8OKBhcf6xBCI6RYgnzlNGm6LqwzCfIj+
         8I4muk4PyX8u42Yac2H25S+bRcdQFB+H+2I7LN5uMMxYv2IoHCQ8CbqknN4hra9iU/Jl
         /p4+qnlcfWn0ezAPOnh3OpvrqCSgXEVJRQLV3IdloIaHX0LwrS5cNlL/TzGdyIlfeAmx
         ri1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751578212; x=1752183012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EujLNqW/yhNndwlFsWseeDyumsGNicFPrGveMHciL1g=;
        b=gXVXgI8qdLH7M0DCKK23uT/qlq5qr3VaWsZzA+NPk5u115lnhc+MbNZlX0ZcK7Y9Up
         Fkws5kmv9hdc0qBqc7EIr8F2APnwpgtbKLy3K/gY4K1qVZ5J4ry/WeiMzXZIvPr7I9uP
         6xHz0jLfpdHbYDVOWwPu6rNu6g6YUfjP9XzIrkQ6FFqPwM7eUpVerQsB8nzsxfVvBTY1
         kNGiJot29+6ocLQygd2YlsO16j1HD4ekz4uT3/w5Eb6Xgyevrt3cAQIKcUoPoNMy2Xao
         EtHiiwPrJYsQYAzhMXYsxgprFFPgAVajknEUaeix9FMGtY05AdMCz2KSRTmODcYjBMg8
         uvIQ==
X-Gm-Message-State: AOJu0YwrESl3GxgYLnDdZUPAdOuhLgN+WUGGD2IpLmCB0JAdZdDN7zAj
	GN+XDndRS58x6qMdpIreHatnTHG+RlACJ0U5DQ6nE1kyN9aSGvtQiOZx
X-Gm-Gg: ASbGncslq0caZH88hmXZPCkZL3DrfEvkizE/ITswR2kLOCODXJRoJioNZlYig4I+Lrd
	Q0yTZClzJ/aMPPAgfqlZJKHaaW+CtHz62Os/O8gaUm/Yae94VHOa/yOetq9ey3n2JEKfZ9hbZOQ
	XysivW1LONdTdodUttj/fxJi0huCKUW0DWg4RCp0y3dUc1orv8SyzuPXg9I4VHeY1v8J+PLidwm
	udy0RuFyc50R/mcKE9r8pzUoKDDLOFwTTd9dgaHZBM1L8M3pUWIovPWq/mz47zCoyUGqqFFU2zQ
	06b3vYmi/xSfPrGIKdMPQUHbjjrAGnJ44fPZQU51XlRQ8OwfAIFT6B5q5OhAcQj3XiMZDEsRI73
	VkWiSTI418Nv3brjTIIvSApF6jxFydoJrWjiO9HQ=
X-Google-Smtp-Source: AGHT+IGduMVdTEQ4pWxjq4Jtfwjnq7ra/jp9Kkwz/nHouhKdoioep8EwkhFb8kQTHIILyQVh40YPsg==
X-Received: by 2002:a05:6e02:1527:b0:3df:5354:a804 with SMTP id e9e14a558f8ab-3e1355a819fmr901135ab.18.1751578212519;
        Thu, 03 Jul 2025 14:30:12 -0700 (PDT)
Received: from [192.168.1.105] (c-73-176-204-61.hsd1.il.comcast.net. [73.176.204.61])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b59c92e0sm137962173.48.2025.07.03.14.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 14:30:11 -0700 (PDT)
Message-ID: <dea87c81-c2a4-4dad-b73b-bdd11d4c6877@gmail.com>
Date: Thu, 3 Jul 2025 16:30:11 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re Behavior of git log --diff-filter=d
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
References: <64308d3f-281b-49a3-bc10-57878903bf4c@gmail.com>
 <20250703134220.31638-1-jayatheerthkulkarni2005@gmail.com>
Content-Language: en-US
From: Eric Salem <ericsalem@gmail.com>
In-Reply-To: <20250703134220.31638-1-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you, Jayatheerth. That was very helpful. Now it makes sense why
Git is behaving like this. If I use --dirstat=<param> and then filter
out the blank lines, I get the output I want.

Thanks again for your help.

Eric
