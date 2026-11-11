Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437378;
	b=Q8gInw6ojJYZmpGCojQFufjKtlQFVD2aNkt/r3OmtvivzTu+RdPSQdz1yLQmIR0NFyBG
	 lwhThQ/iMOyqMvj6LYB+nUksREobNYHGHJk1pWQch94kuL3mLEZhe/YzeSkHaiWbD7rmb
	 WuviAp4H8ZfCQa1JEnmS7BG+cZUIG1xo5vRz1/hVuOlV3/XqRvJNC+uKUV/gK1Yymfe20
	 ybnnmQFYgB7OGityFGllDctBC7bIIFrJOD3FAibu+3kCmKTAWZ6S5lcGLmyuNypaArUF6
	 RO5QRGuj9jbj3oMmw7s+hYklvYWzL8xoXdrzgX3O/K/IE18RBjdw21OISAmDTcDc3qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=/LkDmNOGDoIfkyf4Wp6QygQ+Q1w1fdicxkZ/fhyiKJ8=;
	b=cXQzXMt6F9keZdhVHmPFX3jjkEtw3bRzBkvjt/TEssCUsX7DlWMSNqwjoM5tegbkktqM
	 uWWjTrMHxWDRASa53Cg9L+0E5BH40Rn8o4MM4n/SR/jYqA5KiOtkzamB63W9cI5p+aUH6
	 nCsXcn1EbMGVTnZ+ir8bXzYcXQa83rvIHQtCgckSo4xcHB1LP0x6CrN3B3dJqvVz8/73A
	 RVFFO1Iqx4RFqU+X3mHMziS6EsXBTD+Yyfe39FlkjNOXFkectxxUqgmRJQrQRA+hLpzNQ
	 6nn4RLfkeoTCc1maP14i3kDbL2L7dNlePVdSbF+xPVngYYruma2bvtsT8pggnQIcrOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M41mbEPo;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACA606A331
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDACA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M41mbEPo
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-48e94879f02so1286754fac.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437377; x=1795042177; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/LkDmNOGDoIfkyf4Wp6QygQ+Q1w1fdicxkZ/fhyiKJ8=;
        b=M41mbEPoj9aVz2sdI+Vj7ENQAqPu7ezvGivo5EHqu/nM3jQjCGZT6/Mbb02uxfZgxx
         +ePBGHq5l1gcII9ZcbpEuPlMyG74ltoYzJZqmKy3yJw/6K6N7dydl8iR2sDeFqD/CveS
         jryMHj1Iep55MDylUfBlADo40nO4ctXRAOQcOqGvCLPbh14Ymubn1PVGE5CQ15y+g5Qh
         G+CXiPXJX56arwczuf7XOkLRBEwtA1ChV41BDScnyEsyRGiBPTJnr8M/S5Ur2b3gXNZu
         E+CVePVvsyCz6BLu0hXONEyCCwBMARWithyNerYld2o8VAG0+9CrkgqBkCr0TGRdACky
         uVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437377; x=1795042177;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/LkDmNOGDoIfkyf4Wp6QygQ+Q1w1fdicxkZ/fhyiKJ8=;
        b=Nj2G2BO6OwAptVp6v9Po5Fxc5GM7OiChyQDjfrZhwcimuUdu7y+h8LFlIeR+qBZ+Uq
         499zHmQtqcKldwcDQRGSTzo/YoRJWUO4BTAyy75Fp5N14ii+C/aHTW6SHjpBzBUEVEDD
         2DMKbr4OstHm3xsRhKhTv7C4KgTpFefN/VvR3RXK4cTUnHVsxehw9mgKeBCkPhHQOXd6
         XQubZAFdMfzmSrodVk2S5lOP0FK8XF9OjD/s/4iCt5chJKHlsTIHLX3OFsCaTbADM46Q
         l35P51jNozV3I68pKdBmBdptCEuMz5u6yYq22mL+MMq/P6JR5+Neyq/5javF1U/pARrz
         YBHQ==
