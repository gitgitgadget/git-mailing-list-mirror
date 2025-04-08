Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72761A83FB
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744077990; cv=none; b=aVg2XM/+cwPS1SfM/eHVs9Uo3KhQ3fM4ETXFMbf4Pp7QFzMgBM56fOpKKJGsXgNMJvkn9PKzZ5KXG0GnZQDjTeHXthyh676LSckhlDqwxW+/vLItCXj2e5jOHGGyMUCC9w1kiWLw3o+cieihagZ8ndSrxAIB+JEu8kahYmERYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744077990; c=relaxed/simple;
	bh=yfjd6UKfjV6Rm9U9EJZpx9xyE4/x65NuUgRiLlpaDbg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BigfPLqiIZ4YUJ67iKxsvPm6pdWYIF88EFYI5iI2dN+nacvOXX7jFHJue+PUfyt0bNB1VnAcbmGEsb9bWdyYchD+gIpJaeUbfpamHzXejT5VOUWqBj+o8sKJ2pFfd11w6ZTCl8RMuCCqoYIjy4LAVpTvGN1+HzBRm7qQmKqr9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkEM4t7Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkEM4t7Q"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2240b4de12bso66830015ad.2
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 19:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744077988; x=1744682788; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfjd6UKfjV6Rm9U9EJZpx9xyE4/x65NuUgRiLlpaDbg=;
        b=dkEM4t7Qa0Qi0Yei4Ep1VlMxNOGGHudehfxzfIwztZ+/e5QoMzTw/GlBCJsBqNEjUc
         DgRpLdtLD26Oe/WpvASgvyKZ6HyV6MBuJLJHDc+4bFh1VNG25/eCDyjLndM0u/00h5IW
         XkEn+26J+IgtLIoUJEbt8VOWPSq//U+2uckIFRcLbA64S9Q6kSuXAOVW+ycT4hyoP0j2
         wFlu6Hc8sKX0heq9oLyQA4qoSy6IdIHFPr8BV5yORbkD7Iheoesk6ZV9sQ6MO9z6GnIm
         xThDcup26uwfBXUtxJHUnIlVjR2/7cAuPqMSiJNMQ+zlQMXWXIR0YetVSuSNgKuUDGJM
         +dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744077988; x=1744682788;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfjd6UKfjV6Rm9U9EJZpx9xyE4/x65NuUgRiLlpaDbg=;
        b=R0VOlp3FZvxtRAcvTYFp/RwTSLWdiA+ciNeMwxlPDqgrUtS18pSval2QdgPdHD5gRc
         L3JxE3y9KK5BKKYZOhl6tbl0TgzL8EuzrD7sM8AyUywW+vfU8iUmJEae+4N47PmwmRZK
         9UpxE9yp8rgsVKQD1Vf6ypo/wjbjeef1hLRBZny3nvyRJOTdzS6Z7NMMYz/nWIfeofmA
         ub19MeVCHvF+1pPQtmLUYhK0+29DOWMb6HGTCpNurCkFHEIKKTPrboFVi4bb/fOlOIKy
         8ed3dXyY59SSaFPw8LompVH6duLG88Jk54eWMepTAABKT7hQCRaJ8fxnBJNhVKY2TVZT
         Jlbw==
X-Forwarded-Encrypted: i=1; AJvYcCWF6Wn5Ss/QpOgMgErxamRm6CY5VMp5FfuM9PcDbqByS3/GY4BZ/iAaj53pxSTlwwZJx9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLToNr0G1lRXuT5eNFclR4l2ZBvbqgcMGstOIBn9VDGQg8HSM
	Tbiqqq4TT1AMq2eWfyHLSy89cdSxx5udep1FmoIGpnqoEUPTIF5z
X-Gm-Gg: ASbGncs3kxXIuw4ZsoRXFuj4D0fnUqjSA1EfQOvRWeq3p4aWhLgPok/yUZUsZz1BL8C
	jWLdp7/Op0Nibks4a+Um30FFPgaRJ9ETKnqX0FcoJRpfcwQUoyqUUEgpNj/W6CLF8HzAffTqLQf
	QFCGMsbqpngkRmI+aK2YAnaKu+kibI8smKZQtpfHbX9Qv8kIOqyXjfk3mHMlwHEFIfNOuPtIpCP
	enU59qtyph67WR7dg3gnlL1nFm04xmb0t/Osl6j8L9+Vwd6knW1P14cFrLvG82OhhS99tv3VfFg
	4e5B6w0x5xHUahQB4I3h48VaJByXfg2RaIy7HM+LbyD0SWRm3mZmOpDA8omKmcf0TabtOyn54jg
	kXktnrWr3wkwJMbp9Nw==
X-Google-Smtp-Source: AGHT+IHXSWTV03CoMEtXkeLtS8EwbVX+5mwHmDVmbinT6PMGvOdT3uva9rGdgqCu8l3kcXBfG+vJIg==
X-Received: by 2002:a17:902:e890:b0:224:1001:677c with SMTP id d9443c01a7336-22a8a0429c5mr204415515ad.9.1744077987933;
        Mon, 07 Apr 2025 19:06:27 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:b169:70db:1e5b:dd10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866cef9sm88849985ad.163.2025.04.07.19.06.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Apr 2025 19:06:27 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Make 'git stash list' more informative
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqiknflj8j.fsf@gitster.g>
Date: Mon, 7 Apr 2025 23:06:13 -0300
Cc: Yuri <yuri@rawbw.com>,
 Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <73A1707C-7B41-42C4-A530-E107FB8D5227@gmail.com>
References: <edcd6174-e931-4ab9-b61d-8126a6cab740@rawbw.com>
 <29E4ED32-4909-48EF-86BB-67111B62AE1A@gmail.com> <xmqqiknflj8j.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> After all, if they are related,
> you're more likely not keeping the work in the stash entries---you'd
> rather be making completed commit on the branch.

I don't if this the use case of Yuri, but in the past I kept a stash
entry with some local development changes that shouldn't be committed
and sent to the main repository. This is, I always applied that stash
entry, did what I needed in my local environment, removed the code
that was applied, then I committed the changes that should went to
production.

It soon became hard to manage as I needed to use stash for other
things. But hey, stash entries are commits, so I could somehow mimic
its behavior without using stash itself! So, what I did:

1. Detached the HEAD:

$ git checkout --detach

2. Committed the local development changes. You can use the commit
message body to write a description of what those changes are.

$ git add my_changed_file
$ git commit

3. Created a local tag, just for me:

$ git tag LOCAL_SETUP

4. Whenever I wanted to use that code, I just applied it by using:

$ git merge --squash LOCAL_SETUP
$ git reset

This left the Git stash stack free for other uses and I could use
it without worrying about the stash positions. If the problem is
to have control over the stash, maybe the solution is to use the
good old commits.

> ... this is an excellent suggestion.

Thanks :-)
