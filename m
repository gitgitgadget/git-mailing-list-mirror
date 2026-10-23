Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790150;
	b=aOi7CHSwK5K/U74Pl57A1UckWznC+aYn5YlntC5HIPfU5CN+3vOd+JwlgHcVDFjz8Qge
	 RDc2lRQDCYqyq/0V9KWslY8hY5zpOPR/6+eskjIXPFpgTjGpfUM8tfP/0rLLSPCLXBI7T
	 s+Bd32b5aIpRWdTpOGNFaMpSfmLIcmVD1MfrTffidR74Pd+km1zEYbksnT6sKZaxtM4so
	 UfHAPDwbCAc3CarewZzFeDkfO7NZRipbRGfZc2ERdepLToC2bV+J8mXDACKoXsK1yt/06
	 cbmEPc1mdJNEzP8+b1dB7/g7zUHD/14u1+zA75t9vRMXNG1Y6CnloMyQpWYNYAd/0Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2Drly+TOqdCLmgOAflfIJpViFoYXbCRyl3Dk7Ov6Wlg=;
	b=iMmTBF/ne4Dt4xuPI/FXNNlMq4yfAg+3xDxJ3lUL7A18FbHf0DgkaNe6ugIXxUKBAd7g
	 O2RiKdZJzZ4a5/MDWFsg90vf05eo4R+rRcSUf1nYsInwZuWLgaIanK7RkcPbtd1QS9D5U
	 j7AOufrQ3EHJ1bDYl88FnnJJ3EzX0nl5KbBOkHyOgNUSYhysTdvETxoHLok+gPiojLoFs
	 HUagZ9IvoPvwkuH73lA+pruvRP7KzTN/5tysJCy+YTVrQaFvbXg8syXKJncZYTGOPJlnF
	 ys3t6hFd8iRNc5B3K26lVqNO4FqJyXfBIWCu1LIQTFbFWuxD1uvQk1Ja7sSPzeMd0Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G5Luh2Z+;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD0606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14DD0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G5Luh2Z+
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso13064155e9.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790148; x=1793394948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Drly+TOqdCLmgOAflfIJpViFoYXbCRyl3Dk7Ov6Wlg=;
        b=G5Luh2Z+RWa/vEgTq4opbkH/1d5X6r2WDjQeEWiETek2O/2yEeF//qift2TkprKS0C
         zbajGmHhTmj/v5sBLfMCHisnuUjK6Q0XKbrWrA/4/TmXu+TsWWI71C79oEYCwu1dC9ZG
         GDlUSVUJLZ6Hwuu0QFchHQ9eIDwiJN+kjw9yO9iaw69JDM6tBrIeNaVIsTO6MHhy5AVa
         rTeLorNlrmSoUmKQkBmEkKtRvVcVpB+bQXts+rl5MSOvLcJGkwTgSY+4LMiLg0+sm6rb
         P6N1PJWoX5/pqZT4XyadmI79UD5PXn/U7SXsQ473zoojM0W5We4AGQyW4uZQfBehWH5/
         mn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790148; x=1793394948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Drly+TOqdCLmgOAflfIJpViFoYXbCRyl3Dk7Ov6Wlg=;
        b=sfdbr373DRoi/pWqjhlBGLnVRK3Ov2qAxC4RUCF+wk9koKh10v6z+ljDiUigCB6l0D
         j/dCUYeMTO8Ow1gE3KzfMwG0dYAmSFN5uMuw/EG7HG7cUlhDb2Ta2ELdhdRCTY2Q2bem
         EZXeLoLboABE2ie+HH1vxVMqlNyLvpDTp/bTpzh8XX4gsILI2V3AuPu1+HrKbX1+YC9x
         TzXwDtTOs6Zv+TTebB68L18fxwDbsWrqjdWKbH9/dVLbeOl0a1C6+xnnkgJ1/zfIV9vo
         Z6PrO9UksPsGqaAnwE1Cb7IDhNErriutJniOv51XNQoIcoeBiMXLYxwldEg9YauFwY4O
         spEA==
