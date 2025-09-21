Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1E2E40B
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457362; cv=none; b=dI5gGbbKg9nH5mUdfhLkii/bqvEYCq+OYe0Y1LkLsKVTR5K9xG9g+KIKw3M38W+w3f2Wxkc7JRZzD2cw8kP3DT3YWAxtDCyOgtEaBZIYA6gYSyAG9uDuxZSyloTM2vg+uCB3pfmzbd+IsHmzID/V2nuoLOomLd/J68XiMsLBHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457362; c=relaxed/simple;
	bh=jJrt4btAZEpcczqNw3OngCorN1e/bBxNpA5ASr+RVK4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=c/zu186xSiIFomk1spzULrfxWw8TdY3XgKaeEPoSYXL0riFZ6DNuPQz47myWFSZIZfFZjrzUUsgnPn8AN0e+zIgYQeeMdJfQouf+zWz5bTpYgcb86HocPmiiazegRgTns9SX7D5n62D1fiZP6FIvjPf5sOoStcS4QoJJQPU8CJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDXR30L6; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDXR30L6"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-887764c2834so253868439f.1
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758457360; x=1759062160; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wD5btSlagV7SI+c/3ckhqkMAiiTXhNAblTKriMKBmIQ=;
        b=cDXR30L6JPHhMo8t3HJz97czLUo+GN13MvrTiukhZJvQYhnHu/BwQIZKfVX1Ppq9Ms
         /WfXyCucOCDTtrlQUCmDCrU+JYPTEljjzEpkinK9FyRV4+FIp6NPG/f13iZKs2o4Llb1
         D/pMzhrFn5c+qeekCxXmipUZ328jGYFWSOMBhhrn3WLaz1uDiBuK1sTVT1swu8fv9rJS
         45v2fotVfaFrOltC4m5iVD2FdeS7POEhBnN1jDlaaxl1WXzKEObXiOT2OFxKQRwvhYRU
         PFhB5FxLuLmk+Vw9wpy/b+6GwA2Nj70EZQ0WRQ0/bClYCa271OlnnhDm3WF7rT1Y7WYr
         Ux1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758457360; x=1759062160;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wD5btSlagV7SI+c/3ckhqkMAiiTXhNAblTKriMKBmIQ=;
        b=cfaKF0w/BMGy35pV+xW8+i/VKx6lDCMQiQ0Np9U03e0NM3pvs4nFrJ1l/YrF6ORHgG
         int6hFFZ7eKLufu0ZF4WOOSUyyiD70ds7VJaCnaysBKByDr1cSsBuPMLolAmtbBozJvP
         XdT6Nk+w+Xesjj3+xVoK5EOwvHVsV/h4EvD2OiwfSdKLrN/whif/QZPN/izA+fl0NK6X
         KuPc/15PbLIPZxumNWx7wtrAs73Obw97khZ8ilCMfT6igNPlSjUCjyekfe0JeRTKmkmP
         S2OghAr6eEkjz2I8E0v4cWy/AQXAH+aSetDyXRAeIHRipjSpFPCQ5t42T0IZTR1STO/G
         fwdA==
X-Gm-Message-State: AOJu0YxuGJJS4445nSo6GqonmlUnSMYvp1JZMPRQxFfzaIXIN0XBaf7+
	S+KIo+GXMAoSbOeQY8MzQFaljXinEqoYkojiVMB9PoqFtHt6myAwcY1FRmkm5w==
X-Gm-Gg: ASbGncv4xk3ALEdUwXGKfc0vCUvh+lzVjjbQSYDnYhy3OU9Av9zc09dYLEGCNA595fI
	Fjb93HjPcww6BwKjiflQBy3URrLGN/3UIXaB8vLf1YSUi1yyK17ly8gSBc8HwN+peUuXJIiGdH0
	rerO+lYKD/HL18LgkQDdtB4uFnKjEAkbjo9POdqEapo9ojjHhhSUgeGHw1uNLiLIkfvvUCMk5IY
	z+xinoExMuPv2QmAahEIendSc3ffC5t6CzapTdndRVE9kss+jtnqYK2qaKYsXgenQBUwUWDIJHz
	lw3BHmqfnrJiXWLJiyZ/Ela4VaAliLx0eD8KF0LRxI3mjGuVYYlPr7VJEZ6hXHFWCTw9bcEEwvJ
	6pwKg5e+/1sBQIroLmt/vXKXl
X-Google-Smtp-Source: AGHT+IG2ehIoOWEL+i7w4KiK/Ik/K2YQRLHpic/6VR41Bj0TiBa6Jq9wBTdJWZDQ3v0v4+ts7/hvLw==
X-Received: by 2002:a05:6e02:1a0a:b0:40e:a0e1:2f61 with SMTP id e9e14a558f8ab-42481991ec8mr129125155ab.26.1758457359907;
        Sun, 21 Sep 2025 05:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.35.114])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244b1a3ce6sm48025595ab.32.2025.09.21.05.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 05:22:38 -0700 (PDT)
Message-Id: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Sep 2025 12:22:33 +0000
Subject: [PATCH 0/3] Fix curl_easy_setopt() parameter type problem, again
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

As of last week, every CI build of Git for Windows' ARM64 flavor of its SDK
started failing (the first failed build is this here:
https://github.com/git-for-windows/git-sdk-arm64/actions/runs/17633130672/job/50104373185).

The reason is that we still have one curl_easy_setopt() call that is
supposed to pass a long parameter but doesn't.

The likely explanation is an update to libcurl in the Git for Windows/ARM64
SDK. A strange thing about this: GCC does not catch the problem, but clang
does. And even more strangely, the relevant parts of cURL's typecheck-gcc.h
haven't changed in a way that explains to me why this starts to trigger now.

To prevent more piecemeal solutions, I vetted all calls of
curl_easy_setopt() and satisified myself that all remaining calls that want
long parameters do indeed have arguments matching that type.

As is the custom in the Git project, I use this opportunity to do a bit more
than is strictly necessary to address this problem. I replace the affected
call with one that expects a wider data type, refactor an already-existing
function to cast to said data type, and use it in the modified call as well
as in another call which wants to perform the same cast but did so unsafely
(not that it mattered in practice, really, yet it is in line with other
refactors the Git project has seen).

Note for the curious: The affected call used CURLOPT_INFILESIZE
[https://curl.se/libcurl/c/CURLOPT_INFILESIZE.html] and now uses
CURLOPT_INFILESIZE_LARGE
[https://curl.se/libcurl/c/CURLOPT_INFILESIZE_LARGE.html], and it is a bit
strange that the latter wasn't used in the first place, given that it was
introduced into cURL over a year before Git itself was born, and almost two
years before the call was introduced in 58e60dd2033 (Add support for pushing
to a remote repository using HTTP/DAV, 2005-11-02).

For the record, these patches apply cleanly all the way back to v2.22,
according to git replay. I did not try to test whether it builds, though,
because all kinds of stunts are required nowadays to build this old versions
even without any patches on top.

Johannes Schindelin (3):
  http: offer to cast `size_t` to `curl_off_t` safely
  imap-send: be more careful when casting to `curl_off_t`
  http-push: avoid new compile error

 http-push.c   |  3 ++-
 http.h        | 10 ++++++++++
 imap-send.c   |  2 +-
 remote-curl.c | 14 +++-----------
 4 files changed, 16 insertions(+), 13 deletions(-)


base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1974%2Fdscho%2Fcurl-easy-setopt-typefix-again-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1974/dscho/curl-easy-setopt-typefix-again-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1974
-- 
gitgitgadget
