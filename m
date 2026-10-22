Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647908;
	b=pv3sGiTEvBat3WwbtwBKULpTGrnlESEe5bz4NljxlAshxlHBa35ytjICKhpUPzByCvXR
	 omwLXj0rqpFOcsYxQ6ebeXLNqNgIKWDn6NMbz+CVwqbj3oLsrrdlrb6kYoj8O+n+Hmk2L
	 xgZAJnB47Y35DNNnRGX35jzh2rsWEbHlDQn8BzubHYGFfbbuf4CRa+XLcqdKplc9mAH82
	 JznUoXXTHgN++cpTkSu87D9FhHaLCWeVoCTc6BHdAQ6lX2pS79K977rXrDM78ZU+0Vxte
	 3X16noxEeDW7N921UxYX7vWkZ6FXTlDGEpVhJ+P9QwdxE7rUinoeZSlgqj45xg/C+6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=2GCTUumKtBJMMXesKclvV7s5K6UUWwMQSI+eh+dNKVw=;
	b=hRnVNrHqDonIxH/lefbvAXhnT1Rbi+Vbk6Oi5ApvM4qaMkDQVjJt8fY2BjIDUgVm4zCr
	 0UHavtjquzJre+BD5POcMI97Yf5Dl8n0RAJlJB8+rabVKS6h5+7ysPF1yuZt0bRcgvMd1
	 0JVWpBzDRhBFSI6245YnZ3v9FJBOUdWQ/xM0MWDmqAow+Q5OwVHx/1EKFcWOQZLhi2lty
	 nJfxMfAKky4SNFb/cEUp5V24ImVB0q2WojBCDfmL0Qmx0aNO2twdC1AQQA2/hFzEJWpvX
	 WcJ5EhFUAwU5Ty+jXclKn6vUjiF6Xh4qm4QtcPGozG9A6ERobE8Joc8K0GZkwsdHllg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nortesoftware.dev;
	spf=pass smtp.mailfrom=nortesoftware.dev;
	dkim=pass header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=aLwCo44T;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675B606A31F
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 05:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A675B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=aLwCo44T
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6df7f544919so839132eaf.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 22:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nortesoftware.dev; s=google; t=1792647906; x=1793252706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2GCTUumKtBJMMXesKclvV7s5K6UUWwMQSI+eh+dNKVw=;
        b=aLwCo44TD6ZQ5GyxGqRaKp2sGPHkDFSjLwobT7ttkw8+GMJf6nh55Z3dNuEgWv7KeP
         Gj56Fg148v6XR4f4yZq9iM8+oasYCokPeno1wEt2Ej6Ib9bfA17IQ5d+HQ/y3R5F6zQF
         tvPo05avseI7ifJfwPbOPoT8H6hIZzcFzkl2520xXhE6lbhM7HhOOPQa7Xa0miHGojE+
         qK+K7dZH391FaPyHLoQwkGfQnWQMzfYULQp1M1cIUETuMTT0r0iiJzYLA209CtCnofF3
         LQdKxvTvFLrLBZSEg++208423+iWdJr0wB3WRdLDeCwmueAZTrOgHyjg2Egst50IKIZo
         XS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792647906; x=1793252706;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2GCTUumKtBJMMXesKclvV7s5K6UUWwMQSI+eh+dNKVw=;
        b=cCaWKg2iNa+mD8GuXEJeFjSqnAvEywxMTDBi19BvW8pvpdgOKHTnzSL1O/bhHUlpo+
         LctLb8C5o9R6ydV5eqjEokELa3YZ88uUp22qD4lPr3uN9k9bRCEakfqf6QHeNTCEs3MK
         minyBSnbzcQy5MeVTFI9UF689eVE9wFBALFaU0bOBPPYOsw7o2xRZ3qDSit2twut9+kB
         JlbEifyqOms65ME0ZRHQci3GMAFb62UY0e85F40SF4HM0k8dBFm1aPePeUJE6o4agR6E
         DU6EjJJaliwUVwHsh2zd8wRpc874ev9GekKKKLVXHlHo4kfpBWNotppyeruWtG8UDKmN
         erCA==
X-Gm-Message-State: AFq9FYJz61/pwUo2fMlBMKkfmBuPNZkpax7XotQjunSaHXnwoWnWokvk
	LS06lWu4ATz+IXXyjiw8yH65igkbWmJ0gMOLZGxRc+VD5AZwGr8qtl1tnWD+k8tYCakLIgxTTI/
	fy+LZsQ==
