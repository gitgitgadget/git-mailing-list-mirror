Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE236F2F2
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293026; cv=none; b=ClpOCxQ0xyYSt1RDY9XTk+8qlNCPbIf2JQD9qEiLVE9U/URqGbKp7RYAwEkEpWmoabxMsu7XSbViqvyD1M9ifsy3Z9B78aTnUiPWEw1cpvnOLQ1hS0jXzmWo9akwoMY367hE53h8gX0aA3N+DiFlOd1nYS4hE35EPPCp559ZR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293026; c=relaxed/simple;
	bh=mn5AXIEEoOqQe07N6Qg2h9ZPA7vzvSQeHpYCsa+i980=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=pTRzldQpwtql9ezV15bYsotrWIqpN/EInWugcCcEdnVH5IMTaOt5jeNRGHhArhRPV7AD8YMq7lrK3EZ+V6SXKvhi9CUj6sJAjlGyUtuxLC5qZJEiiscqWWioRNjpwq2bAIxYYfBWQnFstzqS2Cbi3YESHQibMojYHz2zcHlmyT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP5o1rb1; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP5o1rb1"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5033a2c4b81so10248001cf.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 04:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770293024; x=1770897824; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q6O4qTn6XR4SJ4LhrokxvRJAYwW9HsgYjHIuKa/Qljo=;
        b=hP5o1rb1N5XlbQl7J2OcBZIwp/812gIYIzCMyaSDqdueypQiz6K/uL8HYDKD1ut/pP
         e9JezGXj686Y7XWF91gNlEc+ddFUmsSHu+D8i0j/cDWyFhYu6NbxHS5RZyIW/36c69DC
         otwt89M+frRra4IMyzGEQilZVccaOuANXJJih0x3GHiXR9FOwx5Md5H4rbYMhoOP5rfw
         xGI17jTONs4mxcMEeAlkrsyNJoCbE3m3AuhIwzNm4quiCXkYEW3WFTQNJB/jkcoxYR8v
         zUms91K9qTRmNUPg3BXLjYk6dR+V8l4hPpLjyCsW+nsoAFn3Qt0LgV3DHT8cbO269lDm
         81/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293024; x=1770897824;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6O4qTn6XR4SJ4LhrokxvRJAYwW9HsgYjHIuKa/Qljo=;
        b=RuDmwUA+IHKyNviGBvOQOanDKL9uvNUUqZCrHnkRlwy0p0E5m0R6mCd+7QlhZQD7pZ
         XtuCJd/7BqY/huyTXjFRJVih8DAvcfxtdc2QIyCC3IcBB/OkOoa2p6rB13Jf+t/xu3mg
         OyrwBYlOfWaWpgIJ6Zale/96fTDe1TUr8wfSKDpU+S6lS8081jqh8VimiUSiS2yr5IFa
         a+++nNZCHfpx3ufaBhWdqcZ0YSJuHHgwXIdkmTH8hYgKYNLIhNfDQrWkI8u4hMzHx0Zf
         ck788dmETESiqWLa7AtQctgtNPrERe5yJtdcalmeMBsNSPsFB5HwwIRfq4CONKVhubm8
         kgAw==
X-Gm-Message-State: AOJu0Yx1H6lDSFEFZk+GAOnKHiKjMpNfozfVeLysyhNZfbIsrwFBaeKo
	cf/ogx1WPLUpI8F4Xo4pHFRcZFGm2WizjA5tCGqigiXjVaqK8MG3XHEExdY2FjIh
X-Gm-Gg: AZuq6aJMMN2ytMYMjT97h+X5i9oBTMZ+76Y16PfO5ibo+R1LfsJeLIqYUG8eAmTO2a3
	XbpK8befn2xO/JS7/mLRTm7YJfHT0iF7gaPDFDkJqinneVVsA0bi0GGIfL1EE4g2ILLyKJ9qOUv
	F0SllC+SZ8scbsldJ7vjQH070fXQFrF6eRjrgBtTRxHE7bsyInveFN/d/fIsQtyDiJX09EzQybo
	KHP//40ap6ZVuxmXo6ZBiNRHnzSy/e2Kjxl6CMYa9380i3ZNDLzKsW1Geo98u9NJMAy+XLozVbv
	1QYVqRHV/vaARDzQRmqzUrG0J/Xl9j/By573dHK0ZXdMalr1MuJ/tPaED9ZgSxzpHVYtk+295dw
	G2zWQvRx4QmyumhqQThiCD7134N5Xi2bzi5zA7zmAMUPOm6qUgOKNi1GZyA2MgfsRz0Q6bBwjQM
	q3Aio0+q051e7llZI=
X-Received: by 2002:ac8:5e07:0:b0:501:4a4a:c24a with SMTP id d75a77b69052e-5061c0d1d0cmr77082401cf.13.1770293024063;
        Thu, 05 Feb 2026 04:03:44 -0800 (PST)
Received: from [127.0.0.1] ([135.232.177.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c15e317sm36578461cf.8.2026.02.05.04.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 04:03:42 -0800 (PST)
Message-Id: <pull.2187.git.git.1770293021383.gitgitgadget@gmail.com>
From: "Soutrik Das via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Feb 2026 12:03:41 +0000
Subject: [PATCH] doc: fix repo_config documentation reference
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
Cc: Soutrik Das <valusoutrik@gmail.com>,
    SoutrikDas <valusoutrik@gmail.com>

From: SoutrikDas <valusoutrik@gmail.com>

Since documentation was moved from Documenation/
technical/api-config to inside the config.h
This might help newcomers, by pointing them to the
right place to get documentation about repo_config

Signed-off-by: SoutrikDas <valusoutrik@gmail.com>
---
    doc: fix repo_config documentation reference

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2187%2FSoutrikDas%2Fdoc-fix-myfirstcontribution-config-ref-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2187/SoutrikDas/doc-fix-myfirstcontribution-config-ref-v1
Pull-Request: https://github.com/git/git/pull/2187

 Documentation/MyFirstContribution.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index f186dfbc89..92de476a7f 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -351,7 +351,7 @@ function body:
 apply standard precedence rules. `repo_config_get_string_tmp()` will look up
 a specific key ("user.name") and give you the value. There are a number of
 single-key lookup functions like this one; you can see them all (and more info
-about how to use `repo_config()`) in `Documentation/technical/api-config.adoc`.
+about how to use `repo_config()`) in `config.h`.
 
 You should see that the name printed matches the one you see when you run:
 

base-commit: b2826b52eb7caff9f4ed6e85ec45e338bf02ad09
-- 
gitgitgadget
