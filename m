Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C41DF748
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775369000; cv=pass; b=gwDQHnKxkwdRiknyXzlywtr/1wkRuScP5urW9VtWKwalnsUZMndsCA5INnugaI9sX+RJK43x8duku5yURvORCvVS2yCqk2HjJcqhdIrrVifcTOYbuWKnRdkj0eW1f1US3Zeeh5+JsAhyLVJIXa42X3HSedYDNcny/yZ/ZMBmPJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775369000; c=relaxed/simple;
	bh=FGzMlwITHyT99H97wA1MXYjt15Z6gwCOAUr1SC4wQn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gn8Rw7t5euJG5Hyu0VltDfAtxZUDOHRtNjSNMG+8bcl1q79fMcixDT46CN+3LhynY5fyy7KepqLQIl8wLCmKeLMoy8pgJHnYgsYDrrkb5N+p7i3bvZ3INN06uxCSHXZg0DmS2WtO1gcN1hxnbpCp6xsKz4+aApjf/AxZQERjbAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPIEXa/+; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPIEXa/+"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6500040f128so2568342d50.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 23:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775368998; cv=none;
        d=google.com; s=arc-20240605;
        b=UHYWb747fTxLLa7E2mi0bF8hIoWYd9Lobeel0VMcJk9deFZSpeMOX1B7I4T/tKjkpa
         nJDHm0WJn0tZ+uQkKp76+qEbQ5tUK8EtOkiFi+XEwatuEqP8jtKhSk0m/a/UdEYjkdji
         jYJv7jcNimorE9V0nMUcIAaaykxJvaFl/hacMBQyA9Fx+ByXZPh8iLy9sYH13WTzRCeo
         CxfIjqlXIu6m1YpWTG+SvL4zSW4f+pvxOhxmxSlAOJZVEzh8MyMCdUwdcTpcKkz0BkAV
         UZbA/z1J1HzhinL04f9PMq1sQtEO6ZkA2zCNXp2+8hcAH3m0iSyDeCZxfvNnvCM/1eO9
         erPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gn0yU38BLSflpAYtmHJZ4C/xCYZYI199vxINIe4WfLU=;
        fh=jEIUGGHHBCpTn8yS4umoLODuHn1NLPyyjDxjS6hHEAA=;
        b=OpGk2NQCi+BLYSRu2wVoIYbuo3/LEnc/xmRXqLSZsU73gO6QpdDYROF32BBM7c13yd
         2kDj7Qu20F50Fs0YLi5qC4GqQ0ZQCr14qk3ttIVPI09xmpIHL2aAXcV1IFLZPEIJJQVA
         QrbOqwsK9NMSrTGru1wGhNdE7cvTJ6bFsAUvM02GysbOau3vEJTShBuXCFRqaFkD7wKC
         Zx+Fzup7Mk46+2cEreTurE1tJadHacPg47bUo0yrzJHMNEbr+v5OrTWxgG0otfQMk5LF
         AhOhn+1cvdQgxO4SUVJk4vNjOATTogyA20uODLQ/QmtqcCaXqinaRzeLjeFzw9nDGxko
         /5/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775368998; x=1775973798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn0yU38BLSflpAYtmHJZ4C/xCYZYI199vxINIe4WfLU=;
        b=ZPIEXa/+NGxFijzpdqWCBQry3Y0WbNskdqRoviTzr5PsX9/nR7L4/8KOIUIIsqPYRG
         Pwd3Et8BJSPNG3FrNsCWq4yc/KtR+4a3CKwmiP3DU6FO17AMj/6v9pU4e1cP1IF6iDx6
         uSEg9J9gjLdCdixc32p+/2N3ZzOpdCy8mLQQt51Xhfx2KB8VRk5Y0pN4/VwsOUza06EN
         S0hUnwqHzt0kyi3EOfExrdPO7bUIDQQJoQd1qs3adrm6qXjVD+ldrV2Pa88X7SeiU9gr
         C+2s8F77vd/iRSjgwpc+IIDGwNr+vNWdnmYtBU+OLH9YQYND1RT9qIjNCmvnmG57LWMQ
         fCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775368998; x=1775973798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn0yU38BLSflpAYtmHJZ4C/xCYZYI199vxINIe4WfLU=;
        b=hZeCHeFjGLvcRDjzMZB/Ui7sRoza8UGfF5vabh0e5cy21dAzWaZM9Tuq1TPj6L749J
         4GVdltWoCH5wduYYUhs2tV+w1tHF+oz9y8cspV+T2jbFpcxmhkLIvGApa4ds/p5tFFZV
         JLp6iMXYoqIabyXwVnc3YHQTUZRVq174mIoN0+X+2hAKSVEiV8HA5P625YHyIl9tUksW
         YGXECVnUamKzE25B5Gc8POBxtnBqhUU8UBU8e7kWQgQnh8zKM525bg9hqkvP0QlB5LL6
         dHRkZ1jklwgimWR6SEk3pG2IX8KuXiRmw++TFRdg5QWrO3/vRWjkfnwqQpXfOBQ4RPB3
         Ut6w==
