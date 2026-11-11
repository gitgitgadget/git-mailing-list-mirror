Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437383;
	b=RnYFW5SYRVC7AplRKp/k65BF9Kl8695BgJsjR3FXZzukV7sfydafmM6GkpGUGxfkSdKx
	 hcz61r1s41YGMix4ce5eZ7cF8/uPRjtYRQWvoUNckx1Vkq6TcLpT3VaS6ShZsLNgVnA1M
	 bxjXppVSXqYPsu6klvMvAd8k/e2R8KmZ3frwGgojerMAtS+80Sb0YufXaDbVc6QL5nde+
	 ufaR3a7Irx0n6oqQWcty6u6beC+caRd7xvJAd18HEqDUlQkelODn25eYAs8tNPQDpiUqN
	 qXxQZr7czJlgwveB9yi/mUDxjcULwULyo07+MtYRzkSMPJurp/PELAG/5UYllXdlDQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=MpQibAg8X4msOndVvsdNzuZUbPprPXfZAwJh5lqCkR8=;
	b=EuS15PNfBCeZUd6IJJA2sB4k/LCQdYJGH0oNzQ/0S9TbYCqMEK0MkExaq/BXrOG/1/wY
	 csJjPxeXqLkiRMiPAoDWOlGtzpaoxS4LqmVsXYZc2xCwhasKyRH3fnmh1nPuyO/7abrB/
	 uwefMfS8m6oymjkVgsRV+QRf/fiH1OWPaQouDstsrX4n/aAuZeFlIob4DAztQq0kQ3Jap
	 VZM0Xs9tufV2RRoVU7rO2Vm55VUSTA8E+buKBMjIHc8DguTElegxSiq+b0jWcyhpuAd68
	 7tZeItC7A++c8ML1aRiiEN9qlgBCAAOh4inRkuC/n+UYfjveaoLIMwHrDuIE//yhIrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTtrNAoK;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DA60A2636
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E60DA60A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTtrNAoK
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-85ac281604dso2107929a34.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437382; x=1795042182; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MpQibAg8X4msOndVvsdNzuZUbPprPXfZAwJh5lqCkR8=;
        b=yTtrNAoKU7JXIdp1hN235F8rCbJ810IwAjakgYpsepgYOLp9SXF/AVw3sisPVRa/L2
         HISIPASBW/jx6LEFblDBfHD12QYqACHl50jXDy7Y9IW7PUHmoqI7c2hKHpx3tfXGUrQY
         pwXbqouwMamgd1ErsLxAA1HGXHuj+MdaIQRnkfF0bC19f2qC83wHnJSMIGD6Wn0/FwT1
         xqauj4InOmtZLZOj61uong0ytuacPR3fkkkIWKa17jHfafpYqjzJ08+PTvr3clg7nEmz
         3jXkjRrAcdx+hkZpZsawRv5O9c95aPqEfoAH+6e3aB2VvbdcA3omQT1DPVMBB4sM2cSq
         CESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437382; x=1795042182;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpQibAg8X4msOndVvsdNzuZUbPprPXfZAwJh5lqCkR8=;
        b=kz5AnpbZ8EFO2r1Zs/B0PmNQNfR/NuzLy9havtbQ90imAJB1tFimZmbsZUVFTapBwZ
         cDmTb0iKdU/pxr0bGVIHTag3CH5VQ/xprCdcbx9aUJdFCzwM8NfEL/qKOfWfUqoR2RvM
         omJatuPUbJzBMz20oTc5d9SRO9WMIFzRY22trAba0OdsVeR+FZbDM3VvwgOVQTV71vSZ
         5Vgzzj0VGQCmKi0aREZ+tMxIdW/l4c06e7AuRarqyLfu6a9XUTvxeNnyZgvqDlXIxB1m
         C0NHvpeNlBWhhUmOHkvBUBaFvDbtHsOE/YCS+o/IRTubqJLIEDhH6BCLiykhoT8zBfgv
         K+SQ==
X-Gm-Message-State: APuU4Z9jTVZqxWBSOS7M2CTtJcPP1YbJ9oOdYowFgw/7JK6TbXyfCSBo
	4gUSlM/QOPvL60P3JE3kCABlpupNvUujyKL6dt6AaQXTgi9BoKXRBKwy+m3Ku8L8
X-Gm-Gg: AYBFou22qcOd6dlq+w0lhUUue30VxSXz55aj5VLxdYZ5n5JTB4dasPzxxfjIAx1Aply
	wCySYdZ6J63hxpZnl61t9EUS2ptBfmWvT9s5bZn41TteK8QDAa597CvcF+WaeeR6Nd9DEcW0KjA
	4G+NvaKiF6gLeW4RvxbkURoGvkCe52Sn1z1krujzC5NIEfHSy+cNvhJIL6MDu5ijASBcLy4sRe0
	W9aJF0ORmOHS8oZwwl+Qsdks6m0ByCnw7r9qeUXyP8HY1FVY/7ZPuqFHIpo4+b/E4I0TI9S6VGy
	AHa41E0rb2J/z5lVWfKuUMZJV/JCudWeaIab+KIpF55DkbsEro7DZzJOuzQStMgQ2b4WlwnTLRK
	YiEpEF6pJZH1IU2sCPjLO0CT79mziFxmqJ8wMHWlLPcz2rVzHq6z9v3/KIHOCpGWDPGgUAnWKL/
	GkI+mHi/xbPFYKbscT1dDLlUr6ZuMO/4hN8OBsil+oVJ2bH1pVlQ/twa76Y8i0lvZ5RDZb3vxfh
	POiRQLOoVdC1o/lS7Mqzv//sPYQlA8uKp0cFXrnbVIT0Oau6vRwjkSz8BtYFSXTr3N7cB6uuswP
	5ZBNG3puzNlU5Vdl3/cH4WN3/aDPkKJwYTA=
X-Received: by 2002:a05:6808:2217:b0:4c3:7695:1177 with SMTP id 5614622812f47-56b9284654dmr3642777b6e.6.1794437381780;
        Wed, 11 Nov 2026 14:49:41 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905146a03sm6220355b6e.6.2026.11.11.14.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:40 -0800 (PST)
Message-Id: <510dc56c9b2d6f38f38318f6c812a7c9ea059eb3.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:11 +0000
Subject: [PATCH v3 11/15] pseudo-merge: handle NULL value for
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

