Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0BA31
	for <git@vger.kernel.org>; Fri, 16 May 2025 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418180; cv=none; b=t6/tmZPnU15S+Pa3oianX+oJW0O9IHUXb5PmWQJ5Hd+sn1D+3idK9br7kf+ftpcXhfStIEG4AsoVUfUhy90WqXjcwISVQRc/3C2skkGaRsqPU9d7Qj6I85VF0pPQ/MrfRDc70Y/uWOr4/0j/R8QkuYbbJurXVo2fnI1TEaJIlaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418180; c=relaxed/simple;
	bh=uUUuDV3o+GELiyXPjZnyZgIoGc5Ys9WFX0BHLAz0rPM=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type; b=B64UDLVTCyuSbv6z7SOVLsUK/aMIAej7aN1smx0iEgZztB52YbUgbfSn0/pCVzk//Zrj0AlHtFSguNCPQc19NMjknhUTPNWGUsSy4K6E0NmLIY3GS/DBD+6P2Kt715j75gejOaf5WjRfgJzlbPvEfW+sFCzwJc2nsf9D3kJqwbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=bFekhAUy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="bFekhAUy"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7423df563d6so2735788b3a.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1747418177; x=1748022977; darn=vger.kernel.org;
        h=mime-version:message-id:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CUzzjZ+B1xjO1wHBwC04tXS9LEwLeUhkowbZQUW6Yds=;
        b=bFekhAUyMGU65WmzFG2BuFlsnYBqzdeoa/OHsVJygeEZSSEY4sc5DpvjY406omurT1
         s84WfHsae/QSsRqJIQBrxFacOjdbrwW+F1LN9Ujt/EEcbWECkuawSUsNiGTWp2Vz40vu
         k18Kv5vTic8Vh2uDNNOOZ85nle/NNVot2PubKzcITC8L5jWShKumEKl6Ru78x9DBhyUB
         TgYgEHqnWWYoMMgbitzcVPZW8yn1aMeprikMJPXlbOj4fPrSNbFs+ff1j0LLUQwdchf7
         tLcHYV68mGUR+mbXhK8EBFyfsj5NyA2C4bZ76dR9jFS3QFsH9Z6Q8x4tuGROaJvP8JNY
         v6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747418177; x=1748022977;
        h=mime-version:message-id:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUzzjZ+B1xjO1wHBwC04tXS9LEwLeUhkowbZQUW6Yds=;
        b=r6Xrny+6Y8YItOqOxqoKnZFYR7BBQq4dRyJGbh4/P5X+flbwGItHY+ZZRU3Y/te9NX
         tY6UKQX7bKFIcK67YGv0PXxE/Me9/s0J3WpLdYKhfsxAbzAeScp66hWjBud7A2mc4GAf
         p1rMcda+32RcmCPfWCIXZJ+zHtwgFSWA//GCwGH6L9OcDsbifKjo0aOUnzUN7hiXyFBS
         Re4LD4pzSNxN71/O7PXZN7DLFEN+M6IOjjYzJIkDTJzK1izmbNj7ZOa0NGP5+odIyeIq
         +QQfrdBjyw7YKgtOKoaCRWKGOR8ZX3lKOr2x2D1W7ZhHsDargck0YNHWvRA27K0WkUay
         9GIQ==
X-Gm-Message-State: AOJu0YzkAfz1q5QgAJ5CXnjWGh25iYUjXnsI1LID/ZzVgFhKiIP/BW26
	Ur8cAdJ1//IXNQX7ixOqpWQxml+4oIwswEvJbStQ0HNJ6Q9Lj/b0+P9UAHpdN8cnSV+6NrpYznH
	hRyiq
X-Gm-Gg: ASbGncupf4N9pn08uz/X8c3Rp+yONcMQmKJnLGVsJabEFZm59NCMzEzoZK9iRLWVF/M
	sQbXVLOoNK+5HqbW2u79GbJD5rWXNOVTOAcaXDYwtKZ39r0zlWHkoFRb1jdMNmIo3KlzUZCliNo
	n6fX7CeOPhif1vdYx38CA6TLVNGU/mPR5cQFqyKSQ2XX/93rUx8OFUEhXvAORN1t0xWEZco2wRI
	4RvBiGFLFPW+KraqokeP9jRRCUFPaYtzauVunDSaudwHLI4xgKJzN0M3luR5lZKXy9Xf2tvY6FA
	TEW6sWKNKpWf0Q8OOsZWVEgLV490alJS109bitNRqesaoNCLROvZJO/Xg+vZwAIgjGk=
