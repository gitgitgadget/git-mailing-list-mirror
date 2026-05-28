Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD12EBBB9
	for <git@vger.kernel.org>; Thu, 28 May 2026 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937020; cv=none; b=P3cWcFgXhVvZ8nk7KsUsNRk+DdlXJDXZeTtEzXX0ReO7cHUDktM40/VRlCcjoJa6cvlaig+uejlVXn89zZ51q+QHNUo7iNtR+nNEZMrZRIhuHLTspZO37h1iqNzZuR4ehvFLHSRU86AcksvG+WwedUy1iZthbE5DIaVmiHSUxAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937020; c=relaxed/simple;
	bh=2t3PKEjMGx4YJqsewJIutLWjlw+HS27WdwciwQ15Sqg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mtsyE4MBny8/2I7AU04BGS1vPRjHSQZDGIEBfZ4fd3jH1gkWV2yWezVFA3vq7W1387vILlbjeIsjSgRqyAcoJihhBLwfZkGG+nOBY9wAIRLEJM6l3t5tf2Zf9wQJ3oi3UtiFk8bvV2zmB/5FH6Qvf5FL1cEraPYIaYTJV7nHyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tL+Jf6Nm; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL+Jf6Nm"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8acae26e564so156731646d6.2
        for <git@vger.kernel.org>; Wed, 27 May 2026 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779937018; x=1780541818; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVPc4ZG35ztIhU8dy0AsAQQ3RmJlK4wwfSSmEo3r14U=;
        b=tL+Jf6Nm1PVoNoLNBn8kSfxZotR5On+xXoY02tI4noXyhSBsz3f9r02lRWhdsVvH80
         yfjofp4yC0HZ0sNeJgJfVRUB9w7l7uKNvw2sJHINTaIAcL+hq5fE1cnFN2/3Vuz5BTS/
         orYaYPlf7d+h2CqRj8LcraoxFpEnWFZ8U3cqnuH6sKmKKgRKAK0GKFXYClSCE09de17Y
         j+ZFiHx2HdFWVypMSY/4prZ5s5htE+a0y4hGLy4Es6hdYpGM/lksdGxPCWvEfTCy1ai6
         ZSISHfmwPNJkvv58Tg+O86FusI3qBvnBSxV9HDwXzrgmtZRPYiLqShlLNdWbbwybGxSU
         7B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779937018; x=1780541818;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gVPc4ZG35ztIhU8dy0AsAQQ3RmJlK4wwfSSmEo3r14U=;
        b=lvihJxTPv/ilDAA2E/FEF22hGiHDcLFgF4I5is2BhFoGB+6xb/KCC9LwWE4jGbswQt
         8ZXeuEFTqwGha7YfG1e+7Gyh4t2eYHlg1A/yZxrbS5k2eJjD1biLtxx/mPm8/5CE7Y66
         VjhupdH28qT0J/ZqzfsVvDAQrJ2WBQMcatqRwkNScI02+LYM+ShgNeUhnz6gdo+II+Pg
         we9q3VdlBefZTQ1zTSkNEz9dWbIj4rFCw3RQyg0G5ghm/pYxiM6oIFo7IxdPot6ZOep4
         zRLTqBCCohIfbExwMCD8i4J41HB2LgJNmH8yCRPYfMSVISDyU3oMvejKB4PSUCi2Qb1p
         2Gpg==
X-Gm-Message-State: AOJu0YwEvFnvvluvKSAXtDNXNudUE+qf+KpJsvCk/b6ql41bMlpg0Caa
	TEpg4VFVyq6mCZaQ/rrIyuM9wzFHg0W486mQUXvZ1diKr67kCIhmiIlqxLn4mA==
X-Gm-Gg: Acq92OGRDpRBUDXiN2ilbFgaNR59V1lyGG2M33Iz8CnHpZRBvKcj3jzAXi8x4oFyciT
	BLFEKZvKxvATSp1A3LvzIYvtssxfme4jF7iuOWU/Wh+Xnm4cJ6++EcFO6qpzYF8WyNtfel627pP
	75j68w8gNtu7zFjZmkUdOO37SP0/0kfjJM5Kz4rlEQgxX4gqdgmuqaolJDGk5LMMbgsrdhhBkfG
	uVlR+SUACSwpO0e5uqZnQDiEpMv9wMMVlOa2N3o/GjezG0uIqUf1p3WJxh/pTmBsOyNTKzhaxIN
	UVRYJsYxlwRuw2sOFvnH2mil+fOi+AjA2wIMg+Hh56nFVLGqYEsJrLX0pjlf24r+aifWTalmFvQ
	CLeFgiXwgFlEqiBOiHdBg1254LkMuUZDvjAaWkesuIjKaI/BkIC6Df1lm4Q0yADUzamy6XQRGsh
	VNz8i5P92kJ/QxjFKDTaeZn+ii4Mpeq8kL16x7
