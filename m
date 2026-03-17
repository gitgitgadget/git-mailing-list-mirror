Received: from sonic310-44.consmr.mail.bf2.yahoo.com (sonic310-44.consmr.mail.bf2.yahoo.com [74.6.135.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5833F392
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773711482; cv=none; b=azIZwXdwHTF7tCagtOAw2cgbwu6tZaXVLyL7YUv1F0fs3VKFc5J71hqn3g0eFBteEnb41Ywb0iQhVedBFzIHDKgLWo7AqlfEgxYP250ATb/jD2rWIaMbym2QUbaX6kmv2sxBo6DMAIBZp8kJhiCPfESiZ1lMDDGHVIl+x4Y0pfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773711482; c=relaxed/simple;
	bh=i1Q0hc/Pa0n/6zeE5jCgc94jJMsDt8c0UMemq3Pf9Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=peqrC8vw+/ecicKEDKJAiyXRxmxEXWowL9sBewrwqnEWB+xkITxMBWFoY/Ad2DU2lxTZxtTYLqatWt8A7/EgnJtMwSDFGgoz0eBsH3IhBM6dnuoP9qjag1w8vmnAvAY83G6e30veP3Lged/fbqUxaj3u1Sfx4YZ99UOk9RvTCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jpiRxh78; arc=none smtp.client-ip=74.6.135.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jpiRxh78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773711480; bh=bkYpbcY6mCmXDI+WfJrLzWoTvkanr13LJZg8VdiWh0A=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=jpiRxh782yXlt2lcfH8JQmF6PBUWAeXXTLpH9BjJrvrVsNSUpYw7XAFSvcHhVQRAkPPKOkwAkBYpvq10ddxllvgV30P787Y/lGEcsYzyQH62hDM67xjZq8NAB4LLi3gAcX0XHjmwz7WJi2OmkHw6tn9W0Ra8k4WcbhXRZu1wZgQlq3kmneiX1JThgCzEil4vTdz3NcBn5l0TszAia59rZy9Bf5DW2Viz398KjQtOlQIh6Fv8jIdxkjS2NICu8NFPkSRN/5ON+MpL3O6o8kml4sXaZLb7q8OD9KeNx4nTrNl8cGWtQcuqWJE3ZhtGCK2eA1NdTLdD0tMHX5ZvLeaAjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773711480; bh=8aQgZCoLEouD3H6mdmfE3K+gIZ2w6LCbY0KkfMSRtyL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UPKUA0akQI7NgoqNG61gYJUu80tJS6l6vcWZpMKUhGRuw1eNUvmqprSJC/zwGE1wEb7sUGMQdnA5ElFGp4byjmz3l2WSCfM/WF7IsJp3sseBYl5yisPKJ4rNxDK2+6zfxFDLsu+P9Wvd6nLmEH4dL5L93LIhSygFhUzVBhj0K3F1b+WwPjpnnQ3S9a559ey/apCKiNsEwgpFxYEIDCeLquKfrjPHxVoGImEcBkNWOI4q1VtyOpczu8qU4n8BtCskYDzre/aL1/zq8ccJn7R3CUTh8WKJR0SI+EbNJ9xfW9YocNPLitOb/taYMbc4tjGrj8C7POWxuA5I2rX+O89w7w==
X-YMail-OSG: tTJ6aVYVM1m77ou3aW9SxtMmwK1cATS3gvhXRWl_PMpmsI336AcZzonKUjP2NI1
 VJ_x.7KFaCpa8Kgy6.NsJf.NvyKBs3r3CLRo8wyykOStrIFMLfB.GO5zGDlIp7M7bJPvLHK0BRyP
 ewUlfJy.cWJhGvEbiqJktbGhGAARH021rmMS8TyMUtaifliMCvTEkmEuLvqsAAljCrrWQDsjHPXG
 1hfg7qxOTUNYDXDPFZwFLqRRrVxYunDPphFnxWrX7B6zSoC8swOEcSnyi4U9pjo65QDIV4MYzLZW
 IwoZ5ita66M9kwrSBw7zXwM6QKJNflmzUitCDx1g5hPJFjrDXVCFHXZlKgyKnNifO7BrH9P.4UNI
 9y60V2YyzD.cB.uQDiJMX1g4NmJYa.Mctz89AFiChqwbKhOnDF2nyvxldna7sz5FnXQiFtJu_bll
 kiJk6XJSmuQcq6Ugr.71IVIX1fRwJfh6y9pBC5UPQ1dXrMd9jGgxthphpXjHbxgdjguPjAfgIVL9
 xNnJv1Xp_G6XJwevJ_Lpp54YOlWgbX8SPZih3b_qMz1mtbCTXGyw4gLRchjouWkj47QMKppZfume
 Y5gTY0wszKjK1Si.mXEU_ohzUfJTw2dq1RHd_Al3Lgxr0CHnZQ3haKp5wsI.ZwJ.DrJHAvTFWPgz
 vYan.iDPSmqbxrp1hifzsgzfZMuuGpR1T.6eRRKwLPVWwPeMJswsAFTzWfkRPbQw5XG96H6Oeb3r
 3Y3w8O4jLexjwCS6VNdpwD37vpk728ynOJHlDs5pySxvmcGTFzU8yLl107J1wR6BL6Onf24iFweI
 qOjwrOBLldNkSt8UInyVinSscPoSJjxeTczn1S4mR5QvBD2MRBJvLDZM_hNKXjfWfjaUcijGY6Wy
 tGr2nM5uL.fPxhptKm.h1pujWfGmigqvRGP7gu1FOTqTSCHeQICyw5IRm1sytaq0iTxnL51tuNj7
 DV2.GrZXHrNh9Ud3ZXwqFBRoRRRdYLxotncbMj988lEEGWNv_6qiS.0jbwVyodf2m2WS7PYFSug.
 dBfw6KwTv_evdjkQFQmqf_tiVyWs1ijVVEFupS.R_HaSAsLS3TweW9Jud1XvgcbtwzCG87a9fSeI
 ZiHsNenBYmFVAp7v2ner_44F8ZoOlkTdghZWQZentefWrseIJT3XBnq9g3688Bwag97ivF.SK5sn
 QtMqKDD369xyPJD7YosdaDKgp1C0z3NlhfIiuihoKQ6wdtDpVW9Bsy6mQzR0vY_XjKOs.xQjmFH_
 OEmKXhRyxumf8LFi60H41HKORp_BNXmJnSPcpKOQqpWdRUNCeSslc7qbFm8OERjVgpRRhTT5VwA3
 EBgAtoW.DxkUTyiJbHLvZl7oArdfmCqzi6g95zzDQsncodreo8EXNkjNtkI0bUPZBAPffceJcYh8
 fJJJfZMUTk_PJeXC1Yb0R6DlILxXA82ew88_nOVkhZWBFcxBk97zl44bcgqDYgsn_bnlXrJhSuZl
 ceM9NvRSngtWC369pmv4CvhPKB0QDBupkAm13ZbPwIUB48uIGFatRwoEnbSTkH8LfX5sz5986kS_
 rdKVXIsEYYclrhMiEQqVY657yCY_7Svw9zShZQ7oKASc_AS9nrNymM8AEgLR8tRNmGnBBYukOqMp
 nAjy4vv65O9Omp3tnp3XSncQ_oMfbV3JA3PKNK6eswZCThC4vIaW52bePPfp2DsbkQ1ZoSM6smWO
 K._J1p5yH_xPJI2SOsVUgh7EIOKt0rjfZ3WT6VymdukGCQ3c182GEA_Qun6Ak9kNoYg5eVbNUe2e
 bkwANalx8fUeMDT9UQnGZF0aVCypqw9P3cPol3mU.HrjxC4.vA0qaf3dm523zaY1k8RTobMBdEyx
 .7HH_3l76M98rRO1_ekNXhd_L8cYzGkrpVMgYyteSO1BGkY.YKRmAhhP87VqOMquc1CTaWacUk7t
 vTm8KclaSiT9mTz53SugdyR.hwc2i0P_snfrKL5m7qFUUvNi6ych6c7gyj3IEBDuDFX022fNG0Xf
 9DXA7Xmq0AUORoK.W3.J61H.cvq.x6O.gyvm8yg0JmsaJKvSSggybxHs_QGRQc3Pl4zMOznlf2nt
 t2RIkA7O8Uc01aBIW55B6mQ.3xr1_oSr6BR0lCTruNGgspWqSotzHnFQsLof0SLntpjxHhipsh6W
 3sDvwmAOBdz3dF92VIFI2yaAdGO4ZA3kXnndB30eAzSpkieg3DzutOvN1yesvtvma6NSqV3Y6YIM
 DctZbeynaEAHc1AIEp7ew8Ndb1TEtnc__nNOaj_62Hy7fxh6dpYyu33rj3AVnrzPun.AR52LtbU4
 TEVZAB8jIY3SrIaALkIOy0cp3meyV7SlCcuWVFzld8hnOzK4h52b9oC22H.rBO4vNX24A97oT7wT
 DPg--
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: d3681353-b77e-4722-becb-a1678e20a15f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Mar 2026 01:38:00 +0000
Received: by hermes--production-bf1-697f88457-fgkkh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 53981f2f0d877b6f6fb64e650db38bfd;
          Tue, 17 Mar 2026 01:15:45 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: Jialong Wang <jerrywang183@yahoo.com>
Subject: [PATCH] t2203: avoid suppressing git status exit code
Date: Mon, 16 Mar 2026 21:15:44 -0400
Message-ID: <20260317011544.65952-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260317011544.65952-1-jerrywang183.ref@yahoo.com>

When git status is piped into grep, the exit status of the Git
command is hidden by the pipeline. Capture the status output in a
temporary file first, and then filter it as needed, so that any
failure from git status is still noticed by the test suite.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
 t/t2203-add-intent.sh | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 192ad14b5f..44c1936e4d 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -16,7 +16,8 @@ test_expect_success 'intent to add' '
 '
 
 test_expect_success 'git status' '
-	git status --porcelain | grep -v actual >actual &&
+	git status --porcelain >actual.raw &&
+	grep -v actual actual.raw >actual &&
 	cat >expect <<-\EOF &&
 	DA 1.t
 	A  elif
@@ -26,7 +27,8 @@ test_expect_success 'git status' '
 '
 
 test_expect_success 'git status with porcelain v2' '
-	git status --porcelain=v2 | grep -v "^?" >actual &&
+	git status --porcelain=v2 >actual.raw &&
+	grep -v "^?" actual.raw >actual &&
 	nam1=$(echo 1 | git hash-object --stdin) &&
 	nam2=$(git hash-object elif) &&
 	cat >expect <<-EOF &&
@@ -171,17 +173,20 @@ test_expect_success 'rename detection finds the right names' '
 		mv first third &&
 		git add -N third &&
 
-		git status | grep -v "^?" >actual.1 &&
+		git status >actual.raw.1 &&
+		grep -v "^?" actual.raw.1 >actual.1 &&
 		test_grep "renamed: *first -> third" actual.1 &&
 
-		git status --porcelain | grep -v "^?" >actual.2 &&
+		git status --porcelain >actual.raw.2 &&
+		grep -v "^?" actual.raw.2 >actual.2 &&
 		cat >expected.2 <<-\EOF &&
 		 R first -> third
 		EOF
 		test_cmp expected.2 actual.2 &&
 
 		hash=$(git hash-object third) &&
-		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		git status --porcelain=v2 >actual.raw.3 &&
+		grep -v "^?" actual.raw.3 >actual.3 &&
 		cat >expected.3 <<-EOF &&
 		2 .R N... 100644 100644 100644 $hash $hash R100 third	first
 		EOF
@@ -211,11 +216,13 @@ test_expect_success 'double rename detection in status' '
 		mv second third &&
 		git add -N third &&
 
-		git status | grep -v "^?" >actual.1 &&
+		git status >actual.raw.1 &&
+		grep -v "^?" actual.raw.1 >actual.1 &&
 		test_grep "renamed: *first -> second" actual.1 &&
 		test_grep "renamed: *second -> third" actual.1 &&
 
-		git status --porcelain | grep -v "^?" >actual.2 &&
+		git status --porcelain >actual.raw.2 &&
+		grep -v "^?" actual.raw.2 >actual.2 &&
 		cat >expected.2 <<-\EOF &&
 		R  first -> second
 		 R second -> third
@@ -223,7 +230,8 @@ test_expect_success 'double rename detection in status' '
 		test_cmp expected.2 actual.2 &&
 
 		hash=$(git hash-object third) &&
-		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
+		git status --porcelain=v2 >actual.raw.3 &&
+		grep -v "^?" actual.raw.3 >actual.3 &&
 		cat >expected.3 <<-EOF &&
 		2 R. N... 100644 100644 100644 $hash $hash R100 second	first
 		2 .R N... 100644 100644 100644 $hash $hash R100 third	second
-- 
2.51.0

