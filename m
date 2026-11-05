Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892535;
	b=EqvEE6gwMjfS/bEwnPV1TUFmE87ndbL0iz0WgX0ymtyTOTRQyFDhknTzThOvWe/c/xR8
	 LHWEXKgTaopI2CpMwUc7RiuE87cMGUrxY05M0soEoRPP+hKg8YOo0OFnpp7WzWiB66MQb
	 wsaNsno04qNyhB2MTdVPhVAJ9R3MN6VxMc3+tiVzrmXft8OSnZPGs/Xke3fTjFjEIaPi8
	 0AQKXZXzW/ODCeEvzpSS8c2ZWnCeaSHB/OKkdEuE3RIzMXFv/0LL7a/d4o8lZ3LACTp49
	 v/AoWevzBmEYFKWN526GKJrwgAk4OL+Ws7MgUcxT81xX/IfGGcvuSHvUvlsqEYqTHRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O0zWEF/WxL9STe6Tusi48s/We7pK/aO1KfFwUPtF+gc=;
	b=ebciK35IV2xAJqe795cQIYWd51pNvRxu+KegaiTrrNIsU90maYNXus5CYMocKMpU0eW3
	 Flxpdi+iVH+AyXhyr6rBckvnVCJkmaoEqaQso9Q4Gg7Hrz+fgLqxhHXZ0OPSCqhxHsMGk
	 MfGvgGtDAakVb1Af9CsmePMSe2KvC2QkqlY3eyEDCKH7uJ7JnPp+o3iiSDuMQ8UD6hVwv
	 m4qOZ66U+hyn7G2rW08bKjIwuyCsui7mLaJzNzvuYR5yHetxwl/KXINMGgKP0tFhxfyHE
	 KTf3NgNsekQP3cH2LR4DVGyjF+35TI5bYszrhAE068i88EwL0X1lXwPrJDvft7z4jtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dsq7TuMv;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55728606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55728606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dsq7TuMv
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36cad25b8b0so2954721eec.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793892534; x=1794497334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O0zWEF/WxL9STe6Tusi48s/We7pK/aO1KfFwUPtF+gc=;
        b=dsq7TuMv9EmMCqAc3djETYAINvHsxPi3K2iC5FX1ZXCpPHof4JDET8F7+NED6yi54z
         BSCi9QFOTCbIrBfFJGHj+MpCWJpDKJ/xb8h93iayQG9AmCPbs9PD4J8VaVAGVX194hrq
         dVRocXmp4PJqJ99CoxzhUfriuDDBLbbDCgms6D5VqSIMki9/CzKzAVPKFIvahyQ30gJD
         d97OAx9TnfQwoRTrinrcMAd86Z/WBRamisbBOUum2wV24AxOrZ6BLMQ6hAhC0/Fgk9VI
         9gP/olj4+MAK6ydCxf4NCVdcDy0RvGPhjuqsBI7KOFRMVWpsYaoH+uXW2hejIaBK7RSM
         clnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892534; x=1794497334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O0zWEF/WxL9STe6Tusi48s/We7pK/aO1KfFwUPtF+gc=;
        b=e5FrU+N0oxcAtv1yp7NdFEMrMdnunnx0fsIT4sS0Pnn3DrNQn41cwgIc8KDYFvttLJ
         GOud6KKLHcU4PkFYBITE0nHwkfQ9jt69lBNKhdrahKYtRoHpRoQScLMxdo5icc99Re7S
         gjO7Xqleaj3pwv2dPFYuZyqy9hyyEpDnuOg8Oa/3Oaj7Aj0xgHWqEZ5Uu0/caPiBEKMp
         gUcOOSTdPkmKxG/cMs2HqoXjgAMsvWgijTdEyd2zFruQ1mKFPbmRNHAgH2oNhS/pge7X
         F9ZQpMqjlNPZH3BrvFULiOhNR8Fj2Oswid115QGNGIszcv11iHSnU9rAHjvouBDN4y/v
         qkrw==
