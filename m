Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A5E21CC7F
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281069; cv=none; b=Ihmiyc49apbuU/NMR9zwMcum1HErjMcYcDme3T7aqgcre9G1xAKrebFymuCWgTKP1pjHAF1ZfelXh+C7osDDM3sdN0s9DwzbPQ4GslPANMaosOnSeeMJcOND5pJEbAYYbJM64+pbOyhyQqCoU9cUokROwwMhNYVKaE9UhjEBD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281069; c=relaxed/simple;
	bh=0pDDq47W3uwLRWjkYMUX/euK07AuKPEscZ6SmNY5vCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/RbSBoAWmwSJJIUm8c/5qeQbZUmK0fuYjnMOVzzvhDrCbRl2nvsKnKXGPfkUIc5p3BCCijcSrLy1LlmuEh8N/rZZqI0mrlUanuxepPBbDkpjKS8KjS5sf1nDz9DzsP/rB+Y30K9LPRyrbJSkhRICSv3gu4EyooQfQCd6Lnnh5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+gy4SNz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+gy4SNz"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748d982e97cso63303b3a.1
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750281066; x=1750885866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGALmWArKARhFE75FvtsVKaPk4PWrqGe7Ns6JBPSwqA=;
        b=F+gy4SNzqddbBfWC0/VyLKpvjAUXE8+JCliZjMhXk9lVFqA6nZTUzLXQld/pFlCh3l
         dNeoumU1JoCtzLG8GAiQzN2UAdy5iCegvGIf0sDHVhmSnxG1TG/20CAOTgmVG3w0JsJD
         x5d4DsFJXxtAW9d3YWuvYbw+BjGh4uu1oSEiPJtKSvk0ITaFV/a177qB/pUeC2WvKV3I
         cgspFnitg3XneAQI/zvqVSKPC3O/bqItIoh8sZ/coRgyemtdeomzV+NUt0/R/JisXCRQ
         WMXit8RbZ7RyGO9NNrsl8RfusCHHXVub1hcK4OUaoBG0dnlmEvObLKW4dA0F5FshBboT
         u0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750281066; x=1750885866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGALmWArKARhFE75FvtsVKaPk4PWrqGe7Ns6JBPSwqA=;
        b=fHC6dmpuoLW6rQOSGWGsmmiRxTiYJ3YRkHmvm6Hy77ItKyA3givuumSP18bw4vTkno
         Y7vXJcI6bQpDG5mj5dBY800cvtonUxbv1AWoKTs6citK15JqdIYtAHNlwZlrVwPuTzpz
         70+84bALDf5JoylJLaKW6B49RueCR2wkwEVWhc0Wm9V9QkDaPTMTRMPMf/VBAMIx5vFV
         LirKtfzhWkhSxanWvAI0SHv/5gF4QD4ng88NeUt66CrlcMEOQSiTyOtletzI2y/pUt6K
         OsPRJCe2ldYGlA7jLF2xlfWBIWT1PQ2FCdm/y47WAF1eZWkCtVDcY1F5hklvpbzos994
         1+9g==
X-Gm-Message-State: AOJu0Yzj8SQCKxPFfOhPFJCsYnWlQ4vjzTPLP9bE8rY5K/YzO1haSG1r
	gF0cyMZFd/KR8pRM7LnkTWDPqgAQmUHFElwqJpertI46oF7+eUVwCzy+Q3hbIA==
X-Gm-Gg: ASbGncsjwWY6wuWqi8AdnPVAKKxAPVQrlv5bXwrUXkgpeLtET3CNt2MxnaN2eg7AJ8U
	A650JUJikg/7SGi3foq5fkYfJgj/AKyM5skaLxxD3fPmnbZ06q2XHzQDJnpKuOt2yjywVrJJrw1
	taZneY8zctgGco5ENraWmHcHLB/IrJhE9+wXOmFqC7J/ZDyM0MwS8H8SC8qBnwGpWzDgmMq/KQo
	fsoWLrtioPdbZUeRdsnTFn+x+M1PMAjP17PK5wqwdfmoPfQUP6i+uIkISSekoc1p8qdzDY3Nk1U
	kKTrF1d1RvB/W/rP3tU+p5v8F+Ioe/1KNEzrEVsXMfG1+jjERbBA6jtVD3M=
