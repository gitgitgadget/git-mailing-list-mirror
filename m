Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29D745DE
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196355; cv=none; b=a+zI246Mc+5Jgj3RET9B3p5sp8YzxzxJ0HzcwTo8ztfKStQO6yH8K+UKGIpJ422v+VBhsHALRSWbVTqAP0LrmgYvJxq1214h4QCZbK1zijpQv398QHENM5KmVweaC81q6hc4ST0hywLUCRcSYLljgAyLXDaaIobsLtQ/6FSyI80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196355; c=relaxed/simple;
	bh=VtcouaHw6ztbGb3EWtk4zEbxwTZdAZDIvLKHObqns28=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VMldLPmth0emoBiHAOOMuXnaH1qjEePNJFDz0bHxklCobqMm9eoPdYSkVHf1M507yRgiTr8duvR11H9UGrKy7uZXBWXeo8+Srxfqo8ruFC6it6qGBaf/gf1btSh8sdumiYx3aDvnkpq2K0AVHqLl/3NPpRepOOl7VLZ6Tr5+ahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meQJ7EEF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meQJ7EEF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fe00cb134so5696975e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196351; x=1707801151; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNGSXY0lACUj57g92wZ8kTjwAhEGXfhsU6tUIWHtlMI=;
        b=meQJ7EEFtzOhHnRGiZWxKElLxtAwMX6WQ0zMTPNPhWWqPrAmhQ7L/ZvVAXYzHVFuTP
         6c/O/fsWwcWEes/y9FrxPYBq8J5wpnkbl47ttCk+B1EEAtS0FqjzFFvwYl8y3uV0ucNz
         rnD8wDVCuL+YM+9xe1WXDcvXsctkNOtS/6E28nAliWms12ijXY9HCVbfx1QJaDQ96dzk
         faypP7YE8nDzof3ZbmYJEsHtXlXE5Emab8+19U/yDtzjYfROvbqJzIPmqHLpip/gxn44
         SpAhDHBVVbLzvel55+DANcAGozV8k0hmD2HQ5UBB+LsBERyqNfjcGNqw1Q3+19yo3c33
         2HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196351; x=1707801151;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNGSXY0lACUj57g92wZ8kTjwAhEGXfhsU6tUIWHtlMI=;
        b=BueVCH7PVMK9T6asbOs2mwpBpTJyCBedWjP+gYqqXsvRxM+v6AffyJqqXvhJTwHje4
         SK8IPGUJiyYp9yYqIPv4/1Pkc8pPMmYR7hZXtSBaFbdqQM/oj8yQmjl6bgQCjcVFbUgl
         siDANADW2DziFDODgbw9kOYXngMYLKIakFQ5DPbbfCpUwkTdCiahNOhTVjThElkLIImB
         PQ0Pgjc/1kM9NWYNYUSXeLmcHALOWo8Tw2Gfv1GHyKeg0/aB/518wWH2y4KNAGlTPpJQ
         1wP4MPQtld623OKrfYsRdPcU+1B78IMkD9vzJoqBOGnbH4taRDzsNj6LIECpjNG/lTXY
         eHTg==
X-Gm-Message-State: AOJu0YyGXiOj2cJ5ZxIJoNyUR860j3YOMXEubC4VP4W7rbaQ8yXnGogX
	NVCZDlaLVoTVaiBifuWMI6n5RiWnIsQUjlQUtTFKBZsPs+Rc2z431kOFipWV
X-Google-Smtp-Source: AGHT+IGGvMFx0mNqw2qWcBMs7XO1/kvFFaGPjJF0tL0a8KNOz2FX1r2JdoOrF2chWZE1LBsLpjwa9w==
X-Received: by 2002:a05:600c:450c:b0:40e:f222:9e52 with SMTP id t12-20020a05600c450c00b0040ef2229e52mr1103662wmo.40.1707196350847;
        Mon, 05 Feb 2024 21:12:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUCk2VGcxpCV4La+E4/wbbMPEKH0FKiwL3HB9mZKwSGN7H8j1wSEuhXnN1LKX3TUdeCuyLh4KGbjG3owjE0TuTO7sU3zyK3kBqzm9fOGCkpIeIPxP3HRcHuXFlXpsysqeLJZqKDjD7d3PHLhunC1yGcOCH46IyiESCZxr+F8HBTB73bWAsXgh5PicIO9qyWV2x0hYWu2yjXZA==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c4f8300b0040fc26183e8sm649606wmq.8.2024.02.05.21.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:30 -0800 (PST)
Message-ID: <652df25f30ecc8227bef5109b0f7b47817386b13.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:01 +0000
Subject: [PATCH v4 01/28] trailer: free trailer_info _after_ all related usage
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

In de7c27a186 (trailer: use offsets for trailer_start/trailer_end,
2023-10-20), we started using trailer block offsets in trailer_info. In
particular, we dropped the use of a separate stack variable "size_t
trailer_end", in favor of accessing the new "trailer_block_end" member
of trailer_info (as "info.trailer_block_end").

At that time, we forgot to also move the

   trailer_info_release(&info);

line to be _after_ this new use of the trailer_info struct. Move it now.

Note that even without this patch, we didn't have leaks or any other
problems because trailer_info_release() only frees memory allocated on
the heap. The "trailer_block_end" member was allocated on the stack back
then (as it is now) so it was still safe to use for all this time.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 3a0710a4583..e1d83390b66 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1111,13 +1111,12 @@ void process_trailers(const char *file,
 	}
 
 	print_all(outfile, &head, opts);
-
 	free_all(&head);
-	trailer_info_release(&info);
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
 		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+	trailer_info_release(&info);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
-- 
gitgitgadget

