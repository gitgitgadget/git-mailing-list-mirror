Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC382ED15A
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842980; cv=none; b=MpYxyCq/DdKBkC8zsKP774fsLQfnB+pT1RPU9XZYzfvtYQxHVJPK/cnAGipBQdJpCTc5CRyOf5SUan/h/if4FkqmIfDsltvmAiqdmptppJklT2J+HANhZxdNi9qZSoFARc0XhsMgxBSeNHaXi8idBfY4x3YTom5KvCv6CywxplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842980; c=relaxed/simple;
	bh=Kszwp6+0tMDHiAfRyn9qNChVAcR18Sd+ZsnEq0OQLxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP3Y2VjQwzPDWziVDwSxqrnyQiUx59mPBSmLedQYOTQcsTS6IAIAqSMXN34cKFwjntPtvRgAATpxoKUl+1h2zDewmOa/VCnCnT0vnHysFcLdcQ74/sDI7Ky8GRCv0vk2EsOqeQ0ZQUCsg0SHauKjXtS+K5RU6JXaJF6Cuvv8juY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ5fEp0Q; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ5fEp0Q"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3627a1979a0so1301740fac.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758842978; x=1759447778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcRT2ffP+vxI6AVhFBHJkLAGJBXmvRXauD9r00j0AIA=;
        b=IZ5fEp0Q66GAN0tI7QLSKf/rllla7nFthpIBZAd+IujnBtq7oTstB1DWDyAumf+9vh
         XCAEFo19tAr/8zOXmt6MU3AnKxJ4x9WNWrXOBLmGJdugaRArrX+o5QkxkeVKGqWoL6ed
         +j9Y8H+H/XtHBuIZ5SOZaZWMKr3e3EnnaPKx9YmFxVJQKUQ5OKxEG6GpyQdTSo24PRRQ
         2iI6rD300TvrU1GQqcEICpZDUh6hKLn2vstYyK/85uXXq4D+rIxYroJHhnMIQgybe+Q4
         Gc01IUSXP9/lZJuRPagxrcVzRrKJQFXB+3z+NPyp7wiYuPQJqot4Hv+VIOUTxwP9JLhd
         LrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842978; x=1759447778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcRT2ffP+vxI6AVhFBHJkLAGJBXmvRXauD9r00j0AIA=;
        b=gNYBBKgZbHtRTQ3O43pHKsCSxilu+FJ8PEOGzog+9MwTE2wW6+f4jKwHv+XIRQOmDI
         IkM2mzfr6UAMnqRXnMsYobFKgprzqvk9fF7nkE/CKpVF69ZrVP9LDdwzPr3r+noduUss
         4vO2q40srX96bmi+iPmnkhrwJhIWnwzaXQLFnckL6HkjBwSIUKSYjsinszopFx88Jhx8
         QSLnctXgUFr2R1qNg7yoO4L8aCLO0CnSmLEaaZNBOC6fMXI9qq8xrmapRzZ5B+GUBz15
         XVZQJe2pFFmUElgjvGWNWJX/98JU5NVEEW86v8RWBW8cnUbjTTxIALIptUfg1kD39sYT
         C38A==
X-Gm-Message-State: AOJu0YwHxOBctrLPcW7oegzRORlPFD623b0Ce6EfiY9zHATf//M5/EDV
	bTQVRF5iOkBRCLjzzAvgYJA1Wfp2HNVsk+cNkjgqdlb4bvz5+Ev0Ba3uEh9vzA==
X-Gm-Gg: ASbGncvjnsPxYPpmzBc35A+dWw4RHQG1rtZLInYcBOwu48SIRYZwpJ8PjY7yR26evJh
	6ki0Gr8sOq4ChgIbGDQ9fU71R3VpnlRqxrdqjBWDtcLe2vxRFXVR7h0JMjeAYM+bfmCcc2emzYO
	S9as+aQEoUC3kd7tbC1poeFdTM0d4UFMA+eGDIVZLpLoJxFBBajznfM57Fks1OF1qU+fI0TP78+
	VTIbHFSFVo+6S4e0WoQF5RLfPItJjs4rIBCb8LpLb3T3WHCXVoLWKbtI7IAjKn9UyMK2dEqvwHn
	eIIpbkvWy8591fcQOlyQ8sRRqZNOwb/aWmm0F5/T6ae9dBh57HvAIXl+z+ebqW/Ro2ClsK0zMI2
	u+kj+UeuE9TfkyYG+tfIQJvpJzP7WXr76zoxz3G7+Jw==
X-Google-Smtp-Source: AGHT+IGuSZWZSnDIuxG/UkfABRr7YK9Y+Rku5p4bxNjkaVI8avTZ+zLckJCphoX2qj7/dKAlBhUgBg==
X-Received: by 2002:a05:6870:3313:b0:310:b613:5fd5 with SMTP id 586e51a60fabf-35ebed29cc0mr2970533fac.10.1758842977754;
        Thu, 25 Sep 2025 16:29:37 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7a2402e5d70sm674273a34.36.2025.09.25.16.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:29:37 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/7] clang-format: exclude control macros from SpaceBeforeParens
Date: Thu, 25 Sep 2025 18:29:24 -0500
Message-ID: <20250925232928.3846-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250925232928.3846-1-jltobler@gmail.com>
References: <20250924212426.2930029-1-jltobler@gmail.com>
 <20250925232928.3846-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The formatter currently suggests adding a space between a control macro
and parentheses. In the Git project, this is not typically expected. Set
`SpaceBeforeParens` to `ControlStatementsExceptControlMacros`
accordingly.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index dcfd0aad60..86b4fe33e5 100644
--- a/.clang-format
+++ b/.clang-format
@@ -149,7 +149,7 @@ SpaceBeforeCaseColon: false
 #     f();
 #   }
 # }
-SpaceBeforeParens: ControlStatements
+SpaceBeforeParens: ControlStatementsExceptControlMacros
 
 # Don't insert spaces inside empty '()'
 SpaceInEmptyParentheses: false
-- 
2.51.0.193.g4975ec3473b

