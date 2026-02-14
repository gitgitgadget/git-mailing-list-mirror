Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40579339A8
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771067164; cv=none; b=PeYRY/62dbF3hf8ej0dV1E1ziKD7cWZIIPzX3/RoS9NI/l40xYY5E2j7k1PDQgNKuA3hf1ja8iD3zHig14ZWpYCHIyHyyv4AKVVkl/T+GByMLl4+RvhycjvQVvk9vwcCX1Mgjt3TeUlm9Z1tdDbmx+9BAw+xMHCeDkQ+TixC36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771067164; c=relaxed/simple;
	bh=ogIQIIhuoOkKycsj0IVexebeumXh/fLOxromyD2Y9DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfKy36R8TzBbGEsNf24xpcWq0M48gRtS1uTb2pW8iLBaOkMl9pw46JatmHiMDt9yDoFJWxdyB8DQcHpAZdByIJ5RU+h8cuF8k3vhpOp6J1CWU1P150ciwWdflPkg6GJTPuSGyw5bVF1IvBu4YwGDrbZ3SLAyKdyPR97i+5NAI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNGcLSnR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNGcLSnR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48371bb515eso16488355e9.1
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 03:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771067161; x=1771671961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+/qQIUW3lNlwkHfERRF+1NQ6jYn6g82Zw3J71sCpeM=;
        b=ZNGcLSnRS+5BI89bUw1hiQ7D+TWutW0dIMJ6xfQhlTeM0ZmEw3hljKIRkUQ+6JpYnd
         0YDDW3am7A8LhdCDrCxIf9B+jrpmGjnt1xEKd7lYx4Q6qiHcqs/DVviQzMpl7Np7QkUA
         YV+3XeX8Q6HXT0wmBbAbYCGT+Ig9+TKY362eXkCEydvVxn0uWS765EpE8razFFpfIcH3
         LHl6TNCWVPJue+ihAWR1Hw93i1OpvwJk8u7aL6oYj0oqu9QkwTqi09+EA6MfjauJZc+T
         eAe2lSqvAUeAK17/gui5G9him80QqToKrZc6wkLW5LLgfRB47Yhx3NEjt/VVEK6/4d7G
         QrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771067161; x=1771671961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+/qQIUW3lNlwkHfERRF+1NQ6jYn6g82Zw3J71sCpeM=;
        b=mwW7FOT5W193aOkEjTjJDiJ94ZkV7/wzHxzfl892awPlTH/Ij/M7fxJCNTzZkVPAeT
         dDgOVx4H0Dh5lt0fPm+kXsXM253Msrcpu9Go2IVN6hpKJuJ1lVO9xEKPJsxXOLHJ94cb
         aMJX9UISwJ5jq3u4oUIbaU9vR9aUmIdWK/pATjVkW2/yXn03r9LRsSvLlhTjBzjlO0ga
         yVJEa67PKsIBOO4XlzoMcrY83Ocw5DmSI9zn6xsdms7RpltHMmKRxdkUnmYltRCo599p
         Aj0wCeUHUx2KUkEH4lq2SCNBxUFbS0eIQ1dIVBSj8Uj+980CPp3NT1IEr7Dxqs296LMI
         UaLQ==
X-Gm-Message-State: AOJu0YzJqlsXKBpCdlPnvUvo1zlflidfi9SJT5e+tQdvyt+U4pgq0hln
	I23TO/EKJZU3T3jAJwK78YE8W9XVLRa6bADNKb/dbTcSQEnSlNM0tGxUcXpQ3GJD
X-Gm-Gg: AZuq6aLRuvs2ggwIYQUYTT9OFJdr7J3qCzLEHlDrUg0y3Hy6ILOUwYNBW/azua6VTod
	SP0XCqTnhswEjWS1Z1Gc5nZKMU4STOc6KHGsj2IFLmuLQ/zdqs2lEsrecPaVXj5LuPqc2jj6fT8
	dJn808Ms9W9mys8qH2qbvSI+p1wC5N62mz3jyxMUCmSkisevpv6ARqQUqIsfIFAV4BzzRo6w8gs
	tqbS9gZfDEzXI96ZXmJ9JxdXGR8H8XAa/RlmNq1/OdoObjdb+aJEiWpxNFITU+kjDs/jLQWnYrU
	MCxIXscXjfhcqedSPr/Aau3s+7Dxpj1GVN4O5vmNsCGqx6d6YdHrAYHJbKN81/xB5fyOPblXzIC
	rX1H8VfCzDSONb2dEw0560GaEnzsVagrY5F3bHhQ16qSQT6aNBrwrsNa8A/qoV4q4liLy+Ucfbt
	lGE8wOA3wSuUtwSkRytQ5PwJl0sAwnXas=
