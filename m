Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2F3F412D
	for <git@vger.kernel.org>; Thu, 14 May 2026 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773596; cv=none; b=Vd6hTcJ3oPhVfhe5OmVNPFusIxzX90X/ZDUnvFxPAKEVRg9FcYlZqrZE/YxDJ49FAoGzyvCDQ5pYvLGQdf0FuwK5UEUygIHZF+F3gjKS4a8LpOku3wggiSe5Fs52G5vkoDVQ7XtioKIoFcBNqsLfG2Xg1ilMcJJ6dNzPRtrYuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773596; c=relaxed/simple;
	bh=P7oAZ5eTZu2rVCNTpypkDnrcNijPAESZtiSdwdxBICY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=a8ZzyLNBYeCgyBlfo5rY9FQIY4a8hl5tH9Mhy7kJmnd1qygdniFoLE9ShkgbhDj7Sc/4CaN7+fKoSmbFOA5lyLCW581S3nfJasdZhr+8mhhkP/A9WchGz1mZCtWjWlGH9EmljW2V3GcNUpEKZZg4wnnI5ODp7n5Ptzb5v/KPFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1b0EXcd; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1b0EXcd"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-95d0476492eso2548946241.3
        for <git@vger.kernel.org>; Thu, 14 May 2026 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778773594; x=1779378394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=86uevAxq+GU4rJlp2SgMZOCncKm/nKxvLz+Ws/Cz/+Q=;
        b=P1b0EXcdFcvlHN/cNoAgsdrpSRdlNoN46WO7+WWyM4//hM/OKb3DgSfxm7G2bfqLPE
         gCfVQc8Dq+qvHoRc4bmK9Ss1shwCEGP3Wxf1Qneqqa1HwjqD/61OlWLprf7tTOZBP6Ti
         jKFjPjQ2n2cT1pEIWmtWSHBZBe1yCj+hOwp1iCJtmtEp0hfJqQf1+kwBkg9wD9snMdAZ
         y6R4N8fM4uKvGYimFCuOoxJHJDqo87MWMvAgw8vhqyqxuNPSx6KvnO4itPczKLvyYCRd
         5IYvlXOYaQZvu7hsK8Rsxn2ciSLG8Ka0DPwNh7gbOeSEBcmWTYW+4oJo+TkAUrB//GCL
         TObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778773594; x=1779378394;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86uevAxq+GU4rJlp2SgMZOCncKm/nKxvLz+Ws/Cz/+Q=;
        b=jY6WJiKdFgUPwWWGxSXKGe+HGEXe/ibDkjYuJ9vaY69EbUY21yX/dSXJLfHiWNxhVm
         YM/nrrJS5oaPQ2DkC+iQh4CzavV5WEqBjXF2h0s+HTuU8+KpsSH9XutrRSzNRMP8ijs+
         AcEimYD3/OnvpdSbljd0r6+joL+NDOGpsEmbF/1F5OpvfaBtmUZkjRknEYdWE/IbwdfD
         HDCGSxgIDxg6mQeqlk7HlJA4B3W5ya9ON7t1PgEAC7rF7UojyHvBoDbRman9LVFQG5aZ
         0Rpoo+FfCjvSx+Ixm+zbTe7n3LwXy7RelBCMxyy7N5CqqdNB5j+pVkXLR5JsqYyVl/dj
         iObg==
X-Gm-Message-State: AOJu0YwidPCSb7tDnqqN+g/YujAIHrFlczKH2oSbYT7GNcNiscM1dNLN
	5Dci8nGkJrNvXTBpaObyEs3cL9ZOGMBuC88P0nz3X7dlw81dAUOXGzw8RxXyUA==
X-Gm-Gg: Acq92OFyuhUyOdzwK3+giPHgyCrQMAygE3YJRexyFNoqA/3pDBleL1ZTEbHh7xlaw8h
	Cr2m4GHrPW9ywZYbJPh0N7W6XlpZNiWL0DY3EXi5NpGUQICajz5efP6t0+S+qd4V6ApBagKaorp
	zLeI1OPF5zS24nnP+yQixFl3Obn74U5TDXKMe/ZOwBz+M+ucVN3/jeSfYvTBsjMws1D+xpUEhYX
	CjGt7+iGklPY3Etn8bvT0NlOX6W1Mv86f6Y8x1mu9p1xeJDeNeVUPTCyIWoeH/LAigQinf39bY1
	W4EFEmePw21Q8ZpNJ9FU/u+L/i1+4KPzvwvp7//tRVZSzJR37xWSxJyXGoZ+32No6QtV2OnXnXw
	T96rbivxQWIE+0wLM3QmTAmk2EziBkBWETZiaHtO3GrL4RJOZH0savPMb+9hLwN+ssXazvHEOsX
	t7J42lHHAmwB8BYGNT1Zo4bFVajlwR
X-Received: by 2002:a05:6102:b10:b0:631:5ef5:8325 with SMTP id ada2fe7eead31-637a7973223mr3593727137.8.1778773594002;
        Thu, 14 May 2026 08:46:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.126.102])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b2dc42csm26486006d6.26.2026.05.14.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:46:33 -0700 (PDT)
Message-Id: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 15:46:29 +0000
Subject: [PATCH 0/3] daemon: fix network address handling bugs
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
Cc: Sebastien Tardif <sebtardif@ncf.ca>

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

Sebastien Tardif (3):
  daemon: fix IPv6 address corruption in lookup_hostname()
  daemon: fix IPv6 address truncation in ip2str()
  daemon: guard NULL REMOTE_PORT in execute() logging

 daemon.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)


base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2300%2FSebTardif%2Ffix%2Fdaemon-ipv6-and-null-port-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2300/SebTardif/fix/daemon-ipv6-and-null-port-v1
Pull-Request: https://github.com/git/git/pull/2300
-- 
gitgitgadget
