Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C133E35C
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787368969; cv=none; b=YAH92UUtw3uiCac24IRKRGeNVMA8Hf1WWpmDRVvb9zmkVSZ3pjLMq2pDFbH00SvDJJS2H3B82dQn94VGj3vw+SVVgQ0D+rvHqkFawOTminiY0Z0Z9FAsJrW6T6fZ+tOScfPhB6me2WwoqDp7kAKwWasr/wOn0K6KLdV/iOLA4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787368969; c=relaxed/simple;
	bh=9TEn4ZmDZXFeXUdR/N/oWv7Rt0Nw71zbMQWPHhzrc2I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hOPPjC0Ox2mo2JSLG4naqZmSWKW3qbjWTcwOrEy5d7uPN0RvwhtcafUDi28j5M5VD9sn3swcWczPkHEoB9Gule9rJMBSSTVaL6io2zBVS8oTCmBZKdUuwB5d/F5O8rNX9+e6kbaZjlMrtmLqGcq7+q6iqmiy74/rlR3uHTU/JS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtO3pb5j; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtO3pb5j"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso1238134a12.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 20:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787368967; x=1787973767; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=igX4ScQhVcKIUKOi+hnrGtHVpigj/MZsgio+JOhg6CU=;
        b=MtO3pb5jf+sdvT0FF+UHXzJd9YyXTB4rwkC1tTndiLFsssd9kgLS+FcMfhK0Zex1Rk
         ROreUVOf43YwNTgX50WZ9t35jTC1hDzUVUJU85lTsfu9HP6egobMlx0IExSUdMJYi1VN
         6ZsPJsqLpN0NUtVPfEkIVc5Tj8K9y68cidl65Ssvix+ONzkTMwPsYh2ln+hwUc7MBIFA
         yfyPK+PDu21jIbrY52GXKPu7rvooxgtc2qGBkOB3jKklyJ73wEtkTPnIJtGrdg5bF6q6
         yJlSCmzIx6d92RdP445iZ9HL2Here++dU2F4suMuWeQEVgNr3HeUWgw12KPqGOZuo2KU
         DWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787368967; x=1787973767;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=igX4ScQhVcKIUKOi+hnrGtHVpigj/MZsgio+JOhg6CU=;
        b=aQo06x4CM0FseQIthZXk7kXkHGLtSozLjzWzUgpfw4wvv6tckBaCGrjjcPMG052j8h
         jwYe3azxZv9DJtJWmrd1N6mHrFFrXeGH39JkvnEz//IDnAbejIfxBvuuzBNOliUMEohx
         vXkgmTH3uBDxqfcAmXZnsMq0F54oPYYNnOnVary/IkoT423JyOQ8PYePVMzOQ+SFjWrz
         XpozzJFKoPj9uOPFh9nP2q0apjQMzNAMnyGJm+pEA1l3WIHO5aeBeaxG4HYuJXRCouqY
         6tuHou46zMFOKBJc1U5EKD1UNeVp2bParXgnujrOuPVekXeOfUHWdIb17yXXeeVoheGy
         eHmQ==
X-Gm-Message-State: AFuF++mipEjSZIt4at+aLPGYj+pFSLWNGJB8hhB9nU32i08C1UmKK3PO
	3OzAx21v1T0KEGXkjxUHCtSHccEdpT+eh/nf8k0z6ddFF07wVfyNh4B4zqYX6g==
X-Gm-Gg: AR+sD13nMUlFDiSu43w/Rka1/LdpkTEwpmXbIXC3cGacrIXCujebqENfNHbiuwUHcPE
	QuAjLD2bpO3l4We2CZOOU8imqTUTGgMhzfvUcA33flDNy4Z/A/HCyG1py4O5AHTgTkYKHJoWeQ8
	jkfcQLpaiCSlrg9xNL8o7MOO9xu8Wb4CzNKBnYl2XcQqiVp7HtWCoLmEhFrxPHsYBIFm6aQey4v
	/s/ulz714a8DPwsh2UNtjy5OUD3+phXFrN91fL6P2G8JCi85pHOq8IoWMspdcqkKVZbJnSncArv
	2ZCScd7aBHRrta/58j+v8EBKNRVblOwvSgyhJ/jF8Ru11/3i/1P8Kcnxt7e6C9E3Qhe/B2y1Lf7
	LmUPXTKj6D6+nwc+OV1UiIdSq1U4qqnjOLAeNdlG12B1KHHk6ske+bWQjKzu2hccYnJd0o65tG/
	ywJcyKCkAREtoRfSsoZba7vqzFlQi5CbOC1Q+RKTAFr/mDppKpuZlR3IWbkK0OkAe6vw==
X-Received: by 2002:a05:6a21:9214:b0:3cc:f280:ebc6 with SMTP id adf61e73a8af0-3cd4ba4839amr6602103637.5.1787368967046;
        Fri, 21 Aug 2026 20:22:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183c0esm3954883c88.12.2026.08.21.20.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 20:22:46 -0700 (PDT)
Message-Id: <e3f7d885209e6cf9487bea296bc81df43f3758db.1787368962.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v7.git.1787368962.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v7.git.1787368962.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 22 Aug 2026 03:22:40 +0000
Subject: [PATCH v7 1/3] checkout: extract function to display advice for
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

