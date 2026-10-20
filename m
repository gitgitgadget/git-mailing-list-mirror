Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497287;
	b=eiGLA6Cz1jhtvuRB3QeEsEiVaj2oUuXe1DEovQhP1eMtIIPTwCTKwKoGRj+tUZhyaxpG
	 ein/+wASVRKfYtkvpaN/8CVwBfZIzFxBYSnQvAaojfaD6IM92BDcHcWclP6DpNIbtfgpo
	 uTA6VXx3sZCsjS0PcwlrUVuAwXCS51hQXzHlCvAKlZ49dbhNCABBE1Y90ssXtaGQSRWmj
	 wBPFXnq5W1t4kZ/ABm8Dd/f6eWrHmDs71PWZ7LJAu66CpI1445y6JeotREmBFOxVs/ewx
	 zgZ6GIo6r5v7KKBJWPBc6akbwV4Sd/LehEhmObWbIyc3Rgl/8wK1vEqevcWFHX9tTiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=PrNhNdm4kOZvrMoAmZrQgTepay3FkF1gEUiYlYePOUE=;
	b=KbvD95nU0NYVdm6lOV4qk0eRmo7DWnXXacR9m6WjrXty9RE0+ivy5niB4G6oeUlUQRBh
	 S9qfQgiEfSY/gY/Yv8ol08RtqbgJ2aD20ftKjuU/+O3OBavrz9k2FKJqqb7phDMeJe8ON
	 mwVjMV8wG9oanhQR3GzH3LuYa7Pr+8AxXK5tCdj62aSThmfHwxFWoj5gbEmtqwiKFJH8+
	 KTkPOuVeD2LfTamZq4jRaqi3DOOdwakEgKm9u057h2mrfC6sDzq+ivRyCllcGZiXE5mqx
	 rXSd8KNKDeHoQzydhZL2S8DAMJCij3nVlEl9qysgnvc23muamo0e3QCnBCW0N3ug6hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pSq7gYvR;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277FC606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 277FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pSq7gYvR
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4af81963f35so1805976b6e.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792497286; x=1793102086; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PrNhNdm4kOZvrMoAmZrQgTepay3FkF1gEUiYlYePOUE=;
        b=pSq7gYvRtJCbU4xQLSi+3QoHhH6M0joO8wjgzCiDPkmzSpOtRn33DF/IbRJizL96K5
         3lRcTt6DDI51WBPcOaXgD1Xanh5sRV+pWxI/8JCpyLbSHHLP9YhSCBRlW761+A6zZwVu
         EaPjs5muw8LidqWoR9tZAgoOUDBzkC99UYPVQPJzM6ubCXcrIXjmNKdxNxnK4hbfjtt7
         jBOK8x+5xdXxNSv5VftBAKAlQwvCaD9yhre/SaHHs3OvC3CHQyHvNaaCLR7ZoSKqHwaD
         qxKay4H8qxnHlK8tz2TtVIdiOvl+PnsQ25r0SJjo35tlzaAQX1BbMH7PrdUBfbL2meF4
         fkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792497286; x=1793102086;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PrNhNdm4kOZvrMoAmZrQgTepay3FkF1gEUiYlYePOUE=;
        b=2cTR8Y9SmR0TL3JdTTZhVR3iTXWHYNoolYAfla9L/qmaQTVdOSlB+rGKN26VJ1U7ly
         J8U/hDV64+8G7gCOD/6hF7ar1YFw74Lz0ca0Kt4y3DCs9FtM/qd1tRt9djlz8TMK3e+q
         VfdA+q10zPUjmOwfu0+oEmnqdEFay8wX4BmcDo/H3edJZIC780h3v7EUFp2DlpRQk/vc
         2G2wgxfmJiUTB1rjV9bbPADvnQp7ASrOvErTyqwIqM3W8BIF1tnNM3EalWMP15cDba0n
         wG13B0B863xXzwIN6kpq4irYmu1Wj9x+dPl5gKhXJuML+qg9tDXeoUuJAXOECcA2lhIu
         T5YA==
X-Gm-Message-State: AFq9FYJlg+VGqmgMdJ72HSNeFmJoFJLvKauQt0T/zI4JwRZuArYP/wVc
	VtiMxnGVdyQ0Td9Wjxy7qyT4z1a6t6FFXPjOKqC8rbHmdECHN3EfU2ke/1YiaH1u
