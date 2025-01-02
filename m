Received: from sonic307-20.consmr.mail.sg3.yahoo.com (sonic307-20.consmr.mail.sg3.yahoo.com [106.10.241.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447AC1A8F68
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735812689; cv=none; b=Bw7ZWch9AzKONediGBNfSfKl7JgbItCuNPjvh5iJK5nV8ThWSYFLCGHW9cbVxxQbNNIlOuZRzJtAk6EKVnF4oIntgPnjlXVrUYWmduLhcSqpwSNddmaEMbEAX6vDziMV2QNykVPOVtTxb+aGn4Gnw1QHdAivR3JqK3APh31pkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735812689; c=relaxed/simple;
	bh=y//xdOAUIV82C+gZqPTfLtJEin2FmDpF6qzEFX2jV7k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LhBq98kd3n8qFSKgwQAjEIXU9ZTF6aKzU2eSCThjJUrIFzJTDZy0hzb4+PtXH4c/TYTDi50rYo0orBhd3pnXocUydwj4PrT6irfBCFV6dvHCECbhRGgx4Z6Q6RVgSWjEQ0HW+nb5SN1nwAEgdlwpnaEUxyXuAeGNpwGrKvZeKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=fail smtp.mailfrom=fedoraproject.org; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HgFyAelG; arc=none smtp.client-ip=106.10.241.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HgFyAelG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1735812678; bh=y//xdOAUIV82C+gZqPTfLtJEin2FmDpF6qzEFX2jV7k=; h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=HgFyAelGJP7vc6A8lhksAc+Wh+K6GrqYha+3L3UThYCHx4DdJelcc68f5esjdEfQKOV45OSxBgalfis0oHSzJQLYWPFkwwcG3j/akoQHwwpUPwT4FPzGhbnzgBAw9U9DBodtzaqcNCIlZBeZvzAk6Qrslzijd5tTyCrODlx0DinNfxVj9iP+3taq8HtYL07p0lO94anjUUmCQEWdJ/sRoqRYGjbKaNmVHJr6+x9ITJi6Dx5UbCIaBA6ktxQNcw7wywWANeE6lW4XzS89wjK85xorLDzJHGdpMzjqYbwtmAAQ8FaaVuOLJA7SqjC/H7Uhm1DPTN3goVAuvVTNTU83Rg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1735812678; bh=ArpxAq56HBRyKo6CaIlT8fxGEy3T1+52FPhra+VNTNZ=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=lkdhPAZeITBtedR0JHnXsDlpX6niyY1o7KDHlLlM1i8T4Vi0wJN+mD6j9fT5NsTf7uJSblxnnMCUTKa3Hilc8U/SHynGAclZaKhM3x6YzJpDYs7ofjf+IE7YPCZWZh9HwffEuED1qfNmYWNtOx+3Y/TXI2ABdjMfeu5t2C/SEvtXzkI/5w9UF2VWAacoCT12IbmXQmE1oc1kZSdRDV3NiiDjF97y1GnzGeigAh9WNcBJLxNlfNwrcht9Z/hChotlTSDKu1NUCi4mChu1M8tMd3rxdSn82AfJiEYjf2OeD51PF63Y9XS0+zK5Qyew0P7bWvXNGjDsrOkYMiq6uiQ+gA==
X-YMail-OSG: FIo5vskVM1mX7g4HS.f7pjusbMxfrzDujZXi0ziZNIdB.tCdfZT270loMi1qp_V
 M27O6P4Dh.czwAWJoKEOA5rTIH5RWlILoV2mFCzn9UfwjvGu5bFYyKBCFofTPjBEdI_seWFVKq0i
 _PqtEQlDe4fyTKHUn7lzaK9Stau4vxKwyHBGo6.OwLRrR7GxJJMGzaL4CeoxFYYm4yFbZoHzA4yp
 3nPDIgwywtMTduSY1.ENnc.VePu50.Vw_Koc4Gjh8sPXmH736tsrsYvDdIkusN7F_HPjhkZ0nyqQ
 mqSaHLB7e8fUeitqzqNjgz.dfqCeXTAMaQM8p6XO2lpvWrVBVynRC4Hs5SDhrlNpw0WHllK3IKR5
 y9ZhGS08aCHipIjmHcPt0A6Ulbm.9vI3gi92DjGuSX_pn0pzdIFfTaVXhjFCnfu76Cry2yJmTuKW
 Iltp5JNLRPCqm6enGZgDfH7vc9zDZDbQIY.dyeAaciOHfBpmx4BYEWmeFKAmRZIYKVohkOWXpD5x
 RKy6WpdO97G6Ts0SDoJB4NB0rPUJp1J.lhrzGU9H88zCVn4RrDw0526V8p2Sh1gwV3BGAp1QYfpX
 FA_34ywSBdRAYnrtJbKZCrw88oaaNYaITf.eAUlj19cGLDPCCiefz19UXPbNJhpaRKcMFPCPY6E7
 CB_SDzXTnVyhkzNH6jealf_gdsdP9DmPywvbdIeNVDhA2lPFQUTefzTAXOazn6WTrI8QaCHavkVH
 mE..s6E0akk4rEWjz4Y9OiSD8UCt27rlbWqDBI_Bztgc3veCQO1nrbgQprjgX5HOKr53pQnT1C_R
 9CRXVJ4AJ8NXMkYSScbUQ_vkaX3AtCAn41c6lfxDApaeCIlMIAdcSgUC29jpD_HEr7AnLTgXNjGN
 OKIOQRCB0lxV._XSUMAORUn2DhxnqOE8mxCyR2v2PgFLLYdm9ewsYzwZjJT5anduNQ4STyBB6mIw
 7FsuVw7Pd_KdkWRH3GypX7WrhcwQ1Ryx7QU1hfofa.3O8ZjPkROZOinQRKMzgRXgBaxYUq1awVL4
 02kqgKpydNLJmys0sSid8b_aXTnCeGJvw5gveiyn7FPhsaZdOkbmQnlCP7QvASy2QtkNcQFcoH1Q
 nQzu2Rya116IIC_iWmIKRKwyqKJaDoLo.CbctjCCrubBcAIKYJ4cK5fazQn.rhAcKxjxU1Yig3Qt
 ZoGCIofS5PbExF.Tv4tXuTJ81XqAUmitSQELUQ0YJyVGwSjusXsB_YtPnuZEX2VsNrmlFzG86IzA
 XJHffFL_A4nbGpoftcJz.jWmCD4D2qZXaGGQtKwAeh_sCLS3B3mzccGXEyTcfXAtsMHMboSKMfAs
 rVhqO9XKYOsYEz1O0Vo4mpB7Vg6VuwUwEdNfK2JHHtGG038FV53aP1ZpZSVWnhUH_qW2TXDve59T
 ySbj9Nn8oTI.lfbmHisOZy02O62YqPYsrG5c3JsjTsMwUpv2A8RMJXTVBiRzXiTOSTwDsbChPw7h
 pj5NEi7WxZKRUhreOMJTQN1w.W6jhz9vD2Rs596D06UZFNpO19O9Z1q5Tp4ZPE45lEneAYjm0lSm
 UmBGI.UlSx20suMOTFeOFyGp_CG3CqXk5pxHn3qLaSl6q2HX2ww40cUJElqYjhoWXEqle0Nor5Ql
 xDueYjRPXyu3ltxaixs5NHm5_wMtwIq6AjJXgVMm2B9WxW1MnrTNJPHbw4quTb9eHT_pSzOyRiB6
 IHWeYFgPcxPDwTlRe08ZYSYbx8V_vzhx3lEAwl0DrODPVkKmx2.sncS8_u_MJGnC_aJnGxQd8JEb
 zxJTVQMMxuXV2PPEY50KnzbDfbdKeqm2PLM7qplAMpS59qUDZTLil1a.f.PdAnHO8K3c4WhA.u..
 hnrmo3M6dEa.T7Zi0P28yjOJn2Z6KrPvlNJRNq4BMSris7miEbIdO84ORo9_hTfn3T5Pg_A2lKzh
 PB27sc74NfAOvWVYuokqPcKLvlqmWRexbZr8It88A.dwGqqaU5zxrtbgd9XPeBzWzPOPc2AEzSZi
 1YqiR9CsfRgNcH2fr08bNpK6ek1Iz.wHgdAKNAurt5xi_IRYZ5iVjRglcrUjCxslLeLHYM6yotYt
 MRG3PNhDpnKTXHa7u2Jvv7qCrjeXygSiqfYYR3FE7UVoQz702od0uayfcNpH2XElQF5SFe7VnUpn
 IBtOWj8VvksGyqYLdFT8UPKE2gHF0N7GflEQlOCUmCwRQO5pQ5CWxGFeOh_dJigkUSi4FAg0aSRC
 _VezGGeccS8bB.TCa8gl1rrxshSGMCbmLuWpGzOoXwQBnUZp5vhtLfAhd37a89cdxXsz1Xf7S_mE
 X1Jeeef6GUwYxHFsku35owjmY9FPgsA--
X-Sonic-MF: <pjp@fedoraproject.org>
X-Sonic-ID: 193421b3-c548-4d7c-a6da-6cd0739addde
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.sg3.yahoo.com with HTTP; Thu, 2 Jan 2025 10:11:18 +0000
Date: Thu, 2 Jan 2025 10:11:12 +0000 (UTC)
From: Prasad Pandit <pjp@fedoraproject.org>
Reply-To: Prasad Pandit <pj.pandit@yahoo.in>
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <2075804114.5670956.1735812672910@mail.yahoo.com>
In-Reply-To: <xmqq1pxmxyoo.fsf@gitster.g>
References: <1964163554.5326830.1735643984559.ref@mail.yahoo.com> <1964163554.5326830.1735643984559@mail.yahoo.com> <xmqq1pxmxyoo.fsf@gitster.g>
Subject: Re: File missing from git branch
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.23040 YMailNorrin

On Wednesday 1 January, 2025 at 10:24:08 pm IST, Junio C Hamano <gitster@po=
box.com> wrote:=C2=A0
>> * Generally committed local changes are visible across local branches, r=
ight?
>
>Not at all.
>
>In fact, the contents on branch A is unmolested by the act of
>committing changes on branch B.=C2=A0 They are independent lines of
>development.=C2=A0 Otherwise your version control system is broken.
>

* Sorry, my question was wrong. Let's say

=C2=A0 =C2=A0 day-0:
=C2=A0 =C2=A0 =C2=A0 - Fork is created
=C2=A0 =C2=A0 day-1:
=C2=A0 =C2=A0 =C2=A0 - upstream commits pulled into 'main' branch
=C2=A0 =C2=A0 =C2=A0 - new files are committed into 'main' branch
=C2=A0 =C2=A0 day-2:
=C2=A0 =C2=A0 =C2=A0 - upstream commits pulled into 'main' branch=C2=A0
=C2=A0 =C2=A0 =C2=A0 - 'new-branch-1' created from 'main' branch
=C2=A0 =C2=A0 day-3:
=C2=A0 =C2=A0 =C2=A0 - upstream commits pulled into 'main' branch
=C2=A0 =C2=A0 =C2=A0 - 'new-branch-2' created from 'main' branch
=C2=A0 =C2=A0 ...
=C2=A0 =C2=A0 day-n
=C2=A0 =C2=A0 =C2=A0 - upstream commits pulled into 'main' branch
=C2=A0 =C2=A0 =C2=A0 - 'new-branch-n' created from 'main' branch

* Generally committed local changes are visible across _new_ branches creat=
ed from the local branch, right? ie. 'new-branch-1', 'new-branch-2', 'new-b=
ranch-n' all created from the 'main' branch, should have the files which we=
re committed into 'main' branch on day-1, right? That is not happening.


Thank you.
---
=C2=A0 -Prasad
