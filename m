Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEAEB672
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739690959; cv=none; b=D256f1RAlGKmpwf/IGa0/6hGvrvqWjFyoMnMe3hpchNukw2S4LIfy87R6AKEKo+AhiOVNfMkBd/Q+y8Coq2bAHV6AEPgD/F95a+HWg8B+qIWvciWMAc3Cyey9q6GYr3QFOZh+6XiTkc2vXCLRNKxy4Oo2OFhPnFgbnRdtNJ5IZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739690959; c=relaxed/simple;
	bh=jZ21fjZiToFe/BirR2R07EQ503d5Ef2u3tRy/pzaR20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhAi1WgDbNQboAf9kT2M0T52m6uNKYxbXpe9icrPgayNSn8ud5OuQG3UpzUUbIKTdef9AAdXD4BYMKgK1goQWx43p4TQuS7D7UBTp0lpSNVXWC1+MCs+HKkac2qLx0F1rs7wyzlbQyc4BXIDKzK8YDGE9ICTRyT34Jjo8hkXJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHial+In; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHial+In"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso5218572a91.1
        for <git@vger.kernel.org>; Sat, 15 Feb 2025 23:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739690957; x=1740295757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDsErJcWezRLX3/qG14LsHrZlP6/2jx9fIjoxu8k+Fw=;
        b=aHial+InN0Lf0wwBp0mG96YsqJQRktJGabsMjGftQkFtffe/l5VGTkSTrGQVq14N7C
         LY1VaGVIOENJwkovYrfDEHyApTki3h/c7ieTA7KFNthGlCdINXBvtIoJAZ8THGKUrfhe
         3XeWRpqc8zR+ouGmw9Wl4OKtqjusZ3ytVlL9bbOWKr62FQqiFJX6ucea3OTsdj62Fm8t
         xYK8Qk6Jxw5+jREc9rOxYKrcdML1dr3f3U+aoKbEPyEaqozZs0h/ySNlwPx7ND8queLj
         XkOq8+tMVgkR7pab1mY96Dq8Oe/nI42bupXf6KHMPylpnYHGAvTWWewBu+xS4SdEtByF
         KbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739690957; x=1740295757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDsErJcWezRLX3/qG14LsHrZlP6/2jx9fIjoxu8k+Fw=;
        b=D4DfaTTUVn4Y79N5BX+VmLZjBkyFwMPL0Urg1LGkmTMB2X6zjF88521hA34jsVTykf
         4ZN8Yw5yCbM7w/IggRi2FA8b2tfVbo3yAjnq4ZpKASuU8tKFe8PAWq+Zd6Td0vk+xL7M
         ihCDa5uZRD5sF6gl44acI3/bA1KKHU+Y/+zS+yOwfqSwZAGfjH2wG7xyrvLaSiRHh0Yb
         LQ0jdlYx7uTgv/L8gY0VXsAaIjeXD3M5SFRuJtb3Cwj8tsc3MgV05he7VrutsCoN1czs
         TecPUdSMYy39gYvCUIE94NS9CZHOdeOwi8tWoyD54p+qukq2zig5nZavFF/ToNtDYnbC
         rgAg==
X-Gm-Message-State: AOJu0YyibAwuAw4ZBRlam1PLuXZ3oFobGrME8n+HSPO/fjURZBbhOJW0
	ZvlZ79f2QDyjHX9p1QLsS8XJiWxBNrIok/UEX0Hhqrj/G9LgvhUB
X-Gm-Gg: ASbGncszmQFHXiSiSz8yyP2CS4tqWMuf518opmWeWeT/mZhyRvOTak54vV7Z9fEpLSg
	ND+giEdktnfcO58+2JVODAVo8t23IeBw232kHgZVfvQRt8roocpCVUmwjLayyIDTXH2bbBP9bKx
	qdBjjkH4Z0ZwP9e+FnXAYUbiABotSzoFxlsc1Un+40KM7d78UAwTI4SYfC05p0TYRHFoaxwcMvJ
	TyO1nojS6c5FFUwVhqaWvbxlnohR0zFFrhhQkHWFSFkPKaPX8g4OuGJZ2GlHz7StX/TIRdQ04F1
	oIMsAaivcRRtV8xTrT0lraEu2sVbSD68qrMS2bPvGb1QaBo8KI6S3uUOW2R5Nh9zohtvXsyJM60
	Ryv950L3URnvn7QVmAlPaboYYZffUKrmw2g==
