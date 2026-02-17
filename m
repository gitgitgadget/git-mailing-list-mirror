Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707B32ED4C
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326526; cv=none; b=nCeRnSJ+2tTKCggHNCk8S2jJfvl9+SltiBWBztWJSmTDiBuhGoub7/zTR+xER5MyEYz37iYwCmK32QLW4Zcwd69bNf3ypeqWvASO98huJKyv4WIbHEGyqmZWxf/YiZ0IqivfdzTqq17bfiRyeTHyjofQNxfpAu/URhFqAxWA1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326526; c=relaxed/simple;
	bh=NKff5EgLACVh4dOse7HrIGbyy1948TSgJd8AtTwsTx8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tI9gKam/XYw4kj+wThbaqhN5RBAuYXFRWvYjNbpKw9haUqRtFxUWckwiMv9blj/+aSwXkyZOpNAHGL7wdDejdVWM4dcfB24CN2qBmgjemp9AC1DOFFAvryTc9XEfEdVjhMElaT1OGxmGSQMtsRGYXWJPnmzVXv5FjlnNj9QgWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3+S4R1N; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3+S4R1N"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c713a6a6f8so427951485a.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771326524; x=1771931324; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijTdUA2904zp9167t9aMQGD8wmUccSAqZ3QCOZHoxfs=;
        b=h3+S4R1Nf6M5KHa7D8cxecEt+ovk1n6/dOItw6wb/43aBkre+X7lgkmMWBWr/MMKIq
         ULjQpANiS/P5Gwfvr+N0UxssUs6kVykb9z2ynk9cliev07zcYlGUGUoFbBujIxp9jgMJ
         19ZNR5nQB0lFBxxZgK8CXdrKyPgIkc6VAMpYsKeIRiIBG0Abbm60Zrd+e2/MA5ne1STF
         /GWY/v14WcKYI292G7s+ogHUTldCS5vvx5thfbLA8kH6/zc1ywkoXyIFpbgsmw6xNnq6
         DiEtecRud/zmzG0TzKsa/zDsy5GBZHRAlySA0L+DL5CMOSvUagBx7dIpe+KA1EKvgXFT
         X8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771326524; x=1771931324;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ijTdUA2904zp9167t9aMQGD8wmUccSAqZ3QCOZHoxfs=;
        b=obj7MadCi1sMvDtaBg/KksdvPEHxR2tVX9PgAgrIabxZR2FjZh90Lz4Bh9gTpGu9m7
         jRMU+iDpO7gkou19zLz+3OibTSdJrPpFVw/P1jgKHSdzQ3407f9iDmnqGdhetZjkSeR6
         RJw9ba7bW0JG8A4v3O2P7BCLdSbZRx8WG4PtZjQ2vB8nJncMzzW02hEQU0VNmg4/zyQI
         NjO9p6haD/vn1+VO2lTtBXLEv88pQR49z/9pQXQT8N7ahcMYTe6sAqUgNYFrPj7UUf1w
         V7XunQ2GK+NrBECDUhyp7fJwDaZEKgGtD4xZzsdM7r3qzvQHsg79LyzoCXloSzP176Ea
         uEDA==
X-Gm-Message-State: AOJu0YwPUphQDac9hgS43icSUr/V0Zldv4+u2597X8pbjsvpdBmAbxbB
	wtZ5TmaZRu3Z88Vx3ych32H5rvRfMtDxUmCfKmeWX6Hg+iV+2bRtrUt763HKRQ==
X-Gm-Gg: AZuq6aIAfuJKmocuQtWJtG+eHkmLleCjAMsoBvSOZV1XMh/DRVCZX4Fk0XUVXThU6g8
	6ynua7FQ5jxJyw6JjojBsOV1yGrHfpGMBTNjStkdivTaQNt6KB6N30RHoPkf47HawTTDax+QZLR
	7l+AQRJqQu4zz9isrmVhNPT99CHO2aOHb88RLKb8miuWxqUWvF+JD9pdiAJT0sh9r/S9bcyb75j
	QCwA9uCO9MDSbTkZzk2BkXrWUlG+uZfVYFWylK/bkRRuKFFRg4437ZBOa/akLzB0KiocMXn9LrI
	EtgaNvtmgV7a1HlBeyQLj+xuLXs+V+crMTQjfe8AmD7lCPbQhvzerzRfBPWCSEUd8HrjuWh2IoX
	sr3H+ChQIPNR+ZhNhaCSJ63m7jHa4458WoVZe9oczC8A39LLGsJQL+SgSTAwcRXPbaN2QX27EUE
	VrAPjXQfOHozCQ5unD7v3SGIAynRZ4OnnuulLX
X-Received: by 2002:a05:620a:258e:b0:8c7:1181:779f with SMTP id af79cd13be357-8cb4ac8d534mr1364504385a.35.1771326524284;
        Tue, 17 Feb 2026 03:08:44 -0800 (PST)
Received: from [127.0.0.1] ([64.236.160.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc81faesm158051076d6.7.2026.02.17.03.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:08:43 -0800 (PST)
Message-Id: <821043c664e41d8e395e944df3ada8f697a69d0b.1771326521.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
References: <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
	<pull.2008.v3.git.1771326521.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Feb 2026 11:08:38 +0000
Subject: [PATCH v3 1/3] strbuf: fix incorrect alloc size in strbuf_reencode()
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

The strbuf_reencode() function incorrectly passes the string length
as the allocation size to strbuf_attach(), when it should pass
length + 1 to account for the null terminator.

The reencode_string_len() function allocates len + 1 bytes (including
the null terminator) and returns the string length (excluding the null
terminator) via the len parameter. However, strbuf_reencode() then
calls strbuf_attach() with this length value as both the len and alloc
parameters:

    strbuf_attach(sb, out, len, len);

This is incorrect because strbuf_attach()'s alloc parameter should
reflect the actual allocated buffer size, which includes space for the
null terminator. This could lead to incorrect memory management in code
that relies on sb->alloc being accurate.

Fix by passing len + 1 as the alloc parameter:

    strbuf_attach(sb, out, len, len + 1);

Signed-off-by: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 3939863cf3..3e04addc22 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -168,7 +168,7 @@ int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
 	if (!out)
 		return -1;
 
-	strbuf_attach(sb, out, len, len);
+	strbuf_attach(sb, out, len, len + 1);
 	return 0;
 }
 
-- 
gitgitgadget

