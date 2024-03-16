Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20177CA62
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710570435; cv=none; b=P0U8W1EvHkr7mzi2MU366uOsURpPp38S/Px0mTCESeSJlKf3ABASiTuHCIOpldKBDC+2IXMdDhdEMg0degvJD5Bt50C1yA7BYKTUbQWMhDZcCg5wNjzJ5eQ7WtjiChJN6dRF9KLsU9d1o1WKS1Xx83TSkPesUXFGvSi8WxwBAIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710570435; c=relaxed/simple;
	bh=9kAoMDOFAxLoPOZrzD7YL4t/gUJSopvjOz6CeQeZXkI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qplAnmS80Uhlr8+OJ3u9ixxiBl7yuhxQ53oo01CcvpPq0xQkhDB8AOjPiP0h3Kt381Tg5cfzg+OQlMdK93ZiWMWePOducZ4gfLrRPrtUNl9msO9JwyKVx+8U4pFsjDOy9IHJEu0dzM3CNKzkU7tQ4HWDa4me+qQibM9+K006qyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzX38lqK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzX38lqK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41400332550so13924335e9.1
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710570432; x=1711175232; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOGKGuTkdwRSPqSSaqCCsiOdFMxgqW/ZfvgOAqeO+ic=;
        b=RzX38lqKJKjlTVxWwYdYFckkiFACuI0EDG082B7JbvSt78W0fWHKHcdoNp3qIHOrYK
         2Iemn2PTyLVP9cAHYTOEPWKWXRJD3eD2bEzb5CQ92V+wY1d2WWZ0pmLC+g8vwLHb0eev
         jjUcOsjQVx/f22IRgQvW3OH8tFsfKbOEzGhm+y8jRQkQ5vDJrAYyvDiME1+PNzdWYZhq
         HJhvi9Dvx/saFK5eW5dswwb5mCjxDlE8Fog+YaM4f13DF14oQNEgAu2gGhoYyU4ktdt8
         NKfNqsIn57Zoms6tUnvXimgPEHKyi5n1aEjYKdehotEiSsURfH6+2Hcv1FpEZzl/sTP4
         11Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710570432; x=1711175232;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOGKGuTkdwRSPqSSaqCCsiOdFMxgqW/ZfvgOAqeO+ic=;
        b=jXN/Fcb/ch6iwi/hz+gaM9vhWszjKKQdW2CepVlZPaw7cBGmNCs/W1nzgeZWnF/yAR
         NNg+/zVQnf+SEENav2EPYJuviMFWis4Z9AKuMt5XubNG28+bhdeM7kqINTjpeTLXPjZE
         KKffhZSGmtQl9gUhgCEt86NlXxMlusARxVI1B0tROc0PpbggG+pbx7BH2b88U33RXUvb
         Sk7MrgOWKXn/vLlp0lerckFzqq9QKAzwLZP8JHSUPXSSigAjH+sPSKtyDjG786pyXQ4h
         maSy4lJxrFPbHSgkMnX/CdllsamTzUIcNgjRNKMYYoAYz3cL6/UCsfHcDr9yb13/eNrS
         cVAg==
X-Gm-Message-State: AOJu0Ywj93H+WvzruFbVPZPyYkkkLObWRJ0/Sa8k4rCt/N1UrFR9YlnI
	ckKr2WP5RTLVIz/YUUWp5fMNyY+tWHo7/2MiHub8BUAxNXTcSOS499JhsK/Z
X-Google-Smtp-Source: AGHT+IE7s0vBQVoDpZuYpOEXOWelVX4dPXBdAY9Pgs4Z/xiBRG6v7VklU50+mepePPsuR7w/+9FMIA==
X-Received: by 2002:a5d:6683:0:b0:33e:c56f:b5e7 with SMTP id l3-20020a5d6683000000b0033ec56fb5e7mr751835wru.31.1710570431630;
        Fri, 15 Mar 2024 23:27:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh21-20020a05600c3d1500b004140924b256sm163451wmb.48.2024.03.15.23.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 23:27:10 -0700 (PDT)
Message-ID: <dc873c3b82093a6411e34369fc516242f1bb0d6c.1710570428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 06:27:04 +0000
Subject: [PATCH 2/6] sequencer: use the trailer iterator
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

