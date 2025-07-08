Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8087267B9B
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971951; cv=none; b=bCSzQ+bMizE30Gw+b4yCUKN/sICoiwyAUZ9wd3QEk9ULu4/aJJq37y6fXZE/dFoHYmovaxZZbTWKwoHLfeqb0azU73IxflcByQJ6c8aVlU6d2EaYYF8nqme4jrAS/Q17fBeBqBxnNo2svlV98onghT7sfOLrIOGtnpHTA0pdl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971951; c=relaxed/simple;
	bh=rDbbsiVOb2nRaJ/QW3EAiCKbaO29BEbVxIqSfUFUCNQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qsaDJ+sxns56ng4r61lUtSJ8Ja0n6l8KXHbEvJ1X94/2fXNo1x8WjzPyXORdtmt8hR5ycKYmc4tyOvgUmfAGwY/Q+CN5ZqvkxIxNkKW/7FQDEm02himA/74Xlr17RxddNmMiscomS65lStgGul0jo1BiORtkAcoSb/8sec465OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9+igyR1; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9+igyR1"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so2910192a12.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751971949; x=1752576749; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvTZErGk9WH3iykmTdcUGHIJa4ECoM6it/aAHQg/izk=;
        b=A9+igyR12GYkpYKc7jNu4jlikek7kvAzB0SQ3mpflw723giucfdaapNPqTpeRLctfE
         HvBlAMjM4gmv9Y8SmoRNHWuzS/57os7SvsbdI6c3/VXnzUyDVG0gEAOMGTcFAb7oirTm
         YVKPkCzA4HfWvI0I8544Nc7JkPP9JaU00w1UZyOU8caSQbbtfukukZ75gZ1r7yN3QJ8d
         qX/Y185p5SCu05/oPiLiKcmO+4PPKRgEJtD8ZjvrnYuQ1lim34n2XPM2LxEDG9jz62nC
         /z9CuZ45aP0lH7LXxGGb25S31Xlsv3k2xQvvK9HWyYnBE6a3egz8VDf10UqLUOxkJxA8
         5eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751971949; x=1752576749;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jvTZErGk9WH3iykmTdcUGHIJa4ECoM6it/aAHQg/izk=;
        b=IQd52NginOty6LKq/5s5GymrpCclKgbgxaTJNZ3ePin7Gd9pWWLCmf9fs8t+ef57wW
         U1t2hTmIte1EldoKE49px47kYG1EkoiGHUIuSAHYfSXMhcJ7oWrFXnsaUr4lBtNOBrXs
         yseisZcWUiILyNpCA7OXrvPYV10IzgttjzRixCM3k8U0AYVF8ltColqrVLaKZP2aUZ/D
         gCXSZunoQpGal9lEOjI9+oy1xRcGUQLL8R5c8XrX7YtlRPZ6u4BiW/LPxtARbXlH1JFX
         jK3cq12/+x8e2jgjVX/vKpzkXwPiR8fuWOiwKWo1EtjylxH2bC6S5HznnTyL3pwX1uSI
         2Eyg==
X-Gm-Message-State: AOJu0Yx0qXMc9IQjqyyMRLD3fYHwO2nD2X6suNeN7ekE/5UOKWSyVfFm
	m/z+uY0UlYug01ApQgvztDL04UzzVs+sHXPIXu2MYLZ2faeoKr1CeSPxA0pM1RicXEo=
X-Gm-Gg: ASbGncvXIq4qdJf3uFLdBJNDOJpzDz8vNEqyuX7bRcZoRQ1WwmwKQ8nxDrvFoYlbKxw
	agIfqAF2BWArO2hoLetyjU4VkdHGYBQir9ztLduhsi450ONjl2ApyCDeLqGTgRUi9MUMxkPY2as
	rcqg9StdarmhTWM7BvHQuT5UBikoofmEaP0AsCBJZ/aasf2+OqyGkdPEqD/q95KjljXbzWnrNZk
	kfNLG6OP11TnMjZmjo0kNScX3XON9ho7Djy9zOHJprmCWKSQG/fiIGyZDgP1hxKpoHaJreMLG6H
	vtHwwo4/yhOOMJdGoC++SNmXpM+aChsp/c1/p/GGldOZDMBdAuTFSQJ6SO6upbMY1qN3/Pc=
X-Google-Smtp-Source: AGHT+IE4tYsn0cYhaQvZIR8MhK0Dd3m7Ocw2CG1rwNC0816qZpZitCqJByuiXFdFxzjh6neWR414Rw==
X-Received: by 2002:a05:6a20:72aa:b0:220:81e2:eae4 with SMTP id adf61e73a8af0-22b45d23fafmr3965823637.39.1751971948726;
        Tue, 08 Jul 2025 03:52:28 -0700 (PDT)
Received: from [192.168.1.5] ([103.80.119.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450a61sm11184688a12.8.2025.07.08.03.52.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:52:28 -0700 (PDT)
Message-ID: <3e964e0d-bb90-4074-a9ae-a10fb02b3f50@gmail.com>
Date: Tue, 8 Jul 2025 16:22:23 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Sahil Gautam <printfdebugging@gmail.com>
Subject: locally storing issues/comments/projects
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

hi

i was previously on github but recently moved to gitea  as i want to be 
sure that things won't change over night because some big company thinks 
so, things like addition of an annoying chatbot button everywhere. i now 
feel that the things like issues/projects/comments should be stored in 
separate private branches in git so that one doesn't have to depend on 
the hosting service providers.

i asked it to the gitea devs 
https://github.com/go-gitea/gitea/issues/34993#issuecomment-3048363965 
and they said that most of these operations are database-based. I 
thought what if git supports it inherently, so i write this mail :)

sahil gautam

