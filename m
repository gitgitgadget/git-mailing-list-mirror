Received: from sonic315-13.consmr.mail.bf2.yahoo.com (sonic315-13.consmr.mail.bf2.yahoo.com [74.6.134.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225CC3921D6
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661504; cv=none; b=MfO0CsYq2qzsQ1hGN5/iTkaZ9ZoyMlCnHqgSSe2Epxl8jvtGrK7nE14YJ3h7GSUhz0KEjomlv1uynjNwR2/H5Tjfm8qeNIjeCJnFmSJj+faVVX3jLVR2N0RfMBIuXaRaXD9XbYZj9Abq9HMC7hDwrds5PYkwZK4Symg+8AdP1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661504; c=relaxed/simple;
	bh=84qscCtDZTfgdwBACizVUcH31LF9/0+lIK4K2xXxgEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ts0VwCxeXA2Na1kDEFnM6PSnLexGkzW+wKqN5nSGjTqQqQhVM30QE3ci2tTtzDc+LBRLsU5naiLBdWKnrhUrjOsf4ZYQiPbxmtSrV8dmq+KFGatjhW4TmXnUzlywHa/5Dg+Jf3WDNc4L0sQkUXo80salgatcxDFinreDn7a7VNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Epv0Qpvu; arc=none smtp.client-ip=74.6.134.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Epv0Qpvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773661500; bh=84qscCtDZTfgdwBACizVUcH31LF9/0+lIK4K2xXxgEQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Epv0QpvubO+wtVMq4r8uiCmRWCs8QHl+RgZ5ULYgFMJGbZcElWG+J3rU3mkE6/TDXi5HecvDqp0YP1kFjgghhWdLUHim7DU+ldou/LusyGZhZEFUisYRLrWMBefHMawvLXfs6RIFfH4TrPgkuw7sdRghT9pLhqaESO7LrLw0GZTeoXqLuLKhb/NIq756SAVNcCZXhtFDIAtL6gErske9k7z4F4puiiQ+1wdma8Tzus2F8sNgsdzixH1BKKM77kJb2NKI0iP/IeQdUMME7ujmUgBgyJ08n5CkScX95Z16wJe5ed+FRupIwrqLRqlA3bkM3hZ9MHXtrl4rL+zdo9bwOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773661500; bh=fsjGpcViOuYo3M9ZXgAJuQ7zZE6hsLitFecStRcsepi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=JFgtUrd10qFeEExhV17NxtBlxy6UAieI62tSdSMN5wnNMgux3r896eq1JYStxPflKSGWmifhPXdOVL+0k2gyv0ynm9NcP/7+hPVxWiuxnvUaHLtht8zOG2XjXuhCxoMmYK5aMwAFjie1NoTxDeRjtbdAhTse7Uhz8vVcuJdPD8D6zJE85EO2knBfQW6dzygwdsdK53nuOA6Dy0RJzOAy4peAke04PokLQVEDnhTs2P8z+Okr+v5I1S3Nf1jqDV9XtzZpvFbX7SbCXJ50jrdoRbRDHGcGowClYduWUxp8DosUfuW8dt2mZyxrLHCzqlO8EE96z/jcUqQld5ouVQocGA==
X-YMail-OSG: xHyQjC8VM1lFuf5nhlVssdaBFDYJET10uFTKMLpTMA424rUOlgbSW1jKYupyAAj
 .PemAxPx5kqSifwrsE02BrjoGQV2.Fr53juV2qJHMJqq7Mb5d6B6EKVn9oAil6m5jbNT7xelzm9N
 g061lssodkWxHaSZ7Ca3t4WbuM5ztvWzI_hAhlx7Y87VD1bc4dNQjGpT9futODl4aVigChXJ0HT5
 btlZPF7n4JVS744_C5qbK3.Zgg.EABf2bivY4djLGZwK08IC89rPl6OSf6bHHrleNy_UaN2JkB01
 mgEMQ.qlcooMkAX5SU44MuTwqb2pRmNQdmy84tEv9SWWLWkbRDWREKfcwEqZUdpsarstDGYctZaV
 PjD.d5tJVC0lIjBxAWycSIVpGdtkbh.RQ04TXRtoDnHiVOpGQ_Ida.769.c_r339uDdGZta4WMXz
 h0AuP.qPQq_rmRcyf.c5BqKrtxFWbHrPedgPaaKisaQskIJl6.a14F3.3KEajRCBUV7Ccli2TI_g
 FzMPqWGItuRWca2khVU.kVgCvdsiY6ywrDLTjtV.zT.4WBPj16rvSw7Zyep9u4f.EvPtNbSmTpKT
 mzmCMxILJHagWJYIzFvOMlC0YrisQlkePZ0OQSJiQKhh8sHJOtXLmIcMuakwS2R_8Ozep6c2q5QG
 Bhcf_Fg6_1BDA.ZRqwtfEZW_Jwm1aauT09b9s4rMrFWl.pwFnYLrsMvPhQ7SQYO3EuKYfs7VoRgr
 5vZUDKVRn5ey0up35PH3dIYPpXLN_1DfXlhOdCITCrBSFwVfedHxOd0CRbFV3jBmAF1nU5Pnd59u
 y2zYW1bNzJ9IJ8S.oFdXZHIhl3SzrgoSciRLgV6qjCErzCmaCbaix7t5eAHVPx43gdIYm8WTsibi
 s2F0giq4ZsAekY9oaWTBN3XIxkVPUQVqPtRamM17RVxqf16eW3e3_z0KeoouKonxsc0KD12vIGab
 W4p1trqjA7fVJ7V6J15mvV5i1V6pIRMmO1U5SPD8AK_vetmoXwypqL584HjisF8.0m4C8OKVjisl
 1dN9W3p0Opsl5yiThB_jPDCpb1uLxPGPd8aonvxQ20LZP13sCRA3lwqEw1HfpbzNLYIDHHCFADum
 BWw5QGyBcODqstZJexZYEPXLO1a8XUfvzF7gGL7l82HmoWA.nWLoE8tHUkpleIinlaId7h6fbvwo
 0v1d.pRlN_LHXdPBFpyzSD3Yz6gNXM0sVSjI.IkRNDzkvOAOXQGIxA9LzB0_u8W14l9yGGKIuki.
 UeNIU_rmnz_sVJntJcKoI2Ncmxp6SAUD6tkhhO7vdWv4iLv4TOtG7XWEMzTXvJKR.xvrvUjUQfhU
 _Dgeuo8pitioJn46pX6qoLjbMURwlFdvsm9cgoy7kqojFKrH4QKnOSLE3E0DoEBz2gFx7OkMz3xf
 Z0fpkJaqVcl.70.S4ELr077hdp0cS47Wd2nHIWX.jKX_BHCQ3rsz6F0JTn_QxGC6fpYy..2rJNKO
 zll2tlyO.J.fsS62lS4otOSq23UNAjIRNVTmNaJe36xKyapW5ERsniIVxTtFZmcC67EdTw_OcApv
 .ntMYj1ES1npX3Vda1_TV9JRScbrRAwaVQ_AR4ETaFlcYMS3DbHGJ79GLguFqyGxZ795nsNXzITT
 lTW9Aw4QhZ9YaW61XYtcR9LI9sKvp8LxwnPyKzM439VKzPIGAH8lDzQCdkgDW34tbzXDT58eoSl3
 Zn9XqaJ58nieRpIpcrpF6VY18NUeSVSMsUV5OmsuNL33wGwTXhyPugdzDTNyQ8CB46_Brk4Gyjxr
 vZeH_t7kQpMInd4zavQEoDQSKDEzfyeO1qL3WiT2rTXL3go98idtya9.cS5pRWnI3OATWaktE7He
 3wfo_t6hu38J62IVJu4GOMXTfWZYBAY8I9UNpOnFxuapRZwbl8JNyqwtb4_a.bSJffY9JCdLse1R
 3N9F8D_Qf5IhUnePIZDMNrq6V0GTerVym.zVw0DMfRlCPzEXnfZO6adFARCXDKYtwLVItHYyASYM
 xxfow3auUHcGW_UlGDS2Qnl8elDcZep23ugiQWm7XPcv5UGaJ1PA4FlDzR5vKiNPEUyhnV2Fx7G3
 ZemRrziNkTyMAxUt.T_RJU4F7vZXFW9shYE5bFj4mqggm4tMqQeuw03uKVL_sLPDj8oK.781NOvr
 DMt9_4UZCZvTG01jLpT4wo.cAtle5yNdg8gEfYOQwezgrUyASSYHgIdtrse9_lwSgA4jqW_UmisF
 bYj6klX_vPSzWeZjmS7WA91IvGZi_zAnXh3l7bA61wl89UzZlRiitOemCWannkO4jAR8jrjTbXvp
 mNq2kAzDA.j41u5l7no2REDbqGRT0czJ6IQ--
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: 28f7cac3-0653-42a9-bcf1-14c8851a4f9c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Mon, 16 Mar 2026 11:45:00 +0000
Received: by hermes--production-bf1-697f88457-dbpm9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a85313bdb79b6ba306fe232175bbfbe2;
          Mon, 16 Mar 2026 11:34:49 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com
Subject: Re: [GSoC PATCH] apply: report the location of corrupt patches
Date: Mon, 16 Mar 2026 07:34:48 -0400
Message-ID: <20260316113448.77756-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315231538.68586-1-jerrywang183@yahoo.com>
References: <20260315231538.68586-1-jerrywang183@yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

I added a test to cover multiple patch inputs where one of them is
corrupted, and sent a v2.

Thanks,
Jialong