X-Gm-Message-State: APuU4Z/EcvbjPFQHcW7DEosowM/Q7vfnb4rRMx5uHXXx3hiw7RWTHbzz
	+n6kSPtKiEGlEx3OJM5CpzTgMJH8SgpfVmCQowcbkeYxco23Rb74ZiGISjVho6t+w90=
X-Gm-Gg: AYBFou3wMV1h4njGGi1FQG36+5IaurdlALnR9pxSjSosdB/Zz8ySYrp/78sSaC+Q+l+
	mA57irNwV8gLky+seT6CzIXNS1QVfRVTeKYHXiv4TGLlip4qnV4zpzW3fjljMvucwzDfrGSgblO
	V1OpCOzBb9zG9wJoFQn2L3Xa6q/yl7GD1vKXFfV30ggNliQ0tEMWZuiSpqNrjsRHLqaVFe4vCiH
	NliERRu72pRhFov7qaUK76bTgDvk6BSok+4JvVhhvTopjFrJIw3PgiBVmpCAESg97smjxk5elCb
	egKr3bNgGx4i7bmN7XgfxuZ/HB/qi/D1OBlROADwoSBgnQe5mYDycjlKVBmz1w7CJaRylUEpebG
	l0z7VDQEFbP0hwscFtMvp4I2nrrbWheama+l59KlPsDYqY6/Zphc6tr/dq7fUEOWFVcUI0qc9XC
	Vai8r053vT2hL8X4jCAxWGgvlWN6ZoFiI4TDqJh66ISIL9G3Hn+nZ9BwukeB+fuHLUxqAqwsA9/
	mBF2gCgjMCbbI5NxidWkbKIGWt0R0o5jQqt3O7RKazSVaeCbKHs0oIg+NP1ZcB4l6Q4d+0z8Jdw
	JSse8RMEKmfGMDBMYzmaYbOHoCMThqaZny7SEfBhMsx7x7p03x/koD5J2XKfZp83X95a0wUYWQ=
	=
X-Received: by 2002:a05:7300:3b0c:b0:36a:238:1485 with SMTP id 5a478bee46e88-36a4244276cmr40211628eec.37.1793892534211;
        Thu, 05 Nov 2026 07:28:54 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39972d4sm32391113eec.26.2026.11.05.07.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:28:53 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 2/3] remote: do not show credentials when relative_url() fails
Date: Thu,  5 Nov 2026 15:28:41 +0000
Message-ID: <20261105152842.566318-3-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <20261105152842.566318-1-aniketgupta3001@gmail.com>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When relative_url() cannot resolve a URL, it names the URL in its error
message. If the URL contains a user name and password, both end up in
the message, and from there in terminal output and logs.

Pass the URL through transport_anonymize_url() first. Also name the
URL that was passed in rather than what is left of it after some
components have already been stripped off, which is what a user would
recognize.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 remote.c              | 5 ++++-
 t/t0060-path-utils.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 899d805b76..36834b129c 100644
--- a/remote.c
+++ b/remote.c
@@ -3078,9 +3078,12 @@ char *relative_url_gently(const char *remote_url, const char *url,
 			url += 3;
 			chopped = chop_last_dir(&remoteurl, is_relative);
 			if (chopped < 0) {
+				char *anon = transport_anonymize_url(remote_url);
+
 				strbuf_addf(err,
 					    _("cannot strip one component off url '%s'"),
-					    remoteurl);
+					    anon);
+				free(anon);
 				free(remoteurl);
 				strbuf_release(&sb);
 				return NULL;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 56faf5fe73..cea0d13429 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -394,6 +394,15 @@ test_submodule_relative_url "../" "$(pwd)/addtest" "../repo" "$(pwd)/repo"
 test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/submodule"
 test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
 
+test_expect_success 'relative_url() does not show credentials when it fails' '
+	cat >expect <<-\EOF &&
+	fatal: cannot strip one component off url '\''https://host.example/a'\''
+	EOF
+	test_must_fail test-tool submodule resolve-relative-url "" \
+		"https://user:secret@host.example/a" ../../../../../../x 2>actual &&
+	test_cmp expect actual
+'
+
 test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../foo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c/" "../foo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar/" "../sub/a/b/c" "../foo/sub/a/b/c"
-- 
2.43.0

