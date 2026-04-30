Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941A3BE623
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546483; cv=none; b=YuuDkGPOZAZrrOOgUXNwkT0CEgipYz8Gk9Ilv+R5nkj36zuxzjVmKEjSEvf+IdGfehOeY4Z5EHX3Zle2yRpL/zb52z0ZxQMUj3CpiWbaPQDNPihvUfqSO4ZLD2PI+agt4GCU34+AEFh2mqMTa7d0myhZdNxwIOAYuG+RCx7fuKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546483; c=relaxed/simple;
	bh=1vgiDDlOlpx684pYw8WxSbNla5Bz2TUIszqKPms+6TI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SJbBQ2ao8QmslM6TW+XFAYWwlEvfZRxcHPH2ie6MPcnB4SxM5Bel9z6QIkWPWVuu1VCvFeYZAp/qGAWFXPzTROmOBiNslT4cxF0MGtdvinnIOSV6T/nRy2GvhYiJ954415jSqiJW6RQiD7Kfhs6z2pm4yZMErc5P9KNEIpl46A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhLJC/eD; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhLJC/eD"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so940736eec.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777546480; x=1778151280; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLaAv8PlRhj07K7Y/ou/ai6nHt6fWCjShI7DA3yG6E4=;
        b=YhLJC/eDURBxqWNz4nMqxBSMtHLLvCBtW9225RoBjIkZTHEgEKxQPFLLsTMc+mamB4
         KUWX913GYcZjgEEN7/oYiW+Gt1uPhsb0u4vm0+G9bXmM7tFIzvodC+z3ypxHfjccXuvU
         fwQSWWcJS2GkPSycB2iYjtieD/3FPDpvGUiVYHT0nSrt8Vqyip1v4aCFFWCFcbOhF95E
         ZjcGPN1xnLI6kBEzZDIyJHaG9qqsIRyEfCm1/LKAnXQPcG17GA5Obf9Ohbr9cskeA63B
         EBaCtIlnjYEytSPZc9BLoEoq/hojgP6lUH/sZ05k6ecCoLhhb+Y1am3pU2MENrteAgP9
         qKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546480; x=1778151280;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vLaAv8PlRhj07K7Y/ou/ai6nHt6fWCjShI7DA3yG6E4=;
        b=ILuPE8qQQNSCzfNlPBntgXkopGK8F0uGP7sh4j8BL0vfQcEl9MWeQd48srxbW+DvQt
         KsRGdWR2iJ+x0RK19W//zL7r1OMnC1BT76TUpMXD1/divp3Cd1zfeqqcZNxzk9RWwMAX
         QtPhafCWhB2DRRFEGSjBzyoahYKSyfTeCUPsR2lP2Bm1Xr05VYAj7rfKuf6YDKpUODZt
         O+JePR7lB5bhakR9leRrUEZj90tYepRV/k2s4wPg8GdanLP6HCCVCCltknaE+RHvFUZX
         gylADGGk1uZ5DN1uC38GbeU8Rx06S32UEu7/Dg6GbcdeMUb07/eDt8V6bMSvPn26LHUC
         2bJw==
X-Gm-Message-State: AOJu0YyLd1pmW0cfyXJHMkuWUtbVOeQL8992CJn8L/D0glD8pU/GBcTw
	gGnUdNVrC43uQbkO6O6aGWxlT5i4jWUD0ijJpCwNp9+nTDN8KxI+M7vofbHCSmNO
X-Gm-Gg: AeBDieuzfGVKrtmQk7D3YFQlTQUqz/mxvz0W7ndXXBcLjLs4DRCZhNZNpSipcAsuacN
	LYVq/wkQ07m24JeY4UASele92kxUh0UUQxOO8cR5PfYXFuntqSccZ7YQOZYtV/m0F7XQwxS3ufY
	8awUIwZYhNRKO4sxnkiKnPFRXAozD3QUsmCfX/eJy6b38ir8ij9eJQi7wf95riIF+SZWBG8GYPj
	fNGq5/oulJQNiq0Y6334FQzl2GBmN2wKvHWWGa5aI631MjuP41JHcJx0J8+w6Gc2Kb/E84XMSPv
	aqTWPVDPS1/4x0TVrH9XV5soAqZFNd31YxTfQ6Yo91TiOXKADFXymL3Og86yY12hY6+ShAGFDRO
	PlzICfitS0doiUzeOtG9wac0uzUbj7SJ2fY32RGw3gEZRYKkcMdHVfuzXdMS08GYqHWxcmxVNA9
	t5wvtHuOFyReDER016LhMEp2ZQ9Zacy3bnZhkF55LB5EQdfSM=
X-Received: by 2002:a05:7300:7316:b0:2be:1f58:32a3 with SMTP id 5a478bee46e88-2ed3e974351mr976376eec.29.1777546480318;
        Thu, 30 Apr 2026 03:54:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.40.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed46afda3fsm3003799eec.30.2026.04.30.03.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:54:39 -0700 (PDT)
Message-Id: <e0f236767f81ea60f90749d1bc00ab78081efd0e.1777546472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2087.v2.git.1777546472.gitgitgadget@gmail.com>
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
	<pull.2087.v2.git.1777546472.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 10:54:32 +0000
Subject: [PATCH v2 4/4] doc: clarify http.emptyAuth values
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

The existing description of http.emptyAuth explains the purpose of the
setting but never says what values it accepts. Readers have to infer
from context (or read the source) that it takes 'true', 'false', or
'auto', and what each one means.

Document the three accepted values explicitly:

* 'auto' (the default) only sends empty credentials when the server's
  401 response advertises a mechanism that requires them, such as
  GSS-Negotiate. This matches the long-standing auto-detection
  behaviour added in 40a18fc77c (http: add an "auto" mode for
  http.emptyauth, 2017-02-25).

* 'true' unconditionally sends empty credentials on the very first
  request, before any 401 response, for callers that know they want
  this behaviour up front.

* 'false' disables the feature entirely; mechanisms that depend on
  empty credentials, such as GSS-Negotiate, will not work in this
  mode.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 Documentation/config/http.adoc | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 849c89f36c..792a71b413 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -59,7 +59,18 @@ http.emptyAuth::
 	Attempt authentication without seeking a username or password.  This
 	can be used to attempt GSS-Negotiate authentication without specifying
 	a username in the URL, as libcurl normally requires a username for
-	authentication.
+	authentication. Possible values are:
++
+--
+* `auto` (default) - Send empty credentials only if the server's 401 response
+  advertises an authentication mechanism that requires them (such as
+  GSS-Negotiate); otherwise fall back to prompting via the credential helper.
+* `true` - Always send empty credentials on the very first request, before
+  receiving any 401 response from the server.
+* `false` - Never send empty credentials. Mechanisms that require
+  empty credentials or an explicit username, such as GSS-Negotiate, will not
+  work.
+--
 
 http.proactiveAuth::
 	Attempt authentication without first making an unauthenticated attempt and
-- 
gitgitgadget
