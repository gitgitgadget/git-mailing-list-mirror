Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FC310620
	for <git@vger.kernel.org>; Thu, 28 May 2026 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001271; cv=none; b=juwiiReMdFtbQ7fWq8YCNcmnbpTGAfFd+c85f35sceMHqPfuC7gnO6HM/xHrlX0bH9eL+1+SHdjy+p2tjHJpvMv6lqhHyNW4O3l8qaMpNYMJoXQS1ZqRkWUpvhxVIGyAyXrFg41u2sZnty8sBShFi8XpguwoMKIWSlqj5GMwCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001271; c=relaxed/simple;
	bh=SrAp0loLnAzm9u5hPBEkDWaamFFFRF38Xx+Ub2fbaaw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Fum1V1IgbQJ+7pvXspO7gKCctVwd2qDJzOa3Ww3yoFG0WcbeXsI/6nNhaygLcxeQKwLj3yyFfd9iDG4T1YB0L8kdKqdubwmX/HtKCrgSOu4UeLUxRdvEu3zmOxCPFNAFWCIFG1wDgUeDNiTxrXAiSkY6D4Fe9DhmaHk86lOjsJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sghbnQgd; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sghbnQgd"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-902deb2412fso1477328585a.3
        for <git@vger.kernel.org>; Thu, 28 May 2026 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780001269; x=1780606069; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlqkWpw9RfJm46sPVtm2GbsuNeqr0c2CSqvwe1OmCzo=;
        b=sghbnQgd+DYcDasHnvxo99dMiE1kMZ9hdQI01iTytre3BnKAEDbovtpXzAVaBqX4/+
         yGlGlLOg10KvdJThfXrgEo5v7dapczO+J1HqWVWk35sAFMielEmQmUtquftMvGIGaI1n
         iqCHCno0wBTSBxXRNdv/4KJ2EZTTAIeLjiYP3CVNsgGy/ROnlvuzhpB/N5GiFN5/z3CH
         4kRUwWbCKSUUw2w0u0rO4j6Smi9upfIcxkKd8cYqRTuO31ycKwbjphPLhmvCQuYzyrzq
         vtzbmlHea2IJjyi41kBrtFw5f53jsYfdZRzWUwvMudBTwn8sX7OcvJV4mYPoRm0RSJ1R
         ZxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001269; x=1780606069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlqkWpw9RfJm46sPVtm2GbsuNeqr0c2CSqvwe1OmCzo=;
        b=Mdt0QhLyiQ7nulW52rCX/91E0Dv/59u8aCbucsl1cUzGQ+/wHIsKrhtL6pXtlwiV+L
         H1h1H7ZXFmXceXTke5DciSOZSVb+GdY8tCPi//lmfDjhRTARzExhxqmDbiR9zz5iytH2
         EsvqHDdAEzd/29PzPm+7BYnBGdLsFWJIbSrqXv9cYbIJwUWWk5bDaD0AkcsO+HxY9L3D
         XDPGGb/3f+851W9TLj1E0NiT0fBr79ieSfQDfeqxpHNNuNa7QjPFP+rl7Its06FyWlgM
         WFG0man7uhOVpr0FfAj4J89XtR+ZDtR2p+AVlmoCwZ15o2h+F92DioDx7OIXkcpA0NeU
         WQHg==
X-Gm-Message-State: AOJu0YwlDmpzre7RY3DR8tr3CPeHmZKjgHIeW5lVBYC1FNPP5mLFtF+1
	vaczs1R9EQ0K6sPbIMaMyEDcePSprv9CdQyqZQ5WRuejAEfeL7hvqtly2U5EJg==
X-Gm-Gg: Acq92OHFBk7Gp9EhhnKTHu+W0uSXUrnvhxj4AIJcvQiN54rJsx5iOMA1jKcHdzyUzmy
	Dhyxvbltx61hG7VGUpEF7VQYiBHeBF3D4bYr7dMmaODbke1rwh7SyCIGS59R9mhOYqtu9GVsKxV
	8DbTR88fMHfM2CDV0pqHGlpbxbGWwA3vHWY69ld4awS97Xels/vpAhYFyhpjXpKDAcH4/l8jSh+
	qG7L8dzCPhMQmOEo/NUysdxFeK0i++PiCJJ6xUu0iyjusSUvpk3W3IvFAHXtO/AwJqYwcrTRSMa
	Mlp9f/6SstsMJNASpZPxYLDcEkhqJrhNANtkiQQA3urs0OXeLcknntbY9XvLNlqY0qCEyIuexLw
	BO2CF34Ulpzxamilw6OVnRbwALQWNiEQIdhARO96tXtS5ELCs1zgVFzli9JqhbHsdbXzx4Rfu4i
	tutq9tLksqljGQYqYQ05X9G20MdTK4F7cIoQc=
X-Received: by 2002:a05:620a:280d:b0:914:7e9a:2716 with SMTP id af79cd13be357-9152cef8ad2mr107176685a.38.1780001269415;
        Thu, 28 May 2026 13:47:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8706968sm916365785a.17.2026.05.28.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:47:48 -0700 (PDT)
Message-Id: <9633eb62c620c7935f4e0aa87cae8808a6128c26.1780001267.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.v3.git.1780001267.gitgitgadget@gmail.com>
References: <pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
	<pull.2094.v3.git.1780001267.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 20:47:44 +0000
Subject: [PATCH v3 1/3] revision: move -L setup before output_format-to-diff
 derivation
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The line_level_traverse block sets a default DIFF_FORMAT_PATCH when
no output format has been explicitly requested.  This default must
be visible to the "Did the user ask for any diff output?" check
that derives revs->diff from revs->diffopt.output_format.

Currently the -L block runs after that derivation, so revs->diff
stays 0 when no explicit format is given.  This does not matter yet
because log_tree_commit() short-circuits into line_log_print()
before consulting revs->diff, but the next commit will route -L
through the normal log_tree_diff() path, which checks revs->diff.

Move the block above the derivation so the default DIFF_FORMAT_PATCH
is in place when revs->diff is computed.  No behavior change on its
own.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 revision.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 599b3a66c3..4a8e24bc38 100644
--- a/revision.c
+++ b/revision.c
@@ -3112,6 +3112,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		object_context_release(&oc);
 	}
 
+	if (revs->line_level_traverse) {
+		if (want_ancestry(revs))
+			revs->limited = 1;
+		revs->topo_order = 1;
+		if (!revs->diffopt.output_format)
+			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
+	}
+
 	/* Did the user ask for any diff output? Run the diff! */
 	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
 		revs->diff = 1;
@@ -3125,14 +3133,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->diffopt.objfind)
 		revs->simplify_history = 0;
 
-	if (revs->line_level_traverse) {
-		if (want_ancestry(revs))
-			revs->limited = 1;
-		revs->topo_order = 1;
-		if (!revs->diffopt.output_format)
-			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
-	}
-
 	if (revs->topo_order && !generation_numbers_enabled(the_repository))
 		revs->limited = 1;
 
-- 
gitgitgadget

