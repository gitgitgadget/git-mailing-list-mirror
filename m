Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6C3DBD7F
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890012; cv=none; b=MQinbuxsODRIbsJz7H2NB9P4evFj/FL76tfvj5+lvqDyE4iVwVDb4b2hgudHGuSd/d/FkpoNLEp4VYs8sJmewOdc211vs5RAP8LnXt2DveEjbA2qGASn7Qz560ZDcvigsYcF+8DKx+Ph+uROooVyE7jus8rlNDPnMXxYMu+cYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890012; c=relaxed/simple;
	bh=Ao/aEfOMWdkk7cG6BaxAqunla7Vo6n4VL55nZxp0zQk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G6sX6hPFda3ep9zusCJ9NqhnxM2n+J0wRPES96w3PQUana84zTgBXZOMPv4VpIgz/0InKpfIixeexbzYk3zHEpGJQqKmAhVpw4U9V6mbylTUAabuYfV8VLRuXO1NRW8QAXlgTj8YhreoVj7OkRvtBILdNto4N2rewsK1aYbKP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ+DkyfJ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ+DkyfJ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7f09aa39fso5647441a34.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774890010; x=1775494810; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVs9DBKONIEvkews5LxRJcvg9oerl9LS6fLqw81YFpM=;
        b=RZ+DkyfJ5P/3snH4qyrcAOfTW4hexEgWCAD21ajMSnoFtUZX9oG79zdnuZAa15KzBS
         9P/4Vof2UTctl9GLhpL/bhWO7VkcUosZ3CqgMsuoO+ibcVP17BLnygZYfDDkmgDjEQvy
         SlCg3w65k02p7134xePVZt7KCuQUYlSTtfEQ5exshtodppD0Qf6E0NWDSmeSH7NMxHa4
         CxeaNTFssFi2JhgISY1JN+xKrUfImAbFhwh6RT0VBkd3U1punuZnyS7fzNGbLClvIGe+
         hr4zKY+d6J50iFZ4k7cktS5dyCMSsS4g+QuSXURquENc2UNNnkBuoykjqAvtp6+/MQ+S
         AwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774890010; x=1775494810;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WVs9DBKONIEvkews5LxRJcvg9oerl9LS6fLqw81YFpM=;
        b=qX24d/ZepJMxOClEWkTHXukDftPKMdP2omakBQjqTSMKEY7xB/qNnA0P04UF6UJSxZ
         dNoE0dJ/Rvb8OxibFoL+RE0gM1tivnCbDhjsGxctLXjB0l2S1EHu+emhnzLTH5Ur9M/a
         d2Mhvu73NO7mO9jjLnO5Tq5HRM5xEYs1BhgdUrYVe5lhvpspcqEYtInWcSRoKzAbcBdm
         0oAFmtLRp6rIN9EjrfVFWKhu7i4vyqLaLL5mk2nlpFxxpt28fnoGiOfaodHTLwfCirpc
         jb54XClmIAla/X7+M3mLwGWtdm+s9N954xlBHBhHkM/hqPzW2R7ENqvHtdflBy99RYK6
         NQNQ==
X-Gm-Message-State: AOJu0YylWLqcPA6RBbXGUfoKrWHgM/x2K2BVGlbcVlEOAkeGYIF7Vo4e
	4pjWj2Xphl2ED84lc8wqv6h2B/z9KpzXQItizdpYg9GiBSFt28q5uU1fil0ppQ==
X-Gm-Gg: ATEYQzxoCChuIYplT6HXD+EHJnWzW7bT6DdscBpMDFUjj0OC2HmF6S0ZH5ZTM5er4zH
	F07iXhUxtbj5Jggw7eFqrfUsZPNLfwygzTpCKFDxklnMbp01mV0po7heJWrWVanSbtm5Lj/RuGi
	TytDyTYu/pHYN+E/CcKSytbz9V0h5F1FP7K5nDGxNXNvY8fJ8s4WGIocO5S8baj8VW77S09gvs6
	cGVCOtzMGop7zze502gqDQJS5tnzCC4yx7Cq11YPBnB6XKBGCNHW1TDYB7ezkucFU4bfJh3QbJU
	168WKDNgiFBEF4DQEQbr33QMcPedzdQbI9ExSSffmaOWc7EUOF/50mx5izjcK/ytAS+8cYMdBLL
	nfeHifNX7WvDWoqTJMBTx+G35DdnsRmHVNwFmsyAxSomrqZd/7AVxg1etTvYitP5LVVs3GZ0pRM
	ynefSG15/ZkHJW8/mKeNCpTKZDZxw=
X-Received: by 2002:a05:6830:7103:b0:7d7:5d9c:26aa with SMTP id 46e09a7af769-7d9fadd97femr8036869a34.8.1774890009686;
        Mon, 30 Mar 2026 10:00:09 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a7b5499sm6368994a34.18.2026.03.30.10.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:00:09 -0700 (PDT)
Message-Id: <39a35365ae85f630f6c69c2ab0393ef087becdbd.1774890003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 17:00:00 +0000
Subject: [PATCH v4 3/6] xdiff/xdl_cleanup_records: use unambiguous types
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

Change the parameters of xdl_clean_mmatch() and the local variables
i, nm, mlim in xdl_cleanup_records() to use unambiguous types. Best
viewed with --color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 48fb5ce6fe..386668a92d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -197,8 +197,8 @@ void xdl_free_env(xdfenv_t *xe) {
 }
 
 
-static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
-	long r, rdis0, rpdis0, rdis1, rpdis1;
+static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, ptrdiff_t e) {
+	ptrdiff_t r, rdis0, rpdis0, rdis1, rpdis1;
 
 	/*
 	 * Limits the window that is examined during the similar-lines
@@ -268,7 +268,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, mlim;
+	ptrdiff_t i, nm, mlim;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
-- 
gitgitgadget

