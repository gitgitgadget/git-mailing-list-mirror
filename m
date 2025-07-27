Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013077.outbound.protection.outlook.com [52.103.46.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7442A82
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753585492; cv=fail; b=m4JXZ8HMLXUQLNt5D3BbsBz73SF03kw/LSHqgGTZGb26U/nD1KZF3Os2trvFrvoqmVyJSsVQLCAOTqxS27i7/r0x6s/Z/r+0PKrn9ymwKDOvBoCbXJcfNsSuz06wIrvt86ANlTMsh+EqBz5TXC6trHlRpr84JvvynIL64Tg/usM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753585492; c=relaxed/simple;
	bh=ZW7GionnoBMbR810wFCHTwRwOVz0xOvdVKgB3g8Yi+0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=duEOgmGl6Pcg2YoEdzxJQGlKwtm6rLyLLrS9jvNDKFaABOHjpq3JPTrnBfLCJmx95vyYd+whVl2xCfxKZIrfgDMR4C5HUYZxmQ0z1IcfD3hLbbHzxesddvrXTMy/8c4HE2oEcYus1IG0RhlbU0pOifI80gxQrAn9xMHojcWfOPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=rTAhjtvv; arc=fail smtp.client-ip=52.103.46.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="rTAhjtvv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmHHC4c+Hs3YAKDW77a8bve6Rm1GtcC1j8Kc2Hiw48cIiNtayxUsFGroUw1Tm1GIYrVzmpso+xJSRJQIaEDcoGvoESjOinRUMlnkcd9hr9udaTFbFVPLy4oaDTVWQU0hNjYY7yeOZAytmcDkCTKxUVjd2uJEIi3x3mBAziLcfRA4XxjqJGfd7x1U6/adtviHJEd3dXOuL5NiFkaI6F+WA6M9llmQEq675t+kZrts3InOoVc/I+P37vCIcOs3yrLLwt1Ej6wbZW1XKQaVmIVsB2uFxZyNsnI60knIsKRjFjWCRj2vN3+tbdQScdQnErp5hM5X/eI7Sx/4Kny1ub0gUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHWgFay8iJKKOfiC04W/QJFlbqqOBkveizJb8CbKNKg=;
 b=vvuGs2FvGG1o6ZTBQ4G7DIR9eTJy7fG61UyCPFkHio6DGpFzJ49yO7gI4ox8YCHNitV77AwuGw/ELvAD6dwO1SAcR/vQzq866KfYh/XShje/zXm+pLrplrSlTwcL8hG6I1dYjGhKlb2mO8yNvzBlMnqyx/u6sg5ahYY+OwM/CqbCjfOIAjY1SbujHaeKk+VGryhOzyyYnP0poxbfJ2Qxr7cJ/kJHVGMS75JDFPvppWaBl5OiMclCGxKkRvqVZ6bAxCf06CxPO0RmG3GL2/sVH0YRJntUFTPJXcTJf6oX13O3SSA6KkcuK2ONUPlYja0yMiMrDVyEiCwRGSpfnLzGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHWgFay8iJKKOfiC04W/QJFlbqqOBkveizJb8CbKNKg=;
 b=rTAhjtvvLLKgr38TgXFV4jjynYDaXgxhcW8GoDf/YiqtRoD8On4Dwr1Trty54U0zqx7qKdDL4pW50BuYKCaIacmBYTNZfaoc1vyZjGR8+rmdQrdDQRd+UaxFTpJjOMVTdn3fwTOAsoyPTa+k3dfk2cHCqY8HzP4Hi7s34miU84rW2pABCxjlE4dILyTHGnWy2nW6ysayWPKb/l+ZIBkbp4OV8tJ4FeqNdlzGKYbqsvI9Loxzdf6tt0WmEmK40PUILEp7A7dkLiSw4mp/CDWwmtASdlTGvnUdi9Xzea4PF3QFJluO2H5WRgD/OquiC04E4N6wOA6xeYObLfy2fxdjXw==
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com (2603:10a6:10:43::19)
 by PA1PPFF8F25ABB9.eurprd02.prod.outlook.com (2603:10a6:108:1::265) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Sun, 27 Jul
 2025 03:04:45 +0000
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf]) by DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf%6]) with mapi id 15.20.8880.029; Sun, 27 Jul 2025
 03:04:45 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] Proposed Git Workflow for Permanent History, Explicit
 Branch Status, and Developer Continuity
Thread-Topic: [RFC] Proposed Git Workflow for Permanent History, Explicit
 Branch Status, and Developer Continuity
Thread-Index: AQHb/ZTl8dId++xSS0i6YSC3HkqUyLRDMWgSgAAGKoaAAAux2IAABnQPgAH9S6Y=
Date: Sun, 27 Jul 2025 03:04:45 +0000
Message-ID:
 <DB7PR02MB4265527016FB04A500FBE321B35BA@DB7PR02MB4265.eurprd02.prod.outlook.com>
References:
 <DB7PR02MB4265BF28A39C7BD3DB097E1CB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265499C1103242CB482B407B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265CDBD131FB755B0799B2FB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB42655790BB6E1EF589B7D173B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265DDA928244F526CF1EF4AB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
In-Reply-To:
 <DB7PR02MB4265DDA928244F526CF1EF4AB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR02MB4265:EE_|PA1PPFF8F25ABB9:EE_
