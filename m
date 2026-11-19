Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047657;
	b=z5HXZwiv5aLYBb6elFnIOh1OwYrfWADL6iTuoCMztsfA8BjYE8dLjNlo5ZURknM/jeia
	 V5aD+WWbF0GdJb2WC2KJy3zVu+rumJ4x+WgdvbReFuTHeFPZONkgNfBRXofmt79dgER9Y
	 3aZ7fjgTh4PAp1Y3Qn628/13Pd9k9qcHgkfKLpSZyvZHOnxS/CAfODGQ0QUOJZmrfmLOA
	 g3H8zR/6O0AaG2n79ccLx5iOTNCzgw7AdMBvrQdS01l3Tf7pfOtoeoKxdFgM+BAGHBEOG
	 YXcx1Vczh27dfn+w0nx0YmBOPAQ25M4JF15A/Wx28DA3CKWGm3bNa6RNe0QLldu+3xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o37WhT7IE1eyurYfoW9gRBL/khakdk1UR++HZQghg1o=;
	b=JrquVUPdwBO++glA2+qRzwOoYe/v/kK+Lgq9zrxo7hM8+KPh+66zqanAMSpZ8JfHsKN9
	 qDZu/qpxoIot0BFqegrx6hfkcc3JJ+9IkRPJpy8qiNCGZZB1eF0+FuWAsXmpTzUnzGL7N
	 C6zNJVduypYOiJTD5HHLeMVMrAqXHao/GwyC3M7u/v1W8QsU5C6ZK35syYdfozwkyRHrc
	 dOtXUtszwk08jdwFEYb5LvcJi73B1I2p9w8oi2rI1vpx1Ux1YkWDzTS3xQtFkIFArOB9Y
	 fPwM76qdef4LS/UzhnfZWiBnLjReSWJs4eAegEbhNDUhVu+zSGZ/NMocHjgmJa7SAVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ejPnF1CE;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F1606A337
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 00:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 490F1606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ejPnF1CE
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-862df509ccbso852088a34.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795047656; x=1795652456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o37WhT7IE1eyurYfoW9gRBL/khakdk1UR++HZQghg1o=;
        b=ejPnF1CE6Q8e1uj4yKeckNoKHWPYgvorA+RQ+FuUvcHfF8HxLQkkyw+SJKUW/ESjOC
         wQNqVWbczyzHw4LNLegDFICmain4bcZPmUmGaNqp381bXtla5fWLVMsEegxdL+/747g+
         GajGjOf5h5MYkwZEotZc0HgEaJwAp73m8i9CHSgeesU9bp3pZ+rf1rka3hjeAYkhHCxt
         6kH14HrtdTu2S9JC3XqQh0UGfHI+u1wbiKcTuvaYTU6AK3UYAUNyo9SRwW7cPiZFKNhZ
         Je20bnSDgO0dJQB8tJMWkTeC85DV/n/EPetxKoFxH4LlOjLCIJA5kRr1snakiTR6rNpX
         pyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047656; x=1795652456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o37WhT7IE1eyurYfoW9gRBL/khakdk1UR++HZQghg1o=;
        b=iP27ExZ7GJV2gOziB9l5+A4/fbXxYhQVYMW0lJBq6BJj9dyMmFtJoUu6UcWHJ+7jNb
         iqKEQgGQh1ifcSnwC4kgmCASrqC9F/irXIGR7dEZknThVhKZlygi++aCz8aIEJxMhuMd
         1Ye3sWVmUOnbp0NR7k6ou/T//S/72Xl5S7TAKf2kNGwjnTBwZ2S+H5y6z5wikTwjMIKL
         /HTcQ0PnOzPRbLnFWxxFIEE7gcMfkzfTGv8mkqivqCvanzm0CGKPY4a3SpI5d1m9el9x
         0ylX5mdilvmOho3I0TvASUytYMyhIqrvaiGyQkn4tWxX+rOFwrlk541DQNcCAlAkZI8G
         NdjQ==
