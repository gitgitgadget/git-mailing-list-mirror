Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3A74E09
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744475359; cv=none; b=t6NKW60ZT0lmPoRu8SWCY1qRDLroL+3QTfwkiaU8jpWFvgtynRb1RRZin+5gt9S7ksWe1H8VhfB5FLU44IqbfJFQs42t+P1d552tPCRSbQcfgm2gd4v6EWceVFr+WAu06KYzl2D4RYksZ7/7Kny2N3YKFKLX7BSN5/Mel3ky+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744475359; c=relaxed/simple;
	bh=TlJ+bfpNLyInsN8fmyqf+K4hgbc2kU5Kvf3Z94EbK0k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PakxlxigUloyHJ/AcjPfc8bBdFyrDk5U2uPL0hpYj5l4NaQ50ThsSCXlJo7yuyeDM4qNlMjGdcIXiZ1GzjdnMccmzyPB4dfBoYBLAHkExtvSbZbNQ4iINlEP5YxHT/zqx7xS6SlZBc64Rlz2MR+S+xTtKLKLUI/GbeDMaUcA3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acTEXhic; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acTEXhic"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso3513226a91.0
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744475358; x=1745080158; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPSZ6dPhRqI7MGk86/jF7TU6coMfwYWQvdgOd54FChE=;
        b=acTEXhicWpJQ7yxHIxBvLwakE89VMPu5NrE5ajInXw/lJeUmSZDTn8dPLJKU/358Mi
         Yu6V8hfVkI9VCMvvHSSmk1QpDfaLI+h0c87/fQHAby/816QPA2DCw/UgCD+7bLJPzGi3
         xoE5qs3CI1BfuUyu8ddSfOZzwKJtRQOW0ChJ/FSrxYASZ52gmuBEq25Tmy+6bJ1dQhO1
         EZ1TciB/Yt+7dsDTXuOnkMjEWuIKttqz+y7oba4u3A36NSzjIFlbORxcAbeeZSH65WsL
         Arfq0fHZP0fkyw/r2bVmkXexr9XUYnnExPqYlVXfaizDLoVaY5vvBt8jbAm1JQ4i22MF
         3diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744475358; x=1745080158;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPSZ6dPhRqI7MGk86/jF7TU6coMfwYWQvdgOd54FChE=;
        b=B0d8ub972DxV1w/NulHR1YKEqy+Ircm0xc/2bZEnv3t2mkNtlfvADW7W48pEzy0GiP
         yYOLO4PchigfareNkBXj15vF7ZjXefxOoR891YTtgVNFj4w3I4DQh34NoR3tzMe5LXK0
         iZ6bHit4FoBmFw3pzagvZzAVBYevT1Nm6xEiex9By7TzHLtLqISIjFpMV4lXDAxdd4tc
         NStA8nKTsW2FtFDJWaGrLyC1jhwCZXkcPy7/q8HvoM6tIpG5VPB8rkrlkEypr4DPRuBh
         qV08KMwtKw9jtObuPwFH7HJZesZ9oouFMSUsekEAl6yIKsxWvGfqhtdwMT13iArH3uqT
         8ZoA==
X-Gm-Message-State: AOJu0YzxNn9qw9oel8RqT7vHE+FNqXTepMcp+TNktdcvxIA9cICD/rkS
	3+rhE4VWAjUn3P6Bx6UrHZrFnAmFbpbeH9kVrdplJ3yl4qTp/bRI
X-Gm-Gg: ASbGncuD90afMWMeidy5FnkCnyV4aIRoJHGqDZlm3m41O9B+7ZUp9YnzwPpNutLLUZ9
	68kbrLD7FDw7NtSsnGZhykp+hwcbrYGV77ybaV73hkRwKdrbgzIcXPaN8eFkeAJgd1xUKimJyO3
	QHDLEILmAeGGO8wDg/TFkNl1Rm3+k5s4w3o6uEfMI+V/oeygZTpW4yMTdi2GM8jUdRlqJBqcxCt
	EPEEzU32wMGpAyWBGTFW/ry5Qe79GCcJGQ1omfJJajQt5JWt5+pWXaRAsM8+Q7iOaysSIaviOsZ
	q9J/wUt8d/+ycPsaD/oG/QiBh/1WDtJuSpJ8yLMOMBbF7Sbme59mMur86NZ7RugmEwKZnET/3A=
	=
X-Google-Smtp-Source: AGHT+IEOmXY4DvkgpxTWE7sM3zPr8TDm2M9+ljE91B8De0hb7moCPAO6IFKDW7wB0ploZPimfYRmkg==
X-Received: by 2002:a17:90b:50c3:b0:306:b593:455e with SMTP id 98e67ed59e1d1-30823622593mr9914562a91.1.1744475357550;
        Sat, 12 Apr 2025 09:29:17 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:8555:58e0:926e:5ed4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171764sm7958867a91.34.2025.04.12.09.29.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2025 09:29:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Bug in git-stash
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <AE8657E8-D68A-4B86-9644-B57AEE743794@gmail.com>
Date: Sat, 12 Apr 2025 13:29:03 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A17CFE85-47BD-4DD1-B377-8EA27A1262BA@gmail.com>
References: <AE8657E8-D68A-4B86-9644-B57AEE743794@gmail.com>
To: =?utf-8?Q?Filip_Skogstj=C3=A4rna?= <f.skogstjarna@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi!

> The stash contains the diff between HEAD and the unstaged file

This is expected behavior. From the git stash manpage:

"""
All changes already added to the index are left intact.
"""

This is, it works just like running `git stash` but without
touching the index and keeping the already staged changes in
the working directory.

But still, each stash entry is two commits, one containing
the state of the index and other containing the state of the
working tree. You can see that in git stash manpage, in the
section "DISCUSSION". This way, you can operate on them like
any other commit.

More specifically, if you want the stashed changes from the
index to the working directory, you can run:

git cherry-pick -n -m 2 stash

where:

-n: cherry-picks the content without creating a commit

-m 2: given that the last commit is a merge commit whose
  parents are the HEAD at the moment of stashing changes (the
  first parent) and the commit containing the state of the
  index (the second parent), apply the changes based on the
  second parent (i.e. what was in the working directory but
  not in the index)

- stash: this is the stash reference (just like any other
  reference, like branches or tags). It points to the last
  commit of the last stash entry. If you want to use other
  entry, follow the reflog syntax (i.e. stash@{1})