x-ms-office365-filtering-correlation-id: 127f2b86-bb33-4f90-aae8-08ddccba5747
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|8060799015|15030799006|15080799012|19110799012|8062599012|13041999003|440099028|40105399003|3412199025|12091999003|26104999006|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rAj9nqGHtyJEFz4iFUy3b+nVhjy3ojTcWVrL4DtcsKpzKPzImVp/gbkV5R?=
 =?iso-8859-1?Q?0CQkM92c/aKXGPrX0gsC7HQuurpBiKxE+90g+zef9TP437wcfBwCxXARZn?=
 =?iso-8859-1?Q?4zu0sy9rDKqUHMkNpN6oJgKGjDSoQCcr8l0GH8vt9UfKmE7FH93tQL1/R3?=
 =?iso-8859-1?Q?S6OiWBXI9ftNz2gIyfyVBAsmwhyA5OLXLGSl8gHOo3GzUrl/b8dTLnoQjX?=
 =?iso-8859-1?Q?T98vDvbuN+xkUEpdNQ31rAa0RFnt4htf4i1SFxASZX0107fC0VOlotohUo?=
 =?iso-8859-1?Q?NOJKj1VujygQE85Js6VAGY/657fGJ5h0JEYB5k0zzQOEKSdSVj33pNUe/T?=
 =?iso-8859-1?Q?FsJ4jrlzm7FN8l5Smga0akWexOz6uW1T9QIJAz7993mU2bfVKyqbahPpAc?=
 =?iso-8859-1?Q?b2oIZh2pMgpkiU3QU2jINZBwY+K2qy131Uek9bvBFQ+Fv87ZRgPCEJPCxW?=
 =?iso-8859-1?Q?2+9xuCX3Dca3MGPvEDj6E9mXgvGuCPyHxmA7l+z5t1d1Sd2ozO/V6NtWID?=
 =?iso-8859-1?Q?prcPFN+WkSSp7vAxAu/GDoojy8XwVPWHmVeacy4Xx251vucHJdUZmNC/7x?=
 =?iso-8859-1?Q?rm0ZK3alxeJ+CHuQRs56rdK8XZTp82wRc5mMyV6pnYXUd5kx8Ra/4wMa4F?=
 =?iso-8859-1?Q?Qmx94FIp84e+fjZcTzVSwGM6Sh/Bb0VQlln1NJZ0mZ2CprRVFYdqTcVP2f?=
 =?iso-8859-1?Q?hAITXbS8jMh2TEvpVXfo3QKBn99hR18pTcrkApPkBX0JByH3m29xZvjdRW?=
 =?iso-8859-1?Q?d/E9BJ7L/dusR+AJrOMD7LCX9H7vIzwK8dO+YYA3SynEtSi5D8dwQLijWd?=
 =?iso-8859-1?Q?n7leAc0ZbIijru9/6vtt2umPcXYIg5xvRw5gENTMyg0vq8eNldYGlshSoo?=
 =?iso-8859-1?Q?3c3EQ+Ud+cPteS7WIASwmLtbmmPoKbT03UHyGbkPAzt0LWMrVk7nxIUXYQ?=
 =?iso-8859-1?Q?2wSyUBF3lScDfWlffN4hkkaPmllD1BenT93o82UxxKHlRLtoK4NW1CgoVu?=
 =?iso-8859-1?Q?WsFKLLzErtb/6tvVeVTBtnejacf/+n38k85Nko411ZwADuEcrjZa3CqDd1?=
 =?iso-8859-1?Q?YwADGu2yKJQnNS8kHF7DDAoplEcnLkC/FZeOCxHvPkKYt5JlmZOW7W11lW?=
 =?iso-8859-1?Q?YGyGrhXdvTArEDrZiKZ7pBm9i3ToxNbMkxiGNe6FSp8TOpM7laZzB/S2xS?=
 =?iso-8859-1?Q?PekDUSDP8tjkuPGg2908i60PB+/QhbiX1yt/ekKGOrnvQEvH4EK0mL+TQw?=
 =?iso-8859-1?Q?m9RJQWziF/b0o1NsyZGwYZDZghNzZ8sd62hTGEpHPMzC3UQ9ePGdqvH6tI?=
 =?iso-8859-1?Q?O5VkzGtWWz8wTS1pAt7Z98qygw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HAC6jBFvEShWff0QJ53YGTyseyZ+ncWQ0B2jW1aDdp/njrhh3/dogpXLQ2?=
 =?iso-8859-1?Q?yBfb+mNePBwzhqsvA8NGEfBluZDf+B6yy7paHZKFm7LeYagqxbQJ+inD9W?=
 =?iso-8859-1?Q?bJfoECYVm6Xmhqoq4GCu1s1yfGZH0R0sdUzmYgmzIHMmb5YHJ73pi95nY3?=
 =?iso-8859-1?Q?7Pqf+PQGzSEYYgMUrpS06cKZMSDuUFu09DemsvFC5wFFoCAcIPiVB3Dmkq?=
 =?iso-8859-1?Q?S4n5FIWnlgonPsV/vwZ+C4fOTZELyjZjfRVvtF/wB9tW5wDC8sGdAv/nnZ?=
 =?iso-8859-1?Q?ZF2rojKScjsOYHbRteY0QO9vWoizprwP4FrW7GgD61IwcmgqL5LvEWOmlW?=
 =?iso-8859-1?Q?WVhXciHoh7DjUyCDFoanoaoTL/Psf4y/mdKQ5rVLpotHzBBdspfoSNkMTO?=
 =?iso-8859-1?Q?FOoPCLCupza4EENxRqr4EQvwfTpcM/tZ9vt8yHpXR7FM1Vwot1ODk5yYyN?=
 =?iso-8859-1?Q?6Wq3fvRAboFiKlRDu0cq2pOTC6gXCppG4PRz2bRRv4nksDC/gEU/ftsqrc?=
 =?iso-8859-1?Q?+Z0vT2XS40XDU8dDn+4WSTNeS8W/7Drid/DsRhyz+PQpx2ADVwtaztHCVp?=
 =?iso-8859-1?Q?z9qFhboUsQoF4EL6bCNaVPfoSeAcyE4Tiperr1ajUVEkqrOkIevrju49r6?=
 =?iso-8859-1?Q?MvStL04L3glpgDrYG7ZBRL2wxXEwK1Ke5F0fzr04xU8E/0KF3M9Y84QGE+?=
 =?iso-8859-1?Q?XpuvmU4ICRrYSEXabKrlG/iPPzILPCMcXr1zTSoOZPBt9Gn7wv+5b/Y4Cr?=
 =?iso-8859-1?Q?rO62ZNj+2rY4QxgJOj3eHJvIAUrjuVhKRhHtHOpznM2ak9sxy5sA9gATR3?=
 =?iso-8859-1?Q?N3VEOrJWSQQ6PEtX4aG9EzzfFaokRNLRUbFeVDqFrOHl+p45e8pu/0GEe3?=
 =?iso-8859-1?Q?XnLJFlZOSY3a/boF4sj/tjiM8+8nskDYOPRPZcMART92BLxo34iBBtIDRv?=
 =?iso-8859-1?Q?GBcv/3x5yMFOO+rZ32RmejfXnGFbySNx77z6D/2njMPf3s8AFPsCjlUcwp?=
 =?iso-8859-1?Q?3yG0VXZm6ebz/c61WJA51tK9cgLMu/L3vBZ+sTTxpXL14GULiQzV8+0o45?=
 =?iso-8859-1?Q?CPplrE4c1gA3BKmBVBJ+D1BIMYUAeNCLIECsoni5QEiU76Yj8NGG2edDti?=
 =?iso-8859-1?Q?OXATFjg8OhLM9UwZMhExvvbtZu7mRem6C7qDpbSO59VR/pXiQzrb1bzzIy?=
 =?iso-8859-1?Q?Doei+9CX0NwxVWaHKfBFYa72DYkC+m1hiXwOWXOtzdPYCwk2tQaL6OSY9V?=
 =?iso-8859-1?Q?KN2Cn5HAZ3vHe166YhW314fnjhSDCxUD09bbNdiYs9U6ASguM7XHoR1c11?=
 =?iso-8859-1?Q?K17nmVpKB5rLXnGF4ozxTtvBJlxwifoKU71B/eKYksj/WaA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB4265.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 127f2b86-bb33-4f90-aae8-08ddccba5747
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2025 03:04:45.6161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPFF8F25ABB9

Good News,=0A=
=0A=
Skybuck's Git Workflow is now a reality:=0A=
=0A=
Gemini 2.5 Pro was capable and able to write the necessary enhancements in =
Delphi 12.3 computer programs.=0A=
=0A=
The source code for these enhancements will be posted below in this message=
.=0A=
=0A=
(Batch files and Powershell script were also briefly tried by Co-Pilot and =
Gemini but proved to difficult to get working, so I didn't bother with it, =
cause it takes too much time to get working right but the AI and pretty qui=
ckly switched to Delphi, which Gemini is either very good at, or Delphi is =
just a cleaner language and/or more powerful, it's quite amazing how fast t=
he AI was capable to complete these implementations programs by using the r=
apid prototyping language knows as Delphi !)=0A=
=0A=
Here are the source codes for the tools.  (The build perfectly, no errors, =
and they were briefly tested by the AI, the coming days I will probably tes=
t them further and will also be used by the AI, they should come in handy..=
.)=0A=
=0A=
Compiling/Building them is very easy:=0A=
=0A=
Simply separate and store the raw text into file names as follows:=0A=
=0A=
git-back-to.dpr=0A=
git-new-contribution.dpr=0A=
git-set-active.dpr=0A=
git-set-merged.dpr=0A=
git-set-rejected.dpr=0A=
git-set-revive.dpr=0A=
git-the-future.dpr=0A=
=0A=
And then build them with either:=0A=
dcc32 <filename.dpr>=0A=
or=0A=
dcc64 <filename.dpr>=0A=
or=0A=
simply load them in the Delphi ide.=0A=
=0A=
So example:=0A=
=0A=
dcc64 git-back-to.dpr=0A=
dcc64 git-new-contribution.dpr=0A=
dcc64 git-set-active.dpr=0A=
dcc64 git-set-merged.dpr=0A=
dcc64 git-set-rejected.dpr=0A=
dcc64 git-set-revive.dpr=0A=
dcc64 git-the-future.dpr=0A=
=0A=
This will produce 7 executables (for/tested on Windows 11 23h2):=0A=
=0A=
git-back-to.exe=0A=
git-new-contribution.exe=0A=
git-set-active.exe=0A=
git-set-merged.exe=0A=
git-set-rejected.exe=0A=
git-set-revive.exe=0A=
git-the-future.exe=0A=
=0A=
Then simply store these somewhere in a folder, setup the path environment v=
ariable to point to them, by adding a new line in windows and injecting the=
 folder into it and click save/apply/ok, etc.=0A=
(git-set-active.exe is more or less an "internal" command, it's sometimes u=
sed by the other exe.)=0A=
=0A=
Here is the source code for each one of them, (each program starts with "pr=
ogram" and ends with "end.")=0A=
=0A=
program git_back_to;=0A=
=0A=
{$APPTYPE CONSOLE}=0A=
=0A=
uses=0A=
  System.SysUtils,=0A=
  System.Classes,=0A=
  System.RegularExpressions,=0A=
  System.IOUtils,=0A=
  Winapi.Windows;=0A=
=0A=
function ExecuteCommand(const Command: string; out Output: TStringList): In=
teger;=0A=
var=0A=
  SA: TSecurityAttributes;=0A=
  SI: TStartupInfo;=0A=
  PI: TProcessInformation;=0A=
  hRead, hWrite: THandle;=0A=
  Buffer: array[0..1023] of AnsiChar;=0A=
  BytesRead: DWord;=0A=
  Cmd: string;=0A=
  FullOutput: AnsiString;=0A=
begin=0A=
  Output :=3D TStringList.Create;=0A=
  Result :=3D -1;=0A=
  FullOutput :=3D '';=0A=
=0A=
  SA.nLength :=3D SizeOf(TSecurityAttributes);=0A=
  SA.bInheritHandle :=3D True;=0A=
  SA.lpSecurityDescriptor :=3D nil;=0A=
=0A=
  if not CreatePipe(hRead, hWrite, @SA, 0) then=0A=
    Exit;=0A=
=0A=
  try=0A=
    FillChar(SI, SizeOf(TStartupInfo), 0);=0A=
    SI.cb :=3D SizeOf(TStartupInfo);=0A=
    SI.dwFlags :=3D STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;=0A=
    SI.hStdInput :=3D GetStdHandle(STD_INPUT_HANDLE);=0A=
    SI.hStdOutput :=3D hWrite;=0A=
    SI.hStdError :=3D hWrite;=0A=
    SI.wShowWindow :=3D SW_HIDE;=0A=
=0A=
    Cmd :=3D 'cmd.exe /C ' + Command;=0A=
    if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, =
PI) then=0A=
    begin=0A=
      Exit;=0A=
    end;=0A=
=0A=
    CloseHandle(hWrite);=0A=
=0A=
    try=0A=
      while True do=0A=
      begin=0A=
        if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) =
