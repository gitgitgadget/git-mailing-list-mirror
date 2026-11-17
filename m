Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921881;
	b=3aTtQQTX5Sdc/lqpQGMzmSDL/P04DreiSfwlNJqd6DUK9Cp6LODLX0vVmxuWIFabAoF/
	 1XVdgAn0PBAmnMjCPHQfpYYkZkLgvh2pycNti8jyIkDqDm6F8yxvUsDSV5NLw8yEa9NpE
	 hde/bJNp9M6113JqkV295x4NNbdvgKjXi/ebCx/eTPniJ2zXZm3/XPGWhRevRSt4FGZ7Y
	 JXXsWc1cx9WZ6lu0meOEaOGbHzPo1TfXvB6Y0zKGbGzepaWdFgHA7ag/5oeKpKXOtXeqw
	 xb8MrWlgybiHk1Pro3HNILQVoqSesRZ2D58yClgFkvtzcHcIeQNeivW/i3APzKGrvJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=t+sWMCsL8awzinjVBKiIODQDcX4FxHb7TINpwMWSWbo=;
	b=nxbmilgLkyUAWIZ4RxBuK1Rl7QslNkv0Vz62VOQVNNLr4trzGozByIhweGyF15Y9+oCc
	 lyoc7TnFYvQtD87TCxjEKdg6tl0Qu/tjthm5nFy1xaOKdlInSBxQ8mG3t8roaiELbgDms
	 6YzdK3dSwN9MNp2zmcX+3DFm/hHrxhb3OcZTUGe83ySR4erJXpP43NwsaEZ43tUdti2Ju
	 20rx0Hvtsd+uAQAKWkSMGOmY6zvb+RdILnPF3Rg0VaVo/N+A/zts5yRs7T9t/TCiR/6Kv
	 eMIeP1rluplc4KMZvQj964bObbi43zarNEI7JSafsvN2VuRNmL9lUv6U2P7PdRgqmQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AokpOkLo;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258F606A32C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 13:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A258F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AokpOkLo
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so2335684b3a.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 05:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794921880; x=1795526680; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t+sWMCsL8awzinjVBKiIODQDcX4FxHb7TINpwMWSWbo=;
        b=AokpOkLoiuXYgyGrEJ75NoGsED0XeWT0UN9YvXLFRbeZrFkCBGZxzP0ZKne5KNjXdU
         Y6qRpCTcQg11128HB2BIvCLc+1PM0d+xcsSbin4dMDCI+rylg+4fuffqRg+YlYauLwSj
         OqDTpv+S8ze4pdBZmdXGA6Um0QLohyoQMhzhPMu664ZMwR4tKjcVjtncKHK7aEUqf3YD
         P8i70MpeTdHlbVAsh0YepT1EpNrjS6Zq29zNZMIwqCw4/YNzrnwOoI0teg+WmCWts6QW
         9P8gFXZtyZii72OT00P+hHDxRYudXTlG86UxSj3IEqIDDXfYRZJHv3RI0gytDRnP8Gjo
         MrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794921880; x=1795526680;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t+sWMCsL8awzinjVBKiIODQDcX4FxHb7TINpwMWSWbo=;
        b=glweaVUDEK4nskRF2LsNov1SD5+tSqswcifTIgYpZcVwTvm3BiA5aGeRs8hG2UbAA8
         oEdu3WUXaum9Ukz99TSPGZTVxif7AzE8sypo0WEg5odSsxyVQ4w3xWBLcYvgq8MLzoHR
         eSLLFQivT+9eSD3+8MgUx00vYh7wrO3SPFRKLIYOKEXdqOCOgdLzq7uXDFOtrS+sCWgV
         d8+jSPzNQtoJ/kGDAFBn5QW9BqsComcGzvE4T+NnuRSu21mASLkymm4mnVUnu+I5raaj
         d/YG7cfgUVghEcEMUG5HVpSGSEw/eVaarzvKD24DZi+ucV6jmBHke+HuWok021ttKnxH
         qRew==
X-Gm-Message-State: APuU4Z+TrobjPWMjVP3nSpp5pcLKHJ9LXh/1SJsjSXgvSqcwfavGm1wf
	2fPCnOq2eguCU85wpDise/F48Yw2p3IzRTNfDqolT8tq23t11ToH/jJWT9gyOA==
X-Gm-Gg: AYBFou1jyMQJDpvZbzSDBv8qHLkYDLyRgRGsq9w2mlPhJmsNz3/ncHgM2coMfVw+heq
	sUeBFdvRBPBVxEnO/UfBnrWGRZcmDINlmjW47ngowtDzdMBs99rB6xxZHLM0beFoWhON0om79oC
	0I08z/c1LUXmq9ZvLXxcbv8ShA/zJpNXcNFz/ZZCBVcPoNLUGhZ0jQAayHY7WT2AVrQ5OHrJ1ta
	Uy4x78ZjIB+fjPs99RW5M71hltRcPZES/Q+9floVvNsh2bfvXQEYxTJuxdyrIgCo85v3cDGdX7b
	FJYwUYciLapYCewWzbYuA6cMVLAz/HuNXMdxdFPdqsY97z5mjlTklfuktbI1zWBSkV4hwWz2lEX
	8MAQMyUfnMJYuMAD0/rC/yXPVq8okhrz/b+B7R6fOEAPYyQozeKXCZkbfx7NTRQ0xKEROeN4VTQ
	mHWKOk/D4bhuUEu45IT3+oDnURVmC12n8UuKAxEl1dyb9v76IjbWNDj/fyCjYr0rfRl8DdkzO7J
	kCC/h1AL5k27qrGo4z33xE5/O8eb3HgKWzEMTBatdk7KwFxCapuSvzEr8tqtaYGg7bARn+dEueC
	OZ77ztqvb6Hjp1KBePyA/1xNqcB/Oa6T0jxjCKZz+ajbVNuc2vJ5p7XXJnGvIKqKFEQUy26QIED
	v4iACLd3C
X-Received: by 2002:a05:6a20:a11c:b0:3e0:dbf5:59f1 with SMTP id adf61e73a8af0-3f7a8bd98c2mr12497262637.91.1794921879914;
        Tue, 17 Nov 2026 05:24:39 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-125.us-west-2.compute.amazonaws.com. [3.42.157.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1e5ac38sm5090633b3a.31.2026.11.17.05.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:24:38 -0800 (PST)
Message-Id: <25d2441ce75e0794e8df4d2b6d6c4b6d50902174.1794921876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v8.git.git.1794921876.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v8.git.git.1794921876.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Nov 2026 13:24:33 +0000
Subject: [PATCH v8 1/4] branch: move the deleteMerged opt-out check into a
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
 builtin/branch.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b536b619bb..2c1a8b8395 100644
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

