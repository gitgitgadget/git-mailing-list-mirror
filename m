Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7D30C37E
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567265; cv=none; b=R/s7MNQ6HFrIMZ79O2SOEqgaNGjGpOkM3dkAOROgnJEvFUxdKAT0i8o/8MLrhZAnFrqDmQmp7CsO0NHQ4m4DlGNy9uTasSNwukgd2FUsI3QGZQzO39qskxNrD0vNyQvORurDiim78JibTXHhwVS1dOfo/VosfQPtZNpPMQ7zhpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567265; c=relaxed/simple;
	bh=Zy/Ih0LzWihlFZaFnuoQlFfYkQXr4SKBv4sTEi9DlS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAljDd+yERF3OVHqytQeVbtMB1iWDSCyYtDH3nesE97/870O7mKBcu0JP0iJX/aBQln8WJ/YM3iuxbNfIYdB9ct2sX1PgHjhHYGtWahBdoFmmljGuXXzLiBlbtf51WZ0/mbIlBTCqSiakyK2eav6X7w13zgwv8yF+iOty8Si7eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GAEi4v56; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GAEi4v56"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-72e565bf2f0so787247b3.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567263; x=1761172063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=91bg4KYzzIw6QXO09k2RuPIO2/PG0j/b1+f8Vf8pzd4=;
        b=GAEi4v569JRmhIiQ7o0maw9X2Ah/qCtcxy0/RgEiTqoBr1f2ZJv5M5LNaG9f7Qnu3T
         IFC4BCGqLnMYDDMCJYhASr9i5X1Gh3YnOyXFQ18yhGjaL+pnDmDJfOAWZcIZopylW4no
         PIlxIqds2Kqpq2aPkfuxBXPBvRUcaCSH4wxkSHm552YcWY5yGWn/O40aBi2NFjFq+csm
         C+nTuU6nnLMzYq47JOK6bqsJX3oy0WqOu+v5VUnkYuu4QldRXqzO3LqgaSEHY4yqPYTH
         HgvWGPmm6pX0mKu7jo8XWaRNsNz4Q8tT4wPCN49ptgnL9ZbCHvf1pYzbI8h0d0vMTg6m
         7FJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567263; x=1761172063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91bg4KYzzIw6QXO09k2RuPIO2/PG0j/b1+f8Vf8pzd4=;
        b=H3UNUeThFlKZzJBZKC7Dxd6AwZDf3rECU+MDTrsdKcwokd2QQNDbtO7WBWfUAjYP9y
         8iIKakFz5yoG8F6KFoFd9R3SxsQXu0jvSBTIc5+ae23TnE3RCJr4F5jBwzXQc+IJYDXg
         INcm5l3cvivNinXVG2uYOXIAfWkOBWaybKXA6s9UTDlbZ9RyVIWt549zTWIkMWQRnkIB
         nZSTLrXMoerRdfCDiItZZDMQT+IISrJ0XrJU1b8LJWtkmJNEMqN8XvkogAGXbgXuYhq8
         8Ues5XIMDwF5mB+41aA334PkJX61MrG+H+CaYBCdiY7RHO7DJYoB9jgqPlHs7CMXeAsK
         iSAw==
X-Gm-Message-State: AOJu0YyqxsTA4vSHC/oydhgYVjyBvjWQK+n1zTrycqPCtMQjOg1cExf0
	ZZ1PxPUHU/I/FQbS2BxAtui5YjuW1B1F9IGxjMmQ7kb+236nMPlyav3VsQaQK06SlTGBj0p3Exg
	n5R1KO+RbRg==
X-Gm-Gg: ASbGncs4KFVLrzOlElYmM9nMps2jgewzqHCLouKj5+PKcyMxCMoQkiN/vbzPHAPC9Uo
	P4RHQ/t3cdDhaQnOYooc7uL90mowOtau2K+JDD+E8njn7JxqfeihtCaMkiktlaEfElda0NY4HKX
	0Jft//6pXfMrVNLx0gZyVpQfqrP17MfCkL22gO7tzoTDwW22WNh0LceGPnn8gjQ9b5/ooNqTTpm
	49wAtWB0DKsDUs1+k2th0Zhd1OagVe2tuZGhiooE71Xsk5VL+E/+oVoqEIY8dcNqfLa0vkRrv0T
	Rv2UbtjE03kUPr6roHZvVdGGB4nv8Q55L3AMp2G9GBR6BaQJWhUGMYC9Dp+VtimVp5fBKAozC3p
	kdvmJRdvsoGvqekf/+8F7H9LRKH0JhmK1nPD71Hay4ylZm6mzQU8p+AZeUAQGrgUCzLASYHWz46
	3+uOQUHyCKh0dJPYsAmNC9w3wAp4jEr3aqSP8RiIIPsqtgbEYrrOUXvj7NKZj+l74v/IhfrM4VM
	Sj78teWjOM2BeyhBQ==
X-Google-Smtp-Source: AGHT+IHmPulNnZTGQi76wr4K2wHooB87LVRPZbybrSPHiDEQ8yVRQFrrBXHJO9xP0sN0wqSXKdWCjA==
X-Received: by 2002:a05:690c:3381:b0:77f:b51f:6dd7 with SMTP id 00721157ae682-780e14490e1mr320577947b3.21.1760567262824;
        Wed, 15 Oct 2025 15:27:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cefffdd73sm4732984d50.7.2025.10.15.15.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 09/49] builtin/repack.c: avoid "the_hash_algo" in
 `finish_pack_objects_cmd()`
Message-ID: <cd43a60620979a8ce6a41ad78283be683b83e843.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

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
2.51.0.540.ga7423965ad8

