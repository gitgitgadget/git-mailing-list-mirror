Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69122144C7
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768758632; cv=none; b=fXwQgobfeQQ9L4BwbNznanSgXs6LMWBBBQf0XRxAY8CYs6H5A7DenCO07HYNtDCULi2a9N2RuA0Oau/ruB2UsbBTqQJbbM4ukJ5VLHWlOGs3Ah1v1SNCnDGgiIOhew0+JDUSF4NU1bOzm2ZzGMg7tq2JT6/LKQ5z+Yn8JXPlB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768758632; c=relaxed/simple;
	bh=W9OMxoqi3wypCPFHAHqG4rfp810fJ/H/jY7O5s9AyzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9xu7Q8i84fiiIijGmBhq5L5Hhv/a4+YQDGb3/Dic2tkkDhWjRysX0Kmd5/PYQwCpsbOH6F3jQTIlRDyahA2CNSeK94JV+I5lQEabzbmG885p+g6nU9T0ubYAG9KTPZq8R7RgjIk249R67Gj6w6RLUHJaxF2x6SSFdvsHaRFRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFBkA8kq; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFBkA8kq"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b6b0500e06so3367678eec.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768758631; x=1769363431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9OMxoqi3wypCPFHAHqG4rfp810fJ/H/jY7O5s9AyzM=;
        b=jFBkA8kqT9+/QPL1NmPGhJYSyyXoQLmx1hUbVLYtdREuPMulgDI5Kt4ae65Uax156C
         AVk9Fp2nxAq+Lmlewsxm11lsrgOCRIc5M5FfIVgCjGeQ9XGOYt17yQ3QpDDiXetmYYtb
         RrtTmInzJJLUVfgwK8Jbh2FZImTIwQXy+VkOtZED2ykHvKEWJueEfnaBSDQsyz2yADin
         CScwz8qk3HmzDzBvPBxK3lN19bX8V4X8BE5dgkGycgIkVjQJY+qGOdkJArjWymsBNs7d
         iIeG/TKipmd6Q3fj7KPpx0Yjcf12NzrrJCK/8UxozKSAjEYfTCyxqqFoTURsl83/IRUm
         dFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768758631; x=1769363431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9OMxoqi3wypCPFHAHqG4rfp810fJ/H/jY7O5s9AyzM=;
        b=WnjoW79MtLIDEFZc6GO/5EUYe/Eu9UcGTlIlWY0duh8U0+cx1MKpJgKVp2CizA7L+s
         muJzVfAQtSvfy5dkt2MFbaZzB718SNP5hIuZi6CJnBfeZ2Wd0dzEJuq7Ztcn1uqElkZf
         3hfW7vKgDsAj6fOFa8u639QMFDncr+6/l6CMu1F2C3omSck1nyYvdDu6pWFglkJEsfHz
         fid2sDeWJ2+WMDuoYez/MkNmOJ8ZeWEgf3U2aDHXJlYMVJwImc+0FyVZjSq2o/FkyW2E
         0CQZzSlWaKQLvccySYZENRMKc2N1hfxuQYvNAydX7/gt+1j6IYAlIy1Z+4vCb3KpguHK
         dG1g==
X-Gm-Message-State: AOJu0YzSCHH2aDXhtNsHsj4uStpaJCPOOsM1Rk2+CEx150AJgpZjAiDP
	/l1dErQN0L6Qp+zoGg4GpWR+bsBrgr3BeXbB5RTghhidaLHQEP2ZWtC0
X-Gm-Gg: AY/fxX6OpKsAQYTMKRLb1aU49eyd/0NbsZGt1wsh9XhK3kkMbaEmStJkrnA8hkD2DJv
	L/pgfzZ0riDuR55LRKQIOzEgb7iGQPsGG31cLsRGwKe1EWxzmkiWFNfRtEs9CoRHrTf4F7Yv/6V
	GXnPCsK4x1zOoeDsfdR1mccVX6Hi2/MkySs656KPbuQcZsG2G4bw/pAf5Z7P4fIz+Gw+z/YihsQ
	PovID/25Na+bLnG4hFrEF0X+ZeF4g5Q8m6J5pI329HhlH5FYAwxnEcsgCl5XjptAo4Hz8o00us1
	MmmM0ewNwBp4iLD8RgJoF9j48own23Zl89Z4F6rHXRyAmYk9tU1sMAjqn5UO94ZCBpt0dsjc90p
	hTp/BabBkCb2UHKR6EqvoyBub6lfX+M55PDQAUm3h0BiAyCDDO5Q8FwszlXwl2fWWNpRil5YNhH
	DV8N1J34G0cAWOAaWTOBcdKWlgPWNAJ1B5p2L2werPK6h6rvUkI99ruWwW
X-Received: by 2002:a05:7301:678f:b0:2b0:4fe2:6a2e with SMTP id 5a478bee46e88-2b6b3f05fd8mr8326583eec.9.1768758629100;
        Sun, 18 Jan 2026 09:50:29 -0800 (PST)
Received: from [192.168.1.99] (23-93-72-44.fiber.dynamic.sonic.net. [23.93.72.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3619a7bsm9730294eec.19.2026.01.18.09.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 09:50:28 -0800 (PST)
Message-ID: <c51367f1-9ce2-4580-9f7c-4b1adc989582@gmail.com>
Date: Sun, 18 Jan 2026 09:50:27 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Repost: Inconsistent Behavior in 'git add' (git 2.52.0)?
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <12239ac3-bc9c-4484-8633-a255a706011c@gmail.com>
 <xmqq8qdydddl.fsf@gitster.g>
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
In-Reply-To: <xmqq8qdydddl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your response. This is indeed a very minor issue.

On 1/15/26 8:55 AM, Junio C Hamano wrote:

> It is plausible to teach "git add" to treat paths that are
> explicitly named on the command line (as opposed to the paths that
> are discovered due to recursion) differently, but that would be a
> new feature, not a bugfix, I would think.

Agreed. I had been thinking of 'git add' as a kind of
database transaction, where either everything happens,
or nothing happens.

An excluded file isn't considered the same type of
error as an invalid file, which is fine as long as
a user is aware of this behavior. The fact that
'git add' warns about ignored files helps.

Again, this is a tiny, tiny issue.

Cordially,
Jon Forrest