or (BytesRead =3D 0) then=0A=
          break;=0A=
        Buffer[BytesRead] :=3D #0;=0A=
        FullOutput :=3D FullOutput + AnsiString(Buffer);=0A=
      end;=0A=
=0A=
      WaitForSingleObject(PI.hProcess, INFINITE);=0A=
      GetExitCodeProcess(PI.hProcess, Cardinal(Result));=0A=
    finally=0A=
      CloseHandle(PI.hProcess);=0A=
      CloseHandle(PI.hThread);=0A=
    end;=0A=
  finally=0A=
    CloseHandle(hRead);=0A=
  end;=0A=
  Output.Text :=3D string(FullOutput);=0A=
end;=0A=
=0A=
function GetGitConfigValue(const ConfigKey: string): string;=0A=
var=0A=
  Output: TStringList;=0A=
begin=0A=
  Result :=3D '';=0A=
  Output :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git config ' + ConfigKey, Output) =3D 0 then=0A=
    begin=0A=
      if Output.Count > 0 then=0A=
        Result :=3D Trim(Output.Text);=0A=
    end;=0A=
  finally=0A=
    Output.Free;=0A=
  end;=0A=
end;=0A=
=0A=
function Slugify(const Input: string): string;=0A=
begin=0A=
  Result :=3D Input.ToLower;=0A=
  Result :=3D TRegEx.Replace(Result, '[^a-z0-9]+', '-');=0A=
  Result :=3D TRegEx.Replace(Result, '^-+|-+$', '');=0A=
  if Length(Result) > 50 then=0A=
    Result :=3D Copy(Result, 1, 50);=0A=
end;=0A=
=0A=
function GetNextContributionNumber(const UserPrefix: string): Integer;=0A=
var=0A=
  Output: TStringList;=0A=
  MaxNum: Integer;=0A=
  Match: TMatch;=0A=
  Num: Integer;=0A=
  S: string;=0A=
  Regex: TRegEx;=0A=
begin=0A=
  MaxNum :=3D 0;=0A=
  Output :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git for-each-ref --format=3D"%(refname:short)" refs/=
heads refs/remotes/origin', Output) =3D 0 then=0A=
    begin=0A=
      S :=3D Output.Text;=0A=
      // The regex needs to be created with the user prefix=0A=
      Regex :=3D TRegEx.Create('^' + UserPrefix + 'Contribution(\d{3})-', [=
roMultiLine]);=0A=
      for Match in Regex.Matches(S) do=0A=
      begin=0A=
        if Match.Success then=0A=
        begin=0A=
          Num :=3D StrToIntDef(Match.Groups[1].Value, 0);=0A=
          if Num > MaxNum then=0A=
            MaxNum :=3D Num;=0A=
        end;=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    Output.Free;=0A=
  end;=0A=
  Result :=3D MaxNum + 1;=0A=
end;=0A=
=0A=
function TagExists(const ParaTagName: string): boolean;=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  Result :=3D False;=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git show-ref --verify "refs/tags/' + ParaTagName + '=
"', vOutput) =3D 0 then=0A=
    begin=0A=
      Result :=3D True;=0A=
    end=0A=
    else=0A=
    begin=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git ls-remote --tags origin "refs/tags/' + ParaTag=
Name + '"', vOutput) =3D 0 then=0A=
      begin=0A=
        Result :=3D vOutput.Text <> '';=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
function BranchExists(const ParaBranchName: string): boolean;=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  Result :=3D False;=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git show-ref --verify "refs/heads/' + ParaBranchName=
 + '"', vOutput) =3D 0 then=0A=
    begin=0A=
      Result :=3D True;=0A=
    end=0A=
    else=0A=
    begin=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git show-ref --verify "refs/remotes/origin/' + Par=
aBranchName + '"', vOutput) =3D 0 then=0A=
      begin=0A=
        Result :=3D True;=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
var=0A=
  vOldTagName, vDescription, vUserPrefix, vSlug, vNewBranchName: string;=0A=
  vNextNum: Integer;=0A=
  vOutput: TStringList;=0A=
