Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22C33ADB3
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841725; cv=none; b=CskzJmIhdEnvDYfI8o/1V+7um++hObtU7q6/+pyjSZlLc1UySEQmpWy+iIu/aEV31KiGBSuIjGSGYYnBae1FC5Z8FXdMwkoup3c8HWtuV+LFvH2ndN3igVCJBOQa+a+pFJ/VfdE2ttYB5hoY6qGLm2j+ogiC7clTo5t0nMoRIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841725; c=relaxed/simple;
	bh=5hggLDmd58jB42TuaA1N32hrR2J8PHxZb6iDi1mwJtk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=T5l0rIMryJw1MetWFmASNYuCVq0z7l1hjF/7Yhn9Ur6CHCnZyhMSsdaBe+uk0bSn9EFzV6WfpUm1ssiP1HEamii5nn34Q9T+RIIlRQ+HtmAoPSmNA6efYHy2GGo4fl9bYaK48RxZEdXsdKVBkvh90sjO8nbxMWQhmBQRj6hl/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsQEdyy7; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsQEdyy7"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9390f8a1c9eso16758385a.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787841720; x=1788446520; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qgd0RqJWW9McW2Opq7hFDSFRHcg8+fCL4gvWlyqApa4=;
        b=LsQEdyy7HpkHTtIFIN2DPNwzJQfSY224Bpggb3pHslO9d6fphp1Z448uabo6qw6w82
         E65wzgfyD059sw0J86onu3Vk8LYyRpf0WhIeO9AkmSIbqj39LSeABDBqx8jHxCM11rvl
         h1NkzFj6KYGefJkmfOOQr+S/xmmKiAIaM71Nq0JlZez4w4nzqpJieMbFHQyuyBQ5o7Ft
         DFgimBUrXPUc5voof0LLqBk7gkYe7iaHlmjTwU8wlmxyJF+E365lDHDA4TNl9k7CDfEY
         U8f4N8CeoX9visATxnytt9vSMoSnwQaIQC0EEZjznZkrUcoYyilZ85KpURw2wO5all+J
         lpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787841720; x=1788446520;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qgd0RqJWW9McW2Opq7hFDSFRHcg8+fCL4gvWlyqApa4=;
        b=YSY5dBEjNqiv4SHZBKo8P8Bn9dBz9CyqkbhsJT/mUt8BX+0B2AyGR2MJ0pM6s6Uky8
         yMgI/U0K9KDX2yz/o0GBxsl2l34p68oZ0vcKGDUZDCMuDcFyBBdkotbDFomGSsWpB1mU
         C5Xh1oOCGjWC0dGaJ1dcHRlLDR6ec0B1guqeZNJ3nbkgew6uv2bfAJ939ufDYb9Aer9D
         yo+o4+o8hqDFnzY+I7JHaU7qkMc6iByf/ip7iLVOOioKpaUFiwkFq1QPOpR9fDDVj97b
         G/9L2TAfXkFc//mqbgABzaI61/ykQ9RXnrSq7BK/ECWAisQQmxS7AeTfL02Kzh4ALWZs
         9RLA==
X-Gm-Message-State: AFuF++k42U47IRn/4nToPfKDv4E0TPrJzeDdUwxGxeNbQoot05rIqTzN
	LhQqzfbI6BeFRgtgfej9Bo4m5I02C3xSXb+Vj/9xYRhK+jDCefq8cv/WeA1Jyw==
