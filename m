Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12903FBB69
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590175; cv=none; b=D/E3+77Ct49OEP344VPemIwb1EXI2WBDKphrzoZ6QMBqCZd1VqsX4xxXARYnk27pSa1tfI6FimV7OGduGNeT/n+c/PQTk2GSSJ5S6EjNRCWa+ybfD5iImVW10WZTM2GUP9E4KEIeo07/m/bQK0mqYUd1Z/mcg1rjetpqhmVcabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590175; c=relaxed/simple;
	bh=N+wscwtNjzPeNf2KN4DyWZKYBTkgtAN68z3GP4090iY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PhlqegK+L4MNimTMQi/g0/gNQ7Iap4OCfW4QwUHbgUwRX+HVc9lmeNH9n0M37HxDD+0vuhxc3wRFCG2dFim10+ekUSGyNWnbcGSKWZ9PqQNWV6H8Xokf/HeW3MC1rKywBGcMU/wc1ATuqIEmXL22Zd6kh3VUh90V8P4iZpkpjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnNtbwaJ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnNtbwaJ"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8edda5d56a5so15122696d6.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590173; x=1784194973; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bGgD2GV2OjZiTVIn7M79yAEK4kBNMn3417ew6ks9gNM=;
        b=WnNtbwaJUuUNMhNrG8mljSq9UoyrodTlpj6isGa/3rr8oX02c7y9Tl20+EFmOBd6Ge
         9mLnPzek3ZAJVouotmo5D1Huu+7Ya3jYEUoe54kt9M52cFUMiP0FmWvEyjNzCpcVlZtn
         K0EFmLA88X4tS+SJWVbDiETbE7JhhD5EFsBZzndnxA5j7NCCJfc9lyslphOE1dIv3H9o
         lVEXbFOYpRt4zQB097BUnZ5xPpa4tzmwpIjt2JgDoEtewf3s6CwJJsbaR5cvgcEaXBEw
         L+6OqvFT27VsT4+qg7i8ydJg7x8c1uABDTVwzvpIh500kRzQcxgHgroMSCWDnP8zdDsy
         isXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590173; x=1784194973;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bGgD2GV2OjZiTVIn7M79yAEK4kBNMn3417ew6ks9gNM=;
        b=LFIbxmRhXjr+ISWDXjhyrwuLRjkK0u40esmXRZS2NqVCqbyHH38kFPKZqfRauGQo7+
         SYC4OJEUQdpC02vt4rICzli3T4eGZ8I4WIeQZ9QjAHtNpCMfcXKXU1mOIYmnD6KOnYIw
         pQX14yS0wgXEa1gv0s7EGakOpSyxToc0rWCw5DXqeA4arF7sZLxhn5wGR8R0q78MBjo5
         cGjUCKXdxjlKfmNjeHan+5oXJwJEGmq2QT2kSpUcuYjq/zyXcunTh4cwPZl4cMP4cWvN
         AZH7QzEmFsCyOiSqbzS9aQ4393NzbcwPWIqfJepeYPxpoRjJSF8bY/npXQhcLccifLEO
         8c+Q==
X-Gm-Message-State: AOJu0YxCib26GVcszDqfOnud1NMn5CDP6285LleZNOVDg4zrTAOZmeMr
	fPi/ObP03Gf/ObQrQZYzosHxCutb5NX+SifGpL3urzq6uBGVMja209cSzCSkGPxr
X-Gm-Gg: AfdE7ckQFlznwxkocxVdYCVjY1qxzHfOmj0udpjzwo8tkQT/lUaWbiygqAfBLpEa4+b
	diKzkoNNgtWBAdzPoYzSZ3Xm3ZqxGKO3jd9fN45Rz3DzWWgm9Td24LqO36fdQQZ0WmhT9jIgezA
	Q2piPq8MOKIfZxa6lvn0tg4KrC8DZ41QEhu5yooxWdmr+4wdbW9boHdssaCkl1jyP9pByxqAJ7+
	/v7NeDc3uH0VLdKoC9ptJbia/iD1ZN0UR2uAHmzUCCiy62Q3JohPvkVSJPSilmTAf6d52OHfKvR
	fY/QlsQRCwVfOdsrJ8A+cAzHcUJrQvO7hp64hitXR5+SVPIfOoTCGOCj2qotDlAlr7i1R02dJuw
	1wkrN9S4oNMy4wLR1vyYv8v5Vf0yTMn4qZ1G15GKZ28HDNFIe1XKBHfXl6GlnJkdUizA+W7DNfb
	+8Pq2RHamT1E8x1bQG+nl/Y00=
X-Received: by 2002:a05:6214:2521:b0:8e9:f5de:d611 with SMTP id 6a1803df08f44-8fec37187a9mr67691116d6.48.1783590172767;
        Thu, 09 Jul 2026 02:42:52 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87cad3csm13389676d6.48.2026.07.09.02.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:52 -0700 (PDT)
Message-Id: <428a3a006bbcb165a96495bbc2c5fc04e5b15db4.1783590159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:37 +0000
Subject: [PATCH 10/11] bisect: ensure non-NULL `head` before using it
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `refs_resolve_ref_unsafe()` is called to resolve HEAD, and returns
NULL (e.g., HEAD does not exist as a proper ref), the code falls back to
`repo_get_oid("HEAD")` to try to resolve the OID directly. If that
succeeds, execution continues with `head` still set to NULL.

Later, that variable is passed to `repo_get_oid()` and `starts_with()`,
both of which would dereference the NULL pointer.

The scenario "`refs_resolve_ref_unsafe()` returns NULL but
`repo_get_oid()` succeeds" can happen when HEAD is a detached bare OID
that the ref backend cannot resolve symbolically (a potential edge case
with the reftable backend) but the OID itself is valid. In this case,
the bisect-start file does not yet exist (this is a fresh "git bisect
start"), so the else branch is taken with the NULL `head`.

Simply assign "HEAD" to `head` as a fallback to address this.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 6ff600c856..a69771c6d3 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -811,9 +811,11 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	 */
 	head = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 				       "HEAD", 0, &head_oid, &flags);
-	if (!head)
+	if (!head) {
 		if (repo_get_oid(the_repository, "HEAD", &head_oid))
 			return error(_("bad HEAD - I need a HEAD"));
+		head = "HEAD";
+	}
 
 	/*
 	 * Check if we are bisecting
-- 
gitgitgadget

