Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5839F3BB28
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evOqHClF"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so3138891f8f.0
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 09:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822821; x=1705427621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RERfuzItTU5Wnw7zB0Xdb7N3j/2BWp17/hM4j8ZB8kA=;
        b=evOqHClFtq/a1JHEC+a54qRXxI8pNPpsN5QNw3/LgeNTo1h3nU0gPe7KDz5KZsi99p
         JFsa3QenNQVVBXq3OFVrap5ZtkvA1qnWJNSol6Foc28NPOb8cqtTiA3t2IngVbXyGcyh
         cLeOvQk4F4pKsnroOCClkBsqiGwF4fTEqVDdyp7MqxK1qSD1K3OFTdQLEQPeSxvXUi4x
         dY5P91skM46dolzull+lJGlrpC4RxlQeOIDcrpHEm8laHSUxJVVyjgrqW7WhHWDJXHAn
         twi20wzxkd4hI4gFD8ymgTSbPuw+Vlz0XZW4K3QFqWVZd5VMTZa5uvYX4j7xFbCxIcd4
         rS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822821; x=1705427621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RERfuzItTU5Wnw7zB0Xdb7N3j/2BWp17/hM4j8ZB8kA=;
        b=Sj/tIWNZX8khOd/mj7n4JXK5tHz9OH49c3OLBad1RZwxRnrbl7KAGuGhftiBCfpj8Z
         9uHv9gTJe0sb7c5l5TqUp89GH7YMukzcvTf48xIek0b9JJaZbrNwj5pJ87X79fCfQTt8
         AhcFVY91N/Cu11iwD/MtxjIHudLpwe19Lf99nRTLIqM/bS5dvObxY9306XofC1qt7PyK
         ExdOK0oFbIY4mSxSzrpNGD7b5nkC2f/6AS++CsHsIFzIibzHtKQFceqFjFyBkLn7fQlM
         vXVRjKVfoQ3KxftAy/IJE5GFZV2Y3i5M+r/YVGxTJ5/k5pXxchazLtFdvPfM1i5unD87
         DNPA==
X-Gm-Message-State: AOJu0YxsIJRV09FC0zjaW0jlayT7BlNPE9cKPpCf3RG7xC2rMj/XfZE4
	1WxUQrZ0LvOnYWxFb5IcZMqRHNLDJ0c=
X-Google-Smtp-Source: AGHT+IG6Jr1yIfqpKA1HaXCMY/P4dKDJFoMsh72b5ovryolk9qpvycNjav+XKss7tdyHM6jV5AuoXw==
X-Received: by 2002:adf:f9cf:0:b0:336:7f93:3dcc with SMTP id w15-20020adff9cf000000b003367f933dccmr800566wrr.81.1704822821143;
        Tue, 09 Jan 2024 09:53:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020adff450000000b0033664ffaf5dsm2961399wrp.37.2024.01.09.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:53:39 -0800 (PST)
Message-ID: <893071530d3b77d6b72b7f69a6dfb9947579865e.1704822817.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jan 2024 17:53:37 +0000
Subject: [PATCH 3/3] submodule-config.c: strengthen URL fsck check
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Update the validation of "curl URL" submodule URLs (i.e. those that specify
an "http[s]" or "ftp[s]" protocol) in 'check_submodule_url()' to catch more
invalid URLs. The existing validation using 'credential_from_url_gently()'
parses certain URLs incorrectly, leading to invalid submodule URLs passing
'git fsck' checks. Conversely, 'url_normalize()' - used to validate remote
URLs in 'remote_get()' - correctly identifies the invalid URLs missed by
'credential_from_url_gently()'.

To catch more invalid cases, replace 'credential_from_url_gently()' with
'url_normalize()' followed by a 'url_decode()' and a check for newlines
(mirroring 'check_url_component()' in the 'credential_from_url_gently()'
validation).

Signed-off-by: Victoria Dye <vdye@github.com>
---
 submodule-config.c          | 16 +++++++++++-----
 t/t7450-bad-git-dotfiles.sh |  2 +-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 3b295e9f89c..54130f6a385 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -15,7 +15,7 @@
 #include "thread-utils.h"
 #include "tree-walk.h"
 #include "url.h"
-#include "credential.h"
+#include "urlmatch.h"
 
 /*
  * submodule cache lookup structure
@@ -350,12 +350,18 @@ int check_submodule_url(const char *url)
 	}
 
 	else if (url_to_curl_url(url, &curl_url)) {
-		struct credential c = CREDENTIAL_INIT;
 		int ret = 0;
-		if (credential_from_url_gently(&c, curl_url, 1) ||
-		    !*c.host)
+		char *normalized = url_normalize(curl_url, NULL);
+		if (normalized) {
+			char *decoded = url_decode(normalized);
+			if (strchr(decoded, '\n'))
+				ret = -1;
+			free(normalized);
+			free(decoded);
+		} else {
 			ret = -1;
-		credential_clear(&c);
+		}
+
 		return ret;
 	}
 
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 0dbf13724f4..46d4fb0354b 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -45,7 +45,7 @@ test_expect_success 'check names' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'check urls' '
+test_expect_success 'check urls' '
 	cat >expect <<-\EOF &&
 	./bar/baz/foo.git
 	https://example.com/foo.git
-- 
gitgitgadget
