Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157A4165F1A
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751801356; cv=none; b=XCclQ9HOEk2+ocHbIdmctUvhOrx7Z/elgjUCqn9b7H8F2055NWBjDwunDc8gu5CjXkqS7yJyi2LbQIQl4kl+QEOfNjwet4KgEmvPd35p93ZyheNw0rit3mMDHo0VS7eP7bxCXTQvQSfVp34VHYLtyEHiCPTCkz2YPkIDoKehoDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751801356; c=relaxed/simple;
	bh=qw8OGqAAXssI6K12uTSXkV4V2c7SMXNbsUA3s5bMyks=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nnRd0sABdsR/P0c89ssink8MiqGYRGuE1FhGNPDLo9VBPsDjY81CHy8qpWaLi2GRCP5Ct8mqnEuKiqiOsigaFNAiKsMbcAolcSrtbtXOCOSmCvL0d4kK5QFVDamp2ldiQDQOxVnA3trwc6BJQL+3fYGgkhHmb550CFaC+/d2CgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=a6p6R68s; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="a6p6R68s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751801345; x=1752406145; i=markus.elfring@web.de;
	bh=qw8OGqAAXssI6K12uTSXkV4V2c7SMXNbsUA3s5bMyks=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a6p6R68sYQ2LplU3Qo1hHeVmywNJjksFHQvusPyZK9kT7z/OLFkKGNbslraajPP0
	 6f/k7Dcy1LC5QYkiMHVDr5zvtyiHQvgBgt2bJKJ4HhnR/ooGr1RS/VUOy86ldcT/W
	 AwFTX91vsTrkAd2/d5VNzvsY0nBGlyeDR8Mp9FcP8X9e9YXfar1mOT3xhbfmSZost
	 dnyu+yhKaBeIpoUIbBvhwfd6MWWnHDTkA3627HD75Mwz55sprZUxMWWVywqeUbo9n
	 torqXs/hoMrRBqlju6kIFYXUeeAmw3JrX7Bc6jgTjvQJMc+mcvLqmD4pXD+mxzraf
	 e3+4ohp3r/GO8puSZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFauo-1uSKcw48gI-000Qq5 for
 <git@vger.kernel.org>; Sun, 06 Jul 2025 13:29:05 +0200
