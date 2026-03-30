Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15A83DBD63
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890017; cv=none; b=FMHIDnSKT6bjYs/5zQRz7O3apTrCL9OSJA+i+tkrdaAizBHF0tIkLqF+UtXuZHyB9QHXhpyFbUzgVKAUcmc0TGakHrr0QjMmaTMV413NmitVLEnK8VQ0pWNdzqn7b1twnHYqQMuWL3VgoMmOQ/Lmb98UeWobzR07whOZV2QUqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890017; c=relaxed/simple;
	bh=iqZH56zsqnADEN5lA2deewxNQGTZt1PFfVB+27n7ocg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QrgQHOtjycqrxRHMNkp9bPqdr+H5h94KL9ofh5gqL+UPoMn9RkQyfPJ83D+RLQj72pGv2yOfabcmVNKv2NlLKLociCHirBtPo25ZiPOfMqYzdBLGVdvxJDbeth1H1mNO/81A9+qv+uIzGYt8P7JpgZXUUqNIkoz2A2bn1po9ul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7svfkKB; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7svfkKB"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d86eb7c854so2474950a34.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774890014; x=1775494814; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9J4vvq4bJy0GevMew0l9Rn/3185hs48VT2jhz2HQarA=;
        b=q7svfkKB0x9Qjit3Ze2C9R1F6jwoLTaGPI8Uw1nRsgDKj+f3rRPyKdLuLFIANboTKZ
         fNq+RMBtvh4KUGZ0LkzHK5mqOG3wTDz/y6D2Pr8GUI0J9NINAWxP3sqDwiY/Hf0USAk+
         GJnuFp4+8Y8iCuzkOKWik6MQmKwtOyALAIhLn1vgtGRhpasNEV6DpHk/PATA9tiK4vok
         Yltyt8jILijlSsyVDiV/jnlWv5d3cJoG1ujHDcmN6ZryDX3+VODsXtbN3SVpRUM0vQHp
         DvkRsOaKKitLzuMQ+TcPemF15Gm55wCvlfuxhWHpgfq8iEt+9gNcOSsDQhIw1ZXDWpeZ
         wU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774890014; x=1775494814;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9J4vvq4bJy0GevMew0l9Rn/3185hs48VT2jhz2HQarA=;
        b=Sz0u/ktcxL7Acdb59qMAlIxWHsVOlCjXkQjYsPuvmidnOg8tvpK0xwuhZ0wWQM/bM4
         FWBZ5LzjuM3zXUSx4U3iQEEUXLVRuGf3vBsbTbnXKjUFvVeE9/RreiZUWZ58xZWXwiMy
         eykLZmW5J8KNIfggxqSVNAUf/3VE0EXuFQuWR3okcAg5RWYtXQ6AfyrlySupegnadNeW
         4oR3zBmBBxKs+IKfLcOxPYcWA53irdM4mdljcRld0ncGdbx+lu40vybBbXyFtwj0ZZkd
         VC8JYx7qmdMQqiNiNBLSocp/BjI5lMMvW25VknQjz282neUMePJ0lmo7sYy6cllkHF9/
         +FyA==
X-Gm-Message-State: AOJu0YzLhg1UYKgU97LlPAw36w6zQkO8LHX0IR+FCwpAKG6px8zB2tzp
	fpeW43qvwI/9Z7eFClTh3CTBcAplYZ7jDnsG6zIFkWW+5R4NEElBjEkkebY41Q==
X-Gm-Gg: ATEYQzxvFGbMsBpYucrDQdSJX4MnuT/zHTVosowv4P61wyg1HDcZcNbdNw2Z5FrUD4S
	RSzY6mUBv7LFyJ/kPZIUJ7EqUKWJ1Y1gKmwEk+uXL7kZMRcj8lVSCLGCAuHWD903dxoKElV195n
	MZd7uP7pcIEGOdniKN9FhQO6TX5NQV1gM3YNCvqaattDWsVBcrq1U344XiGjzhGj/zO3apoavvz
	y7IovG1jD2xcIvf1FDfPiawL92njcGEH0jny0RRr9/QoULqGqhgJZbMdzjepeEBmHlx9SKRilgm
	6t74EcUQUwL9+bGabl9q4rRW2QY2YFI17Gy7n1lgModJFLqgZ+SHbtvwTnMunTO+Q++r0zkxTee
	n0YIfXYuL/ZIwJDjpHMK82CDe629Q495brsy/3Qm35FfbNgr/yhR5/mW5FqLJM1KJz628R8T3ps
	URgSyE8Zv3EFMtV+dwz4lVCrXk02oETRTnwTsKRQ==
X-Received: by 2002:a05:6830:8d0:b0:7d9:9310:5e87 with SMTP id 46e09a7af769-7d9faef33fbmr6697854a34.23.1774890014530;
        Mon, 30 Mar 2026 10:00:14 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a819880sm6222410a34.22.2026.03.30.10.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:00:13 -0700 (PDT)
Message-Id: <fd14ccafc494aeda4bb9d05b83ac09f35bec8b52.1774890003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 17:00:03 +0000
Subject: [PATCH v4 6/6] xdiff/xdl_cleanup_records: simplify INVESTIGATE
 handling for clarity
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Make it clear that INVESTIGATE is turned into KEEP or DISCARD based on
the result of xdl_clean_mmatch() which reduces actionX[i] into a
boolean value.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 471d9567c9..1f2e8c6b4b 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -329,24 +329,38 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 */
 	xdf1->nreff = 0;
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
-		if (action1[i] == KEEP ||
-		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
+		if (action1[i] == INVESTIGATE) {
+			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
+				action1[i] = KEEP;
+			else
+				action1[i] = DISCARD;
+		}
+
+		if (action1[i] == KEEP) {
 			xdf1->reference_index[xdf1->nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
+			/* changed[i] remains false */
+		} else if (action1[i] == DISCARD)
 			xdf1->changed[i] = true;
-			/* i.e. discard */
+		else
+			BUG("Illegal state for action1[i]");
 	}
 
 	xdf2->nreff = 0;
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
-		if (action2[i] == KEEP ||
-		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
+		if (action2[i] == INVESTIGATE) {
+			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
+				action2[i] = KEEP;
+			else
+				action2[i] = DISCARD;
+		}
+
+		if (action2[i] == KEEP) {
 			xdf2->reference_index[xdf2->nreff++] = i;
-			/* changed[i] remains false, i.e. keep */
-		} else
+			/* changed[i] remains false */
+		} else if (action2[i] == DISCARD)
 			xdf2->changed[i] = true;
-			/* i.e. discard */
+		else
+			BUG("Illegal state for action2[i]");
 	}
 
 cleanup:
-- 
gitgitgadget
