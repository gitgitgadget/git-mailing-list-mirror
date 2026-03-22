Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F890372B48
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774206988; cv=none; b=m1fbVFG8SfzVLjkm2mubys3cKT9hrqiR9jjCxSANK7IUgUxBa/ztn6rFk8ZvdR0DkJhXH+9mGiCcdLLrNL8OOQTI8wgrCo/Shzg3ojqKHQWvGcQyqrokOhxCz9NMIoleYYzFydKVaPaOWbauuVmDyya3ut+McqVJQAM6oZOCnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774206988; c=relaxed/simple;
	bh=qNqjxbvckYgCJRgOpKsQeusNbhhn+5LMkchyOjiM1Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVBOU/i7UDSDfez7tDBGrPG1M8mcx+1Z10FpGiGF704cysz1nNtNTpbbKvQ1DycfpFcBw3yHymskfI5HKYeS4giRw6fPCeIzWaypTOtGMMxl/MT89GXgVVXQnjX+Mt1atJINVnRhuIeDXFlqupTtQsvon6e/9miYxXiS+ka0Tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6Q25kdR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6Q25kdR"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so26867125e9.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 12:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774206986; x=1774811786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7tCj1aRiKhDRlTcNfGJ8t+zL0i4mbS6LeXH0cOqtpGo=;
        b=E6Q25kdR+OljA24Pu+jTbFr1KKcxj/KOk/43PeX/NpkrXJ4MG14LAGXUXFuQ2M3G4U
         kx1n/As5LHztde/WWvF19H5KKVMNir4hnWXrUWJnoNAUbZlIOM4nTgbC3jgdXzrNfNeZ
         632pEXMQVAyIVs6NgygygWrj4fSMWXu+cEpq+iP0uutY1fvS6m7jgxulzRUY9EJHKdg5
         jezI36AxYtHPj6JfYJ8L6orFq4YtVKw5kkTQiPhVNwPQZz2A9ccMjJfoq2DXeFosyjtP
         ZLUQ3l3S39tPpCs+cZHUh77JCuSrmLLYx9DskNMvgwr6OwRukGa7dJwNyOd+cFu5IoUL
         uAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774206986; x=1774811786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tCj1aRiKhDRlTcNfGJ8t+zL0i4mbS6LeXH0cOqtpGo=;
        b=LHL8zRv/KKYg8b8TjGUG9q6GwLcqkHZa9iL/oYKoSzVjRW/1lMoAs8BoBy5LCsJrT5
         +VTTuUGH9vrGSmo8DUr99aFKmsvboqPe3n81bizJ89n5RhGdrwpZR2ESoeQB0bxR6qX0
         WXUPGrZDizdJchhN6oUomqNJe659zBRxctdsY7WEA5Nwlkv2f+pOPu3z7FYOiMBS5xyG
         5KCYpUQ3QWpJMikXZ+JsVvWf25zMvmJ/RpkNGX0W5kRS2ykPTsaaTVMxARgMiXyeLel1
         JFT8crfqNYe8zEudQaU88CmFJObEQT1XpJf06OuEMT87f6mzc2JL3NdeY6dcoR/SRgvZ
         3Icg==
X-Gm-Message-State: AOJu0YzyoExqhb6mtftygvwB39wyt0u649nJ9gBzB/B8aGIr46QGaYs8
	8loFA8E5vk6Fc7uVdO4zVOu4tluGtglAHp5I1QGhY4mAsF470CxDniPsZHTjXvacrNU=
X-Gm-Gg: ATEYQzw0CjulQHCijH23t/M7+jY55nHBjClgyiXkkdy2/km+2JNF8dfLCZeMq+dQt3Y
	8cV3fp6GjoXimeYV7EOgEbEqO23fY9pifCz8FpVL/RPfswM3dZ84PN7i7Zrzon1v9j8hTaTJXr5
	HkZcjL7UUghtQxByB531HwsvCwrCYoggVRRv9Loojr3vb+uVxKurB2bjItf6XVERfdqx6jS5GOU
	4e0sGCVqGl1K36jJ/05TXTWc9hgnswoNuL4wm9UJA+Kz0ysG0eqo2O1CJgxQOXqeQMaz9pDqKgj
	RNY4u8O4LlF4vbY/Bd+AmpNnkdauEgrHBXw3uWP2M54FARz63Ny0Mr0km1EIBcZAAKjyKg+OlUx
	SH4rcWzofQIA7vBr1G+Tq+t1Nm2+CRDuJJAZYkplf5wO+8UpgbBamCDSJMKVmzIL+GfpZDTZ8a4
	Q6kLjxnS3OcWGqIIPNzcgT8dgVFtMB/uwxjJRcrguX3aM=
X-Received: by 2002:a05:600c:c48f:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-486febb60c6mr140286915e9.2.1774206985583;
        Sun, 22 Mar 2026 12:16:25 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe8359acsm224075465e9.12.2026.03.22.12.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 12:16:25 -0700 (PDT)
Date: Sun, 22 Mar 2026 20:16:23 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC PATCH v2 1/4] pack-write: add explanation to promisor file
 content
Message-ID: <fec0c24897092d19a718563ca4ef6e509ab104e6.1774205661.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
 <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>

In the entire codebase there is no explanation as to why the ".promisor"
files may contain the ref names (and their associated hashes) that were
fetched at the time the corresponding packfile was downloaded.

Add comment explaining that these pieces of information are used only for
debugging reasons, and how they can be used while debugging.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 pack-write.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index 83eaf88541..6a2023327e 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -603,6 +603,15 @@ void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_
 	int i, err;
 	FILE *output = xfopen(promisor_name, "w");
 
+	/*
+	* Write in the .promisor file the ref names and associated hashes,
+	* obtained by fetch-pack, at the point of generation of the
+	* corresponding packfile. These pieces of info are only used to make
+	* it easier to debug issues with partial clones, as we can identify
+	* what refs (and their associated hashes) were fetched at the time
+	* the packfile was downloaded, and if necessary, compare those hashes
+	* against what the promisor remote reports now.
+	*/
 	for (i = 0; i < nr_sought; i++)
 		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
 			sought[i]->name);
-- 
2.43.0

