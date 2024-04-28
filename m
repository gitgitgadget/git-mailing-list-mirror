Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247D23770
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343472; cv=none; b=TfzEuE2hOwIAAH1rnqfVfkjDJRG4FyOfXvpIBVgfPqFj91hkYUFUTmFNIp+w6igNJJL/9OhNeowTvJRoAA3fj58fAiheAODwLaR65FvXtwG5gzYdSIBHCc5r53cGBDuFRxp7H/9UMIDFjol/Cl0Cxvl/MPNejNfNSCHE+wOZ2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343472; c=relaxed/simple;
	bh=blfrgL1shA6DGJXD5/gNPeLe3M+Xm5SezQWs8vxBCic=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lzjKlyJrELVVTAv6UtqcEnkCFtdgwlwZwrY/BlN9p7PYyNNJhm/ymTcSmNGUmAJ3i/Yez7zATbq6cXv7rcGnmmzMbannSArY+UFvHDli4Ltz9xCSQKsReTVWv570zNd5fdxNpsptycHWRKd+ZNrxIVMmCvu6Bb8oJ3BgDYO+VhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQrEsdCS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQrEsdCS"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34d13789e2fso266853f8f.3
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343469; x=1714948269; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtb/oxmyiu258YJvwAQ3i8cFUBEs6IaObiXGc9l2sn0=;
        b=cQrEsdCSR7tFGXMLr32zf/17gCD+277MRQhBFI+swuBcAygrciyUWcPg3k42MXPwJS
         3xbi/zgdrQDS1jURqfIfFaAdpWDnkw4E8PKdP0uUMP26xUwvA3UoaaxC2t6Pl9/2/Cea
         yzvSrlao+qCGIeYIpg9oPGFHm65GXoo3RyE5yOnOtKVIm3+ZstYTTp3Gpl13/LwjknwY
         9HcadRBooOHGpyLpVsqGKU0YeJBTTfBxlTxMyvScqboaWgyyDICiGFp7OfWY+Lm9KYfG
         OLTsnkHFjInSHG4SBuZx8p6wJyZE7zxRwhgttPSabKicL6YNx+EimoMyde1xJ3eSIQLv
         cV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343469; x=1714948269;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtb/oxmyiu258YJvwAQ3i8cFUBEs6IaObiXGc9l2sn0=;
        b=pXJuRIdXKNH6qwhpe2CnOlnDJfm83np73FmT4CRpFr5hdeJJUVPPwnICha2S4cWa57
         xGEVhnYWdY6F5TCs5WCBOcAMrLzF6BufiGhB/px+ZPqfaWQlAwu4fKFLPq3pjcemoUmk
         szq4zVEKMg28QzMXaxEtTcnK5R9uJ2i3PfchsTEp3j9L5Mtl7H6M97r5G6ZbopDUYnJ1
         snqyvGBrC1CoW7mhexVeK6zXqemJsgCZBCh5mbMQK7ksTRwpfLdalZ3d6lmd9vNk1SKn
         ufglzY6s2amvA16mXBlmAJgPbE1uOVhBy9u/Rb5iVXD5V5FcFyvU0ukUwonBR/KTo2Av
         f7Hw==
X-Gm-Message-State: AOJu0YxrogAaMYs0fWe5rv9BwYPBKa2Of+rVMOKrWU+hq0JscZba2urP
	CU4WEU8+Sq/dsZFoHWVtpW7kNvxfZg2m2hcRJgQRg7tko+F2LBMiz/ULwA==
X-Google-Smtp-Source: AGHT+IHwbAJ/hxQKmk6EsJjVycF34vYk7VCFvk9xQeoiYvvVmuD+Cp0zS/jDHCzwgIIBKj1dZy5aWg==
X-Received: by 2002:a5d:5549:0:b0:34c:a56b:e980 with SMTP id g9-20020a5d5549000000b0034ca56be980mr3561481wrw.47.1714343468871;
        Sun, 28 Apr 2024 15:31:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d5602000000b0034d117df264sm1046225wrv.114.2024.04.28.15.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:08 -0700 (PDT)
Message-Id: <149c476b1ed74897ffbdf711754b9804fa679467.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:54 +0000
Subject: [PATCH 06/13] url-parse: define component extraction helper fn
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
Cc: Matheus Moreira <matheus.a.m.moreira@gmail.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

The extract function returns a newly allocated string
whose contents are the specified git URL component.
The string must be freed later.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 builtin/url-parse.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/builtin/url-parse.c b/builtin/url-parse.c
index d250338422e..b8ac46dcdeb 100644
--- a/builtin/url-parse.c
+++ b/builtin/url-parse.c
@@ -32,6 +32,42 @@ static void parse_or_die(const char *url, struct url_info *info)
 	}
 }
 
+static char *extract(enum url_component component, struct url_info *info)
+{
+	size_t offset, length;
+
+	switch (component) {
+	case URL_PROTOCOL:
+		offset = 0;
+		length = info->scheme_len;
+		break;
+	case URL_USER:
+		offset = info->user_off;
+		length = info->user_len;
+		break;
+	case URL_PASSWORD:
+		offset = info->passwd_off;
+		length = info->passwd_len;
+		break;
+	case URL_HOST:
+		offset = info->host_off;
+		length = info->host_len;
+		break;
+	case URL_PORT:
+		offset = info->port_off;
+		length = info->port_len;
+		break;
+	case URL_PATH:
+		offset = info->path_off;
+		length = info->path_len;
+		break;
+	case URL_NONE:
+		return NULL;
+	}
+
+	return xstrndup(info->url + offset, length);
+}
+
 int cmd_url_parse(int argc, const char **argv, const char *prefix)
 {
 	return 0;
-- 
gitgitgadget

