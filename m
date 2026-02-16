Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A32745C
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257221; cv=none; b=Ai4dzrEj4tQWTSygKczJ9aSuyPKy0P4KXwX0StqhG3nGuwGG24qr95V6c669HBRtR+dsbYsrsfBDGcAli4Wek0SsL7jtv62agEwPrrJRv9DzKvY9s3T1J2zwaTzuMdWCkM0VnUrzT7bhkpQ8kRjGj/DWRiGb0UreczOTEhJOwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257221; c=relaxed/simple;
	bh=a+DN5fjqdWdSpm8Hk6suuHjSu2I/3LDlt7AnTfJeDjU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bcgFbgtek7RMqpeDRbJ4sgenxsvD76Tgru/+w/TP4Hlbubr1Dvyg4dsITeuNHCMD/S7wQ/lj6LCvQpZKgf6GE3J6iDmCMv4EogvgDr4d1Hs74X1Ww6aSF9iyFhJG8csf+1oSic+oreJWwVESLtTI6DJm/QWoyc1exqF2sUTtZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drhn5ALd; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drhn5ALd"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c70ce93afaso325999085a.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 07:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771257219; x=1771862019; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+7SwK5kjJYLIQsCYDnJ2opui+vfOv3dX8tL8lw4Z4U=;
        b=drhn5ALd2wECg3gR4+F0VWYo7cNqjDdjMSDekNoktg5OkY7+SfoJsnjn87whU5xCCe
         /AuevZ7VOHPS+cOSN3uidZ54ARmcu4nmGGiiOwHFvrAx9Et9h7UYvd6nAAPnpcmA+FVg
         1Qfanasb7VbnZd4qfik4itYDxrIckJkq3u090x6KqqHwxrYjS+4E9EPPgXxlf5aKebNW
         M05pB/AniKNKmBAazZcabOyKPZMpvXXBok6WZKLloiKTT2hLcXE24YEXTIhCEjGReCQV
         r5bD37RN4ro1erPtrfj8IdEpQzYGqLptGtKKKI8AE7l+Kk8HcmHmolXFTg5cJka+yJkz
         jIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771257219; x=1771862019;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+7SwK5kjJYLIQsCYDnJ2opui+vfOv3dX8tL8lw4Z4U=;
        b=vQXrq7YaNVa803BUck77aGP7SFwc7EAQ3nt9YTflJVSZ4anY258sUT/cHs7luNYQLS
         QwViCJ02mO82+OcLOB/WDWYO8L9kESQ9UZWm3beRKwH8UHFv85Z1sI8YGgTIgxItr1ct
         HVOyiU5+SlfbirNnss4ME46iK2tCRO2gRCc1x15lNsRMLqJ5CsdnNnxfhIOn2E9U3eYC
         ByGf80GpS0iQ1GeWdC3e0DqA2fkKrkyTc0VjJFuEhK2EFphvARpdqAYqiyxMtQ+4wvEV
         VLtjVFBZZC2DLQ71EqaFPJ0QHFqJRtxj0K/7w7h3SB7lM1FbxUnqcAH+sr50GD9T7Udc
         TAkQ==
X-Gm-Message-State: AOJu0YxfHNABCiNryGbKf/6fnTlGKtS58ty/G5g3xB8rKfNeXzroNZcm
	HcvVCDCDiyIPLgIfWW/JOV+hoQxfan0s147dvK71DMz7sm73PqLMnPl3vw//Ahjt
X-Gm-Gg: AZuq6aIBVVAcZxZd+RwbvLOtAMyTW3zfXcl/QLibx0uEAEMaMGwo/uuHTZZRf8fDGp5
	pDy88JabEMZHwWX52lhsAaxwhiPcBaJhpe5TicqgC+SNciqlvLOVUcwKcNLfiGmXvN7WyAMu5rV
	zC9i68clkw22fx5QxFCjNzEKotyyGerXxNYt1RCRVMk0gvc4vpy2wCJO+J3xYceBA3uxXLqw+rM
	II1WI7mfpvs/huos/WDFJRf1IR/9yPkQy1521hsvsEKwWi81Yd+3B66MlWZvnPZQULrDvLs3WpN
	hPKM1zpIQCR+H4SlJavNaoMHuuRzNv2TssmnGw6lDZDGrVonL2F1pjptu9bkO023bX4qgD8j6NZ
	G5ggU62YjACzD8AqJrJj8IIrVfhxxa+g86qUodxW55nz3fiDXG8/5IzReF1OCaO0wk4XqBaGQ+W
	DVg0qvPT7p3F5xJONObMc65pQ7gUk=
X-Received: by 2002:a05:620a:1a9f:b0:8ca:934a:5e3c with SMTP id af79cd13be357-8cb424ba3f9mr1244691085a.79.1771257218761;
        Mon, 16 Feb 2026 07:53:38 -0800 (PST)
Received: from [127.0.0.1] ([135.119.238.192])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7ff1csm140696646d6.3.2026.02.16.07.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:53:38 -0800 (PST)
Message-Id: <95ded55c31ee56943327c8e321ed7b5311ffb1ac.1771257211.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
	<pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
From: "Rito Rhymes via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Feb 2026 15:53:31 +0000
Subject: [PATCH v2 5/5] gitweb: let page header grow on mobile for long
 wrapped project names
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Rito <rito@ritovision.com>,
    Rito Rhymes <rito@ritovision.com>

From: Rito Rhymes <rito@ritovision.com>

On mobile, long project names in the page header can wrap to multiple lines,
but the fixed 25px header height does not grow with wrapped content.

Switch the header from fixed height to min-height so it expands as needed
while keeping the same baseline height for single-line titles.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 gitweb/static/gitweb.css | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 8247646063..e2e6dd96a2 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -42,7 +42,7 @@ a.list img.avatar {
 }
 
 div.page_header {
-	height: 25px;
+	min-height: 25px;
 	padding: 8px;
 	font-size: 150%;
 	font-weight: bold;
-- 
gitgitgadget
