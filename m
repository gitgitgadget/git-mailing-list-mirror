Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BD033987
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727634943; cv=none; b=Xq+vk4Mn2/AOZtEfayQaycFbKP+E0taqk2o7uoL1T5g/XWE5nF2ME3IVX3VqdsSLhDw+eZdt1YuvN/8hGt6bH7t0srBnWRpC4ihp02uQzZm2rZ1zsxJZ4424R+BYUY+vhqS+s1GEUMAC0aAV+z3tQlwoIOdMpPeoCRpzT2KL2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727634943; c=relaxed/simple;
	bh=omCtb1U/rjcu31/jN1uZme7MVP+DTsJVPIWvHQOsbG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=jyU5MiV+6Hbh3tmjqzarZtC9MM3FliIc0iRf8SX63h4HbBRdX+X3NbGVSlhMHAtxVr4MKklxPZzOwqP3twT2xrwPQnFOKdRdHGuKFyZSgtnNgKylsn/DK6pGlJG33N6WLDJgIdnc7vO3QUSycbn0YXel1xer59kKx7/U+wUmfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZK6w4Xj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZK6w4Xj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so26613805e9.3
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727634940; x=1728239740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig3N4uAxiu0mORCDRfGLLwW4vScmO2RZ/nMFD+vZtiY=;
        b=RZK6w4Xjt4W+53LPHc8twG1oSRdttPqgR9koI9Qu/rGw2LXH3Fyd/Teoi0Q+KuVpj4
         R+OtfXG6hBf87Pvo8twiEjxtkHttCIz79zzIPd9cau0JsvADIYtiHxiDc1ZfzUDk++6N
         nM8r75vllRgA2MywESBss7sDM1t7wju9UMMC2MgZ8Rb4DJdb07/cR71FWAEI5G9izbLV
         /bp4+tp+8FYhESaFin/Ed4AvjxGFGSsvSO7rr8o4VMl2yDcg8u5EXzJtZVuzwywARsL4
         Afhg+c/RZBVkphGbwo7VnP6hFXNsMJX3/GnSRIZ80qfO4pwoG27N3aXyJ64BXMUYTj1Y
         fCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727634940; x=1728239740;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ig3N4uAxiu0mORCDRfGLLwW4vScmO2RZ/nMFD+vZtiY=;
        b=avu2JbKJdFTfuV5PRfj3vOfEZas2qPcOpWUOcbukmDyznrmqG58PhDtuzMQcQ28iKz
         p8PZGqkL60YfMbMweN97uVO0O5GtYdsqbabfv6ia0+rnXNz75M4e08VxDw7VvZ7Fu7Ci
         ZVqIYiZsQCpfkZO2yLZjUxwo15DXrM4lUAIwG9eLtDrRWmswk7SGrSJEMD740LCKPmTm
         lPFVe4v3TBXuSbMppz9VmuC7VVjCIZyW1TCaZA/V5PXXuFhqQ2Hxrnkudo1AGssDlRD8
         p7XfL5eyJxVVWKwGqfWZOvI95J61lV/VcbKrnel4TnCgwvQe8tN6AMM9E1iQQ1WDyq77
         Wbww==
X-Gm-Message-State: AOJu0YxmzEN0aDYFP8OLZP3EYazfPLtk3AB/zTLfo4yYZCXEtkhxJCPh
	qi6nHWW1gDLoMA67609QzjYv2ZOcDg1brQdwf+WshTGjpbGkDvZV
X-Google-Smtp-Source: AGHT+IFPVKNFujpGRDbIXl9yG6wQQyF5nYMICJlDFe6bIjATnSoiDm7dLBBAf3lnkj1NFJwIHxCs+Q==
X-Received: by 2002:a05:600c:1c9e:b0:42e:8d0d:bca5 with SMTP id 5b1f17b1804b1-42f58409f31mr70599035e9.2.1727634939613;
        Sun, 29 Sep 2024 11:35:39 -0700 (PDT)
