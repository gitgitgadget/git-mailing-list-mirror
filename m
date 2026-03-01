Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543221D3E4
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390956; cv=none; b=qYCk4y7HhD4XHizkxfLUQAm9XoSqyNFh6H493XgpYU4SR9mGKdHVGIJK2UEvMc4RvnugpxAe0bwBEDsGXZKHuYKVWPnROZ13hRK04xEvt6h61avGsN76p1IsF6c9iFHnfloBPJqnFIwnQ9L2KZ8an084lqf+jYlEvBnL9g9lWKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390956; c=relaxed/simple;
	bh=RL3kx+MWa3D+lYsBa2Nlqty5sAjFN+psuWxjJ4yFACY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NPygshi9Gn/aZLrJgc1Qbkj0X8d4JVrbQ5gDMJIKDvq8op4dh5IUh8MIma3oMln/kgmaxh01kfcU5V3huOMPPxaqU3o1aCdmXyaHvyHzRLozm87QvXM5IdvhOUW8h/tSAvH8Mpwggv1lWPUrXlCJbYMcGN/1UcA/W96BYofcGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgoDPIE6; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgoDPIE6"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94dd2d71231so1040682241.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 10:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772390954; x=1772995754; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah+sbSpQergjignXsPiI0l4njf9bL/EoJ4rMbzlUpaw=;
        b=IgoDPIE6sVJwR1f/VL7/n/0XuuDeo72I78si4PiwhuqOVkwPuTqAcUHbRpW4JbJAaa
         WHNc4BMmBC1C4cSWDbVloumcUA25j1aoMt5PrLyH2pEJA4wp7R8vzLfgI6ex1ClTBnv+
         RdVOgBrcpyPBnU/48hQ3qbfmXtECl8GJyeIKW5HGFmdVedfX/UsmCGCmOT8fnIGiiE5a
         bA0xyws7nRBrkk1paQnuQCVOI2m+oSKcWY7cUIdPeI+rgzRrOFhbSIphJG1ytywSiGt2
         VaH/YDORRkf4LRhZp5iWqoGhlhIEjPBRD5r6n537xen4Yc03CM9VxDAOD8CF9Twg55qx
         jXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772390954; x=1772995754;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ah+sbSpQergjignXsPiI0l4njf9bL/EoJ4rMbzlUpaw=;
        b=tjZQSj/aHHWMUhDlMfomIFXqnAczVxZlY2Bn7+DVTrCGPs2x46GyVimzn+0xwGylfu
         TOOoKQYpm3UAY9zObRo43lgmAzl6N+ib+Lqgyxa84DcruFtlfWJqIubsv1K9v66iNVT2
         5pP/LLosM9sUXBw8rLxnJVX9v9K8mjo/0YMGOZRrDAcgEQxvRZ1Dg17n7rdKcvMIesHX
         CtTU2IT5EU1o/TlEH4oba0I+491T7pU2uE9tZKt0QiZ0IjdHg/NAeO9iNhV9Ug45FoHd
         IC7AHLHp+mBDBVmSmOFOhIaYoYO9CxXKbgAt5WodtxZbR+xhEEQaLXOJbIQ97vmBY9xH
         janA==
X-Gm-Message-State: AOJu0YxeVlqewic8WL9WqZsNumVVl9TTqKHAAapEdiOrL8WGwhG+iSCs
	8O7mXrdSJiEUS3akd9yfxjA7keZsS3uEjI/QXrO1bqJHC9wTjEh15ozuIQDDLUzX
X-Gm-Gg: ATEYQzzbLGdQ2TBCGO+Cdd5ViF9/zmqLIPFJW/e+8XqpPeTeElATJpLBq36KsGmHmy9
	mo8iZMut1jHgV2WVW5NPdK83jlqFbLiLIG+iUKxgSsc3Z6BJk14ZKsj7qFDppEr9EzI+pn045lR
	YPWaKJCzr9nRSCaiixSOUkPQ/lYU6ErMeKxc9aT8da6eTBLera+DcvMAfSKIK8jrr7e9S5SWG/t
	8d4fHfBZ+S87/D34uP5NIRksfP0P7Rm87qtbfX/OYyrn4ruY9Ac6Izg0wt9ChGPMyCQ4czOm+Fc
	RbdKRjDaqFMT3RrsVzeVR9mP/POqBNK+2pp6I5aga3hwWlxXIyVN539uZqJN5r1qgBjQGH0Qt0d
	1GgUEQ2ozZaBtmCLN16FLDfneWIrcWHNGGyZ1emnZT+lRph4xCVhTYyRSU6BLmdHwIvTxBZBEAB
	iMGNE98LuA+BEE27Hjd7kfZIc4iMSsYrfZpuU0c4zP3VC54VZryrDdTzs+pepK
X-Received: by 2002:a05:6102:1610:b0:5f5:3244:210 with SMTP id ada2fe7eead31-5ff3256ed48mr4087818137.35.1772390953882;
        Sun, 01 Mar 2026 10:49:13 -0800 (PST)
Received: from smtpclient.apple ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df6577693sm10001096241.9.2026.03.01.10.49.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2026 10:49:12 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 0/2] repo info: add path.git-dir and path.common-dir
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
Date: Sun, 1 Mar 2026 15:48:58 -0300
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 karthiknayak@gmail.com,
 peff@peff.net,
 jtobler@github.com,
 patrick@pks.im
Content-Transfer-Encoding: 7bit
Message-Id: <8D232FDA-E286-48E7-8E41-ADC6645A9BC0@gmail.com>
References: <CALE2CrTt_2-9C4zCrZPBabtsWY=+Mk-bH4Jaemk=yHtfpoLjfg@mail.gmail.com>
 <20260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> Hi,

Hi!

> Following the earlier RFC discussion about exposing repository
> paths via `git repo info`, this series adds two new fields:
> 
>  - path.git-dir
>  - path.common-dir

It's too early to send this. The first patch wasn't accepted yet
(and I really don't think that it will be in v1)
