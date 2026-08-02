Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2077A26ED37
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785663081; cv=none; b=LkLrIzC16ay8dV1zfZK1JJ3OR/ZVALUesKZToTI7QqG/upBgP91c47aEGH2xE7zCI1eygmnAPFrUrKXM1jUA0CzG8e99E3L/b2Kc2K21yEXpxkF0KnOjAcBguBerBKwCL+utLwz60pnG8q9LLcSWQ3zUb49Re9yMFAC8tg8Q+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785663081; c=relaxed/simple;
	bh=CI4OKoSh1iWoPaOEhPqe9w5jYPHwoPlMQoAC6JJHwfs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EtdU1tAtn6pijRPN62xa0u8e/hMq9kCNWqQwuipvO4ZZLwJ7we4Mu/aSYwHEMZxLlht3JOwb482my8j0cRhRE9aRkYGmXkBeEPr1ZYOQRawQ4HtFrWgXKOTLbJOjPT7XAShDRG87NzkSW77BEKISxwdPYT8gdXW811+VFcngomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmJtS8yP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmJtS8yP"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383cb94f742so2362305a91.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785663079; x=1786267879; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cnnLcub7HtfOwutKjAfqo3ybXMfPN82ijdgS2xT4UKM=;
        b=qmJtS8yPVy2xpTPPg5Tpe1OLKF4TQn20kchP/k2VkkYmhsEWJ9igY9CBBh9ZQDq077
         3gAJkMtcmmBSGN2JE+J7FgFQWImVz0W5biOVLQFNPJLSWttcJDA6bJqxeiyINE79+7YT
         8OOjPkm/s45QpPVfGO9TsMDqpXHyZ0PY06OMvpfC/71ApVnx7JJQSCzlBRnKMnY8vIFc
         tKsRvwTgcipsRPDHHN1DSEm3tWNXs90x8ccdey6rr9F9J0sNIgpqn5ovWSPQblycrNsS
         yjUnvhOyxRDW+hXvtv3MEuBP6QTd6GzXxI5eEtTLn8yCwh7GI69mv4+Kw0plaoVijmGH
         vsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785663079; x=1786267879;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cnnLcub7HtfOwutKjAfqo3ybXMfPN82ijdgS2xT4UKM=;
        b=ePzjVc5lXL9Hvg72KbaaFCMvuk7zXjR0KLhYetoJ8eIpgouZXCoo0miYjjj9LuTZbJ
         RFBgzOdOxqZosf0BUGR5uZS3m6WkCJpOjaVodmGVIwwNHLO8VD/wxSZ0ho4g/6IwNJpx
         /OKzbnfccMJKOB9ysKFBSfQ0QfZbTgkz+bki6PYa/PV/10v6EH5qsJcruIwaszp6kLqk
         XXlUGsxNVn3EPT5o6ufQxXTZ13EKE7sbEjfpByAsxT3ANI39akB0PnBHn5wyQ0/OgeI6
         Olc70WR/WF+W00cGoDi15UVgxEnKUFa38CsnCSdhqLAbc74DSh7K0v8WjbbHXOl2Xv4S
         a5pA==
X-Gm-Message-State: AOJu0YwCvnS785+9KXooORjzifcjDAYkSB0u6on0iAvL9w3nvYFTVAqN
	l0ZkZaCRsPUh1LhYOvcOoq1KazyHT2PYzci6Sz4PdQyF/g6XKOvV0O3SqQNWKA==
X-Gm-Gg: AR+sD12u5zbgmlOQ/IYafCE0bgT6MxQ+p50tlPU09fB2dD8jnPxy/l72uAESVmPJtlX
	YDuOBs/2Og+r9M9xUNcfWUNsn3QL9OErsnCm5SfQ35CJuGt3TfAZgOhpz3AFJPK5+Xl6+2NnhM4
	v5/WZXnBkkWWpDwYcxif0BbyyjDtsqSCqNNYwfpZdEM7tGdIeswuz+FA0I7YMKxCvH379DXAcWR
	eAv9PXatvvApUUNLqPzZ9zt9ZYN6TifdQyEL9fnAuu+zpOD9ZgLIX8E3hD5R57xay968TgzA0Md
	sFkNi0tFoSVo5kprJBv9qk5XkAgsintzPZ17CyzKvIBAor7XvRDaomkgLehAjkuaPgycdli5JQ/
	EFJFtx94aRtM2eG3VFY3kR+BhMQLylIZO/Xk6klKdIrZqukW/trXTY9C8lXSSRho8pour1gw9py
	JyRR5pGWONd6+l7G9yVzdRN04fIb992k7mtwXus8wW5qVvlA9Z7e15DJlZzWCm/TaLnHtYVWYIy
	xwT
X-Received: by 2002:a17:90b:394a:b0:36a:c4b:76cf with SMTP id 98e67ed59e1d1-38fbc516f6emr5715487a91.23.1785663079421;
        Sun, 02 Aug 2026 02:31:19 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.167.113])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm20756429c88.6.2026.08.02.02.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 02:31:18 -0700 (PDT)
Message-Id: <b6ab87fd29ab744ce28bd86bc087bfc5956b8676.1785663075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
References: <pull.2335.v4.git.git.1785577445.gitgitgadget@gmail.com>
	<pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Aug 2026 09:31:14 +0000
Subject: [PATCH v5 1/2] bisect: let bisect_reset() optionally check out
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
index 3264e2da54..5393690f6b 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -234,7 +234,7 @@ static int write_terms(const char *bad, const char *good)
 	return res;
 }
 
-static int bisect_reset(const char *commit)
+static int bisect_reset(const char *commit, bool quiet)
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
@@ -1096,7 +1098,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	if (is_empty_or_missing_file(filename))
 		return error(_("cannot read file '%s' for replaying"), filename);
 
-	if (bisect_reset(NULL))
+	if (bisect_reset(NULL, false))
 		return BISECT_FAILED;
 
 	fp = fopen(filename, "r");
@@ -1345,7 +1347,7 @@ static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNU
 	if (argc > 1)
 		return error(_("'%s' requires either no argument or a commit"),
 			     "git bisect reset");
-	return bisect_reset(argc ? argv[0] : NULL);
+	return bisect_reset(argc ? argv[0] : NULL, false);
 }
 
 static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
-- 
gitgitgadget

