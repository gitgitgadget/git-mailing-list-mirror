Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3A2C80
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252100; cv=none; b=B1RJkLoblAsZRsw03JobyHD1OuLDyKy8gWlSnu6VzHG8HwolPQCm+hU605Y9pAw5VgjK9hh/snvE5CcuYTVC2QCCisUq+UPWARXJi17KFTOwCrLQUpXYTAyWszvlbQcz0jai0oUpRyeja7+1NOHUk0e6cV1X5aoF7NaqNA4JpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252100; c=relaxed/simple;
	bh=0wWgk3bHxk1N14jQSztA/JXd4hhftIltaUu5w0KfRpA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CKGse8IV1KZWWn1WV/3ZL3eBdibg8L9cJM0Ccrldu/w5zPG4mL9qVk0BBhkkxfaGE9Vn2FTw4tGM4b8k8zRmrMHdW7iL+nsBKvHFrDvUbVdrbQDz581VBoyOkIXjqkJnxnyns7W/83We2A7rtW9/5Vp4VeoeisuG0KRA5MWWElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bwmgt/K0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwmgt/K0"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5132181d54bso1715549e87.3
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709252096; x=1709856896; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WZY+izhWTibPggTpQvAGRY5I2odNhP80Vhz1ebOC3o=;
        b=Bwmgt/K0Uqn8ezRF+mUdy8jE04LdRhXNabuJYRE/hNTMTVOLai1vI1rXJtQHwPcbXG
         Wf2osB5UZ5QlxV+Ai4lCb8WiBPsGBcvS9kQAACU9S0dIkXvGC6iBVsx7Z0nogeepCdsJ
         wQ1/NmeUutXZLYmGgdAMpoPhCXk9mRE11Zpfyc08EiFno8kAXKu42w5FU57SFS3GBsHL
         52PlJNMxIN5sP5LYZnaaS75Fwdt677PC+116cecw0bFDyrqb1S43+CawdmwQ6gxIMd0v
         BwITd0l5+pMC0RvlrqLbsDPgT2toS08Lx+QMUO6m6rVFlI94znTvmq8n9Gqyd8Dezo3k
         vgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252096; x=1709856896;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WZY+izhWTibPggTpQvAGRY5I2odNhP80Vhz1ebOC3o=;
        b=bK++uYcBxEGwEk0gq03BCoWmMxOs64e1AVvVukTCdyc33KEQXxJ2MNORrSSLlOIkO+
         hzSieMGfViNRC9YutKL8BvTPws0wWxWxMMDDFiC0TB0v8RLlTpv3c4hTXQmVm3WGNidA
         FsIGXAdr3gPrGjUMrz5PFB5h+KUkDSTwVcsd5iAHuqAbXpsDHkL4KsCIvsBJf+dT6WaM
         ak+C/LcnJoKeQEW3KZBbUe5TX2jVpiYjb0vwDz/S2tB+Ll694NV9gdYG4iy7cPR62Qyn
         qv2PZYNOqAvxCNGwUt6/UAsx9cTvIISkqZHhWlI3iCN3/fQXf1r2MKVBEFDalGmGNVsk
         jePQ==
X-Gm-Message-State: AOJu0YyS7EWAn6oj2x+f3nSWYyMHAGZE21uL4ZGzSwiy8rTG/0A9xt9u
	h1nxjPGXy01xFgo8nu16cwTx2GjTUXos0NtXqrIiAqnGKFvMqOkeydoiZumb
X-Google-Smtp-Source: AGHT+IFuXHumsuzh2Hlgut6PcdJCNYxmv1Ky2Q8azbTEDWMqD4UHCoD+64M/ZhoVsCtHI+UD6LgoOg==
X-Received: by 2002:a05:6512:28f:b0:512:e506:1c66 with SMTP id j15-20020a056512028f00b00512e5061c66mr71996lfp.26.1709252096426;
        Thu, 29 Feb 2024 16:14:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19-20020a7bc453000000b0041292306f2csm6544676wmi.16.2024.02.29.16.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:14:55 -0800 (PST)
Message-ID: <0e884d870c892ef562098e04ebabd38bffca7eb3.1709252086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 Mar 2024 00:14:46 +0000
Subject: [PATCH v6 9/9] format_trailers_from_commit(): indirectly call
 trailer_info_get()
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

This is another preparatory refactor to unify the trailer formatters.

For background, note that the "trailers" string array is the
`char **trailers` member in `struct trailer_info` and that the
trailer_item objects are the elements of the `struct list_head *head`
linked list.

Currently trailer_info_get() only populates `char **trailers`. And
parse_trailers() first calls trailer_info_get() so that it can use the
`char **trailers` to populate a list of `struct trailer_item` objects

Instead of calling trailer_info_get() directly from
format_trailers_from_commit(), make it call parse_trailers() instead
because parse_trailers() already calls trailer_info_get().

This change is a NOP because format_trailer_info() (which
format_trailers_from_commit() wraps around) only looks at the "trailers"
string array, not the trailer_item objects which parse_trailers()
populates. For now we do need to create a dummy

    LIST_HEAD(trailer_objects);

because parse_trailers() expects it in its signature.

In a future patch, we'll change format_trailer_info() to use the parsed
trailer_item objects (trailer_objects) instead of the `char **trailers`
array.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/trailer.c b/trailer.c
index e92d0154d90..798388cbf29 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1140,9 +1140,11 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 				 const char *msg,
 				 struct strbuf *out)
 {
+	LIST_HEAD(trailer_objects);
 	struct trailer_info info;
 
-	trailer_info_get(opts, msg, &info);
+	parse_trailers(opts, &info, msg, &trailer_objects);
+
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
@@ -1152,6 +1154,7 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 	} else
 		format_trailer_info(opts, &info, out);
 
+	free_trailers(&trailer_objects);
 	trailer_info_release(&info);
 }
 
-- 
gitgitgadget
