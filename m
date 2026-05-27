Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A8942316B
	for <git@vger.kernel.org>; Wed, 27 May 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901924; cv=none; b=Cr2eq2zJdWKX9Ak0pdFAGnOogrFszweCTGoYUXrBcudPhadmkzFAEyEK3Q60pl6GRqhGVNeIjLU8ncldMqDBpNAxRJL/ZypEtsTikDkHF3puAf2/n+dAQxTuav1VVuDYxHVvdvjE900h+OcUJ0SdMeeuL0qdUI8rny1mdXh3M7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901924; c=relaxed/simple;
	bh=KQwJWEriBuwWBAHK/B2hKYM9y1nG+eRAoAubSX0ltiU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=iKf0+VTuRPsXIgazDnuuiGTRS8w7VPe9uCJGi1UeC+q3KOZzh4rA792BGr7RPw9FrX8f9oyLFft0WE7+HR90XIJufGaaFDLkS+Qabz/O45eNGQYnmhykkgIoQl2u3vY+z+yvWXTjz4Yux82AMM5qIkRwt0+ZffBjdT1oI3CFTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uyyew60H; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyyew60H"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30246cfd41aso1701270eec.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779901921; x=1780506721; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=peYscIy9Tp70Q55cFTxoufwYIQLbIiYJYoAfv3GRCEk=;
        b=Uyyew60H+/0cBlePbFQ9hBnhidJs/K9bHOLeqd6i8Cumhd2c/O5Ep3xqiX61kXPFlZ
         FP35vSVUHoWKumaPaH2AQjVGaYW5e5pxtSIFN/k7o5rtKAC/DtIqN8cA2Jv1TLqrSx9d
         xAAaNVjFeAh2gnJcQULzJ8MyRmXXsZj83nMKj/j5b22LLLF9V90v8QjQyExDhjxMbKix
         3cLDpJDD7Z6pbg6FaK/9cN/JKEjuT/fPjVTITvMH9v8YP60/utZPnv9Bd/086+rJtnC1
         G+EJyqkaRW+hFGRu1RA65bRZDBfPKcySOiZs5ivLD+bp0u8K6VdFZvKtVdTKtHwLKJn1
         UvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901921; x=1780506721;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peYscIy9Tp70Q55cFTxoufwYIQLbIiYJYoAfv3GRCEk=;
        b=Yc1gDJf1T8shTrbIzWwsXAqcFLkuuU6GZyWyQ2fAtqT/S/8nBN3Adth+O38tsdAVH4
         4VuU0XS5CSXbR3+Hx+74AxG2fKmmn4a8fjKq31mFZ1Hel7dlga/liyQAH+0KuaSxd2Cb
         +dwhsx11PgMBp7yPQe3tRitp/OqnAH7ace5RyAFbVUm6PvFsRv//GJKcQY5YjahDH/yz
         jqrLV9aXjhti3y5tCNnyzzOV4ru+TEoU1JWTG5eh94ue/k1oJVaVFsykMWk7WzgwFtHJ
         +aUStdKoRnFvY4QQEG0LV/1M0NGtT2nEU3gu5hvx6yxq1FSexpAuqlIk1OexM/IGdH7H
         V1WA==
X-Gm-Message-State: AOJu0YydBd+DrcpynWBOokRFvE5HJGkO9yR6w3ZVSKdO1C4d8dkpfxvx
	LdMBlwT0XXWsSGy7QoeiE1/zhPk/H20qkrtnAJXtgLVp8YcP5N4U+L+1vtKvng==
X-Gm-Gg: Acq92OEw+xe3+p7u7WFICDYWCmlwCXZjF5fl5lB/VLthMjpxj4uzsSsXaX/jMPDpp+A
	e0OlmhsZCwXRaoqchoxClDbF+Vgdp8Yz9z72ZRy3ImJjyfRa/nDwlfGIkoyoXNVULUcHA8chwzj
	0ogwCyJOo7TZWtsjsskMI6Ej/cqWuIp1Tk6X3tHWufuageNOhVPRrAMYqgSKsQctVIkYHC0aC1t
	3Oyz2I3ecIvnBYdbviES0dXwWxIfB0B06yt3KSs6fXcgv+dW60hK1eCWNH3xsbidxco8146unrw
	GcTiJGYVMraCwIKzu64T6th2B8lJssVf1UlBmR7qmy6xuCi4ZczFio2OuXRLiywIOiRgIjGLmLW
	fDormUEhRGpETMENsOVgloLqWfVytQ2Iizf2Rr0BO2SZbBQTyQa/A/d4FJSmGhW3ZnZwcfw/O/1
	cjivOCd36t6RNvORsHtcoyBMxemroaCSH37L+q9Uk=
X-Received: by 2002:a05:693c:2285:b0:2da:4216:7ea3 with SMTP id 5a478bee46e88-3044905d810mr12141098eec.14.1779901921481;
        Wed, 27 May 2026 10:12:01 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.172.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304cc3451dasm889974eec.16.2026.05.27.10.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:12:00 -0700 (PDT)
Message-Id: <pull.2313.git.git.1779901919956.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 May 2026 17:11:59 +0000
Subject: [PATCH] pkt-line: initialize packet_buffer to avoid macOS linker
 warning
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    pkt-line: initialize packet_buffer to avoid macOS linker warning
    
    Removes this warning:
    
    $ make -s -j8
    GIT_VERSION=2.54.0.380.gc69baaf57b
    ld: warning: reducing alignment of section __DATA,__common from 0x8000 to 0x4000 because it exceeds segment maximum alignment
    ld: warning: reducing alignment of section __DATA,__common from 0x8000 to 0x4000 because it exceeds segment maximum alignment
    ld: warning: reducing alignment of section __DATA,__common from 0x8000 to 0x4000 because it exceeds segment maximum alignment
    ld: warning: reducing alignment of section __DATA,__common from 0x8000 to 0x4000 because it exceeds segment maximum alignment
    ld: warning: reducing alignment of section __DATA,__common from 0x8000 to 0x4000 because it exceeds segment maximum alignment
    ld: warning: reducing alignment of section __DATA,__common from 0x8000 to 0x4000 because it exceeds segment maximum alignment
    ld: warning: reducing alignment of section __DATA,__common from 0x8000 to 0x4000 because it exceeds segment maximum alignment
    ld: warning: reducing alignment of section __DATA,__common from 0x8000 to 0x4000 because it exceeds segment maximum alignment
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2313%2FHaraldNordgren%2Fpkt-line-init-buffer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2313/HaraldNordgren/pkt-line-init-buffer-v1
Pull-Request: https://github.com/git/git/pull/2313

 pkt-line.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 3fc3e9ea70..cfd2799677 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -8,7 +8,7 @@
 #include "trace.h"
 #include "write-or-die.h"
 
-char packet_buffer[LARGE_PACKET_MAX];
+char packet_buffer[LARGE_PACKET_MAX] = {0};
 static const char *packet_trace_prefix = "git";
 static struct trace_key trace_packet = TRACE_KEY_INIT(PACKET);
 static struct trace_key trace_pack = TRACE_KEY_INIT(PACKFILE);

base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
-- 
gitgitgadget
