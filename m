Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD3329E4C
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793726; cv=none; b=r/ObSIB6LaWVfosqHyu2tMUXbKie0cU8PCAE+p4Zgd+5adw0m5tVZ3WRAAueG3LTyM1nFJ8H4UMH4LiFlrcUjcwWvdR31M/mWr7d4AGs7FgbEdj2EJFiDgr0fH45n980VDVedovTdiyKV1d02/zz+XtmTHaUuo9U8v7NHW2mWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793726; c=relaxed/simple;
	bh=LahJU3Ol/E0gMLSZneRkNpPjkoEfpWqs4UhVullmQuI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RmWKqe/jN2742ItlAVkyJ+4wqRX0vlBogysArAg4Vwt6hunky6yh3r/DfspQFu4OBxIvNoGf0yYS56WCEZGz5Zzi4WxY12/0nobnB64N2E6OaoLOuuRZXm7fzKlZzIzyTbFn9wmM1LryTPnT8t8z+vcr4VzrISJteVvaQ+Jfw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jabeNYJ0; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jabeNYJ0"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64470c64c1bso4440481d50.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765793723; x=1766398523; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LahJU3Ol/E0gMLSZneRkNpPjkoEfpWqs4UhVullmQuI=;
        b=jabeNYJ0f14W8I0pOj/TJRYR/MbhOhjwQ6wjw5gf3/ycZ0H4ermmJDDFcitlMQeXq2
         yoLaWEC4S4SDukS58IXwr2wxoP6MT1QjNSDVcEXxEu8szrBBD1+AFby+gU/vll1F0S5Z
         JdxGa9m7An4zVhHCCR4P6eqRO2ZpfcvTt1ZwUl3ML2jqGstVNSWAWoiys1oiPb+7cDKO
         EkiJV8sEI/rE7kJjtXCZ6V5tDfab+1r6i2Yr57jxczmcUYTJfNpWqowqL1e8lstoR9q7
         pK1cHbk7YcrsADbwhX9Wv8UOJUjQX7o7UOOex2/9YLvVqY8EJfEm27yDaRZmzb1dtK76
         OULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765793723; x=1766398523;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LahJU3Ol/E0gMLSZneRkNpPjkoEfpWqs4UhVullmQuI=;
        b=byZH/9vR9ULXwYcOHmzfkcSxKtOVYQZFzj1Tu56ZxZpV3wMhQ7jW8XIa5aseSjWife
         BOz4sPAkRwgQef+Vxe5PYZE5UnJ+6rGINz2Fbl64WbR+uA/jc3i+qGEFiHua5J7hhhtb
         mIaXJtHJddCvG6Vhm/s6vXc33WJKOt9XpREe6t49bOg+jdnWWwyXd7UPcjjkqvoje0Yw
         zBYZ7XwM2CGQQsXMTQNx756VpUsrAt3hca2lwclgwVKlyBvxaSAt+N6J4zgbhJ3PA4yN
         njvW0hyxo1rqKR7unTRsLE/FfjXS7to8luFVm7NFeceK5trCgs2RFwcy5+tRFr/BZB4P
         G3OQ==
X-Gm-Message-State: AOJu0YyNVCgH09uPo/PXViFWJicrNwX9U6Xl2d1O+JZHYjy8L8O1yCCh
	GnD4fWEEqbs7+bZ+zkmEeixJuj5Mi/bk4jqW8fCmQqCG3fULxXMx8jTKn5aInpbl6FfBr4ifoTL
	F3/sqA2a9xprAp20iQyUAMtdBFtf8kLDp26VY
X-Gm-Gg: AY/fxX6duJ3EMZucW7biUyVlnShik0UrOmZEhz9FrxkPSoa5es/I2UjmpC6oefTdliT
	9DV06oMIFwv25OhEaDeSlmPUKW5ZwIwdr/GOpAXELd4MMY2grsEl3wFqlNT0uBH/qO708EUiJHY
	MwCvgWjTBsSjkwcSEcdSoEs+PolV2gV+Tjme1Cgl+PosZ57bLTjBZBhsOSIhvo+sJp/hVxhxSRW
	W2ghtOzQyQX9gz9jMwEuAzx4Gbbi3dNkGXyUORK7UNgas7dVAqeNrezRa9thA0IadxEfRE=
X-Google-Smtp-Source: AGHT+IGf0jxISLn1mde7v3hLkXry/ovTPw4rBXoKrguSJubPvNe6x4KNC+HkL9/gaRJrqg5P89ZDGMMPFD8Md/BtD8I=
X-Received: by 2002:a05:690e:144b:b0:63f:a876:ae58 with SMTP id
 956f58d0204a3-6447a4d49d2mr11175486d50.9.1765793723573; Mon, 15 Dec 2025
 02:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Milos Markovic <k4hvd1@gmail.com>
Date: Mon, 15 Dec 2025 11:15:12 +0100
X-Gm-Features: AQt7F2qSgoalkjNEsfYHM1pV5HdE7yV0sStBVs2ImoWMLuHACRq0ittGbiQ3hdY
Message-ID: <CAKRouPtDrCgUk1bQeF+ao04rtK_jg8KxD6Oju8vw8H-ZYt-7Ow@mail.gmail.com>
Subject: git new features: following and priority branches with new git flow
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear all,

After decades of using git (as dev, as manager and as a cto), and
considering different git flows I noticed some gaps.

Briefly, different git flows perceive branches equally and shape
history from developers perspective. I realized that if the
perspective is written from a devops perspective ( focusing on higher
priority branches, like prod first , than qa, and with least focus on
dev) the source history could be organized differently ( from my
perspective a bit better). We used the following approach for a couple
of years.

Therefore I invite you to check the following workflow here
https://github.com/k4hvd1/rebaser-flow .

It would be my pleasure to discuss new features in git and how this
approach could be used. Finally if it makes sense for you I will show
you other materials and we could think about implementing it in git .

Regards
Milos
