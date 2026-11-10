Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337928;
	b=qkUfH5gNXlgSDgBPZAm5/KPnq+qmZRSDHdT7RcG0uM6+DlDZifaLGJ1JjAFie6xg3+Ef
	 ejVj32eAGhjDQv/97GLlzbaY8ndc2PfpODmyRO3nk8hph0v3E6vDwoHM3KUfA7PHLHioL
	 kv1Az88ueqmKDEnPf+Dm94lnn4qU/YaWuzGUhRZaKiwJn3lG2rg8ZVXZneVbmOiOKWh6v
	 OJyORM/9KKonyuPiWCOwq+hlaMkDyc+xxZpahd+uYWWMkPzykgdgSKcRjlLvZaSm2ZHm3
	 W3OzjgikgdaoY7PyS+R0XC8juPT1IYfSBCjXEWXF50/1VgtpIXPzwM8das9DVnaWpqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=iAFuggf6ralwnUqg5nxvcbUYeiNZ0SRJtuOrGH/jSyQ=;
	b=io8eaAE6bVqxqUg0ZW/nUShV2w7gnkbRZcPMTw1HbYAlIEreY20PcjsHC305q5pHPdOq
	 Aq4IIdihv4XAcMMdsJlf/LI8RGp23oip7uCAgMNGdaRDvZYtFC/06yB78TuGWPME7WfF0
	 v9Y2tWPnGs6/N8haXIIaLdX/HLkIrUK7R77KKd7eFciAwBuE/pukDHDVZFT5RYQaNAdQC
	 BQ9HX0j80vJRNoXWwF5fDCXPCw+k5SINVlXfgYjbvrjh3UU9w/p7iBAx8fTYaeDERZtBC
	 dUgLuX9sKY+Fcn6qINZfDfKc5P1lIOPLP8QNbQcPrUwfNBZeRAnaRtZOce6QzfWyhLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZgItQPNo;
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675EE606A33D
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 19:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 675EE606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZgItQPNo
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4f699fe49b3so1653371b6e.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337927; x=1794942727; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iAFuggf6ralwnUqg5nxvcbUYeiNZ0SRJtuOrGH/jSyQ=;
        b=ZgItQPNoX85wV6nOAoBaXl1eOgPBMofu5RW1xfRVyHlshv0I03rDDBoj02v+94DDXF
         epFzrPkLEajnYsgF9vEyhhXDwUzsiZeWv7yA1LugCgM8089Rur0DdJp9WUOqEKZmJHRB
         1Y8y3mOmBR3/H9eLBWDzc5zkKaSYEkd/EtJ388wIAAGBSwx8Ab4q+5tKCo+qx/3mtSbQ
         bLObrPN4RwG0nFvskME4rMf+ZrNlwgQL1jEPd/l4eSuobw0oFIEbkWBOFi9DpDDj17mu
         W9YnNPmqpKPonLp8O2IjT2sAVVPgX90wpo0oN/pHcfAEFsNMyexCcoZsJEa6vQr73c7g
         SQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337927; x=1794942727;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iAFuggf6ralwnUqg5nxvcbUYeiNZ0SRJtuOrGH/jSyQ=;
        b=QnH9ShgD8FP+a61WsYDabLfDnhJGuMmHbH3VEtsyft2BdFFYxwq7D/tdQbI84ijNLO
         8ixwPKFdChsKnPhj+dkzE/0hpTDii63mLwf3TlSgi3ke7tdgaYL6/35qnhOw8EjqOJzF
         XNOEAcGwx/8M+UuFZ1+Yf7q9T96kIq/P+by3lKtfX32fZGe4pabvIe+02EdldtpTU0l9
         V4ubkoCJUk7c/dewT1JZiMVdmzrGuZNWNwSWBb0v+NkrjRBl02fhpBTOQ2AXR4VejU7f
         VhTO1iSH2VzQ5/YxtGaulYbCJU/ftGvxB6B2PeQQwfZXh49h0X1x9JgjtVuari+1NkqB
         049g==
X-Gm-Message-State: APuU4Z/5A3tEPscERVvwx+igF48FD52PdbeV6iU22bNHFOFl9i9tCbtO
	/QhSJ9srgP3x/Gqyv0SY52ocht/maCNMEzuGoTOUZ2aeMbEPSdRVT04I8yUXFw==