X-Gm-Message-State: AOJu0YxAUXar5cMuWM8OQNR2B/0aPVmh3NN9OncX8bk1VjAiWEZAbhrb
	sG4xtGuL6RabPQEtxaxFl+Cl6M+xeqcNLfXuX/j7ittybCe8of9gSapPrrdr33KwkmYLBMRENnd
	+ZgkZk5BkZhRHr9C/ZVo5wGQfYSWj8iQ439/9
X-Gm-Gg: AeBDiesEg4g5Wh3ttcwjRYM/TknVI4JMRZDHuDi9bEzjl92Mdz97PRt8kOx5/DtRYYk
	vYfdG4UcQO7+buf93Y9U6iXWwC0YP0vSN+mj6hZhETxHCOgPvGmA+G2XdlwdFFtO85SKpNoMTQT
	fn94qKT+KuK2oPOVkjI296Vt/QJ7NmwOJAtPfvjmt3iO/byZKbUobyV0642UuIoGZMvT3eIRvkg
	7UOzLJU/KSZYXIrM7q7MTt+oisgXN+VdqE4PGmkadVo+yuC1KO5+Fi+1CXePDJy5QTIyN7q9/Rm
	Lpyi
X-Received: by 2002:a05:690c:6d81:b0:7a6:1a8d:3046 with SMTP id
 00721157ae682-7a61a8d315fmr54145827b3.54.1775368998555; Sat, 04 Apr 2026
 23:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>
In-Reply-To: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Sun, 5 Apr 2026 11:33:07 +0530
X-Gm-Features: AQROBzBLTdMEo7aRh6Mt_n4nxNPfiryOyr8SXLqZgQXWLq_EwfqvuvqblpUsRRg
Message-ID: <CALE2CrSP0poB2u=SuWuhXNt-FLgqOTV0rmZoWYX8p6OOzpodOw@mail.gmail.com>
Subject: Re: [PATCH] object-file: don't use object database without a repository
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: git@vger.kernel.org, cat@malon.dev
Content-Type: text/plain; charset="UTF-8"

Hi Luca,

Thanks for the patch, this was interesting to read.

[snip]
> When git diff is invoked without a backing repository,
> INDEX_WRITE_OBJECT is never set in flags, meaning only the hash is
> needed and nothing should be written to the object store.

From my understanding, this avoids using the object database in
non-repository scenarios by forcing the use of index_core() when
INDEX_WRITE_OBJECT is not set, which makes sense since we only
need the hash in that case.

I had a small question regarding coverage:

- Do we already have tests for cases like:
  git diff -- <file1> <file2> outside a repository,
  especially with large files triggering this path?

It might be useful to add one to ensure this behavior is
preserved.

Also, are there any other callers of index_fd() that might
rely on similar assumptions about repository initialization?

Thanks,
Pushkar
