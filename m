Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521334;
	b=YuVcL7EOXpmdse0DLkvee4pr7FcHck4a9hiIPyr8Zg8VzLN9mJt/NOZ6zFQ6oywevKVX
	 SDJqjGSo2eDTBmJl+W7kusA43i19QtvVY1zJx5SaDhpSYvQEnTpwWhifV6ZDqtnHyRak5
	 QYwNl+eA+blVprYTXk8kJSBgPACKhl9VHEgHm8tREbDGGsIcisOPxhNYPnzHDhJMG9e7Y
	 Ywpi/JSz/2K4YVygewVfgE5mr00ByexBR8/yxNOMdbzWhtW7W33jFWR8PCN93gTIGguOL
	 Y9VOTKsG48VljMQHJSOYpDFsVjIjC2aEPUbVMHLbzGYOdUqJt9m2jHs4KadVQDsLFeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=EpgRhqVPgFSAQgq7JmHdPOOaKVEQ2dIITA70BG8reTo=;
	b=1BEcq1sDHifCN2pKHT4MWb+PpVLeWNqbA92Dpm8Grxix5G+Z7lPYseT/ocMVbS/lFl1v
	 qClbf5HVPMJWiPMg23xAh3tT94O+fQ3vLT59A3veAT641vXG/k+bF1zN09vWJjenrSwkp
	 EBQ/3NUZTmUXlmsSKVfeZwGbT2HYS2aMENRdcRjGa7zISP1xIBAA5G7C02ehNhyjERlgW
	 oYR7Vt5Hu9jpzzU0rccZ3cTKFoJC0EPfVg/5bDoiPVvN7lT348jrSLU4443774BlenfhK
	 y+022ROzDHUkEeh/lwdLJPKdxYRLdhJ/eA1kEotJOXphnGNmMgTC+DiO2BLEPAx3yaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTAiMJUE;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1B606A325
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96A1B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTAiMJUE
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3282db206d3so2537692eec.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521334; x=1794126134; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EpgRhqVPgFSAQgq7JmHdPOOaKVEQ2dIITA70BG8reTo=;
        b=hTAiMJUEvcHd0BokPXYCBWm+aas/NkJ35QojqcG5/kLGy2D4k7OOtwW47bV39f8phH
         vr8/WptE0O255UrRHWAJnSQdYdTeJHFZc1kFNKg8VQrwUMsZvFQQeS56jglGKQVkufvu
         Fst7kI88oL1aIWr/kgu5PZPgZeo1aZ+pK+ZWExscXuGtiiEz0NQwryg2LSFvavHjiuih
         YKfOi2swi/b4gMv3Rn1/QtvwW47KvMplvIwVUgSeviZsW8D9z4tUpXMo6fjg7xNFC2sk
         JpjJ63KfWEDRyJH0ouqMDKK3y/7747XmCqGXrWDCQohPms/zAe+/uhV0v/n+pUB+JcdS
         m6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521334; x=1794126134;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EpgRhqVPgFSAQgq7JmHdPOOaKVEQ2dIITA70BG8reTo=;
        b=QvxnMfFPN9qd+47YYegc+LbI2P9WDdALepqGOBetxlzw0ol1zl4nnKxRNyagVdOKkJ
         lozUF5Ic6dxQDs9rdYFkkzAtw4i9Z1wTPvBOO3f464ji6lIqunqv6GgC/Lw2BVJiTZ1i
         TKq75IjBVNd+fms1u3BNIEj/r2oZQmQScxqGsV9VnO523lYkzXzidv7XEdM6LzxhU+JN
         rkrMufpbaQ4MN+Qc7Svk1RRdkLEjUD/53+8btc/Af4wGjraxJHrdPPS+0HiBqYSC8CtO
         J5605tRde21sJjOUJ6B6eNiAvh0lAVoTkTPXaT1GCY/o0CFrJZtsYOdJKX+jmBjk0Igq
         HsVQ==
X-Gm-Message-State: APuU4Z/Z0tf71ft0XVwvixQTQAhO3IpCktJOexq2XLIZlYqBLyqqJ2Jf
	fMARj6F48fiItENRYg5yZkY3CuAnbpDXe+uJdix1SOXwjC9FnVOokt8R7bf3Icql
