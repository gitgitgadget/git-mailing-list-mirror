Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21A35280
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712510215; cv=none; b=acscPs+jIOuJboUwqm5FtLTuSSaXOmkX30oFtPCS8N9hy71Qs06qrry5l8gz3zhP3j/BnNFcDrs1v3b+h8jK4djf0mFLKYKcsfGMMFbHM0kjdtRg8o8X6chU+KIt81WpmdkqvVZVSk+YZBLUU8s4KLpneS2rcQDRh3aG2CdmwUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712510215; c=relaxed/simple;
	bh=KWghbCiTW/EM8JdxP8s7+9RQg9JMrQzoZZJpTbfQmu8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=a+mTPJGMr7+VcIEz3J8HU21MXC1YwuFMeOSHvig51HnbvFi9/G5Pl+7ebXWkmh0xGUT6iW+Sc5JytH/VP1+IqWDc2EUd/fV17tzACI+7+yiDQTYzWqxZ29RISN7j1JmzYxkEAHcfnnCHJfrTP7/UKgr3DYY4xpWUpRmh+XjVLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhbYj4uM; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhbYj4uM"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-479e857876fso418043137.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712510213; x=1713115013; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nvr/mEl3ktKGXtLq/PgVjcjtshZgsAZuB1UMP4/yBOM=;
        b=BhbYj4uM5uk/GMWWHfdozhaJ0DstZoxtstiLHj3DZDNwzKt1sGTILPwmagB2nRy4Ud
         Iv/iwbUvIsDJ2iK704PcsM12CIR7FUEbxBt/xbMcv2S/XOdVvEH+9RkiHqB0A+bcyn9H
         r7lXo6QRDXmXkDRQu+W9UCKVukiVUmUre6c9euobDYvMGJ0SAO+hZLkcf5BgfPNs5mEo
         4WkXpzZoGlS/hP76xdYB4fpn17mrRGxqghj4jnlWXsjKu3FydPhbfKZzRWjrNyqppCBz
         y8jd+NizzzeWclnHAlI+9KElnNN706jQqlyx7drxxVDl2/rGHZZcU9B0oaH0IKJCIexX
         kqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712510213; x=1713115013;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvr/mEl3ktKGXtLq/PgVjcjtshZgsAZuB1UMP4/yBOM=;
        b=blb+Z3cxQlSTqF5gHt8idxLl21mxCayq1514QXolIIe44HqwGPcxpMGIYT+qQd8bzz
         CTwSQ9masH45nXDpj+dGQ2UqE7CI1N8/MuoP0Cev9Y7xZXRmNwOTu0IsxyHd7fVWyIra
         0Dk6Mc3jSx0TfDkGIQvk95AqMTgvDg//uE4/dU+TYvXZNoMUUUhU4dka0AVI8rUuA9Hy
         9foKwPpjYstUMaptSRuPbMChdKDWhadhglmFB83MmbSVaOjWa2k3h0L2zzgrJl0ILlHL
         RW84cmRXvSDFNO0ke5sevDyj2HS9E1P66KpRBEsCx+/pX0ucY2yzmHvQQQ2MaFA97EsA
         43qA==
X-Gm-Message-State: AOJu0Yw1eypm3crrrajNLfmWkbjAgIOURbwWAc9B2+f2lGSEe33EB4SW
	ghbrEVAZTOdyiwM7NG/DZAuS36UoMjr+z5SaPQCD+kUSGwcrPrAIYQtZXQ6zwPiwOLUAAyB1NLh
	14gEN9lZLjrF+cxgpwNABWpoOPeogoSn8rm+tTQ==
X-Google-Smtp-Source: AGHT+IGFjXre04f7XEowlTaxsx1FBCG/GQjx8Jvxc5zQcxcTyoWqQQtudN/py5TyXshSghzu8iOO9VAo94Rpc+orI3w=
X-Received: by 2002:a05:6102:390c:b0:479:e2b8:18e9 with SMTP id
 e12-20020a056102390c00b00479e2b818e9mr4828264vsu.30.1712510212387; Sun, 07
 Apr 2024 10:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Karr <davidmichaelkarr@gmail.com>
Date: Sun, 7 Apr 2024 10:16:42 -0700
Message-ID: <CAA5t8Vp9ugXrgawDYA-+2mXT_RWPUUvv-rH9P+Exgb2dtvX6Sw@mail.gmail.com>
Subject: What are good reasons to use trunk-based dev, as opposed to release
 branch to release branch?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Personally, I always use trunk-based development.  New changes go into
feature branches from master, and are merged to master after approval.
When we're ready to make a release, we create the release branch from
master, very few changes go into the release branch after we cut it.
Any changes that have to go into the release branch are first merged
to master, and then cherry-picked to the release branch.

My team maintains the "platform" for a large number of
similarly-constructed microservices. That includes the build process,
foundation libraries, and some development guidance to the teams
developing those services. We advise using trunk-based development,
but it's up to each team what they actually do.  I recently heard of
some teams doing what I would roughly call "release-to-release"
development, which means at some point in the distant past they
created a release branch from master, and then the next release they
cut from that release branch, ad infinitum.

What bothers me is that although I know this practice is wrong, I
don't think I can fully and completely describe why it is wrong, and
why TBE is better.

At a minimum, I know that with TBE, someone with no knowledge of the
repository can look at the master branch and know that represents the
latest work on the repository.

I can't very argue that their practice results in "merge hell" when
merging to master, because they never actually do that.

Can someone describe the flaws in this roughly named
"release-to-release" strategy, and why TBE is better?