Message-ID: <fb74577d-f7b8-4fde-ab5a-5283e70b8258@web.de>
Date: Sun, 6 Jul 2025 13:28:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?Q?How_to_restrict_command_=E2=80=9Cgit_grep=E2=80=9D_to_the?=
 =?UTF-8?Q?_first_search_result_per_file=3F?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E+UmSf40m0dnXoHuyLcoJjtUOTDBltKvG0g8iGHgdV90WOv6NuG
 HjZMXUUNXX0hZpEoPmta9NXp9eSk0aTXi0gyC0n6CoVaLwvQBbepqY6Iqr7+NfKaRbvmt3O
 2Co4Bmgj03bjaPHsLPAdew427xRnaTK0498Sck7lbXXPtQhsT9eojVgnt0JTdvEa4DQKpCj
 nHdAu1pvFPm009QRAAV4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SalrIe68UQk=;iVsDclbShA7ButiIZRNOFmEBdDn
 SVlLNUOkSk9/gQXkPOFxAsJH0mZeUQmV+yLe7Pmirh1KcSYMVYMAbCCmXDYdfSNWCTxvaFC79
 Bh4A3uomutSvOpnboqJiHK5PzMUJDBeU5Sv5F/+ZS4U+tbAGGD7eKM6nDYlY10AHB9w6+fqJI
 XLWkDnyNo1li+v0LwXWaSUpxQCcCtbQxS0IlF3GvyjwXg6Gq0S5mEn7dkWFOdLHeCgB+H6GGj
 aqTfPeBSC2SkMPS2fZgZ6nFd1wLW19u8jm10DS1RXFarx8h8BiwaOLxVC8b4RcZtBXaccNHbY
 XMfwA8puzRrgDFdCDB/af1frwCuIiZfODmxNDVdlX8l8ZXI7he1C6FKBVicRmlH9NQikMB2bg
 KE/Cd90i/cSIf67HYbPTCycG00QwI925f+P/sp5eE1X0+PziQECDjODfCJEvc1GXl0odCYLGr
 wP8PNTf2VMGAhzR6BGQQo5/w6tuNiyeCAKvAB6RGWM7OaGYod8d9EfRpK+igNGbMMoSjo+njK
 deSxueloTCHhQcowuunjhdG3cERwY2Qpx8chzKkkbe9hy4U2Zn4/F1YzgiQpdwM1JXC2DZ83l
 Wlb2XP0vf2IoYubz4dTjuQREwXlx4kAkDpnvVfTKjuypBnnAMBG66AkTF9kKnPO3bNRoVr9FL
 3jTNLvOGLTQnbAY7JfkVwiWOlBc97j3DQWIR3rERDMqjw7xk7jpfCaMfWaDHlXyYOnM8zmp2o
 31vbk1s10z5QVhFeCCuuwAKRe6TN/h67LC7QtSPfcb/3INVoPC7t6Qw+/r8EhBYxxaD9DXXgt
 dpw43gGz7A+D8Hq/d2HilX6+2d8VCiJ7HQxVE+SAW9ZUVRgDm4MGQImWeYdsTVzcrzDLH46ev
 vPU3CEyLYzFrRQbXLdugIjCTM4hBp4jNQJTCkJGnrXYbFkP77Yp6epao6x3W5A622dAsTEWrV
 lN3WAhyv6fk0EDkt2x3PCoBGkr/32rDY54AG097KHq6Xcsi8U/W4Qa95u6jPWHWOe93r+eFvz
 brLhqS+juVyIvznOxnXi4+7H6d2S4pmPBl6dvPzNr5AnBQgDQafoa4Ulj3dr7wR5XgQbBICh9
 C9RhadEMRUuuq6lqty8CRUuwgo5PURu132t4fnsmeZGl0jhirao16o5IG8nP0Jk+UlI3gNJ21
 ck7+qHvMHXfRsF9PaMe8Usc97ZojU+Y20tp+/RiVODghkaI9AOpl6g9rgOp298JypsQy3igg/
 VeuRYsXjA9WW7NqdLL1Ll0npwKz+qVcBE2V07RxSn1akteKiihbmkxv6jO6onu6r9YSIu46iC
 /wwKk5yR9ybJ4xJOQwY/D2NWFz28XB14Y9DYMCWh38so8yEwn/9Fpi/OBaUSmC3Emg+ar2VbF
 uIuVDloCB7fcTlAs3VrYub8/EUzyWTG9wQvGz6Jr74CnQTfc/dZrSWbpzefxEMNUUH3SXw52Y
 arU5yrffVf/JeLVhCsv9hWfVr6R8JbYWw7bb5Xtmnmf1OH2m6hR73cr44lQ7b3MGyg32DzY/y
 SOCqOkLFe9IIN6KrYLGJk5f1+rbLuvo6a6mK0zE8vTVMTtsV3ATa4PdH7EnJwEdscofTfzZ05
 HBCMELAUDIu+E4jP5G9BMxRM/Ifx8xTuWkxSBObFGQ1VtSjs4YOoVu50auBnTkfuQuR8wY1pS
 r6bdjblCyj+UvgnIrXbALS+8MPOIDLzYCOAs7FtGO/sQAucrcdwRTts5ftp3F/5cwpeHj5l9d
 51cbBG8vmBr/28PXBcbo6/jdb609gfGdDnCruBrU9uKfW6NgyOQvz5Ne3q0tr08gThSxYt3my
 eb/e45dttLknT6iCmS3uDqJPZ+TmZPpyY4W1bCT4pMPh2eOvy4/GkwSOym4u2jKRTvv5QMnmI
 vFIlqRG6VBQWBrWQhnc3oi9Y0W2cqkncD3OSU77HGoFTQ1tYxey00CDPBUA5ZazVpnyMxD04E
 8RD42KTQ9drAJGnjSIVsH6y0SGABmoBcgk2iYhuc1LyoUwcHfU9B6R0fSzjlwIsmkGLw8ykta
 OqDFNkO3qi+4b6DOyWciBnMdlOjs0iMcKLaFsFSmAkca0+CgVi/lEcywqQafN7zY1k9LAQMyy
 JOv+7P69le6IGBaImtuI0+/++h+2hIaRsjoTJJmClm+YaGAUHOxnbht9i8yOEuMJYMtzxmKDL
 XQgN5cjRSoyGa+tgcBrkd2XPVPxMi0ysNvAOtqywdbkORZWPc6THNHC2LkeU962LvMPA9EjKi
 GxFDhBfKk/EfS1CiPaX+NlFFuOSYRjT30ASXi3zKDcX+23EFBEmI3ff/yyGam+DGtl8qf/OAM
 ntus82q2+WLX+fa0cyamMXRA1D4KL0a31DPmtSC8CiDoQy1vGKBQOJjSxJdo0aCZrMhIdCziV
 a8h3iY9JB3PFVaizmmZyPHVH5E2w4Hqgn1455V1alI3Oe8CnotKm5s2mMU2p1DBysLKjAhO+U
 j37Xaj8DCSfWXiu7x8x1HIQutwSstdPmwouf+ALTuVksYdLANyA37REpGZIYNGc18FvFZU/HH
 IY2OsbxBzQnrVdN0O8D17WmDB5ZmZbc/K6Orh2hvRo9W3FtrtDirN8eA4lyA+P6kAedos9wCQ
 B3NskwLUWcM/Nw/nAhsAeaROnrrDENzMylHmXAUiQEh7pOn57Sw+SMwEFocK7ZFssFQ30iXP0
 No8xILbT9CxXiPbqNpVV6XHGUjXlgCD5vNWfSmBoVY/mDdC+LwN6+AHF72PIKPd5/Q/b+NbCB
 gQ5VG6nRxE/UK2B8/wOSmzoNZUmNZIlWvxIpg2+1RmTV34qhLoxalGFNLWPGaiwnWYAxhq3Nk
 0KuuayC5W2eE9WPFTSfKLMjVpLeEzZIxxFVRzTptBxLEGHXo5lyykSUvvDZ+8ZFtVGl7pnL4f
 V0JEmxpmwm+r6CAQG6XBPf+D+pbqO8xVKuyUTB2Biz4IMFYk4ltoWmuOGIv4pN9MPjI6ZWXd9
 YDZBKjjGHeP5V3Mudhmiyq4mAwbbvFvoO1J8FrZM07nXFIoXlveNi3XIXbvI3n+pSGRvw77MH
 SPr4F0FMK0RdbSMmBBtjOtITTLGuhu/oiKLhA6l4OdPI74KH3dvmkkOLIaNabUMDkzCJJgSWl
 wLI2l6CzWVmKCqK41TB9u4jWWBISvXBT+T3LsCBeMxkF5BWtazxtEd0NoniBgnpk+LGL8RLZu
 vkvV9ZDEMIfpReBn838pbCndHqol7gb+40yn6BcdJvXhgMnSc8icYVO8dAhjHPkDGW1lx193F
 FCo7plZesl36+7Ps5N1unHvOo7RMC9AIWw3AvTSyLlZlFFzzyCE+3i49U9QelUF97Du0+huqc
 TMbnBWtyP1JBWCpAzoRi6OVM4PWBc5lFZirzH15gbEznMGh3/6OzAvyvApbPqXltgXslGjisL
 Sw7mQxplDJRGoEhijupLv8Yjb1y+rtLJFRQRmnHz2xlCTEX5GQtfS396aKwFKPCbqYAMzUqnx
 luA53/axVHozVUx/czVK4J7ybA5d1wVA=

Hello,

File contents can be searched also by the means of the program call =E2=80=
=9Cgit grep=E2=80=9D.
Would you become interested to find specified items only once in each file
(instead of multiple times)?

Regards,
Markus
