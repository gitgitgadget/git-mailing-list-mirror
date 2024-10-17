Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589F111AD
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178496; cv=none; b=rVZH2EwO9y8CRzBZ9W7HPyfg++wqa78ZppJdJPhQmojUU9fLU0hleRddnhwiQgXMtOdOsFDJLMCdTg6ztuZINJxCncDzN+mKmwkwqcr+XXq6sWEaU6wvY1fm8QMQxpwq5j1OnFld96UbNaD4rcyQv6qGBQxR4463Nu8L16iyjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178496; c=relaxed/simple;
	bh=0aO5iYW593j0Rf5ITDdqAsgF7NLc5QdAsb0Iecf1VPg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=npkuPIvdfghu9tYjHVj3HQ6Nv3YaaCbVrWafRjaBCLDUzjN9At6P7DyLVukwbKYtd1+JDNLtxAHHGDXG8ERglfXguxUj894e5hE+FJ+p/QiPn3lXhaTOizYK3b5t43GU5G9OoMahVgwOs/DVk5OoTrPsHhtiXLjrZlh8ayVongc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZWdCSGU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZWdCSGU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cb47387ceso9334605ad.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 08:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729178494; x=1729783294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aO5iYW593j0Rf5ITDdqAsgF7NLc5QdAsb0Iecf1VPg=;
        b=XZWdCSGU15kI9cfaj+wHhp0V2ycEmy6EX+ehHEywIThJf8FUwJYXkbmb3aEUO294NX
         m2pgfdrhkV+81wvP2DvwP3SOs9IIHxBh1wAEbjJ4akLiA2fQwodHuwCxjJSQWtUai3H/
         L1WmlOst4e7WkDaQjsCdBSYTh815DmZcplgY1wVBmeD6zXpKaSSRRYfDFvulpxDQBJhV
         i8PEZjAgIELBuzqNyLr+Cg326ibSWZkIvv3oK6FSu59cOn0IN1MtOe3P3GJ87X3yIg6z
         w1mvtN1yOVhp0DS2LP1l6y2dvri9UckO34OmMLLlpDLX136ISddJYGIF2FvjvP1foeMM
         oYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729178494; x=1729783294;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0aO5iYW593j0Rf5ITDdqAsgF7NLc5QdAsb0Iecf1VPg=;
        b=oXBVW4SZKa7Pe28kbhmECVU+uQ0vOXrfaUlBjMhT4rrCp+323rudYZDq9uR513YxEM
         XjbwXTmbMcx+gUzsHUNWSidJ1fW5jpJ9pg/+D8knN0vYQpruQtam8TC1F/Ji0DpbhEv0
         xXUcnFu2GX6cXichVLv830G0c4dC9AwEObi6dr1l2lCLDt/097RP2djFTD143dcbDY23
         LkIJ1UH94f8x7r8Aa16Fo/THCB5ExVNfTTX10pykw36wWJ8i4EhOdryxzUqPvB6/72ML
         9PyiznxXyioKwkJwW6KrRgTXUTHNJVXT6KoyqddnffNMQ01A4rL84KbLd5zXtVL/47MD
         erTw==
X-Gm-Message-State: AOJu0YzYnTHvGfolkHkmwQ2alwyo3ooSEF/RN1mhGt9XR99jaQqv8tQq
	WlBuBl+lBLqS8AoeB/ItjlDwORNpk/bDNa+ZSbUQMECS+grNOBNofAIOxDlp
X-Google-Smtp-Source: AGHT+IHLPDlBA6fdscrPKroaYGW6ziQ6GJwSQKA2Ua87AzWxZNBn/hMQ4XRkfeo/zlfxnAmFUa9f2Q==
X-Received: by 2002:a17:903:2304:b0:20c:ab29:8133 with SMTP id d9443c01a7336-20d27ecc7e1mr117547795ad.27.1729178493871;
        Thu, 17 Oct 2024 08:21:33 -0700 (PDT)
Received: from [192.168.0.4] ([49.248.29.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f828c8sm45692915ad.37.2024.10.17.08.21.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 08:21:33 -0700 (PDT)
Message-ID: <bab5a7a9-f006-4a1f-ae38-2dec817c5a82@gmail.com>
Date: Thu, 17 Oct 2024 20:51:29 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Subject: Why is pushing to stash not allowed without an initial commit?
To: git@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I recently ran `git stash push` in a newly initialized repository.

```
$ git init
Initialized empty Git repository in <redacted>/.git/
$ touch a b
$ git add a
$ git stash push a
You do not have the initial commit yet
```


On the other hand, with an initial commit:

```
$ git init
Initialized empty Git repository in <redacted>/.git/
$ touch a b
$ git add a
$ git commit -m a
[master (root-commit) 3bf80c1] a
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
$ git add b
$ git stash
Saved working directory and index state WIP on master: 3bf80c1 a
$ git log --oneline --graph --all
*   293076b (refs/stash) WIP on master: 3bf80c1 a
|\  
| * 64140e0 index on master: 3bf80c1 a
|/  
* 3bf80c1 (HEAD -> master) a
```

I see that the stash commit has two parents: the initial commit and the
commit that actually holds the files that were stashed.

If git were to allow a stash entry with no initial commit, it would have to
create a stash commit with only one parent (i.e. the commit labeled with
'index on <branch>'). I wonder if there is a reason this would be bad and
therefore not allowed?

Thanks.

