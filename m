Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FEC25228D
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020335; cv=none; b=F0a2gVq8Y95S7IvP/Gl0vbBNd7SUM3USwylaPcn/JhNwwWhIw6dDrlTgFtURuP1nX7V399RHPDI4q1qzCtfVUZHnIPBKQSEkiibYz3qksqPgNL0ZLbTMEchMw4Odfix4v1IjVNK0O1bMEKuB1LeGpzvudNjByxmnQliZdqEKzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020335; c=relaxed/simple;
	bh=S3/kMzM2geTwNprZYPBHQl8aaRUnnunLOyhOgbzWBGU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sxBRUn4ZXPKwhSahDqUee/9oNO8lf/G/eJr24+U3AOb49WbhZX+VUprKKdnWgEwNvUnawgr4guIBCYgj67YWYOUWDX5jd8zYxux4mdWzYtAXrWSAB194uXfdDC5VgOJQpOTUAjW1vc1RbnXlwVmkKTcNZVwM+YYPaLVuOgPGqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZt+VpMQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZt+VpMQ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso5186947a91.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020333; x=1789625133; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o1Szer8xUR94EJOlQzhEDPaI9OI+dLj/IlRQ8hmzOeM=;
        b=qZt+VpMQapAeqqg5h7P/lI6PFPbVlhPF+ssnq3hNVHoBIBvY30DjblSOu5VGB7ywQR
         rNv71m0pA99EIo13XPvyBtsRpKmyf0Ombmvil1RpJiCx8vpDGWN1TsY4OfN/W8PKabwB
         aEPCN95l4KHaxi0NnkG/eHdYtGJ8ThvcHVuqS6BiiB9sj8R0IyvjFoxPV3y3jMFtf2o5
         UG8+jGDVGeqEA/g1dTZB2StuFBCt1OqNwSjupMJ7uPmRbMfEDGpnr5JdyUCImOuqlvru
         jl+3ayu7QvSSN36P+vlXrNoG40ZPp0q0yV+jVEkR8d4rgEJjk0WKUBWbQrch0F1cIltU
         SWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020333; x=1789625133;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o1Szer8xUR94EJOlQzhEDPaI9OI+dLj/IlRQ8hmzOeM=;
        b=E9go/n49n4MTpD145hzTLHA3TbLv0NtejWLWNi+5OTCwWHGsMnXdu/1q+f9GZGg8hD
         PPMmt0qmNORP6rUwqGu0e7VhkGZSybSho6Y/g4l+2/O412CYPis3VwqZCpMDgPO4b+IG
         tOSGfKoyKnJA+zm6ijswFAXUneH/h/aiB8u4XOQ3yHHnXACloM5DMGyc9ojL620lMgsp
         gMMDVgw8O8pJKsWZqcgp5Xx6zeGPb3QW/VQP/ES4ZhDX+xwyJGaIvK7T/xovgU/SOQLC
         hwlbs5c67Kab/r7LdFh88uptmxw4IscMG29nezsrhD+Qk8cqK9E6Qtfcvck3T5tuC9Vt
         Up4Q==
X-Gm-Message-State: AFuF++koZmbuoIvCgMxd7hsPNNbxzs+jSzGJ6mEtCtxINbPhIIj1oqqq
	yHGCiJldpYVAooOm+8gpy25F4WY3hnuSDDR8HkFuYpPeSNt1uTBWpb7xmdCjxg==
X-Gm-Gg: AYBFou168QfHjslucYjCZfV4Qv2WdtNKBpeDJ2WTlZG1O8HPg+2zgvKFyTk5F94oi7t
	Po5S+x12uW76dvKr3hh5wTRjXQXlIELkCPwwsMxxlvmryk6+tyy4SUZbDef6c7IT2ZL7fo6jCfy
	W4lEbBFp+FTHIuo+gSkfBRiHDNCSkuyA52MQMdgvQB2xKaq33k7ESme53qbXJNlvhbNR5q4B3pD
	aXHPzbBe2r4S5vIUxYVRr4WVUOQQooMGpraz92D4BtBPz1gtpjAQn8AY1JKfbwDzQrA/NKUtY/G
	/F7rOr/oyH+yWC3cp9/MVvYsieBb7rlkPs9HFO/GZR968FOZKHX9DRdzZXU+99M7H3d/j8pmh4m
	6O+x3iH9CWrPOLMvOPyF2a8WdeZdXv0QSTG0jVY42wQGevsjnqP/SCKa+rkPayxtzBcnw3ox+KO
	hFmmixaja3v60NGrfp0aUHrJs3Oq23wTRuStBrcY5k+y7ZqFAVYS64ki30hXOmQJIm5R91d+wk
X-Received: by 2002:a17:90b:3852:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-39b26272d69mr59535891a91.16.1789020333119;
        Wed, 09 Sep 2026 23:05:33 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-339770f0489sm18885626eec.8.2026.09.09.23.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:32 -0700 (PDT)
Message-Id: <340dd18f2749812f27fae9ce7dd64cb61b6ba2eb.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:17 +0000
Subject: [PATCH v4 03/13] mingw: drop the -D_USE_32BIT_TIME_T option
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This option was added in fa93bb20d72 (MinGW: Fix stat definitions to
work with MinGW runtime version 4.0, 2013-09-11), i.e. a _long_ time
ago. So long, in fact, that it still targeted MinGW. But we switched to
mingw-w64 in 2015, which seems not to share the problem, and therefore
does not require a fix.

Even worse: This flag is incompatible with UCRT64, which we are about to
support by way of upstreaming `mingw-w64-git` to the MSYS2 project, see
https://github.com/msys2/MINGW-packages/pull/26470 for details.

So let's send that option into its well-deserved retirement.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index a464b2009c..cc0ed63af3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -768,7 +768,6 @@ ifeq ($(uname_S),MINGW)
 		HOST_CPU = aarch64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
         else
-		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
-- 
gitgitgadget

