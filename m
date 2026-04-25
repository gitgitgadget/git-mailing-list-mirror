Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE8330D24
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777137896; cv=none; b=p0UYpyR9F1hkAPOKX/RJBitV8UZpR7tUWYp8WIm2pmgPAbplhdQmq2gfrYbHydiL+NT0xp1mF/8AQWMSYdO8iheOBaGOE84+qmRQQ3dMikj5bU6W9xlIvYZImgx6HcPlQKZU7krdptHLAjbuSqnwWh70ZQ9sUVAs3/d3EwXJLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777137896; c=relaxed/simple;
	bh=yFYGNfPTjEkt1qI25MEo6ddS8aIZPGvBKXOibc0XjhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnRe5S0wwO7bgCH8M1aU7NLdNvXWLYFo5xmYdbCnmlaW+hhitq9fkQazkI8Q60Od2bb8mMxA7LTwzs7u2R2qxoCV4RJJ8Q+6wE5PjbHEOdxKhvvPgeXcBWjrZr2px8sn/kT1iBVC4JkNVmMMl5BzAljUOdLgkYnPudEqUUKRMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5ixYnWP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5ixYnWP"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a3be187ffbso9119773e87.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777137893; x=1777742693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFYGNfPTjEkt1qI25MEo6ddS8aIZPGvBKXOibc0XjhU=;
        b=L5ixYnWPBBu2kZmvGTUTXIohC/N4f9wwPbQFG+ls2RpGoWAjimKLKBuNpAi6zr5kLR
         1jd2xKjIqyDCdVmX7W/YKwtOR517vo/wEN8YDsLkVFqr40KZbSWCLoC5eQSqcJZvR9Ko
         x1StIt1y+Y8VIjjTp2uuycLOSbXGJlM0jRgWfc7OuxcxEHrjwg4+3r77hn9K/sqPVA9G
         lyqtGSKOD0Len0Ry9xdZ4Uo5zsDZ+geBSk9HrLJTkPLj/nqkvniIMpP2NOR/o3AcPec2
         n9XAPlOfPSaG7xTFlTLXRjG8UU8aVLcBMkyc05ifVrI32G18chGtAVOQZkdAx4PsvYY2
         88lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777137893; x=1777742693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yFYGNfPTjEkt1qI25MEo6ddS8aIZPGvBKXOibc0XjhU=;
        b=HV4aVwAcFEgSLA9aCuz0YpHbjIWuh18tIDmDY09wh3JuST9xecYZKKXqAFywQqYO7X
         9NxYcm+ZUWY9T1fozKQ2Qep5WGz+vR7byYeBfl11mZYliSSo33M4s8sfwtZWiuRkBs3/
         v/896NYTz4j+C7ODTKl84kzHwS4rGruMJ8VlQBIbLM7VZBMiJiIsURr1dGQh64GG/dLr
         MeTc3bXAXc2wt7Omh6LE9xS6mIUYKz0cZ4J5g/5rG9Ak/8m+j481DZ8n7fHaLrgdneLc
         6LzyKBmSH1ApA0ggrdLw816xhGdbUj3T+2eQrsWycH3W/XLJ9vHOlPEBbDxjUp3SqLqs
         iIWg==
X-Gm-Message-State: AOJu0YxVrohfQrokPyEH+HI5m9TuzM5BmHsLAuzQ+7SM1IQeNngWyv6+
	qCDJbwdCQ4q7OrV0dsOccYdCOHU5mbF8DR8FyNqNluIeLlQwhiVjPEgU
X-Gm-Gg: AeBDietJAvffyu8AykotBFWRer/e2aaZEqE0joWOSeUTMWZFSgHlsFnHuMFXRjOtUvF
	k3JhCZDqSeJPfcZGImre5Oo3FVySDwphz/TsMOrhiA5MIYMwhf5geGGw8rACErd9580WbWG94LT
	eahKRDJnmh/zzEVIyqUhj0G6IvLQsS/UjpbaQS46yFlrRzoGAe0uUkMHqKKSmXkFiX3JVoAaJud
	xpIM+QA+OFQkMDPv/gkC06hQ8ixij0u6EqBwnmPqPRIi45y8vvWqjwblyXNH/lR3c8IthuS8mp9
	0x7gFpunOCxccyJGZ1q/quZgu91JkieCcYPgb2svMkt53UPF7egyNRW9q1WsNMAjv7hdS3g/umy
	Ny/xp/daKP4zgIbEgQhNzYbcAVMdd7I35ywDlr4vQkDKuv+RtSNU2tdDtWgLYbsa4Ul+Dri4AuX
	+/llD9Th+kCVF7t51g6D1ulpPiIw+Mo/Jq/aUUOPDvtbTgr6iSdTC2LluZVzsVD/SEXPfTJ3tCj
	y75FKZVsVEkhmOPRQIxTDcubH8=
X-Received: by 2002:a05:6512:3b8a:b0:5a2:c66a:d6d1 with SMTP id 2adb3069b0e04-5a4171749fbmr10424104e87.6.1777137892818;
        Sat, 25 Apr 2026 10:24:52 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7be0sm6722896e87.67.2026.04.25.10.24.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Apr 2026 10:24:52 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ben.knoble@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Comments on Phillip's review
Date: Sat, 25 Apr 2026 19:24:51 +0200
Message-ID: <20260425172451.21365-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <CALnO6CCNoo8y2V5KmE0KQ6qDurZELipFowcr=ZpZ3ocVB-uLjA@mail.gmail.com>
References: <CALnO6CCNoo8y2V5KmE0KQ6qDurZELipFowcr=ZpZ3ocVB-uLjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> When you realize this, "git pull --rebase" should help correct it.

Sure. I always run with

```
git config --global pull.rebase=true
```

I love rebasing and recomdend it to all colleagues that will listen, but
it still sucks to expose yourself to a possible merge conflict when you
realize you worked hours on top of a stale main branch.

> I could certainly see this being convenient.

🙌🏻


Harald
