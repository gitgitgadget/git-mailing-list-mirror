Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6B319C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097270; cv=none; b=U+PWf4fww2htlAZzv4E2YGZGGwK8TSpEOK60U7etOm9olLOacf29JWOUgBR/zgbW1G4c7EgAkONGjc3AX9V52Thq/kcub+6tmFBLwYsQAoiJ6jMbTfXz+HqxADC4L+pwapy59kr0qshESJ/8qCoTiUS1uihv5WmHzqxE4phfWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097270; c=relaxed/simple;
	bh=vgR8O0kT1bv/V3MMIQ3nwmQ4CPXxRLwJB+E+Sm6GSUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+P23UsvZXyXK0A5jkG+DFtEIVtVPrVlvGvUkYSeg/na16EzaKYEHP3aRneEh7XKwWxnhkKxj0kJN1ueFg6FfJtDbAt8U0nzZiaqokQrW4kA9PeqaEsnsk97eVofbpsh8GRHqY/Eivnt0jO1ryLRKVU+Vh757EvlTePP4qMW5Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=dWZww0q4; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="dWZww0q4"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-72ce9790aceso39442587b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097267; x=1759702067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+WziGW7Oeen8mElyTt8H0ytI/B+D6mLPX8O6X2bA3o=;
        b=dWZww0q4Y+K/xklYxWVuiPVfkXnNJWwct37k1sahYsn2ebmWNLyyEoOnjaMIuulejM
         BeZdrLY6T4Xt0DB20VjbTY81+wD0Q0A0Dn0WeKBbLdattXkMk4qF9L2QVqtGVNPD2q5S
         MtvHxhTlBBEmYe3HgvxLQj4YLyrroSiiRLMVzeS74I9pidg3R1wstlSX7/t7ubADem2T
         IAoxB3SAZCFkpaVHIjWWV/2Gk7dLqdXZO/3wc+C9VC86gYoH6GkW91+Yax4Ewt7zFYK6
         38lu7vLweqczECdl2OvQvYa2s8h2/ZPaKtbGWYuIPs7A/d5c0q9Yt3YeZBmDJU0bbQtQ
         qSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097267; x=1759702067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+WziGW7Oeen8mElyTt8H0ytI/B+D6mLPX8O6X2bA3o=;
        b=GqTmKlsBTHdJMi3iLRVU66abySMmDxIymNy4QAUUA9TR937u3W3gAVCMimlD5QFN2F
         DAt7EOOAs10lwVXEW1i+Ab2ZIzzoQW7580MbVMUHV5w7xyTp3miwoNktXldxdo4/l/5e
         IkHR9UtKBpxAE5K1XetvCn5qt+njZfSa4Xdse3iY+vXy5sCBE16A0JkSEL025bf0p3G5
         1ziUIwxAjYWR8guIqEy2oY5i0F5w6RzvInmUytBFs17+ndqZ1JGzUPGwqx2OkOP1j3TY
         0dYrJOND5tg/cjethcUP4NNPpTKbi2Ax5YoGK+hLI9NZ6Ku9CZbyAvKBUvdHLEAo+eH5
         YyPQ==
X-Gm-Message-State: AOJu0Yx+Cqnd/sFyH5iWxD5Q84g09Z1K1QKWfftJJZaQPHu33m5TlTRj
	5RFdFSC05EDt4JEOwK779jIcAYYkHcF5Puvql5Rbw0d9kjZ9PhcNnfe/ru5hfO3HsFviNWImfIu
	1dsUhWAw=
X-Gm-Gg: ASbGnct1NVV6NXv8SFfER2i+C9dzHCN5wwFEmjjAwOzvjJY1o+GBgd0c8UaYBpNpk5l
	G4Ie3Pd87sq8AAERo39DAehaMZeR0BRfYU2Jt0DKPz4RFQdYpOjmnKU9QWLcCwwqjVC1K+Z39ug
	eKJKBF7ZFxXHpeRhphbgwnpRD2ShGnDvul1/CsJqPDibYqpZrejQ6GI05Kkng+sV2AzOQlZdSEP
	vxT8Vd6MIK1DQymJqs8QPHJ1TsuikPzHuknhgftdod3x/6PgtvysaphJHx4O1iU+F28zav10FJo
	qwu/yn29nycvmE9tEdP+aOr2O10IliBRGzSTzg4m+DFqVGSxvRIBLcPQiYZL755Olo19dLBmvrM
	vhYwC7aC1wxVHvhprV8AnF3t4zOvzaGiDF3FrZ2RP20PaQZnYtsrdRcps8J6YZ2W1aW1hSRahiq
	xCeZKTanxeHq7CVVBk/2e1KJgdi9q3CjWF9/3L
X-Google-Smtp-Source: AGHT+IHJEkKovMyF7muKqsyPbhi9p4tfO97YWnkqpUFi0n7prl5nvByxy2b58vxCRGshKdMQYeZKWw==
X-Received: by 2002:a05:690c:2702:b0:720:58fd:6433 with SMTP id 00721157ae682-76403423b94mr154259997b3.35.1759097267584;
        Sun, 28 Sep 2025 15:07:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-637d39f36a7sm912701d50.1.2025.09.28.15.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:47 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 09/49] builtin/repack.c: avoid "the_hash_algo" in
 `finish_pack_objects_cmd()`
Message-ID: <f16dfbf0c7fdb2ff9bbfa8f3cdbc849916a722bd.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

In a similar spirit as previous commits, avoid referring directly to
"the_hash_algo" in builtin/repack.c::finish_pack_objects_cmd() and
instead accept one as a parameter to the function.

Since this function has a number of callers throughout the builtin, the
diff is a little noisier than previous commits. However, each hunk is
limited to passing the hash_algo parameter from a repository pointer
that is already in scope.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a7e94ed03c..a043704aa8 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1073,7 +1073,8 @@ static void remove_redundant_bitmaps(struct string_list *include,
 	strbuf_release(&path);
 }
 
-static int finish_pack_objects_cmd(struct child_process *cmd,
+static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
+				   struct child_process *cmd,
 				   struct string_list *names,
 				   int local)
 {
@@ -1084,7 +1085,7 @@ static int finish_pack_objects_cmd(struct child_process *cmd,
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		struct string_list_item *item;
 
-		if (line.len != the_hash_algo->hexsz)
+		if (line.len != algop->hexsz)
 			die(_("repack: Expecting full hex object ID lines only "
 			      "from pack-objects."));
 		/*
@@ -1150,7 +1151,8 @@ static int write_filtered_pack(const struct pack_objects_args *args,
 		fprintf(in, "%s%s.pack\n", caret, item->string);
 	fclose(in);
 
-	return finish_pack_objects_cmd(&cmd, names, local);
+	return finish_pack_objects_cmd(existing->repo->hash_algo, &cmd, names,
+				       local);
 }
 
 static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
@@ -1247,7 +1249,8 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
 
-	return finish_pack_objects_cmd(&cmd, names, local);
+	return finish_pack_objects_cmd(existing->repo->hash_algo, &cmd, names,
+				       local);
 }
 
 static const char *find_pack_prefix(const char *packdir, const char *packtmp)
@@ -1534,7 +1537,7 @@ int cmd_repack(int argc,
 		fclose(in);
 	}
 
-	ret = finish_pack_objects_cmd(&cmd, &names, 1);
+	ret = finish_pack_objects_cmd(repo->hash_algo, &cmd, &names, 1);
 	if (ret)
 		goto cleanup;
 
-- 
2.51.0.243.g16eca91f2c0