X-Google-Smtp-Source: AGHT+IGBPRe9/EX9ntRLn0f71kNw5BvCdcTlJu0/QOukmKVi5meiIBGr2MLOVWw6jykJMzHoTf5emw==
X-Received: by 2002:a05:6a21:3399:b0:21f:829a:e242 with SMTP id adf61e73a8af0-21fbd28b891mr31814079637.0.1750281065763;
        Wed, 18 Jun 2025 14:11:05 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680448sm9696731a12.45.2025.06.18.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 14:11:05 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: git@vger.kernel.org
Cc: Phil Hord <phil.hord@gmail.com>
Subject: [RFC PATCH 1/2] fetch-prune: optimize dangling-ref reporting
Date: Wed, 18 Jun 2025 14:08:39 -0700
Message-ID: <20250618211024.2332525-2-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.1.gf2ab606906.dirty
In-Reply-To: <20250618211024.2332525-1-phil.hord@gmail.com>
References: <20250618211024.2332525-1-phil.hord@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Hord <phil.hord@gmail.com>

When pruning during `git fetch` we check each pruned ref against the
ref_store one at a time to decide whether to report it as dangling.
This causes every local ref to be scanned for each ref being pruned.

If there are N refs in the repo and M refs being pruned, this code is
O(M*N). However, `git remote prune` uses a very similar function that
is only O(N*log(M)).

Remove the wasteful ref scanning for each pruned ref and use the faster
version already available in refs_warn_dangling_symrefs.

In a repo with 126,000 refs, where I was pruning 28,000 refs, this
code made about 3.6 billion calls to strcmp and consumed 410 seconds
of CPU. (Invariably in that time, my remote would timeout and the
fetch would fail anyway.)

After this change, the same operation completes in under 4 seconds.

I considered further optimizing this function to be O(N), but this
requires ref_store iterators to be sorted, too. I found some suggestions
that this is always the case, but I'm not certain it is.

The current speedup is enough for our needs at the moment.

This change causes a reordering of the output for any reported dangling
refs. Previously they would be reported inline with the "fetch: prune"
messages.  Now they will be reported after all the original prune
messages are complete.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 builtin/fetch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 40a0e8d24434..11ce51da780a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1383,10 +1383,14 @@ static int prune_refs(struct display_state *display_state,
 	int result = 0;
 	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
 	struct strbuf err = STRBUF_INIT;
+	struct string_list refnames = STRING_LIST_INIT_NODUP;
 	const char *dangling_msg = dry_run
 		? _("   (%s will become dangling)")
 		: _("   (%s has become dangling)");
 
+	for (ref = stale_refs; ref; ref = ref->next)
+		string_list_append(&refnames, ref->name);
+
 	if (!dry_run) {
 		if (transaction) {
 			for (ref = stale_refs; ref; ref = ref->next) {
@@ -1396,15 +1400,9 @@ static int prune_refs(struct display_state *display_state,
 					goto cleanup;
 			}
 		} else {
-			struct string_list refnames = STRING_LIST_INIT_NODUP;
-
-			for (ref = stale_refs; ref; ref = ref->next)
-				string_list_append(&refnames, ref->name);
-
 			result = refs_delete_refs(get_main_ref_store(the_repository),
 						  "fetch: prune", &refnames,
 						  0);
-			string_list_clear(&refnames, 0);
 		}
 	}
 
@@ -1416,12 +1414,14 @@ static int prune_refs(struct display_state *display_state,
 					   _("(none)"), ref->name,
 					   &ref->new_oid, &ref->old_oid,
 					   summary_width);
-			refs_warn_dangling_symref(get_main_ref_store(the_repository),
-						  stderr, dangling_msg, ref->name);
 		}
+		string_list_sort(&refnames);
+		refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
+					   stderr, dangling_msg, &refnames);
 	}
 
 cleanup:
+	string_list_clear(&refnames, 0);
 	strbuf_release(&err);
 	free_refs(stale_refs);
 	return result;
-- 
2.50.0.1.gf2ab606906.dirty

