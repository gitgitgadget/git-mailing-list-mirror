Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257763;
	b=FXzqKmodIvcoDL+mmlsE/F9N2tD05hifa/pL/QUmaAd6/YVq6ErN1UPGpAYria2gIwZf
	 4W+YJDZxt5QZ3X4ZOqQ+wgwD8xDlYPxWM2U5Fdb7kABACBIIYmkN2Ykm13UPi+A8JaWd8
	 CHPlk3CmhzenkoNxIJk91Mf1NXBxZZDjGkcoOu/T8mL4BT7G+zsMpgcMxfO39pHNccQxz
	 kZ5n7jb67Kyy0SsvVqEtvRQTBPwMuqHBrLbQQdaO9jtu6DLtSsRTNvJZyCNy/BQSr5ehS
	 sIv2JcHyS15rPI/LbXiWpaziMuVauAXI4+uewuA99jUn65x2tMPw+fqxcU9Pj6+tyJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yD+1+fPQOO4lGeFLvUY1kORUJlQlZEDmc8jcUQhjEhg=;
	b=hi+DOUeKoXcBskw5p8Z4rAVimUPiiZMvhhvAA53Z/P5W9LiN+L11XyDtqliIcDgiLHHQ
	 uOdeaQ7Su9s4rl5ua01Et+VDJA4AKwXx8t1yU2xmQTrdc7dNmkZf9l0WGNiUh+2eW0ssW
	 Do9e2UYa4eQ1ByltJRb0GdLYyWs5/jn1emBWogZbfPNTviB4KZjdrB236ERe/RZxq5q0R
	 wOMx3RBoNhKXrql5NJY2H4kT+B+ERuW1js0zu8/PVaZfOD8B5Sd4WYY7AJTWShCZv3q29
	 XNmDNx0We38ZRxDlpf/MM+wgvjqoPvBCJfvGBQphTYCLbTSXiTxZ54B8ae1zugxPCRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHj5+nD4;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5F606A339
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 10:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05F5F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHj5+nD4
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so2818697c88.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 02:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795257762; x=1795862562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yD+1+fPQOO4lGeFLvUY1kORUJlQlZEDmc8jcUQhjEhg=;
        b=tHj5+nD4NdMs51S5ZY/RRdFhrDuzOxutBerG/3dlYjsKRtXU+wWtKf8IDtGywzEOHg
         ffsELpHqrGSkAwfvNHluewAGg0iU9gEeYMpbmULSQKVSx9CmWQSKtlL1QRrs+iuGL23F
         MK7i8a8cqEP5+wdC03Cpz57WXEGpOwPeVJsGwH0ACkuiEurW9M7y8wMT9ybKonTrfywX
         w7WnAtF6MEX+5280AX/rvXvZ4fSrkZldfKPWpTJLX68sTTTnlUA0aVrk7c724nwCcAvQ
         T4ih2y3tRxQ1vOOXFoDL5f+D0Yh0m0aJP+BJ6Xf8eKM62P27H2xj673+Wfyyj1HHt/Ro
         nJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795257762; x=1795862562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yD+1+fPQOO4lGeFLvUY1kORUJlQlZEDmc8jcUQhjEhg=;
        b=cpywxnpRrwIM8AWJSirQF0IwzZk85cGJQNcTmrzglX1q0veyNRqxhLzYeDAiA1Qjbo
         L3XzYx+cdJ5QrLpiQMGEe54M7ryvIBu7koIuGC73YTmQC3rbHGIdwhWixkMYTlfbLNSM
         GrlooWSNAcP3r/oRQwyj/VoXncGWiuai0v9ZXwXkbpQsZWEB78OSXyILANxhbUhqRqKT
         PH6y0irmmKOT+umXoJpB/6xGJSUfz1dfu3z1QBx4GCmOgsxSYFQhamHtEroxUaheSV/m
         xWsjGdVUSTthYZt380T+wdvqEtrwPkkFRMz2x6Y/IuwaTT8x1L776a3Yig9yBRD4Mp0/
         /qWw==
X-Gm-Message-State: APuU4Z/X3YpvqlgUf3JKIyTWpuapmreJxNTrscmnjJzmBNWnRkV5GDho
	vnIrp5um0Q+bPNqB/RZdk8w24PbLdl2aPg9PbZzvaFDhURlievA4zB6Mtc9+XtrjO9k=
