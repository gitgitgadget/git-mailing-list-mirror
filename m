Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57949382
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729142; cv=none; b=BN+Rdmj8CvGlLCbLLcifW1pVYEuPS8Jm+xc+Fhp+G3Ofb2xL6K7w2+2bLMtqpDMcT1+aLMYerbNDmoLMOiTDihZQhFXaotbox3kYYyQrSfrQhClp96glL/evFbEy5qAALMQ7TwZVBaysM4AAwxt+bUlt+uZEs/quR9dNFdigWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729142; c=relaxed/simple;
	bh=cfLlRJHRRcZAcPFrnRE3YXlMBYi+jaF4SPkHPBhThdk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gLP76hziHOvzm9tOjw/YU7cBdvqehV1v1O4FWxLLxUM+nj+B9MGhQjaHIMnJ8i/uj2lSxDrjmbG0bQ1n81pCwsz0Lm0DpIGIXRGITWXqxyAhMkZKsyT6Mf/tDGu8xPphYQWiXkC679hzSucJoZD8mJ0quuE+pUcRaWXetUfavYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4rsrta+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4rsrta+"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99ebb390a5so966125466b.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730729140; x=1731333940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIPgJiUiOOv0HCBQ+Ts9PWmIhU51mAGnNrJzLft2ziQ=;
        b=d4rsrta+r1q2uuM4ObuystErLp157EgDrSCVaGLut+DKe7QU7N1EHzTaBswgzrSG8Q
         9Igu2jir1UPlpeCDIfnfBbwNmfGAWQhj8TyV6+wcPiDcXVy6Pib3KX5vTuC7h3BYebKZ
         MJGcpnCz7YVsGzjWs3dxc78j1ehJR/gHvYxYWHX7gHdbFoCgE/zw7inqvlY8MioiWFUl
         Y1VjD/CeG0VIJzBg3w3JZaGsZ6J608IXJnJHJy7p60zZsNG5c8ZHzDLwnz4OLU3s167O
         QrQNecmpX5L6Gdh/+VrpCKvjQTH3GnzVkVKyZJr/P7fMBBf7dnlS+WXO4rP/5F8+1m2k
         UVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729140; x=1731333940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIPgJiUiOOv0HCBQ+Ts9PWmIhU51mAGnNrJzLft2ziQ=;
        b=uWsW1FBZIVc5dYZTTF8981AmKG1WBjrSbkE/QkmJzmc+M/XJFPi8A4mzEamGSPJyQ0
         Ec98jQm+XufFwQpjVNiWsIIpjBtzb9PTQFcwsgwUUEaqLgJsHJGjOmkkpu5o1VFm5II/
         +T1uSR67GeS3v0SO5whvs9HFhAnfX5uV6wsQNLs9UXiriWgHlhNLXzOJV6ZlKMSLvfmL
         5BlsnbxpI+DVG97f0O1j6IDqosjJUkjiVR6w/hMVGzQszdSF9Zy9j8Jhzcw1P0jWcyWJ
         gVIiSiE8t3jHFQHn1iLA5WfG41a6xeA1wKily9OExhfI4+NF++BORLZURRvcD7+DsGmV
         YAHQ==
X-Gm-Message-State: AOJu0YysWEXmd+k1xBYDvvLl8Y4kjSvTUFTgOjoU24oBG5genldfZsXR
	JVdw9fD53kKlgAyyHcTzDAbNWVx+QQXH0viis8L32ClSSG6pyBkvnRA0B26+
X-Google-Smtp-Source: AGHT+IEyVmsEE3PIigxCrPsuMImXnLoykKmG8UVYUYCX2doKgJQGXU1Ukxk7btEWwNAm4ofK9xNLDQ==
X-Received: by 2002:a17:907:268a:b0:a9a:f19:8c2a with SMTP id a640c23a62f3a-a9e652adedfmr1208018166b.6.1730729138451;
        Mon, 04 Nov 2024 06:05:38 -0800 (PST)
Received: from localhost.localdomain ([5.18.179.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e5516sm556327866b.107.2024.11.04.06.05.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:05:38 -0800 (PST)
From: Matthew Bystrin <dev.mbstr@gmail.com>
To: git@vger.kernel.org
Subject: [RFC PATCH 0/1] git: pager behaviour
Date: Mon,  4 Nov 2024 17:05:35 +0300
Message-ID: <20241104140536.4970-1-dev.mbstr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've recently discovered that launching `--edit` with `--paginate` breaks
everything. Is this an expected behaviour? I proposed a possible solution in
this patch. However it is turned out that situation with pager is more
complicated than expected.

This patch does not fix `notes` command and even does not pass "t7006.24 git tag
-a respects --paginate" test. Interesting point to mention is that `notes edit`
command can be also broken with `-c pager.notes=1`.

Relates: cd878a206e8c (t7006: add tests for how git config paginates) 

Matthew Bystrin (1):
  git: ignore paginate for commands with DELAY_PAGER_CONFIG

 git.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.43.0