begin=0A=
  try=0A=
    // --- Input Validation ---=0A=
    if ParamCount <> 2 then=0A=
    begin=0A=
      Writeln('Usage: git-back-to <tagname_of_old_commit> "<new_branch_desc=
ription>"');=0A=
      Writeln('Example: git-back-to merged/AI0001Contribution007-OldAPIDesi=
gn "Re-evaluate V1 API for performance"');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    vOldTagName :=3D ParamStr(1);=0A=
    vDescription :=3D ParamStr(2);=0A=
=0A=
    // --- Configuration ---=0A=
    vUserPrefix :=3D GetGitConfigValue('user.contributionPrefix');=0A=
    if vUserPrefix =3D '' then=0A=
    begin=0A=
      vUserPrefix :=3D GetGitConfigValue('user.name');=0A=
      if vUserPrefix <> '' then=0A=
      begin=0A=
        vUserPrefix :=3D TRegEx.Replace(vUserPrefix, '[^a-zA-Z0-9]', '');=
=0A=
        if Length(vUserPrefix) > 10 then=0A=
          vUserPrefix :=3D Copy(vUserPrefix, 1, 10);=0A=
      end=0A=
      else=0A=
      begin=0A=
        Writeln('Error: Git user.name or user.contributionPrefix not set.')=
;=0A=
        Writeln('Run: git config --global user.name "Your Name"');=0A=
        Writeln('Or: git config --global user.contributionPrefix "YourPrefi=
x"');=0A=
        ExitCode :=3D 1;=0A=
        Exit;=0A=
      end;=0A=
    end;=0A=
=0A=
    // --- Slugify Description ---=0A=
    vSlug :=3D Slugify(vDescription);=0A=
    if vSlug =3D '' then=0A=
    begin=0A=
      Writeln('Error: Description resulted in empty slug.');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    // --- Tag Existence Check ---=0A=
    if not TagExists(vOldTagName) then=0A=
    begin=0A=
      Writeln('Error: Tag ''' + vOldTagName + ''' does not exist locally or=
 remotely.');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    // --- Determine Next Contribution Number ---=0A=
    vNextNum :=3D GetNextContributionNumber(vUserPrefix);=0A=
    vNewBranchName :=3D Format('%sContribution%0.3d-%s', [vUserPrefix, vNex=
tNum, vSlug]);=0A=
=0A=
    // --- Check if branch already exists ---=0A=
    if BranchExists(vNewBranchName) then=0A=
    begin=0A=
      Writeln('Error: Branch ''' + vNewBranchName + ''' already exists.');=
=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    vOutput :=3D TStringList.Create;=0A=
    try=0A=
      // --- Create and Push Branch ---=0A=
      Writeln('Creating new branch ''' + vNewBranchName + ''' from tag ''' =
+ vOldTagName + '''...');=0A=
      if ExecuteCommand('git checkout -b "' + vNewBranchName + '" "' + vOld=
TagName + '"', vOutput) <> 0 then=0A=
      begin=0A=
        Writeln('Error: Failed to create branch from tag.');=0A=
        ExitCode :=3D 1;=0A=
        Exit;=0A=
      end;=0A=
      vOutput.Clear;=0A=
=0A=
      Writeln('Pushing ''' + vNewBranchName + ''' to remote...');=0A=
      if ExecuteCommand('git push -u origin "' + vNewBranchName + '"', vOut=
put) <> 0 then=0A=
      begin=0A=
        Writeln('Error: Failed to push branch to origin.');=0A=
        ExitCode :=3D 1;=0A=
        Exit;=0A=
      end;=0A=
      vOutput.Clear;=0A=
=0A=
      // --- Activate Branch ---=0A=
      Writeln('---');=0A=
      Writeln('Calling git-set-active to mark as active...');=0A=
      if ExecuteCommand('cmd.exe /c "' + ExtractFilePath(ParamStr(0)) + 'gi=
t-set-active.exe" ' + vNewBranchName, vOutput) <> 0 then=0A=
      begin=0A=
          Writeln('Warning: Could not mark branch active. Run manually: git=
-set-active ' + vNewBranchName);=0A=
      end;=0A=
      Writeln(vOutput.Text);=0A=
    finally=0A=
      vOutput.Free;=0A=
    end;=0A=
=0A=
    Writeln('');=0A=
    Writeln('Branch ''' + vNewBranchName + ''' successfully created and act=
ivated from tag ''' + vOldTagName + '''.');=0A=
    Writeln('To upgrade it against latest master, use: git-the-future');=0A=
=0A=
  except=0A=
    on E: Exception do=0A=
    begin=0A=
      Writeln(E.ClassName, ': ', E.Message);=0A=
      ExitCode :=3D 1;=0A=
    end;=0A=
  end;=0A=
end.=0A=
=0A=
=0A=
=0A=
program git_new_contribution;=0A=
=0A=
{$APPTYPE CONSOLE}=0A=
=0A=
uses=0A=
	System.SysUtils,=0A=
	System.Classes,=0A=
	System.RegularExpressions,=0A=
	System.IOUtils,=0A=
	Winapi.Windows;=0A=
=0A=
function ExecuteCommand( const ParaCommand : string; out ParaOutput : TStri=
ngList ) : Integer;=0A=
var=0A=
	vSA : TSecurityAttributes;=0A=
	vSI : TStartupInfo;=0A=
	vPI : TProcessInformation;=0A=
	vhRead, vhWrite : THandle;=0A=
	vBuffer : array[0..255] of AnsiChar;=0A=
	vBytesRead : DWord;=0A=
	vCmd : string;=0A=
begin=0A=
	ParaOutput :=3D TStringList.Create;=0A=
	Result :=3D -1;=0A=
=0A=
	vSA.nLength :=3D SizeOf(TSecurityAttributes);=0A=
	vSA.bInheritHandle :=3D True;=0A=
	vSA.lpSecurityDescriptor :=3D nil;=0A=
=0A=
	if not CreatePipe(vhRead, vhWrite, @vSA, 0) then=0A=
	begin=0A=
		Exit;=0A=
	end;=0A=
=0A=
	FillChar(vSI, SizeOf(TStartupInfo), 0);=0A=
	vSI.cb :=3D SizeOf(TStartupInfo);=0A=
	vSI.dwFlags :=3D STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;=0A=
	vSI.hStdInput :=3D GetStdHandle(STD_INPUT_HANDLE);=0A=
	vSI.hStdOutput :=3D vhWrite;=0A=
	vSI.hStdError :=3D vhWrite;=0A=
	vSI.wShowWindow :=3D SW_HIDE;=0A=
=0A=
	vCmd :=3D 'cmd.exe /C ' + ParaCommand;=0A=
	if not CreateProcess(nil, PChar(vCmd), nil, nil, True, 0, nil, nil, vSI, v=
PI) then=0A=
	begin=0A=
		CloseHandle(vhRead);=0A=
		CloseHandle(vhWrite);=0A=
		Exit;=0A=
	end;=0A=
=0A=
	CloseHandle(vhWrite);=0A=
=0A=
	while True do=0A=
	begin=0A=
		if not ReadFile(vhRead, vBuffer, SizeOf(vBuffer) - 1, vBytesRead, nil) or=
 (vBytesRead =3D 0) then=0A=
		begin=0A=
			break;=0A=
		end;=0A=
		vBuffer[vBytesRead] :=3D #0;=0A=
		ParaOutput.Add(string(vBuffer));=0A=
	end;=0A=
=0A=
	WaitForSingleObject(vPI.hProcess, INFINITE);=0A=
	GetExitCodeProcess(vPI.hProcess, Cardinal(Result));=0A=
=0A=
	CloseHandle(vhRead);=0A=
	CloseHandle(vPI.hProcess);=0A=
	CloseHandle(vPI.hThread);=0A=
end;=0A=
=0A=
function GetGitConfigValue( const ParaConfigKey : string ) : string;=0A=
var=0A=
	vOutput : TStringList;=0A=
begin=0A=
	Result :=3D '';=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git config ' + ParaConfigKey, vOutput) =3D 0 then=0A=
		begin=0A=
			if vOutput.Count > 0 then=0A=
			begin=0A=
				Result :=3D Trim(vOutput.Text);=0A=
			end;=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
end;=0A=
=0A=
function Slugify( const ParaInput : string ) : string;=0A=
begin=0A=
	Result :=3D ParaInput.ToLower;=0A=
	Result :=3D TRegEx.Replace(Result, '[^a-z0-9]+', '-');=0A=
	Result :=3D TRegEx.Replace(Result, '^-+|-+$', '');=0A=
	if Length(Result) > 50 then=0A=
	begin=0A=
		Result :=3D Copy(Result, 1, 50);=0A=
	end;=0A=
end;=0A=
=0A=
function GetNextContributionNumber( const ParaUserPrefix : string ) : Integ=
er;=0A=
var=0A=
	vOutput : TStringList;=0A=
	vMaxNum : Integer;=0A=
	vMatch : TMatch;=0A=
	vNum : Integer;=0A=
	vS : string;=0A=
begin=0A=
	vMaxNum :=3D 0;=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git for-each-ref --format=3D"%(refname:short)" refs/he=
ads refs/remotes/origin', vOutput) =3D 0 then=0A=
		begin=0A=
			vS :=3D vOutput.Text;=0A=
			for vMatch in TRegEx.Matches(vS, '^' + ParaUserPrefix + 'Contribution(\d=
{3})-') do=0A=
			begin=0A=
				if vMatch.Success then=0A=
				begin=0A=
					vNum :=3D StrToIntDef(vMatch.Groups[1].Value, 0);=0A=
					if vNum > vMaxNum then=0A=
					begin=0A=
						vMaxNum :=3D vNum;=0A=
					end;=0A=
				end;=0A=
			end;=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
	Result :=3D vMaxNum + 1;=0A=
end;=0A=
=0A=
var=0A=
	vUserPrefix, vDescription, vSlug, vNewBranchName : string;=0A=
	vNextNum : Integer;=0A=
	vOutput : TStringList;=0A=
begin=0A=
	try=0A=
		// --- Argument Parsing ---=0A=
		if ParamCount =3D 1 then=0A=
		begin=0A=
			vDescription :=3D ParamStr(1);=0A=
			vUserPrefix :=3D '';=0A=
		end=0A=
		else if ParamCount >=3D 2 then=0A=
		begin=0A=
			vUserPrefix :=3D ParamStr(1);=0A=
			vDescription :=3D ParamStr(2);=0A=
		end=0A=
		else=0A=
		begin=0A=
			Writeln('Usage: git-new-contribution [<UserPrefix>] "<Description/Goal..=
.>"');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		// --- Configuration ---=0A=
		if vUserPrefix =3D '' then=0A=
		begin=0A=
			vUserPrefix :=3D GetGitConfigValue('user.contributionPrefix');=0A=
			if vUserPrefix =3D '' then=0A=
			begin=0A=
				vUserPrefix :=3D GetGitConfigValue('user.name');=0A=
				if vUserPrefix <> '' then=0A=
				begin=0A=
					vUserPrefix :=3D TRegEx.Replace(vUserPrefix, '[^a-zA-Z0-9]', '');=0A=
					if Length(vUserPrefix) > 10 then=0A=
					begin=0A=
						vUserPrefix :=3D Copy(vUserPrefix, 1, 10);=0A=
					end;=0A=
				end=0A=
				else=0A=
				begin=0A=
					Writeln('Error: User prefix not provided and not found in git config.'=
);=0A=
					ExitCode :=3D 1;=0A=
					Exit;=0A=
				end;=0A=
			end;=0A=
		end;=0A=
=0A=
		// --- Slugify Description ---=0A=
		vSlug :=3D Slugify(vDescription);=0A=
		if vSlug =3D '' then=0A=
		begin=0A=
			Writeln('Error: Description resulted in empty slug.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vOutput :=3D TStringList.Create;=0A=
		try=0A=
			// --- Core Git Logic ---=0A=
			Writeln('Fetching latest master and switching to it...');=0A=
			if ExecuteCommand('git checkout master', vOutput) <> 0 then=0A=
			begin=0A=
				Writeln('Error: Failed to checkout master.');=0A=
				Writeln(vOutput.Text);=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git pull origin master', vOutput) <> 0 then=0A=
			begin=0A=
				Writeln('Error: Failed to pull latest master.');=0A=
				Writeln(vOutput.Text);=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
			// --- Determine Next Contribution Number ---=0A=
			vNextNum :=3D GetNextContributionNumber(vUserPrefix);=0A=
			vNewBranchName :=3D Format('%sContribution%0.3d-%s', [vUserPrefix, vNext=
Num, vSlug]);=0A=
=0A=
			// --- Check if Branch Already Exists ---=0A=
			if ExecuteCommand('git show-ref --verify refs/heads/' + vNewBranchName, =
vOutput) =3D 0 then=0A=
			begin=0A=
				Writeln('Error: Local branch already exists.');=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git show-ref --verify refs/remotes/origin/' + vNewBra=
nchName, vOutput) =3D 0 then=0A=
			begin=0A=
				Writeln('Error: Remote branch already exists.');=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
			// --- Create and Push Branch ---=0A=
			Writeln('Creating new branch: ' + vNewBranchName);=0A=
			if ExecuteCommand('git checkout -b ' + vNewBranchName + ' master', vOutp=
ut) <> 0 then=0A=
			begin=0A=
				Writeln('Error: Failed to create local branch.');=0A=
				Writeln(vOutput.Text);=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git push -u origin ' + vNewBranchName, vOutput) <> 0 =
then=0A=
			begin=0A=
				Writeln('Error: Failed to push new branch.');=0A=
				Writeln(vOutput.Text);=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
			// --- Set as Active ---=0A=
			if ExecuteCommand('cmd.exe /c "' + ExtractFilePath(ParamStr(0)) + 'git-s=
et-active.exe" ' + vNewBranchName, vOutput) <> 0 then=0A=
			begin=0A=
				Writeln('Warning: Failed to mark branch active.');=0A=
				Writeln(vOutput.Text);=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
			Writeln('');=0A=
			Writeln('Successfully created and activated new contribution branch:');=
=0A=
			Writeln('-> **' + vNewBranchName + '**');=0A=
			Writeln('You are now on this branch. Start coding!');=0A=
		finally=0A=
			vOutput.Free;=0A=
		end;=0A=
	except=0A=
		on E : Exception do=0A=
		begin=0A=
			Writeln(E.ClassName, ': ', E.Message);=0A=
			ExitCode :=3D 1;=0A=
		end;=0A=
	end;=0A=
end.=0A=
=0A=
=0A=
=0A=
program git_set_active;=0A=
=0A=
{$APPTYPE CONSOLE}=0A=
=0A=
uses=0A=
  System.SysUtils,=0A=
  System.Classes,=0A=
  System.IOUtils,=0A=
  Winapi.Windows;=0A=
=0A=
function ExecuteCommand(const Command: string; out Output: TStringList): In=
teger;=0A=
var=0A=
  SA: TSecurityAttributes;=0A=
  SI: TStartupInfo;=0A=
  PI: TProcessInformation;=0A=
  hRead, hWrite: THandle;=0A=
  Buffer: array[0..1023] of AnsiChar;=0A=
  BytesRead: DWord;=0A=
  Cmd: string;=0A=
  FullOutput: AnsiString;=0A=
begin=0A=
  Output :=3D TStringList.Create;=0A=
  Result :=3D -1;=0A=
  FullOutput :=3D '';=0A=
=0A=
  SA.nLength :=3D SizeOf(TSecurityAttributes);=0A=
  SA.bInheritHandle :=3D True;=0A=
  SA.lpSecurityDescriptor :=3D nil;=0A=
=0A=
  if not CreatePipe(hRead, hWrite, @SA, 0) then=0A=
    Exit;=0A=
=0A=
  try=0A=
    FillChar(SI, SizeOf(TStartupInfo), 0);=0A=
    SI.cb :=3D SizeOf(TStartupInfo);=0A=
    SI.dwFlags :=3D STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;=0A=
    SI.hStdInput :=3D GetStdHandle(STD_INPUT_HANDLE);=0A=
    SI.hStdOutput :=3D hWrite;=0A=
    SI.hStdError :=3D hWrite;=0A=
    SI.wShowWindow :=3D SW_HIDE;=0A=
=0A=
    Cmd :=3D 'cmd.exe /C ' + Command;=0A=
    if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, =
PI) then=0A=
    begin=0A=
      Exit;=0A=
    end;=0A=
=0A=
    CloseHandle(hWrite); // Close the write end of the pipe in the parent p=
rocess=0A=
=0A=
    try=0A=
      while True do=0A=
      begin=0A=
        if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) =
or (BytesRead =3D 0) then=0A=
          break;=0A=
        Buffer[BytesRead] :=3D #0;=0A=
        FullOutput :=3D FullOutput + AnsiString(Buffer);=0A=
      end;=0A=
=0A=
      WaitForSingleObject(PI.hProcess, INFINITE);=0A=
      GetExitCodeProcess(PI.hProcess, Cardinal(Result));=0A=
    finally=0A=
      CloseHandle(PI.hProcess);=0A=
      CloseHandle(PI.hThread);=0A=
    end;=0A=
  finally=0A=
    CloseHandle(hRead);=0A=
  end;=0A=
  Output.Text :=3D string(FullOutput);=0A=
end;=0A=
=0A=
function BranchExists(const ParaBranchName: string): boolean;=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  Result :=3D False;=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git show-ref --verify "refs/heads/' + ParaBranchName=
 + '"', vOutput) =3D 0 then=0A=
    begin=0A=
      Result :=3D True;=0A=
    end=0A=
    else=0A=
    begin=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git show-ref --verify "refs/remotes/origin/' + Par=
aBranchName + '"', vOutput) =3D 0 then=0A=
      begin=0A=
        Result :=3D True;=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
function GetBranchHash(const ParaBranchName: string): string;=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  Result :=3D '';=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git rev-parse "refs/remotes/origin/' + ParaBranchNam=
e + '^{commit}"', vOutput) =3D 0 then=0A=
    begin=0A=
      Result :=3D Trim(vOutput.Text);=0A=
    end=0A=
    else=0A=
    begin=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git rev-parse "refs/heads/' + ParaBranchName + '^{=
commit}"', vOutput) =3D 0 then=0A=
      begin=0A=
         Result :=3D Trim(vOutput.Text);=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
procedure DeleteTagIfExists(const ParaTagName: string);=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git show-ref --verify "refs/tags/' + ParaTagName + '=
"', vOutput) =3D 0 then=0A=
    begin=0A=
      Writeln('Removing existing tag: ' + ParaTagName + '...');=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git push origin --delete "' + ParaTagName + '"', v=
Output) <> 0 then=0A=
      begin=0A=
        Writeln('Warning: Failed to delete tag ' + ParaTagName + '.');=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
var=0A=
  vBranchName, vActiveTag, vBranchHash: string;=0A=
  vOutput: TStringList;=0A=
begin=0A=
  try=0A=
    // --- Input Validation ---=0A=
    if ParamCount <> 1 then=0A=
    begin=0A=
      Writeln('Usage: git-set-active <branchname>');=0A=
      Writeln('Example: git-set-active SkybuckContribution001-ImplementLogi=
n');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    vBranchName :=3D ParamStr(1);=0A=
    vActiveTag :=3D 'active/' + vBranchName;=0A=
=0A=
    // --- Check Branch Existence ---=0A=
    if not BranchExists(vBranchName) then=0A=
    begin=0A=
      Writeln('Error: Branch ''' + vBranchName + ''' not found locally or r=
emotely.');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    // --- Determine Commit Hash ---=0A=
    vBranchHash :=3D GetBranchHash(vBranchName);=0A=
    if vBranchHash =3D '' then=0A=
    begin=0A=
      Writeln('Error: Unable to determine commit hash for branch ''' + vBra=
nchName + '''.');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    // --- Clean Up Old Tags ---=0A=
    DeleteTagIfExists('merged/' + vBranchName);=0A=
    DeleteTagIfExists('rejected/' + vBranchName);=0A=
=0A=
    // --- Create and Push Active Tag ---=0A=
    Writeln('Creating and pushing active tag: ' + vActiveTag);=0A=
    vOutput :=3D TStringList.Create;=0A=
    try=0A=
      if ExecuteCommand('git tag -f "' + vActiveTag + '" "' + vBranchHash +=
 '"', vOutput) <> 0 then=0A=
      begin=0A=
          Writeln('Error: Failed to create tag ' + vActiveTag);=0A=
          ExitCode :=3D 1;=0A=
          Exit;=0A=
      end;=0A=
      vOutput.Clear;=0A=
=0A=
      if ExecuteCommand('git push -f origin "' + vActiveTag + '"', vOutput)=
 <> 0 then=0A=
      begin=0A=
          Writeln('Error: Failed to push tag ' + vActiveTag + ' to origin')=
;=0A=
          ExitCode :=3D 1;=0A=
          Exit;=0A=
      end;=0A=
    finally=0A=
      vOutput.Free;=0A=
    end;=0A=
=0A=
    Writeln('');=0A=
    Writeln('Branch ' + vBranchName + ' is now marked as ACTIVE.');=0A=
    Writeln('To view active branches: git tag --list "active/*"');=0A=
=0A=
  except=0A=
    on E: Exception do=0A=
    begin=0A=
      Writeln(E.ClassName, ': ', E.Message);=0A=
      ExitCode :=3D 1;=0A=
    end;=0A=
  end;=0A=
end.=0A=
=0A=
=0A=
=0A=
program git_set_merged;=0A=
=0A=
{$APPTYPE CONSOLE}=0A=
=0A=
uses=0A=
  System.SysUtils,=0A=
  System.Classes,=0A=
  System.IOUtils,=0A=
  Winapi.Windows;=0A=
=0A=
function ExecuteCommand(const Command: string; out Output: TStringList): In=
teger;=0A=
var=0A=
  SA: TSecurityAttributes;=0A=
  SI: TStartupInfo;=0A=
  PI: TProcessInformation;=0A=
  hRead, hWrite: THandle;=0A=
  Buffer: array[0..1023] of AnsiChar;=0A=
  BytesRead: DWord;=0A=
  Cmd: string;=0A=
  FullOutput: AnsiString;=0A=
begin=0A=
  Output :=3D TStringList.Create;=0A=
  Result :=3D -1;=0A=
  FullOutput :=3D '';=0A=
=0A=
  SA.nLength :=3D SizeOf(TSecurityAttributes);=0A=
  SA.bInheritHandle :=3D True;=0A=
  SA.lpSecurityDescriptor :=3D nil;=0A=
=0A=
  if not CreatePipe(hRead, hWrite, @SA, 0) then=0A=
    Exit;=0A=
=0A=
  try=0A=
    FillChar(SI, SizeOf(TStartupInfo), 0);=0A=
    SI.cb :=3D SizeOf(TStartupInfo);=0A=
    SI.dwFlags :=3D STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;=0A=
    SI.hStdInput :=3D GetStdHandle(STD_INPUT_HANDLE);=0A=
    SI.hStdOutput :=3D hWrite;=0A=
    SI.hStdError :=3D hWrite;=0A=
    SI.wShowWindow :=3D SW_HIDE;=0A=
=0A=
    Cmd :=3D 'cmd.exe /C ' + Command;=0A=
    if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, =
PI) then=0A=
    begin=0A=
      Exit;=0A=
    end;=0A=
=0A=
    CloseHandle(hWrite);=0A=
=0A=
    try=0A=
      while True do=0A=
      begin=0A=
        if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) =
or (BytesRead =3D 0) then=0A=
          break;=0A=
        Buffer[BytesRead] :=3D #0;=0A=
        FullOutput :=3D FullOutput + AnsiString(Buffer);=0A=
      end;=0A=
=0A=
      WaitForSingleObject(PI.hProcess, INFINITE);=0A=
      GetExitCodeProcess(PI.hProcess, Cardinal(Result));=0A=
    finally=0A=
      CloseHandle(PI.hProcess);=0A=
      CloseHandle(PI.hThread);=0A=
    end;=0A=
  finally=0A=
    CloseHandle(hRead);=0A=
  end;=0A=
  Output.Text :=3D string(FullOutput);=0A=
end;=0A=
=0A=
function BranchExists(const ParaBranchName: string): boolean;=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  Result :=3D False;=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git show-ref --verify "refs/heads/' + ParaBranchName=
 + '"', vOutput) =3D 0 then=0A=
    begin=0A=
      Result :=3D True;=0A=
    end=0A=
    else=0A=
    begin=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git show-ref --verify "refs/remotes/origin/' + Par=
aBranchName + '"', vOutput) =3D 0 then=0A=
      begin=0A=
        Result :=3D True;=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
function GetBranchHash(const ParaBranchName: string): string;=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  Result :=3D '';=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git rev-parse "refs/remotes/origin/' + ParaBranchNam=
e + '^{commit}"', vOutput) =3D 0 then=0A=
    begin=0A=
      Result :=3D Trim(vOutput.Text);=0A=
    end=0A=
    else=0A=
    begin=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git rev-parse "refs/heads/' + ParaBranchName + '^{=
commit}"', vOutput) =3D 0 then=0A=
      begin=0A=
         Result :=3D Trim(vOutput.Text);=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
procedure DeleteTagIfExists(const ParaTagName: string);=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git show-ref --verify "refs/tags/' + ParaTagName + '=
"', vOutput) =3D 0 then=0A=
    begin=0A=
      Writeln('Removing existing tag: ' + ParaTagName + '...');=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git push origin --delete "' + ParaTagName + '"', v=
Output) <> 0 then=0A=
      begin=0A=
        Writeln('Warning: Failed to delete tag ' + ParaTagName + '.');=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
var=0A=
  vBranchName, vMergedTag, vBranchHash: string;=0A=
  vOutput: TStringList;=0A=
begin=0A=
  try=0A=
    // --- Input Validation ---=0A=
    if ParamCount <> 1 then=0A=
    begin=0A=
      Writeln('Usage: git-set-merged <branchname>');=0A=
      Writeln('Example: git-set-merged SkybuckContribution001-MyFeature');=
=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    vBranchName :=3D ParamStr(1);=0A=
    vMergedTag :=3D 'merged/' + vBranchName;=0A=
=0A=
    // --- Verify Branch Exists ---=0A=
    if not BranchExists(vBranchName) then=0A=
    begin=0A=
      Writeln('Error: Branch ''' + vBranchName + ''' does not exist locally=
 or remotely.');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    // --- Get Latest Commit Hash ---=0A=
    vBranchHash :=3D GetBranchHash(vBranchName);=0A=
    if vBranchHash =3D '' then=0A=
    begin=0A=
      Writeln('Error: Unable to determine commit hash for branch ''' + vBra=
nchName + '''.');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    // --- Remove active/rejected tags ---=0A=
    DeleteTagIfExists('active/' + vBranchName);=0A=
    DeleteTagIfExists('rejected/' + vBranchName);=0A=
=0A=
    // --- Create and Push Merged Tag ---=0A=
    Writeln('Creating and pushing tag: ' + vMergedTag);=0A=
    vOutput :=3D TStringList.Create;=0A=
    try=0A=
      if ExecuteCommand('git tag -f "' + vMergedTag + '" "' + vBranchHash +=
 '"', vOutput) <> 0 then=0A=
      begin=0A=
          Writeln('Error: Failed to create tag ' + vMergedTag + '.');=0A=
          ExitCode :=3D 1;=0A=
          Exit;=0A=
      end;=0A=
      vOutput.Clear;=0A=
=0A=
      if ExecuteCommand('git push -f origin "' + vMergedTag + '"', vOutput)=
 <> 0 then=0A=
      begin=0A=
          Writeln('Error: Failed to push tag ' + vMergedTag + ' to origin.'=
);=0A=
          ExitCode :=3D 1;=0A=
          Exit;=0A=
      end;=0A=
    finally=0A=
      vOutput.Free;=0A=
    end;=0A=
=0A=
    Writeln('');=0A=
    Writeln('Branch ' + vBranchName + ' successfully marked as MERGED.');=
=0A=
    Writeln('It remains in your repository history.');=0A=
=0A=
  except=0A=
    on E: Exception do=0A=
    begin=0A=
      Writeln(E.ClassName, ': ', E.Message);=0A=
      ExitCode :=3D 1;=0A=
    end;=0A=
  end;=0A=
end.=0A=
=0A=
=0A=
=0A=
program git_set_rejected;=0A=
=0A=
{$APPTYPE CONSOLE}=0A=
=0A=
uses=0A=
  System.SysUtils,=0A=
  System.Classes,=0A=
  System.IOUtils,=0A=
  Winapi.Windows;=0A=
=0A=
function ExecuteCommand(const Command: string; out Output: TStringList): In=
teger;=0A=
var=0A=
  SA: TSecurityAttributes;=0A=
  SI: TStartupInfo;=0A=
  PI: TProcessInformation;=0A=
  hRead, hWrite: THandle;=0A=
  Buffer: array[0..1023] of AnsiChar;=0A=
  BytesRead: DWord;=0A=
  Cmd: string;=0A=
  FullOutput: AnsiString;=0A=
begin=0A=
  Output :=3D TStringList.Create;=0A=
  Result :=3D -1;=0A=
  FullOutput :=3D '';=0A=
=0A=
  SA.nLength :=3D SizeOf(TSecurityAttributes);=0A=
  SA.bInheritHandle :=3D True;=0A=
  SA.lpSecurityDescriptor :=3D nil;=0A=
=0A=
  if not CreatePipe(hRead, hWrite, @SA, 0) then=0A=
    Exit;=0A=
=0A=
  try=0A=
    FillChar(SI, SizeOf(TStartupInfo), 0);=0A=
    SI.cb :=3D SizeOf(TStartupInfo);=0A=
    SI.dwFlags :=3D STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;=0A=
    SI.hStdInput :=3D GetStdHandle(STD_INPUT_HANDLE);=0A=
    SI.hStdOutput :=3D hWrite;=0A=
    SI.hStdError :=3D hWrite;=0A=
    SI.wShowWindow :=3D SW_HIDE;=0A=
=0A=
    Cmd :=3D 'cmd.exe /C ' + Command;=0A=
    if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, =
PI) then=0A=
    begin=0A=
      Exit;=0A=
    end;=0A=
=0A=
    CloseHandle(hWrite);=0A=
=0A=
    try=0A=
      while True do=0A=
      begin=0A=
        if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) =
or (BytesRead =3D 0) then=0A=
          break;=0A=
        Buffer[BytesRead] :=3D #0;=0A=
        FullOutput :=3D FullOutput + AnsiString(Buffer);=0A=
      end;=0A=
=0A=
      WaitForSingleObject(PI.hProcess, INFINITE);=0A=
      GetExitCodeProcess(PI.hProcess, Cardinal(Result));=0A=
    finally=0A=
      CloseHandle(PI.hProcess);=0A=
      CloseHandle(PI.hThread);=0A=
    end;=0A=
  finally=0A=
    CloseHandle(hRead);=0A=
  end;=0A=
  Output.Text :=3D string(FullOutput);=0A=
end;=0A=
=0A=
function BranchExists(const ParaBranchName: string): boolean;=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  Result :=3D False;=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git show-ref --verify "refs/heads/' + ParaBranchName=
 + '"', vOutput) =3D 0 then=0A=
    begin=0A=
      Result :=3D True;=0A=
    end=0A=
    else=0A=
    begin=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git show-ref --verify "refs/remotes/origin/' + Par=
aBranchName + '"', vOutput) =3D 0 then=0A=
      begin=0A=
        Result :=3D True;=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
function GetBranchHash(const ParaBranchName: string): string;=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  Result :=3D '';=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git rev-parse "refs/remotes/origin/' + ParaBranchNam=
e + '^{commit}"', vOutput) =3D 0 then=0A=
    begin=0A=
      Result :=3D Trim(vOutput.Text);=0A=
    end=0A=
    else=0A=
    begin=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git rev-parse "refs/heads/' + ParaBranchName + '^{=
commit}"', vOutput) =3D 0 then=0A=
      begin=0A=
         Result :=3D Trim(vOutput.Text);=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
procedure DeleteTagIfExists(const ParaTagName: string);=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git show-ref --verify "refs/tags/' + ParaTagName + '=
"', vOutput) =3D 0 then=0A=
    begin=0A=
      Writeln('Removing remote tag: ' + ParaTagName + '...');=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git push origin --delete "' + ParaTagName + '"', v=
Output) <> 0 then=0A=
      begin=0A=
        Writeln('Warning: Could not delete tag ' + ParaTagName + '.');=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
var=0A=
  vBranchName, vRejectedTag, vBranchHash: string;=0A=
  vOutput: TStringList;=0A=
begin=0A=
  try=0A=
    // --- Input Validation ---=0A=
    if ParamCount <> 1 then=0A=
    begin=0A=
      Writeln('Usage: git-set-rejected <branchname>');=0A=
      Writeln('Example: git-set-rejected AI0001Contribution002-Experimental=
Algorithm');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    vBranchName :=3D ParamStr(1);=0A=
    vRejectedTag :=3D 'rejected/' + vBranchName;=0A=
=0A=
    // --- Branch Existence Check ---=0A=
    if not BranchExists(vBranchName) then=0A=
    begin=0A=
      Writeln('Error: Branch ''' + vBranchName + ''' does not exist locally=
 or remotely.');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    // --- Commit Hash Resolution ---=0A=
    vBranchHash :=3D GetBranchHash(vBranchName);=0A=
    if vBranchHash =3D '' then=0A=
    begin=0A=
      Writeln('Error: Could not determine commit hash for branch ''' + vBra=
nchName + '''.');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    // --- Remove active/merged tags ---=0A=
    DeleteTagIfExists('active/' + vBranchName);=0A=
    DeleteTagIfExists('merged/' + vBranchName);=0A=
=0A=
    // --- Create and Push Rejected Tag ---=0A=
    Writeln('Creating and pushing rejected tag: ' + vRejectedTag);=0A=
    vOutput :=3D TStringList.Create;=0A=
    try=0A=
      if ExecuteCommand('git tag -f "' + vRejectedTag + '" "' + vBranchHash=
 + '"', vOutput) <> 0 then=0A=
      begin=0A=
          Writeln('Error: Could not create tag ''' + vRejectedTag + '''');=
=0A=
          ExitCode :=3D 1;=0A=
          Exit;=0A=
      end;=0A=
      vOutput.Clear;=0A=
=0A=
      if ExecuteCommand('git push -f origin "' + vRejectedTag + '"', vOutpu=
t) <> 0 then=0A=
      begin=0A=
          Writeln('Error: Could not push tag ''' + vRejectedTag + ''' to or=
igin');=0A=
          ExitCode :=3D 1;=0A=
          Exit;=0A=
      end;=0A=
    finally=0A=
      vOutput.Free;=0A=
    end;=0A=
=0A=
    Writeln('');=0A=
    Writeln('Branch ' + vBranchName + ' marked as REJECTED.');=0A=
    Writeln('Tag ''' + vRejectedTag + ''' added for reference.');=0A=
=0A=
  except=0A=
    on E: Exception do=0A=
    begin=0A=
      Writeln(E.ClassName, ': ', E.Message);=0A=
      ExitCode :=3D 1;=0A=
    end;=0A=
  end;=0A=
end.=0A=
=0A=
=0A=
=0A=
=0A=
program git_set_revive;=0A=
=0A=
{$APPTYPE CONSOLE}=0A=
=0A=
uses=0A=
  System.SysUtils,=0A=
  System.Classes,=0A=
  System.IOUtils,=0A=
  Winapi.Windows;=0A=
=0A=
function ExecuteCommand(const Command: string; out Output: TStringList): In=
teger;=0A=
var=0A=
  SA: TSecurityAttributes;=0A=
  SI: TStartupInfo;=0A=
  PI: TProcessInformation;=0A=
  hRead, hWrite: THandle;=0A=
  Buffer: array[0..1023] of AnsiChar;=0A=
  BytesRead: DWord;=0A=
  Cmd: string;=0A=
  FullOutput: AnsiString;=0A=
begin=0A=
  Output :=3D TStringList.Create;=0A=
  Result :=3D -1;=0A=
  FullOutput :=3D '';=0A=
=0A=
  SA.nLength :=3D SizeOf(TSecurityAttributes);=0A=
  SA.bInheritHandle :=3D True;=0A=
  SA.lpSecurityDescriptor :=3D nil;=0A=
=0A=
  if not CreatePipe(hRead, hWrite, @SA, 0) then=0A=
    Exit;=0A=
=0A=
  try=0A=
    FillChar(SI, SizeOf(TStartupInfo), 0);=0A=
    SI.cb :=3D SizeOf(TStartupInfo);=0A=
    SI.dwFlags :=3D STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;=0A=
    SI.hStdInput :=3D GetStdHandle(STD_INPUT_HANDLE);=0A=
    SI.hStdOutput :=3D hWrite;=0A=
    SI.hStdError :=3D hWrite;=0A=
    SI.wShowWindow :=3D SW_HIDE;=0A=
=0A=
    Cmd :=3D 'cmd.exe /C ' + Command;=0A=
    if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, =
PI) then=0A=
    begin=0A=
      Exit;=0A=
    end;=0A=
=0A=
    CloseHandle(hWrite);=0A=
=0A=
    try=0A=
      while True do=0A=
      begin=0A=
        if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) =
or (BytesRead =3D 0) then=0A=
          break;=0A=
        Buffer[BytesRead] :=3D #0;=0A=
        FullOutput :=3D FullOutput + AnsiString(Buffer);=0A=
      end;=0A=
=0A=
      WaitForSingleObject(PI.hProcess, INFINITE);=0A=
      GetExitCodeProcess(PI.hProcess, Cardinal(Result));=0A=
    finally=0A=
      CloseHandle(PI.hProcess);=0A=
      CloseHandle(PI.hThread);=0A=
    end;=0A=
  finally=0A=
    CloseHandle(hRead);=0A=
  end;=0A=
  Output.Text :=3D string(FullOutput);=0A=
end;=0A=
=0A=
function BranchExists(const ParaBranchName: string): boolean;=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  Result :=3D False;=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git show-ref --verify "refs/heads/' + ParaBranchName=
 + '"', vOutput) =3D 0 then=0A=
    begin=0A=
      Result :=3D True;=0A=
    end=0A=
    else=0A=
    begin=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git show-ref --verify "refs/remotes/origin/' + Par=
aBranchName + '"', vOutput) =3D 0 then=0A=
      begin=0A=
        Result :=3D True;=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
function HasTag(const ParaTagName: string): boolean;=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  Result :=3D False;=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git ls-remote --tags origin "' + ParaTagName + '"', =
vOutput) =3D 0 then=0A=
    begin=0A=
      Result :=3D vOutput.Text <> '';=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
procedure DeleteTagIfExists(const ParaTagName: string);=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    // Check remote tags first=0A=
    if ExecuteCommand('git ls-remote --tags origin "' + ParaTagName + '"', =
vOutput) =3D 0 then=0A=
    begin=0A=
      if vOutput.Text <> '' then=0A=
      begin=0A=
        Writeln('Removing remote tag: ' + ParaTagName + '...');=0A=
        vOutput.Clear;=0A=
        if ExecuteCommand('git push origin --delete "' + ParaTagName + '"',=
 vOutput) <> 0 then=0A=
        begin=0A=
            Writeln('Warning: Could not delete remote tag ' + ParaTagName +=
 '.');=0A=
        end;=0A=
      end;=0A=
    end;=0A=
=0A=
    // Check local tags=0A=
    vOutput.Clear;=0A=
    if ExecuteCommand('git show-ref --verify "refs/tags/' + ParaTagName + '=
"', vOutput) =3D 0 then=0A=
    begin=0A=
      Writeln('Removing local tag: ' + ParaTagName + '...');=0A=
      vOutput.Clear;=0A=
      if ExecuteCommand('git tag -d "' + ParaTagName + '"', vOutput) <> 0 t=
hen=0A=
      begin=0A=
        Writeln('Warning: Could not delete local tag ' + ParaTagName + '.')=
;=0A=
      end;=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
=0A=
var=0A=
  vBranchName: string;=0A=
  vHasTag: boolean;=0A=
  vOutput: TStringList;=0A=
begin=0A=
  try=0A=
    // --- Input Validation ---=0A=
    if ParamCount <> 1 then=0A=
    begin=0A=
      Writeln('Usage: git-set-revive <branchname>');=0A=
      Writeln('Example: git-set-revive SkybuckContribution005-BugfixRethink=
');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    vBranchName :=3D ParamStr(1);=0A=
=0A=
    // --- Check Branch Existence ---=0A=
    if not BranchExists(vBranchName) then=0A=
    begin=0A=
      Writeln('Error: Branch ''' + vBranchName + ''' not found locally or r=
emotely.');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    // --- Check if it has merged or rejected tag remotely ---=0A=
    vHasTag :=3D HasTag('merged/' + vBranchName) or HasTag('rejected/' + vB=
ranchName);=0A=
=0A=
    if not vHasTag then=0A=
    begin=0A=
      Writeln('Error: Branch ''' + vBranchName + ''' is not marked as merge=
d or rejected.');=0A=
      Writeln('If it''s active, run: git-set-active ' + vBranchName);=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    Writeln('Attempting to revive branch ''' + vBranchName + '''...');=0A=
=0A=
    // --- Delete old tags ---=0A=
    DeleteTagIfExists('merged/' + vBranchName);=0A=
    DeleteTagIfExists('rejected/' + vBranchName);=0A=
=0A=
    // --- Mark as active by calling git-set-active ---=0A=
    Writeln('---');=0A=
    Writeln('Calling git-set-active to apply active tag...');=0A=
    vOutput :=3D TStringList.Create;=0A=
    try=0A=
      if ExecuteCommand('cmd.exe /c "' + ExtractFilePath(ParamStr(0)) + 'gi=
t-set-active.exe" ' + vBranchName, vOutput) <> 0 then=0A=
      begin=0A=
        Writeln(vOutput.Text);=0A=
        Writeln('Error: git-set-active failed. Try running manually: git-se=
t-active ' + vBranchName);=0A=
        ExitCode :=3D 1;=0A=
        Exit;=0A=
      end;=0A=
      Writeln(vOutput.Text);=0A=
    finally=0A=
      vOutput.Free;=0A=
    end;=0A=
=0A=
=0A=
    Writeln('');=0A=
    Writeln('Branch ' + vBranchName + ' successfully REVIVED and marked as =
ACTIVE.');=0A=
    Writeln('This does not rebase history onto master.');=0A=
    Writeln('To switch to it: git checkout ' + vBranchName);=0A=
=0A=
  except=0A=
    on E: Exception do=0A=
    begin=0A=
      Writeln(E.ClassName, ': ', E.Message);=0A=
      ExitCode :=3D 1;=0A=
    end;=0A=
  end;=0A=
end.=0A=
=0A=
=0A=
=0A=
=0A=
program git_the_future;=0A=
=0A=
{$APPTYPE CONSOLE}=0A=
=0A=
uses=0A=
  System.SysUtils,=0A=
  System.Classes,=0A=
  System.IOUtils,=0A=
  Winapi.Windows;=0A=
=0A=
function ExecuteCommand(const Command: string; out Output: TStringList; Pas=
sThrough: Boolean =3D False): Integer;=0A=
var=0A=
  SA: TSecurityAttributes;=0A=
  SI: TStartupInfo;=0A=
  PI: TProcessInformation;=0A=
  hRead, hWrite: THandle;=0A=
  Buffer: array[0..1023] of AnsiChar;=0A=
  BytesRead: DWord;=0A=
  Cmd: string;=0A=
  FullOutput: AnsiString;=0A=
  StdOut, StdErr: THandle;=0A=
begin=0A=
  Output :=3D TStringList.Create;=0A=
  Result :=3D -1;=0A=
  FullOutput :=3D '';=0A=
=0A=
  SA.nLength :=3D SizeOf(TSecurityAttributes);=0A=
  SA.bInheritHandle :=3D True;=0A=
  SA.lpSecurityDescriptor :=3D nil;=0A=
=0A=
  if not CreatePipe(hRead, hWrite, @SA, 0) then=0A=
    Exit;=0A=
=0A=
  try=0A=
    FillChar(SI, SizeOf(TStartupInfo), 0);=0A=
    SI.cb :=3D SizeOf(TStartupInfo);=0A=
=0A=
    if PassThrough then=0A=
    begin=0A=
        StdOut :=3D GetStdHandle(STD_OUTPUT_HANDLE);=0A=
        StdErr :=3D GetStdHandle(STD_ERROR_HANDLE);=0A=
        SI.dwFlags :=3D STARTF_USESTDHANDLES;=0A=
        SI.hStdInput :=3D GetStdHandle(STD_INPUT_HANDLE);=0A=
        SI.hStdOutput :=3D StdOut;=0A=
        SI.hStdError :=3D StdErr;=0A=
    end=0A=
    else=0A=
    begin=0A=
        SI.dwFlags :=3D STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;=0A=
        SI.hStdInput :=3D GetStdHandle(STD_INPUT_HANDLE);=0A=
        SI.hStdOutput :=3D hWrite;=0A=
        SI.hStdError :=3D hWrite;=0A=
        SI.wShowWindow :=3D SW_HIDE;=0A=
    end;=0A=
=0A=
    Cmd :=3D 'cmd.exe /C ' + Command;=0A=
    if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, =
PI) then=0A=
    begin=0A=
      Exit;=0A=
    end;=0A=
=0A=
    if not PassThrough then=0A=
        CloseHandle(hWrite);=0A=
=0A=
    try=0A=
      if not PassThrough then=0A=
      begin=0A=
          while True do=0A=
          begin=0A=
            if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, n=
il) or (BytesRead =3D 0) then=0A=
              break;=0A=
            Buffer[BytesRead] :=3D #0;=0A=
            FullOutput :=3D FullOutput + AnsiString(Buffer);=0A=
          end;=0A=
      end;=0A=
=0A=
      WaitForSingleObject(PI.hProcess, INFINITE);=0A=
      GetExitCodeProcess(PI.hProcess, Cardinal(Result));=0A=
    finally=0A=
      CloseHandle(PI.hProcess);=0A=
      CloseHandle(PI.hThread);=0A=
    end;=0A=
  finally=0A=
    if not PassThrough then=0A=
        CloseHandle(hRead);=0A=
  end;=0A=
  Output.Text :=3D string(FullOutput);=0A=
end;=0A=
=0A=
function GetCurrentBranch: string;=0A=
var=0A=
  vOutput: TStringList;=0A=
begin=0A=
  Result :=3D '';=0A=
  vOutput :=3D TStringList.Create;=0A=
  try=0A=
    if ExecuteCommand('git rev-parse --abbrev-ref HEAD', vOutput) =3D 0 the=
n=0A=
    begin=0A=
      Result :=3D Trim(vOutput.Text);=0A=
    end;=0A=
  finally=0A=
    vOutput.Free;=0A=
  end;=0A=
end;=0A=
=0A=
var=0A=
  vCurrentBranch: string;=0A=
  vRebaseStatus: Integer;=0A=
  vOutput: TStringList;=0A=
begin=0A=
  try=0A=
    // --- Determine current branch ---=0A=
    vCurrentBranch :=3D GetCurrentBranch;=0A=
=0A=
    if (vCurrentBranch =3D '') or (vCurrentBranch =3D 'HEAD') then=0A=
    begin=0A=
      Writeln('Error: You are not on a branch (detached HEAD). Checkout a b=
ranch first.');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    if vCurrentBranch.ToLower =3D 'master' then=0A=
    begin=0A=
      Writeln('Error: You''re on ''master''. This command is meant for feat=
ure branches.');=0A=
      ExitCode :=3D 1;=0A=
      Exit;=0A=
    end;=0A=
=0A=
    Writeln('Preparing to rebase branch ''' + vCurrentBranch + ''' onto lat=
est ''master''...');=0A=
=0A=
    vOutput :=3D TStringList.Create;=0A=
    try=0A=
      // --- Update local master ---=0A=
      Writeln('Updating ''master''...');=0A=
      if ExecuteCommand('git checkout master', vOutput) <> 0 then=0A=
      begin=0A=
        Writeln('Error: Could not checkout master.');=0A=
        ExitCode :=3D 1;=0A=
        Exit;=0A=
      end;=0A=
      vOutput.Clear;=0A=
=0A=
      if ExecuteCommand('git pull origin master', vOutput) <> 0 then=0A=
      begin=0A=
        Writeln('Error: Could not pull from origin master.');=0A=
        ExitCode :=3D 1;=0A=
        Exit;=0A=
      end;=0A=
      vOutput.Clear;=0A=
=0A=
      // --- Return to original branch ---=0A=
      if ExecuteCommand('git checkout "' + vCurrentBranch + '"', vOutput) <=
> 0 then=0A=
      begin=0A=
        Writeln('Error: Could not checkout back to ''' + vCurrentBranch + '=
''.');=0A=
        ExitCode :=3D 1;=0A=
        Exit;=0A=
      end;=0A=
      vOutput.Clear;=0A=
=0A=
      // --- Begin rebase ---=0A=
      Writeln('');=0A=
      Writeln('Starting rebase of ''' + vCurrentBranch + ''' onto ''master'=
'...');=0A=
      Writeln('----------------------------------------');=0A=
=0A=
      vRebaseStatus :=3D ExecuteCommand('git rebase master', vOutput, True)=
;=0A=
=0A=
      if vRebaseStatus =3D 0 then=0A=
      begin=0A=
        Writeln('----------------------------------------');=0A=
        Writeln('Rebase completed successfully!');=0A=
        Writeln('Your branch ''' + vCurrentBranch + ''' is now on top of ma=
ster.');=0A=
        Writeln('To update remote:');=0A=
        Writeln('    git push --force-with-lease origin ' + vCurrentBranch)=
;=0A=
      end=0A=
      else if vRebaseStatus =3D 1 then=0A=
      begin=0A=
        Writeln('----------------------------------------');=0A=
        Writeln('Rebase paused due to conflicts.');=0A=
        Writeln('Resolve conflicts manually, then run:');=0A=
        Writeln('    git add .');=0A=
        Writeln('    git rebase --continue');=0A=
        Writeln('Or to abort:');=0A=
        Writeln('    git rebase --abort');=0A=
        ExitCode :=3D 1;=0A=
      end=0A=
      else=0A=
      begin=0A=
        Writeln('----------------------------------------');=0A=
        Writeln('Rebase failed with unexpected exit code: ' + IntToStr(vReb=
aseStatus));=0A=
        ExitCode :=3D 1;=0A=
      end;=0A=
    finally=0A=
      vOutput.Free;=0A=
    end;=0A=
=0A=
  except=0A=
    on E: Exception do=0A=
    begin=0A=
      Writeln(E.ClassName, ': ', E.Message);=0A=
      ExitCode :=3D 1;=0A=
    end;=0A=
  end;=0A=
end.=0A=
=0A=
=0A=
=0A=
Bye for now,=0A=
  Skybuck Flying=0A=
skybuck2000@hotmail.com=
