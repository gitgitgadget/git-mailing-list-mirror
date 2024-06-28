Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821F1E878
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588547; cv=none; b=odfbCi98pYdNEPFpvphSbkGPyZJG1LTwN0hjkxYbRbwzfkeLGYVYxU4YULvgUy7xVxN/81KcArZocQDW+Ox7M9oMzUkWrYGhuufgDWFD54Db7iDeqBtCiGrdrwai+fuQaNcNMP7o1LP9+7b0vRGZZJHxMbVk571t43S9mA430qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588547; c=relaxed/simple;
	bh=Eoxyg0vJz2Al5cfT8fXkCy7xtxWyNYUsgDBXnm8ZmiI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SGt7pnzcoJDyBtqietwztrvClAXu0gQeMA0+VvjvBCaTznn8zIeXHJhUK5Pa+IoxoRCLuTgx03CYTru99HTIFclGid0XYhPU0mihLxpuphIsDIXik4oRHhYxtsnXqagiSL0iSNLta32E6wC/IieDB+X5u24N7rjPJmwaxQS61jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0DvpdNA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0DvpdNA"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a72420e84feso96151166b.0
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719588544; x=1720193344; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4TMWUbuXYfXyN9cIK8xvX7nRZLWpvdLV9XGzWkyozQ=;
        b=P0DvpdNAqpQXolg6OsPLDoXKLf1n9f74mwACGeOJFlwcj4d8JHtXvuYmgSQW+qmGwm
         RPVQ1j8Hp1AD6daa3k5Ih0IfZsWD1YJkkrcK6IdYUOeG6u7wHwllnK0ksfGuxg5vSDr7
         vEjklw+0UPc9LVwQysA/fPYMb85fab7WS91TfyS2nC2VE0W7l0D61jBfmz/dmySk5iyJ
         pp2p+Bu47AwpS96kFNF/Wmo9M0w76TLhulY5n0N0cjqSKvmLPco8F8KNZfa61cMb7EKr
         CP0Yn0Izh5WlMblLAGqP1LaJIEzBWeoe/lUWlwBMe+Utbo276YGSM9xclOqFNALUVTmZ
         tjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719588544; x=1720193344;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b4TMWUbuXYfXyN9cIK8xvX7nRZLWpvdLV9XGzWkyozQ=;
        b=MEYPPR+rzS0RE9DqhYpbwMaHXirzYeyP91c4GOfDGs+XF8IeRhkjkw7bCmyF2xfKKD
         Hl8g4HmT1mH32Z9wZF+wTVj9uKXSqWgioKNoT9Ekat5ogPwVBFYIWV6TPmV4501Pb8DW
         Dd/IYoMg4eV0SsQhKThE/zB7N05LJQ/Uj+78rCWEdETxvgh02Gdk0lEIyLjf0CprkAZ6
         uAMLKnsXpvrF4a8ensKrG+gE/Kf4gsIdPv93GNva7A4qKeVoC5c7S5ayrWDSPAS2pKlW
         zqX802gRV+Jr6JojvAiPmoelIhXIH0HrpEPXjCZP6JztBOw7UUGVnBwDcGute6jt++A5
         o6KQ==
X-Gm-Message-State: AOJu0Yzy1i0Ml2Kb7oOYK09t/odPgS4rCq//U83s9STJtoIzM0ZzBGBm
	C9FfdVxepF3cqYSl9jzCE0ZVi9Zs35LobT3Noq8ehrqiAEgWMIiI0YgN3w==
X-Google-Smtp-Source: AGHT+IGxdw5n4IOYoAeqzhskQ0te7C8P9dogcvZDlwbMueb0w1kCJAT7k2l0oNxBjbxiBmLUH1UUmw==
X-Received: by 2002:a17:906:7055:b0:a6f:53f9:7974 with SMTP id a640c23a62f3a-a7245c80a43mr1276466366b.52.1719588543755;
        Fri, 28 Jun 2024 08:29:03 -0700 (PDT)
Received: from [192.168.21.10] ([5.77.197.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614d50b27sm1167811a12.70.2024.06.28.08.29.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 08:29:03 -0700 (PDT)
Message-ID: <0b92381d-b21f-4d3a-8e68-ad9977a8b45d@gmail.com>
Date: Fri, 28 Jun 2024 19:29:01 +0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Mushegh Khachatryan <mushegh.khachatryan20@gmail.com>
Subject: git init fails because of includeIf configuration
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I have a section of configuration for specific branch in my ~/.gitconfig 
file. It looks like this

```
[includeIf "onbranch:other"]
         path=~/.gitconfig-other
```

In ~/.gitconfig-other I have this (the values are changed)

```
[user]
     email = myemail@email.com
     name = My Name
     signingkey = KEYID

[commit]
     gpgsign = true

[credential]
     username = username
```

I ran `git init` in empty directory.

What did you expect to happen? (Expected behavior)

Initialize repository with or without includeIf configuration section.

What happened instead? (Actual behavior)

```
$ git init
BUG: refs.c:2123: reference backend is unknown
zsh: IOT instruction (core dumped)  git init
```

What's different between what you expected and what actually happened?

I have expected to initialize a new repository but got an error message.

Anything else you want to add:

I ended up commenting includeIf section in my .gitconfig file, 
initialize repository then uncomment that section and use git as usual.
The problem might be related only to `git init`.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.45.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.6.34-1-lts #1 SMP PREEMPT_DYNAMIC Sun, 16 Jun 2024 
14:45:31 +0000 x86_64
compiler info: gnuc: 14.1
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show

