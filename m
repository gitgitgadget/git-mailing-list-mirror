Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB9745E4
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770900; cv=none; b=LlE3YPg+YMok8y1Dgz24gqW9G4PDSLFksyI2k6uCFKkAyHcQJ94zVqTdMuozOucTAfs/xNEoa9kirK+38poum8d/BZXyxAaOu56MDasTUlw5tQ1GXnJ2iBDjeqQNk+ZGhhf/Fx1vDdRT+UTudh2Cw3WCDCBUW1PvFi9s7ZdprF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770900; c=relaxed/simple;
	bh=s1vDV6nv4AUY6P6kwaOddf9onm1bIjCCs+95IGizy20=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ut+jqrGXJqSEr5JXahqvd1MquJxILuYY3BxQfJx8zsC8G2kdIlaXvKpKYjoke/zLMOZ1C3gJMAj3posMzCbzFn5C4OurEJ40zRh7pSrJplS15qXssB2EYquarPfSZIN8GijKQ01OsqJzOtQAmCk5XvIYG38Unu1Su3rmCsXRtew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C05fyCI4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C05fyCI4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c3400367so968469f8f.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770897; x=1727375697; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4I0aB/X4p5jWY8D+O3MwvfsXH5Isyclb1xHYzh0EHU=;
        b=C05fyCI4f4dwPOtlInMmZf7tQMbFOEnATZN1roB0vVVJms4TOj9VaEvF3Lsh0N2o4b
         GfGNEdaNHScVxISQFvMOcMQ5mjm24qFjqH7wLB2UIqu+Viwvm51eDkK9XDsHMCfUOHO5
         i6/adthK9KhOGgfl3omu3e4IgPgZSWxrHrnpQAdnAJzaHz8mrbM1/k2K9a292fnaujsS
         VtahRMVrEo5ndroUzPRq+BWEjYC6EPhA2lu0YefJnyNY+CtPah63r7av4lr+yPDClQ3g
         8KSm/t7oZQuUwKl87QrTpvlt0QGmyNR3meUljizyUpcpe+QkEugwtsHC50JLYwfXDKph
         Gsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770897; x=1727375697;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4I0aB/X4p5jWY8D+O3MwvfsXH5Isyclb1xHYzh0EHU=;
        b=o8dXaWjwMsv6ZpTKWFBLLA3pxxAU68EIcmnwFOALFVPzGoaubrBu7xlZAIBiMuDXrB
         4VD6y7Gj2zQ5bmJTuvlCaqW8M1FfGEBPl2w/KHf0MVtMC9RQXG4Q/SVocCAJHCXYro6p
         QemEycllsT2xzdYNCDLWyfoiAdk1BX4GzAeUXGbnW9sFeUOcp9UQO+1ZYxKapF0T03CR
         2JCcMs8lxtXvoWWeHedc2VVCPXL7sHEQs7MR+1x39Wa8ECsIseVTSWzGmRweaCk8pZmi
         pnFSSYCmfYbBDJv1SLIQ71G5wsxmQfj3koBXfMdPcc7SGBX3d71HbyRHXM6QLiLFjSPW
         8m2g==
X-Gm-Message-State: AOJu0Yz4JTkSiwKEwyq+BG9xCOMX1TAM2NIJ18t0s9T+YAZ6a7Z1Kmce
	s3ArhVLrkOBc/kmdwCuUOVbo/s910XIz/Ceqqw9QBAOt8PMJu41bSH9vLQ==
X-Google-Smtp-Source: AGHT+IFaHm5IlBjaOlt6JkCccue/yCX0gl6D7D2G+av52LvGrDPTjF2gsWY2skcRyuXOhS9y/D2Ktw==
X-Received: by 2002:a5d:5447:0:b0:368:3f6a:1dea with SMTP id ffacd0b85a97d-37a42253629mr234562f8f.6.1726770896558;
        Thu, 19 Sep 2024 11:34:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906109688bsm749923866b.28.2024.09.19.11.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:56 -0700 (PDT)
Message-Id: <9697dc1c81db33dca7e4a3c093ee83cdc0efea1e.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:34 +0000
Subject: [PATCH 14/20] ref-filter: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index b06e18a569a..308097e740b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2384,7 +2384,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
 
 	/**
-	 * NEEDSWORK: The following code might be unncessary if all codepaths
+	 * NEEDSWORK: The following code might be unnecessary if all codepaths
 	 * that call populate_value() populates the symref member of ref_array_item
 	 * like in apply_ref_filter(). Currently pretty_print_ref() is the only codepath
 	 * that calls populate_value() without first populating symref.
-- 
gitgitgadget

