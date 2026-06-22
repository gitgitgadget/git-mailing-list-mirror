Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6CF17C211
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151214; cv=none; b=uGyJy07X0KLoddqPPdlhaaFx/ZlrbRiHWUppDbOSnF+PtFI9eJ0UPWbk6Am8T5H0NCgTA7ZW64dEHKDsib38S1hrgvrkODs8imvsLK27vCm1tjhNUhsqPi8ixcDyyLz8be3FCj82j5oC7APa1qpBL2lnuwSq+45Zg+8Pl4fPTs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151214; c=relaxed/simple;
	bh=sb5XoHY6OcHeCHKIOW9vpP85npn/JkzCxqeAW4/DM8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpzKPxJLSwxIgJvh+qCFdqcfp3dlLZdrcDBgFJPeRJVu3HCpiZvlalaQThaqKtEa6lTs0qDJCxUCwTz2vrWcvce4rXOtiT2mqDMYQXm9L5OGEAUVM+DUjkqE9Og+f6Zf89jAD3jXGnNpJhnZ3yxO/1dn3n1CZ/OVAl6j2dislMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwAhtdd9; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwAhtdd9"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-519ddebce3dso39244241cf.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782151212; x=1782756012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wciC4eWObj36TXXm+mMsxFQtZC8gJGZQr7NUVnMJU8=;
        b=rwAhtdd9csW09nwmWhFpdgOQm9nFOMaOdg4jeX2I+dJFKMgXZzU+lTQvKpGG5unV/I
         +SB2vm4ShJh4uq30lOHkSBw9ZyumBYK3mWz3Q6Zwm4yCWWATIoI4z+8qSipTbQBxxEAt
         Shf+XL+6yTSbQYfxywQouU3JVpRqMIWG7SL1AF384SUGA6T5ZedvBX+wDCxFjIhyyRtw
         7ot0WaRK3JQ+divbUIJeCI7e/irpKW5E8Y9gCJ2bU5K6Xb6L0X+aXN9i7UXSBLqJUPWG
         LL5i0ktFNxkj8ejqWdph8lkTqDgOsRfoHEgjG2Dw1uZBJzTflrfBKalLqk/c7dDcPgWK
         vcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782151212; x=1782756012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wciC4eWObj36TXXm+mMsxFQtZC8gJGZQr7NUVnMJU8=;
        b=lOqT1gyHIV4fMf5WxW60RVBR2vxVlfstJ9BXgVJi6fsYIAH+gicmrEUegf8qNVolxI
         QfSfzOeP9tkyw9hpcjYJZpxBJVP9w7tX6J3yPDwDkpUAgrzywHVuQ4SC1HrnkT36oAr7
         HkDXgdlTjs8EUuUI/aofqpEnUyBxNQDszqx0hHRzkCfNnMwlgyO0CFKTTTwAAqS8xkn9
         JZ5zt3xyChmmsX4hTnQG9YhTg2ibs8q8sL6OloIP+w+BCmYOMc5G3G4qNrbrNvoYf/lD
         HHDk3exjRkBfDwKAXhN8BOVeSPq8lVkUuc1UwIru6ZkLM98bOzqj7JG70sxaGIdsKs4B
         i7xQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JNWAot4Q6s1p4d3UBhH3fJqWvCJdhSKwQx2aA6Keej2cTtT4xObRdbeNink4r2Kyzn3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh3mV57APtXiRPoiHPl7Jhks4/XMYQaP25En/lhoBAKQIXqDww
	NnaCej5ow0TAACb2hHVirmlxqam5pkup6FAee0/FsDHBLDnzloUOS6Qv
X-Gm-Gg: AfdE7cl7FOWeyWqk3hOryQ2yPLs2vlMir2P91Prn2/kXKwEwWFxIxFbXszxxlORwuwO
	3pG7Lj4jobL6XUVoku5mmJm13IdYwVIcvRNtsGwOE6CA9cMbNM0fKgy0VReUk5o6mjk9p/A9woy
	L/F9utpupqrddZExiJyj72z2lwYq/1zNIuYrx2HwdoBisumaDSh5ON2FGOIsCvQEkCuWF0H1H0x
	XYVXllhXmmQE4ietZeKFiRSh5AQ0dpwSgSBluyRliJHMwLBPct6A3DTphlMKjuYBe4gPFaNphdb
	V0XZ5LyzmDV0mgIXhKDlHb+ddCyffDYhamu8ZLVL1OB4q/yDVZYT7ybzmnp44vWrs/4ZFMe2U/X
	uJp2OiwQQ2BgVED10XpLb9xGnMRiHvGU6Gw00V18DTk6bMlyEwaUWx2dY/vHV9drt3iww7Pyk64
	g7qr5vQDUQOhsFApYvNxAm0JZ0yuwO2mNtTSA3fhZYGQAKiPGs5j0gHy6SsQ==
X-Received: by 2002:a05:622a:e145:10b0:51a:e7a:b2b5 with SMTP id d75a77b69052e-51a0e7ab5e0mr108747561cf.36.1782151212289;
        Mon, 22 Jun 2026 11:00:12 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51a9b5b4sm3547741cf.18.2026.06.22.11.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 11:00:11 -0700 (PDT)
Message-ID: <001e8da6-3232-4cfa-ba6b-35d3489e4779@gmail.com>
Date: Mon, 22 Jun 2026 14:00:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 1/6] commit-reach: decouple ahead_behind from
 nonstale_queue
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <5492acda0ad05eab67198880a5262e84a3f22ba6.1781951820.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <5492acda0ad05eab67198880a5262e84a3f22ba6.1781951820.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/2026 6:36 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> Move ahead_behind() off the shared nonstale_queue abstraction to use
> a plain prio_queue with a local max_nonstale pointer. The nonstale
> tracking is inlined into insert_no_dup().
> 
> This prepares for replacing nonstale_queue with a paint_queue struct
> that tracks per-side commit counts, which ahead_behind() does not
> need. No behavior change.

This change is only needed if we are intending to delete the nonstale
queue struct, which is currently happening in your patch 2. But we
are essentially recreating its logic in a more disjointed way here,
leaving this code in a worse state.

I'd rather see patch 2 create a _new_ data structure instead of
_replacing_ one that already works for multiple callers. (It does
drop to only one caller, but that seems cleaner to me right now.)

Thanks,
-Stolee

