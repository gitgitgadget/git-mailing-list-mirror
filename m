Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF025A651
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216504; cv=none; b=m5PL6gi4lhSd7ejUmryYbDnqjrCSM6TAYSYswb1wvGFQ+zRLH3jCUcRj4XKjCxN4YKCSfgG+rAxc+RkeMnkzsVKNO27kZBJSzn3PQKIpGITj51UJK/DTNdnG7sEbSaD4bY+DFNruzduHUA7VvrYPFF+F8NMtId95DgcWp23Qke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216504; c=relaxed/simple;
	bh=FOfEcN+1fA86JQK+zgcq+4ybbaEe+SNxwGn/9eKVWuA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bdQxbda/1NZbuQQjUF8Ywq8I/VhHqy6VFCGjk+ehrwe3rO+dVM7H6r2Zg3I8KBTgEkFYXdEMaC6uLPnAbUWcXdFIIrLbpla40U92PunEN9VPaFpUvdqUieuXcm1hfDVDXtAg8z9Fvflw2FOdnwPYKFPKISJkQEd4SYhID1sWDIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaWaPh8v; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaWaPh8v"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-62355a687e6so891592eaf.1
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758216501; x=1758821301; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t2Zn6op1JEZNACOLEk1qgMIqFB0fOl9edBa095ph85A=;
        b=kaWaPh8vMB3mq3KYKqjT9CrmvB7IXgwZKNkm6l0ubqPLfU5pK9ZNWvIDqPtOR2b/Dq
         dLcOwRdOFsMWi19lSplSd/Jne3rqGPNtm4emFmP6mQUaSiH7NCNzt+2Og/vBqNtp2Ds5
         UH0a6qDoh1R5Z5BxO7ypMRNaOgp5DW9SebVjyxINFXG0mW1k8wEa+i8VZLWHbJsgtKij
         S01nLWYUx+FQSHvburch+D6aJXfcgLEw2l/0jWitEYb2m0HZ5FAcJfh76NdwFBe7hHTq
         qvt/U7AIbdbxNWDjO6VEH20e9mOb4gB7AlVIEYd6kI+m/wi3GF51HIlFX6jGMw/fC98c
         pvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758216501; x=1758821301;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t2Zn6op1JEZNACOLEk1qgMIqFB0fOl9edBa095ph85A=;
        b=DhrqFoPbQY49SWYDzV5cSTq6w//q1a86VyqLJ7TsQ6u7aElhlsoy/ZphVLAxuf7wdY
         Tiu7c/RpGzCBRGyJjeP+q+W/Wjg5YC9Z1n9eVqHABT0wbfQtCJMairVBXbrUBbjh8jN6
         HFtGSy53/LZ4DG9fJQ7nsbKfPGz/ECOY1WdrmW6vx6O9Vd2zWD/hmAHf4vZORK+6M6c+
         OdZv1u7BetBoLtDFO6IK7sJXBtfizK4pWkS9IK1nV/TUYnYa3dKmLs1SbJPG83eq7w6q
         bSOLa0ROhE92FcTVEjHdj41+iiJbYDsFqwIlkcz9bFD4vajePybJg5k3UjGJiryY0kJ+
         lvKA==
X-Gm-Message-State: AOJu0YwCAE4XFTObiU/vmOMMg99VwoaQjJCJmmdp9blxs6ojJ/nDW35R
	aWNYdmg9IS5pVlo1g3k35QEiDblcV2A9gkgOfahBd0tkoPS3p5zOorQGhwowWeL2InFx7M9NMro
	bY+K0xyHjBBUxiutSJ5+ukFpaY0gbnohPHWn1
X-Gm-Gg: ASbGncsy4CpydEnwDWNoxRHHKRUmDtflYEeketn4nyCd2+iKV3zMKmET4JHW17vhIW5
	e8LfaBw4FlKknrf42sOapfwSEeGeyCY0523mfi5a/n3NBKtKidItGn9ejBZ4JuKczMZBRvkKAy2
	50pDxGEag3rMY42W5DhDMH+aW4XzI9tkFHHruz5NmdQ8sTc4R3NH0GLPWrN9l/GknM/X8Ac9TR9
	JTSpOs8eZJXc7Msb3oJDXp0hG0=
X-Google-Smtp-Source: AGHT+IGQt3PqLcMPXIyKXTAdjL1h0phdsRkUtbpO2YG4pSHJNPVyuc1pPak3H4+L3CBi2X6N4n+nWrVz4fPKTcwd16Q=
X-Received: by 2002:a05:6808:7003:b0:439:aeb9:88fb with SMTP id
 5614622812f47-43d6c18d966mr147651b6e.17.1758216501513; Thu, 18 Sep 2025
 10:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Goldstein <dgoldstein0@gmail.com>
Date: Thu, 18 Sep 2025 10:28:05 -0700
X-Gm-Features: AS18NWDf4QrgXGZIPCKYDbcTePZLeGDJHygc3RgKvxuqEkLy-L05I8F3_cqI7kE
Message-ID: <CANavNqpHqVgHshUaToS51OGVuvx5FqxROP2PssHW9OELMLeBQQ@mail.gmail.com>
Subject: [bug] git check-ignore returns the wrong exit code with -v when only
 a negative pattern matches
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey folks, I think I found a git check-ignore bug.  According to the
docs, git check-ignore should only exit 0 if a file is ignored, but if
an untracked file matches a negative pattern in .gitignore (or the
file can be tracked if --no-index is also used), then git check-ignore
-v <file> exits 0 when it should exit 1; without -v the exit code is
correct (0).

https://github.com/dgoldstein0/git_bug_repro has a self-contained
reproduction + repeated explanation.

This exists in all git versions I've tested, but I haven't tried to
get the latest dev version to check if it's still a problem in the
latest version.
