Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF82D2495
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704668; cv=none; b=H6TutgbJfQywRKhtNMYGb5/YJuOf7agyPWbt6SrspaGwIpuM7fDLPb+ZLnfL8876/ZPxFRAzg5LQr4Sm5Ii0zUIKjDAhfG8eaqDhQHN8KUbwps3V+OOSLlPNx/sxEY1s9pG1hDO6pRxd2DvqMG0oed/H+qD3aLyUJjRmScMmh6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704668; c=relaxed/simple;
	bh=XFTg39389gYjl4DlYjrE6Fh95Gp/ZuhV6U1JCuP5HtI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XAM4w+CqwO/j9bBedzuSc0727vxc8Egy63u6pQdgRmqmw6Ar26lX0hn/WgyvoiNZjlT+JyjDgmpTWCrahwQRL2jJLOLJfkIBubgIshR9iHdDHrnc2Ap43uqI6tEQBXeXzbniKVreia8dDabwHBjRidUZDSCfUMatyvp91JldxSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx5hAbVb; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx5hAbVb"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f186025973so12360866d6.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783704663; x=1784309463; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cUabWVce8iHwnQPOo1Z1PgqpL5/OZl5hPyo2Jb0poJI=;
        b=Yx5hAbVbE/Q36wpdPMIZARK96OWQAWwHlwMHxcvioPAE66VuLDE1+c997mHygACzU1
         ukrHvjYUnvcaJtlt4FkFWXcQSjbRdiGK5wFUYVXGRkX3+U4HwUikxQRpXEBhITH9SNm7
         sFHZ8PVELW83MPQ33NT6LUAL5bq1M/z36nUs3V0r6Nl3WqohvKcwnouFaidn52oFvnhY
         r8OYo3S+nfvAgbNLA+r0Jim/eZlg/4nHeFcR6OcVpCob7kIp07gCZim8yGoFMf8ku6eB
         fnhBajNro6cFb+q0r2Oxg1uUYviyKdtegedWcuDvJVgUu7+axe0FMqeojR4hV0ehVaeG
         nusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704663; x=1784309463;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cUabWVce8iHwnQPOo1Z1PgqpL5/OZl5hPyo2Jb0poJI=;
        b=OefM02ufDFm4SgcQx+KqTszQui0zog65F6IArjLDHUWhV8KfkQPU1oqyIdNqV+7BaP
         SMpKI0xRYhOxFZTwgzLf1s7wjD+kBPFBzBQxzfWnGsaYV0n8CkK5tsMPIifvaSI7Eb0/
         8f7t8yjEK/eDWarEak3gPBbKK/cCaduhD8vDjCHnzebGp1UejIRQfg4UfqWYffwe7153
         0hDhgn1Te4B8u3klgzrZUUF5OseoJLpUYz4pwVJxQtiFuikYS+K26FFl7Qecy8OF14jd
         E92fSBaJtIrhNfVsmNSSWiGayuF/7CBL1UmATu/4dRFvnf4RByQMisLAI7InzItGp3jw
         qckA==
X-Gm-Message-State: AOJu0YzphZHekbgB9cJgl9eM9zOE/4zP1TVMIS2GkTH7AE2CQeF/kqNg
	Az10P0bTzFprekd5Q9pFz6K4vM4kfKfLwmJeWmrwhDZMQi+pLmtUxy2wUk9TkQ==
