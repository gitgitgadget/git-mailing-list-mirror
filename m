Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24DF7082F
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734574766; cv=none; b=CRHvWzbYb1Dwth0L/Q43yKUK/vlptF3bQ1tIEKX42EQJBRcEd9Qvl1NzkQG2R9/XZqVxgwQUYAuMu0yl+8fhq+lZtMTEYhKs2uoq4FBClRYE/m0ENWdYdECHP2cTVUn8ZEzUQSvaiHGXDW1NatiLkl0z/Fl0AqbiS2dhRkDB7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734574766; c=relaxed/simple;
	bh=tYPwpJzFI+T9DlfyCA75osa1BEA1j8oh4T04bPsIk7M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tSYMmxsn9FWBzfzX8luRGMgcMwKiytzjLjziDL09uoYf4Xudpjl4e7QSslyx2WNS9eowg9qW/Hnw14XPaHlKT1iMhnJNkGxuobn+EKAxGp3TXOBg/pm9hQF8yvO2z6TZwKOqkC/o9sJtd+EhS1bul9yJedeApPwmC0Nj9bNh100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdqIXTZ5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdqIXTZ5"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso193867a91.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 18:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734574764; x=1735179564; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xXegRzjRGQh0lOdVflLaA3K/+aMfcxthIg2FGS9ee5c=;
        b=kdqIXTZ5SE5SJfNk2ZY8Q6A4Bl9WZ2jGC38U0wmQ9LBfK13vaiwC2mtLqhGWXlcvHL
         s42taUVC+BFcXV+WPweyfxXChZQlh7003HwiYv4qHv9w3rxw5QZktZz+wJIDQuT8pDi8
         1E7Bxji6yM4xXZ2SzGoDS0R/yDZvdJFsaPSFj2xYXUrPSNYlXLG1TNqd/FSlfgayTs/8
         1rqru72iheShaxvf/JXCO0gvHrFaQxF6uy/EFeqilkTx5oZxNTCKUj81DfrVNmbt8s7I
         2y5/8IXFfpU3xM1Tvs97pUDejCJweUjJyYyw1NEJSL2CjSSlL7LMDrONS4g1OlJ0wYK8
         jCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734574764; x=1735179564;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXegRzjRGQh0lOdVflLaA3K/+aMfcxthIg2FGS9ee5c=;
        b=jph9YO/VcIX6Nt4LlK8eNGak5H4CcYNyl7c759efn/233wNlLCFZAvui6kOmK6+CFI
         RPfo8NUM52ax6+vzIv4g1ElCfscNQfgUSpSSym3xLcRPBz8+AfCnfOfP8QqWSj9uu+B2
         56wbBXWWn0yUtCv5pX5E9Dg7EngmrWk9qKCQFb1LXZgkq2XgrGyVlJjIMiL5yKZftVQO
         1QAlYqc8i6FddbHGlZK1tY/dqqsW8JGAh8Yd+0eEKgMKV6/XxlIu/8HthturLODSZmZQ
         SlDd6t2iIo1bPKkPP/ujbLadL/CDb3VfhYr2fTZWL7BaLaRh7Di0lXd5GK3ZGYFjc9uS
         7LjA==
X-Gm-Message-State: AOJu0YzaCfNnPRhIDp7btflwvLdL5SJcCvr4bRK7Jbx2TK+p4djOKzkt
	gmTzQl10VR/+ygkqD/y4IgAmwIzOa9SSBT7yqeVyVo9vcDgs4LRHn91rAYykxY4HHZ5PIloJKa2
	qRE528HDP4hhv/BJ9Mh1cyeaqgvrR2Rxi
X-Gm-Gg: ASbGncv+waC/ukHIRsNzBaea+vTO14CskRXRJyjQvMvNv5zuxqL/eqs0oLs8x9+73qR
	fBw5yFeMyvnjp0sIaoa6DakYBR9qRMuFY87Poxg==
X-Google-Smtp-Source: AGHT+IGr0maWzjbnt6wWN5OkxVRiVIndByBWdtg9cYqX3uM5yHkHqVPT/elQ1FXMrZ6NZDii/ui8n/E/Qc4QSYpFK4E=
X-Received: by 2002:a17:90b:2742:b0:2ea:3f34:f18f with SMTP id
 98e67ed59e1d1-2f2e9302d14mr7165459a91.19.1734574763675; Wed, 18 Dec 2024
 18:19:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Boomman <boomman37@gmail.com>
Date: Wed, 18 Dec 2024 18:19:06 -0800
Message-ID: <CADMKT2-vsUUi-23YGexvxbW9wj0Br+cQcv34eStnw-0EDRiKMw@mail.gmail.com>
Subject: git gc does not clean tmp_pack* files
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm currently hitting an issue trying to garbage collect a git repo in
case of low disk space.
After running "git gc" a bunch of times I tried to clean up more and
more space on the disk not realizing that when "git gc" fails it just
leaves the tmp_pack file there.

D:\Platform>git gc
...blah...
fatal: sha1 file '.git/objects/pack/tmp_pack_FG1inp' write error. Out
of diskspace
fatal: failed to run repack

D:\Platform>git gc
...blah...
fatal: sha1 file '.git/objects/pack/tmp_pack_IFvamY' write error. Out
of diskspace
fatal: failed to run repack

D:\Platform>git gc
...blah...
fatal: sha1 file '.git/objects/pack/tmp_pack_khHCC9' write error. Out
of diskspace
fatal: failed to run repack

D:\Platform>dir .git\objects\pack\tmp*
 Directory of D:\Platform\.git\objects\pack

12/18/2024  05:33 PM     7,367,032,832 tmp_pack_FG1inp
12/18/2024  05:35 PM     3,787,194,368 tmp_pack_IFvamY
12/18/2024  05:39 PM     7,713,062,912 tmp_pack_khHCC9
09/11/2024  11:33 AM     3,068,002,304 tmp_pack_XTVFUi
               4 File(s) 21,935,292,416 bytes
               0 Dir(s)         339,968 bytes free

I believe that before trying to write *anything* to disk "git gc"
should try to take exclusive handles on these and wipe them, ideally
by default. The total size of these tmp* files is multiple times
larger than the repo I'm trying to compact, so if the command just did
this pre-cleaning I'd not have hit this problem once I cleaned enough
disk space.

Please let me know your thoughts on this.

-Vitaly
