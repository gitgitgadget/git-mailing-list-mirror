Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8D3BE62A
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091897; cv=none; b=JatTsIivUil8VEAQWqfiUY4+/Op2DpM8gfrZzJCYJiUzmB8fdA/eMjRhwgzYTDHlHpFtJTwTNfwQukFbfTsfUHyRPkGnWqWooHuLZxLyU97KszYDrLvrnwsaT/gNwULESoFRQzRgP7lshHWik6sUb9rEOlTqVyfw5EuMOz04WC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091897; c=relaxed/simple;
	bh=b63FwAXWj671Jz5W7et9R08DCR2Q6v32Cdt4VG5jdc4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KJt8BPahk6WynCBAZCRdn855IavWcQ7A2P54DVyglUCB4ACtP6WdWDrQ8L5ik3hcDRsbWJEx8QphaaGL31AOsnMVjqjBBM2XJCsZysVe7sQY3QeHFjQAnuqME5jcXlhuRI2X1NZmnk80fqJmM+2MWs1OVTNPBFwLzJxYR7eNU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qyskuX8s; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyskuX8s"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1638586a91.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 11:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785091896; x=1785696696; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QGhPD4wlK16cfPJHf0ZO8q+VJwE3VbJ4mUgT7ZSXaqY=;
        b=qyskuX8sw4WfEu7sDpcOzFIwk8QjbS8+ZUI69v8iPvaXukKwYWho57gmIYw09UQrtN
         945jCVNY4ZA19+9dM9Qv7/CKW5t6kI0eeSU9Fd+cIp1zHOQgxrn89kXmIQkvo08lLOYd
         joufsViq6mVSSsbKyP6g/T+oVhy26apfgvVW1vNVtJ1QpBSLhzRNcpW/z41V90d2SaAv
         dxEKdFyogN+hpMuuzRTCFaTpsmyI+JbxmXhqvTqX5j198nqjExQ1qUCHQOpKoPaEuJse
         fQB1FGuLj+5z71Y27i1wYx8yiLqqXQda7Qn9NVP4uqUaJqiFwg0vyJLq6R4f9uOBF4ZN
         yUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785091896; x=1785696696;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QGhPD4wlK16cfPJHf0ZO8q+VJwE3VbJ4mUgT7ZSXaqY=;
        b=I7AX8lbW5Dl3KHeumO9jvkTvlbmIQhGICjB/jUbUhi8uWE7aJN/0J1s5jc9eVkbBX4
         wi/YAn+vu1Q1aDWsaUynzWJ0Jg6G+gIbRa0t+Z6JHLeozdqT/0aSZkUsozXkCceYGTRS
         ty7UMRZsCHJ/Ih63cASL5rRkK9zd7akWoG4hIilgqnuZDXY2ydHrRhy1B6LuE4jybnKX
         NAgda9LTfywU5QkvYeTEPIZ3c0G2rolqhVuij4HMkdm0GtfJbyCC7A1B16ABHN4NtBJm
         zFVulBCRgvoZ7I+MutF/UC6PP0Kt9NrJB7tnwi7JMy3FG4IcsYmeTcd9E6unLdfJ2QeN
         HEXQ==
X-Gm-Message-State: AOJu0Yw9N1YMkkVa5r92k5hnMSZtchn0kboWXNyJnrX6YORzvuaw+G1g
	zdTLve5fv9Xdnia2AX2NHc4ydyExXMasIDFloyppn+VOPHCOYONBkv4cdm/C/g==
X-Gm-Gg: AR+sD114WG+KyBrg3kncfj55OwbZ+wxDmtIqqPL2j3uvvkM0saA+Qd5bp0OyeP4NEgf
	dEMjE60afOMo3Z0TUmC4zNFTHTZ0abBhGupjOic9gLFxnfJ7NF87G38NA6EsuSbYfKZUjNjHm05
	CzSq0WwQQni0iUyaqSOcTFHyVR3G0XVHIjnIf1WTU6H2CYWZpqpMy89zRuJlgz/EdaMCGIRwxok
	wo+tbqyMblgXTtmLjmcAgqQdpyHZR2r3VJvvHrwOfF3c+sUng8vxVUGLtI+LnAGs64QGgCpMa5F
	H8Jf6SRuxniUoPMUqB0VmrKvFsbFHqrvkMmwxw01B1F1yu40Egx4jMSgAgG+RSVdf4a2sfkd/YF
	I4uT+OaddzGjPpruv60ekvNFjjwVGDZAOJiUHf7RKzfqvDDMstlVYVSWyhKOlxzj69fVRtLEvss
	PyUcsO
X-Received: by 2002:a17:90b:4c09:b0:381:6466:7160 with SMTP id 98e67ed59e1d1-38f295bd1fbmr6080673a91.26.1785091895647;
        Sun, 26 Jul 2026 11:51:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.229.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc288a79sm23469813eec.0.2026.07.26.11.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:51:35 -0700 (PDT)
Message-Id: <115e31d80662706214ccfbae10824cd1d2af4345.1785091889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
References: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
	<pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Jul 2026 18:51:22 +0000
Subject: [PATCH v6 3/9] userdiff: add diff.<driver>.process config
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Add the process field to struct userdiff_driver and teach the
config parser to populate it from diff.<driver>.process.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 userdiff.c | 7 +++++++
 userdiff.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index b5412e6bc3..7547874aa2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -509,6 +509,13 @@ int userdiff_config(const char *k, const char *v)
 		drv->algorithm = drv->algorithm_owned;
 		return ret;
 	}
+	if (!strcmp(type, "process")) {
+		int ret;
+		FREE_AND_NULL(drv->process_owned);
+		ret = git_config_string(&drv->process_owned, k, v);
+		drv->process = drv->process_owned;
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index 827361b0bc..51c26e0d41 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -31,6 +31,8 @@ struct userdiff_driver {
 	char *textconv_owned;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
+	const char *process;
+	char *process_owned;
 };
 enum userdiff_driver_type {
 	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
-- 
gitgitgadget