X-Google-Smtp-Source: AGHT+IEYEi0fe+Scw+C1R18PwYnsBFHbm0kLBmKo3++e7NyD22w66ge5x674oUIu9wW8Pvv3JMi0Mg==
X-Received: by 2002:a05:6a21:3289:b0:1f5:8220:7452 with SMTP id adf61e73a8af0-216219356ddmr6468890637.24.1747418177064;
        Fri, 16 May 2025 10:56:17 -0700 (PDT)
Received: from muhammads-ThinkPad ([2402:1980:8253:68e0:8133:6e8c:5f50:c3ad])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970b7b0sm1864735b3a.51.2025.05.16.10.56.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:56:16 -0700 (PDT)
Date: Sat, 17 May 2025 01:56:07 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Small patch to add support for MPTCP on Linux
To: git@vger.kernel.org
Message-Id: <JH8DWS.72DKHPTI873H3@unrealasia.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-CJj7AhzBCnH9mKhAPeeI"

--=-CJj7AhzBCnH9mKhAPeeI
Content-Type: text/plain; charset=us-ascii; format=flowed


Patch to enable the use of MPTCP on Linux (when available)

IPPROTO_MPTCP v1 (not the old v0) has been improved to go about the
limitations of middleboxes.

MPTCP protocol is an extension of vanilla TCP which enables multiple
IP to aggregate bandwidth at layer 4 of the OSI stack across
as said IP(s).

Similar to link aggregation which works at layer 2. MPTCP works on top
of IP layer.

Other than aggregating bandwidth, MPTCP also allows seamless failover
when one network path (not just link) is down (or having high latency)
by reinjecting the packets to a path that is available.

This patch enables IPPROTO_MPTCP if IPPROTO_MPTCP is available and
uses plain TCP if the Linux system does not support it.

Signed-off-by: Muhammad Nuzaihan Bin Kamal Luddin 
<zaihan@unrealasia.net>


--=-CJj7AhzBCnH9mKhAPeeI
Content-Type: text/x-patch
Content-Disposition: attachment; filename=git-mptcp.diff
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2Nvbm5lY3QuYyBiL2Nvbm5lY3QuYwppbmRleCAzMjgwNDM1MzMxLi44NDcz
ZjBiMDJlIDEwMDY0NAotLS0gYS9jb25uZWN0LmMKKysrIGIvY29ubmVjdC5jCkBAIC04MjcsOCAr
ODI3LDExIEBAIHN0YXRpYyBpbnQgZ2l0X3RjcF9jb25uZWN0X3NvY2soY2hhciAqaG9zdCwgaW50
IGZsYWdzKQogCWVsc2UgaWYgKGZsYWdzICYgQ09OTkVDVF9JUFY2KQogCQloaW50cy5haV9mYW1p
bHkgPSBBRl9JTkVUNjsKIAloaW50cy5haV9zb2NrdHlwZSA9IFNPQ0tfU1RSRUFNOwotCWhpbnRz
LmFpX3Byb3RvY29sID0gSVBQUk9UT19UQ1A7Ci0KKyNpZmRlZiBJUFBST1RPX01QVENQCisgICAg
ICAgIGhpbnRzLmFpX3Byb3RvY29sID0gSVBQUk9UT19NUFRDUDsKKyNlbHNlCisgICAgICAgIGhp
bnRzLmFpX3Byb3RvY29sID0gSVBQUk9UT19UQ1A7CisjZW5kaWYKIAlpZiAoZmxhZ3MgJiBDT05O
RUNUX1ZFUkJPU0UpCiAJCWZwcmludGYoc3RkZXJyLCBfKCJMb29raW5nIHVwICVzIC4uLiAiKSwg
aG9zdCk7CiAK

--=-CJj7AhzBCnH9mKhAPeeI--

