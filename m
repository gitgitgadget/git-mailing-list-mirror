Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDD1EF092
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716065; cv=none; b=UjlGdLLq9MAg8aq3WyJuXJRAj0sga22dLmBHE2IJdIpcYuKamni9CtvvmJnzSnqEVsCIxoG1XyV/BXOmgDsVjcMJ8ak7IUuC+DE+U/rRqoXwCjCokrAqgDafR4cRsWb0sUw4wr+oSLEZ2aCjVhXBEgyc1cuGoZ3HaZ7U2JouubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716065; c=relaxed/simple;
	bh=t3hVYu8M3RM7Fgv8kXE8DRTC0c6U15JJVl4YWS+hnxk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s9Y9EfZOhovz4G7IhOQn1yXhwoN2c9TaaPOC559lC2y/488UoJSPnp57+Aos7ZBjRPD7jFW46LsB20sEkivlxiu/YLAvedJpRwNkq749K7YzHQC4AcBJ5w05HHI3dYyj2sN/u6YfysUUTcZ3dK/f7JvtHdKE1OlCs053L4BVY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cdl6TlxD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdl6TlxD"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso350847f8f.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752716062; x=1753320862; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/csmItSQuekwlTh9sPnrl6uFinzt+f0JpzmW73BRmw=;
        b=Cdl6TlxDkHFrj0f68HUIYPjCvGyxin+IOO3CFPJ9KnPPqN96sRZ9UcdW+qSAbxjT2A
         uwKLD/AOWXUuTLA1O1ElUpZt+u5DRd4Oj+BpyNjhQlymggq+LFFLtJnTLnlIzcstg5cS
         yvBCCSXBb4jP5DP1Cuqd+LvEExdjRfKCwCouSb6MDeCqXFKqc6CgoMYTO5t/k0qBtjM+
         +xvWzRKf0lsOVBEaOLePAVa0Gm/F/B688hJuelT0PZVvH18DMPDLwyZUSohP9kWEallz
         EX88FkPihDDW4Oo97NXUOsRqH0+v049mUAKuQnz7SmahHihKpltu5IOzK7EFhugxipmD
         8ABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716062; x=1753320862;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/csmItSQuekwlTh9sPnrl6uFinzt+f0JpzmW73BRmw=;
        b=WI592Giug2X+RVbDgVkinTqU5BX7n4G0bPa4xx6c+9Yp/U5ObsXz/ULUUoPwO0gPX8
         FfIlGi4tP7wDyshxoVgL2M4puQb0uVYhfWUi5zJXifyjHnqTbNaGEELlGo4/uWbp2FBs
         dkLGb33G4cCY/RSUj1LqagCLSfqpzAEOfXUMloKUOyvhYp45xy5U+MtYZOeojh74pX8K
         lo7jC/4/qB7uj6+dSmMpcf3CjOIiAfdX+lAHKd6Zefsjzk3mq4dH4Vb0WzoyH48REmRT
         Rdj4OdZ/LsVnCSOmLM/J8tj0wLRGYZ7AgQkR10JCPz3TJdVOkEO/sNkU0xr3l6Ycc49N
         Hf7A==
X-Gm-Message-State: AOJu0Yzu71CS7PeZnUndzH/ddlAPkMy3JdlHHT7HZTAuZ/LJwdOVWA9K
	fuZj3YZLGMBJTmQJUe9k6oGdg9/T+aSMOppVdMG1X/V/akT1ZkDY/9Eq+ldFhw==
X-Gm-Gg: ASbGnctL4F+oCnULgW13szSMSWJcADEyoG18pj68ZSyiPe9M6B9W97fL8ErLx8dNRNg
	CYmN8jbYP4Fh/TbMZzGJ124bHosRQQREdhBnHtXWEoCXdyvbJzgaFrsoKKnVaHAHbkB6qVLxxwG
	PJRB6jz4EiRuE2Os2eac92vYb1/nU/4wTrFS6SbTRUwpIzY7EPWlyofvY2lVfXqNHmGxLira0vq
	8BEZxrCIgvCLeNF3Sy62EjcmxjSqCZWK83RCM4XnJvuKZ8RtqGTYD/Qd7f9+8NvSPZvmWHv0vCI
	Fv6zQGCtXD0DonBoKW15rJhXVMczNrNqXGaG6hTVrUmJBj6hz4TnTSSDwNp78++D3J14J2PvrSq
	Nj2u92VxtnOLz8+KejpIgguA=
X-Google-Smtp-Source: AGHT+IE4elP0TIvN+B72jkffwUYr1gp/azugEqIBLD0NG8bgxgCfE+rLky8ndQGDpEUkCA/HRgMYkQ==
X-Received: by 2002:a05:6000:4b12:b0:3a5:2e59:833a with SMTP id ffacd0b85a97d-3b60e4c9a75mr4105901f8f.1.1752716061778;
        Wed, 16 Jul 2025 18:34:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14d12sm19502851f8f.70.2025.07.16.18.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:34:21 -0700 (PDT)
Message-Id: <d6dbc0b5ca9cdcd5956e02a0fe603b170dbae1ce.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 01:34:12 +0000
Subject: [PATCH v2 6/8] sparse-index: point users to new 'clean' action
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    newren@gmail.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In my experience, the most-common reason that the sparse index must
expand to a full one is because there is some leftover file in a tracked
directory that is now outside of the sparse-checkout. The new 'git
sparse-checkout clean' command will find and delete these directories,
so point users to it when they hit the sparse index expansion advice.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sparse-index.c b/sparse-index.c
index ff33b8516b9f..cbf2bf618c37 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -31,7 +31,8 @@ int give_advice_on_expansion = 1;
 	"Your working directory likely has contents that are outside of\n"     \
 	"your sparse-checkout patterns. Use 'git sparse-checkout list' to\n"   \
 	"see your sparse-checkout definition and compare it to your working\n" \
-	"directory contents. Running 'git clean' may assist in this cleanup."
+	"directory contents. Running 'git sparse-checkout clean' may assist\n" \
+	"in this cleanup."
 
 struct modify_index_context {
 	struct index_state *write;
-- 
gitgitgadget