X-Gm-Gg: AYBFou3Tom8k5LVVSCm5k5sxOw9hTogW2qXDSJL6ZTYn9iN+QwQBil0VdUQIcd4dFIU
	agNAroPNDodsUJyOJ2Sq/tdUYXHp3d9ladKKnJvabSbHuI3K/6EHMLs3yi9FAmCtjwUU7ceS+DM
	lHvZCeIAem68mZGRKDOLgRRzup3HS+Qi2avvOblyPJcDSK0PqLl65ZM/bVRRG7tHYTW6Hg6m3Qk
	kGOlLG9NTsQ5ymUseAbGr1mHabW56BAESYOkeSRsGsfOsAhNyV/9Hu75fIqcJlNn5rr3xiIYg0W
	vxTGAlRgAPwdOD2VvnHcjSb1ZXIn7McXtrJjGCL2N8ONpDyj5h9wFDypeLDHbk55Iv1xWZ2BVQw
	aIDCI9soRhpoOyYLd3r26av8GLg5ZVLMUOQILmJwTT00hf6BiiWmsXoLucXPygbNUhWzgxOeZPs
	Wk8DtNfHqfoBl8CpX59zL4+rJIIZ8tj1GtNCeKBXYkIUaUHQmZUt6rUibImPfp0cJtCX5S6OJAG
	vGeHgeqb1AgIzmWAkWfE+BvUKdJiCP3VD+/jLzEGzY7BlBCklUYaGgZgGcA8mlbE5BGbQ2n/9S7
	24Z6gV250abJlmWfFYzSIMqIAWmRZ7w=
X-Received: by 2002:a05:7301:619b:10b0:36a:1d6f:917c with SMTP id 5a478bee46e88-36a423c3380mr11489796eec.22.1793521333630;
        Sun, 01 Nov 2026 01:22:13 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.197.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42952e1csm26851942eec.20.2026.11.01.01.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:22:13 -0700 (PDT)
Message-Id: <e728b4ed0d7e9f72f88969bed9c4fc1f8ceec836.1793521331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v6.git.git.1793521331.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v6.git.git.1793521331.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 08:22:08 +0000
Subject: [PATCH v6 1/4] branch: move the deleteMerged opt-out check into a
 helper
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A later commit adds "git branch --delete-integrated", which deletes
branches whose tips are not reachable from their upstream. Those must
honor branch.<name>.deleteMerged=false as well. Move the check into a
helper so it can be used in both places.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..171b13b081 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -824,6 +824,23 @@ static int branch_pushes_to_upstream(struct branch *branch,
 	return ret;
 }
 
+static bool branch_opted_out(struct strbuf *key, const char *branch_name,
+			     unsigned int flags)
+{
+	int opt_out;
+
+	strbuf_reset(key);
+	strbuf_addf(key, "branch.%s.deletemerged", branch_name);
+	if (repo_config_get_bool(the_repository, key->buf, &opt_out) ||
+	    opt_out)
+		return false;
+	if (!(flags & DELETE_BRANCH_QUIET))
+		fprintf(stderr,
+			_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+			branch_name, branch_name);
+	return true;
+}
+
 static int delete_merged_branches(const struct strvec *upstreams,
 				 const char **argv, unsigned int flags)
 {
@@ -852,7 +869,6 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
-		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
 			BUG("filter returned non-branch ref '%s'", branch_refname);
@@ -870,18 +886,8 @@ static int delete_merged_branches(const struct strvec *upstreams,
 					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
 			continue;
 
-		strbuf_reset(&key);
-		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
-		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
-		    !opt_out) {
-			if (!(flags & DELETE_BRANCH_QUIET))
-				fprintf(stderr,
-					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
-					branch_name, branch_name);
-			continue;
-		}
-
-		strset_add(&deletable_branch_names, branch_name);
+		if (!branch_opted_out(&key, branch_name, flags))
+			strset_add(&deletable_branch_names, branch_name);
 	}
 
 	protect_stacked_branch_bases(refs, &deletable_branch_names,
-- 
gitgitgadget

