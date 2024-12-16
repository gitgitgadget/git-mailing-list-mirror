Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323B29CA
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357457; cv=none; b=uwEvmnSyT9qNdJ17s5UJsRHRAL8cP21G/6r0LFOjLJuuKIigf8wB1UIgpjx+Ebu43yFXjnt3sVgad5zCOVVvNl6i6fbPmIjI3qQL6FfZHC7b0gqOty0nsbxs5vSvC6+eKIWuqx/X3GnrTWnHQiyJx9i3XSXNU1Ag6hybQJkNMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357457; c=relaxed/simple;
	bh=VjG1wBeqUQUQ3flyFZUrLQj9zv+yKQSNutpspE77pBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jrj414VTZCGzDaweQsspDHK9HAKchTR9TsV4nwlpYQdGtEqXsCYkX3/DY6rNiplgHNsGVzaBFrOu6Z+Ha7E3yEDW0Sd025q59wuHo0FnPl12ABsRN/qghosjqkvnaYoUlbj1x+Rii0YtKdRBeBAcAMImF0x66UOyKIDeyH2gXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgSJ2O4U; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgSJ2O4U"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728eccf836bso3503612b3a.1
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 05:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734357455; x=1734962255; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjG1wBeqUQUQ3flyFZUrLQj9zv+yKQSNutpspE77pBU=;
        b=AgSJ2O4UUcBMjNFku/9d9gBtO9AZICMQLW5kO5hKbzNAlrAizj9FRlD0CnyyLrJpXb
         G1vVF6JJP5hqXGXeiAcfNcuYaj1nFV1w5U4tSEkC+fmWSgsH47eoEBfgLdDpwApaA83c
         LhmXZ2sOCbvvtnvSS4XruQAwiP6pAY/f36dSIvNqF8AdfUsPWnGPp/Jr+9y6zBRoyneU
         LvhcZdZfXUkGWh5NFjIl3EhQM4KT6Um9Yo5aFygfTWE+qsBg5ptSEn2b28GpWQvcK7nX
         eSQMLsaMqsdSLcKjOLQS1O61R94hb8SniThGPoihLFOvMEnb/xETKL5wTDTy+r8rFf4A
         RaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734357455; x=1734962255;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjG1wBeqUQUQ3flyFZUrLQj9zv+yKQSNutpspE77pBU=;
        b=FqN2BJlTQLi+oN7AL9LbMraNb2xyesBXWG6t4v9WeYQnDbtPLPW7aWVPS2EEq9dINc
         diEDvN0qDLI4kO362L+qJXb9iOvCSHpP83mJ23WFKU8Zl54pkBRwKq/ERSuIqsD/mr3N
         VYQMCJvlI97hAvUmv1Od2NSyDqF9L8VTH7w0HbPgHvxwcdIO+K4iDyqPojEqP8akr+LM
         gsclZc4Lswp9KT18p5fdzoGVysYc2tiesk57XoNvaoRtRrsx1McRwSg/l9nx3C/sUyOO
         8h/Pirb3u1EZQRT41pqOniTBVLuv6Tlx0yp5lw3AVeO4zTj+BSYNq7SP3hmGy51y6CrO
         lvVQ==
X-Gm-Message-State: AOJu0Yz7syfKzNl+9qqDXhGSwqdCaOiL3v1bTIdKUYm48b6D6HZa4HoS
	OUUVV6vDgcu6k3cCZmMF96bjA0KJnixK+VgixCZXHV2jjTxF5CQKJHFvpw==
X-Gm-Gg: ASbGncs5CWONBsIi3+U58xKpZRWxzW58A6w/kUdk3yS/4SyhjsNT2l19HKQHLjeKjNI
	n97AdGo4TZSwUHtGqKh4s0w544T9b3dK/jlMXzIRk/fBlLjPSQqpJvSX527HWh5cairOEwL8STS
	CAJ5lEtPG3AzBOVka5Ew9mmnHHTkWETZ9lDFsXfdkjQimIDxaPN1/PdWURgzHinrvgTD0nHWuBg
	XtwsPcxtCG5MY+5NnPjpxS9zp6ffOPfNUD5lKJ8dInF47oxJmmG
X-Google-Smtp-Source: AGHT+IFgUTml9PMu8l/5sMdM4HPPQtec1yoFLgoSKcFNFtEJMTBdA+gHj/xk3PPEtrna8FWIDkPfGA==
X-Received: by 2002:a05:6a00:1893:b0:725:e73c:c415 with SMTP id d2e1a72fcca58-7290c25c8b8mr16959084b3a.18.1734357454656;
        Mon, 16 Dec 2024 05:57:34 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bc020csm4733928b3a.178.2024.12.16.05.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:57:34 -0800 (PST)
Date: Mon, 16 Dec 2024 21:58:13 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC] Implement consistency check for packed refs
Message-ID: <Z2Ax9dtx4XE5xjgw@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

At current, I have already implemented the consistency check for files
backend. My next step is to implement the consistency check for packed
refs. And during these days, I have learned the source code of the
"refs/packed-backend.c".

The current "git-fsck(1)" implicitly checks the packed refs by calling
the method `refs/packed-backend.c::packed_refs_lock` which alls
`get_snapshot` and `create_snapshot`.

In the `create_snapshot` function, it will check some consistency of the
"packed-refs" file, if anything is wrong, the program will die.
"git-fsck(1)" relies on this to check the basic format correctness for
"packed-refs" file. It's not suitable to just call "packed_refs_lock"
in the code, we should not die the program.

Based on above, I have some ideas to implement the functionality. But
before I implement the actual code, I want to share my ideas to the
mailing list to get some feedback.

There are two ways we could add consistency check for packed refs.

1. We simply read the raw file "packed-refs" file, check each line. Of
course, we should also need to check whether the content is sorted.
2. We may reuse the data structure "struct snapshot" to do this. And we
call "packed_refs_lock" without calling the "creating_snapshot" instead,
we should just check. The reason why we do this is that we could reuse
some functions defined in the "packed-backend.c" instead of repeating
some logics. However, this way would be more complicated and require
more effort.

However, one thing I am not sure is that should we lock the raw file
when checking? From my perspective, we should lock the file because we
are checking the consistency of it. If other processes are processing
the "packed-refs", we may encounter inconsistency and things would be
strange.

Thanks,
Jialuo