X-Gm-Gg: AfdE7cnrz6vzBlvcphZQ/UquDSGxIIEwtvEk9YohoqGq53/zP/u4Y195wEOXDvnqqb6
	SBfzPqdK9+yhFU2QBE4kXCVSz2DiYS+PnHoHod3u4WDURjPj1siEoNCMJZoiS1kvwBm5byNXrSk
	/C741tVqQP8DFdBisIG8eMDek2hlUg5GIAoKX/OoJ60g616fCU0Z4/ckwM9YrW4J5x4euH1GHFA
	JAbOwCMbnIHGX+uDy5vWHXVJmc+TmLYjzoCKiIq9qCR4AwHI+M/TMoUWV9DHatfLJMIxsFfYV1Z
	kL9Dlr3O0NbLxDYWUl2jqTO3wALYt1Ok4IWZo8NrUcfP51wkucdlKmEQ1gQJLaThs7nQqtyZ80e
	Dh78IDgbuHremuxhunV7qBBPImAjff4eIVDj/zg+0G7LJ8ePiZU0+BUkWei5G4CrQHaDYUw2SMS
	XdfCsKEPMd+IP95n+VuvvnNrsxcTI=
X-Received: by 2002:a05:6214:f24:b0:8fd:6e32:2bfd with SMTP id 6a1803df08f44-8fec3ff6ce9mr158455806d6.62.1783704662555;
        Fri, 10 Jul 2026 10:31:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.127.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1da1bsm45863386d6.30.2026.07.10.10.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:31:02 -0700 (PDT)
Message-Id: <f158e1f92e9c586fca34faecaef23f9581d65478.1783704657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 17:30:57 +0000
Subject: [PATCH v2 3/3] t/README: document writing concurrency-safe helpers
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The apply-one-time-script.sh and http-429.sh fixes addressed the same
underlying problem: a test helper assuming it has exclusive access to a
file when the web server can run it for several requests at once. The
atomic idioms that avoid this are not specific to CGI or to HTTP, so
document them generally, alongside the other guidance for writing tests,
and leave a pointer from the lib-httpd helper list rather than a local
comment. The note covers the anti-pattern (a "test -f" then a separate
act) and the two safe operations (mkdir to elect a winner, rename to
consume a one-shot marker), citing Git's own lockfile machinery and
make_symlink() as precedent.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/README       | 32 ++++++++++++++++++++++++++++++++
 t/lib-httpd.sh |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/t/README b/t/README
index 085921be4b..a9d425f392 100644
--- a/t/README
+++ b/t/README
@@ -854,6 +854,38 @@ from the test harness library.  At the end of the script, call
 'test_done'.
 
 
+Writing concurrency-safe helpers
+--------------------------------
+
+Some test code runs concurrently: a test may background work with '&',
+and the helper scripts installed for the web server (in t/lib-httpd) are
+run once per request, so the same script can execute for several
+requests at once.  Such code cannot assume it has exclusive access to a
+file.
+
+When exactly one of several concurrent processes needs to "win" a
+decision, a single atomic filesystem operation can make it, rather than
+a check followed by a separate action.  A "test -f X" then "touch X"
+(or "rm X") races: two processes can both pass the check before either
+acts.  Two atomic operations avoid this:
+
+ - "mkdir dir", which fails if the directory already exists, so that
+   exactly one caller wins, electing a first or only request (see
+   t/lib-httpd/http-429.sh).
+
+ - "mv src dst" (rename), which fails if the source is gone, so that
+   exactly one caller consumes it, claiming a planted one-shot marker
+   (see t/lib-httpd/apply-one-time-script.sh).
+
+A "$$" suffix on per-request scratch files keeps concurrent invocations
+from clobbering each other's fixed-name files.
+
+This is a standard shell locking idiom, and the same reasoning behind
+Git's own lockfile machinery, which creates its lock with O_CREAT|O_EXCL,
+and make_symlink() in t/test-lib.sh, which uses an mkdir lock: an atomic
+operation whose failure indicates that another process got there first.
+
+
 Test harness library
 --------------------
 
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index fc646447d5..d64f9c8c2d 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -159,6 +159,9 @@ prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
+	# The web server can run any of these CGI scripts for two requests at
+	# once; a helper that keeps state between requests must do so with an
+	# atomic operation. See "Writing concurrency-safe helpers" in t/README.
 	install_script incomplete-length-upload-pack-v2-http.sh
 	install_script incomplete-body-upload-pack-v2-http.sh
 	install_script error-no-report.sh
-- 
gitgitgadget
