Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437375;
	b=Oj4uaaPlvqt2fbAZqMuKChuJEeBTl4yyN4+xq54umuhSXtMC7TNL5clgCMz83htFOild
	 6Mo1H/fyznKpLLDOaXOhwbZzJ30LiWGNXBSPbUQcKJ/EfyC/7ytPYJy+CHbzvegEFuMiF
	 4m2oqusl9yBv0jLFiPLvsr+Ill4AUM5s3uiV5pT5g1fviEPMTGxKcgWFPOX57BOvZYynM
	 0LhgGDSplOdA6hOCzyGE6u3vYrA7tTSnMqOacE5Dq/JQqOdoZlbo8Cu0n5eYeWp5IuxMh
	 dEJoCKvm9D31IpurF/N6qWtujNXSr/8TubLOer6POOZyGiZN6VgYwB5ZQ1M/Znbg3Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=2fY4MnsgY1Ma0iGidqE6W4+zuJKOdqsAeUD5xVMt4wo=;
	b=dUUXrfPObopoO0CDdEuAVCRWcOwW5gMMe5nkTR1J5gx8y8pEdTKSKsZzXY9GHiVdPock
	 jnlGljS57Msw46pa+FNpD+rGEyrn6XCvB8QD0YJBLPnAtCNefCvQzk74sU0olHIo6gWGA
	 bzR5uCMc4zB65BgYbubkzIZLg1Qsj0rZyiSqLUNEc35Xwx68bwVa8vjG5mZvV8Y2Hz+0+
	 1QvoSbLc+91SpV93WleTU3yuPDbJYHyVqAI+YFU1MiGJ87mYWYO4yZ15M+zC4oL7JVPr3
	 uGrnntmaaJtKoCiEmPtCchVUdh4NsaiLYoI/3iiXlYlQZHNgllwz5MxOTGwTgca9tBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gocJVT6Y;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07706606A335
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07706606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gocJVT6Y
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4ad89c49e0dso1176969fac.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437374; x=1795042174; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2fY4MnsgY1Ma0iGidqE6W4+zuJKOdqsAeUD5xVMt4wo=;
        b=gocJVT6Y4gFuzROX26uchGn62ktV5gig9gi9zJFMvo7FBNfqfzcSJ6h5HLpl4FAod8
         +z9sOcKJ/1YRFQwtvK+7uRF1Id2Bqx8fRu/YiViY1z2bXADX9j+KbX3NA7o29DpfWV2S
         SmDmhVUJsWMPEredNNFrsbePS6416V66XwTFWzEGilww3QpAG5lY/0QBLOtNk+W6BGiD
         thVWNEjUXEtPtZ9BV6l5dkBdqdPybSq5WfKGqzpU2SnuKhjXCu4Pc0GoKlEmbfRGv//i
         ePca2sCDBu9avs84gxEJBsq16tIOAocBH1uX8P6bxluh6lKVva8OR6FaSLwyCAMIi5r6
         8rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437374; x=1795042174;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fY4MnsgY1Ma0iGidqE6W4+zuJKOdqsAeUD5xVMt4wo=;
        b=S9IDNErflLdUsI7BfAd1hG+NUI7tW2k/+l3lQ3Pc32hRzy6UD0BpxvJMt9uL1fBkim
         EbwsEgX0mUpt8hdAiPJ2v7rSJB/klteQCbDxD8KFtyk5F0qXAB7qZ1Wx6+oro0HQ9/TD
         f8x5qMyS6EY0LLo4Pu8SephsoBSfyhFUySIXSdVU0vjI/FxRHHSWvKpTa/polEsiBsOD
         B7YFOHTwItfmEFVqrsPzu20L6Uasl7mct6EdgGpNvW6Kny1PfPiSIzs/KwgqavplhSeW
         lR62DXaElZSZ93yQZpDNCp2zRBNGUr7Ws3p1qLsSwLCAOGEBkhR7Fnqu04W/ekLSv4Z3
         m/Ng==
