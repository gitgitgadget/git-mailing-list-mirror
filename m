Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF1386C2C
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180165; cv=none; b=qShxXbFjpnZAL3xcRs/dDWnkWSjm4FmMuL/mKaOR7srROWjpyaiuuk3qbYLdMy+YrEwBQwUVP5RFlErk7MKKmxTYwdJCKjnnsZeX1huEj0zJdgzH14ccXc/dLiQuZXLPlNQ5GVj6IG3IutYddIq3eS6UpD/AyVVaUBIm4Joo5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180165; c=relaxed/simple;
	bh=Wp565g0K3EpTPpJgj6hd5W2+WZMKJVVHJcCVIOCiQno=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CBK0xTHN7p63x7At14ECA4pYvQwlS2aCaANH2ZTy2lgHtaxWnagh0TaNdW0BI7ws7g4z+3HFWsyZWSObCgOUc+JFjb5GUJwn0t39CHyaZIG9YTEhlZD1n9ya0IKUA4P1MHVOz5ryx+FNt0Kom6FB8aJEioBemN6konAVm15Chlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emFgeBNi; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emFgeBNi"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92edb12cdf2so185224385a.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 22:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784180163; x=1784784963; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=usIVp1Fv6LSY793WCYZnUqWb6edzyCO1wZ0vD0cVZ6I=;
        b=emFgeBNihy8RRm26vsNBz3LSSfXtVYZTb24Me8a2kRLRzoNH+xA0bk7PUVFEYv3oOC
         9UQrT+OvhzhNnwA9MmB4g5de4jn8PL8GLz6MICKTzKgsdsaU0YhM46tRpq+zWH7lUn8J
         ihrl0gj/uUi1yPANj7L64kEOgIViF9bpgt65FEsHq88m+GOV8h1yuD76TnwdTrENXraS
         h9O4wTKkGqUByhxiZ3ng9wYpB3XXqYxo8ckdPd1v1XLtIc5tlXV10yIJ5QJ3tAfkLccA
         fErhFdVpcpos+UK9Ez4+TNzGn07D3L/nfQrq+8wl6mRGEtFGiEUyQ7S/edwjcna1Gz00
         gFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784180163; x=1784784963;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=usIVp1Fv6LSY793WCYZnUqWb6edzyCO1wZ0vD0cVZ6I=;
        b=SXO58xHwXrFzPn9BmY19TdvY6Fj95m3ZOKOYveKTTkheS1zv7/KwFC3zJu0mkzm1OX
         NShnFwLSH8z7fe90bDDooFNEHsT9FoptpRYpDeGQobkViEKRXx+bYpiMJ57lsMWbQvS0
         yeRjDqQXCfNbm+yXMomeuZQhoBE0i5JVyaqMAa4JYWS4RalvHHqW/zHyPgb5pVNlUzei
         GXVgQ0v6gRmvEfyl4XenozamFPeiU8pCkhA5LbrhnDFvWYr0ptjG093YxIuPLDDR95TY
         65zS9VyTc296LMW+PYChq7t7TNL0y1INdlNUUrm6H6XBkiuOPKv179UE128yjI/y6oG5
         R7KQ==
X-Gm-Message-State: AOJu0Yz86Hrm5g0DRkkw8krxZpdduqbJ/WfC+JZBK8GAD+h4gkNvNspt
	u0kfzzsk31LbdVebt3k34V21GAI3lobTMMlxL30R9X7SmC1OlWBJ4HZ2xUptIi7b
X-Gm-Gg: AfdE7cnjUhQfhQq8c7+zuhO1SO5vn49mdP3kPWKfxBNyNS12Og0kr1rTI0qBKjjmq2e
	en83LACeJl8P1Jj3Tii30s28uU4RZ2JBJrqaMFMYH1j4N92l5bipetMXmcvtYS+NsX45CGDvjVZ
	EERwiy4lEcfeh+HdfAdcGiXfmIMwbAMaKfQb+UG7iqtHhU4NzIggta8e9xaKvdBKVMo/c1Pchom
	Un2FFSzTIomhMDPjX2T1EgyuYcyaUlgrxUH3FLrhRJhlKnFpaU9A3Uc6VEFrXDXwvSrVri0jYQ2
	i5RUWTpzkXlPGZkI2YZ+bYzZRZ5jVkl0SsHx/2JiN4FmHL7+VwfrcLXZK3EGO1c1EDIBIv8edlq
	RtzAvO13nsMfArWrVqXvrrSxCTbcfcMQFUdemo8RnbT6HGA4HZ0ghYxiJkztC7cuDWVJeH6RJUR
	ZdKqXbXnuXEzYf
X-Received: by 2002:a05:620a:2889:b0:915:f96b:8f5a with SMTP id af79cd13be357-92ef2c3faf8mr1866027585a.36.1784180163261;
        Wed, 15 Jul 2026 22:36:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.199.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61facsm1912276185a.42.2026.07.15.22.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:36:02 -0700 (PDT)
Message-Id: <a7670baafc01a8a016486f634f59a3193560e2bb.1784180159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 05:35:58 +0000
Subject: [PATCH 2/3] bisect: let bisect_reset() optionally check out quietly
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

