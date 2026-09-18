Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD149F10A
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736553; cv=none; b=ETDckpIeFAced9eDKDLQH7Hkd8M3ykwpDjbonpgZBQh1nJn/xNim3E/nU8U5EMgXXloaLceDZzQGn1NMiPsnKTa57Ctg1Vxzs0dkE0oXCnkUyop4nTi8Y8ivk/pemFdIaB6JB9t0yzmCMex19hZ0Ysy4FCLsmVCQ+drfqb21SkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736553; c=relaxed/simple;
	bh=UJCeTdgMfQMQSvGa47E7NrS60nlyadeSCdq03N7pGHA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Gd7YHSjwuVrAtl7VYjhER7rYaNMuk3wrQUONO//IeyRzT2bg6SEvTw5cILnx51yBiGiJSEI6etbD9dLzRluN/QabHg4QH8XMnPaGIwWA+KmKn4dn1kuYPm38q2wBrMkDNi6V94wDJHqmkKozrfMQUXZKvM5DCJLhBjHHTv0RPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDiGS1yT; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDiGS1yT"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so626495a91.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2026 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789736552; x=1790341352; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sjZ9bPWhT+ClPPhRN/yoqnmAPibAecPhrwhzh8PTmmM=;
        b=eDiGS1yT86COLB0tGMfa0fqIhFV74HQaeF3b4xFsf2K6r6zIUEk7CbTx2TFNqvXI8+
         usZE/XrTVsOOl72PTYxE9sgrCjhcLOrJ/djLDyuH32XVOv7I8UM8U62uNEJGyxurvHq0
         D/i5nzGDeBvJG68hX+SgyYURkFPt7UL+Sos1w1cMmJlvKQ9PKPc9eVrxAwxHwT3LBbKc
         lslanVyPp63fsBLO+slAJoA9K/hcIS4il1xxDciireAsjO20n56R8XAYpBXr05cGOn4c
         OZIEwYOrzIV37V58N+GRGHiFkX9rWtXyhbctgH+vG35Yupl4wwfyGGBJCpdxBDgtBkcE
         xtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736552; x=1790341352;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sjZ9bPWhT+ClPPhRN/yoqnmAPibAecPhrwhzh8PTmmM=;
        b=Tg1EBvSjx9E5g7VAqFtfOoTSqy0+CFSCZqhhdie/qhXEcmqzlzY+dGda87BSg4K5mu
         ZsoR/hBXUFLLwNjeg3sWLvGmkKB2cn6doArOL7Y3+55lcDdIl6e5iBEYBi+pT6pL6Op7
         mvCqfFRIWmweI8ypnFHsjm5jEvYKAwKiA4RXEG9MS31Ht9m5Wk1HNcSWyTTD9BwfhFJe
         5ZpYrK/ywezxXosr5JuZ7NIlerUqoqqKTAKVTs5tQmmkFQ685dCM9pwzVzATEf6dVHBN
         XyNi9WkQM6PMtB2IykjKxxXmRWB2jOSfv827u2VBW4SMcSYbc9wt+vkMsYS9c/V1kIfK
         Vxzg==
X-Gm-Message-State: AFuF++ka+jVg/UvMsWZ/M+W6LExl6XHIQvnq3gywmQZLkeDxG6ZT+QlE
	FKae9CpadKXqzIJvRERx2/TWeH6ALEgdH049R8EwmZQxhvL/Et75QckJxP1DKg==
X-Gm-Gg: AYBFou2XOGOMMmCPMym2vKlV7WVwDDY0dJXnf/HCdKoXsDiK6mM4uRpZS92orosQ+UR
	vN/kcJZi59rhscmizkSeTKiefU+JysHN79vI/uYWcGM3V7RDPvdg7Ldosv8+/1pZ8hdzzqPEd9N
	Sp4BHsM6SvBRbkTDTFc1FN75/DL95VAOMZALQBKLhhkpeHOut6ool1futqPLENpf2y5MS+GknNr
	uYM0wJUDqDxZG8kNT25rcdZdF686nttN3QMGWVmpttZh7XDv5joGxkfqi6T6CWUvJtyF3TW3OV9
	mPZUMhgv37G6FToSxr2X/bjD8DusGZdxA8lHHo31pMgNK9HoaRbnZyxCcn/aoRp37JLw4Z9MWTJ
	kOPtajxaY7FtTDiPwUPZGBGJSjb1EZOs7MoFtNLP1msFPZgumRBsR1dtHTbfu7bHgtx8ndepLgM
	xQ0IBPsUXhFLgPjEXBvC2Xt5JTuS/E4oPAelkG332QZlSw7+8jJ+ac2FbxIAFYT+9sB2bbcLqu
X-Received: by 2002:a17:90b:5545:b0:39e:1ec8:adc8 with SMTP id 98e67ed59e1d1-39e54d4a20amr5646085a91.14.1789736551456;
        Fri, 18 Sep 2026 06:02:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.95.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5a0e860asm3935850a91.1.2026.09.18.06.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:02:30 -0700 (PDT)
Message-Id: <6e654dcbac2ac1b6c4d5311e64ce516d0bded0fb.1789736540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 13:02:19 +0000
Subject: [PATCH 5/6] json-writer: include strbuf-safe.h
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
    peff@peff.net,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

We will use json-writer.c as our first 'safe' API, after removing some
unsafe methods that reach die(), especially the strbuf API. However, the
fact that json-writer.h includes strbuf.h causes someheadaches here.

Normally, we would only declare 'struct strbuf;' as a way to anonymously
define a struct and have implementations include the full header as needed.
However, 'struct json_writer' needs the full struct info and
JSON_WRITER_INIT needs access to STRBUF_INIT.

Thankfully, both are included in strbuf-safe.h, so we can have the header
include the safe API and move an include of strbuf.h to json-writer.c.

However, this has some implications to the trace2 API that includes
json-writer.h and implicitly depends on that includes of strbuf.h. Have
those files include strbuf.h directly to compensate.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 json-writer.c          | 1 +
 json-writer.h          | 2 +-
 trace2/tr2_tgt_event.c | 1 +
 trace2/tr2_tgt_perf.c  | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/json-writer.c b/json-writer.c
index 34577dc25f..e7fc5775da 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -2,6 +2,7 @@
 
 #include "git-compat-util.h"
 #include "json-writer.h"
+#include "strbuf.h"
 
 void jw_init(struct json_writer *jw)
 {
diff --git a/json-writer.h b/json-writer.h
index 8f845d4d29..fa8cf02253 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -70,7 +70,7 @@
  * of the given strings.
  */
 
-#include "strbuf.h"
+#include "strbuf-safe.h"
 
 struct json_writer
 {
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 36a746cc10..b25fa0fb30 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -5,6 +5,7 @@
 #include "json-writer.h"
 #include "repository.h"
 #include "run-command.h"
+#include "strbuf.h"
 #include "version.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_tbuf.h"
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 96a5bc7f10..5554081c3c 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -7,6 +7,7 @@
 #include "quote.h"
 #include "version.h"
 #include "json-writer.h"
+#include "strbuf.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
 #include "trace2/tr2_sysenv.h"
-- 
gitgitgadget

