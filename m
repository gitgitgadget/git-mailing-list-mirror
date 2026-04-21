Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E561632DD
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771482; cv=none; b=dTiQmfzjb9XNw5QErU68VCoTtouyZcX1G9l5iTPwvrXJlVLYVkfABxU58j4XS/ragQG3j2mh1pUZIvckriHKHZqJ8GQ3/mshSSiEJZBWXSNMBHVClW21SiLoPHONHZeAyPM1zweyI6Heh/Kq5sVEUDkLTY1yfM3yA5M6np3h5S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771482; c=relaxed/simple;
	bh=OM8oesdUXIl6yXKl4Qb61Uu6xAYB1AXL0igZsYY41yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nY4Hs9V+NzwZ/l92/sqAAUUegeEz3IBEII0uDxwjrlVQJKbFiIX0I2zhx1UX0f9hkNuXsvdXgsMfSL4CvnUYN4Z38SJiRnoPrkf0yKdr/ug9rPJ/ARm5chdvTasYiQrgc1PSL3RD0FPu/PZ0VPzeMrmyznS79UJSNBhurtu81sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9JzCjp3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9JzCjp3"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so3398666f8f.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776771479; x=1777376279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9C6DRNT693FfKQgMSXXOKJzZVAHHCn2ph5m/ZfKAEUE=;
        b=q9JzCjp3R2w9D+64cXSktWchkHkVwFBBZO3FwG70F4OvZsRB84UVz3bsKzlXQwu4g/
         VPvyhICOl5rDS0WO4o9x0tw2hBsz+kvDczsCzHKGe9A520uC5AQ0apdeLnZFGRDgmnVU
         V9ruRFCsVmqhPf42F2RqR5x8cvWYWLGSvib4xDO7eIyeqsMKYhy2xiIJRr3LZFLMOLai
         jGqgRpFba6tDbxDC0ldKlRRit7pbxfdDuXk8H48xWApSWQ8j8x6bxkI4oTQVwu/mO18D
         L8y7xIfEmvNeFTMQukGq9eenihYyvqruD83qtl72hu28ipzYYLLye4n71zuU86dsSyQY
         PVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776771479; x=1777376279;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C6DRNT693FfKQgMSXXOKJzZVAHHCn2ph5m/ZfKAEUE=;
        b=q+Cl3CWqMupSZJ6o5CSIBVe3kBbICw94dyFi3TqQnmqGTMP7HN6i0bMdRWV8S1phzH
         Ld4tiwmhV2khM/LfFE5jbcKwB8Dp+Ry3+cwIM/owGQFbSAyrpKyqrSM4M36G9aoRd01J
         6RWzK6DKODuaCWVwlvXCCcuzwhmMpSGa8t3EbKACw9ybWp0GWehzPMjX+IxXrklxpMqy
         duUUKVTXr/bcigDgQXTFEYg54JQ5lGyG4iaJ7ifq7ET4gT1P43gftG+My5sujKEcWmQz
         vIbLPAp9rHrvG/+92M067wyXUkKjljDmPgRH9bSOi7SNT+lZ26PklsSsFq9AtqDP0IQg
         pAMg==
X-Forwarded-Encrypted: i=1; AFNElJ8aHzRBlG1NCKwONcS5YEKp+w8vYSNLWNfLtRd2Xuk3VJUS5EtuCmGQV+hMZKGD2wNsK8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTc+UsMSUtda7qWdb8su9glB2YgGO0Q+R8XOisCOERBJ80qnz
	cjLEFahREo9DVEUggqN3m25Wf7WYnbEfa2YTmJEYBqzLb9lgodQDMsKQQVFZTA==
X-Gm-Gg: AeBDiesZXgprs83NkiupFXnpMJZF1pxg3TbkQY6wML9rEBsSCP+ewyiWsXc3X7JqKpU
	q/ysoR6gPRQJhbPoMf1dn3FTJ+WCfZwSNCIttEQnHLUVQ5di8LciFHHPvv44GSqlAUTtYEO6QvK
	x45K/rxbs2rqPqCNtTveslLXR7I0DUt2fZ8ozpMJNDe3soHmBdt/InaJpolxkz+hXT2yoos8F7F
	eKX5CeF5uvhgSJqv6BpaGrH03XuNnrtZP5Z/hVf7GB42/AVrJvtLoLPA+kyGnMS8KZidq2ilu8n
	+AQDIxwJ88g7VLB8SJZOOM0uPlvbQ2K9MTbN7eq23ssl8KwXhxhzaSMfBwExK885E7jCUEaOjTe
	HoNUrmc2GSF1Pi4Of61qrmKnTGLSH2oCRc0WccScRUL+HOkWtT1WhNIgBaMe4QdAEcy9GrgXDe8
	cjodFzz/P62xTCpi4Sjow/ENgQ+0/nOA/mC0BDKlNjmHSESkbkKuK5v9y7IBEl8R+GraOcMW2hg
	WhegBvlUw7a6tVmrce/AhIiWiQ+msXMamR+GhObQw==
X-Received: by 2002:a05:6000:2389:b0:43f:e272:edff with SMTP id ffacd0b85a97d-43fe3db29e0mr28681174f8f.4.1776771478958;
        Tue, 21 Apr 2026 04:37:58 -0700 (PDT)
Received: from ?IPV6:2001:778:e27f:a23:36c4:e19f:3c1:8a8? ([2001:778:e27f:a23:36c4:e19f:3c1:8a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm34556582f8f.22.2026.04.21.04.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 04:37:58 -0700 (PDT)
Message-ID: <2d5b37b0-3442-42f8-81f4-18b48e95a617@gmail.com>
Date: Tue, 21 Apr 2026 14:37:56 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] git-credential-libsecret writes secret to stdout on store
To: Lutz-Christian Quander <lcq@wateringcan.de>, git@vger.kernel.org
References: <b7b6b94c-7e42-42a5-95e5-d44a54d6da0f@wateringcan.de>
Content-Language: en-US, lt-LT
From: =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Autocrypt: addr=grawity@gmail.com; keydata=
 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
 aETxZy4lQ+jpsbG/q9fvS/sAZA==
In-Reply-To: <b7b6b94c-7e42-42a5-95e5-d44a54d6da0f@wateringcan.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/04/2026 14.03, Lutz-Christian Quander wrote:
> The documented pattern for seeding credentials non-interactively is:
>
>     printf "protocol=...\nhost=...\nusername=...\npassword=...\n\n" | 
> git-credential-<helper> store
>
> Running this at a terminal prints the secret into scrollback.
> Running it in a shell script whose stdout goes to a log file
> persists the secret in that log. Running it in CI captures the
> secret in the pipeline artefact. Every real-world use of the
> documented pattern is affected.
>
> Severity is moderate: the leak requires the user to run a legitimate
> command -- no attacker-controlled input path -- but the leak happens
> on the "correct" documented workflow, silently, with exit code 0.

Is it actually the correct documented workflow? I couldn't find it in 
the Git docs. My understanding was that writing to "git credential 
approve" was the sole user interface, while "git-credential-<helper> 
store" was the internal interface between the git-credential builtin and 
the helper.

