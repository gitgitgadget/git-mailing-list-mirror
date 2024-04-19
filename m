Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273A8F62
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504163; cv=none; b=tAIWE2aRX8qKasFfR5DME1EmOjYGu5sg6POx6xoORCgvsVfLsr02wxBq4kUpAMIQLSoh/WZ6qEMVBZm+3mGzt6VZlAPvK2it6fDJetiWZol5NsLz5s+8Rc2vQGoSHq8w5O3o+sxAKWEaiIfYMYjjl74PK+3T4xPRENJgHRb5G+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504163; c=relaxed/simple;
	bh=9kAoMDOFAxLoPOZrzD7YL4t/gUJSopvjOz6CeQeZXkI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bjm8B8w3Gv74BDmdLpMy8C08n6iWs4OWkd/IHQU8yK08SByF8BGorpabR2C19NedoCyO0tAOIy40ksTgEptE7Xxzt6fImRUox3PZZG47aoByvpuMT/M2NXJaN+zpHxmE5wUTC/c+9k+jLUg4sgR+a5a4QHZ4DRC0aT3vuVPbnoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvzXPFSQ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvzXPFSQ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56fffd131a8so848559a12.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713504160; x=1714108960; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOGKGuTkdwRSPqSSaqCCsiOdFMxgqW/ZfvgOAqeO+ic=;
        b=EvzXPFSQYfz9Uu/EaAtkqOpPFyoJAjFDRCB6m79Z4aoyw6Ot+wGTbJm6IuELW+7FG+
         YvzQEnBrrHZOU2N3wMxtCbDT+ImB8TZlnHqXSsYGtE6m3v7BZtV3zYWFqBjWlW0ByksK
         UvhD9W5bxO916Gz2fYVMXItWPhwN+kx1LpuW5Ada6HrZGF0lnHpEio0/IuxGEM/YxGiA
         Y7WBaB0RfVdOfOMvS9nJNPuzMUFk2LADslVhX0xQ2wqT0k5YyMGoZ/7nD3vIXmKUKYoZ
         Lvfn1zCRkVuPbGehMHNm9KZ/Vif9iR7lH+7YMwgFNTviUYRbrQ5/QWJcVW8f68gsoiPJ
         VcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713504160; x=1714108960;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOGKGuTkdwRSPqSSaqCCsiOdFMxgqW/ZfvgOAqeO+ic=;
        b=B+G64yxWTd71SJs7M/0x0zmYXZgIwFOe+2Ce5bhijhJg3R+mCcc/0AU4ZL6YZZ7JVS
         HCs3V9x0pFyb/kaulOIG6Cl6hNNvtskZHBjVrGjaglodZppR6UZ2UYecRFBZm8+tMGcb
         zAUYXo6EDUzSXRpxdOnEncXr2bB0yXljsIMFtJqgu7Lh8RK2K5l5CxqhsUMDwQO3K+sO
         6g7xXR5XcH6sGev8CCrE5EIsqsJqQ11Colz/FntvugOQ/0SkIRYBIFkupsDTsWX5ghtv
         kWrwQ7W1ZSG5Fj8beqOh+Goh6D08BGQY5A0zXMn6jxp+Zgxmla1i5u9FE7x46bK9+q4c
         aGSQ==
X-Gm-Message-State: AOJu0YzZChgm3f+Vdq2+MxPllKIuo/c+YATAdcjgLjRIL4A1rR199j26
	3kBECmmTZHJv8/T6g+fqf4deZYkqYNQGLYSKZW51wmQSIzE0wVNY1oQsBQ==
X-Google-Smtp-Source: AGHT+IFH6FxUVWmm3EXgFrWEXIatmqhTzEkCy2AWjjkq0Trq603oHj/f3UC+SwXc5ABJ5ig7Rdy2lg==
X-Received: by 2002:a50:cd1d:0:b0:56e:d54:6d63 with SMTP id z29-20020a50cd1d000000b0056e0d546d63mr777158edi.15.1713504160034;
        Thu, 18 Apr 2024 22:22:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12-20020aa7c54c000000b0057025ea16f2sm1670260edr.39.2024.04.18.22.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 22:22:39 -0700 (PDT)
Message-Id: <84897cf5c83eb67c023603016b49fb7b56870aa3.1713504153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Apr 2024 05:22:29 +0000
Subject: [PATCH v2 4/8] sequencer: use the trailer iterator
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Instead of calling "trailer_info_get()", which is a low-level function
in the trailers implementation (trailer.c), call
trailer_iterator_advance(), which was specifically designed for public
consumption in f0939a0eb1 (trailer: add interface for iterating over
commit trailers, 2020-09-27).

Avoiding "trailer_info_get()" means we don't have to worry about options
like "no_divider" (relevant for parsing trailers). We also don't have to
check for things like "info.trailer_start == info.trailer_end" to see
whether there were any trailers (instead we can just check to see
whether the iterator advanced at all).

Note how we have to use "iter.raw" in order to get the same behavior as
before when we iterated over the unparsed string array (char **trailers)
in trailer_info.

Signed-off-by: Linus Arver <linusa@google.com>
---
 sequencer.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ea1441e6174..4c1f6c675e7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -319,35 +319,32 @@ static const char *get_todo_path(const struct replay_opts *opts)
 static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	size_t ignore_footer)
 {
-	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-	struct trailer_info info;
-	size_t i;
+	struct trailer_iterator iter;
+	size_t i = 0;
 	int found_sob = 0, found_sob_last = 0;
 	char saved_char;
 
-	opts.no_divider = 1;
-
 	if (ignore_footer) {
 		saved_char = sb->buf[sb->len - ignore_footer];
 		sb->buf[sb->len - ignore_footer] = '\0';
 	}
 
-	trailer_info_get(&opts, sb->buf, &info);
+	trailer_iterator_init(&iter, sb->buf);
 
 	if (ignore_footer)
 		sb->buf[sb->len - ignore_footer] = saved_char;
 
-	if (info.trailer_block_start == info.trailer_block_end)
-		return 0;
+	while (trailer_iterator_advance(&iter)) {
+		i++;
+		if (sob && !strncmp(iter.raw, sob->buf, sob->len))
+			found_sob = i;
+	}
+	trailer_iterator_release(&iter);
 
-	for (i = 0; i < info.trailer_nr; i++)
-		if (sob && !strncmp(info.trailers[i], sob->buf, sob->len)) {
-			found_sob = 1;
-			if (i == info.trailer_nr - 1)
-				found_sob_last = 1;
-		}
+	if (!i)
+		return 0;
 
-	trailer_info_release(&info);
+	found_sob_last = (int)i == found_sob;
 
 	if (found_sob_last)
 		return 3;
-- 
gitgitgadget

