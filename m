Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336B3705B4
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240829; cv=none; b=Xv+UayWA0/mb1W7RHlyLliX+Bq9mLR5DR+ALxQRxv/qjDCpR16GTyE9fEaw+O8+Gn7F43nDPsQLKIHZg6C53dkACiSVcwmEZbqMs4fiEXDb0jUrQdHojCoFWMsH17ntMXa6I98PW76qeG/0z7G3EjuQsOwdK4Nc+8hRqKVyZoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240829; c=relaxed/simple;
	bh=DAQQ4A7p8iUuNy8qknEag4ZjhHhh4VjH5Nt91vIE5JA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XS2Vo9A6V1JIs89kdijzlYk9tvG8jsh06PK/6wpupBNz5QjOn/ux+hNlH3Fk7yYxsEuTdRU4VtWKNhKlNKP9rPEhdZR8bZ8JqEmoVTJ7ZhBND76xyuKQe8CrnJ7t7cgbJkprNj4rCO4KBtgXCPwcICvBZ/CyPzo81WiRxiKn9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5uKs0cW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5uKs0cW"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c4e9efb88aso3310907f8f.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756240825; x=1756845625; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPCJ3hhbgjHYmn1FZWeFmzELsYhsmPDOfKud6uMr2/o=;
        b=I5uKs0cW0MLfmmTh0ko7oAVuEdg6fj1MgZ9VbQ9EczMdioUmajRVJfuZ1RiPTKr2/r
         pYPRFSICNYnZGg5tHOndfAZEZ4XyyMfzrJ3I8ezcBWMfSzkJKj+9ICxvS4XR7LO1vOye
         mLg5eL98BU1UKwsay//ys/82uEB0bouLYzUwRG44JMRImdZ7+O6waAch9AWSrb0QOBrJ
         MAoD/bUpA6/wlGEzZ7fD64J5NOU7JvSxbngZZAxlfpMvYu1bYaZK2q7nrYiHisCFIyqo
         0dq2ohb57abZ+EcurleFbeat9VZHyOdHYKRa8NVeZgTq7DPxn63V3PKj7+Pq3yuES1QQ
         gAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240825; x=1756845625;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPCJ3hhbgjHYmn1FZWeFmzELsYhsmPDOfKud6uMr2/o=;
        b=UiNn3UNg06gy6D/M4w9PQON82lIuKldu56sn6Eeh/LAAocDtlPxIXWEZDvFe0DXB0+
         EbItuGku+3ZgRyYn91fkJG4ylsFqZOPgFGmFfVXo1J7/f5DjCITz5bDb2PK7FNXGXJ52
         471c55DB20FwOEEFehN1BYpwGmX/a75XKo4+XePGy9znVuFNuNP8GHOR/lnIgOtpn0rY
         0yyiuHAh6GxDWRLPrHxcLnmvKhFuXu3R7Z8d44YmEnT3ktlgmB0dyDlSpxAHwbfQu2St
         P6JkMLyjO31Qjvf2O8758qhgnTFgQ2lzjyUqS+c2zfZfumab95pNgVeGZug56A6bzFrb
         patA==
X-Gm-Message-State: AOJu0Yy9doCuK1rVHvVhNotVvpU8QefI1NnHcq5rt/cKXP/6Tf296OTe
	AkY9CjPErqraUJ0ZAqe2EbZemgjO70XZ98inq425Nx+C6UDKn/On8+l3ERczGg==
X-Gm-Gg: ASbGnctunzZc65zxKHrMNU7R9XTgJzJd0GrDSc6fANjkQYwkhJfyQacaRqDR8tNL43U
	k2eCoUbnuGuFJPh0lyMVGQ564inyyY9IvzLXEh/te1Z6mqoltvICQ/eHgxe1YkWs39rQMRE31sW
	LgZlE/bNBMFjXE98lD7obNYH4/2WMYlmLY5djzoCSVF28IpX4Ga5YCBX1wcJg1d2c9K0ZSoCY+Z
	v62IW6aqIISQh/Nsis8/geR6XqGyij87Voq7liU4TdxnOt5kuGY2S16lY6chd7s11CxBdJDR6dJ
	YXbTORSiFaEep8BQqcqqtIv4PnvLl5tNvgBFjH5i+l9RFt2xq3XK0qDujvMakU/MNfsUQHDYdHu
	4Vc7kNtOgOxuH/yLtyZ20PS7soG4=
X-Google-Smtp-Source: AGHT+IFjtv82F+kQuj0682jk22qOf7ZCL4CCtYSU9Xoq0Igw6Vp1+48s+REzo65RGDDgH4/ykjm0xA==
X-Received: by 2002:a05:6000:26c8:b0:3a4:cfbf:51a0 with SMTP id ffacd0b85a97d-3c5dbf696b5mr12273849f8f.21.1756240825383;
        Tue, 26 Aug 2025 13:40:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba046sm19170279f8f.1.2025.08.26.13.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:40:25 -0700 (PDT)
Message-Id: <36112c30bcf881f48c3de23dcae2b74e31d9a565.1756240823.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 20:40:20 +0000
Subject: [PATCH 2/4] doc: git-push: clarify "where to push"
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Signed-off-by: Julia Evans <julia@jvns.ca>

Be clearer about what we're describing ("which repository" instead of
"what to push"), and start with a positive "try X, then Y, then Z"
instead of a negative ("if X is not specified..").

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index e73b64f61fd0..5c934486c33d 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -22,10 +22,10 @@ DESCRIPTION
 Updates one or more branches, tags, or other references in a remote
 repository from your local repository.
 
-When the command line does not specify where to push with the
-`<repository>` argument, `branch.*.remote` configuration for the
-current branch is consulted to determine where to push.  If the
-configuration is missing, it defaults to 'origin'.
+To decide which repository to push to, Git uses the `<repository>`
+argument (for example `git push dev`), then if that's not specified the
+`branch.*.remote` configuration for the current branch, and then defaults
+to `origin`.
 
 When the command line does not specify what to push with `<refspec>...`
 arguments or `--all`, `--mirror`, `--tags` options, the command finds
-- 
gitgitgadget

