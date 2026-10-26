Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999123;
	b=X9oxCFrE/GUfnQr6gVSIq0e2YlFIwwZl5+NyYHBG1UGtRx/Ia47LFyyhEyFFIjYfTc/+
	 h0E2GHc+6Lo1sx1HwFPTnp+OgscUdidpawnHgzHGgub0FvITpD7iy5GgdKxk+ns6MC2U9
	 rS5bpZzeJFh/DeNC4mYxKE8cGHB3lPo2hgZBrXBK7q62X9UwXKFLmAq53DpjttaK7sjFD
	 OSBqsXZxsangCNVHlfCMw/XqUVzPQhBvSYxMH3SWykawdZZ36tn8gN2fw1usghWp/c8B8
	 uJdN5UicDK7rxKI3EvJGUlfaLqYRKL5mhzfSYrFq3j9+/dtBy6EOE5DO0hT/tF7u9tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=Q7O3IZWlf2gvFFppvDy0G/zs7KNS7CLn3MtK87bpgMY=;
	b=JntLG6nnnTH+jghktde1W5GbMwHwcj6CWLwKdUPWyhK6AKq6gP/bEfU14gyJim43Li4g
	 eG+HR2gayPBykwtLtZgftZ9l7aaGyZGHtGn34qyUG2jdvFpg6WW6mivjXtkGtd+yX4nYf
	 rv9aTS+nD8XeuW0KvIcCRAmc3eVOr7qx9z2nTvjIlIt7Q1KHEcAjLjwuMkZrPEM3K9pGH
	 lOmpRnv67xc8nOHyLjeFge+j43RLRAAr31HAQPEuU0HooYAsgIPk9CLX0wZdW4XdvcV/L
	 2zuYkvFOBeqq8yAZgQMjHDIJHdGX3FS1pjvPsWYTu/rVMUpHmAwXzBk4XStEFPp+5KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UXDcmcxT;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C8606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 722C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UXDcmcxT
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4491779eec.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 00:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999123; x=1793603923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q7O3IZWlf2gvFFppvDy0G/zs7KNS7CLn3MtK87bpgMY=;
        b=UXDcmcxTCtJLSa3wLDbF2AmMP/bMJilfU+ms7DHGfv7GmrwJBEB23V+XLt5RoLbuWA
         3b3M/tpaxFMgFSUGO5Q9EK2u3LaQaM6NXT2/Z/GYFanEZ0Xgrt//7ShdddvVWi5XOmuF
         SVoBddHKtn+bczBhYOQT/OySeAZKsCzlO20YprR9389ncOMnawocmXMQut0XE1NH2jyr
         sqFCyZXE9XAnD1AAJXGOVHmpbjoVMMGSzlJXQTw4G1rNfhr5z6QXB/LO2K7OIkZhAXhu
         XqDSOg+5B36qaeVr2LxltapKvx5c64iuRdoyyBpT3R6tXisCUY3OshgB/bckMqvS4p9P
         LesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999123; x=1793603923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q7O3IZWlf2gvFFppvDy0G/zs7KNS7CLn3MtK87bpgMY=;
        b=uRUjJLYDYuYHBjU5Qe5jimghQjpvNjr+csjnO4wmFbL6iAvR9sHvtpI0TsaO7hpLRo
         76tzmbfayWWa4ar1v0fnXxlsV1CPtHo9ds8OCXm+ELhOJZ+4GWQazX3zB6Ro+kwYJWN9
         Lb0INcO/ayTU/zeVPRJvgyWnqaw9CRnmXV2SW1OaL9rP/GGlLRXLM+sZ8SETnXc8uJcO
         4BzvlNGRaUvAMbkZmXT5Kcor3K8qZgyzbxHQr3PhnQPclku/2YjTQqGBZd4AaOPu5aTT
         4zYS8YKd+aALS5xV53d9eGiKl1zN1KPQhDwP29m8G7fadCQFa3QWcO1XOVuCHzS7DjkQ
         MKSA==
X-Gm-Message-State: AFq9FYK3430XODTWo6KPcYSObOI4F9DUt34ak0HUzznm3A6o+vKBL0X+
	zfwMIkNeQke5QCSI3LNBBR9jXIW8blwDMJnK7DHmfBSeaDbFQVAPCpb/
X-Gm-Gg: AYBFou2MW0qyqFGr28qpfDkabTceAwK/KKsR5uIaOvN3rkYeDyiaVmQgo/ebzK+CXiG
	5NCmagOBUc48M+W8ZUEupnYnJCFq+8Avz3lhUFQX91HifSzWFNKbMxGN1pnW69W0TWfew/0M+Wv
	E0pWvklLMnS5r3bh2H/lOgFLkip3nsYgthbSZDFoHkG1enUrgJBu/4uKWSrYSQGytKB/L11uz4W
	+nQtWTIH9NBnHz/GaI67kyXHwG2veWeVsFwlwgKOrfMZP5ShA890SoPV9ww7gYzf8JEy2OujZrp
	RPAdfVPtGKzdgKObHjxsYHRQ3+chSMqkqjPRwLz4aBC89YQNEO725LWQOfcEc8CFNvTQIIL90JO
	4W9MVumQH4X4EIgXWkF3jV2WQWdfeOXohFlAiI4UNTHbuuts4EcENCqxfsF9DbscVYISMWAQhT9
	NQfrbzkPA9+zczlzI9I9RjofJyagf4sQFM3M4NMgGxY7MmCXFDp8zTm3TlLB6eplzV317jr36SR
	XeyN4NzNNJf4FLVZ09UtzAZQvqqEikFfxl+iV/n64Eg2DOkGKv2ziMrPg/KuSPs
X-Received: by 2002:a05:7301:4c92:b0:341:5da1:7851 with SMTP id 5a478bee46e88-369e845a2f3mr9032377eec.12.1792999122392;
        Mon, 26 Oct 2026 00:18:42 -0700 (PDT)
Received: from [127.0.1.1] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a005c0188sm8871295eec.9.2026.10.26.00.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:18:41 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Mon, 26 Oct 2026 12:48:22 +0530
Subject: [PATCH v2 2/2] unit-tests: ignore --long-tests
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-ks-unit-tests-ignore-long-tests-v2-2-eaab5657c19c@gmail.com>
References: <20261026-ks-unit-tests-ignore-long-tests-v2-0-eaab5657c19c@gmail.com>
In-Reply-To: <20261026-ks-unit-tests-ignore-long-tests-v2-0-eaab5657c19c@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.13.0

In the same spirit as 9faf3963b6 (t: introduce compatibility options to
clar-based tests, 2024-12-13), we should ignore -l / --long-tests passed
to our clar tests. It may be passed along while manually running tests
via a command as follows:

  $ meson test -v --test-args='-ilx'

So, ignore -l / --long-tests in our clar tests.

This does not show up as a problem while running our CI as we enable
the expensive prerequisite via the GIT_TEST_LONG env variable.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/unit-tests/unit-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index d066c8a4c8..06ffd0f5bb 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -28,6 +28,7 @@ int cmd_main(int argc, const char **argv)
 		 */
 		OPT_NOOP_NOARG('d', "debug"),
 		OPT_NOOP_NOARG(0, "github-workflow-markup"),
+		OPT_NOOP_NOARG('l', "long-tests"),
 		OPT_NOOP_NOARG(0, "no-bin-wrappers"),
 		OPT_NOOP_ARG(0, "no-chain-lint"),
 		OPT_NOOP_ARG(0, "root"),

-- 
2.56.0.99.g5a7d1e8045.dirty

