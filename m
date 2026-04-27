Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E731E83B
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320782; cv=none; b=Nt/pZfOW6JJoiLAVubWHawBKFZ6B0zM6eBk6xk8Iv49bhmEUba9zfrrHJW4tQFrm+32o5EEfnz7WmRepqFdkCPQGyVsk1q/YKRyD5vCQqGlcxbkWxwq0Twk7zhZRtZ/SjBbJf6MDzTWL5wv0gTHUTlPoDu2C8iurcVw3oVkdOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320782; c=relaxed/simple;
	bh=bj1MQVKUu56/AGACoxy5eeDYNIEYGw1pdBWfFjlWuws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNy8liKKw9REzlT88f+2NVCU37Tomk60FYiT25h6GILyReBeXBhl6GV0crHfM20ewmq6Ug6iFbZIxn24eVoC5Jjix/iGtITt4UIuqoQkqkvIOwICxzhQ+U2fTKyYCyYSURtT0YcgqU1a7agVza0jf9gC0JEFTQLic92QLtfttgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIkx03P/; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIkx03P/"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8f0a87e23daso599465285a.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777320776; x=1777925576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33YWa7z41g2FdRcNuwAFPiiGEjAXxM3lNe8e2i3kvgA=;
        b=WIkx03P/B1maQ74ccfnVV9QfV2uTFS969IBzxS59H5l1Gzy5AGRbws5y7kgVaLXB2R
         eLlcIvwka2IdM6VwND+GkeimQxp02QfWJCR18/SB97UtoKWSc7nUVOX41/tflRSpMeP9
         J/RQgHy9BUG5VKO3BHQ7qH5nmGno1VVi6rVRRaJC61ehh388SvbfClT1mRhpBATic9Qa
         bLZpwGoV6yUqurdwPYHlpk67+WsYQ0bYiRnQjnnqAX1oq0K8nBX3Jiq9ITl37+LfxK99
         CfJoeJrDUIzbZMTlyRrEMYz2kz9RTL5gK4Qp6yBge1lyWpX+xYPeQBBM/MSGjFABsk2y
         kRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777320776; x=1777925576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33YWa7z41g2FdRcNuwAFPiiGEjAXxM3lNe8e2i3kvgA=;
        b=CkTstUMvjvnPOAiYRK71y9kex60wCcYqkysK0BvKVmc1aeHE0sVAaNQMXOiMdldJUE
         sc4iu+BPHhIMTC/5e026fOGZ/mnHq7AJn4vzyIGnni3a7LiWb1YBm0N4sodXUG725hsK
         PmWxCXLJqREFsfzTMi4UlZYv4u+l7GLrsbZANZSNngPxTOILpvPtFe4WpKRXGetkp+yL
         owFn9N0J8iOlWkEGv95TzELVHbAc/gPH+q3+oyNBUvIe7XzzbuHLj/hcu0GZDDWqNvJZ
         PQ/r+O8JM3TvTC6A5Kfr6mn1C4au2VeOGrz3INSxw8Th9V07M+v+jTCMN4iIFVTfgbOR
         szsA==
X-Forwarded-Encrypted: i=1; AFNElJ/MVPmtxsJQfCIiS3fXuKWWrNqctcoEkLtDvleCrqijHoB8XV11zjZM5TVah4XMXdIvPqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuJi2p/BHaKgYNSUDBmlFaq5teWQOsq0LLY3ucMkWFqzgmVxA
	6U6qmx8PMdsUhQ9tkbakzBOj4eARpw9HGSpGWEbhVsmN7WGsc569zTWX
X-Gm-Gg: AeBDieu7uSUqM7E+HcC8vB09xwbwzR9IAyi2Rq4Vti7gm/yv3Mxa7NICYMpm9dRTyRY
	1eujGp4goebObLw+TDnLBOMzB4Gge1o/miBGL9sKjwqmBkOau56cLEpWOiyl4PU3GM16XGpRiKA
	1h0Kzd3k5rrXfsoV1S1ncvVKhBKJxLnrS4OjvczB6K6kVqJg1Uebs8H1CIp97tLhw+EzGIRbGye
	PqOY4WxAFn4UbtRDPR3XihS0X283SoC7Z4qfYNHV7Qna3y4vOx1L+10uzZP5o4iZxJ2nWtFt9ao
	6eOgCBv5fuhk9a9PjqixlxXCvTqqJIXDrjjpa//qvFNiqc30lqFeJgNJxkYioQZz2hYgUdL1MfO
	Ye2kHjEp9mNWO0Q+EwcTcu8j0+SiDCA+3HAkUzkj61T0yNwDBINtvyt6gCcPeBkQNwJ3DLP5y7P
	MrrGWI9d9p5DhsY+S9tU+gJeAJO/S6X0yiIpx+lHFrQWZxHILcTsRF7zwk1uaD61ULtXw5OcQgT
	I94g9lp
X-Received: by 2002:a05:620a:290e:b0:8d7:f950:ea68 with SMTP id af79cd13be357-8f7d6f3dd7amr17778885a.13.1777320776213;
        Mon, 27 Apr 2026 13:12:56 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e281bd11sm4380556d6.8.2026.04.27.13.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 13:12:55 -0700 (PDT)
Message-ID: <469a26e8-4309-4221-abac-e9a09e3f743d@gmail.com>
Date: Mon, 27 Apr 2026 16:12:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] index-pack, unpack-objects: increase input buffer from
 4 KiB to 128 KiB
To: Scott Bauersfeld via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Scott Bauersfeld <sbauersfeld@g.ucla.edu>
References: <pull.2282.v2.git.git.1777306114914.gitgitgadget@gmail.com>
 <pull.2282.v3.git.git.1777317998098.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2282.v3.git.git.1777317998098.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/27/2026 3:26 PM, Scott Bauersfeld via GitGitGadget wrote:
> From: Scott Bauersfeld <sbauersfeld@g.ucla.edu>

>     Changes since v2
>     ================
>     
>      * Renamed DEFAULT_PACKFILE_BUFFER_SIZE → DEFAULT_IO_BUFFER_SIZE per
>        Stolee's feedback. The constant is not packfile-specific, since it is
>        also used by the hashfile layer.
>      * Stolee noted that WRITE_BUFFER_SIZE in read-cache.c could be
>        consolidated. That constant was already removed in f6e2cd0625
>        ("read-cache: delete unused hashing methods", 2021-05-18) when
>        read-cache.c was converted to use the hashfile API, so there is
>        nothing left to unify. The rename to DEFAULT_IO_BUFFER_SIZE helps
>        account for the multiple usages of this constant.

Thank you for discovering this context which made my recommendation
non-actionable. I was looking at the commit that added the 128K limit,
which had that in its context, but not at the latest code. My mistake!

I'm very happy with this version and look forward to the performance
benefits!

Thanks,
-Stolee

