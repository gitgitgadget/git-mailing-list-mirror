Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040993;
	b=GAl4djJiJ5pX1DsqGBWsgRpUARdJJ6sel+jXooydcDFBWeEXcxCHH8nuKdgL718h4FZA
	 oyqo5gCxC8wn9WX77Lwu/VpRNsuYkd6IrVm5JbesDgWVJkQ0hfxf2sBYv73FtH6fA4870
	 GbDXecOdNguX3yzqWxUek4GCAIhAwHqXkfhMrsvJpNax1nYE4jBG7aAizh+GJXEUW6Ws3
	 ztTugI+mhNpG7UPzKIGMJPqDMVPyGRtyoRP6YOzvt0gaAFnskWkHHkxsKeGNTM+DId593
	 1u45/17g1R8CKSxvFHD6avTFQmuIwrYUZxSEq0gyyQLYPScRsmcn0DP4O/Gfx+R88pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=dybvKjemwIujuuWlI3Vr1RL/sCvbi3EVG+N3Abzb3TI=;
	b=HVfc6xn0iaM2UsR2VwKBWgsf5sJQAYSM2i6OHn3ocrm6rbADr9Wu5ZCbejYRdB1lt+rd
	 QwnpenS2NcwdcWped9pdYwD3s6w6tsj4Arx9uDoWGybFrBTM8+o8LYU1u4WEXFgDHqjY2
	 V/ZT/EcQP9pORjBfTMUh58PZAKNGJ1zhLXasMXOMWbW8TkU1kfCM5OyI26rL4Ftq2GiqR
	 vwz5HJEFQX6Oq4/xQQcNAROXoW4SmpGbAnv4JPL/dQ/wQ6ShlW9dLlzg62qBi/u5eDOsm
	 +RpqbcMEmxIxxXuDsw1VHCAYkVjlMWaTpPATNG+PLejKp/2xBFXwFoTUpMf42R34nLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y5HwHo5v;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F041606A32D
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F041606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y5HwHo5v
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e987b4a710so1592505ad.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040993; x=1794645793; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dybvKjemwIujuuWlI3Vr1RL/sCvbi3EVG+N3Abzb3TI=;
        b=y5HwHo5vzjPVjGKyLCT63kSc6yWd8xL0rnZpW1ShoERVlMo8EqVg9x5GztMTO6oeXV
         4K/pNp3F5hHbiD/VVhfswQiENJ6w4tJciX/+3/oEWWw01zbjZb4vEzC3a+lPX16Rdgpq
         Ppsa5h2UGMWGz9SKb/Axw/UaCe0BV1IYIfbHxcBrkVt/3XervG1buNoFt701mtckBa9S
         RMY5f4WWib4ZlfmqCjaoYcXJ4gLnX7HJ4dObFAJigrFN6mIhXVKfokotxL2OURbmNhQP
         C/suHnygipZH6Zt/j1xV3Gms19nO7aMZTLzzI5lB5R+seGEBizjANRiC6bQs8HaqW3DP
         DlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040993; x=1794645793;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dybvKjemwIujuuWlI3Vr1RL/sCvbi3EVG+N3Abzb3TI=;
        b=KTA/c0U4jX4Y+sNSBbgox6LfnqbqnZvllDGLH6D7ZWKpcB5g2XN3EUEPTUKakjOp2f
         elMyrsCRV1BhsDPf4eThv4rh1y2v9l0sQPxTiXHrQa34x++QJ72Sunvk9bMZ/k6uOguZ
         FR2TVbKKsRipSIEJV8IiiIGFgoIgRj4SgPzoSxaTAurhAQZ4SgxGzuSlNb1DcG3miK3a
         Dv1dM3ZkWn5WA3y7hfE9q0PePE98BmO9RqrHo2yncnJ+6NcebG2Ixvnvy1ODe114K2gc
         IyxrTss8LTEhVbpRLxde+85RiPWwjlPiasYj9WOtW5wNzVjl+ya1Zu+jffJ5j+FjHr4D
         sGIQ==
X-Gm-Message-State: APuU4Z+TANnYo9tS4PuTzsp2eJosW78tPMvAu7G2FkZADi96q9aZ0UPi
	QvEioMF+UPSBBx5jMWsnlkOlfgda/h2X897wnwrtT8SE6tWv0A9nLPO0o2MS3w==
