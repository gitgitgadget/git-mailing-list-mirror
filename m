Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72666390987
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020344; cv=none; b=BuvVgxddQfpllr4BJFBR2scZPe4NDubw/hcZoBMj5B5bkhvvQ+Ba+dnXJsJa2CDnKEuBWrhD94CSh/JGzJ+j6GWNZnlQxCNzWGtBhsGDyCTc8gxZLoiaTRS5IreNwHD94k2qDEQxJq1EjnHvGU90V9lpvmE8gk+o7ykBLNqt4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020344; c=relaxed/simple;
	bh=rH9Pfavc5K3Qnlyr8UkFVzNeOj0jz7zcLCCvBV4JJCY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wo2GGlahDbqjf+5tiAdACRkbeyn7t1I31LVW4ZyriD5mErY1OlqDZu9/3y/+Ka9LUf3UdaGwtAwKY1rfU+0Mq6DtCRxDcsyX9nssbqHK9ZbV5cy0P+f4fbMLkXG0i6aKpCHRVHm9ppY8oFOzGZsXKnHf46HEnbSYDKXm+vcKdVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8YEw4Ep; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8YEw4Ep"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f7so7256515ad.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020343; x=1789625143; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IChfxMJLsMeEbkLtwiynmJjWNdJLtQ/TdEgVnSoJRT8=;
        b=K8YEw4Ep3VC1PRjWCr/oGs8xEz569c5PMIx4GLc26vvwj5YLNvk6dDytXZXunCYgnx
         Rc1jNFwIQC3fuUtelJngkZlpv/IXfhh9XtKNBqY6myWLizMLgSr2EItDBCdrhHhnHW7o
         wIkt8AQIWWtB/DDTYYmUB+U/JWtq5aSHMbBf1xniiF507/C7etaSZuQe1YdtwD5ZE/U9
         +/uJFitlrQeqnjOBHdviZtg/GRCdHbWLCkvtP8qAZhk5c76QNbK6+Y6Q4llId03u3KcX
         d0p7nswfO5PFVWdwuWoosX//M0v4fdUrlfeHfRFtaRCirOruDo0Q65vea+84L0R4cwsN
         jn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020343; x=1789625143;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IChfxMJLsMeEbkLtwiynmJjWNdJLtQ/TdEgVnSoJRT8=;
        b=pTejoCXpx8uT6cDxV7YKakdNczugiFXQ6P7u5l/iQs1VolY9y47bHKJnDSY+vkzROn
         EiBm7cV49MN9/ne2H4AXQmXQKHtr/vSgVxFdpDIxXwx05n2nU8ElwFonqH+JCfuZCi4i
         uxO3Juv1NXrvcCjJVsb0NdLPAuTKcoSPq0clQJYi1fNS3/qE7Eat8m5TfjI+pRpcZXHf
         xhJQ7kXeQYOv/pbl+0jN9Kjr8hwkUO+IeUKcr9JTPRCwXOTJxdbdQ7y/qBNMxabKc5jt
         kqGrEQB6nS0HZ+jEHKJGJPbUTWTFE8YvyXLbDDyb1jfRKZY+J1WIho5hLWg5rEblCxVd
         0l0Q==
X-Gm-Message-State: AFuF++l829ppyFDyapTGrtkJSljbB2E/LHN35mvXOnurdk587ZWDeFFC
	fkobxvJaH+dlMPdnXI83Qd3P2BwRh76yHECimM7sOQdcniqIPuK/msTOKR8Ckg==
X-Gm-Gg: AYBFou1ixB8TMC/TATt8EQOhMZ26PnC17njD88lbm/XJprN+MPz5EWcf+72kkRAlcxt
	kQMpMpwxZas8qFZ38lyrp7fBz31k6UgV55fc1WpzDCGHf/8OTreaExgtesjO1jPtILEUksCizqx
	x7L/kqbIalSyN1CcQLPxLUd//XYMA4AdYWebrQ0MLn3oNoHE3o+fO5Np4t293aV//Cq+nafQdPL
	P9ESl3NYWp3rVecJnDRAq3puma0pY3U1Y+MXjdw/hU0CQy+sbQMfyuNBZF4K25QEXlFgKlA6Jaq
	frX4yqWXrM8Y1xjqCXTAEX26ijWGQZCH3zt3IurNntTnKA4uHWBoJfZweb5j1AkSsyYZonO+yLp
	Xq0k7ibJJKQ7wohrJ+3m583nn1N8cGk0m+KAHnsQ0h2WezfFePUU7VeolMrH5jroAHB0uKmiWgP
	m1cNHEvlGFiMusKkxkimdsuZjSGyB9CqYHCSGvh3CZvmxMYqbvTZFm+sTkkSvWEVwLEmjBVRJ+
X-Received: by 2002:a17:90b:3c4a:b0:39d:6f12:fd47 with SMTP id 98e67ed59e1d1-39d70bb2226mr8820069a91.20.1789020342325;
        Wed, 09 Sep 2026 23:05:42 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534152sm47910838eec.10.2026.09.09.23.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:41 -0700 (PDT)
Message-Id: <0d2990aa147482a743da8fdbe4f9ded2e7fd083d.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:23 +0000
Subject: [PATCH v4 09/13] windows: skip linking `git-<command>` for built-ins
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is merely a historical wart that, say, `git-commit` exists in the
`libexec/git-core/` directory, a tribute to the original idea to let Git
be essentially a bunch of Unix shell scripts revolving around very few
"plumbing" (AKA low-level) commands.

Git has evolved a lot from there. These days, most of Git's
functionality is contained within the `git` executable, in the form of
"built-in" commands.

To accommodate for scripts that use the "dashed" form of Git commands,
even today, Git provides hard-links that make the `git` executable
available as, say, `git-commit`, just in case that an old script has not
been updated to invoke `git commit`.

Those hard-links do not come cheap: they take about half a minute for
every build of Git on Windows, they are mistaken for taking up huge
amounts of space by some Windows Explorer versions that do not
understand hard-links, and therefore many a "bug" report had to be
addressed.

The "dashed form" has been officially deprecated in Git version 1.5.4,
which was released on February 2nd, 2008, i.e. a very long time ago.
This deprecation was never finalized by skipping these hard-links, but
we can start the process now, in Git for Windows.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 3a90995587..88bbe1d78f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -518,6 +518,7 @@ ifeq ($(uname_S),Windows)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
+	SKIP_DASHED_BUILT_INS = YabbaDabbaDoo
 ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 	# Move system config into top-level /etc/
 	ETC_GITCONFIG = ../etc/gitconfig
@@ -710,6 +711,7 @@ ifeq ($(uname_S),MINGW)
 	FSMONITOR_DAEMON_BACKEND = win32
 	FSMONITOR_OS_SETTINGS = win32
 
+	SKIP_DASHED_BUILT_INS = YabbaDabbaDoo
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-- 
gitgitgadget

