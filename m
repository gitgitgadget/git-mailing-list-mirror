Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3EED2FB
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738209805; cv=none; b=j9fLZaYYcPw6ulXN0pAx3hu0r2xRx0eRvIEu27Tq7yH693qR1fC3giZaEMlVm5wm2dh018Rhy783CFBOFaXrNDcAptGpZ0L3xS9oQDd0r3Sl8tt+WXNspZWk/PmOpW5F6Ju147vQPOHp8CBY3HkNSdL/Dmy/w1k2JyDEo60E8Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738209805; c=relaxed/simple;
	bh=PtB3wetmKNssxDaXbrRhi6SPpp5ZsPQHnB/LFRXK4Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8qZK8waT5Kl1EVhpQNn0U6LjPgGFwxbpaKFwy8xtYKrJKrrA1LAKu1T67RdJaVpZ9sFFxPopLb77Z0iz1E43dxKXEhlMOWpBRXpwhLmsOWRbd0MNcn/mecDNhFLNcjX9HgtaWwQfg2gmtAtrAelTv3IK6kUn4byPMJGSlog7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rl/OEli0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl/OEli0"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2161eb94cceso3577985ad.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738209803; x=1738814603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BvNE46VZiabhF0F+r41JJun4ZMgg5eZ20fkdObGfVMU=;
        b=Rl/OEli0VLAX51kfMt62rzvRV+t411yeqt3URKQ3QZUPuIR+0a/Dim1ApoYK+9aT3p
         +tXg1xZf+fgYG4BsI7v2syk6yu1jMkI8TonZJPBh4HI4ImrzKaTP59yDdBkvmwxIc0V3
         qgeHgJ0oZyfrn+5Cv3CHmk6GXUhhKovmOppVLE3IPiS5BuIAWWyX18azdZy6+EA+E0Ss
         KcoeW8ccBRNTNbM54h40zwLqRLRVNgnTdqzlDGw4Mmze3w8eC38aeW59GtmJo3/mhDhd
         FGTMGfXQaHvHt/Bnf+p7zNWcKsDna6ALQ3x7g51gBxykEGuf7XTL35dONWXoTJs4Q+Xh
         CpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738209803; x=1738814603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvNE46VZiabhF0F+r41JJun4ZMgg5eZ20fkdObGfVMU=;
        b=dCeR6VHvFy6XxjlpetXBWtnWiFgBzB2RplS8HWqJnglhOL6+y5U42yLgc+LCcnJnE8
         7IKUOKqXuYiOztEuNT/mbwmUnXSLPDpVAOmdJLh9nMPZ9yYryYdnQfDakXhdX1stI933
         Be2UKjbuM1NrJZPrX8PS4HZObee9gxctTtKAAMv7wlYeCltxU8pNbfjfTGj4Xik/dp5b
         G9set6ye++C0go+abN0PmoMLH3rFgPQBdckLS+gSCk/M8RcwDdbiKigWnOV1WXuXXU9u
         nsVjSI3WZhW94U5s2Nl+niF1CMWktzJaj/vIOo7C06Z+B9bC0N7QekrCNugk7qnYfXIp
         ilag==
X-Gm-Message-State: AOJu0Yxuv2/Ujgy00myA2V5f1Cz8UaX0pwEjjpynYeXeyOmHAgdRxqok
	LaVoq40MYWu2Nof02GZYJqJTZbEpgpJsx00u/l2Jp9LStpD4bWP+nudemg==
X-Gm-Gg: ASbGnctAFAavkAt59Kdy0zrOuSLKZr4uzDE2/ZxYtFrN54biYcXk21pmeIs1gbw7JYJ
	idTD+kOvhWfiSg6M83aD1MIewUZvmOi3kPdGcbRDvgVV+qxmC2R6JxmXO8Nw4RBAOwcaQG6FdTv
	LAM9o43vL2IGQ6cUu5LfDZHfMwaMTEwG5p8w9m+ySSa5gFXaQfsyhWyP2rKzSovQfxgMbh1Gb/v
	QjFxieCM3lNOPaazuGy5CM5pj1qPo/3f7SQfuA3tAL43s/9o3T+ajRBKWa97tW+uWSDMw==
X-Google-Smtp-Source: AGHT+IEfD0AYQvfEzqYNbeFvLZayFxEBlka5wMVsQPqequU1ej2vExMcIyV0u3Mzw3H5YwZK45L7sQ==
X-Received: by 2002:a17:903:2444:b0:212:1ebf:9a03 with SMTP id d9443c01a7336-21dd7c3c86amr87861445ad.2.1738209802767;
        Wed, 29 Jan 2025 20:03:22 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de3303a6esm4027625ad.203.2025.01.29.20.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 20:03:22 -0800 (PST)
Date: Thu, 30 Jan 2025 12:04:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/8] add more ref consistency checks
Message-ID: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qNUizvHJLgMx1y@ArchLinux>

Hi All:

This version handles the following things:

1. Remove code which checks the object where refs point to suggested by
   Patrick.
2. Use subshell for the shell script to fix the problem to make sure the
   current working directory consistent.
3. Optimize to avoid allocating too much memory.

This version is rebased to the latest master due to semantic conflict. I
don't provide range-diff here the mumber of commit is reduced. However,
it won't bring too much burdern for the reviewer due to small change.

Thanks,
Jialuo

shejialuo (8):
  t0602: use subshell to ensure working directory unchanged
  builtin/refs: get worktrees without reading head info
  packed-backend: check whether the "packed-refs" is regular
  packed-backend: add "packed-refs" header consistency check
  packed-backend: check whether the refname contains NUL characters
  packed-backend: add "packed-refs" entry consistency check
  packed-backend: check whether the "packed-refs" is sorted
  builtin/fsck: add `git refs verify` child process

 Documentation/fsck-msgids.txt |   22 +
 builtin/fsck.c                |   30 +
 builtin/refs.c                |    2 +-
 fsck.h                        |    6 +
 refs/packed-backend.c         |  343 +++++++++-
 t/t0602-reffiles-fsck.sh      | 1107 +++++++++++++++++++--------------
 worktree.c                    |    5 +
 worktree.h                    |    6 +
 8 files changed, 1040 insertions(+), 481 deletions(-)

-- 
2.48.1

