Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AC417E91C
	for <git@vger.kernel.org>; Mon, 27 May 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824523; cv=none; b=CDQ7w5v7Dhn7z2a6Csxoz3ACWEXd8Hhy3qSRqFFmt4LHBVekihHQAY8hGxwITwDfBijLNYkrRm+O3C7GIyJG0L2pIgVUl3WCMXzXNKO93uj41lNb4Dq525XOU2BjJZ58/82VSEbwpDHOB+l6irp1/+KeurG+U0xEhBbRfD56pXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824523; c=relaxed/simple;
	bh=7+/JqU1HsahNM8RTTC//LjGBDWCCXLZn9Arqc+5sUZg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tGaFTLE8ae2ecJrOkMMH19Z3JzGc2Hm35kusHf/u0z/DkIxop8iICeW8UZj6YS5bVpyG/QEBEyZPt8cbLosgDqJpjknbTdW/RSp8w8e6kymuE8t5gogsu1bfzYNIJdMFh+gLhGs3MD9LwDsxVS8HoyVrY999lw6/1ZxLig9/h2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQLhK5GQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQLhK5GQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-421087b6f3fso27630055e9.1
        for <git@vger.kernel.org>; Mon, 27 May 2024 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716824519; x=1717429319; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=798AGT+qMeOBl61WbUbVjhezK7Lzt4LlKtYIkXkZxhI=;
        b=aQLhK5GQMewlan+TE3zVIGnoxwFfHWwWXrytzz9zP8q9z2ZqR3U5x+8fSay2aaKXpP
         HGqq3xh1jCwGFYVA0U9F6Dq3xEgYdxsbXMdLYmXT+8LSC1rqFEtFsIpSj4Vjxrro+4eb
         prWsWrByWoUpKOQbNLKMnvLBujkPDCyEcDDGpA2cFS783Qi9v4RauXeoIAifWh6dyaGM
         RntIEDk7uH1Y2KRUdVx6fTHJAMTTvd1AARVwtFtDQxVvef0WpIbIh0C2Fu+Su3TZedxg
         kVzIFtyu1jyu/yIF7hq1HcsbeV7BSTVrJebtRnmWY38P6eBkVlDm82cjFB5s2bk+8Hyb
         5vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716824519; x=1717429319;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=798AGT+qMeOBl61WbUbVjhezK7Lzt4LlKtYIkXkZxhI=;
        b=Nb9hR16/F6JeMW/ugjbfy0D6g/VBUtSBEqD75YpHeY1lbpnKUBeVz9569ngWRZWKWv
         WFrku/qwh0K5x4+UW2o2lwaUafIgQ/wXIoEZrhqoLyuaX4ALXgMcPPtg300Qehz0DbNM
         mBFnYHcnT/30S3PfWiRdWZ3KhXRaFP1e/CXGddXpVEUH3UKRu/o2IoAHZ1G3Q956LQ3K
         gumiK3xyKzMItKyNDOyQquP3brXA60mECLr/uyxUkPjtsb33Ji7H64+79wrgA+78x+G8
         ARZPg/oIMxc1aj+hoGVDUaXrUAIqxYEb6q319OPRWzaGk0QgSxo+OmmL1kH3dt4ekvd5
         +8tA==
X-Gm-Message-State: AOJu0YzWOh69rGfDeUXXAX1ZeEmlI0crdeWowMfaM+3WCoYJdRLd+Rwv
	gAzUPGsI5Mr2Ou4uh0Z3UhD9nGQLJb8O7f35OfmMswBpLc1FddN2PPaEag==
X-Google-Smtp-Source: AGHT+IGfCqVZDakyyo4IPSr1GcEmoct5cLKa85y6pOHaBrQ/8RmIGUJRuxsNnHlzByTcY9KES5Atew==
X-Received: by 2002:a05:600c:6a93:b0:41b:f359:2b53 with SMTP id 5b1f17b1804b1-42108a14eaemr74792825e9.37.1716824519358;
        Mon, 27 May 2024 08:41:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9363sm9363147f8f.72.2024.05.27.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 08:41:59 -0700 (PDT)
Message-Id: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 May 2024 15:41:53 +0000
Subject: [PATCH v3 0/4] object checking related additions and fixes for bundles in fetches
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
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>

While attempting to fix a reference negotiation bug in bundle-uri, we
discovered that the fetch process are missing some helpful object validation
logic when processing bundles. The main issues are:

 * In the bundle-uri scenario, we did not validate object IDs before writing
   bundle references. This is the root cause of the original negotiation bug
   in bundle-uri, and can cause potential repository corruption.
 * The existing fetch.fsckObjects and transfer.fsckObjects are not detected
   when directly fetching bundles. In fact there is no object validation
   support for unbundle.

The first patch fixes the bundle-uri negotiation issue by dropping the
REF_SKIP_OID_VERIFICATION flag when writing bundle references.

Patch 2~4 extend bundle.c:unbundle with a unbundle_fsck_flags to control
object fscking in different scenarios, the implementation mainly follows
what Junio suggested on the mailing list.

Xing Xin (4):
  bundle-uri: verify oid before writing refs
  unbundle: introduce unbundle_fsck_flags for fsckobjects handling
  fetch-pack: expose fsckObjects configuration logic
  unbundle: introduce new option UNBUNDLE_FSCK_FOLLOW_FETCH

 builtin/bundle.c            |   2 +-
 bundle-uri.c                |   5 +-
 bundle.c                    |  20 ++++-
 bundle.h                    |   9 +-
 fetch-pack.c                |  18 ++--
 fetch-pack.h                |   2 +
 t/t5558-clone-bundle-uri.sh | 163 +++++++++++++++++++++++++++++++++++-
 t/t5607-clone-bundle.sh     |  23 +++++
 transport.c                 |   2 +-
 9 files changed, 227 insertions(+), 17 deletions(-)


base-commit: b9cfe4845cb2562584837bc0101c0ab76490a239
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1730%2Fblanet%2Fxx%2Fbundle-uri-bug-using-bundle-list-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1730/blanet/xx/bundle-uri-bug-using-bundle-list-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1730

Range-diff vs v2:

 1:  8bdeacf1360 = 1:  8f488a5eeaa bundle-uri: verify oid before writing refs
 -:  ----------- > 2:  057c697970f unbundle: introduce unbundle_fsck_flags for fsckobjects handling
 -:  ----------- > 3:  67401d4fbcb fetch-pack: expose fsckObjects configuration logic
 -:  ----------- > 4:  c19b8f633cb unbundle: introduce new option UNBUNDLE_FSCK_FOLLOW_FETCH

-- 
gitgitgadget