X-Gm-Gg: AYBFou3V8LyUHriXC/LraILgRkzpc7QJKzOVil/rWpr9ivg7c8JJLyIAq+Wd5MB2IaS
	vfvBF02ntEFh7VmGZi9FJg6DhaY4S0ZIJ9tb/7C32mdFaens4NaqYZRkgaSMSxHquC1WWGXER6S
	wQlrCTifJyCn+SaDNvzPQ7KRcqWwVaPIcMnTBzeUqZJeQXx2u+K3bXvhJQ9OfNoEFJz2HrkWd/Z
	MPn80Da+xRiwGEMnV615ynkU0Co9DOwQ1N3zyZ5IpSOobAhht2p/wsJsjBPmGaVlYAcrOcO8oVb
	E/8k6ry+lr4RVU/FBpZw4B8KPBJ0IdEgb8+Mv1+xXkuZI8SpXlAB9z4cDxUgFm+Pt6BTpOPstwn
	0lcrmH7d5e0rqCVHM64OJsi/jiv2ymXyTQFH0ynn4wDHqkP7BtK+aTnNHF9JQaQB/ygzPdrlyqW
	k2OfvbmuMLBbn9tiWN07YDQoeZBogRyjtedVtAOuSEPNlwh3tfa6mkiO8Zsga4wvClZG2ZINabF
	KqoRmGOJNfHEMUu97TDgKN74+3m9+H7jDqoN2O/Y21Ow0qvXlBZzWg06aJZReKNbYf+ggVTjCBB
	s59s8lXt8sOL/DHKmNiynEUzpyQrLqabDZenheZFvTomXZmTQWFyRw/jTnnq5Y4=
X-Received: by 2002:a05:6820:98b:b0:6dd:fdda:290b with SMTP id 006d021491bc7-7094109ae66mr3059544eaf.57.1792647906211;
        Wed, 21 Oct 2026 22:45:06 -0700 (PDT)
Received: from nortesoftware.dev ([189.129.139.54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d611b409sm3879827fac.4.2026.10.21.22.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 22:45:05 -0700 (PDT)
From: =?UTF-8?q?Christian=20No=C3=A9=20Ramos=20L=C3=B3pez?= <chris@nortesoftware.dev>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] doc: gpg: say which date SSH key lifetimes are checked against
Date: Thu, 22 Oct 2026 01:44:53 -0400
Message-ID: <20261022054453.761650-1-chris@nortesoftware.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <xmqqqzhior8t.fsf@gitster.g>
References: <xmqqqzhior8t.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The description of gpg.ssh.allowedSignersFile says that Git marks a
signature as valid if the signing key was valid at the time of the
signature's creation. An SSH signature does not record when it was
made, though. When verifying a commit or a tag, Git passes the
committer or tagger date to ssh-keygen with -Overify-time, and the
valid-after and valid-before options of a key are checked against
that date.

Say which date is used. While at it, fix the spelling of "OpenSSH"
in the same paragraph.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Christian Noé Ramos López <chris@nortesoftware.dev>
---
Changes since v1: Junio's wording, with "OpenSSH" spelled right. That
drops two sentences asked for in the thread, the one on the time in a
GPG signature (Phillip) and the one on leaked keys (Patrick); say if
you want either back.

 Documentation/config/gpg.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/gpg.adoc b/Documentation/config/gpg.adoc
index 240e46c05..f5bb3cbf3 100644
--- a/Documentation/config/gpg.adoc
+++ b/Documentation/config/gpg.adoc
@@ -70,9 +70,9 @@ A repository that only allows signed commits can store the file
 in the repository itself using a path relative to the top-level of the working tree.
 This way only committers with an already valid key can add or change keys in the keyring.
 +
-Since OpensSSH 8.8 this file allows specifying a key lifetime using valid-after &
-valid-before options. Git will mark signatures as valid if the signing key was
-valid at the time of the signature's creation. This allows users to change a
+Since OpenSSH 8.8 this file allows specifying a key lifetime using valid-after &
+valid-before options. Git validates the signature by checking the committer or
+tagger timestamp is within the validity time range. This allows users to change a
 signing key without invalidating all previously made signatures.
 +
 Using a SSH CA key with the cert-authority option

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
2.47.3

