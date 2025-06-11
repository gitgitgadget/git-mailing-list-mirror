Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C2264A6E
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636543; cv=none; b=epeQkdBjb2A2ozLOTO2mGGvx6MVH58OkoVvw+xMCDDzH2/lar5lqdHXG9NLH0z7F5nx1GKgk3y0kpnmPla2TRe9lM04USjpGnBDevgw6AphEIf8dIJXTcoUu87zKCRCBNbtIlRYe+3XjOv4g5muDmbaTNfWDMXEFIrqUC40YbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636543; c=relaxed/simple;
	bh=W8JDl2rSpSS1iZP8evRD/dqsiThPXyOb/UclqIbWQDY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PRCghpoecJXBawvB3FjRVNJ1hAZ0gl3kq84W+7vbquyCXXJyZarLcE055vsyM0/fK+jVj/PlS1tz/zK957+lH37F43YPODYl+QXBZskWUYWd3iyv6h025PdndCX1kX1pClqKB4vLHi8NW51cp3VgA6QH8ewSkOEzlKAzUaWyoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLTJXJgc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLTJXJgc"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso6931935a12.2
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749636541; x=1750241341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W8JDl2rSpSS1iZP8evRD/dqsiThPXyOb/UclqIbWQDY=;
        b=TLTJXJgcazKzkn6ubMHW/OlVO+qayED7Ea96Y2Va8SPdkePnKr6DLNoLuHvKjAfpwR
         34uaELZXjD2SUZcg4kJjn0b9/4disC+Kf4lNI4lgGxkxqEACBQ1tb0mWF6hVOJ6urQGA
         U0LHjMv0h4epWEnF20+1WoigTcRSm/fdhN8Xh0tsq+RX0eaZmGFei9j5OVofzSCfJjuS
         RJkU7Tbrwfj90KOhA5FQ82CBp0ASpkzdvTehcGms+07UT8d1fRzmDbd8DGh+DftmKCia
         y9fhA8BGRfPBshmGWojjSXXWiH26lX8+b/PyBAj+TjC81U8OsVyvJUJGYPPeESJs+E5B
         op1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749636541; x=1750241341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8JDl2rSpSS1iZP8evRD/dqsiThPXyOb/UclqIbWQDY=;
        b=UcIAKC4sWqvxW8OO4fgqESknPUTcprsV5SkWU8Q2sbQcTFarBHoQYFFmWwXixm8gbt
         kheeDfjfF1jeT/sOpuDoDEoxith51WMi7wybOC4nfKRYogbqCpnnUf+uF+v5CmrCcuWX
         /2f5Thg5p/3IlvkOSHiMzAyViOx+nKBSOl4WrYqrKpQv/7eGfNg8jlLaBmm2n1WJeaea
         CvL/cMtU0QHro7Mt2HYfBa/wm1zOvQJVF/dh6fMgbl+mpyQUZEsk4/AK/j22ck/Rky1Z
         +xVgkWEVUjYNLGOHMMCM2/0rgyQZ1iiLqqUUx6M+oyW0DIqv0MdTVMIAfenwyCsCHcfA
         tsOg==
X-Gm-Message-State: AOJu0Yx7Hq8GkMecPI92s/1Ieg5UtqwVuwvbCRe7hWvfRtSSR0LRloxR
	kqkXJr7LwrALmr3gC2KNool+8EB8aqNQ0MvB5p2a5yXjDv0e1Dit2EWsKO8foNLreBnDedRbtnY
	tfxG2cdL2omJiS/f/0UztEGxsmVejxSlrH0gDoxw=
X-Gm-Gg: ASbGnct5SurwQyvlnQF4rBRuQCIOQNdcPIlvNFoAbTxaOxREN3SzOKWfqA2JdyqDgfY
	/WYuYhgmG9n6OutTYiPazpX8h26AxZcMj2fa+lugzRVGgyuq6nYgsWSmE1comujskcUEa0fS4Q4
	eMAILSOEOqWVL8moy2fWYkGrmocQYGE4aI92ILVRuaNm4V
X-Google-Smtp-Source: AGHT+IEeqEU+zjfLjuPh4UGyUe/vNJOcCbuW5095P3VRbp/qoSc1Qs8rDyR+bYauQT+Ren1CkomH3AK7ZfUTsDZW3NA=
X-Received: by 2002:a17:90b:1dcf:b0:311:d28a:73ef with SMTP id
 98e67ed59e1d1-313b1ef5898mr3120429a91.10.1749636530526; Wed, 11 Jun 2025
 03:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Meet Soni <meetsoni3017@gmail.com>
Date: Wed, 11 Jun 2025 15:38:38 +0530
X-Gm-Features: AX0GCFu_MxVoyFuYhCSfmRbd2soP3JXLxUhzO8-2lsnS7xmsPJqZxVHaQjlJIw8
Message-ID: <CAPhwyn36MjrW6SsSaDo3S9rrrNGOqURcQrsKFukU-sUwyZwx6g@mail.gmail.com>
Subject: [GSoC] Blog: Consolidate ref-related functionality into git-refs
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, shejialuo <shejialuo@gmail.com>, 
	karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm participating in Google Summer of Code 2025 with the project
"Consolidate ref-related
functionality into git-refs". I=E2=80=99ll be sharing my blog updates here =
on
the mailing list so the community can follow along and provide
feedback.

You can find all my blog posts here:
https://inosmeet.github.io/posts/

The first post is already up and covers the first week of the project:
https://inosmeet.github.io/posts/gsoc25/gsoc25_week1/

I'll continue updating the blog throughout the summer. Feedback,
suggestions, and questions are very welcome!

Thanks,
Meet
