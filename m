Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DA32BAF4
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732702; cv=pass; b=AqSVvSC+Nul95/BUnvQnET/bgwGatbr4JU0Sq7dLMQ7BfRkyw/U2aQYDXKCQ0TGLP5w2yEr6S/ZvNB6IDs6vtl8f5AUCimXikBlht/NPUOdSxQk3AYg4ieQWrvTjAA6JN8VqrQ3yanZD5KbUZxPfncjRNBk1YfEENjFLZAG+bhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732702; c=relaxed/simple;
	bh=z/MPYIjMP2U/hLm5zIQctvJFrXgQ+PMjXBYDWXMjtPM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sesQbhtCAmub/DaHIpJ0BAo+iJoOftyjDixYiMs62nULMlhQG9lbzah9zE9tUX03p69l8VF52dFp19H73treOiAOEuKb4RYCaQ9EFYJil/dkyhYB9qMA8trzTo9RBHOXiY7j4RGxOKE8GGlhrRojzwA+eMcWRlbpwLxCHVR9Djo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCQYq36P; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCQYq36P"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ae222d87dso1002315d50.2
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 06:11:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770732700; cv=none;
        d=google.com; s=arc-20240605;
        b=foh6RLXfNYY5DXRP4VpN5jw1JR8AoA45RX9Ya2juAf99WSgQ9A53aapAayyjhkBpSN
         EO4htc2xstb6Ussf9pz6t3qnjZCP4PQbgXQqQNb0WR2Y64A1yBF8D6LqA9tXLXuaB1In
         CqI5oq9FaAWY0H+p06cpolTmvzwV5BRU8vLQeejR94jUb9jg6s8w6DY9o7Fch1mN7255
         PxWMw17hqnAEgpre9Ayy89933zBdQ39qI2ucO7fyUFsvHl5FqYfTk98H50po3P4AsZHs
         Bn036pCbbaKsE6exdhTO1LlE0O1oiqQ0m9Ag6o8m6A5SVwkzbKz0Ps1hEHsKNx+8h4XX
         50Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=z/MPYIjMP2U/hLm5zIQctvJFrXgQ+PMjXBYDWXMjtPM=;
        fh=5NAs/so7PcGFy7wTDR4nMfUKaO+L7Ovm+s1PogWRds4=;
        b=FGSNNMVCErtZgN312W9oLgVAR1fdWkc4vEB9/YE6sg6BsHKP49s1qf3A46IrWhzYfC
         1sNR1wGp7A4h3zMZsYwxI1hsQVM5KHqz43SHTJ+gH6TlYJIcPdZMSSpwsWUhyT6DM2/5
         Vr+zy9ejgJgISBkV2RNBUzsygYW5I6BA/bfFoLCEi5OwJzZx4wnRSvltGQiZLy0qZA9p
         /Go87xhzkvlJe/M+mkNldW9N9iPxVcY6mUww8ZyQzqX9+a+GfmjneMXsB502LNshefg1
         brD9fdo4iDDAF48kXWzUsLbzLi5sXzThCs8DYQLxdr7fUjbfBzWt9CwUGZTQ92zs6QLU
         5U1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770732700; x=1771337500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z/MPYIjMP2U/hLm5zIQctvJFrXgQ+PMjXBYDWXMjtPM=;
        b=FCQYq36P/nnIh8xc2YCWH8PnOynKzjALfyqtwfZG3q646E5CR4bAxz4UMbBUzpfQA8
         e7yz2Ccw9R83yB/ICVBg8ociP1kzfGNBKOCvVG5VQ9MTT5bHj/cRm6q03kLvvGVd7hUK
         H51vYfO8NTZhDqvrfKv2NxjA6KaCTdasFggNwIDt8e4XprhGvqhD8ztkHhZb8Y+wplBl
         WhKRrVuu8zDxx2SfXZkFfe3EbkdHIsPSUD+PalCs8724HcYvHHXaEWZ+yLPkjFrQfrDy
         obpT+9QDPrhifi4ULlO6Mm+nffHzM9HUYmje6wWthZ7/GQO83rpXMhybukFYYBYYjwgu
         x+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770732700; x=1771337500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/MPYIjMP2U/hLm5zIQctvJFrXgQ+PMjXBYDWXMjtPM=;
        b=ke4aMrGsfKNL457goDASRp384XRDBDouiQUAkNPSuaA0ZVMB6rxpo+6aZSueS92fFu
         JWACapDEypL3BHOs2wf6MMth3R1ygIhwx+ZS+GdklQXi8hXTZExJyC15+iGPt4LrdWl3
         gh2DxaW4RyfC/1v4qV6WMqa5ZpQbhQN/iyrbR9o652HLnmNYocZULkJRuoNwfQJUPJDt
         5G1h0UsB5myQeQA17luS+rsXYq9WW6k7ZFlKcc3K9y3H71+HUKOBbikokwtF4kM9KNrZ
         mHIdDAbEGsPknoea8HKOBmvqbun+W0p3en/d6uYyrrwgkppunBBbTfIqkeyIsEGukJ8p
         vsOw==
