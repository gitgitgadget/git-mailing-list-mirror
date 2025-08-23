Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003C13AD05
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909793; cv=none; b=TxhB1aByh0yf3Uc+uki1UeZ+Z5z8Q/xYF5QLW0vnnglZQyaamK2KbsaCzVY58toenwhQ+yBNfiVpD1Yk6uMUNSfMkoDxElXrSVai5JvQ5CpwGu5SbXD3jj0jwtQW9Gh6Aj1+xkzz2pMUnZqvCKy+YHCA/CHz6UjSoMMJiXq4bZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909793; c=relaxed/simple;
	bh=Sh/KULAdddQlB3tqnqx/PsQHPremPA2fs32rvuYfQGc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rCJoFe0Etp16NLLrdfsC61ilNbUMG4EIPsCGkbH+5cbPdpfZULn4jIqpDDmpNAD4uJK8Z3wofVkJ2HPBRTQHwq4SjwEMvtlBqqP7kYRXksJ3hUlLCBQeobs78tL2/FrQulPrtBWxnyAEH4EixONyXxubU6RPh2YD5WFdq+aZByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXDn3gRE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXDn3gRE"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b4a25ccceso15178855e9.3
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 17:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755909788; x=1756514588; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W543Et6o3hc1+axa5UTGDudJGILwDARThjxpSB7xec=;
        b=gXDn3gREd5Vpwf1IZwr6d1GAsMGUAZnKvYz3jdsJEZSElIJ/yMrIcCkBvcYfs28B+Z
         kkBR7ttH6nnxbpKa+FS7KSqZ7uBU7bw8a1Rm7ya3cBT9KcdNDUm7gvmxZJL6ChAUfJgs
         NnYhcv2MXi9ijKdSfNnITDnyPvhUfyyX/Yw/HomlbvIUUPSH0miDrqQ5e9vVQD6Cb5Kr
         C7uQ+v25ux2HG0Va0cjhoLQ5B7FOlhRDU1X5s/95Nwa/urVTvUvQFolhQ156d1X2wX4m
         tfN+Ct96O3fQ8kjXcgiPNfMiFUVpgUaXa+yOATllb1DY1wnU7GbYEXJN+qQQW8DhnqfK
         1ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909788; x=1756514588;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3W543Et6o3hc1+axa5UTGDudJGILwDARThjxpSB7xec=;
        b=BWdl3O7W0w4iP+W2vWhKaDAz45+k/v8oNb8ksPhEutO6qlQ4lkgezd3i9I8Ut3I1F6
         O+jZnZG635XdqnfgUTfgtNbhKTrOFIj1kFh22SLgBKuQeTcNQTYHHtyPvAHomcPhX0JM
         c3GZkdxEXUxEc9tVvYi4aq59Tk2M/dkGOCNNJcyupjDZtKL6f5oQRudPx6wdbg3OEqUV
         4o/iot0DeTbQ7LiDJIAKxKKyMaekIx5z4LLzmZqjEI3q0X/AapK1QpFlLEgl2LACdaLi
         5rfLG2XO2MjDodmaIcXZ/l232JqBqGjnRuH5PK3uOG8T9vYOKL3jsKJ3UgKUXPQnXrf4
         sTAg==
X-Gm-Message-State: AOJu0Yy/FF+wO/oRFumscsBM54j7EbNFKojSYS/5ASJmuw1jM7OW8mK3
	Fd2464G3ypN4hOAfJ2EXaAdXuNwmMp4LpJ5JgktGdgQwhU7pR9W5/NszC3LYzA==
X-Gm-Gg: ASbGnctDLm1pyBVz8CjYQtsYZRxM8eybwCSk/eWSwkmi1qjy1LLhQqrGgtP4AbFgOcv
	Incpvw+keZe/SORXvUOdwpTwayUxAV3VoTvRzYw6C7Vf+PzZT7k1/QA2RUIHVX/Fa6DTGi+Sp10
	5DaVkqyPKNUDk+SRZNXlyhKcuMNwmzrzZTJNreePRYzS/fldsKgDh6jV67z8F0V5/5IMxNeIlOz
	Q+1HeTqUJVfYAb0CEj7D2LH1HVQqJ4HBa8ztFrRDcbb8q35uvRJDssiDd4HCYlLqvsFQVITifDI
	eljys8JyzejeVOEUlAovPeJM4Y5iD/PQu0tO3W9NUzdZjopRXtqMmlMgpaGE7Na4yGJS5nPs+Nv
	WBcLxkyV+uA1UMO9BWp6lVzb0W1+U5yiZrXA/DA==
X-Google-Smtp-Source: AGHT+IHnqljj7h0ou+AajkTh98lPv36W0ngMrcYg18QgKhJ020lcL4VOGU02Z7lzQRtYl5AwwGU1wQ==
X-Received: by 2002:a5d:5d81:0:b0:3c4:f63a:787c with SMTP id ffacd0b85a97d-3c5dc73124cmr3281623f8f.40.1755909787990;
        Fri, 22 Aug 2025 17:43:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711212871sm1338307f8f.43.2025.08.22.17.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 17:43:07 -0700 (PDT)
Message-Id: <9c2a54ab9fa9b3dea47f4ab366fc5ff7c8946a3f.1755909782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v9.git.1755909782.gitgitgadget@gmail.com>
References: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
	<pull.1949.v9.git.1755909782.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 00:43:01 +0000
Subject: [PATCH v9 4/5] doc: git-rebase: move --onto explanation down
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

There's a very clear explanation with examples of using --onto which is
currently buried in the very long DESCRIPTION section. This moves it to
its own section, so that we can reference the explanation from the
`--onto` option by name.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 6d02648a9b3c..b3354e0e4f82 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -114,6 +114,9 @@ will result in:
     D---E---A'---F master
 ------------
 
+TRANSPLANTING A TOPIC BRANCH WITH --ONTO
+----------------------------------------
+
 Here is how you would transplant a topic branch based on one
 branch to another, to pretend that you forked the topic branch
 from the latter branch, using `rebase --onto`.
@@ -240,6 +243,8 @@ As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 
+See TRANSPLANTING A TOPIC BRANCH WITH --ONTO above for examples.
+
 --keep-base::
 	Set the starting point at which to create the new commits to the
 	merge base of `<upstream>` and `<branch>`. Running
-- 
gitgitgadget

