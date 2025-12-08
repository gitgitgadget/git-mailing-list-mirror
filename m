Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D252F744A
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765204250; cv=none; b=sJ1zyxKX3er82fljRPveC+3tWcjt8oYkmn24R5j913MXPtpgtbD9Xr4WIu9iLWZQHoHhQd6AWHG2eRtL0orHy9DHMN1dWnLbEJJBD9pQsGCyMGE/Nig/TihGI8A2kjRfe853lQxfJoAGUomW3s+ke2UgNCJ89yYRX4fv6MHZMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765204250; c=relaxed/simple;
	bh=xUWYpy0YPYlH+Zu9+27f8aW3ujfJz8ZMGhP+kvGAjGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mw/XbyETU7BvHMHVP9mP3IaUg79uh5CInzS8EYZBr7qBOO2zFPufT+msoMgsTryUdCoCeMs9lfen9QhAi6z2JERIhAQAnhQla8vQSNEaxAAhswFLYLsDyQjY1XKrMQYubv+cr9z/ao3W7kMOD1RM5HMgPBdh3ZsavRbuF8j4R2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9AyywBw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9AyywBw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso37419205e9.2
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 06:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765204246; x=1765809046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AyJ4AiAen+GA4JdAYPFddPHJruVFHidcAipWA7HVCG0=;
        b=D9AyywBw674YUpzQKrUMuF0Pp0UyIPjj3CXWvlhX08NIzQiV7J5xEeKr5yYvQl4XE3
         CsYm8IHtCe126vkk62yltr62mmP1GsX24BzMppKmjGWNiIk4ud4yMRG6M7WUFTA6d/pw
         APvmWY2eA0+cGxDAanYIbnecrMaTcKFoF/PGPl1XFxhvRmEXdSwlbsF6UbZfyery/Wg/
         K0O25zFoRi2+rs6f6KvnCxQBf19wAoXTQDqjOj3GfE6c7amMVDR+vkJ+OMhUTb5NqaUv
         45Bvmqo9njOGuQ6zyn+NW7AKNBGqkVPaRyte9FPWXxtuzwnYF7H9389qZPrYhv3jIl+L
         6fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765204246; x=1765809046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyJ4AiAen+GA4JdAYPFddPHJruVFHidcAipWA7HVCG0=;
        b=TAD39DPRiDXWXIF6AfMCJfs+cbxFbzWCwMGeZuyyEVrY/udlIOulLwohkCG6HX+ghO
         AAcQOnQATy8501nrxTtbdy1rndxB5W/xnT0xh1NslBLC3deyhvxOAqcA5xFVir8cYi11
         I5mkglGz5UdvDMxv7Nb13N79rRDzWVdrKeRnDYg6KtQI0+cP+pH+BVIl/d75nDde0r3d
         2IPb4SKC5HqwNHStu9rPfn3y9AJfQ9VUtnF2ftSqP6htUO0PKtwfUSuIZs13hlV7gPS7
         xLKRmcQZxZwBGLVwgwv+JVS1caEfjZTZtWGQ3qR7zw/t1kLYYIaNo8pyOHkpnYb1bT9v
         DMng==
X-Forwarded-Encrypted: i=1; AJvYcCU6SqFKuEnWfHmkDEBPPNPVUb+0/emI6GHWWxO2bHnveGiWFRI8NZ1Bd5tgrGlVKJ+pqhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kSKkQ0x4gQoQ+3e0H/LQKjjHmBAJwCkFk2FnB7WcMaAgK4cr
	b+8QHY2CscGL9J3Fj3b3YePjR/WTtLKl/wagzqlQzMqrTZDn6nsfp0d2Uw13Xg==
X-Gm-Gg: ASbGncvnZMIgpbhoMHEp+Dax45k8jZHZzLVXTFgMXYA/Paj2h2XqGfifTbX27z7cnS0
	aBFw5+Z61epF3MC/E95RkT/tC4BsGxDJrU4ITcqiSpLQyGcjQczuKP2EBTDeNyg+TIBqFl3QeVT
	LBsgeILT2NzQEfGrInDLfMW5oHPIVc2+DbTi4JjRMemKkSh6g/AAetX5aEFlLOhio1qaSc89qK4
	0H+WJ2Dv7klOkIIrZLVNDHJMqJRAju+GZwk8cwfWau4vfRdOi+Kf8NoApeWcWN6xUIzN9bXgMCR
	olCDALEmz/Gvkj4W2xsIfYhatO+JC4l0EfKhpB21XfOMuEevydePamxwy3iXt8Ub/l4Nv3Kj59w
	wAqUxd/G+6eQSVd73Ak6TIMw6VGAiETi9HRwpdWhx78hugg/URyZDZgxI4Z/e2VZFyj2x3c8K9N
	Isb5Ao+AszwrPSxjJc14rU6hHcWpHMAurJBUL84zzde0uymjoosLTSwsX/08ub8dU=
X-Google-Smtp-Source: AGHT+IElmnM/k0JJCNm9Xj2a6EVj1REWsMBD+nuigWCiSg/z3OdSgMlxXeZyeewv/ETuiOQ5hi9cuw==
X-Received: by 2002:a05:6000:2c0a:b0:42b:3023:66a6 with SMTP id ffacd0b85a97d-42f89f48593mr7616033f8f.40.1765204246330;
        Mon, 08 Dec 2025 06:30:46 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f8bsm26279565f8f.43.2025.12.08.06.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 06:30:45 -0800 (PST)
Message-ID: <04cc0cc0-155e-422e-b723-b1115c918087@gmail.com>
Date: Mon, 8 Dec 2025 14:30:44 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
To: Kartik Agaram <ak@akkartik.com>, git@vger.kernel.org
References: <896e4e13-5d2f-4c5c-ac32-2927dbff91a0@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <896e4e13-5d2f-4c5c-ac32-2927dbff91a0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kartik


On 07/12/2025 21:55, Kartik Agaram wrote:

Thanks for the easy reproducer

> 7. Create commit 3 in working directory A and try unsuccessfully to push it.
> 
>    cd ../A
>    echo c > c
>    git add .
>    git commit -m 'commit 3'
>    git push> > This throws an error when pushing to hub, but successfully pushes to 
mirror.

"git push" updates refs/remotes/origin/master when pushing to "mirror".

> 8. Try to fix the problem:
> 
>    git pull --rebase

"git pull" tries to find the fork point between origin/master and master 
which is the tip of master because "git push" just updated origin/master 
to point to the same commit as master.

Unfortunately I'm not sure there is an easy way to fix this. For now I'd 
recommend doing

	git fetch && git rebase --no-fork-point

instead of running "git pull --rebase". We should perhaps add a 
"--no-fork-point" option to "git pull" as this isn't the first time that 
the fork-point has caused problems [1]. There was a patch to do that at 
[2] but it was lacking tests.

Thanks

Phillip

[1] 
https://lore.kernel.org/git/6bebcee9-1315-4ec3-a49b-d767f0f67bf7@gmail.com/
[2] 
https://lore.kernel.org/git/06beff46-cdaf-91c8-e6a3-6557694af618@gmail.com/
