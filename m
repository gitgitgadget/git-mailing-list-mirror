Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF6149006
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124963; cv=none; b=BTQUgU6O3iAkQ4iFQHRfUwULKun7qipmNCM7QvHshteM86H4pAvWG0tpowNVBT9DZUsQutp0Plbj9ycpjDiHiHekf3Xrcbk2uir55G/bVGZAB4vUhPkaInW1Vbu4U2o/IecDoPwrlACe+GFKTQMTtGvFqBW65gARDxkq8d0P7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124963; c=relaxed/simple;
	bh=8zW5s9dVw12pr9fbZJS4z8TlV+Q1EwM2vdLxdUNtO1o=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NA6jCzdzZjRyz9jLGnylxG/Q8AbhpieFMuAT9wCNyqS+Q8YvD2lNNsYyYfGb3apW86+h/66VQWEfarYA8j3+nG+Kwlme05ziZVKPgkTPAb9bF9JwHza/wI+xo9WwBhGJSN4pj5nmnFKd2BV4yXRLiMWDz+qq0AKgFLKNJjIIEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOi0k5rF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOi0k5rF"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41258904302so1019225e9.3
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 15:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708124959; x=1708729759; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVmCHXSxcIJ8BC25Gubr/EV2nNjiB4Aj4jeRQHFX7BQ=;
        b=hOi0k5rFc5TupScZlaEyWajM2KmJWSIZYB5lIxUrC70t3dpj2X0j5LuiVvY2Za6myS
         QZ4s5HUBgKIXGPMJYzX0Howb93rxawOMihQYBLE9zHZRqIm2Eg9p4CllY0MrPYyCRBu6
         f5xGQZW1VMKj2XCS9/Tu5dM5RLbFjEjwLeEE2qhQ55xroSLfjiCUWg5C/F5mM6rd2Pyu
         sAo6koz84AOca/GHjxX7ORlGRNmvJVEwoMlDXfXrG7mO01iy/gTHBLF3TIj+xxHNmmkZ
         trsgQcgDMQJ9IEGJlS/iZ7W/tU9KjaLPQRuaQVjomhrVytzGEK4TfeSpBdaP8gP3X589
         fppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124959; x=1708729759;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVmCHXSxcIJ8BC25Gubr/EV2nNjiB4Aj4jeRQHFX7BQ=;
        b=QUf6XdYCJOoBKP9nChBeXL6tB0aQOAOuR12C7EvqSQGba3ghl2vRblPImoYCtP9Fqm
         RmjjEJQgh3GX5OOfaPnoCzzM391gk5G+5z6m5HS2ZYNKyn9uYvlXwEeVs01vPw6446qY
         OcAeU6Vh5pHj0LHgGA6vrvhf0KENOBU7lB5Rt6jG2Iivuzeaka4L1Whjo4mnxqnNJ/x+
         ZFq+I0+s4G9h9uZ7KOZFwhGNFuioj+O69hNkan8aPhQfO6D90zg8K1OftxTapGtstEJp
         TkLz8d1y6w2R/r+BpV6Q5AJtrrX5bNoDiKbu7xuPte5/PmfFZyX/h+glCNSBeOWR4mRf
         8rxg==
X-Gm-Message-State: AOJu0YyNC/AQYitFWTXwA7xiNgoOXwOiXVoxS7feP9v1nkKuDKWUfTvb
	b7hzmSaI+4xRmWtxv4s3D8gb2OJ/HBPDG9S00xM4enmXqndBlbOXrr5r03Dt
X-Google-Smtp-Source: AGHT+IE6OLmQHR8vjMsueb9U5o5ZWVTrU+w/QdYP0RC4Tp6N7kwLGuh+ixSELdpdJufZxzt2OOrznA==
X-Received: by 2002:a05:600c:1c1e:b0:412:1615:7343 with SMTP id j30-20020a05600c1c1e00b0041216157343mr5042285wms.5.1708124959367;
        Fri, 16 Feb 2024 15:09:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3-20020a056000004300b0033b79d385f6sm3311559wrx.47.2024.02.16.15.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:09:18 -0800 (PST)
Message-ID: <b97c06d8bc324139710b6fb8c7765326f2a2bd2c.1708124951.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Feb 2024 23:09:09 +0000
Subject: [PATCH v5 8/9] format_trailer_info(): move "fast path" to caller
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

This allows us to drop the "msg" parameter from format_trailer_info(),
so that it take 3 parameters, similar to format_trailers() which also
takes 3 parameters:

    void format_trailers(const struct process_trailer_options *opts,
                         struct list_head *trailers,
                         struct strbuf *out)

The short-term goal is to make format_trailer_info() be smart enough to
deprecate format_trailers(). And then ultimately we will rename
format_trailer_info() to format_trailers().

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/trailer.c b/trailer.c
index cbd643cd1fe..e92d0154d90 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1087,21 +1087,11 @@ void trailer_info_release(struct trailer_info *info)
 
 static void format_trailer_info(const struct process_trailer_options *opts,
 				const struct trailer_info *info,
-				const char *msg,
 				struct strbuf *out)
 {
 	size_t origlen = out->len;
 	size_t i;
 
-	/* If we want the whole block untouched, we can take the fast path. */
-	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
-	    !opts->separator && !opts->key_only && !opts->value_only &&
-	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info->trailer_block_start,
-			   info->trailer_block_end - info->trailer_block_start);
-		return;
-	}
-
 	for (i = 0; i < info->trailer_nr; i++) {
 		char *trailer = info->trailers[i];
 		ssize_t separator_pos = find_separator(trailer, separators);
@@ -1153,7 +1143,15 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 	struct trailer_info info;
 
 	trailer_info_get(opts, msg, &info);
-	format_trailer_info(opts, &info, msg, out);
+	/* If we want the whole block untouched, we can take the fast path. */
+	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
+	    !opts->separator && !opts->key_only && !opts->value_only &&
+	    !opts->key_value_separator) {
+		strbuf_add(out, msg + info.trailer_block_start,
+			   info.trailer_block_end - info.trailer_block_start);
+	} else
+		format_trailer_info(opts, &info, out);
+
 	trailer_info_release(&info);
 }
 
-- 
gitgitgadget

