Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6C79CD
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771795755; cv=none; b=Vn5R0+NZTwWU0Sj/i8OOltH07eIzliQl4sx3AzKZt8fjtVyLVMKVU5rMLWMd26d/gtb/4xsdaMV438YFoRCj/POnMozR8CkeWe0L/XScxTZADjnwLqbEhWoPGzAA9BlOKDMlNwXiJfFRSclpv2HO402yLfhgqF1ZrVxVqxggy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771795755; c=relaxed/simple;
	bh=FoxFi80Ct7MW2oassqvM6csLlbDR2Jw3wyzJKW8d2zQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Eb2fT+KYexGSVYxmzXpP9aZBYbDT0UZQcJ16xEZUDuCxfi2qwDfn988HjsMokvArHRSL2KEnMUX3AVp5DyJka5c5Rlm3I8AfEU+3BCgoNw/3iNaDI86kDGIJO/ciQiuP6+54qZzyheC95eytQRAfNJl5L9MRHn2wP45wfAvZmo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntPszeht; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntPszeht"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5674f3e80edso3342670e0c.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 13:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771795753; x=1772400553; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoxFi80Ct7MW2oassqvM6csLlbDR2Jw3wyzJKW8d2zQ=;
        b=ntPszehtqWhC4+V0F2vtn/x7tZIDi6ZPoH6seyFIbRnEUo8dH1HWeWBjcAUkQDCUS6
         ba0+iG1PGofxDdYa1517JWlcTWjslXjzErbzTW3cLgMirjC7/+JgV6nbKcXGVaStQBWj
         JkcA8tZczcLcK1rz2oURfC1Hn1/yoTYcfZr6tZxV+UssO/BBMC6hVuzQpt0Axqwgzba+
         cjatUfo7SBX9PJunp9xHLJ2bpKu6HMP3FdWluAn91jqOJU1WaFvreVa8Z0NRlkScqI+S
         3qWJxVllImrfb/zXqN+tCzxQAhG+xZZJKeE2m9agqgPELEHOv5hxHRBu1XIyKOGd0Q91
         Mu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771795753; x=1772400553;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoxFi80Ct7MW2oassqvM6csLlbDR2Jw3wyzJKW8d2zQ=;
        b=rekLcAaZ79d4t2nOA3QARXDdnEcrhljgAV6R+QBjKXK0aTw48PH7pZ7Wus792H5Sr9
         OHwHc7CyvPaI0aak7Ee41yjbziw2Ghhcu8JwdGb2qaa13ZcP/byGq1v1pA9Pgtb9UYQA
         zim8Jvrar2vvRSWHsDtK/lVeWNQhYHNJARQt0QAlqXKzqx8QVZalNrY+Gixcran/f5pf
         i7VudwvXhrW+Pa/TuomD5vJtoF8yvR5knsqiC5+iyhoWF2IEh/IG8FmQgAk6OH/9WkxE
         o412eWvQKcN7vXa9ncIwuKIdAC+PPP2D3QqzSZfd18GqbnoaLXeL8LpDZfkCNFhjHsFN
         jtzA==
X-Gm-Message-State: AOJu0YwB9syWrRjjCksvnxTpfuMBJ5tQyM4JUOKkZ5dgtrA4j3u0dJuC
	Z22pIjXulCYF0DV24Vs3N2PUYSnGCclV5QMX860eFZP6we5mY52KK42d
X-Gm-Gg: AZuq6aLIisveN+sgXKpnV2Vz1qejavWD77hkN7dB9qUOK+rp2rwIB8EWPNvnjIMOrAX
	ZCGYB54lYjc4blZILTOS2tkG6cijBFx/0Vd5Guu3GtoAFlmRw5e/wGINhjFBQEv2751caxG1ORT
	CMJ6tm0mIgA/1QPiGLSSzxv524Lob8uw3/TOSCu9/7kvb5GM+n2iKBuClKF+kLtXaywuqQA1+b2
	ay25/8s3mPRxnVfZ+CkFwy9p72lQZ9z5wwPSioi2LNcG7bmclUPrOGJI2BoyIWORHFvOiuXwlx/
	KPWlMZ+EA3XnfcJodj5WyqSqoqyoVnwWwFv/iEMr8g2ptiZRV8P5VrOKoImHgdVHuwxEbVX8iss
	PmPKkq4FuFopqoNZouclb7Er3F0p4sTyelxA/ZevfQqM+6C51XeZmzBUUuiFAEK+D9kJOziR/Ys
	aokyLX/yQvt/t/WlMYn/QXVVXXpsrtbg8V2AzLg0PUZj/qrXHVjTmoGA==
X-Received: by 2002:a05:6102:3588:b0:5f5:259b:66e1 with SMTP id ada2fe7eead31-5fe90aba011mr7140197137.3.1771795753304;
        Sun, 22 Feb 2026 13:29:13 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8996314sm5365262241.2.2026.02.22.13.29.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Feb 2026 13:29:13 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [GSoC] Lambert Presentation
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAHU-3nJVDmdU9FGiPTxR=rL7nZEC3K=0Xyc5gAZNCRYrQMG4uQ@mail.gmail.com>
Date: Sun, 22 Feb 2026 18:28:58 -0300
Cc: git@vger.kernel.org,
 christian.couder@gmail.com,
 karthik nayak <karthik.188@gmail.com>,
 jltobler@gmail.com,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <826B22F7-E1D9-4070-B15D-01780C752BF7@gmail.com>
References: <CAHU-3nJVDmdU9FGiPTxR=rL7nZEC3K=0Xyc5gAZNCRYrQMG4uQ@mail.gmail.com>
To: Lambert Duclos <lambertddg@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> Hi everyone,

Hi, Lambert!

> - Submitted my first patch using GitGitGadget:
> https://github.com/gitgitgadget/git/pull/2049

Even though it's ok to send patches through GitGitGadget, your patches
will be reviewed through the Git mailing list. This way, it would be
better to reference the message sent by GitGitGadget rather than the
pull request. In this case, the message is this:
pull.2049.git.1771694893208.gitgitgadget@gmail.com

> I=E2=80=99m really excited to keep contributing and to learn more =
about the
> process. Please let me know what you think would be a good next step
> for me.

Take a look at the General Application Information [1]. You can send
other patches that you find relevant and join the discussions on the
mailing lists.

I'm one of the GSoC'25 alumni, and you can see in my blog what I did
before I was accepted [2]. You can also take a look on the other
GSoC alumni and see what they did to have other ideas.

You can also send the draft of your GSoC proposal to see if you are
going in the right direction.

[1] https://git.github.io/General-Application-Information/
[2] https://lucasoshiro.github.io/gsoc-en/
[3] https://git.github.io/GSoC-Participants/=
