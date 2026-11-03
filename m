Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793749332;
	b=3TJgSsYB3z0a/RqAahBiFBppodc354BtHQ6Ccqs4NuEqK8H5phjEV+YOUnZQIgQF30k9
	 c3IX/aVDwMOT8SKJfR+vvELIJkt0+qVEZdWr6wX5P3rOIHtWtwFAroujjOcceV/Gga3fZ
	 vrHX+7gfGmaomoUKVO4vw510x/8IWXxZD6RfL9+9p1mXUOX8dI921qhtaMgQPoXZDBsyg
	 cpPWN+klSbeOYisNMBs5pK2/RfF80UaKVwPblwr3KejREn0r2SWdfdUMPZaAUjby4weL/
	 m7JE9mBt5ja9nz0rCXo4GsHlM4DEHB6bVg81bcIwnVbHyMHOr6D148K46QYWOns8B8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=gFvQFfuUF0dgmg94Thp04taTlFbPRmeA5WUqJGDhPwQ=;
	b=07k9mhVQ5rR9crlM41bxgjj1JUwj3/zEnASHrD66WRfll5MFVbhpGoqiWrXvnZj0nZnP
	 UE9JOoclzwrNQoWuocSmJ0uPmFYvTE/YeCmNF0tefFEQjQvfLj9AouPt5wXbCil306Ldq
	 KGoboUOJ6Vz18fUYbKATnl4YOULaw1+0+Mx6ECjI03X9RwMKkUZZvX03zNNjlKoBbKKzX
	 5zl7satR23QLPdwrKh1SzLawJgsu4hIPfUFXDUmJ0Is5kW9ZRzsADNpx/rdhveAgAK/3S
	 BNB85D8T68OqeWxWhMbIZA9Ly5qtAkvBmEf45+9B2U1AL2HGLvetnnBJFTZDnb2fM2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YTfvKSeR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA865606A326
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 23:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA865606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YTfvKSeR
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9908e3cd939so40885241.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 15:42:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793749331; cv=none;
        d=google.com; s=arc-20260327;
        b=B2LhNKiKg29c+eZYq04yfCRw5/KLv6S9qz1OM8svtR4wkYZt/mLHULtW6+Hl5bQ4xa
         WwJyMH+E3y3QffagbTtczTgBIsk0pREn062UA6ALDLziY+2G0/rMyAKxdPOO1y7p+R8y
         6gATTnMKbI7gQ9NFWujKWyQ9wSzysvgbNlyzHOIihRvo+V1w3AL6zherbqDlx2aQwnnv
         g4+GoTorWtTrNTTHLyjXHja2LtAxgbJ094uACxsGXUfo+P9w7tG5OoO5kBWdf+yelk/B
         vS1OGVn1gto3uTEe88I8oIi/OQr8xDal1W/Tz2fljtRCVQWD430I/mwKQe525l5TASXZ
         GHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gFvQFfuUF0dgmg94Thp04taTlFbPRmeA5WUqJGDhPwQ=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=JMkxINEpabxmBXMl+xpcS7mOaAY/z8h6qU0oCEkJIjKsjQXXusFAThA1Q6170joK84
         W2z2oKsXdTSd78n8vYWjf2SUIKil1PXG0EcVX+Tl+Zyo6fGh0opYeo6I27ZQduVPGbsN
         /e1bLzPm4sLFC2FMsTVK5kNi6f37MIEN2cTeUbNnGYPAe0rwDILwbuRgxOFg8TbxsquM
         NCuzdFPfe4GZBYmtAaR3PrzulJu5DxGBpY359oBZKIgWasbkhHk0eW2eIMwjaNVveOUw
         51gca3i956eZ/lvfwZvgD4rEkms0Vb2Jk1kV8aEfRF8D2xIuGtfL7jpMFdAgimH+kejZ
         /EwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749331; x=1794354131; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gFvQFfuUF0dgmg94Thp04taTlFbPRmeA5WUqJGDhPwQ=;
        b=YTfvKSeRKKoOFms3Zl3KeLZ8MFxdQYsCUlgxKxN6Nm8cCX3DTmJCxJmj0jfs7CaCGC
         o9X/snpyCqZJGFNhZh0zgbZWLHkvwVe9Prm068o1DaTdOChrmfYuq7Zp8aHjPyIwaE6C
         XA1EyghUEkCU3Ig2TEyDIQmsKO1wyfR+MCcovjUOtb35ty+PczP7V5VxvUu2f5tMjBKr
         s8WKVak8lh3z5NSOyjzJQ82VkU+p0wsLlly/bwaAoCTPXfINsKVEXvurd42avObLJcaQ
         aC7Vo6kQAFxyqFAQZidFI+TBPWIfJfXS/mu2nZhSCk/M/v9sJ3a9FDP0umseMVTxfdvS
         znpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749331; x=1794354131;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFvQFfuUF0dgmg94Thp04taTlFbPRmeA5WUqJGDhPwQ=;
        b=AYgofAYbzHc5ahI6rSuCFppgaOG8dxB6U/Pnon3ApVjWVUuS/lj8kx8dc5hLve9C8i
         JE9EhVwTg6kLDA2ZN6Ty/9RbX946kr/fafEvDrRBOHEjT1OfGIBZXO6OsAVyaq2uDRTE
         sgm4zkU07pm9ypvl3oQC+PqAVCmINK1WMUXD/mnqGbMclV44oUJAwn3O+iDQvR1xLqnh
         3JD8bxyds/hWY6Y+7fem+MY0oB3dacYRwNAe8QhJ0WUgs8wzmtyxOP666U9ravtmuun6
         X8GGq/KXT7a0a94kaToeIejSuBLaEQ49UgEP4ZxQKZfAaTRjO7ldH3A69qdAzm/xpYBd
         SRdw==