X-Google-Smtp-Source: AGHT+IEyvcXSYFmllRoPAf/7tr8JNLxiQaCcEMvd+1uelpmW2p+KoVlI7IBg4aL6TObZH/qCsasv2A==
X-Received: by 2002:a17:90b:1d46:b0:2fa:6793:e860 with SMTP id 98e67ed59e1d1-2fc0f7ef7d1mr22144217a91.0.1739690957358;
        Sat, 15 Feb 2025 23:29:17 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. (ec2-18-166-75-244.ap-east-1.compute.amazonaws.com. [18.166.75.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc327a9d68sm4483243a91.1.2025.02.15.23.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 23:29:15 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: jelly.zhao.42@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	newren@gmail.com,
	ps@pks.im,
	karthik.188@gmail.com
Subject: [PATCH v3 1/6] apply: correct type misuse in `apply.h`
Date: Sun, 16 Feb 2025 07:28:38 +0000
Message-ID: <20250216072843.72385-2-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216072843.72385-1-jelly.zhao.42@gmail.com>
References: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
 <20250216072843.72385-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few `int` fields of structs in `apply.h` that are only used
as unsigned integer and are only assigned unsigned integer value. Some
of these misuse of `int` type would cause -Wsign-comparison warnings.

Fix this by

  - change `apply_state::max_change`'s type to `unsigned int` since it's
    just a counter of lines

  - change `apply_state::max_len`'s type to `size_t` since it's storing
    a length

  - change `patch::lines_added/deleted`'s types to `unsigned int` since
    they are just counters of lines

  - change the types of relevant variables in function `show_stats` and
    `patch_stats`

Note that `printf`'s format string requires us to do some typecast
(from `size_t` to `int`) on `max` in function `show_stats`. This is
safe because we already set a upper bound of `50` for `max` before the
cast.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 11 ++++++-----
 apply.h |  6 +++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 4a7b6120ac..4380a83386 100644
--- a/apply.c
+++ b/apply.c
@@ -2238,7 +2238,8 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 {
 	struct strbuf qname = STRBUF_INIT;
 	char *cp = patch->new_name ? patch->new_name : patch->old_name;
-	int max, add, del;
+	size_t max;
+	unsigned int add, del;
 
 	quote_c_style(cp, &qname, NULL, 0);
 
@@ -2257,12 +2258,12 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 	}
 
 	if (patch->is_binary) {
-		printf(" %-*s |  Bin\n", max, qname.buf);
+		printf(" %-*s |  Bin\n", (int) max, qname.buf);
 		strbuf_release(&qname);
 		return;
 	}
 
-	printf(" %-*s |", max, qname.buf);
+	printf(" %-*s |", (int) max, qname.buf);
 	strbuf_release(&qname);
 
 	/*
@@ -2273,7 +2274,7 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 	del = patch->lines_deleted;
 
 	if (state->max_change > 0) {
-		int total = ((add + del) * max + state->max_change / 2) / state->max_change;
+		unsigned int total = ((add + del) * max + state->max_change / 2) / state->max_change;
 		add = (add * max + state->max_change / 2) / state->max_change;
 		del = total - add;
 	}
@@ -4287,7 +4288,7 @@ static void summary_patch_list(struct patch *patch)
 
 static void patch_stats(struct apply_state *state, struct patch *patch)
 {
-	int lines = patch->lines_added + patch->lines_deleted;
+	unsigned int lines = patch->lines_added + patch->lines_deleted;
 
 	if (lines > state->max_change)
 		state->max_change = lines;
diff --git a/apply.h b/apply.h
index 90e887ec0e..8cd22756e2 100644
--- a/apply.h
+++ b/apply.h
@@ -90,8 +90,8 @@ struct apply_state {
 	 * we've seen, and the longest filename. That allows us to do simple
 	 * scaling.
 	 */
-	int max_change;
-	int max_len;
+	unsigned int max_change;
+	size_t max_len;
 
 	/*
 	 * Records filenames that have been touched, in order to handle
@@ -127,7 +127,7 @@ struct patch {
 	int is_new, is_delete;	/* -1 = unknown, 0 = false, 1 = true */
 	int rejected;
 	unsigned ws_rule;
-	int lines_added, lines_deleted;
+	unsigned int lines_added, lines_deleted;
 	int score;
 	int extension_linenr; /* first line specifying delete/new/rename/copy */
 	unsigned int is_toplevel_relative:1;
-- 
2.43.0