X-Gm-Message-State: APuU4Z98RLOKi4lqumh3NSEqMVLXBzrvrbSa8l1DRUxNYdTfjjAdLIVS
	IpRip6r85w8YZSWj0EwPoWaIiYcxJ5zBNqPPBL5/nLFDaL4vd/ISUvLT5K/hKC3J
X-Gm-Gg: AYBFou1jSw1v4zXHBhJyj3003wOl/OhbDikWf3tChRNLZLgTLcvsPLrIN8mcd5y9Pe3
	9q2BKQHhThSoPI15DWXl3U6+EyJAmOOkdaJ6A/wuGoQkdPNlnPoghhJsBP7r7rXDVSKTo1XaXkh
	Mv399x97cggd6bVtw9laQEIobkXBxTRLRyxsKm3ZD0tmai7BtrCUAnWzHXovlrh5aDVIM+oNkvV
	7AdI9zWQS48TdT/JWCPWZXbaVvgz5TqXbD2E/DgapYfyx2SUq027iXgSS/Yw9K5q+1XAVCq4fXa
	VI/QHjMqjavcs+GR6TB/U5cGIxBEE417UBpXmzdHMHLLuJ+A5zUH2KWMyMDvwQvjnrx6Q+C1LTz
	SGR+a+PBvIdyRXkwRa6Ua2U6cbYcCBYYtSUXFiS7acAFyUtLFXGwqkm3O8X3I/WlYjQ3G6NztWQ
	siFIbNetSAcWcfDcBOcl5zqfdo2V74pFYPNfKwYnzkdkGyir5w6GHSjzuYTGQh2KFu7Qnn5zyYZ
	qnK3tLvMAwocXtK5HgZ6HxQK+lmncDNsmW7x/skD+e3wV+aa+EMNlM9R0WUht6XJNXaxmWvhsk5
	yibfDuoQT6xIRmIdiq0u77LM0rbAfN3b234=
X-Received: by 2002:a05:6870:46a1:b0:48f:e24e:6b6a with SMTP id 586e51a60fabf-4ae46cf7957mr3658518fac.61.1794437373939;
        Wed, 11 Nov 2026 14:49:33 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22f6a1c7sm4018753fac.6.2026.11.11.14.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:33 -0800 (PST)
Message-Id: <90209dc754de398aa150459d7b324fb41f974a22.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:08 +0000
Subject: [PATCH v3 08/15] merge: handle NULL value for
 branch.<name>.mergeOptions
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

A branch.<name>.mergeOptions without a value makes "git merge"
segfault on that branch: git_merge_config() passes the NULL value to
xstrdup().

Reject a missing value with config_error_nonbool(), as
git_config_string() already does for the other strings that
git_merge_config() reads.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/merge.c  | 2 ++
 t/t7600-merge.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index d7bf209114..c6f9356ccb 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -668,6 +668,8 @@ static int git_merge_config(const char *k, const char *v,
 	    skip_prefix(k, "branch.", &str) &&
 	    skip_prefix(str, branch, &str) &&
 	    !strcmp(str, ".mergeoptions")) {
+		if (!v)
+			return config_error_nonbool(k);
 		free(branch_mergeoptions);
 		branch_mergeoptions = xstrdup(v);
 		return 0;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 8f6109fb91..2da12d6662 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -552,6 +552,12 @@ test_expect_success 'merge c1 with c2 (squash in config)' '
 	test_cmp squash.1-5 .git/SQUASH_MSG
 '
 
+test_expect_success 'merge rejects branch.main.mergeOptions without a value' '
+	git reset --hard c1 &&
+	test_must_fail git -c branch.main.mergeOptions merge c2 2>err &&
+	test_grep "missing value for .branch.main.mergeoptions." err
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'override config option -n with --summary' '
-- 
gitgitgadget

