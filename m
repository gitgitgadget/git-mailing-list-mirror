Received: from sonic310-47.consmr.mail.sg3.yahoo.com (sonic310-47.consmr.mail.sg3.yahoo.com [106.10.244.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED642356BE
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026740; cv=none; b=K7gteOQWUzeuuxxBqbufJ03mkQv5Jf5SVY3xFBRPtT9sJYdHexw5PS5xrPnrEqyR2k4Qc6ij+CWpTUUbCknjKffJy+qlD4pL4h/CWB/6De5CrCIzs2acrtd0PggHAJtSVOzJur7WYCkdp0bgvdLBzQBSgsqB5V2gSv1VsPg1abM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026740; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:
	 References; b=hUxNnYGlXCcbHJTiYEUIvh4bBLs/qqM2z5dVjmN6uP23oEa+NvpMjrXO3V7Gnhi4JK1ZYLio3NwAWBapAdnhHsLOi0OMIjeV9O4b+GHH0B0rcVoPPFuwJRFSxyVwTtudHKn5s8WLhaHx4UByGHiP9CPYs3OKLp5/cUMlyNv8zPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com.tw; spf=pass smtp.mailfrom=yahoo.com.tw; dkim=pass (2048-bit key) header.d=yahoo.com.tw header.i=@yahoo.com.tw header.b=fJCrtFrL; arc=none smtp.client-ip=106.10.244.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com.tw header.i=@yahoo.com.tw header.b="fJCrtFrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1760026735; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=; h=From:Date:Subject:To:References:From:Subject:Reply-To; b=fJCrtFrL70dfz3E5cauBh1a661zpvU2Mf3hlrS4DYnW3l4PcO8JT4+Hal6Tnolwhnktu3DqKtUlwo9bj5npfnRY7lrN0my9/XVnUkQhqhv/LG3oTErBWVhMbqb+vr4aTUMo655dbzkTFs0+XMwMNUV+cOrhf2yWLJd2rXM3Uo0BfV6Eq/37VF7Ql+/FKXfBVR1icDy49QrUz4IW/MmnmE0d6V867/j4jY5z+qV3P5flGfzghA3X3Kpg01MPLDjTCaWCGZMcz8iPoaj8YlkU43UtMVd/fLM/2nkVw/zEl39TRtE6UCrp4LL6aH/YHcsjD3Jdmy+WZrsLnz+4HJdn8hw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760026735; bh=PgT+wy7GUruXsIjh5lW8BvYDxOZT7DY/hU9UpxyV1V9=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=jDi5WwdPCx07XvxqTmxPykeGLuV/zY+Nu8e5+jyJK2B7NEqPNPDUK8CEFzAgL0qW0DHvJQfomEkdHetzpagROReklzdutMYIpjMfAA5L6xdoGBVan0jGsr6jQdNCGy6pwJfIJ8A7x4aNJkF7cIeclbvc1RCK1J/eESmHVQtzRwudxN3rvoPipyhHyMDZLXFTHQgpwFq/1BZ0XroaymhrzsmOmWJ946/I21jCGh6PfGLMDl0r80CODW2fZyGY+YCdPm8ubw+ZUEO4hjTLv5JGdO0WPu/8NAJN8vKzSXQ6QLqRtwr10vjUQP+g698xBpUQvM6AIpkRJMac1x3ekeI6IA==
X-YMail-OSG: j2edwqwVM1kTVhlzJTFWWVzsuEGDHfsd9UOyU1EHjNRjSoDt90kL54yVu9XIn0g
 AttJyZAmMM7tWF.ZOlGc64xjgM0dFydmCPOpL01nV3kr80CvuVYCvEASAQ5X.8copUugj4RW.AvS
 ZRbz8Oy4JEPXhI09bTQo5ZcK.PYYLX6Q7ccDDTjf8YtWM9D0wAlGEtHtWoCMZHgnyOf7XWTteH9k
 4diZSU7uiLYgndwNguJ7xLQlOkjdZ22xsvdbPgS4lQIJ.Gu7epfCnwPdBMqaiQ49dngcYlwRJxaP
 ZaitRZgFg7ntQXnLNtCKDCdqemCnlKdQEgwJ2bYA..nZE68EoWl3Xgtn42D7PtpCkLHrIAOO2Rhh
 fRf3BrBghLn6l5J3qJhM4n.rO0JvDC5d7mBFamn8u2weOAU4iYk..C5iH6NWGlpnjA65PUM3E6MJ
 SLJ41W69z5jcuH_6C7DF0uG8ePaz.LGny5qPF1y7GhTlR3umtkxDDZEcXaWR.hxReGRR1UeTrHi5
 Ip3WoiLws21IQBclppoZnJZOHTbY7JM4VWdYPkv9RlMDRftjo6huxyPUCIme_WZR0OY6w4Zzwif.
 mf_t_HHOfIn8Jhs9t0lcVtvtvMkj2425t9gNdcC432jNNUl8zPRDetnhNLQZVNb9wxOoJ6a7Cl.K
 nD96Kb8yOM5fPhmjhZ518IRhICCVIChJP.cpJUemwMduqpbHihDVKByPqZrOujR49MPPgw_H0T0B
 fNAU2Fewx8j2KMirL_p904YXYjlRWYUfsNO_Z8ufLJUZqZULIwVAu_2AdukvbfKy_DLzybvhG1uR
 yfUZiEXasnfrrGTd9f8D4tqoI8xd.0y.WIJIQF.jjTA17Ls8X9VDw.T0DjnHldj2ftddRgg3GviC
 0VUg5DZKCe235sF0ZLJLoJ2TVTyCXCyF8HnJczoZTU8iKn2GTneBENHq.AyNXMAYyMgt6rFc71S_
 peG54lwsFHE61iYf44KLR6aumsA760z5DWNms5tS6x2atKYm7yAZ1GgJrgvIu7mpaCPrsf6VwN7B
 tkNQSf5HUgs0l8Gsy9el4QyaTdZFdTsSg4IXehAQwDxPtY7IakFNlyPUDBs7hgoU78Lz49RY4bks
 sK_ONn8FQ5GcXRBHuOMghaON8ZS80SxbSrFs9o2kPsefd.FCjUXD.c9eIfuKUoy8.S5T5GYR1vHS
 UY_Kfim5n9AhpXY2PVOhjsqz8uNALty_NxWRPUCpDeqqZjPLwxF7IxSfwA5oJS3W5iSbFFUBAEyr
 eB2acOHjBO1r2MgjlcG5lEZThNN8XxFr9HNp5tLRsO.dgQ61af9ZZqnRMzSBSw4Kp_knBs0yr6BQ
 MB.pfbzSJHrIwoj3eaI4FT2UBfgv7uMd.NVBxwPqgwNJxEg5zyNUa7.0QJPKUX0T5reXbdJFVaOW
 sFGCK1Syr_Nn3fpJJYRkYDSFJxipxbwlnZOX4XEszLPPXK0TXkcV0aR91a0FFq6LA1.bed7IRSyn
 YQSO47MTu.OTMHEMnGbThcsQXs9gatnAnE6mJpiXfFioGHN72CNt5aKrjkvdSXAgDmhhflIoHWB3
 hNBUgTe8Ke434ETopM6ukN3Cyxkx9B8Br8BjrrTxkrKpfiu5Xv4irpw07lCoTd_Wk9DO.vl.CCft
 Uu7swMVX1tgWU7D41N3gccDhx_sYS8FKw0cjVSwN.4qsNlnjVI53gq3OxhLR6b0WDuY44HHctcoK
 0rh0sCa_ZmtYrbCDnyaeX5VUScC0PRrheLOAYiSteYwVX36MFaGR7ySZXSbhusvWZNgx7FVptvdB
 umvoXRG2gKG42wmkeGMpM_2_IoYqRWJY8R_kcXV2T5cOgXB2kJXIhN.sxN5hNDPa4054LPyr_Ssk
 ZdCxf3dcEM7bikUPLzvcKIm0gDLo7H8A6AxIgmiY7XiPRc611bnOxU0uPOli899PK87jYDVdJrpR
 s8Z_ZS8w2qstxkamUkFXdyrLd07erpqjOnHgCgGY5kjNr9Foe5Z7qJxJoS1p0TmY.ERy3OvsuQbn
 j9.wd9shM6Ai8vcwx7Y_NG9G2VkqHXsTcRGHEDHkgQqPumz.LnHLu29tMoEYWWn_s24zMFS2CHCs
 pcm5f9M8f5pOxRYznzejvlXuhcAY_.KWIce2CnFejGxAMRyyyaJ1jJyT2O1lktAo2HEboHQwvrhA
 4Ikymc.MPh6Lu2KFtzTKgP7XgTnQN66.X7bOY5UP.8V32Rr4J3.KtrTdYDs69QwVD0TtPxyzDfaJ
 aOCqPxtbckGq4cTxqhLoEatm2upmrqRCgJ4eqRJF28bZSmv3I7cLDqwRKcBkcffZHi3Z4K_widie
 9I9EGqeZARxwtN2jkc4yQLzXCMqFIQ8RKDXEiNtzURSMBNUPl_KC57Iehbw6Pvo7QRAVbHg1P5NU
 -
X-Sonic-MF: <jerry7151053@yahoo.com.tw>
X-Sonic-ID: 3d97a636-1048-4a56-81b4-81b7f28d6421
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Thu, 9 Oct 2025 16:18:55 +0000
Received: by hermes--production-sg3-578c98656c-n8t9q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 71425795e99dddfda8e785754a433386;
          Thu, 09 Oct 2025 15:16:04 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: miko lee <jerry7151053@yahoo.com.tw>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 9 Oct 2025 23:15:51 +0800
Subject: Git Source Code Mirror - This is a publish-only repository but pull requests can be turned into patches to the mailing list via GitGitGadget (https://gitgitgadget.github.io/). Please follow Documentation/SubmittingPatches procedure for any of your improvements.
Message-Id: <56E990D1-1309-46C0-92F4-CAE915A8B22B@yahoo.com.tw>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (22F76)
References: <56E990D1-1309-46C0-92F4-CAE915A8B22B.ref@yahoo.com.tw>


Sent from my iPhone
