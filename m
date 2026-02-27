Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E6441054
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207342; cv=none; b=tPNTeM1fA2vdZDGRUwejuC3czvO3bnqo8d2OZwqzlppK3mmtoIFMThFPKwxiGrKYjspFQtgRUDRNPjXv7VSgpx/zpVJ14m+9+B/+4D/ezZ0CUuZy1iC/GW6vu8KzZ20G6JZ3NmtMv/4BRzdBjQ0KS/Tk6oj4HUbWwmuUZgUNC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207342; c=relaxed/simple;
	bh=uZhHHqCxwQ/j2sTUrMPsEQJ3WkJScydScI16/DyGhKI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oHBC6E36TK2uTI3U5BeMkqRjFgpeSbiFVhyO48UZu+I2dKSznp9tFZchnljsYnExu35aP6ufz/MmbpTIOek9kKWa0L2+qRsv+ja86wyF37zYMjc+DI7CyFmgw+/fKharXHTJE9EDTwiaNC8zZUd9r40tpuuBsP7N7iNpYcFMlGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyKKsfLJ; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyKKsfLJ"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-127380532eeso5492504c88.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 07:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772207335; x=1772812135; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzAF6/VNm4LUSW7VKRiLiZCYoOKct47v1p2I3eF0eDs=;
        b=XyKKsfLJEmsbiGhHV3wDT0erQNWu7vbjtlZefhq3K+4hxGPVxjaSpTQcZDDxKh6w9d
         Z5krjHUTDbSqezDsQ997QD/BnIxaF6mywOVhbn3ObplS3Y4BUYHryzdRljN7xrFpXneT
         tzWb4d/BQ7Ey8RwF2OsLE278f8MDwifvamWtnssUMSxYeLSCI/Fm7/aX/85I2jOkIEME
         ZwdtfHsnZaw/Q1ZRuFsR0yxsfy7nKCXZ7MCnzckj5tJjlvWn2No2rApJQlon0MXlWzem
         DenlRKYmOSmv934maje1lUk3CVj3lE8oYoRd+1vvOhxnXWscLfVw2If+Jy/NdsDhg1JM
         MLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207335; x=1772812135;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HzAF6/VNm4LUSW7VKRiLiZCYoOKct47v1p2I3eF0eDs=;
        b=gpXQhZd5StGyVpEA4elqwf/oPg0hgUl4VuHx00LbrUc8DC/J4aaly3z6QrLz0LTKMY
         30RqVHEtWoEm67PEAbWYWEThMSxYVK4mr9uoDI5Mws3buF0LAQ6NVxRMSlpV6EFUiKhk
         01qvIr+I38a+eHYxejnn9pBI9b0tDR+LM77+HujTwnKbNM+nG4RoCk1+ofs0bK6Mej0j
         y0DBkdArqhVz5xqsu17E+O+wzYMJAYg7jH2ANd0Di8whuQyGZF/sru7qImWT78cczPIg
         YqFnq+8L5gCLXvUrMzJsa88T8KcfDrRV/AiAdI7KAAJFv2fVspMoG7I6jYpzdXQ9+1Gr
         PORQ==
X-Gm-Message-State: AOJu0Yx8S+ZOORN5Kk/4OApXG2B74gGtzD9WDtpR+7Qla8xkqiTEkU4C
	dhJDJuo4Lv6lt6swt3BtEsa8Ika58iHZflKG9mUZwmlwGC4ofcLu84NJEIfE2g==
X-Gm-Gg: ATEYQzwhuK9cNKWI+arFbqAdF37h5QpHNEjNZt57CICOTrpLLe/NyZiKGChq4wvTysP
	eZcDtM/kAK+J7eH1rm342t5mmNhZWzFhjdBEVkQQJxrXabuEVgtcWtXxGDIxrZIK2rVD3ci21VM
	gKK3khyAFRD3tkqeCUQfT9KPxQo2CqfGQhfklqDPNj8UnF1i6rAox13aRIbJdDI659FQM5/nk/r
	EaV/NACdUcjO50rRI+ufDIQLlW0pAoPdnCkQbCQe+PmPJoEvO8h1jD1G5c+c/YF//30P8mmYVu0
	9DJrKAdD/kgG6ESjGFGf/T4XI5Hbzg4Ye9hHvlNy7QV0+Hku9M1BIxtl6cE+CDoemQh7da9QmRM
	QHp6A5p76bX98VCU40J6GzByDhRpYCuX+YnUoE/CVDWJE8ApKq5yokc0rDRrTYhN1Oxj4Qm5OA8
	o98somguwUlyWTDdVvVAjlwnNP18PriSzcJr/R7Q==
X-Received: by 2002:a05:7022:486:b0:119:e56b:c74d with SMTP id a92af1059eb24-1278fc6a7e2mr1590456c88.18.1772207334931;
        Fri, 27 Feb 2026 07:48:54 -0800 (PST)
Received: from [127.0.0.1] ([172.184.209.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a32dabsm5600023c88.11.2026.02.27.07.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:48:54 -0800 (PST)
Message-Id: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.git.git.1771574833967.gitgitgadget@gmail.com>
References: <pull.2202.git.git.1771574833967.gitgitgadget@gmail.com>
From: "Yoann Valeri via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 15:48:51 +0000
Subject: [PATCH v2 0/2] branch: add 'branch.addCurrentBranchAsPrefix' config param
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
    Junio C Hamano <gitster@pobox.com>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    Yoann Valeri <yoann.valeri@cea.fr>

Changes since v1:

 * Added a '--no-prefix' option to git branch

VALERI Yoann (2):
  branch: add 'branch.addCurrentBranchAsPrefix' config param
  branch: add a no-prefix option

 Documentation/config/branch.adoc |  7 +++++
 branch.c                         | 14 +++++++++
 branch.h                         |  8 +++++
 builtin/branch.c                 | 24 ++++++++++-----
 builtin/checkout.c               | 52 +++++++++++++++++++++++---------
 t/t2018-checkout-branch.sh       | 26 ++++++++++++++++
 t/t2060-switch.sh                | 26 ++++++++++++++++
 t/t3200-branch.sh                | 16 ++++++++++
 8 files changed, 150 insertions(+), 23 deletions(-)


base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2202%2Fvaleriyoann%2Fbranch-with-prefix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2202/valeriyoann/branch-with-prefix-v2
Pull-Request: https://github.com/git/git/pull/2202

Range-diff vs v1:

 1:  30a6d8e195 = 1:  49641fb34c branch: add 'branch.addCurrentBranchAsPrefix' config param
 -:  ---------- > 2:  0fbdf031cb branch: add a no-prefix option

-- 
gitgitgadget
