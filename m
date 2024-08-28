Received: from sonic321-23.consmr.mail.ne1.yahoo.com (sonic321-23.consmr.mail.ne1.yahoo.com [66.163.185.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2A15A858
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877283; cv=none; b=QPSeh4fqU6TAK1zB+3a9HK/CV1MbYgt0QEJCnWwhuuOqFIpoKXOLWHsRzqnMrHjBh82VQFykt9aJcE2TWDWDlvTpT5PvP/Zl8GmbmxnveM/MBoI6S+ZcKdNp+dz96nU6cCD/s32ihCARxVN07rc2PqQ5su4yXHCcynNgpIPzeDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877283; c=relaxed/simple;
	bh=XniraHALnp2nkP656kC3Q8hq2/Xm5C/bcKcbPvlzt0U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=k8vIaQKCRbOXtKj4o8GEMqo/AaMKU+vU4reHuTA+5UJYaZL0gYlNBM5N48ibt7UmhBM+phBZKJRzeILoBk1Bxppi4JOX+reEgMU6+LcbJxE/0+8Nn8dh33Fz5egHeyKmRJAOmx1K3Esh6Upg4TZ8thXeo101AKh51nTGZ0DhnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ahdkcvaz; arc=none smtp.client-ip=66.163.185.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ahdkcvaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724877280; bh=XniraHALnp2nkP656kC3Q8hq2/Xm5C/bcKcbPvlzt0U=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=AhdkcvazyLxa9z2vpvoZSjfF/ZwiRz2U8pwbQpB1csw8v+pe/7O9Kq37FPoSkX4fciVtHgflko6aBXmOXPRtB2EsMslDU+4BFINEe7GZMorqGFaLvIjETmdRLpMSuAIerRFZHQSmvdZlBXCbMnCB82zwmEc7pGjsjndu+cQ+kkJHCTQtSSWv5WXfkhKg56dwvBM+hBuYchKFtbFwErFEIGXGij3xlcUcO3QVqb46IymotJUmIMPjvt+fhJYhcIXiSg2F3C8dHj9n3q32xo1GdXjsB1qFHj6pgzdSntplpYbvh9CTIbJwCllwzYbzkAo9o9YBmC2rbBhbb/31TGq0fw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724877280; bh=n0xYlizyag22yA0RwMcpMkkRiLUN+u91d4MYPAy5HRT=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=k2QtxPtwqt+4QGtgbahNo8Wy5eRvczWzmKS0SyEUIKi7CmNB1O3YWplsmE9woe+olUIcWbvsmlm1PVidg5OaAqp0JAEU6hY0r8QjW5T+Sxw51ng1pS3gsCTFUUDeXknuzFXpTsRgqxAoC9l9TTSK913XxCJ/Hd1N9nd7QyVUS1QrVx5um6CbfQfIpUM+hlIqb3/v1TTeqLQqnbLuCHoA8JvUHTLZ+BWCpLqTUz8aW24aZwKV9jLAK8z1Txak3pjSJKbouZyfWw8QDsVr37CeQWki6JNUuonXXKDnezob7Wxi6Ol3g1GiZpIms5DlSOT5/MG71C5JQjRD4oVAx2QhFQ==
X-YMail-OSG: wVSqeIkVM1lStW2gI_3Z7JYjP4gWd1DVgtX8FG5f_gh0oqXygUPDK3jQO7A9Hds
 vRNS1_XU34YbXlgTSjprP92x8zooyqiraPA_sRaE_5jBfV8IFUy6d2RYU9IfwSFTGTVbUDy4Uiat
 .9_5iEcpECI3ddaQKbZXjqF2ttLruM4igNlM_RU3tQbATSIpex8WUvtLHxOAugK5bzozM9m6Ikx5
 VM.frwPPh2XvCyHpDAsmbioXpn5yP6tZlPCYfR.KgcG5N9sZDAZJkgoIHC09ZuTVR1fPx2NR4F7e
 0liX96UVvbW9MdPpFr5I3Sn1O9vCKsRF75MK8.DPkLBDd0ukS4Qpk11lCt2g2WANO4frxr7.D68C
 1uXAckdwPlrc7GUYCrL4VL7DE58OKDMv7Ju..Pods1myg5IhIlQZO7obNH0XY9Kj5uIQTqJmz1Jl
 _uBdSOw7rYttBoe_hcOvAgIOmCybLZ_a9ipIN0ucQfCVCJy1H1tA77LqznDVbUU8xJJcf3_bbfbO
 FVxmIXcfOzUD2ebQJtmjLBTVjJybhTXyvjv7_Da1zPaSLfgbYF6S53tzOjBEH3HthihMWvK9XnvJ
 ibxOmARDZRcX2iTtIO2FDIA7ttNdzaxNRJMelFhynHEGa8fLREG_tGGFaBAp8.AGbL3xkKJ5GdLR
 JLQNheaf1Y5bKPDvyn_EmjItaJPm4ljjF0G6B9uEeTObr.6L1pOQnKNOUwKhjLXV.9q2hFwQFZa.
 sux5aJhGr.i3LszcHI_ZBRuV.B5Me2QcJ2ZKstzA84KMzgJZe2eGkMdEeucZa_KxXjTW9qNSDdzu
 wN8sL8pBI1atILmDWEexX2KCHnjryRGBcI0fjUcBUe53aE_c2rxXWpLDE4nVBN7PADnKuzzNmoCA
 GVSD3WAcIPzj8ZjxVxvbKhJB5vg9vNFc_lE5qw1OKNbAhHimWVpjELaNrmQJKhbF00wegceGur9N
 i6fUlmhXhDI_mH9TwzTAtC7PQ1eeDh81FjAGgInRl5NeBdXBZ_CvSWOxrd2uY5P_a8BxM40dfOaA
 HjIywLJO26co497CfyR9YFNFFZ2gIQHHAWjz_YBfPSU11zYFWugG2JubzD4llvhxqGLKyFt6LfTg
 jX83BbXaPUrAlKBnegpA61ylvTTaecJN6ksRwXf9JGul2FdHA_jiKa0QsAfQzbwGSEtDDZF7SmKO
 RrGl.FeJQGOY3Mpnhrc74fIkypcMNfCdQgdCHhtS073cPBlaQ05FBejxJAyJdIy2tMpCgDjQdRFH
 VpTWADG_qTvhBHFZ0UijvRj0WhqP8TdYrc3dZ8eyiTlSPs59aLYXKG3yEYvQxh.FiCqpwwFSjEUP
 _AdUkaGnTAv3HX1SkPjllGtscg5yvFp44szUdRTvisaLqN7NDClBGe6Ie4wzO8Z6ID5EzHwOJMMT
 sz8pNmtZEaxR4NmJHdizTlcEa7EQVLhgTS4isM3p0ZVAryVn8trQyxMWxMbEFBKsIYeplTKzQbaB
 ChzY7Cs72zTNC7SYbK_FulkmEobHTJnYk1Y9k5saWcQJ.EJ8_8ZOM6UkPJzMEje26jKmQvXstTmp
 LICOjFMTBtTCNMThK2wwSEF8bj3zErL7aXOk9mBxQlcNRAIis5GKpBmzhEgeB6jUBeEdDjY423ki
 b3jW3T28leMkahDsa9LNBtnWgp7sGkb8aEUscmFhW0LRTq3s3dR81i_zfcdZC7Um9X25ElIVaQgW
 _hFR5ixHjZctmKc2emer_p0vdLIS7LcxbYp.UyTfXYw4A8rWa7Pjr0BMO9bDqgAc8wCvdk8774N6
 KSQZ.AVGzKoOxXtCdilAWDaOUE2if9fz.VebIsdzvntYTKGAwJbExaX92jDJJi8g_dL_RyioOxAv
 Q0oUDVIBuqD94kKKJag.E8JR_ki6_XVGlrlMUFDMvoZEkT4ttxIxn3TJR03pF1CZn6g5XSxdT3wY
 43oq5hNfZEt6DDbwnHOCRmHTQbEI0ebsKEsbGGGdAIQf8jnvGRQgyY1lF9r.3y0LCKQPSmB.D0cT
 S9QI.E7D_UvS1rm952.J0ve_T5VMS6GYf7Z.GoyYIe1fT2fPCsIEWHOnk7qWOBNw5R58zBQEwht_
 MypbUCI5PLocADyR7S3.GG0bqssxJ7Scp8wzaM22XoNElnSB_GYIKjKth_sWvrWDBbYAg4PA.tqW
 _h0KSPrSGsQz0hxG8ub1k_cFk44X2AwpPUmk_GMYv.kQyQbz1SmTMN32NBihZDpGxMuKw5K51Ucw
 ZnbiFrSQI6uMVU62mk8xBzO1H
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 5d8f4f97-6c88-4b0f-a85a-09d7a224f6e7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic321.consmr.mail.ne1.yahoo.com with HTTP; Wed, 28 Aug 2024 20:34:40 +0000
Date: Wed, 28 Aug 2024 19:54:08 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Avi Halachmi via GitGitGadget <gitgitgadget@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, 
	Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <703154053.591587.1724874848280@mail.yahoo.com>
In-Reply-To: <1689227029.5308571.1724168839763@mail.yahoo.com>
References: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com> <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com> <xmqqr0ajb467.fsf@gitster.g> <1689227029.5308571.1724168839763@mail.yahoo.com>
Subject: Re: [PATCH v4 0/8] git-prompt: support more shells v4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22645 YMailNorrin

 Thanks for merging the git-prompt portability improvements into
master, and for coordinating the development of git all those years!

I probably won't be following the git mailing list closely, but do
feel free to email or CC me with any question or other comments,
either specically about git-prompt, or anything else you think I
might be able to help with (I'm guessing mainly shell-related).

Best regards,

Avi Halachmi
