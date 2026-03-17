Received: from sonic317-26.consmr.mail.bf2.yahoo.com (sonic317-26.consmr.mail.bf2.yahoo.com [74.6.129.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE553348896
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764616; cv=none; b=l8wYZpYHEk9un5nUywkgUHP7ChY+KNE7HEczfmelqdZJkv2VXT71AVeFdmip3Bj+ZEDoGUh7XrvYnpnR6beUbJOG+yWcxRYOclO6bHk5PfHg6EK7CLWd5KrEMpzn1CTYIflintAH1DSZyaGUZKU5FZ/zjO55ytb0aBwQdsaptf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764616; c=relaxed/simple;
	bh=szKZXRfGAYdVt2Whtx5tsOPl8h4t/DEd8OQJwHpCjxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeRZcpeutZ3b//+EM9Zbx2H0qUI1yPbA94Rlhe6aGqe9U5AyhiFoLZDzLjs96YfMWuijY/uXiLAWys71zJjSy/pfS3BPkkHXi87QzZTvGn8oec5v7vTwT0w72oP8Z9/c9das8dggvYcNfGK/ZnIjt7NGa/qRYgv/zQCRoJlT5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WvxHXPHU; arc=none smtp.client-ip=74.6.129.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WvxHXPHU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773764613; bh=kE6adf/pKwLLSYYn4JMTyjMTM2IyPCqjQt2kNjlx0iI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WvxHXPHUbzCe7uA2cfLx9NljHwThkRk0Qk0hu/Z/0kmng7rr7pcfvs/cHsnZqzCeh7I1hYVKCQUvVdSKfc44Tqhwd1sLCSeSKzGjiMK4vHuh4X8ZdgRBB4bzJ4uzqSFxcRX+KKTis0qWqXn+n93BEs6di1lxdeWKphFCYDMk/cCz1altW2dCbZ6Dg8YIZYp98IRCTN/wTxSJXtbn/OFxh1B93pvsUnUvS/mjiOa1rM91ibZJLFh4qGSIIzWmL5M1bfj8/D2vf/oNQH6C+sy79+8OOzbc38HZBtj5sIjM6hMDWXEVM2cR7DsUJ8ZsGB+a2n+otAzojrMNBB0WIUWJ2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773764613; bh=Qxx4qec7fEw1W6iq0ORyYLu+9JWgNkBOQ2t/EZrSR79=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JMEKrcBpheRmWh0p2hz5C4NHrl7277DXk2T9V6tEC44P2wi+u7XDBLU8cUctyTkt1i4LP4X3mNb67p6aYqIXXrKTy9JGXQXDZhY1/BEWn+1ENZCeRd4KefoEhDto9d1H7744g7gw0S2YcUzJu+YBBPrWzUrYCOI7lxqlfYH5eQT/+LBzbIcs5dHXO7424Y+neK0XQCSwaGff8bbjWQosjLm9FD3nDBhbohsMGfuu08Yb3eHawZPTQO2m8FzeLmwHD31OzslexQe94Hk0lRX/aqCdb6s4OBy76WZM1wdynTwAyS8h7M/zpbqm9DD5/W27V9tChVMskI10p92AbxvhQQ==
X-YMail-OSG: Bz4KAIkVM1k.XHY4asDFk4EvyQFt5Vjt_aHVNWPiZNp_rYwHZLEbA_ns_qaoRDM
 EduBNC7AwMFTdA7wiaNOmuX_rxJco4WZBURa4.3qQzrFrQZQwC0L0OlDQUYZgyrTXZqNQiwcmxSA
 cIcMw6Q_47XR7raLo2.JQPV04kfkLrdYh7cBt_olkvSkgJr3IaTvtnxgTNg1GAI_8_J7jZGdVxkF
 R2yiNahHq9JP48_JoJ4wvbbBXy5evxzAMNtHTBgODDgOpjNNQBRD.gLTiuDoBLe5td6FAeDOTElO
 2LVAVx0KboCmDtXn_jRacmi3Vi5pJPF9EfVC_IgA8DzTv45Icso4ynhvzdKHeKuwhLvy.XmpTtbn
 IgkqWiH3t1YtpTpHHlLIihS0L6qpAvZe3lB.8RqpY53VLuWZdOo.OfzkViyQJ76NECmthlYqNo4L
 ZKhyROqaXsvWe6_bF46.wxEknSiPQOAaTVXlA8PPA7FbwcHwgS1B_YJz1b2M76mn2CzkZOWHaRYJ
 hiXIRsTpmwpJ0jsj0KIp0SEA2PJWjDKxLIbEnYtdbtr4SgpQymeb7jTvz.gHBtmMXDQlZFZgaDwE
 uYjzdJp4ccenJmtV3I9zrxqNN7fRyOqGGPbawxIInDVvG_DtsSL78TX4YqLhj8TX5iyMYKnaeQPl
 ZxZCCHVM0iOR2kU0SvH5h8ggHCAKuqQssD1m6_8aX_IW.e.zYhvj0KyPovAZRTUBQU8aK6pmvcGz
 1S5ueGwbh78ffctMiumVPmQoroeSXBuCFhDRacxVYclw5V5fYroieOzUVBeD1AjnD_KmEY6C80Bg
 ASD7qzxXgAmsx3HOMLy3iyjdu4_TnqAI0fxnScQaYjbEliub0NIKYea7Mr0wLHsrR0FyWtD_4o5n
 Lp_.sWn6y5MjT1Pz28FofhQlW.dREkAFMXASfCBQ1p_WsaVkN6XGN6sfFXcedmtbbILRYOp27Qkx
 dUUGNBJ.ddg1kmDMi597dwbb.wOz9MUX2B.Dymuyy_DcdB7uN87tNALaCAwJdRO84f6I.u4Tlahi
 zUUEOZRhUkeAuirUn2ata1lfd1Khm8H.75N9RiPn9h1pVM4cxDs.DbQmvBifUHlEQkHmdJRRNMVJ
 fHk2H3yiiCS.QGZdXWWgNV.gVc_KUqKXsx6106sPqBY5lkci4RpHI.Dr0w4X5uLcl8_7GnCfHVn_
 1NSTTu.KuR66PXgbIo17kVoVXJsYIqt3i5Vw_Ssu7aVmj0slKNNkRPvFjgzGqgORiMtkGoTGZYUi
 6Ma9Qhk11IMnN5pDVFV..cy7PysFANWVMOmZjmLz7lfUZExWs4yY5von7NXeaiAeWWA4Ri6tCe1m
 d0geD0nrV_14hFX10Vv6FDLAlOqhkLy2XMDKo44DwvJlRlpwmdqeYCPLvdX_1rXPBSyxme0aI4ma
 Bg.Lnh8ojTM8Ay0tUIUKRKiLDlykJNRF4Z16iB35G5cJYXj1pQDPBZj.HnNOc.P3EN41XupZ96H0
 lgaJZg.qkvaqTDqq_mrWnZC0tHOFYtyBv_4zB8NipHbeHRJp2J2Z7pIx4wLasYXA3H.fCXV_xiXf
 J1H_rj4bNrXrSfwCMd2xDcKEWZkt1vVr3mK6dqyLk5SXnK3OLmRFY1xc.eJ12DwWfQ9cUkQ4gE0i
 UjHuDAsMjRVCfaL2wYCw_TVEi5GrL096Ajn0QVFThF.K__E3rufueF.NI8nRJOFjBdJ8RNZ_xRHL
 gJxR7lUGLH0.TaAaouvvUA_IecResLUVruWLfRh3qzfo4lxfBKebdOiF9JnL9vu_uT1syU2W_GNk
 Z.RPAgosAiLCd9AtDHUJvQDv.ul0CK19Nug.RxDHKSahontsrkvjjC0CghdMkeOkAe9l3JwmcaxO
 daJ1nIwYsCCcli1owI7J6w0a0cFZe8GElTxTYjCZHL_evaYW6PsUBRWHjKtqECT5sGd5pxMPBqj1
 gYzOda6AAxHe24IPy_NHCnEhpT_Iu29g1h8mDhriyrZ1L2UMtfj8n.MPXDRxq7MmOP5qHn4xEtUQ
 ra.qKIzDlOMytPMmk.r53JhbbqyfUaCNeZwbBDTeH9.cngoxSLF9z8QNwi8o6eC7RphwyjYHV5TN
 B0EKAif84BuqWF_vmOsuXRf2HxCIGN18kjJTAF2YIcSAR_tdkcQ_fuEZZGa5vpHJ09gWvJAvoLqc
 XpwCLnRUtM6NHPiE_9kzk1sefPTi7pfBATeatcrf8UE5cwQktGD_Lm9vzhSvSHuJTUDTUwMvG.QS
 DAFdSLgWiOjOLiY3dmkWe._hN8kvXp0WxkwBUhKodkwjhqkML_4CywMm3uhDhPISG7qsqHAFKcYz
 4lZh5_cCqEM67hF.f8U8VMy5JRne11ozcSY_s
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: e3f497cc-c4dd-4dd1-9394-624ab8139a7e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Mar 2026 16:23:33 +0000
Received: by hermes--production-bf1-697f88457-f5brd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 275727739a5229c22067aab3db4f1e1d;
          Tue, 17 Mar 2026 16:23:32 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	Jialong Wang <jerrywang183@yahoo.com>
Subject: [PATCH v4 0/3] apply: report input file for more parse errors
Date: Tue, 17 Mar 2026 12:23:18 -0400
Message-ID: <20260317162321.71812-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316162123.84532-1-jerrywang183@yahoo.com>
References: <20260316162123.84532-1-jerrywang183@yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rerolling these changes as a single series, since the follow-up patches
are all part of the same input-location reporting topic in apply.c.

The first patch updates the existing "corrupt patch at line N"
diagnostic to include the input file name.

The second patch extends the same treatment to header parsing related
errors, and the third patch does the same for binary patch and garbage
patch errors.

Jialong Wang (3):
  apply: report the location of corrupt patches
  apply: report input location in header parsing errors
  apply: report input location in binary and garbage patch errors

 apply.c                 | 100 +++++++++++++++++++++++++++++-----------
 apply.h                 |   1 +
 range-diff.c            |   2 +-
 t/t4012-diff-binary.sh  |   4 +-
 t/t4100-apply-stat.sh   |  88 ++++++++++++++++++++++++++++++++++-
 t/t4103-apply-binary.sh |  20 +++++++-
 t/t4254-am-corrupt.sh   |   3 +-
 7 files changed, 185 insertions(+), 33 deletions(-)

-- 
2.51.0
