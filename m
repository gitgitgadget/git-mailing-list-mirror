Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F193A5E7A
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691882; cv=none; b=ZjRl2D/zJ3B7+5dncnksoii8aVzcXTFUcuyrTSsl7klUY7WpRqHegpgwunzNDjo9y+Qtt/fPdX/5j4UrEaRcgOlJu79u2TCK9oHJMQdFpsYVXfhSXu5JteMl6d+daKGXWvrxr3hn23fnh1mdkGucv0gS5z1n7TJsJfEfOk3mwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691882; c=relaxed/simple;
	bh=9TEn4ZmDZXFeXUdR/N/oWv7Rt0Nw71zbMQWPHhzrc2I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UliLH+M4JzKU/bXccuYXS4nPok9v466JMxzRZyM9z0ksLMEIRmhfdXw/m5jTX1fbcyDA0Gro2/jYoojAwjQDW+meUCmikx8A2cuZ5UClNK3dEijqgMkyz6ayfJotqBcZ477jERDkVdtRd5/NuFSVInQvHHZeiR0fov96t62KqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2gezkRj; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2gezkRj"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f0167e59a3so244620a34.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787691880; x=1788296680; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=igX4ScQhVcKIUKOi+hnrGtHVpigj/MZsgio+JOhg6CU=;
        b=X2gezkRj67EAtqXe+Lb7JXZsrDAZaylzM5erRHbuq+2keof85QNxIDio0k1n95ZXu+
         HEwlni7kGNL7+NHfX1H1Z9OPkx7s5MQnVYpEIlLsKf4UNCKPAOQ3Sfx3da26YkC3zXAy
         Ho73eCj0fQ6aD4tqB2zAPiMbU8pmN4Jafq7NqR/dIQM+EBVB8pIMQ0aAr9LEEByXMakA
         LO4h+pcX9QuLMMFluXn6RhSW+ujQ+dzsNDBJqYL5VSjaDOZYmSSLvgEndroWwkjy7ZPF
         giLyTh624skDt5xUu3fiil+rL+h2QwDFq3blKAg0R5ilMEip/GOWDLXe0BTcCvvKOK73
         anpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787691880; x=1788296680;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=igX4ScQhVcKIUKOi+hnrGtHVpigj/MZsgio+JOhg6CU=;
        b=IBD5DK4U6HznD+IRHqExUREtGYzwNMefFB3ocPVbDCfrxf+UdMtUIw6VE16lt8ORyl
         3F7HOtbNcS8RzK+xI4KcuIhFX4e5/EgXxbm91x7vIf/GnvKfBrE+ygu5RAQtFi16R/I3
         bGWxLBWp0ImV30rx6ooXCRgSP/0akcddg0q0ddJzUfRXsMwlRF9tjrfbGYzKC1yibzYU
         3EvCpEKgl95FdAl+plwo6TdbtZ0vXv9Qs4jmUBc4NKX9jfw0XpeFabaiBV0ryMLGNN8u
         3r2+n/8Oc4e7k00RFZhs1Y+60AFhssk67i8+geCxDApwbd3gTn3b8mQ/jeleoeb0ORWd
         Pb1Q==
X-Gm-Message-State: AFuF++kdRrrpNeHTJKmAusOYmyJY/lksZWFAsvZBBB2VVD0UAxJekYg6
	XnFxJazVJiHX0OS1olHcM2Fuh9wfgDNxWXQXI3P7E5RlF0G6NYk+bVaOLDSshg==
X-Gm-Gg: AR+sD10nC8gP8A8a9KmXswylBJrjAPYW/rdCYRo5UshHVo6yj107NZEoReDbMMGyApY
	Rl9bIar7dyXqlStQ0gMozQM4Z6lDFMfBvMUjC3aNbaV0E8sSPgKarAU5NdbpEXrnO1N+6TawRO2
	Y0T3O1KsP2AxZaRb8EGVyPfrogEgKTRTXBh17kACd9O3yqIza1bGBQgWn+ZzyjR3dqDJbP6SmQ4
	cbdzUHDT7AsAXUS3N9QpgFdNRqaiB58ECkNMYYqv+gNR4ocA1rxbjeZxIs0U0ObpDi8N6+QQ1UI
	VI8UtxlS9FLFUdYBHgILJESzPFb24VxP+R2jS0dforqnLEMIy+4ZyZTqXEl+Ui40XRhJcUUthOX
	25UP53ZLbVUoMF0z3tQqKazrN7iPo4rRN+Uv+EvmaGCTkIdw6pVdc4H9pM0FDxpbhYRGOfyURIv
	d/x+pAue8vjYrz5MyyUsgWSHNVbm7UEEw9cbqEfENzOzIhWJcD7gWpRSQvMb9ULSPUMZ31KGAB8
	nCc
X-Received: by 2002:a05:6820:8590:20b0:6b1:464d:4d1d with SMTP id 006d021491bc7-6b1a03c6c50mr1583759eaf.11.1787691880002;
        Tue, 25 Aug 2026 14:04:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.165.178])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-465b03ae31fsm453967fac.18.2026.08.25.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:04:39 -0700 (PDT)
Message-Id: <e3f7d885209e6cf9487bea296bc81df43f3758db.1787691875.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v8.git.1787691875.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v8.git.1787691875.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 21:04:32 +0000
Subject: [PATCH v8 1/4] checkout: extract function to display advice for
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

