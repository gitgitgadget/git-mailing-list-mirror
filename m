Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379DE277CA4
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960894; cv=none; b=MfL+eI8+wev0mfyx3nnOulKKaMtbkGAm2TFGIMxzwTB6LgxBDqTpVej1IOZjLKJIB3LiBcjmf/nxtLnq2dqViI3H7QATTCVjMW+p5OdNYrvNtb2Qi6bCoj3VEiAyzP3OVBQJ5qlkvrRaeVX7Q9+lAuBcXwR33PbRvWn9gAaCBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960894; c=relaxed/simple;
	bh=qSih7gr+1LMPvi+v2eVa3ZLR2HwKSJx80D+7dTbz9qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tr98YgbYjuvYjt1ThBmSlcA24jdAhxWskmzWTJ4PuRfFt8UnakQGfAMf8digUYXD/tJ/WhijNa8cgby7vLR/plqVglZOE7b13lsEx24MRIBLjQ9LNWDHenxcXPtseKgNTLHdMbz8AG3jQS2Xv2fYp7Kk2I7OQRpolqYbbdvZoXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbGVKF2h; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbGVKF2h"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-896ff127650so98193996d6.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 11:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771960892; x=1772565692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mzAF18Jy77R8IXbxr6U09nlb4xsqFgWhzu6WMYThAfo=;
        b=SbGVKF2hk0Jg5HkTg6jN9dhGri8nG4KWOeeZj2hDj39dhxI+8EzWmx0FdBc7Ne1bvx
         n4pVRg96nOptqx9HaVQCcO5buAH2Dwc8BXtG2hhbSJHqoxwJLadkWxMm1zyiBB6iMGz+
         N7tgK12agD0NT1yEn8iJkULZmwP4vTEmj79DN9p66jw5lydqHqcQi8Oviz0sGroYOcEh
         UOXBEGv6RVVKKsJnkUkBl+hO8OVFC+/ZRTTRr8JAF8M3lQk7nb3TlmwTymiTcjtVHPj8
         ur5J4MZspK5nD+y6VVjWWjTtiizyTn5muaQfHlUGagviawVnxFwbUMFhC5ugbWXqAGhA
         TuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960892; x=1772565692;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzAF18Jy77R8IXbxr6U09nlb4xsqFgWhzu6WMYThAfo=;
        b=A0rD6ZZA8k/p6YKeKEEXiP512YWeFqrEil4rXTAVBfCQaYJfQjTI37qFjCS0W0Nca1
         +t3ADGvVvafzRtyiONVDXave6vSkzqxvfT8IWuvmeXfHaLu1v0hbYFY0LGibDXSyHi8c
         YVqhgMQ0VKKEwmM9ozg8vF5/s14CxfC9TzaCkVJ/Yk5oFhIJ3/Oydc2JW4gFRWeXwTHc
         9WJX/EMl693XiPTULW//jAYbPszCqGVIIB4BwjYxZh1j0yPb28CYmWzYX31M/Na6UrAD
         m+/EAVTTG97vfhotR9I7tib73gkiMtpw9xh4x5cwh74nZd8r4VAA05Jg5c5Qywwm54pT
         er9g==
X-Forwarded-Encrypted: i=1; AJvYcCUyEcRnCJA/af+BAxrjKMTSdMiP1uPVrxsnjGeocFi7w8Ke4KUgzROB5365iVvQc4jw6lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3NuhgIrOQLQWjtdLeBzZV4TC9bGKTCTN9pudMb2hsgHaxso5
	xdujwMyZoBzNupf15DR97oyT4Dix1jwCGNw5q828ckuVEne3uU5xFLuhDyBL8w==
X-Gm-Gg: ATEYQzwHVEpONEob6WeA1eS7/Cd2WlbcJhIHLQzolbMsk91x5jku2gH3wg9f73cfJTV
	UEGH7zAug7+9vtK83yXj/lyvlQ5z3+EjRRqupoHmnjXDukmAH5mpUfaiVO2otz8Db2ZXf8HLcVA
	sMhJuHR980zKmFSt2Oh6yGiB/vWdpA0GEYSad/VQWBZM2niL8yv9bOV+arJ5oLpsmLDCCY1cJcc
	W8kQFj9ZtgxM4lSntuChe2OzpwWDZKwnzsf652wC/K6OBdIKjPhcR2vwI5DvDzB6ie5A15mW+EF
	yvxdFRXyYEa2lKhqJqz7bE5a2BhWzaFdi4K9yvLvKhCQ7ldPgubuAbljVRWNXFsjnM2KGTSm0oP
	ITYLJ68nHqfBk4NkLUCqma/WrCNTPtKxPjhadshaokSoSuSp8F6IO/yyOOX43u+GPVFobw8mA34
	v4+YrfE96zPL3Y8hhNp5NRuPM8TfkCuLaA/EOZtSiQFY+P9NGOK2vLpKh/LADkv9DHzgONer5Br
	ZXX
X-Received: by 2002:a05:6214:1cc1:b0:897:1ff:a7c with SMTP id 6a1803df08f44-89979c55650mr200228916d6.1.1771960891889;
        Tue, 24 Feb 2026 11:21:31 -0800 (PST)
Received: from ?IPV6:2606:6d00:177:b6ad:f025:57e9:a66c:6cc3? ([2606:6d00:177:b6ad:f025:57e9:a66c:6cc3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e77cddfsm120457896d6.52.2026.02.24.11.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 11:21:31 -0800 (PST)
Message-ID: <3f744aaa-23fd-45f7-9776-87036ec8ffc0@gmail.com>
Date: Tue, 24 Feb 2026 14:21:28 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Feature that allows the user to merge only specific files/folders
 from another branch
To: "Sugiarto, Titania" <titania.sugiarto@rwth-aachen.de>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <532e9d58b905404fa625aa59104ce8f5@rwth-aachen.de>
 <14775be9ed944bf684c3696e1a10f44d@rwth-aachen.de>
Content-Language: en-US, fr
From: Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; keydata=
 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
In-Reply-To: <14775be9ed944bf684c3696e1a10f44d@rwth-aachen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-24 08:44, Sugiarto, Titania wrote:
> Hi,
> 
> I have a suggestion for Git, which includes a feature that allows the user to merge (I want to highlight merge here, not replace) specific files/folders from another branch.
> I feel like a lot of users have spoken about this online but up until now, there hasn't been an update regarding such feature.
> 
> Might be worthwhile to consider?

Hi Titania,

I believe what you are looking for is already easily doable with:

   git merge --no-commit

Then you can revert some of the changes you don't want in the index 
before running this to complete the merge:

   git merge --continue

Note that subsequent merges from that branch would not include the 
changes you skipped, that's the core concept of merging and you can't 
avoid it. That said you can also cherry-pick specific commits, also with 
the same --no-edit flag to allow editing the cherry pick.

Since cherry-picking is centered around individual commits, doing that 
for all commits of a forked branch might be difficult. It appears there 
a -m/--mainline switch in cherry-pick to allow that but I have never 
used it. You will have to experiment yourself if this is what you want.

Regards,

--
Thomas