X-Gm-Message-State: APuU4Z905IAFDettsEkOIc3to2MgqD6NTMUvyj1IjCtus0/jZAWetwNg
	pTaBfMGfcjzWbsp+kcr2+iCKSl+MtZY8cU7UFhm8VieJtqlYEP5ivhfGr+ZBzrgjyfwsd3+M/mU
	4+4XOtdD4rMXqRxl+0Ix/DWdOa+tUrtvDV4nM1fM=
X-Gm-Gg: AYBFou3waUhsLlhKapfpUl1Wo/W+JQz5YMZ4HjpccNp79Px4fbLBhpJQ6idFrxjBrIM
	YmiaJ4j+pJ0xZJaw/lq/SqdMFLl/pDU6lWKnrG78YbooB4ihbohcg0qddRe/2LJG3orq785DOCb
	LWBh/3uMkXSOA2evvRpSoRvPQDPAAkWEz+dklSye6nPYAxWvfkuSUbx6Aiyq5kzpsLFc3TMSVNL
	WuMCv10C7cvXxfm6y7tUGUp8PImJ6d5R+h9KESYS47I1JZ0UkTIZwhEjvQs53zIcjNdwb63SGI2
	/3DwK3zpcMxy9DCKBeUsX/DkpLXA4dZ7APIA8ju5s92hI1ccNxzSZYQbshekOTajdSc1H2AUSKq
	UUfBFbpgUblQTyVlnouiaeYPp6aQXt+n/0lOyWn4VYKQnUvHdGcFY5IQZCWFFx1pEjLnmFDBMFX
	GIZcRrT2hEDaw+BCh/T5LeR8T7xJxEG9ji21HnP+mGzg8ZMwCy
X-Received: by 2002:a05:6102:e0b:b0:7cc:2fd1:7143 with SMTP id
 ada2fe7eead31-7d0726280c4mr4395433137.17.1793749330880; Tue, 03 Nov 2026
 15:42:10 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Tatchou Yopa Nelly <yopatatchou@gmail.com>
Date: Wed, 4 Nov 2026 00:41:59 +0100
X-Gm-Features: AclHuK99wFbja9QH51WKspjXYnlrb8hY8O2hPIZqnAqvot8vrlkhNJ1rKbzxZx4
Message-ID: <CAG7jffznkS4K4DGmHYjvzguWLTf5srip2eJz7B52TXE3XZwoSg@mail.gmail.com>
Subject: [Outreachy] Introduction: Yopa Nelly Promisor remote fetch ordering
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

My name is Yopa Nelly, and I am an Outreachy applicant for the
December 2026 cohort. I am interested in the project "Implement
promisor remote fetch ordering," mentored by Kaartic Sivaraam.

I have checked Outreachy's eligibility requirements and confirm that I
meet them, including the rule regarding consecutive days free from
university commitments during the internship period.

To prepare, I have started reading the partial clone documentation and
the promisor-remote protocol section in
Documentation/gitprotocol-v2.txt. I am currently setting up my build
environment so I can build Git from source and create a test
repository with multiple promisor remotes to understand how fetch
ordering currently works. My next step is to submit a micro-patch.

Background: I have hands-on experience with all the tools this project
requires - C, shell scripting, and Git - and I am comfortable working
with them.

I have read Git's AI guidelines and will be doing the work myself.

I look forward to learning from the community.

Best regards,
Yopa Nelly
GitHub: https://github.com/YopaNelly
Email: yopatatchou@gmail.com
