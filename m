Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B5138E
	for <git@vger.kernel.org>; Sat, 25 May 2024 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716675076; cv=none; b=IMBqZ2WYUnaYF1UekJSnwCbbElfbyDTcSV8+hDd1lbx2oP234VNrJoJfWKj8BAUKFQSNQVa1ypxka6PhOxD0IEDe3yZNxzGNiMqdBUFEDTmmcafdSYtXdS7nNlonbP3UF+8QMkOsay0Qu6SKMY6XFcIuypi8ofdVV0o38mJ9ppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716675076; c=relaxed/simple;
	bh=iyfuJTWJ8Twm6js0y9SIx8ClPrQKoTmS6nfLphveXu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A4xKX+GFVSV+b41hr2i4bD1M+ToF7ArLnkHe856zlAO7u3b/sdvgTddcqlIHqXGUhkPoQZrhuQfheZ9xBhDb8rNmRBnu4b50Ekn+WHLg6WGm59/7B631RaLXqSUoB1aDkcb9p4nhh2xM1r9gRhRLX3/d/nUGqXhe38o+sDDjhEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiWl4gNh; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiWl4gNh"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9b74043b1so4878481b6e.1
        for <git@vger.kernel.org>; Sat, 25 May 2024 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716675074; x=1717279874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UUai6cb6SKKw6049bpwCSM7gIKS64gYDgJRBYmC/yN0=;
        b=hiWl4gNhCojhyhMq1vmN4cnIUE1cOO8i7sDx64Exq8hC4z+NrKJIvQNzzJqbSHpoUw
         1ITcOriINbbyLrkWjk91UxAE7A9yc210I/snJYdma+rkHzbr56WvYErXDo1GR5I2pn0q
         s/C5sSxUk+CDO3lvYxCE/j3FrNxrpc96wY01rvkeqle3K4skQ7M+TBCGv2ChGKKkQR2w
         0N1y6bbbhog/8YnOQM+pPTRs4beu9hc/D7rjlGRAu3EDlPM49V70wrIhLKAPSUICOrh8
         n1lfBIqeHVq8eZ01zdujfe+l9kB/pyvMutHq1oXChMCied/VgNAvRxdSkBjoEa6NHIJZ
         gFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716675074; x=1717279874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUai6cb6SKKw6049bpwCSM7gIKS64gYDgJRBYmC/yN0=;
        b=oZin7PVShiPGc7JhGpDriE1QpZ+Rk5piRAqGbUXs5xSKK9cMd8nZrpsAB9kCCEE55R
         EuoNWPw2NYIJ53LbG69r/Ny8NoG8lI5hUIb8b4WxzzdX+XHfYzy0fzdzrl0HAGZoFz+F
         RdxcdIerMQZYRl0IVf4NC6ds+G+PsHlWV4YUpesm5exyKVzQGtVgJbC5ebnKgiCYyYOs
         KZzMFqCFgZHSmWXOsw1IVR6/ghTpzkbUGy7BrLmQYmP6OXLfEXImtCXEL22HLVd8nvUK
         M0KEvRtvl1snXCu046qI8Jxxym+KlfO+5n3BOG0dBmV+duQJyVEmHG26HUa1nXpbrZXy
         ZFeg==
X-Forwarded-Encrypted: i=1; AJvYcCVitglv3ZnRnTW5RNkWge9zUllyM68Ty12aurXpyeA28lbLnMo/2GUdgIEnvk8aNMXnD5aoxEKZ2j8Bu7Q4r+w6KNrk
X-Gm-Message-State: AOJu0YwnypIedoxra3PVuvLnQX5PkT8+OdR5N09FkaZkctL8bWHHIT/b
	2AafBlsRykRvYabm4381veS1J8NX1n8BrXv+RYZ4qS+BQipsW4dY16vP1Q==
X-Google-Smtp-Source: AGHT+IFl4iwJh0ArqcbIkCPDspsKtUA7yXkhyCsQXBw/5tVFUk1pYxotdfD1JzlLKrPgWZ/kNxerbg==
X-Received: by 2002:a05:6808:2128:b0:3c9:6dc9:a532 with SMTP id 5614622812f47-3d1a538c765mr7296410b6e.10.1716675073826;
        Sat, 25 May 2024 15:11:13 -0700 (PDT)
Received: from [192.168.0.100] ([66.7.95.216])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070dc622sm20382246d6.31.2024.05.25.15.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 15:11:13 -0700 (PDT)
Message-ID: <eecf9177-2557-4af3-a660-6eec63ca854b@gmail.com>
Date: Sat, 25 May 2024 18:11:12 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git "safe directory" not working correctly
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <CAHa7PX8THmTAYFVwAtjimgcenUPC4A5BF2OHExC82Cnrdtbn=g@mail.gmail.com>
 <CAHa7PX_JwsvADE0Xv9AW--5ZgAChwQTWrqNSGhwWbuabk5_PKQ@mail.gmail.com>
 <ZlJaXfLc5fvBl4UK@tapette.crustytoothpaste.net>
Content-Language: en-US
From: William Ruppel <wcruppel@gmail.com>
In-Reply-To: <ZlJaXfLc5fvBl4UK@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Brian, makes perfect sense. Yes, I was using good ol' Windows 
cmd.exe. So, there is no bug here.

On 05/25/2024 5:38 PM, brian m. carlson wrote:
> On 2024-05-25 at 20:22:38, William Ruppel wrote:
>> FYI, I discovered that the issue appears to be related to the single
>> quotes. If I do this instead, then all repos are considered safe:
>>
>> git config --global --add safe.directory *
>>
>> And in a similar vein, to whitelist just the single repo I was having
>> an issue with, git itself  says the command should be:
>>
>> "
>> To add an exception for this directory, call:
>>          git config --global --add safe.directory '\\bill\gitmaster\Src'
>> "
>>
>> But, again, the single quotes don't allow this to work.
>>
>> All the examples I've seen use single quotes. Has something regressed
>> w.r.t. to how single quotes are handled?
> The examples are given for a POSIX shell, where single quotes prevent
> any interpolation or escaping, and double quotes permit interpolation.
> You're running on Windows, probably with CMD or PowerShell, where single
> quotes don't work and would probably be interpreted as part of the
> argument, leading to the `safe.directory` value being `'*'`, not `*`.
>
> Note that at a POSIX shell, not quoting the asterisk will result in it
> being expanded to all files in the current directory, which is why
> quoting is necessary.
>
> If you use Git Bash, then using single quotes is correct.  Otherwise,
> you may need to use double quotes or read the documentation for your
> shell to determine how to properly quote things.  (I don't use Windows,
> so I can't say what the proper syntax is.)  Git itself doesn't
> necessarily know what the shell used to invoke it is (very especially on
> Windows, where SHELL will not be set), so it provides the default POSIX
> command.
