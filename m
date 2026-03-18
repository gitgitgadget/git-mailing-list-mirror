Received: from sonic317-26.consmr.mail.bf2.yahoo.com (sonic317-26.consmr.mail.bf2.yahoo.com [74.6.129.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5332AAD6
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866151; cv=none; b=mT+FgheYppvrL8DimLydxK+bP0UtloimctX36+HuId1Q/haZS9rjNnDufAQcpyxqpAa+n10uTCUuToUkJNzmKO8KkI3uYBM7o+gdKnwcQyRN3fbRORZAahbWt/LBhb8o3XIN9e9wGeDdSaIC7HXHLu0xE0ly7vgPSwbdZmRYXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866151; c=relaxed/simple;
	bh=45ZoMfVU5URCN4DR69mXBLkRvlBeKcHZOBn2UGkCm4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:References; b=XahsKZKaIJTFQT3rVovULJ7PeJmWuYbk8d95gA3QGk0z6sCiSuKvgg/G9LARUN1DUk+/ujsbffivUxs8t80OZXlVHCGZZAh/eVtG5fFQlf6L8mdN2BseGCEJCUnLKtiH3KV3EYkgLHd+4HkVJ+0cDynBqmxWNqUcLv4T27Skaig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=r+UixdZY; arc=none smtp.client-ip=74.6.129.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="r+UixdZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773866149; bh=s/RJzf/GEN1gMThcX3+qKxgAdKPtFHhpXo1BHiLCUPg=; h=From:To:Subject:Date:References:From:Subject:Reply-To; b=r+UixdZYLJCvGvx4nhdJ5O86a+VRDAtpgbEPrtKRauJee1VX5e+J+RoXWdUOCOpbjWQSRTTrHlp8Xw95owTimFWlJq/T4D8yeNcijwvRSF3YFx36qlbsQVKNA2wzjxoJYbyUe10sj2S+NzClfc1D16CR+xtfiakZ9hqOOJPanaziQtcc2GMBLMgKlSbWclqHAD5tHLP9ouzYdSGabAjnIPtRiPWhSf0e0AQUelcx7PwGrmyR1V3l3/h7yrImQ5FD7EJFslD2G4dDgcsEwX7s9OaH62sbYeIPEG0coCBSuK11mZs75N1IREPYVSzMesebizW3uolbgokH/aEE3cEXpQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773866149; bh=oVIKNRC+C0lKTu+jhwS+/6TCY6GTTLL83GKN7BBew70=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fd2aSJ53oJ1aIj9ycyDwNWAMVONavr2uI8X3/hi2zT6Z1n/iZraodKfLhmX9j1NBJTTzikvwXkmjiGSaXCUTSCH3osdGGkO0PdZMbqZP9ah3m4J3G2a64mZymRjdm6UMfxgoXb3yfI+tJzwdiQUhTbhiAkMzxZLJFoWRtilgCIqFY9QATIfCeUMOS/TwW11xhDLMt2xq2xZOoiXy3ob96tyIUwXfNKM8Utvw8/1tS0sP2Le2/jDgTe+aDW1fjLvhzXtte1GikL6Q6AhOs06+It927D6jLlHwzmQKlbAcdagFENfR6XoZZgRVzYERj/ME0HTmgTHbKOQyqBiA9eno8g==
X-YMail-OSG: 5b88y7gVM1kSuUEOYfPf68LTYHN9OMsxzHYBWsA7kmS_ktaz8vTaNerzIQHVqLs
 IH6FM_4pn1ia5JDzJww6TzzmMEKltYmeMiFle9y9WqUYmq9OMrA4vGq43P8hKVQbi6YQZFufLRe2
 _Y6WI0FI_UPYA1ovGrHrZK2wnGKW7_FsW1UUrRt4CTvUJj51zykNhrtMwETXVih4X7e9nGQZRovf
 F3z3NKeXaEVncT7s6wz4wlECq52Rlr5fQPqSU2ShB3px6Y9uFa50zoPh7nRZjvXAhXgw0aO9RwZt
 Ruu7MKmaimUZQjcyqqxKoQU3Kwybzhgvixge6vYxHU0vsNKA_d0hae8v2NdqgBIRovLTiNik8CGp
 oynUxkCI.QH1YYavsBQBMB6bYXUvccFFVmY47DhLjk2XKqDCJkcvmhTYXOzOcx4bphs2Gf.WlYRi
 Ld8XJJEpp.MOgtZpg6JzIDktVh507XvH21sum3r7feUP0iO41JxgEB1gOVWV0HkQI3vPk0IPCuSJ
 54Lh9ciTYgaphgIegsnR7Qq79okv52nztPbgv0sqmHZ9Wbf3yL81LmzZLkS4Q_2sG7d5mdqP6WVs
 SGKBhLjOUqSD_8bvyUmMMlyRYf3vO9Lb.e18h9PWzx5apsHhDtZTZg7KNFocyzVlpxTcSyBNM4eG
 04Fnxsk.CJBzbdQxjXB1Zt9gRvugibDal71tZMYry75MeL.4dYqK6R30vBgpmsasymcAGGrvdUwK
 r46X6jVPr6Cebox2SAchyIFlD3GJGK4n798REZ6ybgbvoQiytJtqebYrbWyR5v24V35n3rzwVD4k
 yHjsByN3o52VzB.00YX4004H5lTYGpKcPE_fs4lyDWJhEEIW5M5ezNBGfpT_2_kKOhCdZSIUESGd
 J3E1CPEvqY.aMfi5YH7xg7KDyHrek700iOOz2DChEOf06Wm1W1bSFVPP9btFDm2Pemh0hApwwrGl
 6ZtNUc9w8N2gMfO3flUriaW4blXtFqdBRHfLEVaWhABzkEjv8o1cQG_GO14zXaXI_BFLSR7IQu6c
 cZOO4l25VxiWJmS_VFQBIZoE_h972rtDbulDNdmKxrn4kvIZRwMFGfk87EnBcaWUZAloo8wJwe37
 iDWMrdu.0XhNN42iUvhBlokB6lVHWKh7.te1QJMgmWYsuxxs9rWktIPeWO32SzZwgHx8ut9.ieoI
 .6DYSe3.sCQwvod3Fr4oE1bxPmiMH7vfSFt9_pUS5wMttkca2M6OUD7BfNrNVpvikVkHm0IQg8tQ
 OMTkd_BpNsVE4AARa4qJ.z7LHMUVkhu4cgdyFbOl04wbsJ.Ehg.1aF_fhSzbRjdOX3cr6ULG2Kky
 8oCCuhPI8mivmg8fyokj22Y925VD8_DEefWYBdS5c9y95_QZt0jb7Q1jnTy2errH2z6_dEKpGk1U
 ebAIWK9QSg1Sfh4OHcnkV2ncISU_mM5cdeXlFiht5szhR8VUHI4Fx8U7npiooD63avHO1evJzeT8
 QVJORcNLbhCnKS.ZvldfOSVUYe7_.PA3skPwHTn2dazZ_NUSpO1KSZPiLf9dVV82.ZxWpTUOHhis
 0ASs3D6OSNuxCILb02sgEtbSlxtttP8yreVi8f5LKwMN6KPG59tvOIcJO.xH6gdBbUEZXfD2XXM6
 MObGXEgxK9ss24VV1oOdvFJBXmaAJCh5UXyGy2dIE7YcuuBVFWA96IDNCdyfJF.0afHwSQcULm26
 epM7bh71_0XPH6XHbkqsWyuib8XSfKcN7iO22u.VHBekE8Wz18.Lfg8bvGXLxRtNbThOfB_UZvjv
 6PGoNiRWkmqGWkm2NojZz6yV_o04fqJApubJrOVq.mAekL_wQ3geGDU73OtmSgWm1JMSlv8PdqQz
 Evqeif94dQ3Y6q0CJ6Ft3e7X2J3.YYafSI20KHdy3IfVnfIkF_aiZIuLfFu9DhcnyJjUX3NolxFN
 60Su5Y9B3LmE2IF.e2u8ocmAEjfvirKdcF8HjmQfNmsn43qz63i8lKHq154XtwwL8F.2VpvADcdJ
 bGrkvDSEpF56rdMduJV6Sy.4xLsd9sTxqLi.pV81BApI2mKwGpqDbptERqoJBJ41pkOusqTusrdq
 ovVudJvvcYigeM8H9NZ.d8B_5rZgYKAwlNxfUhJs3joCU7fq3e57qxVyNpBf2tHYteZ5_jxQWvNR
 EarI5ciuFu9VaR2fvsYHy6PqBu850WxA86tTMtRnTsjGQKv.yC8kEDmH8_6XN9iVgqEHZaIWdXLq
 b.8HoUCHnn0CUJYxyTaXzEdVfaHkbj58wrR80pw7dQz_bQgGtFPukW1vA8E3l8TlhGu5wDbEZLMt
 7JdOHqCx_S4pEZRWC.KbN
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: bd9dc981-b70d-4206-9a9b-c5c7a50d0344
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Wed, 18 Mar 2026 20:35:49 +0000
Received: by hermes--production-bf1-697f88457-2mcdh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5087dee980e4177e160d4a83883e199e;
          Wed, 18 Mar 2026 20:35:48 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Subject: [PATCH] t1900: cover linked worktrees and separate git dirs
Date: Wed, 18 Mar 2026 16:35:47 -0400
Message-ID: <20260318203547.39972-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260318203547.39972-1-jerrywang183.ref@yahoo.com>

Add repo-info coverage for repositories accessed through a linked\nworktree and through a worktree created with --separate-git-dir.\n\nThese layouts are already supported by the current implementation, but\nare not exercised by t1900-repo-info.sh yet. Cover both the lines and\nnul output formats for layout.bare and layout.shallow in these cases.

Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
---
 t/t1900-repo-info.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index a9eb07abe8..f85ed232c2 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -69,6 +69,45 @@ test_repo_info 'object.format = sha1 is retrieved correctly' \
 test_repo_info 'object.format = sha256 is retrieved correctly' \
 	'git init --object-format=sha256' 'sha256' 'object.format' 'sha256'
 
+test_expect_success 'setup linked worktree' '
+	git init main &&
+	git -C main worktree add ../linked
+'
+
+test_expect_success 'linked worktree layout values are retrieved correctly in lines format' '
+	cat >expect <<-\EOF &&
+	layout.bare=false
+	layout.shallow=false
+	EOF
+	git -C linked repo info layout.bare layout.shallow >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'linked worktree layout values are retrieved correctly in nul format' '
+	printf "layout.bare\nfalse\0layout.shallow\nfalse\0" >expect &&
+	git -C linked repo info --format=nul layout.bare layout.shallow >actual &&
+	test_cmp_bin expect actual
+'
+
+test_expect_success 'setup repository created with --separate-git-dir' '
+	git init --separate-git-dir=separate.git separate-worktree
+'
+
+test_expect_success 'separate-git-dir layout values are retrieved correctly in lines format' '
+	cat >expect <<-\EOF &&
+	layout.bare=false
+	layout.shallow=false
+	EOF
+	git -C separate-worktree repo info layout.bare layout.shallow >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'separate-git-dir layout values are retrieved correctly in nul format' '
+	printf "layout.bare\nfalse\0layout.shallow\nfalse\0" >expect &&
+	git -C separate-worktree repo info --format=nul layout.bare layout.shallow >actual &&
+	test_cmp_bin expect actual
+'
+
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false
-- 
2.51.0

