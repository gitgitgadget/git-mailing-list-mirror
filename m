Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A943B637A
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784979150; cv=none; b=K+BGTCVuytF9jYkCuztRkLo1aF5M71EQaD6Ut8Ubf3MbW9sfJFO/qgTRfSbHCPbStsxQfmy6bkS+MrPIfkoH0MB1AnfDNScCpExQewDHoZBzyGNkaKAHhZnXeit5YJmO2ERVvploVj01PQ0edZAwVS9oNIqKCe5XhRiQ/CUgYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784979150; c=relaxed/simple;
	bh=w5sdqWSEAZIVQnbo46UE5UcLz/88iBb8Jnn82WM3TkM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z1XiTN+hl3a10eG0ciOBmnU2k5ApQm9Fqx/pN5/281rAFInzqPCYYQcEIYKvOiBvl1z87Ef4xZ4VJ/O9cpHmo96vaJiZk9E9lmvCnJXHq2Vlonc56pEQAYzinJ0F+2M0ClP4N2ye0UryTs2LbZflRPDIZzDebifzaVPUS6Q4RZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNSTLvdL; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNSTLvdL"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7ee46bae4a3so32654a34.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784979148; x=1785583948; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mPRt0rFK2yh/Mmw+VUwg9mLY/Js70AU8IHrpxB3N+pQ=;
        b=WNSTLvdL+lZmM1oO7uWbGgP0jebnr3H0WwJG3LH5kC2lYih9Zsfhi0xNeigrU3RGWm
         gMHdgO1vG66Co+An3R/4OQA0D3xB4MpywxUxBY8KSQHqxqXDknTvPLJJoLKUIYj+exoI
         cKvPKxThtFQgXGAHq9XQql7uDs1LBcPZtYpljUXYh71UuttALOiN86EpFCfpBiAjPfhF
         O3VPIj4zblfHyDmBPpNWpWg815WUHSK0qhmwYj3sOSzKU7XDC1kaOzC1aQ1n3GU+Zs3I
         5geGGUNgrvaep1+FXRQeoWx/nh77qAZBulbSEmPSsjTqbzwexclnre11lhxucKWZ6/oP
         wSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784979148; x=1785583948;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mPRt0rFK2yh/Mmw+VUwg9mLY/Js70AU8IHrpxB3N+pQ=;
        b=rAFSIHHErHnFhEWjNZbnlwPQAP9wOObEFXvWprA3h/ntcq37aGyB1MkwqBOX5foBip
         OrWWfl87RVQDISelrkr8Nq41tnPY+ZW809PPxUtyKvWF35F/BLj+SeZ2/zaOheSvru6K
         AUYQ56BJYk08MBFSNYC4wnhCEh2bDiEjXADnJD6sHI0r5FJupqz+EdlYA2G0i7G2qdCb
         RrfIVt+VggAAtECVnh1gQgcE1ngAz3YO8Jq3TIMzSCBgqzrpdvL7B+5a7j5P3NlmT9Pe
         Kg4XWNATGNnorUoN7IiiOp+qHL+sA4nvZHg7vpT374w5F74dmqoOXcXHawvaNAe0f3zL
         ifJg==
X-Gm-Message-State: AOJu0Yx7H/Bo7djsQQaH7u+IPz5EKH/lDQOviDG4N9Vp2HCm1IYk9q82
	08khutF/yEoCj4Rcw80a+TZuADO7rL6E/SvvQs2ahrT/IG878lpy48lLS9MBXELe
X-Gm-Gg: AR+sD10o02uNdsnI0mtfdCFlWZ2zECRtyCsQWS448/40WxBnjRg1LzaqPtdkc1OFh95
	jdlo/EmIdUQY2g+je+BQECEw6geiD1weppn0FJ7c11cfoCVIwoV+ThJJnz4uS2VM066N5AKRV7q
	idCBshxkM8QhyczDM127RM8bDk2c/OT1BRq3k6bWUaRKm2NPz0iq4zXWG5XucQMs8Kc66crjmfC
	KDCtC9JjiePVogLAtmpfg0bKeRGERrHRk/0EbBjJhIBExXgxSHziYKdGq0JY0rSChftgWpqVzFT
	IjJxXGgzCYCFuuOvlJUdneeY/G33FYbLj/EIWgE8dTQ8LVSxNtICKcDKhOej8cG6S11nNYdkMCG
	EIaKM5Xc1kAV+gIjLf+3cTBPufSeOJIU+Q08V55Li40HqkbdMD8hSwUGx3AIplPhDHJHq2TFuS4
	U3v0pO
X-Received: by 2002:a05:6830:6185:b0:7e9:f0e6:fd55 with SMTP id 46e09a7af769-7ee78db7dfamr1606094a34.30.1784979147988;
        Sat, 25 Jul 2026 04:32:27 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.94.33])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a102120sm8134569a34.26.2026.07.25.04.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:32:26 -0700 (PDT)
Message-Id: <34b37aeb435654fc0c129e32db4a1fcfd8fc8dec.1784979136.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
References: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
	<pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 11:32:12 +0000
Subject: [PATCH v23 3/7] branch: let delete_branches skip unmerged branches on
 bulk refusal
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a skip-unmerged mode to delete_branches() and check_branch_commit()
so a bulk caller can silently skip branches that are not fully merged
and carry on, rather than erroring with the "use 'git branch -D'"
advice that the plain "git branch -d" path emits. Existing callers are
unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 09631f93f7..504117d1c3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,6 +192,7 @@ static int branch_merged(int kind, const char *name,
 enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
+	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -205,10 +206,13 @@ static int check_branch_commit(const char *branchname, const char *refname,
 	}
 	if (!(flags & DELETE_BRANCH_FORCE) &&
 	    !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (!(flags & DELETE_BRANCH_SKIP_UNMERGED)) {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
 		return -1;
 	}
 	return 0;
@@ -315,7 +319,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
-			ret = 1;
+			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
+				ret = 1;
 			goto next;
 		}
 
-- 
gitgitgadget