X-Gm-Message-State: AFq9FYJEN9Z1qPoaPG06bfrgfc1sYn7gGh9cZRK1KFQvzgPZAGgdIY0c
	wMeEUPVhSII91SztRdDIg3O8D5NmVZv2Ib71sHxxvqo2QW/LWJj3TczwOwNgFS4GL05jfQ==
X-Gm-Gg: AYBFou0w4CFcLM6vqmuoIEqrxWwP1R/R58+Zg+fnAD3ONjO+e3tF4nZbx8A4BdTMe+y
	iCax9OaQbC03jGnFcU7W/AMWduaawSRRi2FscxB7vdgNo5bCx8kgFZP59hGGDB7k7tUAgf466+/
	ZKrJjZckF0/Q9V63OKWG7djhtMb1uGapFcE1SVANkf7W+JpZoQfq+ghTGpFSnsk8so6zFnwnnE5
	rlnOUXce9JXicQiKTYMr9yVLoaHkW7bfhOxPD78G6zCRYW5BGPn1XYp07tKEvWIPzv4FI8XpTE5
	L9GVSmYBYRMG1gGC6y8iwtRiqXV8pG1d9siy2GVDbGSULYTinAmCU8QAweAXclWvcOUlCW+lTCB
	/5ye2xw9AjXLDSwctCiniUHSDI5kIMA2X7MYvFuSzYSxw1hhH6l5Ldq5qIEwbHPSlf8o1ShGPVg
	+4OX+etSg1QDDB6wKLGWvnuqEtgoFot+YAkUasThc1onvF+X1k0uvFTjeLjM3QWREx9GXgw51NE
	ctA8mFhEIfO3A08hFJK/x48Fz2m33AjQlC5azipaY97o+TdI39sWDiTbmYsny+OBhBeshknuPoE
	BQckAxBXIeHfFqF/JZmKm1Jx6ezufhuzakkbB5FpzhFg8kp1FJUUT8ozqzySQeWF02+WU29DrYT
	wUZcOQRqznC8MjyDYeMw3viCXwaxFij1kJ5b53k6ENYwUqsKLfqHg1kht
X-Received: by 2002:a05:600c:8286:b0:4a2:bef:ae5f with SMTP id 5b1f17b1804b1-4a35ace0b88mr1123885e9.29.1792790148234;
        Fri, 23 Oct 2026 14:15:48 -0700 (PDT)
Received: from localhost.localdomain ([102.88.167.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bcdsm334600f8f.13.2026.10.23.14.15.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 14:15:46 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v3 0/2] checkout: make unique_tracking_name() use the given repository
Date: Fri, 23 Oct 2026 22:15:31 +0100
Message-ID: <20261023211533.73433-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022105641.68963-1-okhuomonajayi54@gmail.com>
References: <20261022105641.68963-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unique_tracking_name() takes a repository since v2, but it still
went through the remotes with for_each_remote(), which only works
with the_repository. As Junio pointed out, that gave the illusion
that callers could pass any repository.

Patch 1 adds repo_for_each_remote(), which takes a repository, and
keeps for_each_remote() as a wrapper that passes the_repository.
Patch 2 is v2 with unique_tracking_name() using
repo_for_each_remote(), so everything it reads comes from the given
repository.

Changes since v2:
- New patch 1 adding repo_for_each_remote().
- unique_tracking_name() now uses it instead of for_each_remote().
- Dropped the sentence about for_each_remote() from the commit
  message of patch 2.


Okhuomon Ajayi (2):
  remote: add repo_for_each_remote()
  checkout: pass the repository to unique_tracking_name()

 builtin/checkout.c |  3 ++-
 builtin/worktree.c |  6 ++++--
 checkout.c         | 13 +++++++------
 checkout.h         |  4 +++-
 remote.c           | 14 ++++++++++----
 remote.h           |  2 ++
 6 files changed, 28 insertions(+), 14 deletions(-)


base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
2.56.0

