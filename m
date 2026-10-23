Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761549;
	b=PAsDWTOI098nePvagUrWD+i1tlQWHQ/x8slPQc8nxIJJftrh47vF65bxKSnboBz7vnG1
	 uDKHgzcRZNPqIVq4nh4OYl/lwLw/1SxOy7hcFOzR2tUUtnPZwBcVwTaBt5ugbCEp9jrpj
	 kqcOy4U/L47/fekxTuyxK609gE0/kBF+h7IHqnrhWLBTJ49/YIs2KwJw5XOdvlHqqGyky
	 TK+9Awr4+xi3BmLQ2NO9G1LEag0jZhEJCYjeg+bHDLyBtyGFia0d92VXtNcc4c+mEifYV
	 Qt/P0tYbeE4Gm00nSoyG17D8bfzIecpDnRpwAvPpm9IwBJCgAxocB7JRZHdEATUPddg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=BuSHtg4WTo99SgFp7a6HpzTpSsKK5mO+bmqe+pQB/h4=;
	b=3y2JPBPzM9PASz3+Z4nnzgJqkPJ2Dqrh9TMRrw9HaHuuzwmsgUAiwtbtWM0HYvnYfSII
	 faiS/Q9exSgD5SxOL/cAvSJxYQbW1pWz9wz41EFaNqymqJ+uDfcWXvBs4pV/Pa8U9zclX
	 jnh8KExlENhA/E1jZDNpGGuNZpOplm7RGl79qt6F3zcJvjBMasKeqqOhGon0lcXvxy9bX
	 Epe+YGGuVTDoJngKCcnmOfoEVvFfOAZXEMVNKcegviB2ND6NY704tU9SJaI9+2DfU1me3
	 l/hnEc4ekg7tdig2Sgtm4sJ73byvtvOwJf058XNOnGofvluhhUGjISQnljifAlvm6/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YISVIA1P;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460C606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5460C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YISVIA1P
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6d68de53053so457452eaf.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792761548; x=1793366348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BuSHtg4WTo99SgFp7a6HpzTpSsKK5mO+bmqe+pQB/h4=;
        b=YISVIA1PoaqXtoOhAFUoF59ocgBfHgRWb7q3w5uF44fXPVmEAaX1C3Us4WISjr6TNg
         NXxErl0bYLCCxQgJ/qqawHfVlh98RSPD6MpbmdWnlz33Lp4JZq/p7jhbSqZfUXAUMriE
         PIB4jcBIADcbH1u9N3oeththDwxDmYt1wlYFVWoTgyzxjUp9aPGkj2D5EUvPe88QnNt9
         0ALzEIj4RRPyyEN9xg+FWo0CWLON/TihcnUxOyYORDfgQqZwxJvtLmL5ioVdUnRiwE3K
         XXwAvy+BpVnRHswa1jvAkFbvRYmX3iYrUJhfY2xG9NKo/WbMRbba0uyEWSCA5T5ycZ+V
         E7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792761548; x=1793366348;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BuSHtg4WTo99SgFp7a6HpzTpSsKK5mO+bmqe+pQB/h4=;
        b=Lb08o/VkVpwzMnFA6aw4ao9wTFaKlLDKVP1alCqTUwE+THqJhWeolo4lIy2t93aKW8
         8q634memoT0Ls5zvCM8Pl+FeAQ/fE7XsOjogFvvmTuO2m3jrrhFwACxC+2vnEovPgNTb
         QWzkwwtIjTUyVqn3SiaE80kjHvgORTHY5PDPtRNbE8/SKgJTt6sii4naZMK1mxDmrYjX
         xf3cBHgx1ig/FKGRw7loaaUPSfwIuD8nuFiOwdM8bvwVcTIGVtQjbzjmcISCsiMrvx2+
         OMD0z/NTIYsNCMHviVKdGJDtqZYOJo4pTH+KTtFqYqev+h/7X7HqkirO0k9FAZfzbPK/
         hQaA==
X-Gm-Message-State: AFq9FYLDLfYJGR3DFKOJQadZLXHqF0hZvSDBtOVE9kv8QkfMHmiBachr
	b/JvkyBcNxPUzzlG1puDXz7Vz218Uawh98a2qt79DkOc1SaGdOvgHg3ecaoSYyg6YAM=
