Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5BF37D134
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645716; cv=none; b=dgLk0rIwxGmCE3fePxt+NTWeuyaTloFNpQQKFLqLe0FPyKNcjjOGpUg7zGLEAtEpHjpeXpcJtHhOHrREgnkOaYTwXVGtpa1uDfnRya8BwE0iDYPZMsWWz7AbBWfxRr3e2/gtpVNw5L0klZcduqP6D6MTDi5+3kZk4BTazJ17psg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645716; c=relaxed/simple;
	bh=HoLWkvqU/3T0Nuse6vpYnNAQ4OMdJSAd/2ZdKn8UrOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMWBXZDYBXsp0N37EKCwZIxppeGp/4oxxtFRUbAHne75CRupOH0a14wFlsfnJ6v+GosS3Z9qKtsScLkzsmGWkjL7SVczz+H+Ob91IuTGjWf5MVHXy9P7UCA36t4ELpakR0RtnyZTWexiyT0A3NyHIMokotKfqLMQhYkTeXSBMkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnpArSGp; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnpArSGp"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c70e3eb3af1so282878a12.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 09:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772645715; x=1773250515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rX8Rllh0tzPzg9X19A5iLLYKRUVlAcAEASFl5DF5A4=;
        b=dnpArSGp1TsBrLEEd1sQxwD/solXE4uo92XjN7a+UstMTtZ3RWfxei/2oKoFnylo+u
         88VN80CfZ4n5mFnSaBjH/7KThQN0hZ2BQaoTVJ+dfdZWbQBjuvC/3hES/DRFSK+1XkFB
         Kt/tnJDbpDANmu/8OYqEnGc9wvb7SA8dfN85NYbTFZ0Gliit0gVZyZ5X26v2YDfzul7c
         EQiPbCoaM/zy29obdyZnz/lGkj43mtYETY/1LcVQeMczE2O/ZiXD7Tl4eHRp2ZmljhxM
         d6fKu+LFXrwsShD6LrY48dIZS/EhTJbziFTa8GjpELy0ByGKgEYp2QiYHgHjXHAOIRZu
         aLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645715; x=1773250515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rX8Rllh0tzPzg9X19A5iLLYKRUVlAcAEASFl5DF5A4=;
        b=fYwio7F/MOl7q0YEEDvnHmCsUGpSqOOX5d5y7eY48RUY47MBu9+VsjeWBUexcP8YrB
         XlDathRnqW1E9mcvngU9vED2WIgm0pKbSiFj3A8W8kjyT0bmzU6c6AzvIFnqENGhlniR
         u9N02pocM6CXrWEG0x+dfe73bsw+RBFle+Pp/sQkYaiWskd1orYcIP2JgwirYWrvDBpT
         /bScCTWg2SJKcZA9OIPyJJTJZqK2IDlorZ3Ih28MKGuhJp2rUqBrcFm0B6RBNzmUpKLD
         gocylzOy3ttHxIOrbDO8lH05ejTylWUfG45e4wqZMQlNRKLa1LHr+jT8ncAa79drp02/
         B3XA==
X-Forwarded-Encrypted: i=1; AJvYcCU1FosQg+FwLQOBmkj0IU9VeZvs0blQIkJreQtojoAbWuAzDY56rOfMB8VQoec29eeS8u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAb2LjlnpfgpVH5WdYK24VK9Z+VQcLzTYJvLDyPSYxxHUGpwGv
	EynV1i2E+CZGy9hSWeIVSMiqscu6gJbxEuMf83bh3XhU6d1sx8iAsaAY
X-Gm-Gg: ATEYQzwrG1GYT0RZEyUZgp5ATnaKtKM6schtiFiWxldRVz94n3kvRTnlIoFTW9wGE0h
	z05Tosy28zyV9lkZwrw/iKn6ET/8eGG9gvoiONR+I44ZbTxREUoayvkJ3y4Rwtd3kY/OAPJ3C2e
	PyZL5qpRh8nL3LL4lJ6cyWbdLOsZsaviWE5lTz49zwk1e7yNsQHjqUbom70cFFOH7sOA3zqsV3E
	ZxO1uJBy3uaRenPpEmaNLyKBeqQp/QuSXGs5zbR7vWPfBAV+uXEtb/CGiFtYlF6poI+OZHATaiE
	BCKdSFTZjoGpMdTQRhX2vSFpZmlTF2vsa55GKUSZ60P508ff10N+gW9Mg8zIDemp/c71wJ33q0g
	MzmdGJ7shDoAdDcmyBco2Bv0HPTRB8J3WhiK32aG2vtQ5rl94ISn3ECNrW1AIQhWuOA0nFhAQIH
	tJrBniq4iavDNfavhHZ/sjhYuPm3ybnkT0UdZQjxOa9sfkcb56nmaeHbXb9AOh9JM0eKNHGCvcZ
	Wmbk8CLUAWD
X-Received: by 2002:a17:903:1508:b0:2ae:6092:8d87 with SMTP id d9443c01a7336-2ae6ab3fa63mr18462855ad.6.1772645714590;
        Wed, 04 Mar 2026 09:35:14 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f244sm213467735ad.59.2026.03.04.09.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 09:35:14 -0800 (PST)
Message-ID: <fc2aaed9-ecc3-4efa-bdef-e6ac951c1d5b@gmail.com>
Date: Thu, 5 Mar 2026 01:35:11 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
 karthik.188@gmail.com, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20260222102928.377519-1-a3205153416@gmail.com>
 <20260223074410.917523-1-a3205153416@gmail.com> <xmqqpl5rumy0.fsf@gitster.g>
 <xmqqjyvu42pw.fsf@gitster.g> <460f00d5-97b4-4a6c-be45-6f60a17cd33e@gmail.com>
 <xmqqo6l49mrt.fsf@gitster.g> <99c6a437-3fc3-4d9a-9465-4c47a9777776@gmail.com>
 <xmqqfr6fa63h.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqfr6fa63h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junio,

> That is one of the things.  The broken test highlighted that
> GIT_DIR_EXPLICIT case needs more thought than what we have discussed
> so far, but there may be other cases that we need to also think
> about.  See what different cases are in the big switch statement in
> setup_git_directory_gently().

Shortly before your email I had already sent the v12 patch.

I did make changes in setup_git_directory_gently_1(), and logically it 
shouldn't cause major issues.

Unfortunately, looking back now, my implementation barely qualifies as 
“functional” and actually undermines the purpose of setup_git..() 
itself. It's a mess — I rushed into it without properly reviewing the 
context (like how other cases are handled) :(((

I'll polish it thoroughly before releasing v13.

Regards,

Yuchen
