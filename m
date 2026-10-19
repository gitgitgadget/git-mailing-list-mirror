Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424253;
	b=L0j1lgq9r6iUAZGDIHpfbllFj2SEuVXzLM2uiZ39sTqaEoA93C1i6dcPV0TqK/S830w4
	 HgcDx/ohRikQS+NjAN2iyBSNQX7sVhzLzpdDsXYvETO8kGAbU4FzzKWlYnp2H+JyQeVdf
	 nxnP5x08dC4v+mfBNdsRBcKkG7e0ZWLPOekgpdYiry3yYdfzPg0+nRvij/ExqJwV+LjZ9
	 kG2UtdhVbp/PXrhyy5zhe7CipVZE6JH861B6qGHHsVbsWH96dueqZfKE48ODI1Cw2rtHG
	 JYymU0+yPbRFWO+28DdD/g8FuRGlWx8VixoNbVdq46m6YvKomsW3UL0JWFjk0BJ/NrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/Tmuu2m18kvMNRv29H/8Y41MCgKPFgcB4WSd073BzA8=;
	b=xIHreTi+Qwu+tbKmJK/ynawMEPebZX3VuNlMFZ54D9lU6CkuSuUPvLXk1tloJ3ooZB4i
	 zusoyKMTr7tSbDR7YcZ8laocfpl3Vmbp1JNXjTJvMuZc2kuVjI9S/qMdfL1Beu0KsWYRl
	 Bj9N3Qxaqg4rUid/ao1ksIx6k68ul089D4v0UXVpz0WQP+N041QVacexABMPA2fCl3Yq1
	 hPnshCxHvdLPy95a9DSTQD7T5oNjSZV4UZECWOdpi7Wp0HajRjlPknCpWpvgrxs8MxEDK
	 RFP7AhN38cAPsN5y5aj4GDYhg2gRbL3fJHBEBADaHbSgooLUpbybJRbp7wI8ZJDS2Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pw9Vvw4R;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08809606A329
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 15:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08809606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pw9Vvw4R
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e985106c0cso15136035ad.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792424252; x=1793029052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Tmuu2m18kvMNRv29H/8Y41MCgKPFgcB4WSd073BzA8=;
        b=pw9Vvw4RNZW8oeBg7JlJqEkD6SirGPv/c3QplUuqi7lHYRWc5PGJ/prsB1qdG4AIHd
         K1sqc1xqZgS8g5lxPs5Y7q9lL44q/72f80a6D073WwBR6kQOlMbsJv6iCEPWaeHOcHlr
         nuOZs/Nwv75m3Yc8cJ/sdZwaoGOaFFgSsXGqhn9aHtMUYLISFfsIjuJSbRhFlgCGCF2M
         rz9+5NO2xKHbo4t3W4pbWwL6W0tSPRZjfgAwpuWRp2C/i/0H5uD3JwU++Gy2O3GEanS8
         mjCMQNzMFcYRjFFQNe16MvUmZHdz9lsJ/Kl7t7+2J5NJ8+W+4K/Ufaulu2LUyOuOQ1Vj
         XUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792424252; x=1793029052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Tmuu2m18kvMNRv29H/8Y41MCgKPFgcB4WSd073BzA8=;
        b=icMGdDm+gu5gqvRd3cqKhu5UQq9YDrk8VPJ9hA3tHUEJaFsIU3AoqVG7n99xHqHTdn
         RiUwIoJpvDbQ+TrlVmNwDyi2T/0s8ovJ0tyM/u5p8iPyS2sl52pRZrWDvzM2ZQUPxq8U
         xC/mU2ed17B390H4FhV4mvCiVH05M7w6CuPYh/J6r+HoOp1jnM/SwP88WHppp3r5XskJ
         US5/jLT4OWZ/2RRKOCSpooBlsaRnO3Pyc1uJo9UnYCylmfUM8l1tfxKoL/mOqcJHFVqn
         KoeQBOnfAlzXlfAr3+Z3SZ/IWKZMgrA+1a19GM+bhKdPUdhMo/9pCECAlvNsJ/rfImc3
         bf2w==
X-Gm-Message-State: AFq9FYIczHASbgQfPHQjANuoPRtLthZnrXjCTJw2ePq8hpHc2WgcRNR3
	wDB5gR6Cn4TSVuw0e5EIZV4hwyTztg2oK/bo+Y+cUdQU5vpAlMUCBr6SO9NTyazM
X-Gm-Gg: AYBFou2X/XsSt8w1jY+mX+BGw1BE1YoqfR/CAxDGjwXbetl6sXr+yIkYAZgXvK7LLl7
	kSoDeHHYtCLsT6SGVkfKO0zjYUwz91eJwNcNgGmdk6x2WduwW4bCop/xs0jVCGAj+YTI3jtho0C
	jwIaLFIbFHMELoVvL4rEd2zpco5E6AN/KKqRdnMZqGdufTJm+2UYZtWQY0ASjGmbdChcTMBtH07
	wwlvdw3qN7CsFe8Md6ywTd4QhQPBmpjh/gKy1AfNQpVaN9IvZG8ZbOIFX4ChForQMiLYZbbhfo0
	KCri/2gpGoAVUA5sKJ1ybcX3h1Lg97Wd7sb55PseemXkbS8cwWth0Bv63rnn7915wAGH2g5UqU9
	TLmv/5qghu7jRIoJi3jee0K/c7MCBV+MsU9TakUBWfpcwqbc0m/qSQQW3AywPsA0zRRElygj0h1
	j0wU5ktUyNzrAXQJaRjbla/ef5039yrx2nuUFDb+5T1sg9TMAJ7+Mnd7qsHQ74bswMi5RhsUg01
	JgoiN31RndEC6O2WT6UboNGhKxuoP8R13fYYbSNeL+b2gUFTR7YlZFhlbiB
X-Received: by 2002:a17:902:c942:b0:2e9:b80e:c3fa with SMTP id d9443c01a7336-2e9b80ec4acmr64192975ad.49.1792424252281;
        Mon, 19 Oct 2026 08:37:32 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea14caa857sm3193425ad.12.2026.10.19.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 08:37:31 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH] fsck: use Q_() for the verbose connectivity message
Date: Mon, 19 Oct 2026 15:37:25 +0000
Message-ID: <20261019153725.333-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f609.dirty
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

The verbose "Checking connectivity" message has the word "objects"
hardcoded as a plural inside a plain _(), so translators can't give the
right form for the number. Use Q_() like the other count messages so
gettext can pick it. English output stays the same.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
The number printed here comes from the hash table size in
get_max_object_index() and not a real object count, so it never
says 1. Left that alone, can look at it separately if people think
it's worth it.

 builtin/fsck.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9af4cc085..fedf8f853 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -379,7 +379,10 @@ static void check_connectivity(struct repository *repo)
 	/* Look up all the requirements, warn about missing objects.. */
 	max = get_max_object_index(repo);
 	if (verbose)
-		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
+		fprintf_ln(stderr, Q_("Checking connectivity (%d object)",
+				      "Checking connectivity (%d objects)",
+				      max),
+			   max);
 
 	for (i = 0; i < max; i++) {
 		struct object *obj = get_indexed_object(repo, i);
-- 
2.56.0.186.gc51408889.dirty

