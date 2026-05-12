Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6536A378
	for <git@vger.kernel.org>; Tue, 12 May 2026 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609432; cv=none; b=Y+chlasOCyfjWPDHa92IcRIPccAuzNl1Pz8YQ6NnKfmoMGt27TMQ0skZXmChC2E8TFUFNyy6shGJAjrpX0VjOy3QwKEXGKWOSK7OIVvxe/RqJiVnhgyiBq+Z4U/+xshEEFhKO2mb5pvE7MdfAem+X2V+0OR9C7ZKws8abCOBWYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609432; c=relaxed/simple;
	bh=fX4OvBVV8Pd7ppnT5E3rnJzlKJlg/3XrfBXMkyWB0oY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ic0w0dzSmF3NBzTd3kzvTKVDyLfRpSp2wg6Uyf5vvMMk4J37fKpGUtibdX3HNN0pe+PbObZ9WHJnTvB/+TS7Yv8Z/4T+ZR9mPSRNf31AXjffLWGc+1W5ei8gYe5Ln+u+R5FCHLDPJrFCwyVmaXVSUW0bIWtP3q9sEO98k9XMDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3wve2q/; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3wve2q/"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so6088323eec.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778609430; x=1779214230; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcLsdeWMhUMQPfZNq5JY+8B03eHo1E5r5hp/TD9BEIk=;
        b=Z3wve2q/tifJBot2LCOh8ZzkxEcYRQ0FDbNhvA8xGw2e8f7yDWGe2bdDvbahlqhxpH
         xPE3pO+yZWDLPth8sCXD+0HFRFceqcZqe5SViSb0TJijuX49Fv/X/om5UOrB8iVU/y7V
         zR6zbJ0wnKG9GVGvd/CqK+aArFI+hWqf/v2vjQ7ODPTLvcBkl1OskHs9ZzZIdBHV7atN
         i5YtcCTSZyc7gWQ8ZaeGWLjTQ1rMbQfmWqhsbzBsTKhTpalHTG0ufH9D0+s8d1qw6cxS
         PnpC5t24pjEl0E7T3g1QEiILpMCj49OGNY2xAkfGCpCi/9fHiBwmJ+tfmxgFcG33/rXL
         QOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609430; x=1779214230;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vcLsdeWMhUMQPfZNq5JY+8B03eHo1E5r5hp/TD9BEIk=;
        b=jq+znNE41hc9lrig7JOx5YM8ajpPAuiTSHazfoyzZAVCe/4dUNQSlASOamapD/OWn4
         c6ZQurhHzFbLd7MQl/YuOvaYKpcHZwaUxCO6WfSJ3woSdAbri4nwfXiSqkalYGTGRV+F
         XpMO7COGAQpeDaxRulnwu8AwI1LjFlGnmHcSYaosEO2BBbL/zKIrWZlo9gX83jveix6C
         LZUdXbj6e2vE5DI63RIfNq632zmkqtHnjH8gjWyPIiu4r1fSopDqlTKylKaRIcGtin+F
         nUDdgS2usLKXlvok1lVjH11o5uwLu3wLuTcyzhAzjvr13B2AP3bjAQDL9nCZ3Xr5QUrc
         8hRQ==
X-Gm-Message-State: AOJu0YybqxA6IHPnO2H+SuGrRhRzvV+02xEtW4TR+JAaJm3iuzgP/1Hf
	vGBNXpVSkDL6uSIe+c0JNidrKIR7+Hjd7KEi8M3/eKhV9XYW4erRWIaCOTM9Ng==
X-Gm-Gg: Acq92OGLPCjPOlE8yo8ohbE+Tra6VPPdXcoMt5mU9KCOWdrgBbGvA0G5pWqUWOgYoGw
	0SQQAWnnOEszyk0b7quqp1oJhNwZ5NEbjxKFwVz8zFvCjA4zWwNcdHqmtGJYyocE8fvrjYGMz6e
	ekGawtRysCkI/gcBAsI3NsuhtfAUt6DjFwwXcpJ6us8Al5Whccwb3Is2TsRwTjpZUBzNZeyfr3O
	G+yvq9jzQoU5l1mtAUrkfrlZ77DRiV3In6JxI9sgCyJlCXTuHm2hbhPPshIoVD0cGzIzTB2j+lq
	KnIkBxC30ToYR0y331CKdDL/Rtlkx4p54OfbRs3uyjTum928Jf3EVBPz5G/JpzFw529rzV2ShOA
	xEpI02CIJCrDg+cWdkgp1Vpf6aPD9SZF/Ijpk3G3Mn5oFKbwtGICC9+O31mgdWOz5awES0WW2zD
	VhOPe3OdKVd87ybSgIn7yjv8eD1k0=
X-Received: by 2002:a05:7301:290e:b0:2d8:71c2:255d with SMTP id 5a478bee46e88-30118ca4b2bmr119445eec.14.1778609429684;
        Tue, 12 May 2026 11:10:29 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88885b87dsm22854073eec.21.2026.05.12.11.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:10:29 -0700 (PDT)
Message-Id: <020ca774c0ec3abadb5c987c93373f11d67d5880.1778609423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2105.v2.git.1778609423.gitgitgadget@gmail.com>
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
	<pull.2105.v2.git.1778609423.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 18:10:22 +0000
Subject: [PATCH v2 3/4] xdiff: guard against negative context lengths
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

