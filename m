Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFF2698AF
	for <git@vger.kernel.org>; Mon, 19 May 2025 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645432; cv=none; b=pv162Oczy9Y3xlLzgzoDlK9qAzvoDL5QrhlVb1z9PR4vMKwNmwy3/tx7Y/eeosMNj/+wiFzna7CSUpU3lulH0OgOshMeGNMXYzPi6nAOtiH4cm4dyLNbpr14PqSRL/rCXkRB9p+6HhIlQKc9U3hW5k2oTBXb3zVOjao0oJB/POM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645432; c=relaxed/simple;
	bh=Dqs6+1E41uwbXukU4j8oLjBEwBmlIGSRiyj7jiwO28I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ai8neEmS6HHu0y0zhvZnjM/ZZxvE2CUwZDlVSTvyvSyi6oBlBzd/KjDnWWTYlZp/J+1j197z1ZZ0bWwmFd12eQVgiLWw6O3uB9XrOHF//CRWgxghUvcEISUVV0MYz4F4MK3KdNZ1zorOyWx7Ri4TvDqZfl1iKvZeUvi+eaRolVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt7zzHx0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt7zzHx0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43edb40f357so33092335e9.0
        for <git@vger.kernel.org>; Mon, 19 May 2025 02:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747645429; x=1748250229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xfM8aMwXkHV3BGya6j+B1Mr3Te90qwcqQZ+GzN+fD58=;
        b=gt7zzHx0pZo7mSaVreIvc4gHiZvEeJ9PparH6zfOghHXkLcMF4rIwfs6dBV1El7qB7
         AHd+7+5T9tG2Qh8eqyYlC++/X7zl7bCtwDDVcpUtBDK0629c6vUYbxXfL56nqABRvNpo
         jkOxT6mrE1bE2q4itG9bAPE7+W5Abou30qgDCerSnqbQthIgoTY7uIk7LYBZ00O9q6zY
         ElRJhPvusCeY9tEW04K5cy74N7gctceKnYUUdE4QN7igClNRclrUXmdJoCYidgg/WBWz
         0Bm/9igXrB5OjuONBOnhlFrcJDYYOziPeQe7il1xWuQMRxvd3DM9QQMIh3U5NTeVvvO0
         8kMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747645429; x=1748250229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfM8aMwXkHV3BGya6j+B1Mr3Te90qwcqQZ+GzN+fD58=;
        b=WfGv3bhtUFVMmCaPfb9T38hq50hn+3Rwiss6x/SHdaw3fLJwAIKXd2cuaUxltWvk0o
         lvCh1fRA+GyUmmaaMXPKbytybKnNBtQsmLccwOP8LWfNRntQJYeNJISjISaVoVKXfBVf
         +x+ydCXGyJKhbIQwA/bhRSj8L6Sd7sFW+DOjR8qtVmZzXpPNAm9rcLuYyn60aJkUiIg9
         2eJr12A4sQw3KO8ScdXI+jG202gdUPwyg6ZkcV5ldyNqx/cl/JaZAOBNEDfL8uBNG78L
         zjFhTEAMurC04DmvWycAc4xLmsn6MENbDMmrrJIbNI86819KQJK+BMM/XM/hWwjNqFDW
         wALA==
X-Gm-Message-State: AOJu0YzDNKPmsCYJh/W5AVcQWTIIVZhCS8qXw2dTdYq3JhXqSdwpjT3U
	q2Nl5SSz74omKX95GcpZD+s5QoiWvWH3oj6csNf8Qv7U+rn5FhJ07+3P
X-Gm-Gg: ASbGncsl4rCr6UDz6eWMrQQUf7wCXtOgHRxg87rnYR+26faospN/4bIeu4R3Wktuwol
	zbm0sZaV4OMl+t56JeNpkhSmhwBanPg9If80KA9oNg7q20rn+zxZQ9HdM7NJmu5a68JYnJzIT7T
	bgQhnRVWsr77v9IbBTkgSyR88cf6mKhWtfHUqbukfdAioKKT6+Qu6gXCh+up0LIp3/aXIJVIJZg
	plIawdZRW5pajPFVq0yadhzcTaQGRHffX82/uCXTIL4z07FtUSuIdpoWncSnDr+5OplW0lMkUwW
	s2njwE2VMzyEhGaChqa2+2+6sCPSVwIbbetXXRvyLYe4M0sPRIyUTMDnqFL8EK0sVVriivheSYK
	kbD732FDF8mgJeS5kUCdk49lPbR8=
X-Google-Smtp-Source: AGHT+IFZKTLMTpu1DLVBV54T6vReVVOW1nwMWdsKg73bo71TBzU6zo9WEFfwkkEgcw4Pqi0HsgF7dQ==
X-Received: by 2002:a05:600c:46c7:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-442fd675b5amr126319695e9.30.1747645429105;
        Mon, 19 May 2025 02:03:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8cf66sm11841857f8f.87.2025.05.19.02.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 02:03:48 -0700 (PDT)
Message-ID: <32de776c-9f15-4030-9f78-76384dd6dbb1@gmail.com>
Date: Mon, 19 May 2025 10:03:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 10/11] bundle-uri: avoid using undefined output of
 `sscanf()`
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, johannes.schindelin@gmx.de
References: <694d8e62-486b-43d4-966c-4fa1e5a95061@crinan.ddns.net>
 <20250516134054.217202-1-phillip.wood123@gmail.com>
 <20250516154250.GA26009@coredump.intra.peff.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250516154250.GA26009@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/05/2025 16:42, Jeff King wrote:
> On Fri, May 16, 2025 at 02:40:54PM +0100, Phillip Wood wrote:
> 
>> On 16/05/2025 11:11, Phillip Wood wrote:
>>
>>> I had a similar thought, though to make sure that we parsed 64 bit
>>> values correctly on windows so we'd need something based on strtoumax()
>>> I think.
>>
>> Perhaps something like the diff below which adds strtoul_u64() in a
>> similar vein to strtoul_ui(). I think it's debatable whether we really
>> want to skip leading whitespace so we could perhaps tighten things up
>> by replacing "if (strchr(s, '-'))" with "if (!isdigit(*s))" though
>> that would mean this function would behave slightly differently to
>> strtoul_ui().
> 
> It feels like we would had to have dealt with this before for other
> large values. But poking around at a few obvious suspects (e.g.,
> packSizeLimit), it looks like they are all constrained to "unsigned
> long".

I was surprised by that as well

> So yeah, we probably do need something new. IMHO we should probably have
> repo_config_get_u64() or similar (with the appropriate underlying
> helpers as well) as use it here. But I am happy with any solution.
I think repo_config_get_ulong() and friends all accept a multiplier 
suffix. That makes sense for things like packSizeLimit but here we're 
expecting a bare integer. It probably doesn't really matter but as one 
of the code paths parses a file that comes from the bundle server we 
might want to be as strict as we can be.

> And I do agree that we should consider banning *scanf(). With numeric
> placeholders I don't think they're a security problem (though they are
> easy to get wrnog, as this discussion shows). But using them with "%s"
> should generally be disallowed.
> 
> There is an fscanf() in builtin/gc.c that uses "%s", but it is careful
> to construct a custom format string that limits the string size. Yuck.

Yes that looks pretty horrid

Phillip

> The usual thing in our code base would be to read into a buffer and
> parse from there.
> 
> -Peff

