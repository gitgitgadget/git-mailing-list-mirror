Received: from sonic317-20.consmr.mail.gq1.yahoo.com (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA32E3EB
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.66.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777217; cv=none; b=LgUPkBTftRpEVwE444TXY+t9TTx0wkCjDAGucy2esylN0C45Xnusig7/qCi53jaYhv1DZVq1eQBUuJrlUB8ps50OVuVJmnSOjw1/1jHZpr6ztVVb/6zZIOpfv89iMSU7aT0BvdF2su2RtPRaiI/exwHu2zBot3DT3KdbclNFpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777217; c=relaxed/simple;
	bh=CE4Sh7iOWg8zkqL5NL/fANNotoWlaJMEcKqGFZ7o4/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=saIl+T55LW60/b9xIrkDzYaoygsAdIM3rkW5zjB4Ydc/C9e7wevmaeRwoOhStA/tVDICJ7QMwhSTPztN1GWUdhDJPaEvRS8CcC9/tz/9tXumUvgZGwPtHFgVwhepD2NjOeRTB9ZWUaZh4kV4snichqYeAYBK3npwBp/IgRRLWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.ca; spf=pass smtp.mailfrom=yahoo.ca; dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b=O2yMXVjz; arc=none smtp.client-ip=98.137.66.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="O2yMXVjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1736777215; bh=16oECwCDVq33A9SvNLld8Ha7KlTIrTn1AzZAPQ19Ihs=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=O2yMXVjzL3TcXM0egZychmiUOIbLB8yd49jVcbTNdWg8dSeklfgI1AXeegrRjmWtuP2DY7iQz29zZ+OeM4TrHn41L40B9zKA98IuszxEI4ypZ636UNVVLWROu8iLnY3RoBDy+Qs5CwZ1f1wuxYdFpMliQLtcxjNROLiRWjqaO7iJCTQ/yUnk/OmE7XWV6VtLPfK7dUNohDkH+tdU+HR5B513RYOIXlObRnxqXhJWFjHMbpK+dYl1nM2rIx6DO7huXZddJ9huOnkwpq0/V5eWL2McJYMruuDQp3sVn3MD+l7Rg4yAiOPu79TNDHO434m193LvtCBUww9srBB3SQEtbQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736777215; bh=KH2iABcigLQMzwsdh9b4BZWQ+JrpvGOLnAJEIbj2Zs4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qx5rjj+WNZSflWaxRs/rl6vFX8xKbJ6Pan6f7HI7x5UwPcNR4k9SFuxZnb2EZ4ZGan+vhboQr9cn2BBELZHu96rEMgkB29+6RNoBH3OKUMZUyT1Sd3QxKiuyjYG6HRfTMx9hOoA7dip5xmqwdF+TpZ4FmKt+YORtXdASQGiNaV/E/wWBHZi/KqESHAKoSkmRcGTcyKbaZyXtyGYcXdNNEktzYwPoThQnDNrzcmS3ZWJkr4K7bwAOgbUmpQsKzCGwyTYay1CeV+jIh6hQuZc5mc57yepjVxgxmUTd4AQIENnjsedgOreO60lK8IsnnSUhamzO72aSRa87OpfwgHWkPw==
X-YMail-OSG: EHVnlzAVM1n1PEaCLNrIPHG9Jq462Wc_NYUFMaSh2UYPgN8xEZD_DbPGZBNC04n
 dRR6guVBTig048Snq48Xyl3VEVdHENIMeYP_QF1K85hxt0ItPHgltFQO4XEQx5Jl8b1ct7jWZ.rA
 RDSMS_B4qlkyhorcT4vmLS8Lg.8LiJfLZaUChfusgOiH0uILcQMBzn8JBclvz6CYIM0Oiyk8rJj5
 BAoFa9unHTYjhC80nvfKD2Xrv0Gy.0CWetY_WrPht82VsbrdiJ1XoOZzrNeFgPqpGX1jaje2HYIx
 xdKuWMbG0ekGvZuA7JKK63SpdwDR_j5QRkrbtn.ongtZcIxcfPHw_.sggwhHsYUuEAVxQTwLT7UO
 isnbzLPwW6QpEEIhpkOwcAl3RCutOKXBYW4HPw0goDXd6vbcfpa.QWxhVA3YAcyHToejWiBhAQHC
 mrjUaMfE_sN1m2a4ZHBMd0f2yy2DejfPeP.Ge2_tMuZM0GTfx4aolbr7tOo.gxJ7iYxz1znqQGt9
 96pJU9Yr9W1qtnE8y_GxNRKkxve5BktNtJivBT4IanIZx.c1lVuJlFOldmPTanHSerC63AW1Riub
 ng4DqCJcPUaiGq49xBO4.sLiNu1PscemGEDohVuRQjYrkBr86IzllG0ZK9RUvndER1TwcVRKZcY_
 UvAVkN_nigQKwQR4GPRC7qWfqf9QRv1CLS30iNs.34d3HOTLdAJth.uJMG3h03XcBTH3ZpjHj.4P
 cpiPgwBNf.qyA0FP6zg9_jNpOLomFFoHKHv_dc0jm2UuvN7.vRgece.m5Ys7shW495Q5TFLEwcOf
 tL2lyaWji8WqDbhx5aJPEE_6vciTcnOg13BQV792ldcc8BxWLOftFEOrpEoY7s7suVfc9LdBIvda
 ve1POLbwolhLYMrB6iiiW0qe93AFQ0S4c5dGw0QPI_HA1R6RfmpEl9JbUJNadCdSqOqUXjRq07dP
 .Ori_HmCm_0H3r1iN96Dxt18E1SutmlHEUfsCX5Du1Djjg6pcVzp55hRZt943G1A91qadV6TsInm
 XtBibOIWkTtspR6YQhdVjQNTjrxOFpxdVcM3qXu9Ve7YGIbQXBjxjdVs4BavkzSxDKs.8SfKGw5w
 zLSci0B5tOIVwoWKY9ph3639q1bFAY2E7S9duKRZjT8gvLpjT8jNzzqN5lGgbrVgsvcu.6d4FHox
 AiXW9EUeCl.si8Cg5gkUTQYwpIImrTBZt2RQ0h66IKanylQmg4Ab7CvoIHECQa7dihRwbGOZHXGb
 7XHHfPnfDUNzv9thI1Urb0xtS90_gNjQuK7TYVy3DTh9X9l_5F4rgG1cxC034IEtk8.MlRis4ekr
 eAOTyg._sHalPkx8MDhMd9BMW3FU0VSUQFk5YCszNRtEWiQxs.pqArLfqzEYwb1CL_oTBYESmUCi
 PeInUQojOMcEs43EO6cpvAv9fT.8w2c7XLzeqHb7mTZy4pweHZQZUgixaxMSbbmMqKy.IqgMAgJw
 _xygDoK0VOR0bG.js4fNg6L1oys_nyjT5E5WgP7axpIX6HlI0aOhCeadblBuTvnjUsaLYnJT6rcz
 zQVriWbX_VeEAJMivhjajAo7w1.ETYrHgzEM11pbIeNpwrfZ1V51oNijZi2AcWzwpxrJMFRKOWAS
 PrfBjeiQxeF_lprl_5eJ.46bE7_lVXuJS2DK8Ef5Pkv.IGGUQ2GQHPizRefmLIb0kqHdTovSJnU6
 F73fBa24ugZ4FEBGvklPOIKcfaLlbGIdoDlPvb_E2K63UbVgddTxPiM4vKRqnfQPqF3OtUqBXlXP
 jAX1sJdPZrsv0q.5_Tj427KWSkTgzdqel6eVbk2KPGytbdxcLsdsrebmmFYzluNTF9k.83e8olgF
 xvAE28qDMIR1wGqBzVVCuH4L4mQ9e3gbGfZVMHcLxs8uXV9V6nzTiwZXBmGu6ARe0cZz0Xn15AKa
 kBBCOGzbNS9yuffgnGtuPkIHtkdWx26LQ.LLUCzDimRXZEnwDHn8xYwcvJUdln.3ajA15n9HBiJj
 7lY7wN7f.0u.IHpxOclcXzS.zGBXsFdqRv3uO8.rxHJe_z_ZmhXJRqHWtWFUwkgxpfex8mrGi_3a
 8jxrN0OPIHrLMwsf7fvdF2YNwqo3QJNRNfzEJXnF0U4MMfLfpz8wjF02TfJZKqU5E4LgCgcx_s2t
 WIvtmcl2WqZ.Czhjsdpp1ThK9bM8C2RSt1PmhoiTHxJVZ4BRjJiWjGgdzEgRexpgx2wc_rT5afeQ
 LYFcUHKW._NRxFc_8k1FbY58-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
X-Sonic-ID: 21b01c4e-a00f-473a-a57b-318c9480c594
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 13 Jan 2025 14:06:55 +0000
Received: by hermes--production-bf1-66bb576cbb-q5j52 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ca96bf2141a3e2901560bf369ad7d6ed;
          Mon, 13 Jan 2025 13:46:39 +0000 (UTC)
From: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH] meson: move config-list from libgit to builtin
Date: Mon, 13 Jan 2025 08:46:32 -0500
Message-ID: <20250113134632.21592-1-alex_y_xu@yahoo.ca>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250113134632.21592-1-alex_y_xu.ref@yahoo.ca>

config-list is used by builtin/help.c, not libgit. this matches Makefile
dependencies

Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0064eb64f5..ef3604a17f 100644
--- a/meson.build
+++ b/meson.build
@@ -614,7 +614,7 @@ libgit_sources += custom_target(
   env: script_environment,
 )
 
-libgit_sources += custom_target(
+builtin_sources += custom_target(
   output: 'config-list.h',
   command: [
     shell,
-- 
2.47.1