X-Gm-Gg: AYBFou23Y5Y1T1IGaVdJYcycPbQh6/D/mfVxhRFCldLzU0fJCQtF6ASf4vZkeMPdaNL
	gnSC2pLF0SiCaEw3Dm+u9JaNUVR6jGPWdn8mdIDNLZMer1bdS1GmsDvJgJXIdQnsg5Sqj2O/oOG
	JyyVz+whGU6NwyIOZunP4TH+ltRP7rL5P8eNi3E417VSIZdDKTEF8/SuCZLYbXaCJ9zNzwhQ5oU
	d01/91bfjgf0fGNDlWTXVgmdMjeXJM3wgKvRYBqTgi3GqG+ew3fY/jtBLG6zSDtFdKogBknoaf/
	PtFkLxNWtPzuukiJTld7xMlrHlX2hYi7BnU18XhxhpH2SolOWdTfkIsCx7h49TZFSN0E5e8kj2N
	VByJKBy4YdJpqKIEA/Mpb0TJVfZp3FcXgPGqmjbRzzErgD7DeB89JAxXwxgUMFQAta6CC/3/F0x
	pjePacMatRoz0KJTk6zMS2cLWinN4euhXbtEJkrmvHRRv/b+qFjFEoq2PqfsaOMaQ63yWP3Zhio
	hHt+Bl8dzXDeM6tCcrIvypc4AGaDvJ6X2dexI8itBKwv5O/amlA71BaPSI5Dm4=
X-Received: by 2002:a05:6820:3515:20b0:6dd:3105:1f86 with SMTP id 006d021491bc7-70b88a62225mr897943eaf.62.1792761547979;
        Fri, 23 Oct 2026 06:19:07 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.204.232])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84fbe46f5besm2067658a34.19.2026.10.23.06.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:19:06 -0700 (PDT)
Message-Id: <53a5a1787acd97e0233ba48b46162089de6fcd3a.1792761542.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2272.v2.git.1792761542.gitgitgadget@gmail.com>
References: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
	<pull.2272.v2.git.1792761542.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 13:19:02 +0000
Subject: [PATCH v2 2/2] hook: accept .enabled and .parallel given without a
 value
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
    Patrick Steinhardt <ps@pks.im>,
    Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

hook.<name>.enabled and hook.<name>.parallel are booleans, and
git-config(1) documents a boolean without a value as true. But
hook_config_lookup_all() rejects every hook.<name>.<key> that has no
value, so "git -c hook.lint.parallel hook run pre-commit" fails with
"missing value for 'hook.lint.parallel'", and so does a bare
"parallel" under [hook "lint"]. The same happens with .enabled, for a
hook as well as for an event.

Keep rejecting a missing value for the other keys. For .enabled and
.parallel, pass it to git_parse_maybe_bool(), which takes it as true.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 hook.c          |  3 ++-
 t/t1800-hook.sh | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 5e756cb353..c500fec33e 100644
--- a/hook.c
+++ b/hook.c
@@ -184,7 +184,8 @@ static int hook_config_lookup_all(const char *key, const char *value,
 		return 0;
 	}
 
-	if (!value)
+	/* .enabled and .parallel are bools, where a missing value means true */
+	if (!value && strcmp(subkey, "enabled") && strcmp(subkey, "parallel"))
 		return config_error_nonbool(key);
 
 	/* Extract name, ensuring it is null-terminated. */
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 45b99a7f04..fca4cfc712 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -516,6 +516,17 @@ test_expect_success 'globally disabled hook can be re-enabled locally' '
 	test_cmp expected actual
 '
 
+test_expect_success 'hook.<friendly-name>.enabled without a value means true' '
+	test_config_global hook.global-hook.event "test-hook" &&
+	test_config_global hook.global-hook.command "echo \"global-hook ran\"" &&
+	test_config_global hook.global-hook.enabled false &&
+
+	echo "global-hook ran" >expected &&
+	git -c hook.global-hook.enabled \
+		hook run --allow-unknown-hook-name test-hook 2>actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'configured hooks run before hookdir hook' '
 	setup_hookdir &&
 	test_config hook.first.event "pre-commit" &&
@@ -1080,6 +1091,17 @@ test_expect_success 'hook.jobs=-1 resolves to online_cpus()' '
 	test_grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:$cpus\"" trace.txt
 '
 
+test_expect_success 'hook.<friendly-name>.parallel without a value means true' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "true" &&
+	test_config hook.jobs 2 &&
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-parallel.txt" \
+		git -c hook.hook-1.parallel \
+		hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	test_grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:2\"" trace-parallel.txt
+'
+
 test_expect_success 'hook.<event>.jobs=-1 resolves to online_cpus()' '
 	test_config hook.hook-1.event test-hook &&
 	test_config hook.hook-1.command "true" &&
-- 
gitgitgadget
