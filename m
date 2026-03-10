Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6D43CEE1
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132689; cv=none; b=I2Kj7Gd5W4uXD0tVYI3TlIrO2sikZ5gEhs/b/x5aGQZvv841g3R1ChQvQs1/w8Cb7Lfmj0xrSuadiA2/jKEIlFgx96lHdd53+PYt4NG2XIPmyk414AP8keMjDxhMEAXJkz1lHv9byRS8A7MiEycMTVwsc7tQoVyk4W+gpJFkpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132689; c=relaxed/simple;
	bh=xfa21io2+FJbIrGAwXxiPIakRUsqCfiFQKX19SKlk6I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R1pgjHOweNCi9ib2sHs8huZ6Z/npGmAlkbKQySlW70WbAMeoe6fx7gtczK7RuKqAZuWD9VhqNr3lPSm9KDYdsZFCZm4AJBWww5MYB/66CZWL8SXiT/F1ExHKD3mdSTtQwt9F770ikiOWQIFWBgn2N7/+VfiOXcgDvG/69JJXnnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA8ltJYl; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA8ltJYl"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2be3bdfda8eso5981277eec.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 01:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773132687; x=1773737487; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuIcqdDZbo5zQwKG77erGHbY2cXyTe9v+9s95vfs480=;
        b=lA8ltJYlaMj0+NhoM4c4F+VzaqYQvrajsU8f8qenORBOhZyfCrO6ybt0gZZG3C9G9n
         jYdbYC15nay93nVp5vCXPrtr5qHIFQReLDbLhdUDnpQ0LadvKFGQNbpCsD+82e+pLB51
         DpIWdkxgJ81/PHYfjHDRqiMyXayqG3SUX4brboCJNaVAJoKBH/YjYqSyHr7z6yzfvRk7
         6MSa9oq/kdRYi2WqeVtfq4r9p9kfhdggj54AX/HJuE4vA/ZETbkiUJ4fAaE6t7HpcTzm
         uKOjN/0PJcn8SEQ+nP7JvnZ++5xhJxtrG/flnwlSoQfQbrfwQHsucZ8DZ5go+a5SKFLG
         SMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132687; x=1773737487;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HuIcqdDZbo5zQwKG77erGHbY2cXyTe9v+9s95vfs480=;
        b=DMxdeTmoy2Hfu6zPkwFaiGpNbhYOnUxB4yqBBDxezDLBaJ5qe4rpJYlplvOc8bkR6O
         R/HCp0yZh+oHHkxg+GXtCHJm0sVuJDtAvSBGQajE5Eiv6lg2jbrJ02uU4ioieNM8oXEr
         E+IMnFaz5H+gaxfpPbLkA/RBC8j7xznT+kG6KNQupX3tnwUUI8k73iKajePcB3Uphx/j
         sLPf6TwURjAE1+tlOs/tLjTjhwxxDVq7EH6VUlM9bswQoSkv9NDozQucNaAOV4w/nSTN
         wK+dOjbe/YttasTAAUgNwHpqkbeRqsMfZ3LzN/eTmClYw3YS5mPf/NaHU3xP4SoQ9wGr
         yTQQ==
X-Gm-Message-State: AOJu0Yz52lPbw0CXyZMx9xnY2s4tNuo///McGJE2G6cNx9GYKHbYG/5a
	L3ByLyNYjWE6L08sLru+8McDdB7otxUx/cRyZ+FGncXTorMijQgpPWlhdlQL2A==
X-Gm-Gg: ATEYQzx1itx655GyTlT3VhbyZay90xyFd3x4Q1LbrMOIokRHagaIfYJD8jrh6w4Yym6
	yApKkvMQz1JON6oPvSrPe6sj4ll5Ch+GJOkBoOBJqtIilKht8SXVVlgnGVK2ghvUEymNIWxdO6H
	dXAVookdygnxyo85SoAF73ACUV+BxiM4A1s1ShxdYpFwJrdPLrcl/mVglkHYHX8sMdqL1zL2s7o
	lf0UncvQo+ge/SwDx90UqR2cramEDmM0nejetTEfV3m0ygOFFiKKm6Loiy6G11FkolCwojHap9g
	ht2Y1qkahSBIXERj/xXucgVi2p+NrB6rrfaJsI/zXUhUNzEBSLXAqg9HyXznV/VNiTT80w8C5z1
	VJrqHdXLPag5IpH9RHtk6jGJVOH+jkH7/w0NvgYwT4Tu5Q33lPKdH+zQqrBQlDUqct6GXkopGd6
	QpOXknImUsAiRjIfq6AxA88NVj
X-Received: by 2002:a05:693c:2b04:b0:2bd:fbc6:4134 with SMTP id 5a478bee46e88-2be4e027480mr5456561eec.23.1773132686546;
        Tue, 10 Mar 2026 01:51:26 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.69.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f8078c6sm14957477eec.5.2026.03.10.01.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 01:51:26 -0700 (PDT)
Message-Id: <acebdd714ba1e195c0c8a10d936a5075802157f5.1773132678.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
From: "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 08:51:17 +0000
Subject: [PATCH 4/5] The 13th batch
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
Cc: Arsh Srivastava <arshsrivastava00@gmail.com>,
    Junio C Hamano <gitster@pobox.com>

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.54.0.adoc | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/RelNotes/2.54.0.adoc b/Documentation/RelNotes/2.54.0.adoc
index fa6e42f3bb..ed5231f82c 100644
--- a/Documentation/RelNotes/2.54.0.adoc
+++ b/Documentation/RelNotes/2.54.0.adoc
@@ -60,6 +60,10 @@ UI, Workflows & Features
  * "git config list" is taught to show the values interpreted for
    specific type with "--type=<X>" option.
 
+ * "git add <submodule>" has been taught to honor
+   submodule.<name>.ignore that is set to "all" (and requires "git add
+   -f" to override it).
+
 
 Performance, Internal Implementation, Development Support etc.
 --------------------------------------------------------------
@@ -143,6 +147,11 @@ Performance, Internal Implementation, Development Support etc.
    were kept track of by a single global variable in-core, which has
    been corrected by moving it to per-repository data structure.
 
+ * Use the hook API to replace ad-hoc invocation of hook scripts via
+   the run_command() API.
+
+ * Code refactoring around refs-for-each-* API functions.
+
 
 Fixes since v2.53
 -----------------
@@ -234,6 +243,10 @@ Fixes since v2.53
    to access pack data by "fsck" has been updated to avoid this.
    (merge 13eb65d366 ps/fsck-stream-from-the-right-object-instance later to maint).
 
+ * "git log --graph --stat" did not count the display width of colored
+   graph part of its own output correctly, which has been corrected.
+   (merge 064b869efc lp/diff-stat-utf8-display-width-fix later to maint).
+
  * Other code cleanup, docfix, build fix, etc.
    (merge d79fff4a11 jk/remote-tracking-ref-leakfix later to maint).
    (merge 7a747f972d dd/t5403-modernise later to maint).
@@ -264,3 +277,4 @@ Fixes since v2.53
    (merge ed84bc1c0d kh/doc-patch-id-4 later to maint).
    (merge 7451864bfa sc/pack-redundant-leakfix later to maint).
    (merge f87593ab1a cx/fetch-display-ubfix later to maint).
+   (merge a66c8c7f91 jk/repo-structure-cleanup later to maint).
-- 
gitgitgadget

