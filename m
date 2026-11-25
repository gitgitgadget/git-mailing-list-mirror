Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633598;
	b=4zufDGNQB/rsbSk1tsyTp/g+nX41tcX9G4qaWJCnbOfoTONsa8psLW1OHlD7+Jvp7pNb
	 +RILZYfPAxfAAJfGwrRN8eAGfsa8C74LA5vTcNVXOyEUycIXlTtk4y1sfno6xBSqkOV6M
	 +799l23sC9HcpA0nzbb6NWWYs+/st1QTARgtXLohN8B+ezymm90a1zMdFAKExWOHWLVNM
	 MecYfZq5XI355FSBZBICph5d9MhqoaawdKOZAXUjeXUhC/IYYTYqmWv5KiyQetPMx0Ky1
	 YjQek62SiaAoVuE1/gPiPKlI9at/BjcWgXBLMrBgn+pF/h8LakjFiBmzNq+wVAu5p1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Z0Akfym+JPHTsS7/MhXnnLGPx6jZ8aVxbXnnuCNSxZ4=;
	b=jaf0dPMYQiXlhbS8iVf2gDAy8w0I7yJa3nUtzu9NC7k5GQI9J4XBrzjJGKga61ASWjTP
	 Iz0AH/ZZ5VlaOfkPX6AFCCTrTQh15mndgf54cH16LOjUY0PQanbip0Y/whJh88WouFYH9
	 QMnkkuOvNA1GUt9UQPKhHgDKdaqkfO3N6hijEq/EMyX00F/JUVyoqHbpNqKepLej5st76
	 mCZTxLgwG3RknZp4766QfJaVG57gokO688uA5rdSGjaI1F8Eam4+9luqt77yAc9HQO2Ps
	 9JO3qvMsJ8qeMxF+vqJ8jDAnV/K67ryANKzZcG4bMOULe3kYEj5psximnNXCsKRCbSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u8BKTe2Q;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC45606A323
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CC45606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u8BKTe2Q
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-716c0217635so7286417eaf.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633597; x=1796238397; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z0Akfym+JPHTsS7/MhXnnLGPx6jZ8aVxbXnnuCNSxZ4=;
        b=u8BKTe2QOoBT9AHgb+XtX5wFQlKruN/fKBmljdbSltKaaGO5NfLPKZisbbwjFVpJ3N
         WJUFs+jBeaVKqHwRXbqyQcETLN9pmjGlIcNZhk4THBd+ryeSdzQTRRbDOvKFqGQKXgwz
         WYR6vbR6hPCxY9MGiecBYsylxTuuaJuG0SUg8bcgBN1TjVoBNlbl1EIVhV7YTsmR8LLl
         +nb9PCYAQu7/SzsMYDDH3GMfb1ySqnQ/RUeROb81iEj7thJ0/mW3DDmri2zWuidnjzRp
         vPmCVaJChdky0SMb8Tr1wUL1dsZyOGaRnAi58sTLQWGOfclU+zcf7/W8f9NibXQ4HKZX
         4E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633597; x=1796238397;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z0Akfym+JPHTsS7/MhXnnLGPx6jZ8aVxbXnnuCNSxZ4=;
        b=Sr8SxV2mVMwLP1tAkzxaIP206xzMsVbCMb9+oDHGXxJJ4kWprCN8MH0BRneqmV41ip
         36paU/epYtb6y7MXetGhe6DcLaXJo3LhmzYj8d3AXQauN/nG53RBEKl0YBw5nk7CZzbD
         yGLHXlI51gqb/rToB9oxlBkxYVgFPzEbRESWUSRof7bL2eD4MvUMO+6XoiiLjRVC53yw
         0mbdE+ezwoqQHbGffxgfP6wYnCdNbByCLDLe/TwzXvQ0nVsTCk43Q9FiokgwqzcFgyJA
         Hs2DLx+fkAkyUAeo8rEpOK3DNn6T6bkLdCeuGduI0tYO5yHZwfYVtQA3PQmjdqauQc7m
         AGzg==
X-Gm-Message-State: APuU4Z+VbR/ThePksm34Pc6Rluo7wBx+9BECILR3ZrYILS1x5KR9Ji7R
	oVa0y9aOumy/NeMwxG7RVDbXCx9RosrmhjNaKoazr2v2WDz3s2JBCAIuUjrTVzta
X-Gm-Gg: AZFdTZc/bpPZq3nf1WTEAl4FyelI5pMO49FocRNq0FJXjIPvY8wAtLVuv3ehsrnIzqs
	NO68xVkswUfLx7lOa9w2lpESjuwisIu1o7X+FK0yia5+XiWLZL5PKdJwPSIZfBO33zUHu29Y/ul
	s3h4PS39OnCDIyBv41fCM72zLdJqYObSm4I7kb55Okmw4Ph1sP+c0ZmAG7dxVmlRFUxqkApsjfC
	p5GuvT7vDxjjthj1fa8e0M2nnnWF74h1tVAQ5swZ5JpraaJHPoTuOnCT+m+noOeCLi3v7UaJhGw
	4NHqmwIP9Tg0xU8lQnsBbFcusrRv4mk4rfBWKOjm6Kfv4AbsDPlh+wupauQuHSYMwsQZS+Xr/q3
	b9jSuOmIO/f2DKkkfmyRQvdqnyn3sJdw5QNWkqbrBgWkZa5rHH8rSMOqXHirkvUPzzz6GSMCzuc
	v4YsU+vjzYg33xuJILMQtGx24Q28eyIeo4niud9eO+CRNlGAHPEuZix229boEI1zARM/hzdlcmW
	nidtSLLGzKt84U5OuOTUI4OWxTRBl+rk98Ms+naaG9Ovqgf7hyvQf4Cz/Kcd+cfQnCRQounPXTS
	xqQzB3EDp0xDMG0IQobNqG65dGNcEhA/