X-Gm-Message-State: APuU4Z+ktddyz1Vecnkq9WCaqFVXMcKlwLP99xy+kRbtEftFrwMx9vQ2
	2wdZQVqdtHWYwvVBcnDVBR3MIaJnTFs997v6CPec/VzOSJHP2kHVl72G69nvuwsk
X-Gm-Gg: AYBFou37zq0AWDAa75EaDrT3fNROX7g6+XA6T9gruqGrvP4VaBBQjY4jp63uilza4sH
	abUVpQdMgbQSyQZSkd2hk4pS0XGLJPOxtM9+NDst58GOaSdiNodT3bg7kCPfcmdAdXEzp8sivf6
	v8uGI195o5yVwHBDKG83UZCfmHTRlOXtAak+FjoMIT+qiJXkQWlsitWqnK81Lj3bZOJOF3LQP54
	znVALZzxclhb1uz2j0Porq2ZXCAGnZFfHB3M0WP/4Aja/bxR3ZXGC2a88Et1+jZ/cRV9M/A6VtK
	adt+c7b5gFHOkb7hdpC6hWPZ6HxhKXde1aTeduCYOeQmc05VeDAeHsELuwGdvEiQq2qS862C/4p
	dX0PJxUo6b3dDGaUWrpgvbDwIKrPbViU3lXX/cNhVFF8G5tTBnsBBqAZi87UmZbpILEIHyEwbdk
	xvItXH1B0qEiQJ1OxJh5PNBLdl64xdMxHuANAr/vQjjA+zjdp64RbYu9KCngYHaiXCih5QYL6cv
	z7l9pfmjVpbr7KcM0T1h6Wveu2RZD+F5C38VlGH12K1BMFJ6Ded4kZnwxMEteLTQWe4BRXATvKI
	PAZOPyXRRqX+kWFYVzax2ZNbT8F8qrSZpnk=
X-Received: by 2002:a05:6871:2b08:b0:494:9c66:77a0 with SMTP id 586e51a60fabf-4ae46bd7b89mr3099049fac.34.1794437376777;
        Wed, 11 Nov 2026 14:49:36 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22f6a1c7sm4018805fac.6.2026.11.11.14.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:35 -0800 (PST)
Message-Id: <f30ecf07b4ab5c6e17171a008d1e17f713ed5305.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:09 +0000
Subject: [PATCH v3 09/15] remote: handle NULL value for remotes.<group>
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

A remotes.<group> without a value makes "git fetch <group>" and
"git push <group>" segfault: get_remote_group() dereferences the NULL
value as it splits the list of remotes.

Reject a missing value with config_error_nonbool(), and keep the
whole key for its message by skipping the "remotes." prefix into a
separate variable.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 remote.c                 | 5 ++++-
 t/t5506-remote-groups.sh | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index d3164fee69..80be49acb4 100644
--- a/remote.c
+++ b/remote.c
@@ -2200,8 +2200,11 @@ int get_remote_group(const char *key, const char *value,
 			    void *priv)
 {
 	struct remote_group_data *g = priv;
+	const char *group;
 
-	if (skip_prefix(key, "remotes.", &key) && !strcmp(key, g->name)) {
+	if (skip_prefix(key, "remotes.", &group) && !strcmp(group, g->name)) {
+		if (!value)
+			return config_error_nonbool(key);
 		/* split list by white space */
 		while (*value) {
 			size_t wordlen = strcspn(value, " \t\n");
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 16e9a1bc2f..f11eb8511e 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -54,6 +54,11 @@ test_expect_success 'nonexistent group produces error' '
 	! repo_fetched two
 '
 
+test_expect_success 'remotes.<group> without a value is rejected' '
+	test_must_fail git -c remotes.valueless fetch valueless 2>err &&
+	test_grep "missing value for .remotes.valueless." err
+'
+
 test_expect_success 'updating group updates all members (remote update)' '
 	mark group-all &&
 	update_repos &&
-- 
gitgitgadget