X-Gm-Gg: AYBFou3T92AcjN8IcT7+sRVQOPJfX50RZP410zMQQDhmCPEqtaVtSey1ybj1bNBbD6q
	BLWVqahG3iQztbFQ//9vRLX9nYV0vkBzbtuuy59dGO7KJszFNA4DfDfDCod7hVO1aPFSm3+munk
	7QjmXppbUIHgoD3YPy0jtRsT7lvjKasTThX57M8GbSN87agyxvrulmZDNLlKY7B64pBI5wrfWdD
	n2XWyodyEYlR0a5i1wORTJl4+SrCDbHZJQnv/Xo1nAJCGiEDzEkBiojWUpdy/WzflEv3xB2+WXc
	MDxjQIBV9//dVBmwbyHVi0+ZO+RYgtsDg7ElmyoA8M7lbHK7wTWlAV+8BTwW/gzol7kjt1qhw10
	ZWzMlskSB8yjx4SKe2UHwQr1JZ1J3xaf+zWs+yfM2UYlRwECjwClJ8KwCSYhRt8h7f3SCF6P/ZK
	k2FC3VDOQ8yRV+bpwtZvXOhLQaVS0mnFfkcJSRd39t3kmwPVc09Oru+7rFIt1jZe45rE/HbLfpY
	Q==
X-Received: by 2002:a05:6808:1585:b0:4e9:4aab:be51 with SMTP id 5614622812f47-53cd63bfbcbmr8287786b6e.67.1792497285993;
        Tue, 20 Oct 2026 04:54:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.124.148.98])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388a5572a9sm9337530b6e.4.2026.10.20.04.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:54:44 -0700 (PDT)
Message-Id: <pull.2270.git.1792497283164.gitgitgadget@gmail.com>
From: "Roger Koranteng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 11:54:43 +0000
Subject: [PATCH] t1010: add basic tests for mktree --batch
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
Cc: Jeff King <peff@peff.net>,
    Elijah Newren <newren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
    Christian Couder <christian.couder@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Roger Koranteng <rogerkorantenng@gmail.com>,
    Roger Koranteng <rogerkorantenng@gmail.com>

From: Roger Koranteng <rogerkorantenng@gmail.com>

The only "mktree --batch" test in t1010 is the one checking that it
survives a concurrent repack. Nothing covers basic batch mode, which
is how the leak fixed in 6272f3bd17 (mktree: plug per-tree leak in
--batch mode, 2026-08-29) went unnoticed.

Add a few tests for it. Two trees in one batch should get the same
IDs as running plain "mktree" on each, a trailing blank line should
not add an extra tree, -z input should work, and a tree that names a
missing object should make mktree die after printing the trees before
it. While at it, check that a blank line is rejected without --batch.

One test feeds two blank lines in a row and expects an empty tree in
between. That is what mktree does today, but the documentation says
trees are separated by "a single blank line", so I am not sure it is
intended. The test records the current behaviour.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Roger Koranteng <rogerkorantenng@gmail.com>
---
    t1010: add basic tests for mktree --batch

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2270%2Frogerkorantenng%2Fmktree-batch-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2270/rogerkorantenng/mktree-batch-tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2270

 t/t1010-mktree.sh | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index cecba55d45..42f72acabc 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -117,4 +117,77 @@ test_expect_success PIPE 'mktree --batch survives a concurrent repack retiring a
 	)
 '
 
+test_expect_success 'mktree --batch writes one tree per input block' '
+	{
+		cat top &&
+		echo &&
+		cat top.withsub
+	} >input &&
+	cat tree tree.withsub >expect &&
+	git mktree --batch <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mktree --batch ignores a trailing blank line' '
+	{
+		cat top &&
+		echo &&
+		cat top.withsub &&
+		echo
+	} >input &&
+	cat tree tree.withsub >expect &&
+	git mktree --batch <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mktree --batch: two blank lines give an empty tree' '
+	{
+		cat top &&
+		echo &&
+		echo &&
+		cat top.withsub
+	} >input &&
+	{
+		cat tree &&
+		git mktree </dev/null &&
+		cat tree.withsub
+	} >expect &&
+	git mktree --batch <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mktree rejects a blank line without --batch' '
+	{
+		cat top &&
+		echo &&
+		cat top.withsub
+	} >input &&
+	test_must_fail git mktree <input 2>err &&
+	test_grep "blank line only valid in batch mode" err
+'
+
+test_expect_success 'mktree --batch -z reads NUL-terminated input' '
+	{
+		git ls-tree -z $(cat tree) &&
+		printf "\0" &&
+		git ls-tree -z $(cat tree.withsub)
+	} >input &&
+	cat tree tree.withsub >expect &&
+	git mktree --batch -z <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'mktree --batch stops at a tree with a missing object' '
+	missing=$(test_oid deadbeef) &&
+	{
+		cat top &&
+		echo &&
+		printf "100644 blob %s\tmissing\n" "$missing" &&
+		echo &&
+		cat top.withsub
+	} >input &&
+	test_must_fail git mktree --batch <input >actual &&
+	test_cmp tree actual
+'
+
 test_done

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
gitgitgadget