X-Gm-Message-State: APuU4Z+FPG6EbSC+AXPe+KlTLWZwsN/r1gRBgMADPw89BB0Xeei1w6vb
	7KnsC2zRlO/WSLRpEaznDXNm7/u7kZavDvFhkG/AgUx8YIqnhyKCSY6DrwPb1w==
X-Gm-Gg: AYBFou2q2UF0WuDCUGf4RuaoHWq7rH8FSGNdw+54wCW9X9JXcKM0wc2ivp4Orz3KOH4
	j+/9Xbyfk8zXS5pmDIzPMPByt8sHzzQFYn/ynKKeE2y9XYGXYbuvwT1ETGLWhvovCwC0EHLwZ6L
	pyYFpFtzZxpNO+DT4HnidXZTOiZ5X9++4qXDjRp4KfAu58KJx+ra1RH+dNp1wiBApF1Brs13Ev5
	BSaBDUxme9wL16GDFmNDWTx+UZokiV9YJj9OWUYFsyopmde/EKCJLJ0PzfE645s0IqIuVHVJVnK
	WSLIKsoNd3/8uhGGrFrpVGweIP0TuraN5lyWOJ+5vZNtVjpV2qniM93fb7P/GEExg3vNV0QhueG
	W6yTl+YDmP6fONZZ0RNehci9dDm14A5zqWeaR42fSRdH7/8yoMYU1ufM2vCDF6WonFrKv+LGpAR
	v5K2cUlwuiKPP7aWBA7+A3mI//jd9o39eA+vKNPYp8wyZZscI6T+DPmcKwLQtiuAGUYJUAmvdfs
	QLa8VT6G2HMwwBc2TDUaBzJ92UXv9dnM0BbPviJSiuwjwlEMRCIt2vnecYuZ4tjfbLpeBeNXpFs
	VcQJKPTbVxuj0Ued9XVWK4LwEXusXvQc6mW+fQdKc9lrE3yYmTvNmni/yxslc3iLl/uMXA==
X-Received: by 2002:a05:6830:3115:b0:81b:a5f9:3490 with SMTP id 46e09a7af769-862f0945a28mr6011481a34.24.1795047656250;
        Wed, 18 Nov 2026 16:20:56 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01d492dsm3293400a34.6.2026.11.18.16.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:20:55 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/6] tmp-objdir: inline `setup_tmp_objdir()`
Date: Wed, 18 Nov 2026 18:20:40 -0600
Message-ID: <20261119002043.2108654-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261119002043.2108654-1-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261119002043.2108654-1-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a subsequent commit, `tmp_objdir_create()` is updated to preserve
`errno` when it fails to create the temporary object directory. In
preparation for this change, inline `setup_tmp_objdir()` into its only
caller so `errno` only has to be preserved in the single function.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 tmp-objdir.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index 5307717354..c78fc0e6b6 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -144,18 +144,6 @@ static void env_replace(struct strvec *env, const char *key, const char *val)
 	strvec_pushf(env, "%s=%s", key, val);
 }
 
-static int setup_tmp_objdir(const char *root)
-{
-	char *path;
-	int ret = 0;
-
-	path = xstrfmt("%s/pack", root);
-	ret = mkdir(path, 0777);
-	free(path);
-
-	return ret;
-}
-
 struct tmp_objdir *tmp_objdir_create(struct repository *r,
 				     const char *prefix,
 				     int will_destroy)
@@ -163,6 +151,8 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);
 	static int installed_handlers;
 	struct tmp_objdir *t;
+	char *path;
+	int ret;
 
 	if (the_tmp_objdir)
 		BUG("only one tmp_objdir can be used at a time");
@@ -196,7 +186,10 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 		installed_handlers++;
 	}
 
-	if (setup_tmp_objdir(t->path.buf)) {
+	path = xstrfmt("%s/pack", t->path.buf);
+	ret = mkdir(path, 0777);
+	free(path);
+	if (ret) {
 		tmp_objdir_destroy(t);
 		return NULL;
 	}
-- 
2.56.0.173.gf57c9a7388

