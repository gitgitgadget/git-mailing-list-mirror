Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87B393DE8
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327171; cv=none; b=VAF/FNOQDmggrWch8epWvjH79/11m/DW/dv/9plTe5W1WULbXbQZfV44UgmbThrNhsvzK4C8vqHPSZ/zwWStrSHkiDxBcZDOFxW4V9zSqTmeOjTueuai34tIRMlv+KKOSqYFgEgicehjxZOUqbOAG308Kz5EHuZYJa87M8B4yU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327171; c=relaxed/simple;
	bh=0LHdsimwVpCx2b7qcftg8aF53seEoTa6kt5UjSFV5G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wp62nTbTMvD43pn0XMU/xc8yDMBxZfgB6ey5aQJU8wrtkkV1fnncQOUivU5+XGFsUXXTW8QoYLUUv3H4ZVzU/Tarc2/xXOqLTj4kXUawuCjJi7r1wJYsKOH7Z6X8QjKRlPHml2FNkPJxZGV0o/KJ1NBMwZx9KMNrpeiYZdWL3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBIetsgm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBIetsgm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f1bc40b35so85388745ad.2
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768327169; x=1768931969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqsCGBxoCSZopv3BM4vdIQG/Ae2j9zqiaABhTRo/sk4=;
        b=HBIetsgmQSLoM23MY6C4/GKsrhjLoChgt6KJKsAZLjZqD2nQEsRR1n7V9fbDe1bscF
         OKU18nVGnUPmUUqjmDWkSkkDy3plQUz5NYz5rJ2dHlTfBEBhObxzX0Zjtd8DRqQHM551
         jB9th+p4QII0L8GX5lDh4DSgxsbpZX0QaHVL0ghP0wrNZ/rt5jx3iVCRLIFMt5oM32mk
         A/ChAvm8nd3TPXcGIlutPf7ZAUxr9kxmdFWRDkZkfxDCyI8nNBfG5biXYWYF4+fXsZ/N
         wjZSjWyUV1cJuVxHF/QL3ILgq+50Ccx87CW+LMXrzL3FK2+y1N/sYLqyQxcKhIpQ6CU/
         bQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768327169; x=1768931969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AqsCGBxoCSZopv3BM4vdIQG/Ae2j9zqiaABhTRo/sk4=;
        b=iEOduXBMEnfXZlMPfdhSiPkKFnfMEp0jAao0S2Kviv2YeuNekp9iApMd8syQ4ZLSfr
         1o2+CBnhbfMxHY/rlPF+TikliI9IbTf2We4q9eEeKXBgcQ7Xpr4cFtKWMJ1R0ruztHUk
         D29EQ8ZTrzYHo3s/BYApLUXq8LV/PT2g+Oj5EzyHWtI3c10rmzg7zRRMzz5+YljxNYeq
         0b1fRDVpmVifWb4AAt/oeiJTmWSOTnnTm6ZbFJoExKVT4IUyDhJfOlnUUf3eY/hOAqXY
         tALROWB/tZvJfdyiAZp16/tmRILuPUeDZ3qjCP8Bm1/ZPq5/yIy4Kws+cpyKRcCAeyWY
         QvuQ==
X-Gm-Message-State: AOJu0YwKkQlZ24kEuHrGunyM5L+N1FvzsQ1BHeGjRzzcbK4gI8DhI4Bs
	PfE6oY+CFI4YVZycNuuSDGTkUaNMEGiuMxZwMnSZ9yWKtdNIkGUcycsX5eokcg==
X-Gm-Gg: AY/fxX4zWInYsgma8OyqZWCMYY4CdKUJ0hv8pzS7qefTGNM8EA1LJz3p7KcF6e2atoo
	35zzCoOlWRMVKM8mUYPshIiZDemVvMM0kbwlnWrs2dQ4nplUuH+tCsk+3zmwa/9X2puBkwAtv5t
	r1tAsHfzsH3agj4npSRjghVm+d0a/C0juPDhcY1Mh8dEv30axcai11L7yZatSu1pGeRgb5+aVO0
	jEtWKbe5Blbl0RUbC6icIXTX20AHV+XYTRC8wBTUkKp+BOd/4T5EVK6Ia8mkAQZZ4F1KMYlRkij
	+niVnNWiWR6RtIxAI5J5IY6Weu+OgzaIC0V4f15y2K50R3S7wmET2s7A1AfVVztg2m7+cjx0Myn
	KxhfTvRdNdjy9V74WXy6tgJ1+tMZ/w4/rULk6eJfw/UQC1TpO9ZNHVP65CB/KXhByxMyZ9VZn+2
	meFBi/MpzdN9kl1pXpP3H4UkBWWRODuZMZAhK6EnqZn42Cyw==
X-Google-Smtp-Source: AGHT+IGEA7QqSlvFzluN2+PQLQW0Bgrsr+3D2oRtOvnQ4y8AgEvcO4jcU+Vt6y6k9iXFzcSJhD4khA==
X-Received: by 2002:a17:903:1a8b:b0:2a1:5785:4417 with SMTP id d9443c01a7336-2a3ee487487mr211830375ad.34.1768327169408;
        Tue, 13 Jan 2026 09:59:29 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:d0a1:c2df:cd9f:7f86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2fe3sm208476265ad.59.2026.01.13.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:59:29 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [GSOC][PATCH] t5500: simplify test implementation and fix git exit code suppression
Date: Tue, 13 Jan 2026 23:23:03 +0530
Message-ID: <20260113175913.474414-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqbjixljfg.fsf@gitster.g>
References: <xmqqbjixljfg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 'shallow since with commit graph and already-seen commit” test previously used a
convoluted here-doc that combined manual input construction with packetize, echo and
embedded Git commands. This structure hid failures from the git commands, as their
exit codes were suppressed inside echo command substitution and pipe upstream,
also making the test harder to follow.

The changes simplify and make the test more robust.

* Assign the results of Git commands to variables up front and chain them with &&,
so the test detects any failures immediately, avoiding any exit code suppression.

* Use test-tool pkt-line pack to construct the input and then pass it to git-upload
in a temp file, instead of relying on here-doc and manual packetization.
This avoids formatting issues and ensures correct v2 protocol guidelines.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 t/t5500-fetch-pack.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 2677cd5faa..62cf0e1ff7 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -892,15 +892,20 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	test_commit other &&
 	git commit-graph write --reachable &&
 	git config core.commitGraph true &&
-
-	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
-	0012command=fetch
-	$(echo "object-format=$(test_oid algo)" | packetize)
-	00010013deepen-since 1
-	$(echo "want $(git rev-parse other)" | packetize)
-	$(echo "have $(git rev-parse main)" | packetize)
+	oid_algo=$(test_oid algo) &&
+	oid_other=$(git rev-parse other) &&
+	oid_main=$(git rev-parse main) &&
+
+	test-tool pkt-line pack >input <<-EOF &&
+	command=fetch
+	object-format=$oid_algo
+	0001
+	deepen-since 1
+	want $oid_other
+	have $oid_main
 	0000
 	EOF
+	GIT_PROTOCOL=version=2 git upload-pack . <input >/dev/null	
 	)
 '
 
-- 
2.43.0