X-Gm-Gg: AR+sD103NzFTOrXF2CKbecAKloPvHLE9Q2dgIHfrB1+5xSDqJXBI05pQldJGHnpCutV
	R3Nok2+6lJqGpzTJybfFh7WUBXXtT3FRrFMgzLU8hCA/WRa16QS01FuZGJZnw14teQ+KnUrwir9
	PuhMUoGr3ZEpsaGD+m6txYl+oU5afVQWHxLLNN477SNwsFvIAT1xQhC7xz2tRHsY5TkttUs+RSF
	AdRXGLmQ0C+EKzpdVJF+B0xVIBqzd3aQ5aSh3pnZoWDSz5PMcuoiboi3wSXVcH2U3hYuFipKzls
	PuU2PjtVprAKXPW32fZQIFMxutC1YxdUK1EIb3u1R3ZR9euHeNjwlUPrPYR3Zq4Yhb6zuSgylR8
	GK6LTwCuyBJ0tWZNhQWZUT+yn+J2eoBJfc5HIFp2laCtBI+wMN/9DbRM2S90K3sDNBbQaF9poKl
	7H68OvJoXrQc2VDZZE8CbkEjLDxh2MEDBpJrrDS5qYPRLhNg2cZdrd0uqgGtNpokwV
X-Received: by 2002:a05:620a:8c93:b0:937:7890:29b5 with SMTP id af79cd13be357-9378044777dmr950049485a.37.1787841719987;
        Thu, 27 Aug 2026 07:41:59 -0700 (PDT)
Received: from [127.0.0.1] ([52.186.174.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e68053dsm462752785a.39.2026.08.27.07.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:41:59 -0700 (PDT)
Message-Id: <7650c38d6bf4c68cae4894d1cad5d96dd55e4b92.1787841717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v10.git.1787841717.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v10.git.1787841717.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Aug 2026 14:41:54 +0000
Subject: [PATCH v10 1/4] checkout: extract function to display advice for
 ambiguous remotes
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
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Fix incorrect indentation and reduce nesting. We are going to extend
this function in subsequent commits.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/checkout.c | 62 ++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..3cd5fff709 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1343,6 +1343,34 @@ enum checkout_command {
 	CHECKOUT_RESTORE = 3,
 };
 
+static void advise_disambiguating_remotes(enum checkout_command which_command)
+{
+	const char *cmdname;
+
+	switch (which_command) {
+	case CHECKOUT_CHECKOUT:
+		cmdname = "checkout";
+		break;
+	case CHECKOUT_SWITCH:
+		cmdname = "switch";
+		break;
+	default:
+		BUG("command <%d> should not reach advise_disambiguating_remotes",
+		    which_command);
+		break;
+	}
+
+	advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
+		 "you can do so by fully qualifying the name with the --track option:\n"
+		 "\n"
+		 "    git %s --track origin/<name>\n"
+		 "\n"
+		 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
+		 "one remote, e.g. the 'origin' remote, consider setting\n"
+		 "checkout.defaultRemote=origin in your config."),
+	       cmdname);
+}
+
 static char *parse_remote_branch(const char *arg,
 				 struct object_id *rev,
 				 int could_be_checkout_paths,
@@ -1358,35 +1386,11 @@ static char *parse_remote_branch(const char *arg,
 	}
 
 	if (!remote && num_matches > 1) {
-	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
-		    const char *cmdname;
-
-		    switch (which_command) {
-		    case CHECKOUT_CHECKOUT:
-			    cmdname = "checkout";
-			    break;
-		    case CHECKOUT_SWITCH:
-			    cmdname = "switch";
-			    break;
-		    default:
-			    BUG("command <%d> should not reach parse_remote_branch",
-				which_command);
-			    break;
-		    }
-
-		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
-			     "you can do so by fully qualifying the name with the --track option:\n"
-			     "\n"
-			     "    git %s --track origin/<name>\n"
-			     "\n"
-			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
-			     "one remote, e.g. the 'origin' remote, consider setting\n"
-			     "checkout.defaultRemote=origin in your config."),
-			   cmdname);
-	    }
-
-	    die(_("'%s' matched multiple (%d) remote tracking branches"),
-		arg, num_matches);
+		if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+			advise_disambiguating_remotes(which_command);
+
+		die(_("'%s' matched multiple (%d) remote tracking branches"),
+		    arg, num_matches);
 	}
 
 	return remote;
-- 
gitgitgadget

