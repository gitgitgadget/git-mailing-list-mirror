Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300E4F896
	for <git@vger.kernel.org>; Fri, 17 May 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953980; cv=none; b=XB0jeR2t5bCWWqAeSuRJmUMNzjemv/N+2ofs+h7AK9PnfnrQQFksbgS8/1Bg6LPLwV53z5tfFml+DQqqCiknvkkBdw6JiJOatam9G9t7ulaevO4qG/NoaWk9klyVxrv1q5PpTCn/25Y7zbf5lPsdNmUNms41WyT5OauLxmdR4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953980; c=relaxed/simple;
	bh=xwgNIGdg1rO/EmacUFbt8tjJcSQleQIJsyZpej7Pq5M=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=HKv/sU8Rh3J2yHBFabtyMCUExuDr5ybby75du7nMiUamYXKD0DBaeQ3L/fyO0oNx7lJhV9kiJif4DNcvMNdV5ig3vy2RAHbV7jdAkf9UTsZ+DNDqE5thvuHio+mQxc2vbd7tlmmjBim7Ns4PB4FHzoFHw2Pj7kQisjoxg9pp9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gearset.com; spf=pass smtp.mailfrom=gearset.com; dkim=pass (2048-bit key) header.d=gearset.com header.i=@gearset.com header.b=T/E0+9fm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gearset.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gearset.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gearset.com header.i=@gearset.com header.b="T/E0+9fm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-420298ff5b1so1676085e9.1
        for <git@vger.kernel.org>; Fri, 17 May 2024 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gearset.com; s=google; t=1715953977; x=1716558777; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwgNIGdg1rO/EmacUFbt8tjJcSQleQIJsyZpej7Pq5M=;
        b=T/E0+9fm8MqTTE5rceEnYFTggErwrUutMV0Qh4dXMf9rdhoEjyy7tQ0kq5FSI2Ke/T
         mHRll8wKbBBSNSdYLGN58aEkTptKtZYwAUOnQOKsNQKcWyUQgU2uDv+YQTPDqWliPZ5W
         pWZEqitWH7A9c2oRwAKX3G91bKRIYv2tom3v41Mm39blC6iU4v50tocoZ9++R1eg41v0
         w+5fa4LNUrWtGgmXaHJx/zWgfr7pzCD82NmNTIXmWRlmXD7h4VCYUBCsFzKfGGgy/BcS
         E2/AnT5PVdlfTk5MDNZzCg1L9zU20cgcSDR0RN+XekBiaYPDPCsOL5a+0qXAYMzNkq4B
         rjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715953977; x=1716558777;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwgNIGdg1rO/EmacUFbt8tjJcSQleQIJsyZpej7Pq5M=;
        b=c5kwSVExZU/zdtaOyIkdWGDvcG7sx77vdV0D8yiiivxM5W7OxkofEHlWXzSkR6DlnA
         mM7t+6jSeSAOnFbMHzZgh9tlmslDW+0Ef5gv5BbSREtnG36yXR1BZCUh8cg80HlJK+/c
         Lhj9Mh/RD3rvEONXyZ17b8iAQB0ZCaBeKLwQzJIHKBXZcIN3T4tF2S1XRZ5JSEFoTigb
         ANf+HH0idqi3BaML18oCaXH6yugDYDVGrDdBHr96hn++GVoqYiN+Ei5FjPLp+sa+c4G8
         Trkp+QQnIncxH6wwullCtFNx3hxwn1m1vcnEX0iU66bCQsrEv2sbbpmwXgI0fmsLQvuo
         pnhQ==
X-Gm-Message-State: AOJu0Yzo5facXI0qyP4mgMcz3lVnMw0cbEB29eVhp6iEgVHADmyIVWcs
	PzwxsN6uJ3V4Mrru4PvRefkLNQyhbZ2F/CXQZl6T3nowh2whCB/1mU2FDI50SO901Lm0tXHIr4T
	t3T4=
X-Google-Smtp-Source: AGHT+IH1lMYVlhOgRRnwXupaRSY/MfC9Eg5yFuqPvay1EQCqvcMca6cHBSuQ6l3jY53Nz5EbIQCtUg==
X-Received: by 2002:a05:600c:4f93:b0:41e:a90d:1216 with SMTP id 5b1f17b1804b1-41fea9324e4mr190205435e9.3.1715953976684;
        Fri, 17 May 2024 06:52:56 -0700 (PDT)
