Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64271D30B
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658310; cv=none; b=WK/jBOI8m/z7QaOCer03sERFo/gLKsnxTcxMbyeoIjeABBA9NY8I4nRZFkUXGsDva6V4MJeQrtQGhbNCUqovYe48crKqmcc26Tr7f5APNhtMj9yJh3uDPMwfFdrQepMQmI4s0onRjEILOW4TtHYnjAFvk6A5KLiLh5rms1mw0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658310; c=relaxed/simple;
	bh=yUFjxGXoa9Iu5ABIv8e5hSygDvEud2XumKI6i0VwrCo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uhyBGTNMJOddcSMtSRhaBBPx0bEg+Je6klzO3Yf9c9Xwfl9+dYTDA8PUoki3Xu7KHiB3CRJDEGWbHGEQVS60W/m6QmaWmxFMCZG4glHZePxGFhBRmHDJ7LLLQF/hPKTHhKidHnxQANHB1XdDW8z/lU4h8AxXSd90WJ/SzofUkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFJgqlBM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFJgqlBM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41282f05409so3100425e9.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658307; x=1709263107; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj66rkJA3Q9yHv6pTHD9ZT5In/BWmtsX624blZGveos=;
        b=kFJgqlBMQf0NI1bUoyLulPcFZJcjqaiy73W/cMF7AkEmo1fTA9FJ2JBRzRf4a+A1OP
         eb19Jh0T7JSdKrRReBvR65Fy0IMzwnNV2SJU8Y7r5B41H7fH7w0Sq0N7I5xdz3icXLSf
         PS5y8xYlXsaMjwgmYrmuZItloMUeQh4XD5MncWf7P+b2q9vGpAin2g1WFydVn1DfMQlT
         uIeuhbMmy3AEwXe89twuKo69F0rwUy/p1uWyoogH2TDivfhjd1h7k6n22ZwTVN0zb3TB
         JOUrBIns8S6hBvHSnsxa8d2HMf4QhbP3Pr7xnAjxkmXyATnULqymVb/zxnQEOEMbPCqC
         ceCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658307; x=1709263107;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tj66rkJA3Q9yHv6pTHD9ZT5In/BWmtsX624blZGveos=;
        b=dNZEHW9fLvBVWdjevnRMa+qOi/+KsEey8Hcplxe5zniAFQxKu6JTrbjgpTw5hSMpvl
         UjFgtqh1KEZTFl9rqgyYHN8HckUgPF5w9bznPYr0uNgKWXmdH7hKR3szahlhC9HJVY70
         qzGVCLFnlKeO95GYIKrC0NM9cKEmYpCrHrRRc/m4Fp4N8uUpXf2VNuflssXbSqt+KqZS
         GmHpQoqHvomkKPjWJRtBYNEWhaLfaobE6ju7nflT411O3S83flgOhbh5jYmDl+wV94b6
         ArR+cLSTCp2oet9hNcmcGRTsbdpfSehZWe2phiTFe8ar1WVK60vxq6Gnd3TLBrC4Ddcd
         N+eA==
X-Gm-Message-State: AOJu0Yz4pJwQ0BWoGw+Sb7lAOuZUcbeeggG0pdoJod5j/0HeDnBfrfU1
	kGkOQoXoBr8LZbnoW8EdWFFHHKoSk+3TxcoZxOnZg9bDGJbp8Ukuoa2hh+fQ
X-Google-Smtp-Source: AGHT+IHmxLlcdbopOE1Q5lT3YWrQz/yDq1/8WqbsEd4mKMk5hYzflfYsZmHhtVQWc3Xd39nrjbiOKQ==
X-Received: by 2002:a05:600c:1f86:b0:412:9008:b252 with SMTP id je6-20020a05600c1f8600b004129008b252mr273440wmb.40.1708658307435;
        Thu, 22 Feb 2024 19:18:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b004120537210esm573743wmf.46.2024.02.22.19.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:27 -0800 (PST)
Message-ID: <c04fd4eae941e234f4c7364bf035501a8e244db5.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:09 +0000
Subject: [PATCH v2 05/16] fsmonitor: clarify handling of directory events in
 callback helper
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Improve documentation of the refresh callback helper function
used for directory FSEvents.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 6fecae9aeb2..29cce32d81c 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -183,24 +183,35 @@ static int query_fsmonitor_hook(struct repository *r,
 	return result;
 }
 
+/*
+ * The daemon can decorate directory events, such as a move or rename,
+ * by adding a trailing slash to the observed name.  Use this to
+ * explicitly invalidate the entire cone under that directory.
+ *
+ * The daemon can only reliably do that if the OS FSEvent contains
+ * sufficient information in the event.
+ *
+ * macOS FSEvents have enough information.
+ *
+ * Other platforms may or may not be able to do it (and it might
+ * depend on the type of event (for example, a daemon could lstat() an
+ * observed pathname after a rename, but not after a delete)).
+ *
+ * If we find an exact match in the index for a path with a trailing
+ * slash, it means that we matched a sparse-index directory in a
+ * cone-mode sparse-checkout (since that's the only time we have
+ * directories in the index).  We should never see this in practice
+ * (because sparse directories should not be present and therefore
+ * not generating FS events).  Either way, we can treat them in the
+ * same way and just invalidate the cache-entry and the untracked
+ * cache (and in this case, the forward cache-entry scan won't find
+ * anything and it doesn't hurt to let it run).
+ */
 static void handle_path_with_trailing_slash(
 	struct index_state *istate, const char *name, int pos)
 {
 	int i;
 
-	/*
-	 * The daemon can decorate directory events, such as
-	 * moves or renames, with a trailing slash if the OS
-	 * FS Event contains sufficient information, such as
-	 * MacOS.
-	 *
-	 * Use this to invalidate the entire cone under that
-	 * directory.
-	 *
-	 * We do not expect an exact match because the index
-	 * does not normally contain directory entries, so we
-	 * start at the insertion point and scan.
-	 */
 	if (pos < 0)
 		pos = -pos - 1;
 
-- 
gitgitgadget