X-Gm-Gg: AYBFou06ftu7jKTpYzEgXTw4axkgeNcAF6LQ/OPmbU8M70w5ALCgPcSde+v+crw+rIY
	IvlGP//IEL+KIMGMIBUZtuKJW0hEfwuFa+LU02ze/wt19qf0AwiNnGEPscM/kFJwxRf+UzQslRu
	9tdpmm/6Vn/phQNlj3qUWQz6IOzLXgJ4mpGUGSG4RMXDU4rWxM+pPHkslZd3ejGzU23aeT27wBH
	+nNBudSNaKuOX31kAwfFjC/3dPyOyHY96tYaHuB6YsrAIu4mFNgCxv4Xn/WPmgoyzYlmhOu3msq
	auNbC7QCsX64dDcSIGWabKhlphgnrJicMAf2V65yXL5bHpbJBb4s3UPSUrDvAm0VWlRA2IQjvN2
	GSExdJDNIjJ9MZrp6JhcZNidkkQp8kGReUPCVCQmifdQ7hmkbvp69epw15vJGOFxAxGNjBl3kuJ
	EOSr7wGeuUBfCJXQSjTzKLNh+TH8WFzrCpvUfEqa1pZ4cpxTpOdNtKGKAChbhxc9ky73WVx8B+7
	STa9ol4DSD5PK+oLWjwSOEkRDEx37GqmfMXx3DW/hIEQXlQsVHi+D7+vJGs0pJ5o6PCRH1PMkzb
	XSSznkR8EvFf4s21QeqfG9sHU+EmEr8Jhg==
X-Received: by 2002:a17:90b:1c84:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3b106496dd5mr1150922a91.32.1794040992694;
        Sat, 07 Nov 2026 00:43:12 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105831cf6sm2529253a91.11.2026.11.07.00.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:43:12 -0800 (PST)
Message-Id: <5c12b13d90c40fdd933bcb868db4b593f47b99a6.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:45 +0000
Subject: [PATCH 13/15] config: handle NULL value for remote URLs in hasconfig
 includes
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

When the configuration has an includeIf "hasconfig:remote.*.url:..."
section, a remote.<name>.url without a value makes nearly every git
command segfault, "git log" too: add_remote_url() passes the NULL
value to string_list_append(), which copies it with xstrdup().

Leave such a URL out of the list that hasconfig:remote.*.url patterns
are matched against. It cannot match a pattern, and wherever git
reads its remotes, handle_config() in remote.c already rejects it
with the usual error. Commands that never look at remotes keep
working.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 config.c          |  3 ++-
 t/t1300-config.sh | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index e0bb29b53d..f6ccfd52dd 100644
--- a/config.c
+++ b/config.c
@@ -327,7 +327,8 @@ static int add_remote_url(const char *var, const char *value,
 	if (!parse_config_key(var, "remote", &remote_name, &remote_name_len,
 			      &key) &&
 	    remote_name &&
-	    !strcmp(key, "url"))
+	    !strcmp(key, "url") &&
+	    value)
 		string_list_append(remote_urls, value);
 	return 0;
 }
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e3f8064889..8fb920b1ba 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2970,6 +2970,28 @@ test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url in such
 	test_grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url" err
 '
 
+test_expect_success 'includeIf.hasconfig:remote.*.url skips a url without a value' '
+	git init hasremoteurlTest &&
+	test_when_finished "rm -rf hasremoteurlTest" &&
+
+	cat >include-this <<-\EOF &&
+	[user]
+		this = this-is-included
+	EOF
+	cat >>hasremoteurlTest/.git/config <<-EOF &&
+	[remote "valueless"]
+		url
+	[remote "foo"]
+		url = foourl
+	[includeIf "hasconfig:remote.*.url:foourl"]
+		path = "$(pwd)/include-this"
+	EOF
+
+	echo this-is-included >expect-this &&
+	git -C hasremoteurlTest config --get user.this >actual-this &&
+	test_cmp expect-this actual-this
+'
+
 test_expect_success 'negated mode causes failure' '
 	test_must_fail git config --no-get 2>err &&
 	test_grep "unknown option \`no-get${SQ}" err
-- 
gitgitgadget

