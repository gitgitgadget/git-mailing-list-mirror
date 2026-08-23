Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A519CCF5
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494578; cv=none; b=S7uwkif2QDWpjUEVulDldd1kxH0U4MQGO4sKkIMbftmA81JFSJskZuvS1LGHnn27CsMj10rkK2NhvZXIUGoQO/C0XS74JW79YG1Bx5A302nViWZ3bqXkc8IA2xgAEzwbMgYX3ssV8ctSrlTclBdfPYU5sC1UDCO5pDcVmow/2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494578; c=relaxed/simple;
	bh=GLjgKFO/b7B6bZS9YKJupeHgM25O+e6RU0e+b5gwn+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHTv7qmE3S8Pse8INMRRWZlEev4zHFHDa6kHYD2/6rJZtoMVNIPdNKiac5Qly9ltAXvEqW7bI4D5OC1tqHn23l2j5eTowc3sDe+kOECzthRvXcjKojw+/pn1yDfx4oC32T/0Qs7+ikw8xrMb/SWINos4YDAXlPasa0zmJWcKlFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrjzlBlR; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrjzlBlR"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-52cd38ddcdfso14600831cf.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787494574; x=1788099374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLjgKFO/b7B6bZS9YKJupeHgM25O+e6RU0e+b5gwn+o=;
        b=OrjzlBlRudLjTCrsfJd0FvH9oAAYQ9HNvvGuW5AEovTs1GGwctdcvcTN9KeAsqe6Xg
         FsVmdO3rT73i/KtD7LNBr2IWKqvYWC/4hp/yxQI1dN3/Z0ktloeP+MxBgST+g7qbbxoE
         klmjCZoaS+R5nMg3MYtzw9eOHF8v+lfZcO5q89E+mu+Np1/VNKyauHAGh3KZ6ifiTOSz
         e+PC7OdKoXgEPLUnFXKzpLFnb5R3kWk0VS2wZWOArtPx1lup6kdWPfW6zrJMMLT3oYFx
         M+aZ00eX05p5eRGX2w6g2v08j82xi/d4KgpuYn1LT9RbpoCeDiSq+Z1E3Ymh2VeWeCdV
         o8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787494574; x=1788099374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GLjgKFO/b7B6bZS9YKJupeHgM25O+e6RU0e+b5gwn+o=;
        b=e/1AB/vOIMLYsgx0Z6mpRnhllUpLXSmkdtHCNtyRedt3qG6X5uuOoXp9GTohyQROYj
         h74oHMmV7Y1SKjAbycFwM93A/s5QCXQK/zKNUdn8IPzSeyMA0Qci5AtilZ4exotkQVvH
         +Vz+sEHpcrUO0aGYM66FSOEi0Gplwh/Lwf7XBYHoMvsAQyqcgVAilP+ICKx+LYX5kpuE
         i/aHNwDipmQyLJ78Hjhlc/ecOh04ITrBUzjt4DN7VKw+xPZUPC1OR1OpLQENjSonPtDA
         FLyyn6Pwh3+slyaWDPt6FobFXO+OjjI/rsVmCntCZhd62QqJkQqftFURnDJH/a47Tzel
         aClA==
X-Gm-Message-State: AFuF++mO15Y6jNQ6xJwpin78fMhy9pNJSC62wAg/uzwoQAF0Wx/tHwUA
	5sWrFUTu8ERiL2NM47ztJ3DnxQVvqfXpL2GUYDyTnaQQuVObzA44rGwx
X-Gm-Gg: AR+sD122gbXF2q6iuiINNAswl6rix9ZanoY0RHpFbqK56FxBaoDCfq1kdppwbZQImV1
	iuarLAWBFQ+ESHM/35B9Ak3WBdvYU/VnB5a5Ryculcm/GVdAGqLds/Qw6Aov8bGd5qiAzP8Sa62
	gfVtaRjb/vpfK169EFtxqqJ8lbdkNhj2IZW71utJXi1cb9T3gTzvnjmdpjlF3M/dyr/NjLUd3/b
	h5F8lHOryG8pOzp/n4/tMMOPuBMX2ukBRssvg/WJFQ9yr1ZTFOxWuTZ+QVgcn6mY8RRJQxZQnyX
	MdL9uE9C28TDeFaPHJNxFVJo7KZikUEWxRzAgVP9IBJ4dR5P0OeHkpCUbWce09vrTzt9RkVz3wK
	WgEDorEQzyRaq0w83Way2q6O2eP+AM9tXRzfPAq8i42nzYZ4rzePW3Kv8xeKTZC0pi0fUED6eAl
	LUjEgc/Z04OfP/4Q5xae5v+u5aTtXDU7gHWmlHzR5O7ljogUchYssRa63NKfNu7AW5FeW7k+rVY
	PcMSuK7xy3ptGO6MWG4PoM/5rt4x/uagD5hWN3IDsgX4kdJhparFmV+
X-Received: by 2002:a05:622a:30c:b0:517:6d6c:187f with SMTP id d75a77b69052e-52df572bee0mr197719751cf.14.1787494574298;
        Sun, 23 Aug 2026 07:16:14 -0700 (PDT)
Received: from niko (50.sub-75-194-244.myvzw.com. [75.194.244.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a4d8bdsm38494086d6.38.2026.08.23.07.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 07:16:13 -0700 (PDT)
From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] t1402: test forbidden characters in refnames
Date: Sun, 23 Aug 2026 09:15:11 -0500
Message-ID: <20260823141600.74820-1-nikolauspschuetz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqq5x13stxt.fsf@gitster.g>
References: <xmqq5x13stxt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Many funny characters are not allowed between 'foo' and 'bar', but
> are there characters other than dot that are not allowed at the
> beginning or at the end (e.g., "refs/heads/foo." and "foo.lock")?
>
> IOW are we testing exhaustive now?

No -- dot is the only character with position-specific rules,
and every other character in the forbidden set is rejected
anywhere in a component.

The file already exercises each of those rules on its own -- the
leading/trailing-dot, ".lock", empty-component, single-level and
--normalize cases are all present. So this isn't reaching for
exhaustiveness; the coverage was already broad, and this just
fills the untested gap -- of the "forbidden anywhere" characters,
only "?", "\" and ".." were tested embedded, so I folded the rest
into the loop.

Thanks,
Nikolaus
