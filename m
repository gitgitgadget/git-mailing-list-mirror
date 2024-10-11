Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF31C5782
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673949; cv=none; b=rCCkAdPvDp2R5kmOSWQhCR3DYiN61DXnYEPdlCGEM8kBADbPoxHXlhW5WQeiVIQE2O6mEHRqLncz5V9v+5aDVlXnywxsDGC1n/bB1P5/aghnB4TnMii1vRcrsOHwY2q4kuoS8nmjrpj01hqUBCaJ6Lz5SVzmoSyNjephkriRsAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673949; c=relaxed/simple;
	bh=zA5t/4iibsUDaLdixuZgFHdieOU5CgDrM9MZ+Ktz004=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=mIAImhlhwpY6NIiFFVCJa1R/G0jxcCgmgo5HBjGTjrfsEALZi7yRyiv5CKaPZu22pqYN0vy9z9ZEUnBafaTBzI0f6DD30n42gBtyU0VssaK2F75f/kAxdculofbnvzJZcKMhmOem3UVO193Vpt2figXzB8tQocbbmU/1ZPNV0cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=PS2twnnV; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="PS2twnnV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=S+C0N/QhEvZpEoV4E1I/pN7Nx4Iv+DcLtJRIn5xCnGc=;
 b=PS2twnnVi/MABaaFy64XOnqklvQiufJHu0uEHok54v/SqvSriIm/sH3xf05+G8dzRvu+X9Mdnw0F
   UrzATJXJuRYvE20PxaO60Y+edJgxfOG5Fkz72sccew5TBc/duurEXe/Mew9cS0r8QtSR5lxtgDdp
   rWiTi581dXqy8M/wYvSJWFS90uXeEZ8WET8E5G4H5/URALucuaWUFNUprdDOats1n3DrFfB7QnFC
   vSPJ/Op1wEo+URExTO9UUDLvNXGZvRZQwoKuCLMCvLy4FrZqSr43meYX8ohOOPcRHPemAX/KKm/2
   P0a4VI1rae3yqHDbFM42rJhHatghioLbw43Ebg==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL7000R6HCJI120@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 11 Oct 2024 19:12:19 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH] t/README: add missing value for GIT_TEST_DEFAULT_REF_FORMAT
Date: Fri, 11 Oct 2024 21:11:33 +0200
Message-id: <20241011191150.825255-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAEl/1XRwa+o16Aws43g7ydwnHWRzzvjBB+uV45msQyGDhcGeSPReNH71PPPy3XX
 oQJLEmIhzFMwciQPlXxTMDipqaQYYnklIUo5CzgbPgFC2Yr1y6Uvl3ChGkKVgxNT
 aDJW9VQeWHQkdjYEgB8KPFfa0N2oUBXjFDvSRSufnH7EBkbGOP4FDq/ZClkJawpc
 eXK86AtRlGN8MJIo2FMywwZIomwfBKFEiEqTmFmGm+sfDhmk0kVaSZbFLiBzd82z
 i4IPgNRZWzCaqFUMMXif++z1jIjTA80Mu41A+1/roV6Nsjg042iRhw2MxUUzxbQc
 uEnc7mC4hoq5KyNQid0Kf47qy82Ws6dwUaTp7XDn68+uhkoyKHedEQampyoF1+Us
 ee9H0DGT16ibIx1CZWkHc2AvASUpNXaZS4elE8ec3eTUV+EOTjWxcVZOX0SNCwbF
 9kAEusenPqNzhDGLxM9DBhk6insLkpmuKAW7vqA6QWzR3qn6cNz/TyUj

The documentation only lists "files" as a possible value, but
"reftable" is also valid.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---
 t/README | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/README b/t/README
index 8dcb778e26..8c0319b58e 100644
--- a/t/README
+++ b/t/README
@@ -465,8 +465,9 @@ GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
 use in the test scripts. Recognized values for <hash-algo> are "sha1"
 and "sha256".
 
-GIT_TEST_DEFAULT_REF_FORMAT=<format> specifies which ref storage format
-to use in the test scripts. Recognized values for <format> are "files".
+GIT_TEST_DEFAULT_REF_FORMAT=<format> specifies which ref storage format to use
+in the test scripts. Recognized values for <format> are "files" and
+"reftable".
 
 GIT_TEST_NO_WRITE_REV_INDEX=<boolean>, when true disables the
 'pack.writeReverseIndex' setting.
-- 
2.47.0.6.g93f83f3a03