X-Received: by 2002:a05:6214:c88:b0:8be:35bd:8273 with SMTP id 6a1803df08f44-8cc7b616dd9mr386352276d6.12.1779937017553;
        Wed, 27 May 2026 19:56:57 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e657csm207261236d6.24.2026.05.27.19.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 19:56:57 -0700 (PDT)
Message-Id: <pull.2300.v3.git.git.1779937016.gitgitgadget@gmail.com>
In-Reply-To: <pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
References: <pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 02:56:53 +0000
Subject: [PATCH v3 0/3] daemon: fix network address handling bugs
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Sebastien Tardif <sebtardif@ncf.ca>

Fix three related issues in daemon.c's network address handling:

IPv6 address corruption in lookup_hostname(): getaddrinfo() is called with
AF_UNSPEC hints, so it may return IPv6 results. However, the code
unconditionally casts ai_addr to sockaddr_in and passes AF_INET to
inet_ntop(). On IPv6-only hosts, this reads from the wrong struct offset,
producing garbage IP addresses. Fixed by checking ai_family and handling
both AF_INET and AF_INET6.

IPv6 address truncation in ip2str(): The sockaddr struct size (ai_addrlen)
is passed as the output buffer size to inet_ntop(). For IPv6,
sizeof(sockaddr_in6) is 28 bytes but INET6_ADDRSTRLEN is 46, so long IPv6
addresses are silently truncated. Fixed by passing sizeof(ip) instead, and
dropping the now-unused len parameter.

NULL pointer in execute() logging: REMOTE_PORT environment variable is used
in a format string without a NULL check (only REMOTE_ADDR was checked). If
REMOTE_PORT is unset, NULL is passed to printf's %s, which is undefined
behavior. Fixed by using a fallback string.

Changes since v1:

 * Split the single patch into three separate commits, one per fix, per
   Patrick's review.
 * Deduplicated the address family handling in lookup_hostname(): instead of
   duplicating the inet_ntop() call for each family, the address pointer is
   extracted into a local void *addr variable first, then inet_ntop() is
   called once, per Patrick's suggestion.
 * The (void *) intermediate cast on ai_addr is used intentionally: C
   guarantees any object pointer round-trips safely through void *, and it
   keeps the per-family blocks shorter than spelling out the full struct
   casts.
 * For the REMOTE_PORT NULL guard: both REMOTE_ADDR and REMOTE_PORT are set
   by the same code path in handle(), so neither should be NULL
   independently. The guard makes the code consistent with the existing
   REMOTE_ADDR check and avoids undefined behavior from printf %s with a
   NULL argument.
 * Die on unexpected address families in lookup_hostname() rather than
   silently leaving addrbuf uninitialized.

Sebastien Tardif (3):
  daemon: fix IPv6 address corruption in lookup_hostname()
  daemon: fix IPv6 address truncation in ip2str()
  daemon: guard NULL REMOTE_PORT in execute() logging

 daemon.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)


base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2300%2FSebTardif%2Ffix%2Fdaemon-ipv6-and-null-port-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2300/SebTardif/fix/daemon-ipv6-and-null-port-v3
Pull-Request: https://github.com/git/git/pull/2300

Range-diff vs v2:

 1:  b2d8143811 = 1:  b2d8143811 daemon: fix IPv6 address corruption in lookup_hostname()
 2:  5c01ec3cad = 2:  5c01ec3cad daemon: fix IPv6 address truncation in ip2str()
 3:  e312735716 ! 3:  4e74294071 daemon: guard NULL REMOTE_PORT in execute() logging
     @@ Commit message
          daemon: guard NULL REMOTE_PORT in execute() logging
      
          REMOTE_ADDR and REMOTE_PORT are both set by the same code path in
     -    handle(), so neither should be NULL independently. However, the
     -    existing code checks REMOTE_ADDR before the loginfo() call but not
     -    REMOTE_PORT. If REMOTE_PORT were unset, NULL would be passed to
     +    handle(), so when the existing REMOTE_ADDR check passes, REMOTE_PORT
     +    is guaranteed to be non-NULL.  Guard REMOTE_PORT as well so that a
     +    future change that breaks this invariant does not pass NULL to
          printf's %s, which is undefined behavior.
      
     -    Add a fallback string for the NULL case, matching the existing
     -    REMOTE_ADDR guard for consistency.
     -
          Signed-off-by: Sebastien Tardif <sebtardif@ncf.ca>
      
       ## daemon.c ##

-- 
gitgitgadget
