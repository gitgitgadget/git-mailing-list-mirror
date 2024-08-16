Received: from sonic320-25.consmr.mail.bf2.yahoo.com (sonic320-25.consmr.mail.bf2.yahoo.com [74.6.128.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF48170A2D
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802989; cv=none; b=aYcWw0ymcelUL76P1DVWX4WDOujUkbLYlIDbK/CrsNK+WP//xTxmX8b/HfW2ghIqIl5Vh4tCedE1KMBRFLXi5gkp7nrPF0Mk9RHVEn/WkWI43OucmCv0Tfm8vDMkzURsMQK8tXaBWax3rrDdEgt/OzyDB2XJ8cBAkyquiHWih1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802989; c=relaxed/simple;
	bh=zlDT2DJ2vVblsreOQEZIVJBYB7YB1JAn9yapa6mnNkE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EqJlZCbzW6Bfiu+pWEVPe1TWS+X4OtKGzHaPRRmVhdL/osOmJ2COZUNO+ty8Z4TPZ2eq6gQUDsUUG4MphmeDDQhfrHR85/3/P41WvEixFZIT/GfmkuJrq8qgeQnkCilUhLDOwFX+diUTw0V8ffz9759lh7cQd79oW45h1aDKQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=o2pOrEkU; arc=none smtp.client-ip=74.6.128.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o2pOrEkU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723802987; bh=zlDT2DJ2vVblsreOQEZIVJBYB7YB1JAn9yapa6mnNkE=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=o2pOrEkU60mD+5YROLF5zQRzav9PLCeOMzeFzgiJcf6X9rkixymRyUiTu9u7JySMQZRADZ1Sy3jF/vIQlbQhpUVmQdNCWuFOMaHN5MKdjM6vYYzxkhXLzVDagCXuN5dU5RALj20cv98Guv4ekbYYanzHBEBl31B+NtQZviv3ffS9ZHENQz9lEEf7d7hW2j9x/j4EgCfGjZKrdxpYhqOSHG2SoLEb0ddXQdjjC2jiuKVLlC+F6/BP+5qqaRc5JIB/UMhRXTCMs15Odxce4m49U0NoOwR4dmefcitk7NdAa187w6Zu5cwiRDvda9zP2kqEkxBUzqA4nz7Kfd6Aj1dmpQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723802987; bh=sbDIkPWCOWVZQ+jh8O6MJR2xPYOLIV+5T+H4aoGqD2j=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=XgqDfqnwz67yZW1/+ITkAn8KFbKV+JaQjhsTCMeve7FfDXo7bgwyMmv8RiHBkoG0Vm+t2ohPCfwCPmCpXE+zlxd16Xv0089y3fHJUxrx7dkWq8bnzav/o0OjiF1fpjv6MEVxgso9B2Skimd12BJMFWsyQSeUfkQhpLF6a/Al7pdrVWdsaYIsZRr40I8SFh9o/r4qDIk15N/Ne5c9RMaLnmJ97xrkXC7XjNkMBR268B0X20vjhDk6qQJfwxj0HBpp9VxwWlHeLfDU8tbInqbf1XJmBH6pFh67FjbMkyR7InW18RqkOzFINK1sbK0LZMYwOh0bIaWI5hSO2KxfNHqmDA==
X-YMail-OSG: _4HeaXYVM1m8jUdIeVJd4klGETLv_vwiDQndSm6L22s48mQ097AS0Q7PKG32mcv
 nSUWX.WqFsL272kmUzpSfTjGimPx6nfuSZXzIeMFRas50LDQ6Wfa1D05GSQy1MeLIBboO1Ol0tRC
 h71irAWSeoTCPn2b31yL4a8Tykj0XE0SPPtat2_CwzW4PLThDmp_cMQ6T__W4zck1.Xm71YbZeYs
 cM60r.sxh_y5rOgL84B2ntL8qFjvIz64hYJx8jc_ZqHaNk4aOCkYog5WYE0jEQTf9DCWBhkYmTfx
 jLAHEEwzzA68I.ZO35YeWaOAg1tOu_ITb99YkPyGUifZGIAc5oDwlctAJflNsH5qLE0gJL_8yd4A
 VOTLP_VSVAee7fm5vTAG7MLhu1bsbx0TbYk.65_6EUEJV_UpFFE4oPrW1.AuzBChylyI.YDEsvI.
 dKTC33Z1JBXEpiWbODrkxpbY5M7.vykcZv3rirwacKgwIylpVvx_ZxR9ckus8db23Yu3WqxiCPgy
 LFZgujjMfJFvRmPkKJLhn5ivxrrfiy4ksDzxpZMhIrBUytPRJvWK4jCDfj_gcy3U7iXyfOoF7jlp
 5wXQVh7mvt8lhkKnD7IXR4qr_WmqlXQWEe.i2fiWKuOKdMZnHpn6X79gkUpwws53dnGP8_2WzyZy
 GGCGUWyha.1olRFNHKbOV3H_lmy1PmbD.24d2R9B5A4lWKVUN9lmikFnnpFqmAe6K7w5oQloPmy1
 jO62sTpgMbN7vGtOOC52fggbvhbkITWQWyO4.r4LvtlY0fQY0R8lrvAvsDyGW9spqfN86e_PJDSL
 zVzJwcgh6lgLYL4i0dpGwb5FCxPg3BjIXfFo2uAybYhd11sq_xCMUIF2IOpGN0vrJioLn2H1_HuA
 MHnln7KDgMXY7Io_2sEdVmCQ8sSDzsuYUrD2aPARBFpT00vBe3.Y1.NvIrWqtUTV6bQFMwclPTwz
 MGCOcd9X_N_gQTPKxzbI.Ks4D3zJKS7y1NO8j.swaiEleC9DbbG8EfvxwZzQeSc5OMK9VS56Q8ah
 BZN9y0IxxlP9W6v.o815DQKswkOwusRyicVdTrjsFTgFwFkaaai4Qq9r9Q6YQwLubk2bw4CuGiaW
 .PAp0ywAILSZbqYPVKcK2BrjaybkYrq32cwDwG6ui15lnHAOyTbLeCZUMCpO5XxNBArWXqp1xpPc
 8n8g42owQTmbU3bflCScizNdTptQs_vFQFvc06Y1_BF6wef.EgXADcest5VdAlZ9yGEbjKIQ.I_n
 dyXQcvoW8YbGtUno1SuoTSsUSWmCIE9coFHpMDQf4m9EPT0a0Da6J7hyZXNmQa8VxtyTO1_eXBBC
 ake2hrTVCfVhsbNPGm9nArzSj3ljjv0wzoT9PFc0pLsFd3np.BgwAD3Fu2cJFulgAjAT16VNKFXs
 ILXSXhXQE76JaioPJHyttqPDbICmI.7NUNuI8wV2eLlrHrR.oG1P8mrYQhUHEDzM1ASpM7hxO0IT
 MFjTqeLuEvwH4BCxpVFixaqu3BygBJTQtBS9JOXObWWGhmCtcJcX5sQAfM9cp2h70JbWtGfBXqd5
 7IDu.OHojTpHbghXLcedq__ODyHOB5LrRw5U._PUUQ.3CvFl5ZBCpCO2tXL3_DAfzo6pF3Kd1x3_
 dDKU9LKlPs8iRVDrPrYkjoIiou2xcoM9MLebuECFwwI.Am2b.ECl2lVZkE2SenDXhJ__HTiQ_929
 gNPMpXm0P6x9J11WHVCr7moDkjcX3_TeqxDDHhNasKRpbDZ21nTWMK.mRycWsSSk6pU3k0Q4lAu.
 .VV3YRTkRjcbqmcKVRc2TYh0pUQoQyb9jvDxXdYgDqu92xGc4TSuEoj1iTBJSPK_EYxT.WcBpAQ0
 UHKghS4dH0Up8fKWA4.ZIDRkZUFVvdhN_DdLIWJPCHBrFi9WgU1JF_2KDK7nzet01iEj77PDa6ip
 zxsbzOwUqiYJq3xcQXPJbaBBc3mwntQUS9.AoOsZc9mALD7GWGP.Sd7c6dZt_JDN8n1BYGlO7lEI
 omIn027xjRLszETUJVh6Bm9mtLBxWprXHw4aY.m7jRPy6IYb3A2FlBelWQGzJYhoCxqyLuYlPBld
 UJuOQMdMt0ALF6X3U80AVqWKpIVjnwA8AJhHykPWr0Q4mMY5GEZWun0iuzSq9Xcuh1OfGvApsOd3
 vVthMyTGfLUT5Muo2ndaWcShoitypnP.lgf2EzRVQJKc50c0O7H6kk3lp_g4vWTZebApP3rth6Wa
 O1FFDD6mLjXCHl8D2xMvvI1bg_ldC2B8Kgg--
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 0bbec4d5-4468-46e1-a355-6cf1d4524f9a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic320.consmr.mail.bf2.yahoo.com with HTTP; Fri, 16 Aug 2024 10:09:47 +0000
Date: Fri, 16 Aug 2024 09:59:35 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <902082087.4500648.1723802375900@mail.yahoo.com>
In-Reply-To: <Zr8SxmujUZ7Run60@tanuki>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com> <4aa75cdb5dddca0fa2a4817e856d26f724cb43eb.1723727653.git.gitgitgadget@gmail.com> <Zr8SxmujUZ7Run60@tanuki>
Subject: Re: [PATCH v2 7/8] git-prompt: ta-da! document usage in other
 shells
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22544 YMailNorrin

 On Friday, August 16, 2024 at 11:50:17 AM GMT+3, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Aug 15, 2024 at 01:14:12PM +0000, Avi Halachmi (:avih) via GitGitGadget wrote:
>>
>> +# Conpatibility with other shells (beyond bash/zsh):
>
> s/Conpatibility/Compatibility/

Thanks. Will be fixed in v3.