Received: from [192.168.1.21] (p57b1438f.dip0.t-ipconnect.de. [87.177.67.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm131210355e9.47.2024.09.29.11.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 11:35:39 -0700 (PDT)
Message-ID: <f72b003b-a3fa-4750-82f2-96402053f56e@gmail.com>
Date: Sun, 29 Sep 2024 20:35:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug in git-gui
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <69e3564e-3314-4a6e-b489-11a96022e08c@gmail.com>
 <67cf0658-f0ee-f141-534c-3081b818545a@gmx.de>
 <d0c95c24-232f-196c-bf19-5f8ee89e246c@gmx.de>
Cc: git@vger.kernel.org
From: Clemens Haffner <c.f.haffner@gmail.com>
In-Reply-To: <d0c95c24-232f-196c-bf19-5f8ee89e246c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Johannes,

you were on the right track:

- if I set the env variable (as a normal Windows Enviroinment variable) to

c:/Program Files/Git/mingw64/bin/git-askpass.exe

the GUI does indeed (almost) work as intended.
Almost, because while git-askpass is running, a console window is open 
in the background. ssh works though.

- however, with the variable set to this, git bash does not work anymore 
(waits infinitely on commands like "git push").
It doesnt even work when set to mingw-style

/c/Program Files/Git/mingw64/bin/git-askpass.exe

- If I start git-gui from within the mingw bash, it does even work 
without the variable set. (The console window still appears though).

So, to fix this git-gui needs to be aware of the enviroinment variable 
when launched through the start menu.

I'm not familiar with the source code, but I guess

git-gui/windows/git-gui.sh

would be the file that is responsible for that.

Greetings,

Clemens

Am 29.09.2024 um 19:44 schrieb Johannes Schindelin:
> Hi Clements,
>
> On Sun, 29 Sep 2024, Johannes Schindelin wrote:
>
>> On Sun, 29 Sep 2024, Clemens Haffner wrote:
>>
>>> I think I found a bug in git-gui on Windows (Windows 10 64 bit)
>>>
>>> git-gui Version 0.21.GITGUI
>>> git Version: 2.44.0.windows.1
>>>
>>> To reproduce: (I have not tested it with rsa keys)
>>>
>>> - Create an ed25519 key with a passphrase (--> .ssh/id_ed25519). Help->Show
>>> ssh key detects that key perfectly and shows the Public key to copy
>>> - Push something to a repository:
>>> --> it will fail.
>>>
>>>>    Pushing to xxx.xxx:clemens/test_repo.git
>>>>    CreateProcessW failed error:193
>>>>    ssh_askpass: posix_spawnp: Unknown error
>>>>    git@git.xxx.xxx: Permission denied (publickey).
>> This might be due to the `SSH_ASKPASS` environment variable pointing to a
>> Unix-style path, but your SSH not being Unix-path-aware.
>>
>> Can you verify that your `SSH_ASKPASS` environment variable is set to
>> `/mingw64/bin/git-askpass.exe`? If so, can you set it to `/c/Program
>> Files/Git/mingw64/bin/git-askpass.exe` instead and try again?
> Oh, make that `c:/Program Files/Git/mingw64/bin/git-askpass.exe`, i.e. a
> Windows-style path but with forward slashes as directory separators.
>
> Ciao,
> Johannes
>
>>>>    fatal: Could not read from remote repository.
>>>>
>>>>    Please make sure you have the correct access rights
>>>>    and the repository exists.
>>> - When using a key without a passphrase, it works perfectly well.
>>> - When using ssh-agent with a key that uses a passphrase, it also works well.
>>>
>>>>    Pushing to git.xxx.xxx:clemens/test_repo.git
>>>>    To git.xxx.xxx:clemens/test_repo.git
>>>>     = [up to date]      rev1 -> rev1
>>>>    updating local tracking ref 'refs/remotes/origin/rev1'
>>>>    Everything up-to-date
>>> this bug must be in git gui, as it works perfectly fine via git bash.
>>>
>>> "git push" spawns a new window, which asks for the passphrase. After entering
>>> the phrase git works as intended.
>>>
>>> It seems to me that the git gui cant spawn that window where it asks for the
>>> key.
>>>
>>> If that helps:
>>> I'm using Microsofts OpenSSH implementation:
>>>
>>>>    $ ssh -V
>>>>    OpenSSH_for_Windows_8.1p1, LibreSSL 3.0.2
>>> Greetings,
>>> Clemens Haffner
>>>
>>>
>>>
>>>
>>>
>>>
