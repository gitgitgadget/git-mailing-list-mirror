Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E37E1
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029532; cv=none; b=IowXbNo0ocJgthiVBH1dCUU+1TyfyovxBm6NZa4/LBsL1D6jwFmMGbB5E9IALR3SpW3lyrrm+yaPfg0J2KL1/l2DL4FNgvlwhG1i9ZBHqto0iixQkBOlfuynQABWKVsiwXXKXp5X8siM6gKLoNSGu+6laqKWW/bps0xqBA2n4bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029532; c=relaxed/simple;
	bh=DoLwRL8nzSvsNNdwSlB+VwrSpYoXd0yCFCNnV0ziMZo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lBbit2J6E/k5ZQysE3VSyv+4dBwk+I2DO1dK4WPeDUvX28CJBhVPAIo1exnCQyqwClVYY/kLyINGmK3HMdtcm785N5tPNwk9vv20mKgjR0Dsnh9XdTs8iQs6VmvXwEd2D3HCy0Gra2K0fvVRBb91ERpWvGAbw+Nia7jnIBYag/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJas1tV1; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJas1tV1"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52dbcd398f9so156542e0c.0
        for <git@vger.kernel.org>; Fri, 23 May 2025 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748029530; x=1748634330; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE4jl+uH/mQfMcIjQZzY7iA48V0awJjfBTVpq/1Kk5Q=;
        b=WJas1tV1l0wxcizOsCXJNLJYigG8DYOw+sAUNbT7HjiXjo5tenZI6ay55ePmpFJFoR
         wI0vW5fH3UpTu7VFE5FwPdJypEjOV8yPag3RpEa0vH46vmlOgK2ZljD6K06EwZ7nap0g
         xxfK97LHDvxCfm+Ci8WZpbZcpOhzsWDLm6RfutKOW3/64AuKKuZhT/fPD0fP6dzf7AHT
         R3v6nRCsh3y8/HndLzgDk/WsV1HU5vIGczWq4p16fjMGyYyYSDY2DllXeA2aAo0mYqw7
         FYe0Et/7eWohMRHN2fGpXNw/SV2fqsORCXAZWctu3nJG9SowNSzC7HYxUEGa96Xa3/Ok
         qYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748029530; x=1748634330;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE4jl+uH/mQfMcIjQZzY7iA48V0awJjfBTVpq/1Kk5Q=;
        b=bpZZdUHoa4Fc2zcmQ8HnIIrymaj5yCbeJgAoPv1KGhbQiKYu0ohme5dTTLlGSDgXPt
         2/F9xjTi6+Y4ArTUZn5Dj50fVx2wYRp4AqyATFcBx0cZSnNjRP47BbJA011TWVMOBrOK
         zSiEbx6NMTLB7NvAiwQ3uAf9gcu7v0f1PngeA56CqXyxSDlDB+1BVFrQqx5XPV6a0Z8R
         PfaTBuWn+sUoixWmr44t/jxFKGGSOtgt5nTjnvHlX/JU1WXLY48zOo/FIysruOkBKx3h
         LAv+gdemzSznoxozgSX0kbCLeo3lU0n0sNKLB9v+oljZYJoKD+YkXDNht6hPn1C8KpMJ
         vQOQ==
X-Gm-Message-State: AOJu0YyjAZba5SEqKJN++2W1ry2WijL1qNfNEbJtReGlpVsx6LRs7+Ge
	1gT7Y23DSESevc76KOdry3X+ruKQWz+pPp2iPGyXzWfKm3CsWhldvQHpJEmUwOC+
X-Gm-Gg: ASbGnctcdVPUm8SF/0UpFKTOgW1DMRnZuiG6vDKbv5/sM+7xeWbgW8e0uafyJFcSkRp
	580ys/+EsCFTq70doZfo0mRy25MXALsjDBL1WdW+GRznCWfFK5tQ1Qh8sab3H5eVK3hjdO3lOZ7
	NKMBi9xw8HCs6Cl5WjMGuVqrrqr1WLmei626HGbyDM022FLexHD594LGNH3/m8agg2sAYD+2TwT
	PaoT7hUbvZY0BCZDCiYY2+ZVI4TwTN0RKVCKkPhPr4LZUbKXWym95fVdKky3eKM4hCurXcpfEea
	3bO6mrDqTwi44c9BpykBbTISfufJ3PhB3801rqrgGOdteAOnvbcddmEVbzZCN8VOiNkJoKeOZe+
	k4xmN
X-Google-Smtp-Source: AGHT+IFpS59c69lVchLt2vfjk4ANDSuJNAPQwSKNJCCJY0BmdahIq1+FgS6XjqwYq4jvWmLkLTr8Pg==
X-Received: by 2002:a05:6122:488f:b0:52d:d4cf:5754 with SMTP id 71dfb90a1353d-52f1ebd2b74mr5441566e0c.0.1748029529927;
        Fri, 23 May 2025 12:45:29 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec027524sm12709467241.0.2025.05.23.12.45.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 May 2025 12:45:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: =?utf-8?Q?Re=3A_=5BRFC=5D_git-ghost=3A_preserve_=E2=80=9Cwhy?=
 =?utf-8?Q?=E2=80=9D_on_deleted_lines?=
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAOc+UT0n9pRGur0d4cORU0SMQY-PNs5ekLd=LX9xc940Og+nrQ@mail.gmail.com>
Date: Fri, 23 May 2025 16:45:15 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F0F0FF5-85D8-48E8-B056-F71F56AEB915@gmail.com>
References: <CAOc+UT0n9pRGur0d4cORU0SMQY-PNs5ekLd=LX9xc940Og+nrQ@mail.gmail.com>
To: Max Rhodin <max@ux.se>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Hi,

Hi, Max!

> I hate losing the why behind a deleted line.
>=20
> When you drop code in a review, being able to attach a brief comment
> to that line would save a lot of head-scratching.

Sorry if I misunderstood you, but I can't see the difference of that
to committing empty lines + giving a meaningful commit message.

> Git-ghost =E2=80=93 see the remnants of days past in a file.
>=20
> git-ghost hooks into commit to stash deleted lines in a `.ghost` file
> and enables maintainers to prompt for a short reason. Later you can =
run:
>=20
>    git ghost view <file>
>=20
> to see what vanished and why. Blame also becomes easier.

I still don't see the difference of that to git log -- <file>. I
understand that git blame doesn't show what has been deleted, only what
is new and what has changed. But ok, git blame has it's limitations of
being a quick line-wise inspection tool, while more deeper analysis
would require more powerful tools. It looks to me that git log with
some flags would do what you need.

