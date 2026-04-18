Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96A33F5BA
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521820; cv=none; b=EgNTyJTXQNYkETwyLziy/Wz0klzCpHviSdCNAkSpUWIsNkEDlq/U8//k95Qus15v3iu1Ufqr7Xh4o7L6evO2hikDiqAgTndwRaUWG0lgq2Rngm+1CtoQAJhq1072RhgIy0aQmGcqQFfXNB8w41OZwxesGkDz15AwsDBVf9Lexew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521820; c=relaxed/simple;
	bh=5qpPWc38Hp3uf49zg6iaCXprGyzjYkaArycpgXU6zhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h549KI3EvDwyc++NSNFj1uteznRRFSilxg/DV3kLyLhRzJgK3zxFfHuVBlzFWT1rPneP6jTQMvsnqjaoqIN1rWqcLmIGafipm9vbI3VLA0TJkVJsic1HzWvHmBR5DsjkjE5n1cMdIJeTqZv9i5JcWQs2wJX/S0/UoxpkFAJC2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWK/VanM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWK/VanM"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43eada6d900so1547153f8f.0
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521817; x=1777126617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3daYD/ZZZHYabv/qm6nyTmvkGHBGho0/tzYckTln96I=;
        b=XWK/VanMqlCAdfbiX/6vHds0HDT8269dtE0vSaXjcMOykCx3YaU4WY++2QX7GTpGHE
         GQTgqBGuMNihC4MBzg5qlLBpNzHX/HaywNccnDr4TEHyphswg3mCEkZariR/F2bYeIi3
         dk7VKnTf6R6G6cUrfkP9WGEHQ6KrFxMEbmPbLKEpgJU0I/ofiRCl+uqo5q47mD6YGeEr
         1Y/GZYw+4WL7yLY6AYx7CdpdlK35wVaglUeeoWbmEo+X0TDzEcjGHWAYYhxX21+zb46y
         S9gAUrGarL99SPdADvMFenMTdN8LwnXumeAygmkVrqClF6/wI1Fws3ddI6rbFBCwh516
         v9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521817; x=1777126617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3daYD/ZZZHYabv/qm6nyTmvkGHBGho0/tzYckTln96I=;
        b=qLte2OHHHNT15G5sbtinKchyIG7dhkO2jUUaydvgZM+ogIVp4clTCJFIxHI/S2zc0c
         F1e7b/j2phG+ycVO9yLM0rI5gXtRq4ZwoXjj0ZuBynNgGpv6i9+wSxCkyCYcjSsUcga9
         vPUP3u58TQR2ZsejnlhuBGdLokF99K3Vjn3Byju5mRcXBT4lXFSVVWsw6Inl89NY0zYp
         pmIcL74BssrBHQ1eANpYBD7V/tTsHQ7Ze3C/CGXhiU1lpJR0BkMxCmPu+4ZZSbbYAqf9
         RgdGCylaYnB8fzTeL7bPwfEV7Ccfjv4kWzB+ISTQe3qI7tVbUVqPfOGOg+nOez2QJwSj
         fvmg==
X-Gm-Message-State: AOJu0Yw2lkfyS1O9XTViwmJnukIPQSPTanUaUhiG4qpttjiI8nrbVY27
	91/Vkd4DjS9FW62kp79+j5UjZRqGcb1ksWcZtWIod1QLgAt9X+FZfjFIw9iizA==
X-Gm-Gg: AeBDiesjXkdIyopmjZDYC5jWYyw2u3tyX0l6tE5f8p9gPzkQ25vAZqcYzu+kx1Yh568
	x/O5tCcFJOJDVjeft5wZskFrvYZoi71iusWz8ZuiSAwfV325F7hxLMwBI/RPNgHC37vtiLE6jRd
	sz5Nv/dj8O2Zs8mdVu1szR6eghBMBr7wlKmAYzBIbgOTrUY/SaI4DQKQ76oT3eX1fqwmmU3623F
	H5Wtw8tcUgXyoP+oIKiqdGZcTS9dt04fKlBoq3hFNItgdFCqZJV/IqeUsnWOa/cxnHKeSaroMrK
	QKYL7E7/Qgz36c+j+aaaUMMrlSP69oZBdqzHJicvnOlRSwpcOGes9BwJLVtwOjffIqGd1sRUrml
	dtknsyqn+mS/BdYp7sVu1NrAOQ3WsP2u4V3EezpEVoYrGjhDYn9554eTpyyskBJWZIDm+RsW/cb
	Ixh8UTw0/cusjIcsS05tNk69g8DwCXtve2u1FdaH2EXKuSw3L82fWwocgINZZ7/iwhzH55YcwLW
	WHpiZXaGr7z4lRpYOc=
X-Received: by 2002:a5d:5f43:0:b0:43c:fde6:212d with SMTP id ffacd0b85a97d-43fe3e13d46mr10402825f8f.33.1776521816937;
        Sat, 18 Apr 2026 07:16:56 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm12505310f8f.31.2026.04.18.07.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:16:56 -0700 (PDT)
Date: Sat, 18 Apr 2026 16:16:54 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v6 1/6] pack-write: add explanation to promisor file
 content
Message-ID: <bc1e3eb244117ed0ad8a7fd3f2bf180f085eacdc.1776384902.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>

In the entire codebase there is no explanation as to why the ".promisor"
files may contain the ref names (and their associated hashes) that were
fetched at the time the corresponding packfile was downloaded.

As explained in the log message of commit 5374a290 (fetch-pack: write
fetched refs to .promisor, 2019-10-14), where this loop originally came
from, these ref names (and associated hashes) are not used for anything
in the production, but are solely there to help debugging.

Explain this in a new comment.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 pack-write.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index 83eaf88541..b8ab9510ff 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -603,6 +603,15 @@ void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_
 	int i, err;
 	FILE *output = xfopen(promisor_name, "w");
 
+	/*
+	 * Write in the .promisor file the ref names and associated hashes,
+	 * obtained by fetch-pack, at the point of generation of the
+	 * corresponding packfile. These pieces of info are only used to make
+	 * it easier to debug issues with partial clones, as we can identify
+	 * what refs (and their associated hashes) were fetched at the time
+	 * the packfile was downloaded, and if necessary, compare those hashes
+	 * against what the promisor remote reports now.
+	 */
 	for (i = 0; i < nr_sought; i++)
 		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
 			sought[i]->name);
-- 
2.53.0.584.g6b87e8e9dd

