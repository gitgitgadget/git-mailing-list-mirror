Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892A47DF8B
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054560; cv=pass; b=KKSM6wZwhNVXuK7pQny/YESGTyxnevaeEK1R7JoHajpfoF/S+eK7IaLEdH4+lUuPPEc5qqcU4X7rPSGN8sizptPR3ZeYgBI4px2Ci8eNIYy7c15ju3fthayaWKnHQa62RZVnhWm8onNiTKGID5lX9JgRiD46tpqOCiO3bsCpUjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054560; c=relaxed/simple;
	bh=0kmdK7XjQY9eZAwd4yhhsj3+2xXiokaq2HrQefmKodA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpfMDo0terKdarqydpJ+7s9BTFNXYy5/VQ2i0pNUl59WHCPIc5KUUkFI7lofadM7By6JZEIPAoVIvpZGS11dN/VZ7xwkup/MDzTkDD9A1oK4fU0PetI98+1FBddag2p/vHuM2NqxYPFmQQu2mpLw7c6MER2ZNa9F0q4dMfTDFIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg1JNH7b; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg1JNH7b"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a46ebe2beso34520627b3.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 07:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775054558; cv=none;
        d=google.com; s=arc-20240605;
        b=Ly8GFtncD0VtKI+f+ciLdQfM1xspLKBlZh85xnjUQlb8XdZaHk0wVnB4nZunzzVtRv
         mls2ys22lCYDdba2LYTNhuMDy5E80kd1GNi9/UcgUHHVOp26V3deYwUQrueUSM5FmTIP
         XIDivltOpiOqz6K8AR70MF4LkQyPpB73RkKeft41fSPdbi7XIoYRXaZiJYxoebC5gX/s
         Lllfgv4n0ebMeB/ZlZcgy3Z8Wx6VLjh1rJ//GICX8WUyxvI5dMWa093XPniVVfZAEN/y
         URyh8Dn1qVI8NOo755M8xH+0X47zMdVF0Q970r8A38ifL/dIrCA7lWZAW5nh0Y5jpOPv
         dQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7QW6H2h9sQdlINk5F1ioR4IlZs+hWYa9l3u692u4rTI=;
        fh=y/qf+YGnRMXksQUvBuMy5CTPTIor5n4e0nzastFOUtk=;
        b=IYQ1fBcHUPNpquFQYTROeC/U4KELVkbKS5WuLgCHAfMCwgTSeZ/0Ci2e8megds+77A
         sg9o9dUC99429ZbalRBpXnITqS3HuabaijPz71H5qwTfNLcMmwUFZTtxzLs0QuvyPTsh
         Iv8wztHst1ecEz2bNiQm/sZVbe2V7NRWv1Xo1XSKcnZmmvo4O6fwCCsIDv9RkxkImDD+
         IkARP6rVCXRMgN9LeEr2dAkYj+dHH3+RQUzbYVNzDeRGa0mXMSSjWZBK1zzA4+/6o2Np
         mA2twsiENVnCooKvMbhS0/JvmsSCfS+gr9yPWQazOfo0wa/eui8jfrufH/GVGCaBN17S
         fjnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775054558; x=1775659358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QW6H2h9sQdlINk5F1ioR4IlZs+hWYa9l3u692u4rTI=;
        b=fg1JNH7byA9OSdbHTGopimO4i7MGRmQ67dQoFEfbL/QE+6s5XcVp+6VAuLZxcIod7Z
         rs1XgTdcmRnDQfPKE0W/H7dNjeAm3HTysDM8pwEP0Z2yux2JXjwf+/Up3sRz04HCPsC0
         mQxQe0eDikecPJ6z2wQbObeh6NhgHVRnavVLH41QvsSBUeSA11qDh0rpyuqekeKlApsD
         VBkMyWowCQlX0kEuVMU+h6zg+Dq4/CTOO+oTNXncNlWtBWeAY5/E9QPeLv7nvF8lu3e+
         +Kz5bIWHmjLpu/9D3FT4wnzmQkmh5xbMoNVmRQWIe80HbOjd+I2YHPe8SiYCtviR97FZ
         b6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054558; x=1775659358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QW6H2h9sQdlINk5F1ioR4IlZs+hWYa9l3u692u4rTI=;
        b=I0S4XzqAS/QonQ3wfJ2pQ1Gb3dgMZMitpz8fthY5ik/zO/zaAoezrw2sWaBiae4h7M
         f9c604B1tdqUHe0mZsU4eM0WOZ6wNpqFfShHtN/GZW0QxMB3AywTTiG/IOoNsmPkQJOS
         kBoj8N1CS/jAVVyIvOXb0ZXqb+ozEgffc07tPpwkUg+xLCWG/MMuDvEtYg5/CWVmYxIN
         yY2GAcXPMGx6MxhcnOU2Z58fvLXDaPiI7vXHbydnA0eMqKEcPJN5/z6yotb8s0OmFCWx
         UwGj+UtN0GI3IOGFKA8e4Kdiylbsg/IU+SjnM2VWhW8W3jcF8zjyHN059afQ/IqYpUli
         6A3A==
