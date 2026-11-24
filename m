Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529354;
	b=5WqWxHrCLliwTst5/XfqikApyxYkTx2xKmHB34TbDBCeXuFnd0uCzUd6T1iWYUGwOau9
	 GFPS9M5ArczVjIFpRdOvXzY6tck/xVuIBDYzKRFIe/b4VZeGf7rL4vpSHD55Ub7RVmE9L
	 yEizL8s9StfW5mNBy6yUQe2khkFX0MRozZwmTj0mPYHfvYKWvLWzv6faP9PEgZWdteSuw
	 XVHHWsx+8T7vBtJovBUc66QOp5EdU3ATf7mEeUsEXyAcYm40fi+L0KJAj7jbfG06oN6qw
	 TLjUXvhB7U5g2FpIVTy0NkvesIOsxEQHObx/ZeVAp5zEx/a5rfX3z4832aCONMRpLnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jbORGO0Ico5WMA41nnup0LRvG5u+u5DWkIhkwguweug=;
	b=mteLpTnHQLFMvzw+8IMbyDo+in6/aDfymyueRgdfgQstI3CLsLRMg+JiGohFHVnj/TCF
	 XgS9kYmYWxVP4UxMIsy764UszkZmQ8Z8rfUxPEpyPGjjJb3gYQ0Qk4o/IF8J/b1oHPcSa
	 8sPGidD4XZ7v/kx9bsZE6xYQj9iyDVTmaI3T4o82UrSBIwtlYXCmB4grWVflaiUlXxI1L
	 JEAcSUnj34ntN9g0Dr+EMNK9jCSf1sccDyMLOltiZ417Ei4z8GXaCL9BWiDsaTYJhmrqn
	 X9nniWgKxTnYgGOJgglpuU0gwV2rYeQvwKuOqTsCUZn4clTIkZpBbWmEywEre2AphDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CM520FAN;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F1606A6A3
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 14:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A4F1606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CM520FAN
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-949dcf80821so223595885a.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 06:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795529353; x=1796134153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbORGO0Ico5WMA41nnup0LRvG5u+u5DWkIhkwguweug=;
        b=CM520FANDSlg8A4WCEKHkgCforewoK1e2As6AQqppZVitncS1hdju8Y31rE8XM7FfM
         Hf47MFsTbOrwu1TjHYsCJIGLE7lCQYVPjfjKxgdxPWKcwP4RqUARyIpFNP+ip9teA3c3
         IUfDIVZD1EsjrFzZuUhI4B6rS04CirMloU3Sj2OVaSETz9YjIOFlwkXveNcoiOMLEY36
         nZUJmtGQ2XCdyMwblceEg29trhrGwMMGM33LYD0cG05zepyCytPckUqKzKwbNM1wwRZM
         GA6MKZcyXczttZ+qL1OT1+UBXOFsthmzEoStYjPRlwZ/5ZQZJsmAwNbL7VKtfQIalczX
         7m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529353; x=1796134153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbORGO0Ico5WMA41nnup0LRvG5u+u5DWkIhkwguweug=;
        b=STEqZRpqvlsPIR10kg8XD+1mCthXzV80GI1Uiv5mCLT90gfu/ZknwPTTl0UWen+MPJ
         if8//gT5kdSLdoFprgbibS6Bq86Tzr4xU66x6nXM6BE5GBvYE/htxp9HIgJB2i8fC1b6
         rkE77QXSitHEywVhJ7GY25plg9dYZweE6KuxrS1NHWOP7vp07UtEYLv5ePJsSW03Lngl
         yKHKjDzq2Z5Q4V4k+hcuwMGdwR6ToTEXa/6oz/acuqpIg8/mkzNFYpPKycXGiI9WHy3E
         gY9k5DZ5HaBlW7ChUdEE/sLBlsKQ+Kv6s2fVtg1sC9RTSZ47I4tsonuiKNWNhcmOW1OR
         sToQ==
X-Gm-Message-State: APuU4Z/PxsNnphPSRMV5K5ILG4mq7x/Mu4LAKa3woVF5uVSpyi7TlRdS
	NWEzItGyNPYhtfU4M0KmqXpZGhWjfsIvOK8pJQh0h2WbFfzPmdXVvYDr
X-Gm-Gg: AZFdTZdZOry++0Rv/fFdgvL27M/Tum445MwEkIxwEeeuG5JD8gty7zw3qidvuRB2O+v
	HSdhVaUn7zoAqh7qMxoLPNnDAUZgBfwUiNSoDTJfBXXkFlWft55ofbBBEojLJP/zP0rqaQBV8pL
	cxI8qWLv6xjgJ3IaYd/6YydnppacaxHkJ0ZSOKppfUA64CHZBUGAYaucaiWhKh7ABTGx6/4dVQw
	LYDEWXlT2o6B9GxaMRdrqoN2TofaoxgtLeEcpF1CDImvCiwwA1YOpJNOPWtumZMnfswsUue8Z2d
	A6sOpM64pCZXLd3pO0RVPOod+G8Q7TDzBMJNmkb4ZlHisR4SEyQVzSfqgvMbOrj3J91cdPIckSx
	lPJXGysX/6eOHe3yTL4/btqV2+Y9VT72/rwekWy+8RT4uPUO6F5NddQ8kK/Zc6wnVmq1jzAYLJ4
	Fcv3wmuW43Fov7CB2Wm/bQQckV4d3rVf8XP0Rqjsj3VJ+sRyydH2GwekrWLRVBo5HSbiVFUiGKM
	aKmOOjQ//G7RvJe0NReTdFeO6AS3nSiJcTzkcMvIt1r8Rns2JsbBn+hzncTsrPAr4NIx4DLGN/j
	2i7AGMnJLlYcjjxobMcMS1jdo3KUwVEqYwQMm0W6P0jskABaB/I3d/7jRb7pxf+lDtsJBUr9KMz
	zl2EN3iTwy1wQrDHKLIQ0
X-Received: by 2002:a05:620a:44d2:b0:93c:bdb4:2be7 with SMTP id af79cd13be357-949bab2c38fmr2331638985a.60.1795529353040;
        Tue, 24 Nov 2026 06:09:13 -0800 (PST)
Received: from localhost.localdomain ([223.190.84.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb4004e8sm1045737885a.33.2026.11.24.06.09.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 06:09:12 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Nikita Bobko <nikita@nbobko.com>
Subject: Re: [PATCH] history: refuse to rewrite branches used by other worktrees
Date: Tue, 24 Nov 2026 19:39:05 +0530
Message-ID: <20261124140905.47213-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <14c971ef-438c-4197-b0cd-df9bf0ef0ae4@gmail.com>
References: <20261123103911.98860-1-aniketgupta3001@gmail.com> <a0ebd98f-669e-4ff2-bca2-cfd5da5a7316@gmail.com> <20261123215431.27574-1-aniketgupta3001@gmail.com> <14c971ef-438c-4197-b0cd-df9bf0ef0ae4@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> That sounds like a bug though, because "git history" will update
> HEAD in the middle of a rebase and we throw away the result of
> running "git history" when "git rebase" completes.

It was wrong to say it is refused. That only happens when the commit
is still on the branch being rebased. My bad. Otherwise, the rewrite
is gone after "git rebase --abort". Will refuse in both modes.
