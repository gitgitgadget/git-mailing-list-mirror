Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33F37F72C
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312864; cv=none; b=Q/xYelwvOQ/NFB6qa1ydXR7u68tCjs3K0fn6SAG4N2y8ZMneIlN4fDbmqMTMNyUQK31MC4udMnRJSGgDGW9Heh1K5HExb3RG+N7S2YqbXZCts+yXNQvCKri9Vc2FmOSvMNdz7L180VoPJr1HH5QmjoSI6i+p+Gswqu5cnZ2Y0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312864; c=relaxed/simple;
	bh=Wp565g0K3EpTPpJgj6hd5W2+WZMKJVVHJcCVIOCiQno=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GxUH91itjtppCvB0GTpM4ZgWMga/6NCc9F+ZqHIrXhgo4zHKx3FDMJzvMXK2OWG/jKpGDN1JC9osnvWTOOhaeUdD8w6iBq0Ju9eRu5h0FinPyNDEyKVYy6A/xxA0sh8dDeT9ODLKyab9Cue3k2ImOFQYjTkWf9bIElsKIEQ79OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asDQZr7c; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asDQZr7c"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e85499ffbso379268785a.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 11:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784312859; x=1784917659; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=usIVp1Fv6LSY793WCYZnUqWb6edzyCO1wZ0vD0cVZ6I=;
        b=asDQZr7crlRNmSw4pVl6KVMHNwZ/04Sycij9MUpeBcC7NgJS9DP3r6QB2IaeqtRVtf
         fRIeO3A71HYXG0L4HsU1rvl0/OhwcI/oHDnEr9l3XnW/1o0GqMoJalcY+th15pQZDe91
         8cHQRgVam+TifmLcfvUH96+rcFOHiXJk1MkAK0ajjkKXgpoXXNWUecSSAYrckEe7iwRU
         swB7z7Me9sQT1+DJFS2wM97KaPETKMtU1SBPqgbP45N6+McRyoN/JAaqXzI/A1l0xj1G
         SK5WIqoYbcCVyRnz9WwUdty2QyUQ33vRZ1ej1QfNPV+8KsQ8u87lcuGha4wBCTjqV0f/
         Efrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784312859; x=1784917659;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=usIVp1Fv6LSY793WCYZnUqWb6edzyCO1wZ0vD0cVZ6I=;
        b=ABShdFjD3e5FFit1uVRaz1WjX2iRH85+axh3cSnfijeZ+EJZw2NzDbetP4jMilvS9Z
         0sV1Npc9PyZqGFiBxXpur/9156VP6XP8vUdqKq+2nM9LopmKJxTyj4n+/gxIn7amZaB6
         0c8j6wIIFxkO4ojzbEUZ5JKWYCHQ56P/3lvrvpv27Uey2Yumqq5m2JCLnn96W1Xm9f2u
         Bs19Kv++DdiEEPZe6rbDtpzPeWcZXhW/JgAyy53HSoXrfB3IQ9wB/hhHMboKUnANlypT
         Vg1C4HcRO+yj8E/rFsvTgzAyWNsgZk2plROaNS4SuiWm68AuhgTjmEtObEuCu98yKPen
         sEFw==
X-Gm-Message-State: AOJu0YwgdvvD7xi5DQN+08JwG9c7nrLc+cssbd9+6KdsVD1ia2N6KFMC
	S/g8HQGpZpSQlYHdSwlVUgfwEPm8rCFsxeLvYl9GTW2CcDnVtWNjui5ojs66xE6Q
X-Gm-Gg: AfdE7cl2jLqBIyfcXXuChZbX7ZntWFl6pL+aW0csu4qTHjEkvKpzV6w/UX/wWCg4YOI
	PIyNDk4ZmAqWNfINXcN7nhfe20leRge/ffDDlKgCqlQF5KOuXWm3P5DMO9/sKvkZ+9Ip4dUvT5H
	NbCmmQi1LslFh8Tzy08J2/kqW+tO722wx5+DJr7l3n+zmjg2FfMubKwcXMRVaRj9O4I2QV5AYdS
	sO9raQ3LrFFNiOUJ2GjZmqPlAyL6PcXoBo+vJvRqGrFpMWFdxxz5VUM73NdnP08EV0V8j/fmU6D
	MTaL35eAqwNQmoSs0y2/ipY8rLKLZMI2rLmWRWvqp5hIa9wUfacXOaeiuAf3Z71imB8gUEH4JTT
	qjqRLbNTfwaiHBz467fWtoIBEBuBxs7zRl9nUAHoUg1+xjkgNdC7KdgtVdzpf6IlmxbBbmsaDyk
	nHcxZyvQ==
X-Received: by 2002:a05:620a:172b:b0:91f:3793:d90 with SMTP id af79cd13be357-930b3e6f656mr394925285a.10.1784312859250;
        Fri, 17 Jul 2026 11:27:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.156.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52e02desm219007985a.10.2026.07.17.11.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:27:38 -0700 (PDT)
Message-Id: <8a2dcdf305437fc71b85d9dcb00600b68a39631d.1784312854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
	<pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Jul 2026 18:27:33 +0000
Subject: [PATCH v2 2/3] bisect: let bisect_reset() optionally check out
 quietly
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a "quiet" parameter to bisect_reset() that passes "--quiet" to the
checkout restoring the original HEAD, suppressing its progress and
branch-status output.

No caller sets the flag yet, so behavior is unchanged.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/bisect.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 69ea14b1b6..27d30b549e 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -230,7 +230,7 @@ static int write_terms(const char *bad, const char *good)
 	return res;
 }
 
-static int bisect_reset(const char *commit)
+static int bisect_reset(const char *commit, int quiet)
 {
 	struct strbuf branch = STRBUF_INIT;
 
@@ -251,8 +251,10 @@ static int bisect_reset(const char *commit)
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
-		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees",
-				branch.buf, "--", NULL);
+		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees", NULL);
+		if (quiet)
+			strvec_push(&cmd.args, "--quiet");
+		strvec_pushl(&cmd.args, branch.buf, "--", NULL);
 		if (run_command(&cmd)) {
 			error(_("could not check out original"
 				" HEAD '%s'. Try 'git bisect"
@@ -1085,7 +1087,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	if (is_empty_or_missing_file(filename))
 		return error(_("cannot read file '%s' for replaying"), filename);
 
-	if (bisect_reset(NULL))
+	if (bisect_reset(NULL, 0))
 		return BISECT_FAILED;
 
 	fp = fopen(filename, "r");
@@ -1334,7 +1336,7 @@ static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNU
 	if (argc > 1)
 		return error(_("'%s' requires either no argument or a commit"),
 			     "git bisect reset");
-	return bisect_reset(argc ? argv[0] : NULL);
+	return bisect_reset(argc ? argv[0] : NULL, 0);
 }
 
 static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
-- 
gitgitgadget