X-Gm-Gg: AYBFou25AAewtWrpcwsJf/ANiPBPVaxA/HD6tHceWgtkH2tXESVPhvEPLdFFsxu1vQF
	tcLk1yDIAGvVf/GsFqJNxxYeVKsRgBAdArqn5mMtAkSj4mMvmHN5Cfe7Fn26ZAZAcIZ6sRvKZ42
	DbAdWFDKa20fBdeHr+eRbE4nm9Av/c7mEd92X3m+3KJdjKabhxyvq1ztNcTvDjxVbjpGvFqWEEt
	Gsfl2UW4aywUKnwfl0BvKUgqM9C4F7bhiVKqqZL9J/LJWrtcCAvp05hGTq9xS6PnEXBSe0F7LU9
	wEAcm5fCo1XoUXuDghkqxiiIBADfYTdNJNTBfiS2NSx/2aPiLHYT30u/N2qsAj5Hvylzol1M+hg
	7vi3uAnoHL5QQKm7UY8csIjHous6X94P975ozzrXycC8d97CJRP9rPl38cKQXwfcVaDcYAdEYz8
	Tjrx2KndTf+tfMQfODw86KOxgVrf1Yx0UgEoD4Ds4LjJIykK6AmVw7MxivOrObc5h2lAsx2VMKj
	B1p1dPxLUHIrd1thqZFJznZp3rL0XiMF2OloUpJrTzYE+EV5ODi8lrFJQz/Uknjk+G9AZuVaxw9
	fzyJbn6v0XFT6hO70olgz1zOLLlCwiHC3NPPBMAuB24Dlx7fesp1
X-Received: by 2002:a05:6808:181f:b0:4f4:9a44:73c0 with SMTP id 5614622812f47-5683c9e2e9amr2566536b6e.6.1794337927214;
        Tue, 10 Nov 2026 11:12:07 -0800 (PST)
Received: from [127.0.0.1] ([52.154.21.60])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905f2faf5sm2856393b6e.13.2026.11.10.11.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:12:05 -0800 (PST)
Message-Id: <f24d4019e889b12cd6237217c3cf31f47aa318d5.1794337920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
References: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
From: "Wyatt Holden via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 19:12:00 +0000
Subject: [PATCH 3/3] scalar: disable orphaned commit checks by default
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    stolee@gmail.com,
    wyattj.holden@gmail.com,
    Wyatt Holden <wyattholden@microsoft.com>

From: Wyatt Holden <wyattholden@microsoft.com>

Checking for commits left behind when leaving a detached HEAD can
be expensive in large repositories. Add
checkout.orphanedCommitWarning=false to Scalar's recommended settings
to avoid this foreground work while preserving normal checkout output.

Use the existing set-if-missing behavior so explicit user choices
are preserved during clone, register, and reconfigure. Document the
loss of the immediate orphan warning and the availability of reflog
recovery. Existing Scalar tests cover configuration preservation,
so no additional inventory of recommended settings is needed.

Signed-off-by: Wyatt Holden <wyattholden@microsoft.com>
---
 Documentation/scalar.adoc | 7 +++++++
 scalar.c                  | 1 +
 2 files changed, 8 insertions(+)

diff --git a/Documentation/scalar.adoc b/Documentation/scalar.adoc
index 5252fb134a..d2b8c9a6ca 100644
--- a/Documentation/scalar.adoc
+++ b/Documentation/scalar.adoc
@@ -214,6 +214,13 @@ am.keepCR=true::
 	and non-Windows platforms and keeping carriage return (`\r`) characters
 	in certain workflows.
 
+checkout.orphanedCommitWarning=false::
+	This disables the reachability check that warns about commits left
+	behind when `git checkout` or `git switch` leaves a detached `HEAD`.
+	The check can be expensive in large repositories. Other checkout
+	output is unchanged, and commits left behind can still be found
+	in the `HEAD` reflog until its entries expire.
+
 commitGraph.changedPaths=true::
 	This setting helps the background maintenance steps that compute the
 	serialized commit-graph to also store changed-path Bloom filters. This
diff --git a/scalar.c b/scalar.c
index a80d8ee3ff..7f851f5610 100644
--- a/scalar.c
+++ b/scalar.c
@@ -138,6 +138,7 @@ static int set_recommended_config(int reconfigure)
 	 */
 	struct scalar_config config[] = {
 		{ "am.keepCR", "true" },
+		{ "checkout.orphanedCommitWarning", "false" },
 		{ "commitGraph.changedPaths", "true" },
 		{ "commitGraph.generationVersion", "1" },
 		{ "core.autoCRLF", "false" },
-- 
gitgitgadget
