Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335332E6BB
	for <git@vger.kernel.org>; Tue,  5 May 2026 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022153; cv=none; b=ODwLAF6wSdsT9+nEXJsoNRyCBl8U6A7Qi7b3Ycu2t668vxMiKI4+aRIRKCR3JbjZ9olQkYJi9CfCjoc8hEjzCEZRkBnhvv5RH2xR6elMDkh7kgZD7SZEPcc3zmT25pMxGrOyI/pSgI6ATxanY6SfTRHEkHaS6bLCGKulHIeQNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022153; c=relaxed/simple;
	bh=fX4OvBVV8Pd7ppnT5E3rnJzlKJlg/3XrfBXMkyWB0oY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SAlJuOADPkJzuwqborUCr6CoQZJ0P/GElflkQcQ4ctuGz0VqTdJeqhwJt40oZlDZxbMq7WKLe8FFfASeQcyWp8bnPTUFb0O0Zp02eRczV3aN2K5RMpgDDoHCous0cTonRUKHYTiKiFDsPfaoKyZHu8jUx4mxWQwr7Gq9HqLCPNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYHLj+yb; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYHLj+yb"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f00a567cfaso300763eec.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778022151; x=1778626951; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcLsdeWMhUMQPfZNq5JY+8B03eHo1E5r5hp/TD9BEIk=;
        b=kYHLj+ybdKLyCsGDeyrpQWBnL9pbrvRTdC6Xfxjkc/h5bRg6v7e5O8jH8xREiJB7i5
         m1IJuL/x7qXj0E/PemlYbAElK5e/CSipWfLfCgt+z6/YZLTmhad422HePhagJfKCcOEq
         ARzFG50VO7A15UlsvXJIzM3/Edc746sfdcfaJdlMVFKO7NRyqc0i3w+4lDHvDoqrCUvJ
         J4mf6+x5JPignDQpGV9nKAQuUH0B/qGffpd7Ivj45KkH+PXicd4AnSSqqzbCU+3cWQQt
         Dcbk86WGE/e7pE24rVpBCkuWZzu9a8j2WzYxtvMcEkquwk7Wq0tUQWiCpfm+rp/fz5eE
         VFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778022151; x=1778626951;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcLsdeWMhUMQPfZNq5JY+8B03eHo1E5r5hp/TD9BEIk=;
        b=MvypdJjHs3oj16BQAe8/i5W1FsK+KsWVg6+3XG+UCphf5ZfIUNrXEAETuFvGDYEMxf
         cwoWCrZSozgVHH8GbY/OJZFjCdUltGR5S+xD/msyR+cV7aIs9Pn934ZYlDZuIpe/sOvG
         dGDOIJfwbi6M+tZ73sRlEGCasjoQjBCppi5lBiqc4TYwu/PV/kwWzZlTNLtoZyQ/MrxU
         K35BQEhU4cXcuyns8rD/D0XnaytktB9bRxstz2OjSYjPnju+SsHuKBrqST5XHKesk20K
         djSGZ1M3Byd1b+aOBGKvD2Z53PVEnEL1RpIurDg53agxK4ZG92MS5p4X4Myn8i1LF8Mf
         vPnQ==
X-Gm-Message-State: AOJu0YzpppD/UFHVQBiyVyKruBS1aKZu3XP5feB+7zEA9Rd1Nz3h3eCu
	jhtwPFplco4f4LlQuTUkC88S4265VkWWET8FxmV/yQ1VEfb4kajn+H8hnkkGgwNY
X-Gm-Gg: AeBDievobTiifo1dkV9paEdEmj2k+RYfPpkiLxWNcPMjt21IHpQWQ/v75sINxYdrqzS
	ROHNWpG1144Wc45c1FRYBU0XiV1iPz67jtFdbWAr35bnCoVw5GH/qHwMsUpjxhrTcE2PjkGDkBc
	F1lJx2oSyDYvZT0cOV0+iU6Lc58GaovjNjsKoEGLZ4jqVzeExOAXffBzfa+drXNnDU/Y/i9onUV
	dv+3uLbpOpdxBVMwohumw2Ikd4aRrDkavZy17kOZCAhItHefOHl+5WTkONsW9tLNDMRq/wxVSX6
	0QjncMcy3Reppx6kHWggSlrJbrXQLFIz3oSbd9coLNTn8Onop7q34Xh9yvKlHBodt18hCwlzAkL
	BqTzpL7Ltl7ZgycEXlrpKr5KRw53UcWLiKxdPV/9nMffxJHjokorsIg+d2kCNfsqEdz1S3pXaJ0
	hAsmZ3a1JpOUB8BTRR1dnO4Mmz1jjwni15
X-Received: by 2002:a05:7300:b10b:b0:2f3:b7b2:cbd3 with SMTP id 5a478bee46e88-2f558c796cdmr385805eec.5.1778022150246;
        Tue, 05 May 2026 16:02:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.4.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56cec58efsm902968eec.2.2026.05.05.16.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 16:02:29 -0700 (PDT)
Message-Id: <f9cfa0c55dde8f7e876b568f8ea7caf555ffff1c.1778022144.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 23:02:23 +0000
Subject: [PATCH 3/4] xdiff: guard against negative context lengths
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The xdemitconf_t fields ctxlen and interhunkctxlen are typed as long
(signed), but negative values are not meaningful for context line
counts. Unlike the diff_options fields changed in the previous two
commits, these cannot be converted to unsigned because the xdiff
arithmetic relies on signed subtraction:

    s1 = XDL_MAX(xch->i1 - xecfg->ctxlen, 0);

If ctxlen were unsigned long, the signed operand would be implicitly
converted to unsigned, and the subtraction would wrap to a large
positive value when i1 < ctxlen, defeating the XDL_MAX clamp. The
signed type is required for correct context-window calculations.

The previous two commits reject negative values at the parse layer
for --inter-hunk-context and -U/--unified, so negative values should
no longer reach xdiff in normal use. Add BUG() guards at the top of
xdl_get_hunk() as defense in depth to catch programming errors in
current or future callers that bypass option parsing.

xdl_get_hunk() is called by both xdl_emit_diff() and
xdl_call_hunk_func(), so a single guard covers all xdiff consumers.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 xdiff/xemit.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 04f7e9193b..7cd9cf0a44 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -46,12 +46,20 @@ static long saturating_add(long a, long b)
 xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg)
 {
 	xdchange_t *xch, *xchp, *lxch;
-	long max_common = saturating_add(saturating_add(xecfg->ctxlen,
-							xecfg->ctxlen),
-					 xecfg->interhunkctxlen);
-	long max_ignorable = xecfg->ctxlen;
+	long max_common;
+	long max_ignorable;
 	long ignored = 0; /* number of ignored blank lines */
 
+	if (xecfg->ctxlen < 0)
+		BUG("negative context length: %ld", xecfg->ctxlen);
+	if (xecfg->interhunkctxlen < 0)
+		BUG("negative inter-hunk context length: %ld", xecfg->interhunkctxlen);
+
+	max_common = saturating_add(saturating_add(xecfg->ctxlen,
+						   xecfg->ctxlen),
+				    xecfg->interhunkctxlen);
+	max_ignorable = xecfg->ctxlen;
+
 	/* remove ignorable changes that are too far before other changes */
 	for (xchp = *xscr; xchp && xchp->ignore; xchp = xchp->next) {
 		xch = xchp->next;
-- 
gitgitgadget

