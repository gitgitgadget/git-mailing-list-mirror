Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296237;
	b=ayD6nQv+/YQP7+1qt1oX076uJvUozz0DrDja7MpyFW0R8TVlH3KGlhQCdCGoiw+xlfOP
	 udacxlr3vKvbtTocPiumrgcpVDjymxg144aDjNtOnBbcAif1TxQ2kFXtzwYuiwp0Y0pAm
	 xzHbXbrrVofzny+RYw5333gQIcd+LvaJvESPi40S+GuqGOqYXzOVMVlaQqIOyAZwe0EmT
	 J+Kw+OyAYTh/+wf35XN1Ra7xAiSm8/tKEeE+xYYS+b7Ke5HhMTcOIlCT1sVwSdksKRuMx
	 Pc4sTXaxh/oVseUpiuX3a+ddhjJXBjF0UmkM27d2ovCNOF80llzulpbGGeBI2gHk4bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=MpQibAg8X4msOndVvsdNzuZUbPprPXfZAwJh5lqCkR8=;
	b=nKg/y0bMfTqXebpjei8gGtt1+Yl2HY9dSbEueipBv5ch679a/pjcAC2bTXLH4Di421qy
	 OkjZA4pc39BMxM8mC9v1fWjIb0LAYGiDKr/EQqkGKmHapDeO7v/JrPMSLKEjj4ZRzqgxh
	 aUxehAJNqa58bfa5kU+6SQ3/beasITQKYQYlLtWn9NZNTGJpiI5cKI+6Mebr3q1/SmKRl
	 /v1oVC3nEaHSnTUZ2/lUk3f8xoUS43tcEXeRHe7c8IE+vh7Bp+mwcR7OphY1si6ehQR9V
	 0ednZLPrSObBHibaMZuJa9yC7WMKNrlcdi4e6lI+Ap21yty3rw4fwSGZSVMUdGOaa0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nbxlZibk;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BDB60A6F6E
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3BDB60A6F6E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nbxlZibk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a76f63b243so1254364fac.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296236; x=1794901036; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MpQibAg8X4msOndVvsdNzuZUbPprPXfZAwJh5lqCkR8=;
        b=nbxlZibkFftKKfjP484JifXG4miF5DD006zLxJ2RX/3pC9G/2Zk0865zh0MOrGDiMV
         XWtNcjwVIzelt8GXShv5zQFAnLsfUN4c6bi4pd/780uOxV4RrtQ/ytGRIZW+LeHcloYK
         iLeKoMoTeR7mTmgtPGRJg/5fZEghuXWg0fFkKQ4eSBbttgfcduWKkSbiiNwl7FJknTPc
         TcdDpIW8HsuFmuaRVqkh4KJB2n4i97ZYX+oi98EdekzhA/0NqWvLU7iV0JSLykhSmAPM
         84gUaBQtemQjYlygJW7pusdgUcjBiLXfb6zTHPmRUV03LDkn8A/77AOgUXvPKZM1CU/9
         eXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296236; x=1794901036;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpQibAg8X4msOndVvsdNzuZUbPprPXfZAwJh5lqCkR8=;
        b=Yx2AIT9khnO0GSFBzDNjY4/lAMgx95EdhNjbW+580jB4hr1og6FniB1Ie2F987TQ+s
         c4qGrsPY6cIc9r95mwFpMyAAdbhYBpkWwlF4pth5tRx5mxN7Vq4OG4JMtwnofj9LWDiL
         w937+uJwqUG7zxyiwEt7m8YMqCIv8Hr7G1Hv8hTBPsVWgit1TIVgKzXkJB3CPjtZfTg2
         LDZX5u5q5tUjsCtCuvZRBCizQiVYuJcaLuAL4SxOB2a1p4bWZLEzYGrKReCdvHDKXzDQ
         DLyUrJ+LwxT4ppi7VKkFX4Qc9jbaezgEcqw4CLSzXnpq1rVQkOF93drThzPg8zQ49KRD
         z25w==