X-Forwarded-Encrypted: i=1; AJvYcCWzoHN1ixZH440xzX6F4EZ9r2HByMoQ9L0bAQC5iPThgl6p4sFb3mBjLed2fulGSdKaPk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHK69EGQcOooC13PckTDAfYaLq26mO8IO+XW5aqktobLOPUflM
	Lo1aIjjXyE6bR9vqiuYw6LS1hIkAg3pVrcJHMi+0y/jJ+bmMIwXdYrdqZgBehVkx5fS8vk4B8Bn
	DXPvWryeKSMx6zlu3+M0jwl4zO43SV/Q=
X-Gm-Gg: ATEYQzz979uPR01S1ghe/1WnDQQwH0hZTR3BUqCm921xf7zvy+7025qngY5awmU4NGF
	rPF4lJlPpkFsI8AbN3+MvvwVbsCASPJm0AttjDE+Laag1L84zqim/yPe6vzgSG6RGc2fjs2glJ3
	P2RzspsI1XrP7gX843j9NN8fUKch7cyaKalNgkUqIpyUjJMGvbbQDahZQr6S20kKJ7XT4dElzsH
	ri4jlPEY3gzyxXYl9oPh8U+O5Co2qspoJUDjR6rHxqmW+/nFjyT1gfs9Zmcby4MCthZNwTwpvZT
	1HRIvjG+xJDNVXJNQIr54pq2TK6Z0+8dy/Jb2rghjPuc4P8WdaSLfgcI5WkbaxMurBcZXg5d5zG
	HiuWVNKptg6Ho7DBU3vrNDQ==
X-Received: by 2002:a05:690c:6f11:b0:79a:c40d:b734 with SMTP id
 00721157ae682-7a212636809mr43541427b3.48.1775054558248; Wed, 01 Apr 2026
 07:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
 <20260328001113.1275291-1-pabloosabaterr@gmail.com> <bdff0a5d-b738-4053-9b72-08eba88156de@kdbg.org>