X-Received: by 2002:a05:6820:2909:b0:6f7:384:a094 with SMTP id 006d021491bc7-71b326c83a2mr15112889eaf.26.1795633597106;
        Wed, 25 Nov 2026 11:06:37 -0800 (PST)
Received: from [127.0.0.1] ([40.124.78.245])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60491337sm16961811fac.12.2026.11.25.11.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:06:36 -0800 (PST)
Message-Id: <639a7a57371e1384a7b551c76ca616b7274f01e0.1795633584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:06:24 +0000
Subject: [PATCH v16 7/7] remote: default to --limited-fetch in a shallow
 repository
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Adding a second remote to a shallow clone used to still fetch every
branch that remote has, since "git remote add" always set up a
wildcard remote.<name>.fetch refspec regardless of how shallow the
repository already was. That defeats the purpose of having cloned
shallow in the first place (for example with --single-branch), and
can make a plain "git fetch" on that remote hang or take a very long
time on a repository with many branches.

Turn --limited-fetch on by default when the repository is already
shallow and neither -t/--track nor --mirror was given, so that
adding a remote there does not by itself commit to following every
branch it has. --no-limited-fetch keeps the previous behavior for
whoever wants it.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-remote.adoc |  9 +++++-
 builtin/remote.c              |  5 ++-
 t/t5505-remote.sh             | 60 +++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index 39b9281293..2216a2a752 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -57,6 +57,11 @@ Add a remote named _<name>_ for the repository at
 _<URL>_.  The command `git fetch <name>` can then be used to create and
 update remote-tracking branches `<name>/<branch>`.
 +
+If the repository is already a shallow repository (see linkgit:git-clone[1]
+`--depth`) and neither `-t`, `--mirror` nor `--no-limited-fetch` is given,
+`--limited-fetch` is turned on by default, so that `git fetch <name>` does
+not need to negotiate history for every branch the remote has.
++
 With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
@@ -79,7 +84,9 @@ With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
 that tracks all branches, `remote.<name>.fetchRefmap` and
 `remote.<name>.fetchUpstreams` are set up so that a refspec-less
 `git fetch <name>` only fetches branches our local branches are built
-on. See linkgit:git-config[1] for details.
+on. See linkgit:git-config[1] for details. `--no-limited-fetch`
+explicitly disables this, overriding the shallow-repository default
+described above.
 +
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
diff --git a/builtin/remote.c b/builtin/remote.c
index 18fe6f697c..8163fcc618 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,6 +16,7 @@
 #include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
+#include "shallow.h"
 #include "odb.h"
 #include "strvec.h"
 #include "commit-reach.h"
@@ -238,7 +239,9 @@ static int add(int argc, const char **argv, const char *prefix,
 
 	if (!mirror || mirror & MIRROR_FETCH) {
 		bool use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
-			limited_fetch == 1;
+			(limited_fetch == 1 ||
+			 (limited_fetch == -1 &&
+			  is_repository_shallow(the_repository)));
 
 		strbuf_reset(&buf);
 		if (use_limited_fetch) {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 679d22fcec..61cb53a589 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -144,6 +144,66 @@ test_expect_success 'filters are listed by git remote -v only' '
 	test_grep ! "\[blob:none\]" out
 '
 
+test_expect_success 'add remote -t keeps an explicit refspec in a shallow repository' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add -t main upstream ../two &&
+		test_cmp_config "+refs/heads/main:refs/remotes/upstream/main" \
+			remote.upstream.fetch
+	)
+'
+
+test_expect_success 'add remote keeps the wildcard refspec in a full repository' '
+	test_when_finished "rm -rf full-add" &&
+	git clone --no-local one full-add &&
+	(
+		cd full-add &&
+		git remote add upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetch
+	)
+'
+
+test_expect_success 'a remote added in a shallow repository defaults to --limited-fetch' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetchRefmap &&
+		test_cmp_config true remote.upstream.fetchUpstreams &&
+		test_must_fail git config get remote.upstream.fetch &&
+		git fetch upstream main &&
+		git branch --set-upstream-to=upstream/main &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--no-limited-fetch overrides the shallow-repository default' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add --no-limited-fetch upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetch &&
+		test_must_fail git config get remote.upstream.fetchRefmap &&
+		test_must_fail git config get remote.upstream.fetchUpstreams
+	)
+'
+
 test_expect_success '--limited-fetch works in a full repository too' '
 	test_when_finished "rm -rf full-add" &&
 	git clone --no-local one full-add &&
-- 
gitgitgadget
