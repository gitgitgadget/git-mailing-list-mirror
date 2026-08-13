Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D03264E9
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 01:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786583145; cv=none; b=dzjtuFpJfxyGc2bzjfL8qSYrxb2ZSTgLs58NUJWaNUS3lpjFjZTAW1dbVXGbZMzYU+jICRncV9GWwnlxbI5kO3X1zVR6IY51/cZ3O697DMGXNoFP4U+Dq2xv1MPYj2u5VFT2yR/57gWQoyuuNdEf1dM2uWSxdLjR+npIIcsD/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786583145; c=relaxed/simple;
	bh=W22HyOaArE/el/qMVZkYL/ayvHHJcn4UzqEiWiAlMg0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VWtBD6It2YG1iCct7Z3o9m1xRQ74903iy8LnN6XkmZfyF4NghNoon3cvLfKaC3EHxCium2rnwbKYIHoFZ5yEhfvjhuW0qKAq43uV6UP0NN8yUQPtejZvCwi7OkUNxYpdLNZhe+J1n0mKGTG4QUWolZ8T5ntdf/1Sck5nUjYh/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGIij5Yw; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGIij5Yw"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9309d4ea213so13500985a.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 18:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786583143; x=1787187943; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xYskOLMc3gzORPOL8T+xf1hfVIkndPv+UBXZrU7Ne+U=;
        b=eGIij5YwJuvGlO5hFn4uxCagQ3sNMudcIO3axV7qDoO+dh3eH61cRSEJNCQ/B6qhMj
         qZhTeQSiRFHFDI6FoSCwhp9gQ+Ey6P1UePI/ajwNvhFRvw86m7s6g+Vxs9/46v1WMfTN
         ZAJ/+6pvUMLUKWy6wBuRz/es8hAMC/PQonqodcHjdzpvx6vgU7yCqIV9Uid7yz3XWxtc
         coGsIAXSP7QuYTrau4n6icbX1XqU5nI6TPuOi9w4Ko6C1Si6d2SJ2mwztig/J1NwiHxe
         /INGUEr0Fug2q9bK6Rdt7YqhPKdLgFLaUf+SAn7i09MmDJ2PUsuI8UOXm9YMRH3TcPgU
         3Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786583143; x=1787187943;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYskOLMc3gzORPOL8T+xf1hfVIkndPv+UBXZrU7Ne+U=;
        b=hP3XPYD+Mosf5hslKGkO9/33FuBS33Rk1eVbUlz8ZyfaTEttZvj/Yk4sVm17luLw79
         eQULCbf58LPpOPTzpy0rQBQbhsqCXLxSInD/SPI3m7JUy/EGH2v1kmT8AvFX8lyLcaUT
         GDayVSFoWtHyZOFW7oO6EDhClWkV59nwtz5hUMUZuVeBxtB4+/apmom4W9tILGUNs2CY
         NUDYKcuWnqo76zm6x1UWZxDWWuTBZT73tMNDu3dOUUX3YjoZc9KT/S5OcrXLdO6mK6ej
         0ymOLKU673zwI+FSIl+PpfwmJekUrtY85euGCOOqkgJyn3QRdM8UbT/A/NaEVLBhtO/4
         TItA==
X-Gm-Message-State: AOJu0YwStM8p8K3rv9R4mFBiwy+7BrtNUinoXDmaovSmTR9poHGLg2ui
	I2HQL3idEw/fRaiF1mTMwsmX9s3g5eLY9ClFhGroR+IfLlEOrjtgBoRxtdZcbg==
X-Gm-Gg: AR+sD101tlQTYUsuXNMOPX1RVNpb3wliotOCYCHBn5prnMI4S1mUFv1vllXWyaMKRkm
	n43NGezasn5k24bsE144eH7OKfRcO2jlqnwPGCnB3Jv9A4njMQk9vpfKHyb0ysdKq5EOmoIl4B9
	tIZ46E3sq+u//BJa9QNnY1W3yLFT+mr/KPPi5RIzUFxfmsum74OPRWS/bq8Q0gq1gcco8/eZ5gn
	vMiN+Gvdb2Lp5yOkM+LTJME3spD/oTuiX5abkkjW3FNT+V+BU0GKBF+XtN43yV6rADjPKeeIcJR
	F3fla+DVlb4L7YnfTsORAVI2CheWSmvFHcdtwiJlbX99b3enchF9Wq2WLZY1mbM0lkcXnEhHAGG
	cR8Pzz89UYjIxH2czuvIx8J3Jh4/cNI/Df41o4FgZOK0QDM0Z926GDVznI1QWRB83+KKWTU6uFl
	ZF0Bohp0n3ZLrCZhwr9ZRh29v+HFSgtTlS1y67hOUHf6CZ7NykFTTqd3m23JDV2gbEWN3weSt3e
	w==
X-Received: by 2002:a05:620a:2311:20b0:936:874a:986d with SMTP id af79cd13be357-936bf8ca37amr174664085a.9.1786583143314;
        Wed, 12 Aug 2026 18:05:43 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b12170sm34235285a.26.2026.08.12.18.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 18:05:42 -0700 (PDT)
Message-Id: <374d148f43036077c31c5a55ddb1b59da4d3a923.1786583137.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 01:05:36 +0000
Subject: [PATCH v3 3/3] t/lib-httpd: document writing concurrency-safe CGI
 helpers
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The apply-one-time-script.sh and http-429.sh fixes share a root cause: a
CGI helper assumed it had a file to itself, when Apache can run the
helper for several requests at once. Document the atomic idioms that
avoid this next to where lib-httpd.sh installs the CGI scripts, so the
advice is in front of anyone adding another one.

The note describes the anti-pattern, a "test -f" check followed by a
separate action, and the two atomic alternatives these helpers now use:

 - "mkdir", which fails if the directory exists, to elect the first
   request (http-429.sh); and
 - "rm" without "-f", which fails once the file is gone, to consume a
   one-shot marker (apply-one-time-script.sh).

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index fc646447d5..f26e1594ab 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -159,6 +159,19 @@ prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
+	# Apache runs each of these CGI scripts once per request. Apache can run one
+	# script for several requests at the same time. A helper that keeps state
+	# between requests must update that state with one atomic operation. A check
+	# and then a separate action is not safe: two requests can both pass the
+	# check before either one acts. Test the exit status of one atomic operation
+	# instead:
+	#   - "mkdir dir" fails if the directory exists, so only one request
+	#     succeeds. http-429.sh selects the first request this way.
+	#   - "rm marker" (without "-f") fails if the marker is gone, so only one
+	#     request consumes it. apply-one-time-script.sh claims its one-shot
+	#     marker this way.
+	# A scratch file name includes the process ID ($$), so concurrent requests
+	# do not overwrite each other's files.
 	install_script incomplete-length-upload-pack-v2-http.sh
 	install_script incomplete-body-upload-pack-v2-http.sh
 	install_script error-no-report.sh
-- 
gitgitgadget