X-Received: by 2002:a05:600c:a08c:b0:480:6910:abd1 with SMTP id 5b1f17b1804b1-48373a5ba84mr84580905e9.18.1771067161087;
        Sat, 14 Feb 2026 03:06:01 -0800 (PST)
Received: from localhost ([102.88.77.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a44ae0sm33968335e9.29.2026.02.14.03.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 03:06:00 -0800 (PST)
Date: Sat, 14 Feb 2026 12:06:06 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH v5 3/4] add-patch: allow all-or-none application of patches
Message-ID: <1ad4524023e246744b3d268db8a476b605d44223.1771066252.git.abrahamadekunle50@gmail.com>
References: <cover.1771066252.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771066252.git.abrahamadekunle50@gmail.com>

When the flag `--no-auto-advance` is used with `--patch`,
if the user has decided `USE` on a hunk in a file, goes to another
file, and then returns to this file and changes the previous
decision on the hunk to `SKIP`, because the patch has already
been applied, the last decision is not registered and the now
SKIPPED hunk is still applied.

Move the logic for applying patches into a function so that we can
reuse this logic to implement the all or non application of the patches
after the user is done with the hunk selection.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 add-patch.c | 62 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 8e21ea1246..07526e7fb6 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1420,6 +1420,40 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "P - print the current hunk using the pager\n"
    "? - print help\n");
 
+static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	size_t j;
+
+	/* Any hunk to be used? */
+	for (j = 0; j < file_diff->hunk_nr; j++)
+		if (file_diff->hunk[j].use == USE_HUNK)
+			break;
+
+	if (j < file_diff->hunk_nr ||
+		(!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
+		/* At least one hunk selected: apply */
+		strbuf_reset(&s->buf);
+		reassemble_patch(s, file_diff, 0, &s->buf);
+
+		discard_index(s->s.r->index);
+		if (s->mode->apply_for_checkout)
+			apply_for_checkout(s, &s->buf,
+					s->mode->is_reverse);
+		else {
+			setup_child_process(s, &cp, "apply", NULL);
+			strvec_pushv(&cp.args, s->mode->apply_args);
+			if (pipe_command(&cp, s->buf.buf, s->buf.len,
+					NULL, 0, NULL, 0))
+				error(_("'git apply' failed"));
+		}
+		if (repo_read_index(s->s.r) >= 0)
+			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
+							1, NULL, NULL, NULL);
+	}
+
+}
+
 static size_t dec_mod(size_t a, size_t m)
 {
 	return a > 0 ? a - 1 : m - 1;
@@ -1447,7 +1481,6 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
 	struct hunk *hunk;
 	char ch;
-	struct child_process cp = CHILD_PROCESS_INIT;
 	int colored = !!s->colored.len, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
 	struct file_diff *file_diff = s->file_diff + idx;
@@ -1784,32 +1817,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		}
 	}
 
-	/* Any hunk to be used? */
-	for (i = 0; i < file_diff->hunk_nr; i++)
-		if (file_diff->hunk[i].use == USE_HUNK)
-			break;
-
-	if (i < file_diff->hunk_nr ||
-	    (!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
-		/* At least one hunk selected: apply */
-		strbuf_reset(&s->buf);
-		reassemble_patch(s, file_diff, 0, &s->buf);
-
-		discard_index(s->s.r->index);
-		if (s->mode->apply_for_checkout)
-			apply_for_checkout(s, &s->buf,
-					   s->mode->is_reverse);
-		else {
-			setup_child_process(s, &cp, "apply", NULL);
-			strvec_pushv(&cp.args, s->mode->apply_args);
-			if (pipe_command(&cp, s->buf.buf, s->buf.len,
-					 NULL, 0, NULL, 0))
-				error(_("'git apply' failed"));
-		}
-		if (repo_read_index(s->s.r) >= 0)
-			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
-						     1, NULL, NULL, NULL);
-	}
+	apply_patch(s, file_diff);
 
 	putchar('\n');
 	return patch_update_resp;
-- 
2.39.5 (Apple Git-154)

