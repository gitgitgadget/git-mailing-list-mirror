Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00049395DB7
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266026; cv=none; b=szSPlVmops9gWR2WeLFr4vv+f0eGA+spKkxtRoSB6/MBmbPFcHr4tJWkhRMCbLfP9UtVrsRUQ4ypNTFT5UuoUBc7WMd6GXLR6YYP6WGAU+3qd4AU4FPr6UqLESV551L77rgTMOUmPB2/WZOEbliv41y+QkyDCKIle/xVvHnCmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266026; c=relaxed/simple;
	bh=F1rQY6lS1liAjY+9q77IEcOzLQyGsY3Qt/rpIVhG7as=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jfJ/24/mMz8H94L0++k6XwP+lfah0WzFS8F4hfU0xbH+T0QNlMaSuuZgkcpKNxssgsq7bUWdScu9OopRXmmZkPgDJS7YYwZwm6P81ChRPyqPWWNbJUjEaV0BwoZ4+j55f/q8k6xBF5WvHPQAQBJUStm6h3VrnazTyRmxZcKkNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVJgdpxI; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVJgdpxI"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c0ea57fea7so4838873eec.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774266024; x=1774870824; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+e0vbdqUVgzn4DIHrRVN1NYuT+wGbffhrIkYn6JMRM=;
        b=CVJgdpxIFi18Gc0LxvKL+oZBUue5TA+UXH+/hvSG2qG0hCa/ev88l85XNYeBlyaIRC
         ZCsYh/r46AyWEe//V3OTzaodSOXqLqFBVtTOEaLq5A1Qvm1/+H9Pcusx0/Nkyf868wf+
         cWwZjSo5sKJ5IAK7iySab3kCp+cBGrj6Y+ILTUNY1vPqmpNgKeUmiov5m8LTe59nz6nQ
         /ZoALb8Lze+JwT6uKo5c1SLYQGv4FoZ/h05ONMvtkAI6VRDMHlzl66tMezott2ut0VcU
         Q60q1B9clPFXexwiNclvaU6nonTzbtLj9peYvXtirZToH7PnUM/i9MgoG5NbrfZlPuAv
         VnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774266024; x=1774870824;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+e0vbdqUVgzn4DIHrRVN1NYuT+wGbffhrIkYn6JMRM=;
        b=EoRpGsNlwh3ctyxwQPdTXV941i8Wn1yY/0E1k5boFf9/AqNEjeuTHvTI435ZDuxYTN
         Op2Imgt2ghxM9cbVbQcn6XKGH6hQpBN/EFnj0OfUmM4nDXttTACRo3l30VvZqcN5zbR2
         N1AuKm113JnJGIGxet4ombsSuOQnDinSN6LIV6ZgPqIGMKF3cA9hkpm2UaFPQPs911vZ
         163QFyJknQvIhIZJIvJdeE201HeL5EMjwZRB80rARhUa0Z77GsYWNF3gm0ZNODzhD0Gy
         v7R5dEmenNlKLlSYyynHGaxWHQKlu1RuMGvvE2ZSr0ZweY02y7O5FQNppoQQhLJ7nsW4
         I3fw==
X-Gm-Message-State: AOJu0Yx9Qw0QI5JbdZMmWlvf/OL2mMKCkWptjgJDhDumWJSiqE+PLx67
	QsNu1hArT6cOIthRo3uUim29lamaCu0hW4EzYWeWj8fx29tdSbV3NtTwhNMv/g==
X-Gm-Gg: ATEYQzzX7oO5UyYUBerdGLSDIVtVg4ZxrZneWpDUbsOMOADhihckjl92qHyABBrsvL9
	eC5egAB/xUYWiQjv1VM5zol6GgUC0DFDuOj/IPyoZAwRprk1+CB+HigWJva27xQGaTemuKQ8JjY
	5tKgS0eXS4/A7gUimjWZ8H74dj6GDHmJ/JgFZja9NScNSCmpYBvoEMvf7DLa78KUIman12E0uzp
	TwnpqTH2CFXqwmEVsIJsZd0WjqqGEsdQbx74Jia6jni6GqhkgRCY5A+omsjw6+Rts+PeR2gwnEC
	tUpR+FhMhtBCCpPE45KQYW00KTVV2SurCr8rJ9qE2azETPimg44d/+QDt+4b74mRBaG/Z3Idx9f
	/vqRuMBURlyWLYfT8B9bZZTIT2c6U5NEDvHKu0o8C2Kp0VHZ2NVJO3sUgycbgSgtvJQzSHp7O08
	r4SmoBals2sr8e8Cr4bf+UaE9kFdg=
X-Received: by 2002:a05:7300:3252:b0:2c0:c5b7:e542 with SMTP id 5a478bee46e88-2c1095fba56mr4807584eec.8.1774266023520;
        Mon, 23 Mar 2026 04:40:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2ce04asm12360806eec.21.2026.03.23.04.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:40:22 -0700 (PDT)
Message-Id: <fda0239103f6e2b9e76403144b9ed2e9205e1c2a.1774266019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
	<pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Mar 2026 11:40:14 +0000
Subject: [PATCH v2 1/6] revision: include object-name.h
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The REV_INFO_INIT macro includes a use of the DEFAULT_ABBREV macro, which is
defined in object-name.h. Include it in revision.h so consumers of
REV_INFO_INIT do not need to include this hidden dependency.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 revision.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.h b/revision.h
index b36acfc2d9..18c9bbd822 100644
--- a/revision.h
+++ b/revision.h
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "grep.h"
 #include "notes.h"
+#include "object-name.h"
 #include "oidset.h"
 #include "pretty.h"
 #include "diff.h"
-- 
gitgitgadget

