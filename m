Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E63D6CD3
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741123; cv=none; b=mN13Zi9IceAtckEA4YfQT7jSMN5Uq6S4ERowmwXzieKAMkkrnIfgvFXQrSs0Ab8DJNbxcrlAYoIrsxidrh0v+pMYKAYAdfnd7LBfARrkTm6WuFqncpeM/A3iZ4EeXz72JJr+USx+vz5Xee61oRxoWyBh8fdMxLg5xYjlIzITorM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741123; c=relaxed/simple;
	bh=9TEn4ZmDZXFeXUdR/N/oWv7Rt0Nw71zbMQWPHhzrc2I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Is7UFY2B5xnyVcHEMr2zCcWkiLa9DAY5JLZShLW0H9MWZvcBzguit4ICRznzTa231Aplvg1YJUkgX9hrGvyrU4YIkC0SQ/JidKBzaT0ETXHgUo62r6zg1GNLMLjcxuNu6jcZM5DCXlItt9jx85OWNQhysSsBAPxhQsMJt77s7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEH2vClh; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEH2vClh"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f18c0e03e3so549233a34.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787741116; x=1788345916; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=igX4ScQhVcKIUKOi+hnrGtHVpigj/MZsgio+JOhg6CU=;
        b=rEH2vClhNeCxEnUkiTLXv0/qZiNsRa/QM1sX7O0F00yOLT179PujwjGmFl8WNHSv+1
         ILai0aPNQdPZ5m2Mx8y7uxF4XLc8GGyio+INPBP4G5sScMxaxzw8+xtMdnG+6qzAGHFy
         T0HnfqWoS9DNmftvX0/kh52UkBqQoy08rutzur1DJjmuwdeqq5XphzSyPHqwDGtrbsR9
         n/aiTFzjMPhB2JPnDVh2/ju9LY4IitawLjLX5M2Cy29jUbHWvwmBTS348LJBOCFsNxXR
         nbGQM4pIKPKgozwtqm3NG9KliGsiz58ia/fky+inAVxpuDZkXvPZHVRth1Q89foDoQul
         KeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787741116; x=1788345916;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=igX4ScQhVcKIUKOi+hnrGtHVpigj/MZsgio+JOhg6CU=;
        b=iV2rME9uYg5MFlpdKNpLzyW8yDgeLgKEjxY4SneIRnXVu76llCEn0jz2bhNRKeKpZB
         PVAIgtxueSnqsLn8sJyV9niWWcK7RTxNuTZCj6EYdMuAvePLZ4SIRmC2TB0Omv+WBERJ
         P7lkpWG5xTT63C7sCDVOnn4L/V0P3ZiQlDp+4h0JIaxQGOBTujekMeH+GT/4RvMDDL2e
         MwlF/It7WP5wTVl3bGp+yLq3ulIcMUc3bMB3zYXLYvIxr4H/oMA70TXT/EIOonWPYe5i
         3IOP+Xx0LYoeK30uO56taLX51UABqDG0RN9f+M2melALE1mq82kdHdEAbpV0HbXDjdXr
         ikOA==
X-Gm-Message-State: AFuF++mUpT5lGTiom35dqBOGUXyTxhNhiQVm8fyuH2CA8JkkdX7Pcyar
	6v/eNNx68p9lGswNH74Xpta/jzEYfWXCqMAG494kfEUL5xoZqfO0sLmRKRdmuZZI
X-Gm-Gg: AR+sD13ei+3C2tF88wZA2DKhGFex82OVo4kFkpdivczGBBA50A1Ld3jJOBAHIlxH6DV
	XMVmceeDebtr7TwzDk0qRsV/NXXwf3bAfsug8meB6voLINulRjiO5VWUtdp6ZgJbrkTsD+UM3v9
	ikf8M0qLeCHIA2vq4YwSWfI1t7O98YAvWAzB3Dj6MPDoUOZd02hD6tfPuWnGhbkJ7TPjCJc1lhh
	de383ahl9dEMRJN0kJz8Wk9tJAGFu5thw5MTK5JnwKNBZE2NerNNTnoSBm2LpzjF3t/dbnmXH+k
	oIgDX+F6aUMRmoxrreXQxqm37y0Fw5AtB+HkVQav4IJH4tH58k+n+0DOKymPkGZ7ZeZXqCjmgSG
	xr4F1wHWBcUFu9x0RKUiUuO9Fk0e1fw1d42oqJ4syy9imEZ3Pj+yxDBETRYus4Kk7/JDBuPLhp8
	ERg1LtG0Gtz845toTVbBGi7Sl02EaUaXFIhNOcT21Gbcyzf4oWveUxQnSITxbJm4cjhmtnNpI/8
	g==
X-Received: by 2002:a05:6820:2910:b0:69e:3e6b:c07 with SMTP id 006d021491bc7-6b1a03705a3mr5519586eaf.5.1787741116316;
        Wed, 26 Aug 2026 03:45:16 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.19.227])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-465afb1613bsm1742916fac.11.2026.08.26.03.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:45:14 -0700 (PDT)
Message-Id: <e3f7d885209e6cf9487bea296bc81df43f3758db.1787741111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v9.git.1787741111.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v9.git.1787741111.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 10:45:07 +0000
Subject: [PATCH v9 1/4] checkout: extract function to display advice for
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

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/checkout.c | 62 ++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..650eda735f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1343,6 +1343,34 @@ enum checkout_command {
 	CHECKOUT_RESTORE = 3,
 };
 
+static void advice_disambiguating_remotes(enum checkout_command which_command)
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
+		BUG("command <%d> should not reach parse_remote_branch",
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
+			advice_disambiguating_remotes(which_command);
+
+		die(_("'%s' matched multiple (%d) remote tracking branches"),
+		    arg, num_matches);
 	}
 
 	return remote;
-- 
gitgitgadget

