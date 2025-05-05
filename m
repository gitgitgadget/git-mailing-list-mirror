Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0113AA53
	for <git@vger.kernel.org>; Mon,  5 May 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452471; cv=none; b=sTxe26Dt/wdRoRaV++03MQWHtJZNMlhY0S6oPct6yXXUW8jJz/nKgL/d24l32UG7wHVUfb9jjuDygf8Dv94xFMi9T6RMeANrCWnOSEJR9tvgAgMTKlWmMRYxE29sVudLKKnH7fZUf+wGFxZ2CcH7+RkWBheJphI+aBFlBeXQvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452471; c=relaxed/simple;
	bh=RXbraGh4xuCqtwsNWRrd/uwuIPhPEP4GM7kOj9VNIRw=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=CeDIlWOiCnItgXScU54ihQU6x3tcAmRWgnBQuJJ0w9ZF0VcykcQELeCYYUkBxyux8Zg1+BBe0VzS/cneiPtqp2Pccn8lz4W1S8t21z2HuXRVX4FUj2akvvA8mw90dX1iWaJX30sqPgtmJ/SxvJFFVZ9nLk82Meggk5laRGXDikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coRJckEl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coRJckEl"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acb2faa9f55so587245766b.3
        for <git@vger.kernel.org>; Mon, 05 May 2025 06:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746452468; x=1747057268; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iApBQQ1ibKjxhRGDxGECFy/aU2GFayvwJYG6OE8liMo=;
        b=coRJckElKcU9shHjtaZczAsN/8AOwPp+sWZW6GIYXr3oFvwg8lBbiAXPErXh+XRwsB
         n75y9kV22IJmR5tFnTM7ZnaA4XLp5ajkb+5VS3qVz4zTYBKHnXIm+yTKndUVx2FIHLTH
         Eviv9szhDUlAI4lZGZmnAp/leVsuBC0GoY69nmup9rV4Z8SjjwXlhnqw4+M9UlUMxosO
         EHKwSNjIRz/OdwihVKfpk1XOBGly1XJa+KKG/wZ84ZypxBU6vhKs4RjFoaS6phvwYLw1
         kBGB0Mmn9rDjEEIEc2lmNgZPSVM2gXjY1ItmJ+DKc0icLmfK6Zr3gt/0Q05vMdu2iR8z
         eICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746452468; x=1747057268;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iApBQQ1ibKjxhRGDxGECFy/aU2GFayvwJYG6OE8liMo=;
        b=Mkd5cR9zkFVgkB5KKUdDDN8PNLHNVhJ5BA1+Si8dSjEhEvA7igLx7zjKxo6NBvTn5z
         CaeszqeYAdiP1oRCs3r56ckPWOvJwK7fWIyKD8V7Uq5vZLSfnWCDgjiVaoKKHY+5aPK5
         Qdl26q/YVXLwmvaUJGx7EnKT0DR37FfBiRL708QSQROgM9M72yCq65TCrHQ71mV/18V7
         OhseA8AXMoGze3xUtd2XAOkOCJffBPZBFzAunHvZVs3Y4foigE3gbA0BtmtU6x9IjmDV
         nY/J0+tey1LH+yDomTbbnZacTwRroHyUW1u6dmRhigxj9iixhZ525uqNFENTaz1bG0HR
         i+xg==
X-Gm-Message-State: AOJu0YzLN8pj6i46RYrcO/80Fhvbboc3F+1yZUxJ1ULmcBnLxbvjHFL0
	gIn5GgosjMu1XR2HXjaN0AU5K2BN4egUrSHNYVvBK7lu6poHISscuZOZnQ==