X-Gm-Message-State: APuU4Z/RbA/Z07M/2+zfL0V2nqcDdcank88y5MaCBb3cL7/heJj3FWRh
	V/yBHn0uKyBRv4QUuo6tlIkee4YIAcbMkoQWsJTrtxPoHqybFIZZetYeb87BRSTq
X-Gm-Gg: AYBFou1DXuAGpxh+lDDP99aH69k8a/UqUjPpM4Ykk6jKpA7WDC4HPoDB8xE4eC28zOS
	lrXtUJUB/jbGvlF6XQE+1LxJ+XJADFFyp3qdUyIFsZi+JpTWv9myWkb6R20GUMp4U8gIewQ3Ns+
	X4axGrF6x6e1sscZoDMJ7EiJMV2uDcaQo96OGD0EVXza08QDR9CA0RzcKNr2EKw5Nx4pHfvkDnH
	EijGDQvCSKd7lXEVMH3BVSu00BUgbqdmvc7jnKMJRcXlqXMqxKhN104xapErptziagNEHmZrftp
	YqSvfHFOlooOQpu+jPVCpy280Oy5FH7citCqbT98Azp4ENWuf/VAYmHG75hTlfnivhFwHbZLv+s
	ZBkdOMbqkdfQqOy1uPdFkqFQH4JvyeyvaLcw+bnflMxhJfnv7ouVfqgT5g+lELhGd434YrIlNR+
	C2Oup3eIp2U2jDIiihWnJtzejwqA0inmZyUv1WLngxHgLztnsYuv498TJ2+c8gOtvmD5jNM9NSI
	22Kfv9KeJtn8b86BM/pIUekU6WuHMsh+Oz+4PAF6BgKnMace2EL8vjA3vb0rbcoxIaXKdiUUqxn
	88QnTkOjVQ7bpz4qirIBKzVGZ5zCai6tM7HCKF3iMYLCqt8eQPw473qS
X-Received: by 2002:a05:6870:3b84:b0:49e:162e:7a83 with SMTP id 586e51a60fabf-4ae20357d14mr880054fac.33.1794296235666;
        Mon, 09 Nov 2026 23:37:15 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fcdc93sm989524fac.10.2026.11.09.23.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:37:14 -0800 (PST)
Message-Id: <1533ef9cc6c5f4eb19007f22fa85709ee5870a77.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:41 +0000
Subject: [PATCH v2 11/15] pseudo-merge: handle NULL value for
 bitmapPseudoMerge.<name>.pattern
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

A bitmapPseudoMerge.<name>.pattern without a value makes
"git pack-objects" segfault while it writes a bitmap, e.g. during
"git repack -adb": pseudo_merge_config() dereferences the NULL value
to see whether the pattern starts with "^".

Reject a missing value with config_error_nonbool(), as the callback
already does through git_config_expiry_date() for the threshold keys.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 pseudo-merge.c                  | 4 ++++
 t/t5333-pseudo-merge-bitmaps.sh | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 22b8600d68..19fae9233a 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -150,6 +150,10 @@ static int pseudo_merge_config(const char *var, const char *value,
 	if (!strcmp(key, "pattern")) {
 		struct strbuf re = STRBUF_INIT;
 
+		if (!value) {
+			ret = config_error_nonbool(var);
+			goto done;
+		}
 		if (group->pattern) {
 			regfree(group->pattern);
 			free(group->pattern);
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 5b2a17f90a..e7e6b2f8a8 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -233,6 +233,11 @@ test_expect_success 'out of order thresholds are rejected' '
 	test_cmp expect err
 '
 
+test_expect_success 'pseudo-merge pattern without a value is rejected' '
+	test_must_fail git -c bitmapPseudoMerge.test.pattern repack -adb 2>err &&
+	test_grep "missing value for .bitmappseudomerge.test.pattern." err
+'
+
 test_expect_success 'pseudo-merge pattern with capture groups' '
 	git init pseudo-merge-captures &&
 	(
-- 
gitgitgadget