X-Gm-Message-State: AOJu0Yzgjxcz3L/m9vZ6T1rEbgGt7f3jRC7oGJz6TkL7CeoURLFI/x/b
	W0jJyc6nERfId/qJnRmC4/iNi/smaV0fEM8La4Q6rb2hWdgymcg20TnhYtUt4+66wnJ5Etwy2Dq
	K+Pjw05Bvg5n3vGFgCG0oR3rdKkKLyeElC29PA5Q=
X-Gm-Gg: AZuq6aIDM2znrVCEhWOsG2Kw712cUy0vDyNLST/dQ8RuzwFB8NVkfQJ02jHMRZYRvOq
	1ZzbuupQVQSnREBXSHyvW6mxvTsSvzhKeAA8NgQg4L1BCt8pAtspTBtCH6aQqiY1iSXKE5oD5Qi
	xj90I97mUVYWsykodxvCLzVVp5PCQ45r3rP7FE2Gqjp2thDsDuInlYCOWp2gF67JTLzCciMKWJ0
	YqHP5ujuT2I7p+yiI4+i7Skzt/SMLdb1/t8IIieDNxQG9uYpPiOfCWkIlyKTTnZQnGf0ThQOu1z
	sNnYecY=
X-Received: by 2002:a53:dac7:0:b0:649:d468:f79f with SMTP id
 956f58d0204a3-649f1f55270mr10258027d50.59.1770732700260; Tue, 10 Feb 2026
 06:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Tue, 10 Feb 2026 19:41:29 +0530
X-Gm-Features: AZwV_Qh9nE1-YpbRR4Yypivq9NjryxAcX8YIffP8EBbE2_xucsCHiLwepl_a7eg
Message-ID: <CALE2CrTt_2-9C4zCrZPBabtsWY=+Mk-bH4Jaemk=yHtfpoLjfg@mail.gmail.com>
Subject: [RFC] git repo info: exposing repository paths
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthiknayak@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I=E2=80=99ve been looking at the "git repo" command recently, mostly compar=
ing
"git repo info" with what I usually reach for via "git rev-parse".

One thing I noticed is that git repo info currently reports repository
properties like layout and formats, but none of the repository paths
that scripts often need.

For example, as of now:

git rev-parse --git-dir
git rev-parse --common-dir
git rev-parse --git-path hooks

are commonly used by scripts and tooling to figure out where things
actually live on disk.

I wanted to ask whether it would make sense for git repo info to
eventually expose some of these as structured keys, starting with
something minimal like "git-dir".

My idea is not to completely replace rev-parse, but to let "git repo
info" act as a more discoverable, descriptive interface for repository
metadata, including paths, where appropriate.

One question I am unsure about is whether such paths should be
reported as absolute or relative (for example, relative to the working
tree or invocation directory), and whether git-dir would be a
reasonable first step before considering others.

I wanted to ask first before making any changes, and would appreciate
guidance on whether this direction makes sense.

Thanks,
Pushkar
