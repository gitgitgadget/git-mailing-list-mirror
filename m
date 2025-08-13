Received: from sonic304-24.consmr.mail.gq1.yahoo.com (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648DC2C15A7
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110082; cv=none; b=LToAdVNeo57Ea1LhmEEyvn7zuG3pSjGlGIgipXw5/pFqtyaS3mlWQ9LsSFRekdtkFFVKDvfI/wb0f18qwwaEQl6VM6Hh7J/iupDYCX4vxP9jwJOiLIhmyjfIl6Zu4Pp6akSPgjC94KSOis3CjArqGohU8hEE+B2gaimo8RlckWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110082; c=relaxed/simple;
	bh=Wq0EePSMT55uzWlo3FzO6VTUgQxIC6ZAMlUvpleigKM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=k6n4UNWUrUUR5gYv3ZqFzh2nASewnAHqoLCh34j1fFktmCLXfdE5LBeQ03N8gaAWcv4SUsao/msiqPj3oW7nz8X4P9X1AKfW/Z7l+NcEIfjjkI4HHaZIM+i86cwJxmO+qoPQJgpdDxjt+PdpmCHIz8wE9R2PJDjq+O3l5SBlOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YOjcH1EL; arc=none smtp.client-ip=98.137.68.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YOjcH1EL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755110074; bh=Wq0EePSMT55uzWlo3FzO6VTUgQxIC6ZAMlUvpleigKM=; h=From:To:Subject:Date:References:From:Subject:Reply-To; b=YOjcH1ELjxUGccL84EZJOwn8LuGmcNlHGMBr2PYu4wzBC+KMy9SSOe7bxUuu4FUL7OmVUZvP1vBE8MsfK61nPFcdu3zkpjmTvuLudjx5IHWPZJq5BiuTa0L7W5ugeluzvs1eI8g/aqqowDQnHWCGu0kuRqiB/dEhxEw92Z+5CLorszDr59EWeC+29ZIMmaSXSxA1crUArtno3q7b+/QSd0TQyH5aOimGtM9howeXxmWdcIVPgvgl4dKYeMC1BtDOdNd8yIl+IlSLipsUBNhQJAvkjPWvqDYa1eVLqR9ESZS4bc4n8Pb+XPyvMYjdMHLkeYbrlaS9PbIMM3drSOBgEQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755110074; bh=hwlhyHnghnRp/4TPR5yXTW1TJJej3XtDoLb1GxPmPyK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QtwSDDSxvgccVJbsThvPLacipfEWrFx0g78tP4qSsft1Iu6XufMxFFWsZB0e1DIkzK8U9IrHT5nwiQrZTsqz3FBKWezOuhwgP8YkwOEVAjd1o8sDZwwdPkOgdQlTmkW03ABlKjfWiSpgm9yOuV3+B7oLMX6Xn6R5Fb0Sg3YdBhT22jL4/SI91EwoNRDd+t1y6yGMxMyLGke/WSn0KhdY5GmCh5bz/nQYKJguQa5mtZI5Z8CXnFp1cE7oEi7ewVTrMVVdqjXU1ElyQhpVK2Bv1W99E8IPeTH380CRE6n6BvmcjmzkjCBWI3fxxm3EPoXjZwTaeuPp+0PbIew9w+rZfQ==
X-YMail-OSG: 7UhLa1kVM1kFAHdYgWJS4OQGHiy4361O27heW5_lzM3sTgW0gqM5NF5tGDn5Omz
 ap4kEML80oAMkMII4cu5nWxYZTP.NEaWfQEAMDg0paSQpW1el.4F4KAeXZJOMzmEUE2ePh5bmHXi
 PmRNBCId6ApMcQtywq_ZpeuYVDeIyr6dEhWyJ3RAhJ1v9_4lJZM9EGltUECBFvdse.X6NOwlNkwq
 6.kDkI7T6CgNj3XDIWQ0pI31.C5brKcq_IzRufE6qLGJ5g2mkbOMbkS.7R1y.aC2HfhUwVIYXqUd
 xSkbEo62JGabY0zUUaI8PjD0V3FJZKXyKsv9PeDXwYAzXGd_0c4f_65ma.YCLFiCbAmptXPK8N8k
 h37FCXiHzvrDNu0eFpqj1s7TH2Nd5BBXVPt32Hk.kaaWm_56Bq6Fao7aLE.EQ_ZD0Mbhd8V6D_8C
 l8sRQ.9E5Zh5xx6XrZWpWN2L781bykyQOZqOLtAxngy_aX6TkhVpkXOhkTD90L1reSXRpskIUEFR
 0lvPEcSVnYwNwITCCitfywBHZpVoXghzRFEKxEw6QCbIm.gWQLPbvK3aKU26sLfGyhxNAb8BmsZb
 8S67spyy2..N5vhJapnaFAZgM9NUXiAWiq.IcQxEAB4tK0905KzSByNVZw0NWKV.Uw8IEB9FWXLC
 pTrGAo.WB_hXmG7rHDGM_KdRbnx0csdZookSPDQAu2JDB0GGEb3B9WU2.mQdDIAxC.VVhr1LJwDq
 LehXmhbin4JWTOh89kdIkTEybW3yRunOk9KJ5O.OA4mWw5Hw4VR33EVbeu0_UlLmW1oPN1SVt.RO
 fZt0DDH8NfLVec1a7O9fl6b9KxN6KyIyjHZ5Zibtj6sIWgEBdwHeC7PrNN4.b0H0f051RZtELcQv
 okeZGj2nEd3Jt4qR5O9Xr69_zWPC1zVJNoPFgOEf_r1yrhmlmTyC9Qj2zkqe.jD4oeMgczp_cObj
 b8fLINGeYknHMCEPzxYzhG98xItKlu_b3WGMgY_c9KSmg8mowrhSqq8vNRdYwRYW10M5QdQtf2XU
 WF7_7rw_vXOPValqT5FgV1G937F1D1P7OMVfGQCAszCeJRAwrCHlgbbX0TVDs2RY_DlviNqoB_SW
 5ymYydfjZqx4camjxMYrRMHK36774JGoMt7vFIGZXzmlsd1RFYnpBGwr7mGg.t39yXXIFsxbG0uv
 4KBTqojOe8qyUM4DAe4sX1oEt3rpSYVZFWKI1VOLYF1qbF2g9xyePqcK6FIpR4ogISZiR3WV2q.u
 u8YIfaN_6ob6t5DiQMId6xt.LsjGOH80DOMP_h0YqCqADI5PyxZmPVDYe_XOE9d1r9zyVcKSRr87
 gjF7P5MmED17RUV1FqNiykG5HkDO.OKHQvFBhjStXS4e2ypgeTBbLiQpBZjb9G03HRVgSj5j7xPw
 R81mjIJiwdVGhvUugHXX84BSSOx1Z4N_6vRiR5mepSJ6v3gv1_YYKoGJWi7jF2NgGpvFz.GDxlby
 TUZB8LLvpg_P0mY_e6vvCXeVIOPRqumi7zrZ01UDKvpAe.vvuFAVnvwQrLC8XLDX2E.dd8BfFDQ0
 TOEZoXfCCrKD94lvfjc.rYPh04d5JPXrnhYfsHLUb.WnhucQhW3ZjCdVypcWU.0DGAoJiENg0xVP
 BvafXRKYo7ctxkfVqUz1ycVlTR.Zc24HFdTqUN0QWWxUrGEQqmPIMQeA.EiUilybD67GawZLqvSC
 h.EOmuj7.I5VVh8AHSwk_nsmdJe8o5LB3F2Uk0P4buphe7piFSOhwj9hftbDfOs4LyxSLNBsn0b3
 GXeT0YY1GREHQ.pFFEnOm.P5BEACgEVQF5HuzdrOTqe1t.OXAI.APZNL_ccTnZleqqeyMRKPlzsn
 YX7rzlHPcDR6_3k02Bxfgr4AElK2wp1VB456zFll1Pg1d12wINUjU4s0EESE2C_YhrQDyto7I9WE
 6eoonlto4f5yxh12YT5VD8E0x.cRbfYtUUlzoehM1SFxk79eyD8WtcHTR74p12W7UTigdZ.SztZZ
 i9LCbe2gc2Z1g.m3qzhgsUC.12MG9G7P7AEOwUJQrby4WGOs1lFHGb.86_ZcJQCzOFjXL1FW9_if
 Ojvxh19TT7qMte4ZGjGZENIZGW3zYPrh3fGAHPheiiTIHPS3uxfi0fkKdPm1l2AFE_efoen97R3V
 JiJP7IOPpbESgosks4AJcB47a4pUkbXzIHztJwpHUoGhNNwVLveXN5B9ax4fkYOFtPvsk5lWlMxw
 yvtv_mvKK4RGju7iTXyP.cuLVdmoofKDt4xBMukG9xcD82gX_q_S.FYl3qaj0ePPe7VevF.kH8BB
 cNVCOSSdWxkqGFmLKzXfoMPHdl.je
X-Sonic-MF: <ken.englander@yahoo.com>
X-Sonic-ID: 9eb1802a-da9f-401d-9364-e65b8d49b718
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Wed, 13 Aug 2025 18:34:34 +0000
Received: by hermes--production-gq1-74d64bb7d7-f4j4n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a3b183b2cffc08fdae33be602849a51c;
          Wed, 13 Aug 2025 18:04:12 +0000 (UTC)
From: Ken Englander <ken.englander@yahoo.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: installation comment
Thread-Topic: installation comment
Thread-Index: AQHcDHyhBWcfDR+gzUqPmkYdDA/m9A==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Wed, 13 Aug 2025 18:04:10 +0000
Message-ID: <SA0PR19MB43679ADC65CCBE9DB385FFE8AC2AA@SA0PR19MB4367.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SA0PR19MB43679ADC65CCBE9DB385FFE8AC2AA.ref@SA0PR19MB4367.namprd19.prod.outlook.com>
X-Mailer: WebService/1.1.24338 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi,=0A=
=0A=
I just wanted to offer a suggestion related to the installation procedure. =
I am a new user, so I do not really have any idea how to answer the questio=
ns I was asked when installing Git (for Windows). I made my best guess base=
d on the descriptive text provided, but not sure that was very clear in som=
e of the questions.=0A=
=0A=
So, I would like to suggest you provide a default installation (or a couple=
) based on a more limited set of questions. I am going to guess that these =
options can be changed after Git is installed.=0A=
=0A=
Right now, I only installed it so I can manage all the older copies of my s=
ource code which I have been working on. It is a single program "project" o=
f about 600 lines. I just want to make sure I do not accumulate too many pr=
ior versions since I will not need them right now.=0A=
=0A=
Thanks for listening! I appreciate that there is a free tool to handle vers=
ion control and whatever else it provides!=0A=
=0A=
Ken Englander=