In-Reply-To: <bdff0a5d-b738-4053-9b72-08eba88156de@kdbg.org>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 1 Apr 2026 16:42:26 +0200
X-Gm-Features: AQROBzAIPA-sefmdXY1vuKpgFE4u4CsOc2Mvr8xe8s_jfGucx532h6xmAeVqB7I
Message-ID: <CAN5EUNR_yfkv_hC4wg-nHNg=3FnkYdvFm6FcOUNG2A=MdGs7ZQ@mail.gmail.com>
Subject: Re: [GSoC PATCH v6 0/3] graph: add --graph-lane-limit option
To: Johannes Sixt <j6t@kdbg.org>
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com, gitster@pobox.com, szeder.dev@gmail.com, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mi=C3=A9, 1 abr 2026 a las 10:36, Johannes Sixt (<j6t@kdbg.org>) escribi=
=C3=B3:
>
> Am 28.03.26 um 01:11 schrieb Pablo Sabater:
> > Repositories that have many active branches at the same time produce
> > wide graphs. A lane consists of two columns, the edge and the space
> > padding, each branch takes a lane in the graph and there is no way
> > to limit how many can be shown.
> >
> > The limit is a horizontal truncation, each lane is cut at the lane limi=
t:
> >
> >   Without --graph-lane-limit:
> >
> >   *   7_M1
> >   |\
> >   | * 7_E
> >   * | 7_C
> >   | | *   7_M2
> >   | | |\
> >   | | | * 7_H
> >   | | |/
> >   | |/|
> >   | * | 7_D
> >   | | * 7_G
> >   | | * 7_F
> >   | |/
> >   |/|
> >   * | 7_B
> >   |/
> >   * 7_A
> >
> >   With --graph-lane-limit=3D1:
> >
> >   *   7_M1
> >   |\
> >   | * 7_E
> >   * ~ 7_C
> >   | ~ 7_M2
> >   | ~ 7_H
> >   | ~
> >   | ~
> >   | * 7_D
> >   | ~ 7_G
> >   | ~ 7_F
> >   | ~
> >   |/~
> >   * ~ 7_B
> >   |/
> >   * 7_A
>
> After seeing this example, my first reaction was that this
> --graph-lane-limit option would not be useful for me. The relationship
> among the commits is apparently obfuscated to such a degree that the
> graph is not a lot better than a plain listing without --graph.
>
> But then I tried on a few real-world examples, and the result turned out
> to be a lot better. The commits (asterisks) typically occur in the
> left-most lanes, and the lanes to the right are usually just connections
> without commits. This makes it more practical to just truncate the graph
> part, i.e., hide the connecting lanes.
>
> In conclusion, I regard the way the option works as useful, even though
> it is not the way of truncation I had envisioned originally.

Thanks for testing it on real-world examples and I'm happy that it
seems more useful than expected.

While working on this I spent most of the time with graph.c and
I got to understand well how the rendering engine works. I think
I have an idea about how to tackle the column rearrangement
like gitk, which I believe is what you thought it was about at the
start (and the
TODO that's been on graph.c for 16 years c12172d2ea).

FWIW, I'd like to send an RFC about the column rearrangement
because it would be better overall, no information is lost, you can
still limit the number of visible columns which would replace this
in most cases (only scenario I can think of where you still
want to keep the truncation would be if you want to keep the
branches going straight vertically).

I'd like to hold this series and send the RFC with the idea for the
rearrangement. If it ends up not being viable I would come back
here and add a 4th patch to remove the extra padding lines
(merge and collapsing lines truncated) to make it more useful
making the graph more compact vertically as well.

I'm sorry if this ends up not being merged and I've wasted your time.

>
> I discovered a small glitch, though. If you download today's gitk
> repository https://github.com/j6t/gitk.git, run
>
>   git log --graph --oneline --decorate --boundary \
>      --graph-lane-limit=3D4 465f03869ae11acd0..origin/j6t-testing
>
> (j6t-testing is a volatile branch and is 86848fe40b60ae58f today).
> Scroll down to line 166 and you see the '~' at the wrong place:
>
> | | * | ~ 9f0d1c2 gitk: sanitize 'exec' arguments: simple cases
> | | * | ~ 6eb797f gitk: have callers of diffcmd supply pipe symbol...
> | | * | ~ b966b73 gitk: treat file names beginning with "|" as...
> * | | | ~ 0c8be6f Merge branch 'ah/fix-open-with-stdin'
> |\| | |~           <-- this is line 166
> | * | | ~ 8e3070a (...) gitk: encode arguments correctly with "open"
> * | | | ~ bfb0fa7 Merge branch 'top-panel-search-highlight' of ...
> |\ \ \ \~
> | * | | ~ 9cad4a9 gitk: do not hard-code color of search results...
>
> I haven't tried to find out what is going wrong here or to simplify the
> reproducer.

IIRC there's one place where the ~ padding comes from if it's in an uneven
column, I think it might be what's failing. Thanks.

>
> -- Hannes
>

I'm still new to Git and even though I've read the documentation
I may have missed something, if something about what
I'm saying to do (The RFC, holding this) is wrong please let me know.

Thanks for the feedback and the reviews,
Pablo.
