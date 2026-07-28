Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15443F0AC
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245473; cv=none; b=Mh0p0Jc8ulQns6t4yjbBsKMAu/rh1KyaKGkrpPW1Qb1kMYR+xXFHGdGIfMYBgU3z0+PoLMSTghk8qJtuUZedD8/kCaV2O2imWwI/ufv6kZYMe7eI4ADkh3IL3C1VdYto3sQEbTNahAKUpbOiIKCsD9doPh2uy8uGUVVSoabLcKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245473; c=relaxed/simple;
	bh=YRAriakaGk4mceJg1vGXWCmn/usKRS8iUj4ELFr+8bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UxuIv7KtYtOBI85ssekL6G/st93zWsQrw21n1Gn/0GjkN+OGGVVRf0m2gG3UWJQfSeCmryA+Uz+qvFMHwEG+lAE/yQj6N1zaOmOHsTFQ8loCXHMGxEgB4asAxl6bS9zc6gebuGK2+8/R1A2ik5rsz+wcAbr/BrudYHfZ89XUmas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFwsHV2Z; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFwsHV2Z"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a01bc6a0e7so2274142a12.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785245465; x=1785850265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ILaIetJRpc+PsIC9dpfxXzQqdXM0j8gkX6+iqU9ulLs=;
        b=iFwsHV2ZHahghTsnt2+ZyQAVKuyPmgX3rHNxnm3jyBwOhwJ0q2esVBtbfaQxRj5pIx
         DhL7oL4D4zMNLwChkMImVocf+e/xyvpxmnlsaWtd8J47ArySITPE2XlY6eh9N6IQoK/p
         OW2dwDEqxXg1pS8/YKbMb0RJZ7R0gSGR9S/p75aWTYk62lfb1O+jRYro6VsDOyoXAMmG
         0dvVgI+Aa7151xPFxTyM74fk3Qct1GJiIrzZx4oWhzZE9AlVjN4Hrx8+N8EBUeukL6JV
         WXB7puaG1MfiKiy8F4j3EsbRoipYcXtzLjKRk3V52tYxVHyekEgMs7syv5k4Q3eMdxN1
         dulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785245465; x=1785850265;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ILaIetJRpc+PsIC9dpfxXzQqdXM0j8gkX6+iqU9ulLs=;
        b=qSu+Kh2txZy8kQhQLZ053g8HtV8EcXMTk84FuxwPb7d84ZqDnThZykj6yx0/ipW4HU
         PYU03xdWMmIRLqku5pU+o/B+oITQeI+egDPF1o22xjkhOpjCLy2jqQ5pLiqB8TvTy4/e
         ncvQfRK4kMFSW1AH9sIsI3rXrdY5XFOhxtWLDs8eRSnjVMc5YLk9RaTkPXevnbahtJ4h
         Rf3AgkQjAgfaXhpBeEm7RUUk7GXQIhA0JriWeui7dXvGIcn+dHalnAhgnpbHBXVsggsA
         HhI6aCweVW7BShwVBFeDQgREUbyz8dXA1Q3MwQBQ4qDlnfVmCifjxOuS99jzrfn4wase
         08XQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIl7HIxKE6FTDnYFBonwQi9xfLbqOufVGiBXwlt0m8Q3dE9pLzKu5BQ/sd033afIj9wfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRYQmAgJFdjHMpDpZIGAg3PgZYm+MZF0TurllYM+ICkWD+I7r
	kkP+ni0uMkXeGuAcuwYk7gcjlMmb341DCZpyuLlDUHBKxySbQkMLjWSB
X-Gm-Gg: AR+sD13D0SRXo2L/3cT3Td0kpUHlOFR2gNYSDsK9+McJS+bAQhj9Sw2NvOp1Fb6WfkE
	hTZX97qs6TDC56+x4kBAH2BPzwqtoD5gBjx2kNngafT58BeTczFGNhlrsE0sAa2vnewhfn8zeCQ
	8dJML6jl/O2vg5o3hOgW+VWIx0+x2o3fzwRbE+qUi6gOKbLXoz6mtuXN5kGlHCpwn3CmCzMTmIU
	8Wh/BHQ9KjHXtiUHK92GTuKb3RJgnvvgyTbmVKGAeFRpv4NxoV0Z9vpPTOZ2TL36IcMKZnzhW9w
	IXOKrVQ9T8eE86hg1kh/j8MqB0jf5ChZJVOZEiriXTkn8wbQTJZJFeAJwjNYBi48Aj5pumYuG7Q
	jjQZIbn8lq+IAJhZwSkMDm5YEfepDfA6m9tTYZrZJt+k/jCgiMf4q9dkIg2j9/mxKTxJmY3eToR
	bS+MHfkdAxgK8mBUPGRsRcucAA7cwW6fji+107hTFjTthgh0TZWS+zKAcF
X-Received: by 2002:a05:6402:24c8:b0:697:ecb4:b86c with SMTP id 4fb4d7f45d1cf-6a034a0b240mr952999a12.2.1785245465080;
        Tue, 28 Jul 2026 06:31:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb50bd30fsm4162486a12.5.2026.07.28.06.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 06:31:04 -0700 (PDT)
Message-ID: <758dbec3-7657-4342-8b74-7e59cdf88b5e@gmail.com>
Date: Tue, 28 Jul 2026 14:31:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Failing tests with WITH_BREAKING_CHANGES
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <amf76F4wxlboLz_A@fruit.crustytoothpaste.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <amf76F4wxlboLz_A@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

On 28/07/2026 01:46, brian m. carlson wrote:
> I have the following in `config.mak`:
> 
> ----
> DEVELOPER=1
> CC=clang
> GENERATE_COMPILATION_DATABASE=yes
> WITH_RUST=1
> USE_ASCIIDOCTOR=1
> WITH_BREAKING_CHANGES=1
> ----
> 
> In this configuration, I've noticed some tests failing:
> 
> ----
> t0014-alias.sh                                   (Wstat: 256 (exited 1) Tests: 23 Failed: 2)
>    Failed tests:  4, 8
>    Non-zero exit status: 1
> t1517-outside-repo.sh                            (Wstat: 256 (exited 1) Tests: 404 Failed: 2)
>    Failed tests:  248-249
>    Non-zero exit status: 1
> ----

I find t1517 fails quite often for me due to cruft from a previous build 
when a different branch was checked out. I wonder if there is a command 
that is no-longer built by WITH_BREAKING_CHANGES whose executable still 
exists in the build directory from a previous build. Its not clear to me 
why the alias tests might be failing though.

Thanks

Phillip

> These don't occur if I remove `WITH_BREAKING_CHANGES=1`, so they appear
> to be related to that option.  However, I know we have a CI job for that
> case, so it's unclear to me why these tests are failing; perhaps the CI
> job is not testing what we think it's testing.
> 
> I noticed this because I plan to send out a series soon based on that
> option and obviously I want to run the testsuite first.

