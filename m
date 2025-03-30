Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE5E1DA4E
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743345467; cv=none; b=WLCOn5j+xgqMf07yfxM/t5IQMFDneHqV3LHq5nrtbLnQtqq+4bw4Gau2GgIkHxwBqxzHTCWvpf77Rr4peGI5ScJoJWb47oPP9bBWdBvTs46HpEwznCw5Ktk8L/c8FKVCc2FRwy8s7vZjN+AyTKIFb+p2vgoc1UudIsZOAlbDN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743345467; c=relaxed/simple;
	bh=PvPJmfkRP9NIX4LX0azLndECHU+GA9HtqJJsb/6jtgw=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=nhlr0dcULoFBbVLXe2mOcws89I1THTQCuCMkkBFpQ/fqaH5O5341/FDxuPuR+eYT/mzWS2wNJX9T8XbcLAig7FczXaHx70shbsNAyUZLGOekx3wY8DwS7HuTnhVj3HDvPJqvjUEBJ0/pihpKj2BF2ox5YmTYJzovUJVkzpflvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rapz2Jlm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rapz2Jlm"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso16830315e9.3
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743345464; x=1743950264; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m/xiUVy7sRmsL5xwBxYkOn1dUDacYwWr1uJ9Sb2iMQY=;
        b=Rapz2Jlm2Uxh+qSxYKDQWbyiWZrg4z+G+gb9edEL8sXaE9HOgZoEyMQi9VFU9RnFSU
         ov3r79kGfdBeW/SlX32NnIC0z0DdFygwLGWywqe3i74eMddE16hrcft1e1wt0l5q3are
         VVycp9lHRer3fgfXlsf7B343DWzMrjvxWkVvUV1ipWyCUHb2yA61yDr7UNmC+XamCLnO
         gPsEBT+oyfeaIgvI3mbrtszj72VnCIFYZnYwqST/jqRIR8D/t5OtZ0b9UJPnLjQECOxf
         DBfME5IRcj1GpUmiQv9mcdQt/1oQjR3IsZOyuZtR9ZDFx3y7RqjJYPS3AUVrts/LLRoG
         luHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743345464; x=1743950264;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/xiUVy7sRmsL5xwBxYkOn1dUDacYwWr1uJ9Sb2iMQY=;
        b=T5LV1SI/lwTXrvvH8o4xw/TDs6RlSsVUwSP+IU3UCkBfRT/bOBn+58FP168YmIScOl
         ZuBYcj6XEYtCkp16EIAtCRRSicEzVvEozJU8+ytOdzdmsl0L1sAhvKrYjsO1nkr78Tzk
         IPRll7159VHygI0khWo9LqqAWTTlMYEwtnEoemDCR3nmoEvLazBtmrV3TD5OMKO51DGu
         TPalRTo6jgKyi0/qTFbGB3xPFiZdsM2Xvbf9db0ZaCdJV28bQItCvNDea3H3ffvmQuc3
         xyQif6uNe16QR+aTNiJA3f4gwXGAVE4t89+AE+sVW+TjDRdUDsRjZBxuB8zEhZWzsog3
         9ypQ==
X-Gm-Message-State: AOJu0YytIRhC1fZSXJ+H/V6BQwvrv0VyTL0++4zqpZvD0NvzsCmgvbKV
	RE2UGfsrmd05vv7uPkSoRweJAHzoikTmnKwQMXed9BawzSpe9bpbtjq3f/Oo
X-Gm-Gg: ASbGncv0zj/NfMdXNx3TM/t8XIxHa9PI2fnDXD0GB9h9fB24+LHxi0TmfafPPqXEiVW
	PuL+Pod9UP/h8Sb68vS4cAgZ26T1ZI+yij59I8opSHpE3OuqdLNusGo8+5WaznquizIW2CO+W7c
	e+zq+4nbXz3Mr68wUFULuvr/eUmSft+aEcMzd4HkEuSN3JIOu0OgOrKYQ6mwImmjdhLmX8dAEzF
	R7o/7cMMkOZ2UcE/a6qG5boJuQQtHT36HUeWq7b9NoAxDlN7pZ2354RzxZ49o6YTpz512t8vAMl
	1FtQJ+BdU18H/K5/XEbJUWar/wH7YlaZ+fEI1t6NjDR5O+m5TPHJ0UMoHZhidRN/Aw4AaWys7wN
	AKV7gOHiXESjmZFFLnEOCqdaSJrE=
X-Google-Smtp-Source: AGHT+IGC0KqSiZDgCmsYfqPWqd25EIeVsLUgbCZw1VcKkm6MvVmYUnHkd33nSIWYrxKLM23jybCI+g==
X-Received: by 2002:a05:6000:186c:b0:39c:13fd:ea9c with SMTP id ffacd0b85a97d-39c13fded56mr3978172f8f.47.1743345464420;
        Sun, 30 Mar 2025 07:37:44 -0700 (PDT)
Received: from ?IPv6:2a0d:6fc0:8a9:4000:d097:82a1:cbdb:22b7? ([2a0d:6fc0:8a9:4000:d097:82a1:cbdb:22b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8314b6dbsm138908815e9.36.2025.03.30.07.37.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 07:37:43 -0700 (PDT)
Message-ID: <d8f596cfac9b001350b8b5e408067bb4caa073a7.camel@gmail.com>
Subject: A cross between 'git stash create' and 'git stash push
 --include-untracked'?
From: Alexander Shpilkin <ashpilkin@gmail.com>
To: git@vger.kernel.org
Date: Sun, 30 Mar 2025 17:37:42 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I'm trying to write a script for my use that would run before every
invocation of 'make' and record the working tree state at that point.=20
Stripping out the boring parts, it is basically just

    git update-ref --create-reflog refs/build $(git stash create)

but the problem is that what I want is less like 'git stash create' and
more like 'git stash create --include-untracked', in case there are any
new and as yet untracked source files that are nevertheless picked up
by the build system.

Of course, that does not exist and, because of the syntax of 'git stash
create', cannot exist.  I've looked at the code in builtin/stash.c and
it looks like there are only two callers of do_create_stash(): one is
create_stash() and hardcodes the include_untracked argument to zero,
the other is do_push_stash() and (assuming I try to undo its effects
with 'git stash pop' afterwards) will potentially destroy my working
tree's mtimes and cause more rebuilding than necessary.  So it seems
like I'm stuck here.

Any suggestions?
--=20
Thanks,
Alex
