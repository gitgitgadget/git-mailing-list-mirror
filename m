Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17E79DA
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765261424; cv=none; b=ZXI+klDHrO0PcGEuwoQbCiQp3MqaQpop6HZUQ927k+3jeEVWAAJ2CTRKwbtGGL9MZ8shbiQxSNA9UsF4sYkhR14KHpzcRCKWmi1nXl438SCWFgwfdn691kJ4W6ls1iljvVcyJ/GXq33z7+HfmPOUWCWH3zTXTvEZFjihrJpwco4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765261424; c=relaxed/simple;
	bh=za7yF8GGrIhfeG/Owyp8avY5agXhnTl+EWltgwCSUqs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=DSCtgcwMEprwKCBjEhxwctidvN9Q5HaHKS34AamlBGGZlq267nBcPMHq2HlX8xzKdYykOqwLoRSCypyc0zhGHOSQGs7c57rn9g4g1omSXLzewJpnU5KBNwiDAwDatxuHjigJC5Vo+2N76DWwsBdXs2ar3cuf8F0ZJC6VevpJcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8r5AptL; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8r5AptL"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so3080542a12.3
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 22:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765261421; x=1765866221; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eTkuJA5nPcso+GmbT3NsCXPULp34E6c3f2jhn5NO4O8=;
        b=Y8r5AptLdsDM/7q4xQTE5v491zJxORRCoi7X4F7AC5DIQKQKY2GpwBuHKJJrSDPsZV
         zID2VpOnM2WxQRzvWqSofPUTU6NxNk2aPuSFyEVIoj7tanDlA6YVJyN3/91pwceDwPeX
         dJFYhrvqQbprutG0beS/mOkg1WdEjpW6rvvxSaEQEaeoBWwt8oOeLttOKp2Y7YuiPTdy
         p5GcA8Gk5sLghg8uKU4hjq2wS4cKIjyi0cWEn5HRkWsYYt5X2ev7WVOIQEUwGnlEXrd6
         IUUg/ByDjNafeMtQIEHIWSpdJg7F5uc/9Efz/7rAurUQKLufi+/oD4QxyHTZxh/M7ptV
         o1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765261421; x=1765866221;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTkuJA5nPcso+GmbT3NsCXPULp34E6c3f2jhn5NO4O8=;
        b=ZtLhIVaOKlgsKP3mpN0rnk2jUyfHQYb7jwwqp18qhaWl58sFZjvHfdiaZU6Z3+CqhD
         kN52cadiNxz8B8fVpRwJ6oNy4r6dM0oT/Ld19o04T0JE0ZJd8nmlmSS2+hfgCc4yWuAX
         cROT7hDky7xYhy0s+uzRuQ6aRleR51Dz9wXneAu6bbJaB4XaTUyveVz1dEOn3jRmt9+W
         QNxpLdNzqCSULZsRx8uvWhm9EnZALYQA8FozXB5O4OCtYaBNE/3BNWmX0vlFVI2SZVkJ
         qXFIrGJ+vNooulmCTeZVVMgUYRTsZ0rrZKkTNAO7cTz43sae1ay8iJJSyVShsOhjgFj0
         7wyQ==
X-Gm-Message-State: AOJu0Ywb9NtoSVdpFysuCSxmegEKzahOCqd7nLAbEuQ8akelKSOcOIVP
	dLaICXE0iH0pmnupntBlJQfxSZgsXb9tClHX5Ava/k49V369/frpamU8Eza0jg==
X-Gm-Gg: ASbGncvu6Ap34w3BId2XyyO1a7IxU17+oQttpiX+XYTLVXjm7Nm6JIYVe7Mt0FhEeXy
	yQH4zVbNF4rHE75Y0uvi4/wyr17/PMmqY33S+sQze7LraNe6Qi2Nu7JLenifhvlMKMp1OacPEDj
	wa4tLg2qyIeceryQwPv+fV9S1fsg932phhFrusqOgy9lVN4D1FSZ3r144AGUzaJAFOqqltfEM28
	2LEmbm58Axfy6WGNDqkBLtmsjgv/I/gzANi28B728OloQbgjEsUS26OGHds9ZU81iSDj59m8tkL
	Wg932Pzy6uyV3l40Z92V9Bsm9j9R8BUrbZhN6zqMItSFqzMcCeRavmM6xj/u0N3hirXVN4M6rYE
	0h2is5X7B1uupBcHrBhCEGsTSjWyf6o0zii64ldZi24XQWkDuwY30NjS9Sf4krZk2WYPk5sLGVo
	89SjmDrs6HCQCScHBBRrPlvLRZNg==
X-Google-Smtp-Source: AGHT+IFDCCA1Hxr2GoEmNmTFP6vWdWy82iVNoZfmhktaydu7EDLRoRiNku/5iWWpGXNr6fw7oP4mxw==
X-Received: by 2002:a05:7022:b886:b0:11b:9386:a38d with SMTP id a92af1059eb24-11e032d3e2amr4734316c88.48.1765261421311;
        Mon, 08 Dec 2025 22:23:41 -0800 (PST)
Received: from [127.0.0.1] ([172.182.200.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7573508sm48158788c88.3.2025.12.08.22.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 22:23:40 -0800 (PST)
Message-Id: <pull.2123.git.git.1765261419802.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Dec 2025 06:23:39 +0000
Subject: [PATCH] doc: fix `update-ref` `symref-create` formatting
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
Cc: Sam Bostock <sam@sambostock.ca>,
    Sam Bostock <sam@sambostock.ca>

From: Sam Bostock <sam@sambostock.ca>

`symref-create` should be followed `::`, not `:`. The lack of second
colon (`:`) causes it to appear as regular text (`<p>`) instead of as a
description list term (`<dt>`) in the HTML documentation.

Signed-off-by: Sam Bostock <sam@sambostock.ca>
---
    doc: fix update-ref symref-create formatting

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2123%2Fsambostock%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2123/sambostock/patch-1-v1
Pull-Request: https://github.com/git/git/pull/2123

 Documentation/git-update-ref.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
index 9310ce9768..37a5019a8b 100644
--- a/Documentation/git-update-ref.adoc
+++ b/Documentation/git-update-ref.adoc
@@ -119,7 +119,7 @@ verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
 
-symref-create:
+symref-create::
 	Create symbolic ref <ref> with <new-target> after verifying that
 	it does not exist.
 

base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
-- 
gitgitgadget
