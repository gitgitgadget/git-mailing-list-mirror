Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50302299A93
	for <git@vger.kernel.org>; Thu, 15 May 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313147; cv=none; b=MRGP5xwRs/xRj6sgvn0WnPAq7h4Jk+nwAsu8mGdh8PrXYmTgumPtcTeshU13H3e/PhB+NVnxMYTzpKLFMhBeoBgkU+RClYGKbKHaquWCj1wsLoE8PoVSjzkFP+DcyNQDDhQB9ODtk4BnhdIOT9F0FM0YgmP+HgJo53kHp08mhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313147; c=relaxed/simple;
	bh=XfDJp/aUSlgKdbWqvXR25rGxiAw1UkCH8WAsNMt2LSw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rZyS2es6xuhZ1HWKB5Fuv1YjC+8NUg5xRog7Ggq4F1vxah2kruc6QkM1Qc5OOTfwsNfpRSWv3Vivgn28ECS8e5Wa8GCpjYFtJSypLADcNciynU3N70WRHrUBUQ6MfymGfl/myqEEN+Ty3PEMw9KysADP4isREyYKP705DeUsHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMBc5nAr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMBc5nAr"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0b9e2d640so763646f8f.2
        for <git@vger.kernel.org>; Thu, 15 May 2025 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313143; x=1747917943; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoKfqTMHLNIGyTJqsxkN2MFuiiK9LRaWvBYcXajsNyc=;
        b=dMBc5nArXdoXy2FtvMuQlFAfvcgI0mFOIy11YYk6pqdRVKoVPlQ89xPDCqSUZ93JSN
         XdgLnC+0YOotq5ZLAYrI9KWbxNRUF4oaCdUwlU3RWjKtP7o2orwKHizIjT8eSP7HdmzT
         4Db0xY04gLmxC6q14zegacg5HJH8WVTmNFaG8sg9lZLvrUFuGVWKDRWOC3yWTG40cy+D
         txU/AxkUvl3VoC2fuBb5e7EvOvQ9GGTpjEXuRSYAu0hOtRrDIlQhEXcHfkLymILcdLRN
         AWUKGh06Km0QvANmomNW1zQCuHY6SNzW6UAfUqAOYoeg8fy5yEWaBRii4FxIkXzl4Ke9
         7uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313143; x=1747917943;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoKfqTMHLNIGyTJqsxkN2MFuiiK9LRaWvBYcXajsNyc=;
        b=D2SWo8bBEsUo8j28xfTjm9NoiIqez0E+3hY5KnTxRuLjPmTa+Qls25vetyRgV7JO7F
         f8OOe0VLUb2qUxpibh44EBnusDaGnvQ1iQjedSzA9L1SYbwQFGvE2GL54QLcTXKqzBOp
         dNaj9W/FWCsO2/VqICvEnVGXlX8tssk2Vhkhwjo6DwgJ6bFqMdPpjS6/3Cq0LFQ4hRtz
         mlbMknXt0wjvwam+bb0n3/nLjRj2C9SPqwCwtTRRYZH+hLoBDVtGvT/i35xtwG7GuVHy
         YVR780pESAZXNfaSbmGeDtpwoD3CO15yMkHPdlWVAaL4j9y/iuR3pUm3Fq0uFiVJg9Ic
         ReCw==
X-Gm-Message-State: AOJu0Yzkg3oIyYf3zBAwqCGvQksix8od6CBMC5LwSGZMJTzPI3KzuUBB
	373krluNyXckUcNYeXAfMwfO1e+sUjEVknXGIg/xygvNCTtWGB3F2GU0qw==
X-Gm-Gg: ASbGncuU0BE0DKJXHlY+1oaSmBP3AMnXfqMvHWgX8V2Opz87CHtTe/lXoBa9ASeX64T
	7OBFLO8Dq4sN3S73X9ugLgiF9emZSzp6UZM3znofBL/hV4ymcSE/ERrKUguS4ZjdU64df2reOtt
	/HoMbCNRds8L1nCJGiQX7+qRxfeGkDt1gPpISx4x5SUfHBiM/qa2tOI9FP+W9jbG1lxy2E5irhF
	zutu1nO2m+easpWC/Uppk4P+LsQIpahKk4DK0u0/5B6slgW84b9MoDg9HiedhfJQJUbI8kLCbz9
	k/mKvSkVipWrAn5pNZMVV6PxpFgfLVZ0yQsW5+wlwW6JAwNds/qa
X-Google-Smtp-Source: AGHT+IEY+h1vh3W0aMxlpAQCOb1Mpvt9JmcToC28l0VGc1IvtxTou6cUR3I/IwyLGYhp466GXHtlfA==
X-Received: by 2002:a05:6000:1a85:b0:3a2:6f0:50bf with SMTP id ffacd0b85a97d-3a34994bba0mr6997132f8f.39.1747313143008;
        Thu, 15 May 2025 05:45:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f482f1d6sm62086865e9.14.2025.05.15.05.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:45:42 -0700 (PDT)
Message-Id: <35c4870e2c101c9ef72d1657c8f6dd077cecc5fa.1747313140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:45:27 +0000
Subject: [PATCH 02/14] get_parent(): defensive programming
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

CodeQL points out that `lookup_commit_reference()` can return NULL
values.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 object-name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-name.c b/object-name.c
index 76749fbfe652..ca54dad2f4c8 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1106,7 +1106,7 @@ static enum get_oid_result get_parent(struct repository *r,
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(r, &oid);
-	if (repo_parse_commit(r, commit))
+	if (!commit || repo_parse_commit(r, commit))
 		return MISSING_OBJECT;
 	if (!idx) {
 		oidcpy(result, &commit->object.oid);
-- 
gitgitgadget