X-Gm-Gg: ASbGnct6o5vLMsaP/JJGCpcJbpd/xjAsacbclxWLuHcUsSDrHkWCUNUF389q2wjwok9
	h51bwA6RRnA0uWvKk+lSoqRPLQiCIgnIgKkWfd2onfDOjoJmUvWVjW5vdTFBwGdzTcziLXvFdIY
	Di1Nx9KEp+dLnrC6Hk9LtSBbE0b7iwCoBEoDgluRXr/VnBg7LPS8wLB2G8NViE3fZhtYzdkfXrw
	FSd4FzpFlgdaoqV+IJJWQGhbd5Q/Y/C4hDxOTqElnc8eymT8muzaM2QbytSTRFDkaCJ93/osJcy
	r2dqIsYCHpaNtdwonAYRkHpDZfQMCBiVGA/QZJog4KJ3AUBcrvWgm5n/wfLQH77h1e7VPoxr0ka
	MY29xzicEbkzsbx1Dzfar4FN/FgnC7I4=
X-Google-Smtp-Source: AGHT+IHVCqmkMgwR9eMu0xdwGTHrHG0el73PZssQRUk0+EvsZ2CAgCVFRAaYVKq3Tu2HioxBqhHeag==
X-Received: by 2002:a17:907:86a2:b0:abf:4da0:28e3 with SMTP id a640c23a62f3a-ad1a490f050mr767503866b.18.1746452467824;
        Mon, 05 May 2025 06:41:07 -0700 (PDT)
Received: from [192.168.2.101] (dslb-084-056-099-033.084.056.pools.vodafone-ip.de. [84.56.99.33])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad1891a2bd8sm500666266b.57.2025.05.05.06.41.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 06:41:07 -0700 (PDT)
Message-ID: <5b8e60ba-b05b-4389-8c06-88c143ceee10@gmail.com>
Date: Mon, 5 May 2025 15:41:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: mlell08@gmail.com
Content-Language: en-US
To: git@vger.kernel.org
Subject: Bug Report: git submodule overwrites submodules of same name but
 different path
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear list,

I have encountered a problem with git submodule add that leads to info 
of a submodule being lost if another submodule of the same name is 
added. This can happen if a submodule has existed on the path in an 
earlier commit but has been moved (git mv edits path= in .gitmodules but 
not the submodule name, probably to avoid moving the corresponding 
folder in .git/modules)

Find below the summary from "git bugreport" (Answers in English).

Best wishes,
Moritz



# What did you do to reproduce the error


git init parent
cd parent
git commit --allow-empty -m "initial commit"
git init child
git -C child commit --allow-empty -m "initial commit"
git submodule add https://example.com/child.git	child
git commit -m "Add submodule child"

git mv child child_old
git commit -m "Move child to child_old"

git init child
git -C child commit --allow-empty -m "initial commit"
git submodule add https://example.com/child2.git child
git commit -m "Add an new submodule at child/"

cat .gitmodules


# What did you expect to happen

I expect that both submodules have entries in the .gitmodules file.
Git submodule names are given by the path, so I expected some way
of resolving ambiguity, for example, git appends ".path" in other
cases to disambiguate. So the expected .gitmodules content would
be

[submodule "child"]
	path = child_old
	url = https://example.com/child.git
[submodule "child.path"]
	path = child
	url = https://example.com/child2.git

# What happened instead

I see that there is only one entry in .gitmodules listing the
new submodule, under the name "child":

[submodule "child"]
	path = child
	url = https://example.com/child2.git

# How is this different from the expected result

The old submodule (path = child_old) is not listed, the information 
about the origin of the old subrepo is lost.



[System Info]
git Version:
git version 2.49.0
cpu: x86_64
built from commit: 683c54c999c301c2cd6f715c411407c413b1d84e
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.12.1
OpenSSL: OpenSSL 3.4.1 11 Feb 2025
zlib: 1.3.1
uname: Linux 6.14.3-arch1-1 #1 SMP PREEMPT_DYNAMIC Sun, 20 Apr 2025 
12:38:52 +0000 x86_64
Compiler Info: gnuc: 14.2
libc Info: glibc: 2.41
$SHELL (typically, interactive shell): /bin/bash


[Active Hooks]

