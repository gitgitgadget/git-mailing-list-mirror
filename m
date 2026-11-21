Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293726;
	b=oBKonm/khEaw0KQOQXXCl+eZ/j/77p5f35gkm92OblLwnByUxQWA/4nyrgHtXIVUKiaa
	 xZWYXiIz0d5IOfY1GjS++Z1KSdIK7kkyDQld9WR1+TltdQA45VkIJ36A5uwnPf+7naJwv
	 6r+80GIUf9cMnu+PlMclWu87kkU3oXTVA3sGBm6oK5JXx/YKyAJG5Awg4+32JeEE129h+
	 B5ocawqEjf6F7iw77bGMTUbRcPuvGc5waf6Zsg74mb/sNB8/UVqKT8gXqKXAGoFqmin+X
	 JlquVeSVdtqq6wax2Hw9bqI1Yv0rW1a/XQv++h9ijkSmZMTQjPKh8mGjz2y2y3Dy5LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=S1NqqudNc1TCCy1dwCoji4Zrm8Ip1rWgvr4b8nN2ktg=;
	b=ypRm6/LYW2iaRUb4sZWw3XHrgQbwLWVgJRBtaz2w9zx/rvXq5h6XWPs+ekeUB5rVvUrv
	 3A2bPowYeovLjHl0d/F9vNrEIDANOyhQOK4a6rVlLAqJoYq+1PMBBtZtK76+46ckbs2U6
	 ChwdGZgzTbKLNVHW5/3EuQ62QkwaRDnCKWM5xssVruujFgJs71NE3cPfXZ67yJQpcI1pv
	 6XECbXmse6Ou2I012UXrgEP5Fttc4vVxkHjf593vIttZlvTT7IPEuCtMx2FYeGkpAXltp
	 jUB33/g4clwDi7cQ0H6xrXfwfvyLWqfnbE1Kbw9YiyUVYtVc11jARS5t3CpUqCsHx/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dF8xBfVz;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691DA606A339
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 691DA606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dF8xBfVz
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53644ab1f7bso18890661cf.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 12:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293725; x=1795898525; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S1NqqudNc1TCCy1dwCoji4Zrm8Ip1rWgvr4b8nN2ktg=;
        b=dF8xBfVzhPlpMNy62X6lfXnoqoiPqJqBPLsbiH53EtlaJX0BrkcpHLWs0wYw0g8Shf
         2Ngrh7KlXFd70s5VBZpNIspum9BDcWmYGgcRuUe30Sj9qpKW1w24fJSo9cAATh1iH337
         MqfebuygctzmS+hAavv7cJxxGSEXcEZjivPOZXcJFCgcX0zU4AYzxVpI4v0+GzF7H/6A
         O/nwfSg4iLMLEAA6Ng8qtqhVq/h9H4h6dflt4K+RR8YYuCoomUWV4tLEe1mDQAfvzWqm
         AhzWR2OrpGK6GUMfFr5+1jOJaL9OfR+8XjRorU1TucVSQpnTlG/dYrVcASGfUpn7je+0
         QO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293725; x=1795898525;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1NqqudNc1TCCy1dwCoji4Zrm8Ip1rWgvr4b8nN2ktg=;
        b=x9A8vjqOEBucf3ORegHWXk8qpr6SWYPR30IxvPvK9kRtibFD6gmS0fbULhruGrNDXY
         uvUfiA7UvfxdlWplDlAsQnw/cW0k0gixZauSQ5AiGqoSKrbtu2sALLV/gl5sECPDe1La
         cycpQTjZjiUtCOYy1odzdYzJVfklv/mKIBkL3owxiiB2kqnfZzKzWddgT6rd71mFAXSA
         h5EYR3oCXu2UKXgo8UAdePZpXL7xse353zS94wZo8u0CWrZBVYdq2qLL/bwfSZxqT15q
         W3x78di7FrbENgJhqS8uW+h6zkjnr9YAalpmjaBm5u4o/s1k9EtbOWNhAdcEjmR2QLr5
         LXhw==
X-Gm-Message-State: APuU4Z9JAX3oqAVVYIWhm2BluQBojskgo6iCsHpbhErFFnh/L/hi8/bA
	ZohKRdW7AGCglNpImyzUYDytt6OalwQCgWBwexrCsO8Y5G0//yMLjYZsQSdqng==
X-Gm-Gg: AZFdTZcltgQ5iJCxJ7lkJu2Yqm9t1nwbhTQyIz1S9gN2v8MWLk/9IdFEoGzeYF5kK+g
	17fh9IlDSqAbiMz3lixdsty3wYfxrmmKnR5zKwdHE2x5LHGh8BcAjZdQXOEklFJOY6yC42BwlYL
	0N3ajFmP7wCIhyzBq+vmKDtmwcHDbj33XAbi1/XNNn4Khaozy6TjOa7Ew3HuEP2AKTZpe6BLDao
	te7+Q4cUxYJFWElk782IHIFoM98A1APpZCgrY9ZHWzVOV+PLB29SCVETsKx0mhMhEbqH9kpF1Z4
	y0XhZs+bARHTFK360yuJl/o8+JFlFv53Y2F7Xy4DPyf+hI1+WJQ0n1D6Z0+x8ES7Kh18O/zTOlG
	bg1r3RdWrbB8kykoNdpHDvmPRBdm1af9e9HzFlCuWdVpJAPEYp5H6kxi6+ptz8HZzWSaEm8zhxS
	RxcQMZW1jL9tVWUyJGdYLSnMExsxsXkYtF3xgtTVzWgEsTgSf/BEW40ZNQsbX66wsc26GtlIcvU
	kuQ8f8R+Yywu8TEZuBKUgWvb/UtrUaUE5tJwidG0VT23cP/fA9ZzKFkSYNWWVd+rNmoyfXNnjqN
	XvUDlR5GeIwFBCrrpiovpqgRwBMoSI5p6g==
X-Received: by 2002:a05:622a:5ce:b0:536:b7a:2ce8 with SMTP id d75a77b69052e-55d76a88b06mr128449461cf.51.1795293725336;
        Sat, 21 Nov 2026 12:42:05 -0800 (PST)
Received: from [127.0.0.1] ([172.203.213.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7889ea4csm57365671cf.26.2026.11.21.12.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:42:04 -0800 (PST)
Message-Id: <bccb3f46476d04a932fb5ad28b40794dbe5b0827.1795293722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 20:41:58 +0000
Subject: [PATCH v10 1/5] branch: move the deleteMerged opt-out check into a
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
    Tuomas Ahola <taahol@utu.fi>,
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
 builtin/branch.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b536b619bb..7ccb36364a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -824,6 +824,24 @@ static int branch_pushes_to_upstream(struct branch *branch,
 	return ret;
 }
 
+static bool opted_out_of_delete_merged(struct strbuf *key,
+				       const char *branch_name,
+				       unsigned int flags)
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
@@ -852,7 +870,6 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
-		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
 			BUG("filter returned non-branch ref '%s'", branch_refname);
@@ -870,18 +887,8 @@ static int delete_merged_branches(const struct strvec *upstreams,
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
+		if (!opted_out_of_delete_merged(&key, branch_name, flags))
+			strset_add(&deletable_branch_names, branch_name);
 	}
 
 	protect_stacked_branch_bases(refs, &deletable_branch_names,
-- 
gitgitgadget

