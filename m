Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A630EF92
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567308; cv=none; b=GrztjYz9+2AftOD5/dNd7GWZUIYckIGCo+ZtptGFj9css9QHbo3XYr1decdoz95zLo9CHFg1c5+5lZzLU3/iu0K3dzq1UxelwMGMvNUSbmWgh0Vr8Y/NgOdX98CjpRjxBXCYkArlUJMQaxaGzZi3J15E8QxGrlV8Y9R6nmI+kWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567308; c=relaxed/simple;
	bh=q6tXfN+bubdtggisTTP7f2c3On1NxXVHK6HKCLz5Uus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qimph3sLY3SY+STKM4LmUHWr4hOGFeQInSm0Kyz3PP7IEzYE64hRQgju4crYFhmbG/uSZhjXHfbdlDD/kV7DcJ8uxgg3v5tU+LGJKB0CKKU3XZ+ZsADxjFXR31PDNuO+BaVJKEIu+ho5ptvbFKMPp7JOuzUnN6Wkzrelw9dQe+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=MDRJDokp; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="MDRJDokp"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d71bcac45so868267b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567305; x=1761172105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qyEUPiG8evv5Xf2fM4LOHNdM3b1128OI3vilVfkO/P0=;
        b=MDRJDokptFFOA7kafiOM+9ymEG5sykWC0bVBdwMJEUQqqv3T/KSVVKx44OetzYq/Yn
         te0LoJsWuCmoF5b96T4lkFUuEICS5r5XyuqifosFb9yTCjzxiynH82atUhrrTRVzFkYK
         dsre2+6v+6c/keMIkw19+HEq7Nr/SdNq2os+v9yc+IGQpYify65IpOTDcw4Fg7KFS1QN
         OuYchkD9agPrLzbQRkCgfmkzXyEwJwBDY9r2iDbq1Rf/8PHEUyMyBA4eWy9NTZ8mN5CZ
         v8F9Su1dZvx52xjjjTI5x7M1oWxqzouRmC1GCj2cy+Dt8aOifbJajccvDo/ddsn+fRn4
         T24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567305; x=1761172105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyEUPiG8evv5Xf2fM4LOHNdM3b1128OI3vilVfkO/P0=;
        b=QfE+ERK8aNmaAiDHr+3IyfBDazKc8SPSbAwDpxRnC4qJezTtXhER+J+p2AyfoQCM9r
         WKyJggzYyv0yu7HV6hzBWiL746ItfdierbMngUPsm4CxrqaeM9yIH5uPZhNupO/FE6HJ
         oT/ja6fJPgoUgiRDl77vCcQ4lBM5V3Vk1vSLH04hYQ3fOyZUr8KOqDZRgVJa5VDlZla8
         kdRlt5rQWwh1aF5RAU5gLDNddLJ0uDefL6wcTVMOos4ZGuUcljgpJ4IlmaI9JecND+WQ
         YV0KzrnM4rttOFPH7SqYow9DEKWBe/zGPU31IfREmo+2T5Yr0yhHxteYG9hHVpMRuVV5
         0pbw==
X-Gm-Message-State: AOJu0YxK4+t1vDBaGVBGVxReyV3kgbel5IK0mtbf7S3vZfnxeDgg4uEi
	+s05PQuBbYwAS0q4kjJo+Vgua5dwDPLiKEVD8kXZJ9hAHnSZ8pkI/5699fMhyO/o4q4zRbC+6JR
	NDMFS3xTv3Q==
X-Gm-Gg: ASbGncsjm4Zhkxlx5sil+r+QAMbSTxfjYs7ggIOH75EQ622hK8hzslQ7XZdoLPzc/cl
	P1RJujovebDI/SPiD/ssg14QfIhTGno78fuffqPiTSLOUe2RWksCXvki0xVEiCMMoozcdKzadyc
	5HoGD24cN56vAffC/B+6VPOtIaMuDq+sbkis3J8NB7GiqXWSPfDk0wbroypyjdpHZ8tZtH8Gz8v
	GY83eWaf5TbYXdyM8w7Z53rTrjS5jWA04Zcr/FteO8NhDBkYqFzhYMv58oEJ9xmTt015WKfNl+6
	LDnMk1tu1FJoAAsdxu9qKvg1P72I5cOmRqOxfpBFV9cRX1F6Fzt1H5zy1n43v/Hg1ONBCismI2k
	henW2cvarS2yPiwBMla7+2Sqdd1wDjQWozFN8H74EDE61lmpSjCs7hixpK2sSGKaFhNmKxv943X
	d8/0nF1JcZ7pYqijdobVvUHRjOUGOASa1zh9pkwtJalB9GlG1zIzVCOPRC/JasbnVwqONZnyVzV
	oC64Qs=
X-Google-Smtp-Source: AGHT+IG07tOGxcJ/vmlQtbuY7+KFuN1+wFqlfjuT+39VSnZL1GRVu9+34272CZWD1Ze/8wXOrxkxRg==
X-Received: by 2002:a05:690c:6709:b0:781:64f:2b5f with SMTP id 00721157ae682-781064f3889mr206558927b3.59.1760567305232;
        Wed, 15 Oct 2025 15:28:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828d3bfa7dsm2744957b3.20.2025.10.15.15.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:24 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 22/49] builtin/repack.c: pass "packtmp" to
 `generated_pack_populate()`
Message-ID: <acd9a83ed035ff0bec330363506acc30ef669672.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

In a similar spirit as previous commits, this function needs to know the
temporary pack prefix, which it currently accesses through the static
"packtmp" variable within builtin/repack.c.

Pass it explicitly as a function parameter to facilitate moving this
function out of builtin/repack.c entirely.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index bf413a6ee2..bed902adde 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -150,7 +150,8 @@ struct generated_pack {
 	struct tempfile *tempfiles[ARRAY_SIZE(exts)];
 };
 
-static struct generated_pack *generated_pack_populate(const char *name)
+static struct generated_pack *generated_pack_populate(const char *name,
+						      const char *packtmp)
 {
 	struct stat statbuf;
 	struct strbuf path = STRBUF_INIT;
@@ -271,7 +272,7 @@ static void repack_promisor_objects(struct repository *repo,
 					  line.buf);
 		write_promisor_file(promisor_name, NULL, 0);
 
-		item->util = generated_pack_populate(item->string);
+		item->util = generated_pack_populate(item->string, packtmp);
 
 		free(promisor_name);
 	}
@@ -896,7 +897,7 @@ static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 		 */
 		if (local) {
 			item = string_list_append(names, line.buf);
-			item->util = generated_pack_populate(line.buf);
+			item->util = generated_pack_populate(line.buf, packtmp);
 		}
 	}
 	fclose(out);
-- 
2.51.0.540.ga7423965ad8