X-Gm-Gg: AZFdTZdXpdMdpHsFDqWQUDfFLiUZrKfGtHA1AlFbJa+2rLArk/jxJmkKRjQTDfuXSTg
	XTR7eVCI7s9VOrJtdhBV2Z3f3jWGZc/1FviXystcFFtY9a2SxZ/U1TVDcSn/EB7mzp6fd1SCv9f
	j32U89SFLqEvxDEOzTEa8xh5feUQtbCLEnmyc3KD8t5mDvb4+5x+1tdfq09DisrDbY8s/2MAqfZ
	NLam2lo0F2aeC0cm5vC6QDGU2xnm3XuN1OtMtNqmvXWJzZ+UWzmW+nHmLfr+tBgaMJZGN7Ub9Gq
	1YNO7oLzuXcrRa36ogCIBd74xGmle8bjWOVrOXfe2DPiMWPpXofAxUwtN7oivg6RfF6Cl3uIiEA
	pzJmj0PdZILc+Bi2ec6dxAPcQCT/hfNvZVOilOLiFDUG0a+caCGcEqn0gZz8wP9OdMygX5DX9Sz
	magZOGtYwW5CwTjafA0OPdKy2GxKwjA7LXsQu5Iz2rEiZr+3A8Hnzr2UmiEn+m+P/oTI4dXcD9h
	8SL44d1loPrLqV75osLrDmDiPH12nR8Rr2TwdoXsAr/Ak+N0sRqCyWvL/vZy5T0Hzn0JeO5/cpB
	IrdsBInfnuhSpk3ucUWsaPnjKnFR+6BBInFX9ByAK2EnkhDiGhMBHHISisZnj9Sc9v4Pz+mn8fX
	Aoy1m2ytycKXFq7ukuRFF2g==
X-Received: by 2002:a05:7022:38b:b0:1b5:2dce:1b6d with SMTP id a92af1059eb24-1b55689ab30mr6723320c88.17.1795257762080;
        Sat, 21 Nov 2026 02:42:42 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm13290463c88.15.2026.11.21.02.42.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 02:42:41 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Sami Jawhar <sami@theorem.dev>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] combine-diff: fix the shift for the 33rd parent and later
Date: Sat, 21 Nov 2026 16:12:33 +0530
Message-ID: <20261121104234.98386-2-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261121104234.98386-1-aniketgupta3001@gmail.com>
References: <20261121104234.98386-1-aniketgupta3001@gmail.com>
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

coalesce_lines() records which parents lost a line by setting a bit in
the parent_map of that line. The bit is computed with 1<<parent, which
is an int shift. For the 33rd parent and later the shift count is 32 or
more, so the result is undefined, and in practice the bit for parent
minus 32 is set instead. The line is then shown in the wrong column of
the combined diff, and the hunk header can disagree with the lines in
the hunk.

Use 1UL<<parent, like the other masks in this file. parent_map is an
unsigned long.

Add a test where two of forty parents lose the same line. It is skipped
where long is not 64 bits, as the masks cannot hold that many parents
there.

Reported-by: Sami Jawhar <sami@theorem.dev>
Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 combine-diff.c           |  2 +-
 t/t4038-diff-combined.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index 717d537688..54d0aed6b2 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -246,7 +246,7 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 	j--;
 	while (i != 0 || j != 0) {
 		if (directions[i][j] == MATCH) {
-			baseend->parent_map |= 1<<parent;
+			baseend->parent_map |= 1UL << parent;
 			baseend = baseend->prev;
 			newend = newend->prev;
 			i--;
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index e11b711388..fcf7333d7b 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -127,6 +127,30 @@ test_expect_success 'check --cc --raw with forty trees' '
 	test_grep "^::::::::::::::::::::::::::::::::::::::::[^:]" out
 '
 
+test_expect_success LONG_IS_64BIT 'check --cc with forty parents, two losing the same line' '
+	blob=$(echo file | git hash-object --stdin -w) &&
+	result_tree=$(echo "100644 blob $blob	file" | git mktree) &&
+	parent_trees= &&
+	for i in $(test_seq 1 40)
+	do
+		case $i in
+		2 | 40)
+			extra=common
+			;;
+		*)
+			extra=
+			;;
+		esac &&
+		blob=$(test_write_lines $extra file file$i | git hash-object --stdin -w) &&
+		parent_trees="$parent_trees$(echo "100644 blob $blob	file" | git mktree)$LF" || return 1
+	done &&
+	git diff --cc $result_tree $parent_trees >out &&
+	# Check that the second and the fortieth column mark the line:
+	printf " -%37s-common\n" "" >expect &&
+	grep common out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup combined ignore spaces' '
 	git checkout main &&
 	>test &&
-- 
2.54.0 (Apple Git-157)

