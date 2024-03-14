Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FE23FE4
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710388823; cv=none; b=VQexGmbrLqoMU/isdSaHW66e90G8frxO4W5/FQblorVas9w1HqPYa/2Hm4jF7j5pL6/WcwWbKZyjxleHOJ3XIh9ydjmV3HLPZyNfN4NxDVNE/ZAnfvLby+q19ned1bQFGltbrb+fL9musFnhF0rIvlHQHRxzymPS52RvHFesCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710388823; c=relaxed/simple;
	bh=hAY7PXOJMmSYm1GWIh/Pe4/RCXYpkpTXF5XBkQhzztI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=snDCU2hWxc4VL2t2yRgqOu7Zkt7tRuMDBFesF81/dBquAJBJobQ5KYWEqczk0pJxKSU9NkI/sHOM0ofHA2B4CRrg91M+EaWXFQx53AxyvDB4eEa35GdVHhPV3cYPT4kmuFhKY24T5C5tkX/RSCuY9wRPjnIhDUt1SbZYLB+wJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8dsOfcu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8dsOfcu"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e9df3416bso347516f8f.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 21:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710388819; x=1710993619; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRaXHBgo0fm2iontEupQp2JPBByi3V/KrJo/t5De7sI=;
        b=l8dsOfcu95i0iuer85hSOHKY/Kd1RrziykdG+KRhzLkDfaOxVkYuqfr9WIFluhyh+d
         yC5dRzwWuK+DwNP+1gWFnGnB1cGLorMOfD6hJEBfV25yPgK9n74RhSlqj1Nk94atxnwZ
         Ku45b/hpEXmcsMxnHNU4ecv4OtFHfBYNBjdKAKF2DQOOaIUZ1UVbJY7d+JDvHCJ/fd6h
         6Xxv+4Pb4dQnAoPa5zyFVVdmgF7Mj9rSGhaYFQsYmIHu8pCxRzUsOMzzprcLT6P+5tXg
         ubtmUhwgggl0HzywpCUJMiP6M6Jngdeq3gQAQ/0x/p5u46Zwa492nckV2WKyoCOaL/Od
         lZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710388819; x=1710993619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRaXHBgo0fm2iontEupQp2JPBByi3V/KrJo/t5De7sI=;
        b=KVV1+pyK4ljTJ+uyLXzEn4wN4J5VIfKh5ryrF+KwMeNeFb5lffXkYAFftkxhZGLvQS
         fxMbLCBKX+pWDVPO3kiLGbWIFFcmnQ74ffOLqSIQ9+i06199NP0KlBxACXe+Xo8HYrFA
         hJ+rWYe+55XNrA0+GvLhD1KoLTO8TALATu8uTU1KFij3dwanbk+A02jG+eQgtscV6EAG
         WGvF5Nb/3Rg2WLm61NuFeMFrczYUVcOFZ6r7isUxDLt9P9HxArIDqChp/kWM9MSwVDBY
         mLeRdzqv0OvbVv0oF0XIxh62o/+INkOtfEcQZ2NptiTP0LmdPTUhAgrRU2wRFekNOQ4U
         aHvg==
X-Gm-Message-State: AOJu0YxZDTVBvZ2709I7ysZxIYpk8q6pJGwJ8lEWEGM3DAsQSe2JmQjy
	mslXh+L/wvol0EzZEAx1/fNStr9+ekeqqoTyNlVRJfVlS0AjNS5VMwgzARaR
X-Google-Smtp-Source: AGHT+IFS+XBKYALrAGened7QU6D1D8xQNJYO50KsVWNbP8Iu7uWcN9BIUDU6JJ6aS1F8Tc3kzEgCRA==
X-Received: by 2002:adf:f350:0:b0:33e:3555:bb57 with SMTP id e16-20020adff350000000b0033e3555bb57mr276523wrp.42.1710388818675;
        Wed, 13 Mar 2024 21:00:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x14-20020a5d54ce000000b0033e891d97d6sm575419wrv.107.2024.03.13.21.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 21:00:18 -0700 (PDT)
Message-ID: <pull.1693.v2.git.1710388817.gitgitgadget@gmail.com>
In-Reply-To: <pull.1693.git.1710260812280.gitgitgadget@gmail.com>
References: <pull.1693.git.1710260812280.gitgitgadget@gmail.com>
From: "barroit via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 04:00:15 +0000
Subject: [PATCH v2 0/2] bugreport.c: fix a crash in git bugreport with --no-suffix option
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
Cc: barroit <barroit@linux.com>

executing git bugreport --no-suffix led to a segmentation fault due to
strbuf_addftime() being called with a NULL option_suffix variable. This
occurs because negating the "--[no-]suffix" option causes the parser to set
option_suffix to NULL, which is not handled prior to calling
strbuf_addftime().

Jiamu Sun (2):
  bugreport.c: fix a crash in `git bugreport` with `--no-suffix` option
  doc: update doc file and usage for git-bugreport

 Documentation/git-bugreport.txt |  6 +++++-
 builtin/bugreport.c             | 10 +++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)


base-commit: 945115026aa63df4ab849ab14a04da31623abece
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1693%2Fbarroit%2Ffix-bugreport-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1693/barroit/fix-bugreport-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1693

Range-diff vs v1:

 1:  9c6f3f5203a = 1:  9c6f3f5203a bugreport.c: fix a crash in `git bugreport` with `--no-suffix` option
 -:  ----------- > 2:  868cec05ed5 doc: update doc file and usage for git-bugreport

-- 
gitgitgadget
