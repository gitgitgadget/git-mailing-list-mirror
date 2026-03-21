Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBC282F0B
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774128520; cv=none; b=iSQWCgoSNx46Swtn/GI3ldUGvtBHu3CwiaOLV9NMzdPHEapzAELaDTGB1R5Ijr8AcAAHHK88z6w//38E6P4o6EkR2QGQHrujnTbCWCkgFrP2Npp+StOVZ1pA7xxkYKv9jdXsfAAe5V3u/Mzu1I+yh6hHFJdKWFXkxBCm3fFVpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774128520; c=relaxed/simple;
	bh=qNqjxbvckYgCJRgOpKsQeusNbhhn+5LMkchyOjiM1Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9XkKhJ8ckXAv6Dp6icF7fQyWDomQc9yisL0ID2m6pxbEoxQGMl0dLHRlWvQ6oL5Tyt0qFqIEn9/9heijPWfsqV/6wyFjxMNbkm1O8dsRzHhndd9Se1SpO8H1Qsw3+xrfkIXdqXTcw2FxWwczgrA4TAl1eCWZiGlWCl6WS9P10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUCNjwD8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUCNjwD8"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso1770085f8f.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774128518; x=1774733318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7tCj1aRiKhDRlTcNfGJ8t+zL0i4mbS6LeXH0cOqtpGo=;
        b=gUCNjwD8eafw1RRubVZEP6hbf/U+6KIj/w2ikKqQou3jXjqjwPKox7ZEN98B+aTN+e
         iEZmZfzYKliv5qOy0Y4oaGXLMxWVYQX4LPaoP31SK+owbSHOaP9/ieSt4X3rQAq4zYHO
         pXzTcZLyyzU8YoXJCRdqrxrePcxhDgmHO7lsMkDyi+qkxshYfgSii+S0dOoRhvpkaZxY
         GWvlSQMCVsFhCltV7huDXVGCldZA2hhCUv6J208hNXna2bZXtbCyBuSTKSdBzVkySDOn
         fsyAeERz5i4ezs/eMLYQw6wvK+JO/FZhcME8YH1TKrSs0lQwfWJdmqzTrSZ1ZjZuh6Rz
         QQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774128518; x=1774733318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tCj1aRiKhDRlTcNfGJ8t+zL0i4mbS6LeXH0cOqtpGo=;
        b=NsuRbhRw8TJYeEla++aSWh8XFTwa+XUbc9g+cEuuhV0FapeaLdfj+7I2kAHFquOn8O
         N7ZpP4VsEb4nlISIybcFIzftwWsG27BEVBK7m2mkNvPLtlxxeFa5v/A8xy8eqTPuIel0
         RHYSrappHHh/5oARky9QwuME17tgYcr8QVNJo0TkA/kmxVSpE9DR/EKbGOkSJBRnjh75
         LrWBbflpQQE8AylDWqhN9BK52ea3uc8nysb1haKloyJiaSp0K9KndKtaGbAUFnpv50Ec
         je30+Z7sF+dEccWPvrbA8ANJavKV6lPbmqRGfZJKvruThBd6KMfuJvyta7p1RWYhjlgx
         v9oA==
X-Gm-Message-State: AOJu0Ywho8jiQdQlHpT35KIPEjrZTg9VzsRzACKt5WcXk0DSwoNiXQyn
	uPBnRhSxIhtdn3x2VblqOBlsAGQk6B1/1QFOZthgL12t7OmeKMVMfo5wLA1pXyf/rMQ=
X-Gm-Gg: ATEYQzzOC99PaXHPK+0Q8XIM9gxlqVKic+egF+QkLdYQRvLE+yXK/h2NF3wt4O8JwgA
	kQL/zHphaccdr+m9DijRXT0O1K3mqqv0f14EhHIyiMsUIeWqIPZUc38DfzFU8c4IYlIba5BEWQ3
	WSUjPQ+kyECigjuCXka4uosYF8t7JBccejwcamqOC9hmKCRFDWi4OuO86wOlZ2Q1oBsWnzvNkgg
	/ap848maSbErFCgRzdFkKhVzdOLdzrm50OnAYnnRHurPPQdUMnRNRZlz7+A8Fwf7ShJnnbUAhAv
	38NA24L4sA6KuzsQ6/+kEggpVanZs/F3D0vtFfH8sQuSmsLLyD1iZDMHjL6a2707cajlT3Knnd5
	rCp2dRF2KQKXmf/Z3GrfzpjJVfb8nhAcWYEsdkVEN6rw/Vp9tbPftSJJzMfQfGSYis6G7S/2x8T
	JWOV95Ta0MTwZMJOD22R+Ij/ABQ+Tc+QS/Ial0E5ePYI4=
X-Received: by 2002:a05:6000:40cb:b0:43b:4298:3c0b with SMTP id ffacd0b85a97d-43b6427daeemr11073085f8f.30.1774128517652;
        Sat, 21 Mar 2026 14:28:37 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd38bsm16945667f8f.10.2026.03.21.14.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 14:28:37 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:28:35 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH 1/3] pack-write: add explanation to promisor file content
Message-ID: <9bba49563e809634e223c3b9d75496cde94707db.1774125871.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>

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

