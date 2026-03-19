Received: from sonic312-21.consmr.mail.bf2.yahoo.com (sonic312-21.consmr.mail.bf2.yahoo.com [74.6.128.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C429E0F6
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955156; cv=none; b=Rx2QQ0u8mXa395i9GWGY12LdRA8/cWTRK6W24eh7hKKFXjhw1nwdE9vDmm7i1i9jrStrnUmRNESZP2iQnaz8UAUlWr8RTojvX7qixNBllltbxRyuKM557iIo++bFtPMIWgZ50tZRXH1XOzirkN8k/W4hWpi88/ZVTILqK1IYzFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955156; c=relaxed/simple;
	bh=hwRhY/dhWywrudMuUe1RkXqMBTkux7lmpqGpM0PhkpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJtkMTZ/xmUz9dZT1UavdPOMVnEnA3VgNRdiW1Y2YSKgnoi3WA48kQ+GacgA5DQWI71so9pqZjIGnoP+1ltlvdNiG9c60OWggtIEZAfAKhZ4RoVJfnjuA7dwSuMO0QLQe0RPLbycObbP95KKcqSExywzDCoyWp5fJn/3Rv+8vEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mopD20mr; arc=none smtp.client-ip=74.6.128.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mopD20mr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773955154; bh=sVEtFAjGhn2bd4e1EBGlcp40e5POP2/QTUQ4nCsguc0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mopD20mrdge1HfIyLKJU+L8cSu2qwPp4bLrOA/sCsGOsL5PazH3RM4Bs0o8Rht/0Oieo6Cbb+sO4N95c3RIr1raQfckR2EUYQWsCOsPbiMQvxFSRnyRt/tH7mNO2TfdNw6wiQa0CPdZnlV83N41GH/SF84fZc62Ht7i/Q1jO9hXctHrO/eATwrsAPJ6eAgOX3z20anr3RhGrIlIg+Yk/yIBDBZPknNQkKnf0hlWCE4ehLv/ZVpHKy2PN2qxSppOPfRyLxES/M/r2Qvekms9DXMcCg+UkOqeasC+6VUfQXQPng7ZNDl2TCKZuxyXo+ZUgEy1Iqjwfah093pKw4O0ebw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773955154; bh=8Jsj2rgQc6S+5GIeGxDTm1+2ieIBUZXnMh+GyvnZdyM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nuaeIjHLdUZSXMDN8c9fuI6zRakQ6OD0fQvTPf4Oqp9yfS4SDLDjsxqm0KI/KK6anRiwr89/5d8KLOUifWpyq3rSmzCf5xTu4VrkfOxQGgGAYGbCSnN4ZmcQWiy4jom4y4pKEOvBHVjJuTFp3nlBsgNZh4uzK8i8uzKNi4ejqczfcjTesn2WldabgeQrWK/Wh2jpDv+cfyzw4tgbGf5hQH9W5GaUj18CInu8RXabqgHhph7bsDL0YFRcANNV2QTVpasredZeqsolix4sUidOsevzZwZzxkjd95quFkLVHyvvwRfygl8dSdavexpBUJau560oRVR9qoEqP3xFIVqt/Q==
X-YMail-OSG: wtHOlvYVM1miinE72OBxYlCuxuOf_loImEi1mdptbG2yhS6lPvJrGr1rA9DttTO
 onSw5pyEEl.NkgVSj4BlUFS3IqGPm_90iE1J.NTOD6cYd4.tGo8hKfdJIhk6PO6M85UehIBggghN
 _dSJLC3Ga1afM02ZJwJ9BQzcfi_xmElx4BVuP3gyAvmQDd2RRZDbSbl5lvVWrSbdVOrvQ2CjQb0v
 Oqsr_QLHeLSgdv47J5w._yTjS1N3ZsmChOo2OI.MyKwPwavj7Bk6iQgF3KgaotuoNXgMtHym3GyX
 6XNXNEEoF31ltGTaXYIAbCnvsBSblU.BBzMU8ad7x45Cn5gv96p9P2GG6wORZsekePOqR0p3bh88
 h7Z5FmEPziHa8h_vcSH6YKVZAW0P_i8I0mM0D9DKPvfqmFZgejQ35cMaOBcJz6w1SR0CLOBrdos1
 yl1BXs5fALzOGu7i8MpyeToM.FkifRrkRzXzgJY8yav1jkShIJDXn93VnhLMwwvd56qW.M2DWBqc
 KAPmLVbt2zpCkIguZYG8OQy5ixM.wjTIWsJznXrR.srI7z_pkcOyw7R94JH4EtmSzcaoI.3YdAva
 9e7RpwXaHgojQ9cRwplufQJQGaINym8RJ56xVGVPlcV_MFn7W6Fq6GRzK3MMzKU.ruEmcfQdqzLN
 Zn8CplnByLNNvq4WOt2ODz4MBRYvFNRx8we7qgnah_U.bWomDM._6cUMxqp2fahdN.aCd0HsyfVU
 jcVOdFco43CZ3AIE8IGendrCBeiJyfBhVXsi5X2IpakCuSkCte21IVqsv3oHsz35goJbEap4STLt
 E19oDbpKI86Lt.05r2q8TEJDXAN4i7wjoEO2xnZX7lwlgvKzTGexNvHFVxPPG.deb14zuwbD7vPL
 IiAVNXNkWfy8WMsnYdWwuhLUXqJ9BZQ2vEGAfr3ID7jeRT7xz7xm.Eo7q.GIY04nVqC6N7Aj42Dl
 Z4l_VMe5IM5BdT0_3ywvF5f0NnSSI656w1jDLuQDVjwQ.Q3a_wVXVHtLx2xkAt7mqsrCyfGhm92x
 T8gcl4jBcunVxTwWaiUXa31tN.AB7q.O_KLaDQHk_36WaCwxz4D4wPzfKnNdw0elVimv_37bq3jK
 jbm.MtNyPIqTyUNI6WsJYCgtgSJvRpf19TaIGkRX14w3xLuv1Si_OD5uZd5ZQGccujfowc80pWOe
 gqx_ybvrap_KuhkZgpLVU58D53u96ua_nS6WZg.UavNPM0boDlNcfykUVyBM7n5idvK16Sxjw88h
 6ybM7hKH1ydgBivb5poos8zzjfCt72ITcPwBZjUVeHKsNWLNp32_EKwMOQfQMM_rfziMZtr0__Sk
 THK_nfpS32mt6dxG_9_JWWa9P._lXXshZSrNxcTFmJQIRUENCVZXawTdO5c.2KIpMSHx256jChdo
 4BUMl8V0WXhCNmWM7Ot44pQYBPRiKKuA9wAyF4zykYq1OXKLaNVqrxinnKTRvLypo2fbOGFXP2uU
 uTU7Tg843_7Tj84qRSYH_E33IheSjDGAVuBTVo9YHEN9wj11YEOHMuxfGaqpK6vOVDqNO4zwAIKj
 JkglXeBjiiji0MR21JhVwGM4pL8AppZZzPNMcqH5N56kWir7SegkjcQkxEb8qaxUqLdvV3IKWEIQ
 5sB7QYA2zOG7YaR8eK0Y0bm3WdMO8qJlpp502qcaH5qGNn7B6QDzRR2f4rBnKZy1CWN_rH8mK8pg
 k5dIYZHTVa9m3VF8TxwnEc5OOEj00gzaMvyMzdE7r8ilNiECQIDY8ONIIJEKATKbrD4py4NR4Xjt
 3mTO_tXjThXj_t2.Cpa089Sy4CGF1bVe3tFWVgAmwRaN0PV0tgDfcRnD6_polf6Ji4dg9mHCSJ5z
 Z1P_TNwga2p6JYVAnF5uGNUFLiOOMyCTrVRnLENE.b9RrWLx_dXkjeegSuNTiSLhDddDmKk5R3L7
 gKtU.0rixLl8bcOvoBuT37ME8l.8Aha5cVBrqngsAm6byBP4Z20SSTnc_IAOzR85VHW0i1pWG7Q2
 Cy.J4s6okZEzpCuYqAQIYLdVXXUbJQPeGbrztTewvn32nGELA9NNgMMEI67A2
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: f2162683-548f-4d06-a7d2-29505f9530c5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 19 Mar 2026 21:19:14 +0000
Received: by hermes--production-bf1-697f88457-5cjx5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bbc8cadfb01f01b7eedfd2543e5a1487;
          Thu, 19 Mar 2026 20:58:54 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: git@vger.kernel.org
Cc: Jialong Wang <jerrywang183@yahoo.com>,
	gitster@pobox.com,
	karthik.188@gmail.com,
	eslam.reda.div@gmail.com,
	gitgitgadget@gmail.com,
	phillip.wood123@gmail.com,
	lucasseikioshiro@gmail.com
Subject: Re: [PATCH v6 5/6] t1900: cover repo info path keys and path-format
Date: Thu, 19 Mar 2026 16:58:54 -0400
Message-ID: <20260319205854.15214-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
References: <pull.2208.v6.git.git.1772428548.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eslam,

Thanks for working on this. I tried the v6 branch locally, and the
path-key coverage looks good overall, but I think t1900 still misses a
few non-default layouts that seem worth covering.

In particular, I think it would be useful to add coverage for:

  - linked worktrees, where path.git-dir points into
    .git/worktrees/<name>, path.common-dir still points at the main
    .git, and path.toplevel points at the linked checkout

  - repositories created with --separate-git-dir, especially
    path.git-dir with --path-format=relative

  - path.superproject-working-tree with --path-format=relative in a
    submodule

I tested these locally against rev-parse and they seem to behave as
expected, so they may make good follow-up coverage for this series.

Thanks,
Jialong
