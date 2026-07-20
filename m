Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB673D330C
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538625; cv=none; b=kKAL9XVVnXKwfVuW100Ld6ZT1JH19jse3zX+3+oCFvk/qvnli9JYR5rpS4Zg2M1py5EpC7vWZU+5ou7Xrvk9jLc6xq4q+baJljawOEzT8ZGW3RI99ciXkE2s8d3BrnLKnAY5F5wQE3B1DJWLM3Y4Zak4QVr5++hgOXvfUYwg1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538625; c=relaxed/simple;
	bh=MGZRXhC7L0sse2UoGYqplTSmKzbRfJbn7U3v3DjoEuQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gWERnU+5CXUAqLuSeSWMzqQPiNV0lZ/ZG70FwkbkAJmjE3d39Do++I8seVq1fn5vbMLnsbd/QQWRUSO93aYhH1MOYHO3c+N8tTIKIm4WGJ9YwKzcjT46HECKPrAJR5A66v859qiH9BcjmIdhfvQA4aaJdWahFQ+JVQmYwgbpt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsVXqkO6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsVXqkO6"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e7c6ec9dbso503626185a.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 02:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784538623; x=1785143423; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=paN8ieCIxsz2jUbc+/EnC8ZR0EAkhi6D1IW6Ai5Fsxs=;
        b=WsVXqkO6yX12tZlGEH8TUO94JUophHdzHC1Q36jcPW91LpOUrvDx9ErtjsqqAJ4/FN
         hF4tLCs528jgtUQJlBr/PkzpUnijomY60bVtwhy+hSzBMuhKCL6i3T+obd6PC1SKrmjJ
         iRk23IHj0lm6i7fSaPYjXsCQ+gvz/tPMKGMxfOLchYIwpEr0B827g792nrxld419Ddoo
         NauM9ns7kBQYd8LTdT0mPlEeYb21rgIfAKEA1Q9oWo18/wA+HZzfClqb4QcM8iTAyCp2
         D1ME5tyj2cJm/Q/blq7ZpGfGm2ceAdUlUBQglx0EOwwOMq6W+RYRoV5YePCRDK6tuyO7
         TnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538623; x=1785143423;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=paN8ieCIxsz2jUbc+/EnC8ZR0EAkhi6D1IW6Ai5Fsxs=;
        b=QIwoWc4sgEiEnGL40yZ9qASgb0SVJ0iHzC/biLGAYw1/0hfhWHiUxdGD09X9Dryio9
         Gyo+TLH5+1n8xwVSAiP7reQRoGbcMzbSFQ5OHRcHwxPiuz/rH6QVoKMfLr6umSkvhOPN
         N4l8xMmLT4TaluxZc9O/EwDLz/gsyZF+E3p9uRJ60lMRHZkgqvZ+cu0RMSK1PuKL1WVR
         jDOy+JUj1oTjIH0iCiQ6cezWA6UbApKXulx2JbwgK1NBRH3PRDofFR0pNRXu2d/hvJvM
         XvwrnXTCfF8JGs1zBfR36iCRnjKo0lLeF1zH37s7R5iSxigcZq6v/mCJEqZ2ytxACA2Z
         /mYA==
X-Gm-Message-State: AOJu0Yz/vWc+tH7ns2zUfCQI90a/yUOFrz3Aho5c+fb4u0Rxshs6aCFc
	Lu1PNT0bOoKcygh6qijWNgAkR2dv2e1LdsV2+FvX/Q07CLXOb/4dVyFbyh8FeA==
X-Gm-Gg: AfdE7cmnY0N2JFiWLuXSAc/H3VqhVTfDLWzeB+D6KGGN+X8lBAJW16XI+jz1jkBz4J6
	60yzNYJQbHdAEYJEhL6b5MdVkgigCXcyrenNlrYBwkbMGuWz03IN5GDtUkaLKcTll7drV0ZJyJF
	Dtv1AsCCl9F2ZEHjfYqIm7WQcS1zhhTow2mh4XZwH3qfqI7FnN49djXIUWHSls866V+SfkT1xVb
	4uj6pWO5mgh7V/9Jieau+b2TS5LN40oJuI0EACPfPQwzEQtC+F3jxlOaVN4fPHsYuH2zTN9uzCs
	JNQa3wU+k9uuhhyltKMRSUE7+BirFh4Xbd6OBGWsfz2N6N90UstWe+ejesP3+tylcpPcmoN48vo
	IuRxxog1uYaDvKz870Fl2Cd0lFQDcleHjPhILwRIzWsAXOa1AkKbBB2uMxBBj83teROjTkuuR6g
	Vm7ET6
X-Received: by 2002:a05:620a:2548:b0:92e:e2f4:e652 with SMTP id af79cd13be357-930b3e8c290mr1353026185a.16.1784538622610;
        Mon, 20 Jul 2026 02:10:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.23.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52df3f9sm844060885a.8.2026.07.20.02.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:10:21 -0700 (PDT)
Message-Id: <59920c51ae813f1ca0e95746c88b8b9017252c10.1784538619.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
References: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
	<pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 09:10:18 +0000
Subject: [PATCH v3 1/2] bisect: let bisect_reset() optionally check out
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
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
index 798e28f501..0e49ca23ae 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -234,7 +234,7 @@ static int write_terms(const char *bad, const char *good)
 	return res;
 }
 
-static int bisect_reset(const char *commit)
+static int bisect_reset(const char *commit, int quiet)
 {
 	struct strbuf branch = STRBUF_INIT;
 
@@ -255,8 +255,10 @@ static int bisect_reset(const char *commit)
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
@@ -1089,7 +1091,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	if (is_empty_or_missing_file(filename))
 		return error(_("cannot read file '%s' for replaying"), filename);
 
-	if (bisect_reset(NULL))
+	if (bisect_reset(NULL, 0))
 		return BISECT_FAILED;
 
 	fp = fopen(filename, "r");
@@ -1338,7 +1340,7 @@ static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNU
 	if (argc > 1)
 		return error(_("'%s' requires either no argument or a commit"),
 			     "git bisect reset");
-	return bisect_reset(argc ? argv[0] : NULL);
+	return bisect_reset(argc ? argv[0] : NULL, 0);
 }
 
 static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
-- 
gitgitgadget

