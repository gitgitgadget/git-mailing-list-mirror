Received: from sonic321-24.consmr.mail.ne1.yahoo.com (sonic321-24.consmr.mail.ne1.yahoo.com [66.163.185.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9B312BE9E
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718942490; cv=none; b=LxoKESaftnLJt/yoJYYIv/3nYymEvqIsRLP+yFfez1v4k1ZW4jmkOFkl5mThsI3xAyTvAXVIqxJ6VMdSQE4Q00qRAyImfP+N+JCkx4LMV+IvD+AS0zrbBuTcwZStfs8O+DXowNqIJPw/Tek1TfX6QxUiSJ0VP0drR94WtEpzHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718942490; c=relaxed/simple;
	bh=z9kcsJaEyDi9pkZ929lkGJcm6QFE9Tb7q51B9BRa13Q=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=GuJYQpWh5/Afc9VOArkgJ8vnt6iiQWpkJxAlxSYqUKYaquIvqrcJPlIlICbJhLj3HdpxMU3U/wC9hsw9rQ26L/2p1axvWJXDnUlkyGF82BV8Xc2tgi8XSYBH/42CVKGm2vYFboP8ztSL9G6soQSycZgs/zWP7oP+IzC2nVNo6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=t+L0Ruqz; arc=none smtp.client-ip=66.163.185.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="t+L0Ruqz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718942482; bh=z9kcsJaEyDi9pkZ929lkGJcm6QFE9Tb7q51B9BRa13Q=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=t+L0RuqzRiPvBYXVra8LL8CBLSjjEyNo3BdTk7WUA0S7GMqwNJs15XNLh6AggqC8FaIFUBEvp8QnnuCmo+Pzln89BbGMN1s5NROgjuQxRj3foHgZFUoC/uMJXcAvHkR/KPM1G7AGGi28oL5B3QCsbkk28ZfexWqJoa0QGYf4YcHZ5XlZ+N6iH/eeTIBEqFXjA6+tuPR+QN3PtKFTqSV+CYn0BuYqcivaQIAGBceUSyqtVI08PPEnhjgk1w8ZVtoUliLdzlFX8Wz/LvCp5Vln+DxGw4EC95fUz5CGbzdcXD4DeHy3GRYXv0ajm4VYFAUaSRszUhiTOO5Zh9f17fV1uA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718942482; bh=t0U1BHReKxEs4sXh+o1q6hYD2vz1KnCXlHANqtBoZlZ=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ElRtoDIU0Lx/Drefcns9i8n2DMZvcVTEUlM2dyLDJCdm1InPRA3F1wLl9zqN1jvq+23RRoqIVjhigXmv6a8apkBCpHRU2VzYB5iH7KQ6V8K4L9GpGEXO1GhLy+jw4nWJQqZbuZm0J7xn8HvluY7WC/r+nSrr8xPecitH2QMdhldTHPSVNjL2ZCe9ZoW98HfqSohQMjmng8QcraRhvoyogJSmDUe3hSeXi698sPcu8AHZQNd+0ZKry/E+IhDIjup+hkV+0S62m9mDKoGQqnUdKqllRFQ0v4EUCz636inZd4hReAq3KEf6b4zeOxLyTCbcWj7z0X0elcbZ5MhS6iiX8w==
X-YMail-OSG: FvQOTs8VM1nRgcI6tZCM18BWEpyJ8ZDPfrrnMAKciro2d0IH1VMwJEDRGYbgBpq
 YBYGwJTaAkMjbssBzNpOFxIjnJa48fBmjfp7ffr6NfUqb_XPTtkl6LSpc0pS2U05gO4liZKAoVhO
 im_K7nmQDzQkaoLcsG.SWhmjMHpQpap19cZae4dEKgYKAx1xFnA6vNyG7RLjdyySK90TC.98eowZ
 dVGLiH8UCnYI2xxlWufriIQIOhLwYEkvkNg9gkJq8nODzLslCNi_j9dy.oMxyuV1m38xgIhrb7gR
 pvDmlcpbexVwp5TCtmJIkTda_SVrCFHToko.pwNYbb.EgnDnnikxtQycjn.wGt6xcdQB1m13MvPv
 EVoC8aOGWbDVqE_k5GTyTO91GG75ktczsYxc1o71vD9vZNzpiey3J8EMCxi56Jz7MlOESl_GYyXt
 GS.gnh1wNU9Q81kGwpbsekysMRqSIdcFZS6BksrRor.s6.Y878CLASkha6dil3qBhi0cjYfwFInL
 HK3PbUiLJj1BhCLkkbn13PHuK4kHyFD2Gz5A4MwZkIh77uwspY5CocZTM_OOut2LXVuSdyNtMhpt
 N9tgtC9N9dU.p6QIYhlkkkXtoyTgU.Xp7yOLjWmDY64.gXMUjoM_CQ1bZ.fJvnPEqqvm9eaOzvd1
 qdKQgS7vMdQl68iGS1FTomqm0HOruNx5_peLj0URlcAc01BLe_32p62moOEwqXd_.cJJvc2.6j4R
 xUIM2vyvs5zfTpPpVhtf6iTYIEWTPvttZ1DeRQgj4nkIdG77VQid_reKbBRtNNe8ekp.c8UQDq4F
 Lk6c5X3IWNeFvnScAnd6nmsW4Ay4mWZjJhoa8Je4_ZYSg8inCBYN9XZ2osNP.qXljvk.zxc6yzXO
 .oY3pjDCiHq9S2ETpl.YTBdktFlamVULWb2taJuQ.qdkOxQRQA55Tiq0HZrwLogm8g4X0pVlNlEY
 5JCuZuNXht9eVBkPCl5vo4qn3VbVX0xVdjYgFTQuJAnMsqAH096L6yb5k0a6hwS9aoypYmyfDJmD
 rQQQiaV784yc.TomX0.2Rp_Svo1l5jNjaGCCJBGTDuSkY8JW8Y38vE0kx6tY2G558_wTK9PYKDcj
 imyFhyFT.77LSFMN7K3Hax_5Y5pxZASu0kkF_RDoi2IOaMBLK3s7Gr8z6beUdivBmiTTljbPKfBD
 J9cXv0FJzx25deUFrZefS58eGjR5x0df4gMNTeMTmH9IvxjS4_Q6_jdG_IR034yXuDCOM8BIR8VX
 whBic3Y9Mv5mh7w0D1s.mfCvHJECv37rqehdPYu5cv5gBbqT7l9dGPWu7ylufy1WyH8G_JQXlrL0
 YyQFNjPBzoFz5otLnxxoQAEVYsdsuZLJbyJ7B7qDaJD._mUmHctJ5nGTKb_gQlDCoFBVfLOQY4JJ
 hkZWvibPZS5DxBVqE88CXqgrXBYM1aGsnsf0NUjcHm9d.vZFBVDLbbeQxNQpqENcqa_CNFZVKOsK
 zeAIslkFZvi6T_SC8DqptS6J88qQSYSVDn4A9ILTu1Wyf404tMLHQTwukG633_U2IvN6Wy.A9v9K
 ryg3o4XLlnf9MS.QIqQzBv13pmp6sLEoDAeycSD9SDouwNMENdHQbcYv7zOKDKwqgbg.xOreEHQ8
 2O5.wMUTeP4EKEZWWqM5buwX5jfWQGVUsAWMKMI6NxNLIMtWge5erUF3VWOD_ps0WCWCKU9Cu1hK
 HHDCOehieXt20SF0cPqSjYD796kcYoINTXLNiQsIAMmo4HInpdAWG4BTbxwk29c5jJRGolytm65i
 Yvr5C5RSEQqSq08gqy2AW8RMiV4bzBv3EwjqDPqVrMWiFaMx.FYPiVkCBbkeF2fd6taM8rNamJZT
 r8pEY1AHkmVckP.tfTJAgaWmXUfmo.H9Hp_rM_h5.r0cNQF9MFmFBwtlw8JsI21pCmnnDlvLGMRW
 v4MVLM5IxaAnIlzXzWdEu.2czfALAbmjgbj8Jne2YSv9Mwp_jol4ARz4o9fknz7_hp6m0H3XWFGy
 wc8462dqpLw6yXKtHKCWrhfisfZYBdEIUBzJ5TaudNE3u3Ml8UusfPoIwbnRWekGjqviwwarysah
 Bp8VrpA6BXuHUq4e7OzdNiYiP2xsYIsTb6sGsuC43AGX3_zKnU6EBwGAkJ.L0hM1P5Nuf0gKKk_a
 TWEA7WN7USN0zk93woWBjUUULsYnhCwghwZSxHYsSUJfBO9q_FchjDwCyhyk3Kky9XoMFSxFvlgb
 uLruAlfbV3Ptc0o4-
X-Sonic-MF: <gofronm@yahoo.com>
X-Sonic-ID: 4ad6f98d-4492-4374-8462-a113af8df1d4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic321.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2024 04:01:22 +0000
Date: Fri, 21 Jun 2024 03:51:11 +0000 (UTC)
From: Michael Gofron <gofronm@yahoo.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <968676664.8436621.1718941871973@mail.yahoo.com>
Subject: Git bisect skip
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <968676664.8436621.1718941871973.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.22407 YMailNorrin

Hello,

My question is can using `git bisect skip` cause a bisect to be indetermina=
te and/or fail if the commits that are skipped couldn't have caused the iss=
ue?=C2=A0

Consider if my commits are like this:

1P - 2P - 3B - 4P - 5P - 6B - 7B - 8F - 9F.=C2=A0
P for "Pass", B for "Broken", and F for "Fail".=C2=A0
Broken commits are commits that we can't create a build for but wouldn't ca=
use the issue.
Failing commits are failing because of a bug.=C2=A0

In this case, 8F caused the bug.
If you tell git bisect that 1P is good and 9F is bad, bisect picks a commit=
 between the known newest Good commit (1P) and the known oldest Bad commit =
(9F).

1P -- 2P - 3B - 4P - 5P - 6B - 7B - 8F - 9F
G=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 B
=C2=A0 =C2=A0 =C2=A0 <------------------------------>
Perhaps 4P. That builds and passes, so it marks that as Good.

If it then goes to 6B which is a Broken commit and we do `git bisect skip` =
what happens next? It seems from the code it uses a psuedo random number ge=
nerator with bias to determine the next commit. Would it ever get in a stat=
e where it can't determine the commit that caused the issue even if these b=
roken commits would never cause an issue?=C2=A0

-Thank you
Michael Gofron