Received: from smtpclient.apple (host81-140-166-74.range81-140.btcentralplus.com. [81.140.166.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa90e93absm333919795e9.9.2024.05.17.06.52.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2024 06:52:56 -0700 (PDT)
From: Matt Cree <matt.cree@gearset.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Issue with git log and reference repositories using --dissociate and
 --filter=blob:none
Message-Id: <3B4EFAA3-0EE1-4C08-ADCD-7B03E184B016@gearset.com>
Date: Fri, 17 May 2024 14:52:45 +0100
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hello all, I am working with an application that uses a reference cache =
for repositories. We use that cache on subsequent clones to save on some =
of the overheads of cloning the repositories each time we need them, =
which is fairly frequently.

We've ran into an issue with git log combined with our use of the =
reference repository (and possibly --dissociate on the clone) where the =
commit history cannot be fetched (for a while) with the error:
> error: Could not read 2ffba4df2f9ec9df145fcdd84fe20a3d934b4555
> fatal: Failed to traverse parents of commit =
7603ede45da4d396f2641b01e2ef3e13d49b572f

This is part of a user facing feature but thankfully it's extremely =
infrequent as of right now.

We do a partial clone of the repository with the following
> git -c core.symlinks=3Dfalse -c gc.auto=3D0 clone --reference =
./$reference_repo --dissociate --filter=3Dblob:none --no-checkout -b =
master https://github.com/mattcree/dissociate-clone-issue ./$clone_repo

Then we try to get the log=20
> git -c core.symlinks=3Dfalse -c gc.auto=3D0 log -100 --first-parent =
--pretty=3D"%H %an %ct %s" master =
b3447a67238c760aa2845d32e5eb95b96e67c733

I set the following trace options to help debugging
> GIT_TRACE=3D2 GIT_CURL_VERBOSE=3D2 GIT_TRACE_PERFORMANCE=3D2 =
GIT_TRACE_PACK_ACCESS=3D2 GIT_TRACE_PACKET=3D2 GIT_TRACE_PACKFILE=3D2 =
GIT_TRACE_SETUP=3D2 GIT_TRACE_SHALLOW=3D2

=46rom what I can tell, what is going on here is the following
1. We cloned the repository using --dissociate which forces a repack of =
the cloned repository
2. The clone completes fast (on git 2.40+) but in the background =
'git-remote-https' is running
3. The bug appears while I request the log during this time
4. When the 'git-remote-https' process ends, the log can be requested =
successfully

=46rom what I can tell git repack is called during the dissociate, which =
I guess forces an update to the pack files. For this reason the pack =
file the commit objects are in may not exist at the time when the git =
log is called.

This means when going through the commits, eventually it does not find =
one here =
https://github.com/git/git/blob/492ee03f60297e7e83d101f4519ab8abc98782bc/r=
evision.c#L1106 -- this code path does seem aware of the possibility of =
missing objects but in this case the arguments it has been given clearly =
don't stop it from failing here.

When we remove '--dissociate' this issue does not appear. The decision =
to use dissociate was mainly just driven by perceived safety (I did not =
work on this part and can't say either way) -- we may fix it for now by =
removing this.

When we remove '--filter=3Dblob:none' the issue also do not appear.

When running the log command, Git 2.39.3 appears to print quite a bit of =
http logging e.g.
> Info: [HTTP/2] [1] OPENED stream for =
https://github.com/mattcree/dissociate-clone-issue/info/refs?service=3Dgit=
-upload-pack

This does not appear with 2.40+. I believe this is either a bug or a =
poorly handled scenario caused by the lazy retrieval of pack files but I =
can't say for sure. This is the second time I'm coming to the mailing =
list with a 'is this a bug?' type question -- it appears to me that it =
is, but our use case is fairly niche so I wasn't sure if we found =
something here. I've dived in a bit with the code and there's a lot of =
moving parts which I am not familiar with, so I may have missed =
something, but I think I've covered the main issues and I have supplied =
a recreation below.

The following gist contains a recreation including the reference =
repository state, the repository to clone, and a script for repeating =
the situation, and a selection from the log output of running with =
`--filter=3Dblob:none` -- however it's probably easier for you to run =
the script yourself for the full output.
> https://gist.github.com/mattcree/b5fcd364c97219465f37b62598db36b0

