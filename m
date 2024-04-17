Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187FD3B290
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713324774; cv=none; b=kD+jPPqAUxb6yEutYdsf7mUyOwMNKts9FvuoZ/LhcTJ3iHiEfoLetAbnxP6I5EriIggvXqlM3oQn4NBrkBVHrYxooIMp5YylZNeSEIZWEA/FPZq7zx9GDoIdd4UBCKy2NYAhx3RLAP3NiQYw6+6ZOtnSYXs8AsrWkcuLKFlxlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713324774; c=relaxed/simple;
	bh=Xdtsv0dzjNtePWXVcfvl0JSzgg7TJc3PM0ecZSAZDG0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXElE6L4DZu0rx/nzXv8TiZOAG3eOU7CKFMp3wSfK9XlAApN42p6GNKCHjzCGcdb+K6rtXCcmbSW3640oGcfuRRwm9iRWtP1Hx8p3rpFChgfOtFKMZKTFV/yuN2niSOdyVV1iisE6HtZK0yOXN3MydwL9M1f0zqI2SPx8fToO+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=RWB3McLj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="RWB3McLj"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713324769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0M6dx4A25saI7CR8lTlaEgybcMSJRsrL/eWIPcfs0L0=;
	b=RWB3McLjWUmO+ODx7TmpMSqZmlz34kL6dGL1jI11db1D6xuzVgNPvIitXoa623zIzGCFOT
	XPInJGmgLk17MPcXmpP7+WT8fBLdzTPmpGso0E3VXInjfEcqANXczcFOPmoYfHDHNUd1wk
	2Ez5gOlLtzfmR+1dXAtRPf7QvnhFcUpGr4Jvwh1VOvpWwit5xef5qcA9dVmPKDBKrfRfEf
	7U/pxiQz0v325OvqLIwAtc3qYaMG43qJu5WGZB1S14f9icEJzIJwFD9BTil8SfnmbPzrpS
	jgIQSCUh1WlaA2S+L34MLzVbmaWM4IIzCQHv9qHwO2mbMKu5E+4olBD+MoDqoA==
To: git@vger.kernel.org
Subject: [PATCH 1/4] format-patch docs: avoid use of parentheses to improve readability
Date: Wed, 17 Apr 2024 05:32:41 +0200
Message-Id: <25b90d065744c01da3f37b6966fd97d699931f6b.1713324598.git.dsimic@manjaro.org>
In-Reply-To: <cover.1713324598.git.dsimic@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

In general, using the parentheses disrupts the flow and reduces readability,
so they should be avoided whenever possible.  The improved sentence is a clear
example, in which the adjustment is obvious and simple.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/git-format-patch.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 728bb3821c17..a5019ab46926 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -239,8 +239,8 @@ the patches (with a value of e.g. "PATCH my-project").
 	variable, or 64 if unconfigured.
 
 --rfc::
-	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
-	default). RFC means "Request For Comments"; use this when sending
+	Prepends "RFC" to the subject prefix, producing "RFC PATCH" by
+	default.  RFC means "Request For Comments"; use this when sending
 	an experimental patch for discussion rather than application.
 
 -v <n>::
