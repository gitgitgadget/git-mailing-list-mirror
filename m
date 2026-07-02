Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7213C342A
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978556; cv=none; b=nRUOQkFYWAe8T6E6+UHWM3fwwBLZtmZKqs2U2pHifEbyjLIhn812Us7kNmuuCiRw0yCb4dud7MeZQz0V0rg0Whs/ILfaL1bdWyXpbLbH+MpzcY/WE4gLIccwzPzBkYTIXZW8guOWSM/7HvUoabbrHDqczKesqCiESH/Y783Jxco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978556; c=relaxed/simple;
	bh=f3T595LO3V8t5J2eZiJiBE8vduw4LwMyOIx+DC8gRZI=;
	h=Date:From:Message-ID:To:Subject:MIME-Version:Content-Type; b=FFSKHpDJ5bjSpYlw2n5CdMnQcRQgFyiVNw6maUX8lk2Z5wkrE9GvlI5I51+5OwQNICXy/5UchYnZsIUoCbM4aE9oOMU2p/4UYA3TmHZAwXiPcMNDQx7ESGom0VPqEpNsf3YHAjjwihwkJJOV6EcMw/YrZCj/dIVlCr1ZTRverDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnDkbIkg; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnDkbIkg"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39b1026e171so16292371fa.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782978553; x=1783583353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:to:message-id:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlXFLCqcOuVQfMYxbICaO8n/rUIqFANDjxkNq+jO980=;
        b=FnDkbIkgI9Mtis7mAaricKHYaK7yh/2d9F/yWrqxVeXtsI9XIve6P6Tll9BvZ0FNNG
         2bMEyeFQANouekudZ++2c/wYqBTK0GDQx2fPcYdhqll2ZjKFygdOmKSMrXgGyi/rus5u
         m80sy/nrf6kr2/tOCDjjFGovhZFTWt5ygmT9uCyCkg9/8G4Ln12Xo/jN1XLxXHhs6U6e
         T3WvX/kcOrDbHLKgy2cUpXU98RPbUske5vfw978rnX/IIYWRItj1KRZRxdgv6gR7yWmR
         0EDVvl7MenCCjpQ5MBzwhi1A75OPufVMvxppwTJOjwAWEH5lRPfkogrA+GYYR812+m7e
         6Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782978553; x=1783583353;
        h=content-transfer-encoding:mime-version:subject:to:message-id:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlXFLCqcOuVQfMYxbICaO8n/rUIqFANDjxkNq+jO980=;
        b=iLmno3/avRqNfGx9EZrw+iex5w0FtUz2t+wrLM4deIKSDxZ2S1ysRwKGcjifnTRM46
         HQZ873azrOqCYyfEfGQSPFtx0RMcxjIGMC+DmS6JmYHLRHsHB03w7SYHh6Gws3QmLVfY
         KEVMgbZUF02koRfjFlatB1ZhETnydhRNqHwjDAzyTzdZMJx3vsblNAneHNac53+9kPqG
         HVeqXg/LxB1pQjbWwFUblgMqklwDisF78XjTzPl/WfSkf6GbW+bYdur7s1fNyDI6/kLh
         +xwWjutAiXrR5a2ETk4s22mTt8iDh0wdK25WHPjKvLmGLvUiBSvD2uXyZm6xntpYzJ5B
         zWBg==
X-Gm-Message-State: AOJu0YwMyiguvK4nC1jTr9wzNC1u8iEwVwe9pxGSTrSDKmE48hBTzIOS
	Jrb/vTCHdAbaeDcYhbZa+B+VosMp5zYlgqlC+eCN1ztF+g+QbKVNMvWoGm+akw==
X-Gm-Gg: AfdE7ckc5qzVYez53ZJ9ZKX47fLAdSViD/2FqdC0jzzHjWFUKEGmSP6J8fzdzhbbIaB
	vgfPQ2svVJgFSlS8PtQaXWCFWfZoGNH5/aS4qSmf+E2MJQT3zHuSmxQV5sbfLxxE2OP6/PtrJi7
	n2FCfC7R+TRhkr5CqP93UKWRKrbCBlcYW5zbQhR/ZWvImLFwjXw9qOh8pCJyqnBMXumvgTLjSME
	tvckINc1rF19Nmt+98aOQ5jG4uzCEntgVbh4r0VtFghbOSpy+h6yE7EUdMV/gSIVL8j2tbff0bD
	PxG1cebnU7mVZRYhj7FZJxW3DWYaz61M263byBBmMcxNDjt9sF/3BfVVk+rWT2UgzG4LXnxMRF3
	rnRPeVXQvyOy0UUPP2TJKVRoC0JGMkW7Q96d2wt9UMC3kDY1A0LJcdsctZIrZklOiazkEx1EsVP
	rQbD1dIL9DF8PsXQoOEPI5+iTgKWb/v54AOr+kQINUgGeptlrKq2Cgm1aYkOc=
X-Received: by 2002:a05:651c:2204:b0:39b:224f:93a1 with SMTP id 38308e7fff4ca-39b36fa31c8mr9560001fa.38.1782978552864;
        Thu, 02 Jul 2026 00:49:12 -0700 (PDT)
Received: from host.docker.internal ([83.149.249.84])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b37fc341asm4813801fa.24.2026.07.02.00.49.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2026 00:49:12 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:49:10 +0300
From: =?windows-1251?B?xeLj5e3o6SDP6+jx6ujt?= <eugene.pliskin@gmail.com>
Message-ID: <323134122.20260702104910@gmail.com>
To: git@vger.kernel.org
Subject: Unexpected recursion in 'git rm'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable

Hello.

The following git command does recurse directories as contrary to the refer=
ence (https://git-scm.com/docs/git-rm):

    git rm -n *.json

Without directory specification before '*.json' this command is not expecte=
d to recurse directories, but it really does.

git version 2.55.0.windows.1

--=20
Regards,
Eugene Pliskin                          mailto:eugene.pliskin@gmail.com

