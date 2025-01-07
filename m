Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F7156968
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285066; cv=none; b=P03UYh2LVk7cizETsdHDKlDkKuDoz+BGrRMuQ9hOQMu8lO6DHLVz0DJLdTfWnnxaGn+eVzkRqRIEetx2TbVF2kEYygo/JkgNsa/m6BkfyHr+E3MCeixdXvPYasupt+4uGkXvjRNmxnHtWMEzRZ8UOHofvbJGxF8HZeN5Gk+AFOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285066; c=relaxed/simple;
	bh=QlhJ+9/eVE9GwT0kF7DJKlT/b3eb2DyMOJsoXKnSkXw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VCkiwazITzKI0047Hu+BjVZrBtUssxUliWtxmk7/E8LqCKOlo2ORLREHmYK3zeF3AGy2QmRtaasqhYp8NCTCiWlFO0YckPWtcNPNg0sFuE9JMdsH6B2Zu1pB8XP0tZcxomu+52coP/PhxNeDbz90R6bwu8sbvJB2SeLwBJ+EXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhcFg/GC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhcFg/GC"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436230de7a3so24648015e9.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 13:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736285063; x=1736889863; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQFDv10KtG1boUe2H0y0/g9dnYoXzKa/vfNYX1yQgIw=;
        b=MhcFg/GCyYaMOrOg3oNcgDx9rubLH30A9CX76EtOSMl9odIJsZchAF+oflF6Qds+y9
         F9eE1qRci/V0C+mSlnFJ/GX/gXTSGw0VhiPMaxSI/+ig0F4ZsqvlNXb/EuJYoR8SeTnH
         1Tp1R4BAAcwu33GitcM74rFUxtc8vT75rujWfVo6XDECZjlMOE0UsNiGc/ttStBZxB+K
         h2L80JCCkwxyz3WYsTeLeyolz79tuj62JBwssfnpGexTaJa3ojq/N5IZNEfwoW2QBjWO
         HdvQuJwX2M5aD+8VJzBhg7UAa8BS7llLVDr4nLFXncjWowdjukQWlpM60Ai5TzDpykfY
         mZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736285063; x=1736889863;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQFDv10KtG1boUe2H0y0/g9dnYoXzKa/vfNYX1yQgIw=;
        b=ly4wKWWo5hcyMcLvmHv4JjsO4Fypu9l0koyT5QylVVA0UF20L4oI5bw+8vfkdpWjeY
         Gd7wxQMD1eIrxlRbHHyh0Ww42nG8b/7g7NC7m3srB82U2Rx28fA9hZjBY9yfTPnnOSLe
         4oUqbArwRtaaMHoJITBGSeMzo2JmA2ecILuUedcnP1hx4c2UfHxUw3+i2eaVDocXGWyZ
         kClHMQMi/QyBNmSvHos3qJlC8qblyf1yMS/eqotlvFnEKyTKQydtmkPHVr0k8/ZR1b+p
         RadG8q0mzyOOudNCeD9m3hRHtwiXPX4M7PLHG3ObEOrdPZIIU/fIC++hWY7Aeyj7wmwW
         ArcQ==
X-Gm-Message-State: AOJu0YwNhA0RfM+CNIDZCm/mrkC/AGbDKN//xs+t38/JnQI6F6T3KcEY
	2FJkG8jHe93sT51wHmuUpDJ3PDn0Hi7EXFyRTNNw7/KmVJSDhAyM/myMiWWKV18=
X-Gm-Gg: ASbGncvyn5Ej5osEg8eGHZI2FayJM8f6ousGXdSIEfyzfsWoMJLgQh5P+7I9IKN96Gj
	HKVVHI3zi46MAnGYb9LBpf/LYlXwHCgG/vAxDm7Wo/9Ttl41cxvN0cYyy6zWBMnI3mpHr2GMbPz
	iIs0wxl96dZ/xGe3LVN2Cf9ybNifqNv6FCoFeEqp7lxsMl7kXbtykBf+K+9m+GIU5FDhpCsM9km
	oPusxV3rgm4Im8ZSTnWKMSlOxxpFTQVmKOAwb4piPR14v1cyUBqAQjoJZJH
X-Google-Smtp-Source: AGHT+IEigPz6K/MRQQScsMDGBIyw3AHX0gLPuEJnVkExTQMzwoEtH9Pid7wrUo8CRV5LKWhYf2qY0A==
X-Received: by 2002:a05:600c:46c3:b0:434:f335:85c with SMTP id 5b1f17b1804b1-436e26f4258mr546295e9.6.1736285062974;
        Tue, 07 Jan 2025 13:24:22 -0800 (PST)
Received: from archP14s ([185.254.75.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dcc8ddddsm21856085e9.0.2025.01.07.13.24.22
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 13:24:22 -0800 (PST)
Date: Tue, 7 Jan 2025 21:24:21 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH] docs: fix typesetting of merge driver placeholders
Message-ID: <20250107212421.7yyvuzw4uqxnqv7t@archP14s>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Following the `CodingGuidlines`, since these placeholders are literal
they should be typeset verbatim, so fix some that aren't.

Signed-off-by: Matthew Hughes <matthewhughes934@gmail.com>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e6150595af..5d12b78549 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1166,7 +1166,7 @@ internal merge and the final merge.
 The merge driver can learn the pathname in which the merged result
 will be stored via placeholder `%P`. The conflict labels to be used
 for the common ancestor, local head and other head can be passed by
-using '%S', '%X' and '%Y` respectively.
+using `%S`, `%X` and `%Y` respectively.
 
 `conflict-marker-size`
 ^^^^^^^^^^^^^^^^^^^^^^

base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
-- 
2.47.1

