Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010020.outbound.protection.outlook.com [52.103.32.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060382367C1
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496577; cv=fail; b=qJGLtwPGOiRkx0Dp9XRiHfVI7ZvCjDHSlSGK6KOS+0ZMxg6bQ6f7z05YjuGn7Dc9Q+noXjhj701igq7RA2yBZUnhuErySQqbffpr6jYfdLOx+zTKQN/vuSGHAxxbpOlaT6iuJmlFbrix+kCIPrPTd70Ha9jWhXlhqom459cCdR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496577; c=relaxed/simple;
	bh=MTjrCkZM057jnnSU/sK93vYltTUrMiem4f2V1tEadF8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t1NEHqeup26y9Yl6sQk7FvCBojXYwlbiQM3ToodvgY4TVPR/Nf4vz33ubCwumrpFS616sYvYPgcOU2pz5nNPjwiUrjekY1qgmarGFQECJmacxp6mkGU0i3j5DItmSQM6ymspd2MoxFeUz7rcKQUk0yBuaet0oeQctmQ7deEyx6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=V3zf3WQf; arc=fail smtp.client-ip=52.103.32.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="V3zf3WQf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfWoZNfYwwu8JK9Zvk6rLBM8tfYJ4Ko4Rebb0j1sxfQ4AbmuMD6oyqFH0/sil6NZ1nRlcveoWbEMWqDW5pFNhZYsCc1hRJo9IUW1Mb9S78FQWLjo0Q92HQQV7lUj7s+9yb0nAe2aax+S1aRtpuy9J0CEjZEJ1fFclXQXUZpIJ8ZWxtnJsbewG9DOHxtd2pXdAL03EYUYVgxeAIQil8rv8oHC+uwCM34yNDB/7q7twxh39w9yWf3gnnGtctcWorLeekTJnzaY9RFqGiWaSekWepSsc5+Y2ei6jM0YiC0ImxGenb4gBRanpSpG256NKgD0fkXJtaXjLfi+3dCwOe+4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtK+twHakAlvZcfMa/g27NKJ6CNhahnDOkTMGTMo8GE=;
 b=ZyWPdO6hEhaX5IvTkxcmXYWaYprXJIXyGgoQv6pVJhF4fMvzfO5f/bxlbjIeVxg8KdJqBbxfw7U+8mRy8Jiq5SvhK/Ttals1C+wqS58XHvcN8hpScOJTR9crhBEH0p0xG+ruu/oR29S3y8iCKbfLvTorUIOfAE9xsTqQlTOwMrS8Sfz5TLr0nFEIAyV1GwChFPYNe9ZFP6FaxyhjZSmriUXjiANCcs8ZAbpjCZObqFwymLmI/WmIPDXHjo8PvScqTkxVP7XuiyWcfy2Up434LivWrYzDqPMy6PnBEovMq1GhOLl/iSHQHQotMFYuhdtFKS2n0ZZuksmoTD1wjonVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtK+twHakAlvZcfMa/g27NKJ6CNhahnDOkTMGTMo8GE=;
 b=V3zf3WQfw5QE7JburvC1MyRAZPAKzRNe5g1gnSq3BIRjl5uRm8vocqV+ohobj9ivqyXERyOcvYpzeWBmgG1zWHj/eozBiFm0E8WdLewDLnMV+sUy5f+bjolSNQrB+B2PaJiLhi91cwWMfrCRWx9acnWa3byXV7zWcx7AHLg7P0qizDotf7z7BtP+EIR3iMRwb4bo+8saWR0ARJStCKrJ6j5no9FmdRjPULYzOeu2uITjd5W2oduwe3mAv9qlG5dum1o4warUoKRSuoB7bGQPQEaoHjNdUAP5LLEcYP9NUhwqSFRguM3ddCvsGy6I2pjJfmbOL2l2sqiVOjHSL0w4gg==
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com (2603:10a6:803:82::29)
 by DBAPR02MB6439.eurprd02.prod.outlook.com (2603:10a6:10:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Fri, 29 Aug
 2025 19:42:51 +0000
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f]) by VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f%6]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 19:42:51 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Was "Re: [RFC] Proposed Git Workflow for Permanent History, Explicit
 Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Topic: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Index: AQHcGR0afBR4UVFtH0y7jlWzQ0OEhA==
Date: Fri, 29 Aug 2025 19:42:51 +0000
Message-ID:
 <VI1PR02MB42713B3BBD5802512B5FC9FBB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com>
References:
 <DB7PR02MB4265BF28A39C7BD3DB097E1CB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265499C1103242CB482B407B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265CDBD131FB755B0799B2FB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB42655790BB6E1EF589B7D173B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265DDA928244F526CF1EF4AB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265527016FB04A500FBE321B35BA@DB7PR02MB4265.eurprd02.prod.outlook.com>
In-Reply-To:
 <DB7PR02MB4265527016FB04A500FBE321B35BA@DB7PR02MB4265.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB4271:EE_|DBAPR02MB6439:EE_
x-ms-office365-filtering-correlation-id: 542030f5-ad6c-4498-8d9d-08dde7343d6a
x-ms-exchange-slblob-mailprops:
 HeyTOiyEx6bPi+jhwMr1wenxQ6bSrWi9g/6Ce1bPVRbwK1HkQ+/wDv3TPZb/OGLULD/xhl4djwW23B3XMy8V7Ovi7BiVhsuohPnyzoQHY14pn6uCCvv3YygBCv8xvHindA4Rq1m7cFjdUh3WX94dMd3F39U42gpTxdabclrtu85A03vBYRgdfUyL2R29Rk3nGA/QbSZLHkLuk8yWxme3UnHR7vlFQSEXeSJswz1QiohPpb6kZOD5xyBF9+qMB02jKoMRTyHCp/TMyRegfrq/d1bCO+pgW6MT1vERMwigBVYpPZ3QxzcKGVMMQbokXRZlR6Mi8QQuf0w3bBq8G3NlzNcjvdZY4VLkJGbkBGNUU9WqTD5eGnS/MKBfqIbLcOpD5zxSfBfvOq2SMwZfeMRFnEYPRcCsMIDsm2PglWZLjeTYAR152EY4nVpfCLrRWrInWJrEzvvKuPkMjhvXnqXbxQ4H+zChTqDHDUtsMfxTMiZ0zf3Rd2yd9+StouE9iadqf7RwVvJrmuJqDe3c16/21L3GadGtTzrMq2AO1bNpoXUShQw5/VOJngKmzCi1qpijdul63B6WvIFM4Xpu3/9S677lBbvvNXaFtvfTJXoVS7uGVwRmDSirk/M2WO5cELLxCYadJEQ4WHkUYnjpG6n8DbWMFIzVYXrRNcBV8B4mLx0DHxAKqP8nktuKCh4+vUHV5r48P2M+auEqsElghmNS3aeXeqHX0NmwthNH8wF1u+BFatR7pRIkAwqGY9+VehGIhFNekQvMPkOROjN88g3aRA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|15030799006|31061999003|15080799012|461199028|8060799015|8062599012|102099032|13041999003|40105399003|440099028|3412199025|12091999003|26104999006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xSMPce7w4k8FtTAYgNqzF/OhAJKjlPfj0W4THstNQFDrv0VQsupMjefmla?=
 =?iso-8859-1?Q?+yAf8m8g3AAzhPPv1QJaTyC4CMblpaAIn3B9oNkLF1RdIx5fu4NVDFFBOO?=
 =?iso-8859-1?Q?X1N/T/CXkQ5STqgkANy+uDwSOLlViPBPalJ2ctMcJG6K8nS+x1nAfIzbZi?=
 =?iso-8859-1?Q?pG8yS/YA5isrNLm14m5Hvxucu29T5LNlFo7iXwJdSQemMhDwI3Ib0qG+Fy?=
 =?iso-8859-1?Q?q9iEJormuYLvhuAkMBQelnpAoOzoZtciDNMEsYg6bkzLBLdp4yTP25HdKO?=
 =?iso-8859-1?Q?jaqlxwyipa13MUHd9wHTXY6m+csiiMasCI7+h2sa0vC3yaKp7txkYl3Vk7?=
 =?iso-8859-1?Q?x2gLeWOpXkv+iSztzAmfqClejsStTvfMbx7842Y6TSnJW7zjo2k/J2Wywo?=
 =?iso-8859-1?Q?b9dg4UIJ+hY5doqsmzHYi4R6pYMDxVQuNg8GsAftWibRYoVeMMLYH7XIUH?=
 =?iso-8859-1?Q?z42+x4uYkYDN7xA07Z/iCZ9ipGmZ4DYb36w4ma6CtoMoE/3cuqVuKZqH8g?=
 =?iso-8859-1?Q?w4m7dzhMNHpMEhDQHRhGM1IZOKXv4AYGdhHoXei9Jwt4G5IRok9/FSX7iE?=
 =?iso-8859-1?Q?2MQc4+nSGfIz6LhKGsfvtp3MJka36FOyLZ8NDpcBnFAJcMlcvsr/6Nz4L7?=
 =?iso-8859-1?Q?GfvowjwEEmcFKMWKDWjiBRVGTGFlb6WnsanRRoFHBQJ/tTu27m3/N3bwDR?=
 =?iso-8859-1?Q?lbBuQLTqpomBRkf9zGd0tTOHzhsNppTVg+2uW3fsw55r/0VXFzYzYefzSP?=
 =?iso-8859-1?Q?MinJn/Br/Z0b3Po3l75QjPHL1wWoUmV4Q/ppeAr6BjAZt0Ewu0IOUpNX8u?=
 =?iso-8859-1?Q?4BPheqCpAzAAjQMZX78hSvU7Q+8Qd2PqpwZwtQCWFpPl7cLL+Rn6rzJxyP?=
 =?iso-8859-1?Q?DNWD8+AHTm9uP1rXpnGTgF2r1i1BMJFrxG5pweYcdrpC/lMUzh2qDr36VT?=
 =?iso-8859-1?Q?1Y1TMA0tZBKBTor+xbdfv71x98Oj+PaMAHwliPvRYUYTqpBYMUlf4jEY65?=
 =?iso-8859-1?Q?nCqRQ/OK7TNZeTd28DZs2KvK4cWIeXDIbevFeCZ6wV/hGOD2wFQwvzTJz4?=
 =?iso-8859-1?Q?Aml7lc7xsbBiedYzNVfkfddwng4JoQlIhhwow07wdQbQmuO5CFiIBLMLsG?=
 =?iso-8859-1?Q?9GTWLW26MtEbka858Ly0tOkA/cEiWqrtqCVRoUauoYf+hDFU8KWxFhVpQO?=
 =?iso-8859-1?Q?J8KsTlUB4Gj91RW7xlw9zmBY7rKqqmdUnI4HunweK8FqVG7il7jxSjbJVU?=
 =?iso-8859-1?Q?uMFsLzrQRxzWtqkd6S8m6DTDgTViP75/CJsevRbhkiHDAo/9zq6wrTUQei?=
 =?iso-8859-1?Q?LZzEEWdfM614aY+NQmsTf/4EGQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5L8dhe2ktuIkthxMixBHS8JLpjUKs0jiNusb47T/IpQU9ZnIi7YbaIJXp5?=
 =?iso-8859-1?Q?VVxejaEaP23d3Nt/A2ehli9wfgyaYuPrfZ2skzQCLb1OownxfY5WoHbZ1I?=
 =?iso-8859-1?Q?jbNQEOto9rmmPSDSqWso9qZBHtrbKbj1pw8iKrUNAo9FXw80bjWrHhaWFS?=
 =?iso-8859-1?Q?tgPdlNjqD0/Fak9DCBqeZyvlw1FlGhkGQRTPi67o47jSAylZIl/v+B9LGc?=
 =?iso-8859-1?Q?Zr2LnroT0lF0y0MiffpUNVSqFoQXIW8K1R4Ds2A8SVTIZ7hEcV3+U4vNFz?=
 =?iso-8859-1?Q?Hk2lQ3hlh0o7JAfAtzrXaWE/4acvmiUZViIMzRZQT2OBDX3dIR9s5RoVH9?=
 =?iso-8859-1?Q?yHpzPcuDTKm3zcsL4fNvJEbSEQR25OucZGXVHAVyBZ8q9qyDylrXy6HT1+?=
 =?iso-8859-1?Q?DUHXawpzLs/WCVSza69ad6S3UulXRxtg2j7pTbNbTzFkZtoOrEd2GibCb9?=
 =?iso-8859-1?Q?ZFId/MYI9yuoFIhKHFVH2MfPm8/0rYpsfQ9WO7GUQVIXqYt4KAp1w4CP21?=
 =?iso-8859-1?Q?1HrIPZqCBA9TXb1CvgVjbWUUWo1aCWwa1tuVeTarq6KbnHB4feOBp2uhxG?=
 =?iso-8859-1?Q?Y9CPDS501nlOFgcUEGyYFffZEc/UDDmch+vB5cJMh67XMLMBywzUvkqDxy?=
 =?iso-8859-1?Q?UqRUkCjjV5mZu4Ocp89x3rtNiqDmhce/SUfVmBw9781WKBrgksFdrXOlF2?=
 =?iso-8859-1?Q?9udh8/PNWL40jf5Cw3VwG0STTL+AJMp5mxrO3T6N2OmSt1Gvb+kdQOWgde?=
 =?iso-8859-1?Q?hQe9WCulTdpYSXo/yjan1tWLLSOeET4VxnfRN6IV1tXvTX/lQ9xN1eduk9?=
 =?iso-8859-1?Q?Q/ntQsNkVsElVI86GUMEl/+7UrPUrWW5ziLDZ/ULm+WZYJVWmOqbtJ6o30?=
 =?iso-8859-1?Q?yLp9qSWreor9m+Odkhm46zwoCreJXKcToX0LH1dL1JnoOHSaYfhdtiN9mj?=
 =?iso-8859-1?Q?faVeJU8nQZIC6w0acRr8zWZ9OMSIqTfX/a8TFJyXevpX/Sta5FRDz3TmJF?=
 =?iso-8859-1?Q?pWPB/SdVc5QT2PrdsKsil4n26i3kfT0DK8qxkbq9iTi/9t1pAX7/LBKFHJ?=
 =?iso-8859-1?Q?LRKpfLQCKegxYHW3RD6eF06PYQWxPQCIaCVcUE0skjNcIgpcXhi2DTox66?=
 =?iso-8859-1?Q?mPWeMrZcRje4fF52G6yw9roiD0Uh9HhZPlD7e6aiisRuf9p62d2XliT/T8?=
 =?iso-8859-1?Q?N/JwdXn6IggwntHCplFHes9TLTZxqv3c/WDkncFSuote1oY6BPBdxmvhFN?=
 =?iso-8859-1?Q?4qjHUZP5snf2R5/qfq+voXBYN8BdX2yTkR/y+kB/mAYBFZN6paDt6UWmbN?=
 =?iso-8859-1?Q?P52o2pr+kVtuQkYZqhuHZZ1XGobkDqEP1gm0sNSr5s4WoNA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4271.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 542030f5-ad6c-4498-8d9d-08dde7343d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 19:42:51.1172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6439

Version 0.08 of Skybuck's Gitflow is now available, all source code below:=
=0A=
=0A=
Save program 1 as "git-back-to.dpr":=0A=
=0A=
program git_back_to;=0A=
=0A=
{=0A=
=0A=
Skybuck's GitFlow=0A=
=0A=
version 0.08 created on 29 august 2025 by Skybuck Flying and Gemini (AI) an=
d Co-Pilot (AI).=0A=
=0A=
credits:=0A=
=0A=
Almost all code by Google Gemini 2.5 Pro.=0A=
GetBranchVersionDigits code by Microsoft Co-Pilot.=0A=
Software Idea and Prompting and Overwatching the AI: Skybuck Flying.=0A=
=0A=
improvements for version 0.08:=0A=
+ local git support=0A=
+ better contribution number=0A=
=0A=
Delphi code developed for Delphi 12.3 and Windows 11.=0A=
=0A=
}=0A=
=0A=
{$APPTYPE CONSOLE}=0A=
=0A=
uses=0A=
	System.SysUtils,=0A=
	System.Classes,=0A=
	System.RegularExpressions,=0A=
	System.IOUtils,=0A=
	Winapi.Windows,=0A=
	ActiveX,=0A=
	MSXML;=0A=
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
	begin=0A=
		Exit;=0A=
	end;=0A=
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
		if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, PI=
) then=0A=
		begin=0A=
			Exit;=0A=
		end;=0A=
=0A=
		CloseHandle(hWrite);=0A=
=0A=
		try=0A=
			while True do=0A=
			begin=0A=
				if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) or (=
BytesRead =3D 0) then=0A=
				begin=0A=
					break;=0A=
				end;=0A=
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
function GetBranchVersionDigits: Integer;=0A=
var=0A=
	XMLDoc: IXMLDOMDocument2;=0A=
	Node: IXMLDOMNode;=0A=
	ConfigPath: string;=0A=
	CoInitResult: HRESULT;=0A=
begin=0A=
	Result :=3D 4; // Default value=0A=
	ConfigPath :=3D ExtractFilePath(ParamStr(0)) + 'SkybuckGitflow.cfg';=0A=
=0A=
	if FileExists(ConfigPath) then=0A=
	begin=0A=
		// Initialize COM for this thread=0A=
		CoInitResult :=3D CoInitialize(nil);=0A=
		try=0A=
			try=0A=
				XMLDoc :=3D CoDOMDocument60.Create;=0A=
				if not Assigned(XMLDoc) then=0A=
				begin=0A=
					raise Exception.Create('Failed to create MSXML 6.0 document');=0A=
				end;=0A=
=0A=
				XMLDoc.async :=3D False;=0A=
				if not XMLDoc.load(ConfigPath) then=0A=
				begin=0A=
					// Check for a parse error object before accessing its properties=0A=
					if Assigned(XMLDoc.parseError) then=0A=
					begin=0A=
						raise Exception.Create('XML load failed: ' + XMLDoc.parseError.reason=
)=0A=
					end=0A=
					else=0A=
					begin=0A=
						raise Exception.Create('XML load failed with an unknown error.');=0A=
					end;=0A=
				end;=0A=
=0A=
				Node :=3D XMLDoc.selectSingleNode('//BranchVersionDigits');=0A=
				if Assigned(Node) then=0A=
				begin=0A=
					Result :=3D StrToIntDef(Node.text, 4);=0A=
				end;=0A=
			except=0A=
				on E: Exception do=0A=
				begin=0A=
					Writeln('Error processing config file: ', E.Message);=0A=
				end;=0A=
			end;=0A=
		finally=0A=
			// *** THE FIX IS HERE ***=0A=
			// Release COM objects BEFORE CoUninitialize is called.=0A=
			Node :=3D nil;=0A=
			XMLDoc :=3D nil;=0A=
=0A=
			// Uninitialize COM only if it was successfully initialized on this call=
.=0A=
			if SUCCEEDED(CoInitResult) then // Use SUCCEEDED for robustness=0A=
			begin=0A=
				CoUninitialize;=0A=
			end;=0A=
		end;=0A=
	end;=0A=
end;=0A=
=0A=
function RemoteOriginExists: boolean;=0A=
var=0A=
	Output: TStringList;=0A=
begin=0A=
	Output :=3D TStringList.Create;=0A=
	try=0A=
		Result :=3D ExecuteCommand('git remote get-url origin > NUL 2>&1', Output=
) =3D 0;=0A=
	finally=0A=
		Output.Free;=0A=
	end;=0A=
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
			begin=0A=
				Result :=3D Trim(Output.Text);=0A=
			end;=0A=
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
	begin=0A=
		Result :=3D Copy(Result, 1, 50);=0A=
	end;=0A=
end;=0A=
=0A=
function GetNextContributionNumber(const UserPrefix: string; ParaRemoteExis=
ts: boolean): Integer;=0A=
var=0A=
	Output: TStringList;=0A=
	MaxNum: Integer;=0A=
	Match: TMatch;=0A=
	Num: Integer;=0A=
	S, vRefs: string;=0A=
begin=0A=
	MaxNum :=3D 0;=0A=
	Output :=3D TStringList.Create;=0A=
	try=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			ExecuteCommand('git fetch origin --prune', Output); // Sync with remote=
=0A=
			Output.Clear;=0A=
			vRefs :=3D 'refs/heads refs/remotes/origin';=0A=
		end=0A=
		else=0A=
		begin=0A=
			vRefs :=3D 'refs/heads';=0A=
		end;=0A=
=0A=
		if ExecuteCommand('git for-each-ref --format=3D"%(refname:short)" ' + vRe=
fs, Output) =3D 0 then=0A=
		begin=0A=
			S :=3D Output.Text;=0A=
			for Match in TRegEx.Matches(S, '^' + UserPrefix + 'Contribution(\d+)-') =
do=0A=
			begin=0A=
				if Match.Success then=0A=
				begin=0A=
					Num :=3D StrToIntDef(Match.Groups[1].Value, 0);=0A=
					if Num > MaxNum then=0A=
					begin=0A=
						MaxNum :=3D Num;=0A=
					end;=0A=
				end;=0A=
			end;=0A=
		end;=0A=
	finally=0A=
		Output.Free;=0A=
	end;=0A=
	Result :=3D MaxNum + 1;=0A=
end;=0A=
=0A=
function TagExists(const ParaTagName: string; ParaRemoteExists: boolean): b=
oolean;=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	Result :=3D False;=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git show-ref --verify "refs/tags/' + ParaTagName + '"'=
, vOutput) =3D 0 then=0A=
		begin=0A=
			Result :=3D True;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git ls-remote --tags origin "refs/tags/' + ParaTagNam=
e + '"', vOutput) =3D 0 then=0A=
			begin=0A=
				Result :=3D vOutput.Text <> '';=0A=
			end;=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
end;=0A=
=0A=
function BranchExists(const ParaBranchName: string; ParaRemoteExists: boole=
an): boolean;=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	Result :=3D False;=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git show-ref --verify "refs/heads/' + ParaBranchName +=
 '"', vOutput) =3D 0 then=0A=
		begin=0A=
			Result :=3D True;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git show-ref --verify "refs/remotes/origin/' + ParaBr=
anchName + '"', vOutput) =3D 0 then=0A=
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
	vOldTagName, vDescription, vUserPrefix, vSlug, vNewBranchName, vFormatStr:=
 string;=0A=
	vNextNum, vBranchVersionDigits: Integer;=0A=
	vOutput: TStringList;=0A=
	vRemoteExists: Boolean;=0A=
begin=0A=
	try=0A=
		vBranchVersionDigits :=3D GetBranchVersionDigits;=0A=
=0A=
		if ParamCount <> 2 then=0A=
		begin=0A=
			Writeln('Usage: git-back-to <tagname_of_old_commit> "<new_branch_descrip=
tion>"');=0A=
			Writeln('Example: git-back-to merged/AI0001Contribution007-OldAPIDesign =
"Re-evaluate V1 API for performance"');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vOldTagName :=3D ParamStr(1);=0A=
		vDescription :=3D ParamStr(2);=0A=
=0A=
		vRemoteExists :=3D RemoteOriginExists;=0A=
=0A=
		vUserPrefix :=3D GetGitConfigValue('user.contributionPrefix');=0A=
		if vUserPrefix =3D '' then=0A=
		begin=0A=
			vUserPrefix :=3D GetGitConfigValue('user.name');=0A=
			if vUserPrefix <> '' then=0A=
			begin=0A=
				vUserPrefix :=3D TRegEx.Replace(vUserPrefix, '[^a-zA-Z0-9]', '');=0A=
			end=0A=
			else=0A=
			begin=0A=
				Writeln('Error: Git user.name or user.contributionPrefix not set.');=0A=
				Writeln('Run: git config --global user.name "Your Name"');=0A=
				Writeln('Or: git config --global user.contributionPrefix "YourPrefix"')=
;=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
		end;=0A=
=0A=
		vSlug :=3D Slugify(vDescription);=0A=
		if vSlug =3D '' then=0A=
		begin=0A=
			Writeln('Error: Description resulted in empty slug.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		if not TagExists(vOldTagName, vRemoteExists) then=0A=
		begin=0A=
			Writeln('Error: Tag ''' + vOldTagName + ''' does not exist locally or re=
motely.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vNextNum :=3D GetNextContributionNumber(vUserPrefix, vRemoteExists);=0A=
		vFormatStr :=3D Format('%%sContribution%%0.%dd-%%s', [vBranchVersionDigit=
s]);=0A=
		vNewBranchName :=3D Format(vFormatStr, [vUserPrefix, vNextNum, vSlug]);=
=0A=
=0A=
		if BranchExists(vNewBranchName, vRemoteExists) then=0A=
		begin=0A=
			Writeln('Error: Branch ''' + vNewBranchName + ''' already exists.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vOutput :=3D TStringList.Create;=0A=
		try=0A=
			Writeln('Creating new branch ''' + vNewBranchName + ''' from tag ''' + v=
OldTagName + '''...');=0A=
			if ExecuteCommand('git checkout -b "' + vNewBranchName + '" "' + vOldTag=
Name + '"', vOutput) <> 0 then=0A=
			begin=0A=
				Writeln('Error: Failed to create branch from tag.');=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
			if vRemoteExists then=0A=
			begin=0A=
				Writeln('Pushing ''' + vNewBranchName + ''' to remote...');=0A=
				if ExecuteCommand('git push -u origin "' + vNewBranchName + '"', vOutpu=
t) <> 0 then=0A=
				begin=0A=
					Writeln('Error: Failed to push branch to origin.');=0A=
					ExitCode :=3D 1;=0A=
					Exit;=0A=
				end;=0A=
				vOutput.Clear;=0A=
			end;=0A=
=0A=
			Writeln('---');=0A=
			Writeln('Calling git-set-active to mark as active...');=0A=
			if ExecuteCommand('cmd.exe /c "' + ExtractFilePath(ParamStr(0)) + 'git-s=
et-active.exe" ' + vNewBranchName, vOutput) <> 0 then=0A=
			begin=0A=
				Writeln('Warning: Could not mark branch active. Run manually: git-set-a=
ctive ' + vNewBranchName);=0A=
			end;=0A=
			Writeln(vOutput.Text);=0A=
		finally=0A=
			vOutput.Free;=0A=
		end;=0A=
=0A=
		Writeln('');=0A=
		Writeln('Branch ''' + vNewBranchName + ''' successfully created and activ=
ated from tag ''' + vOldTagName + '''.');=0A=
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
Save program 2 as "git-new-contribution.dpr":=0A=
=0A=
program git_new_contribution;=0A=
=0A=
{=0A=
=0A=
Skybuck's GitFlow=0A=
=0A=
version 0.08 created on 29 august 2025 by Skybuck Flying and Gemini (AI) an=
d Co-Pilot (AI).=0A=
=0A=
credits:=0A=
=0A=
Almost all code by Google Gemini 2.5 Pro.=0A=
GetBranchVersionDigits code by Microsoft Co-Pilot.=0A=
Software Idea and Prompting and Overwatching the AI: Skybuck Flying.=0A=
=0A=
improvements for version 0.08:=0A=
+ local git support=0A=
+ better contribution number=0A=
=0A=
Delphi code developed for Delphi 12.3 and Windows 11.=0A=
=0A=
}=0A=
=0A=
{$APPTYPE CONSOLE}=0A=
=0A=
uses=0A=
	System.SysUtils,=0A=
	System.Classes,=0A=
	System.RegularExpressions,=0A=
	System.IOUtils,=0A=
	Winapi.Windows,=0A=
	ActiveX,=0A=
	MSXML;=0A=
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
function GetBranchVersionDigits: Integer;=0A=
var=0A=
	XMLDoc: IXMLDOMDocument2;=0A=
	Node: IXMLDOMNode;=0A=
	ConfigPath: string;=0A=
	CoInitResult: HRESULT;=0A=
begin=0A=
	Result :=3D 4; // Default value=0A=
	ConfigPath :=3D ExtractFilePath(ParamStr(0)) + 'SkybuckGitflow.cfg';=0A=
=0A=
	if FileExists(ConfigPath) then=0A=
	begin=0A=
		// Initialize COM for this thread=0A=
		CoInitResult :=3D CoInitialize(nil);=0A=
		try=0A=
			try=0A=
				XMLDoc :=3D CoDOMDocument60.Create;=0A=
				if not Assigned(XMLDoc) then=0A=
				begin=0A=
					raise Exception.Create('Failed to create MSXML 6.0 document');=0A=
				end;=0A=
=0A=
				XMLDoc.async :=3D False;=0A=
				if not XMLDoc.load(ConfigPath) then=0A=
				begin=0A=
					// Check for a parse error object before accessing its properties=0A=
					if Assigned(XMLDoc.parseError) then=0A=
					begin=0A=
						raise Exception.Create('XML load failed: ' + XMLDoc.parseError.reason=
)=0A=
					end=0A=
					else=0A=
					begin=0A=
						raise Exception.Create('XML load failed with an unknown error.');=0A=
					end;=0A=
				end;=0A=
=0A=
				Node :=3D XMLDoc.selectSingleNode('//BranchVersionDigits');=0A=
				if Assigned(Node) then=0A=
				begin=0A=
					Result :=3D Abs(StrToIntDef(Node.text, 4));=0A=
				end;=0A=
			except=0A=
				on E: Exception do=0A=
				begin=0A=
					Writeln('Error processing config file: ', E.Message);=0A=
				end;=0A=
			end;=0A=
		finally=0A=
			// *** THE FIX IS HERE ***=0A=
			// Release COM objects BEFORE CoUninitialize is called.=0A=
			Node :=3D nil;=0A=
			XMLDoc :=3D nil;=0A=
=0A=
			// Uninitialize COM only if it was successfully initialized on this call=
.=0A=
			if SUCCEEDED(CoInitResult) then // Use SUCCEEDED for robustness=0A=
			begin=0A=
				CoUninitialize;=0A=
			end;=0A=
		end;=0A=
	end;=0A=
end;=0A=
=0A=
function RemoteOriginExists: boolean;=0A=
var=0A=
	Output: TStringList;=0A=
begin=0A=
	Output :=3D TStringList.Create;=0A=
	try=0A=
		Result :=3D ExecuteCommand('git remote get-url origin > NUL 2>&1', Output=
) =3D 0;=0A=
	finally=0A=
		Output.Free;=0A=
	end;=0A=
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
function GetNextContributionNumber( const ParaUserPrefix : string; ParaRemo=
teExists: boolean ) : Integer;=0A=
var=0A=
	vOutput : TStringList;=0A=
	vMaxNum : Integer;=0A=
	vMatch : TMatch;=0A=
	vNum : Integer;=0A=
	vS, vRefs: string;=0A=
	vRegex: TRegEx;=0A=
begin=0A=
	vMaxNum :=3D 0;=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			ExecuteCommand('git fetch origin --prune', vOutput); // Sync with remote=
=0A=
			vOutput.Clear;=0A=
			vRefs :=3D 'refs/heads refs/remotes/origin';=0A=
		end=0A=
		else=0A=
		begin=0A=
			vRefs :=3D 'refs/heads';=0A=
		end;=0A=
=0A=
		if ExecuteCommand('git for-each-ref --format=3D"%(refname:short)" ' + vRe=
fs, vOutput) =3D 0 then=0A=
		begin=0A=
			vS :=3D vOutput.Text;=0A=
			vRegex :=3D TRegEx.Create('^' + ParaUserPrefix + 'Contribution(\d+)-', [=
roMultiLine]);=0A=
			for vMatch in vRegex.Matches(vS) do=0A=
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
	vUserPrefix, vDescription, vSlug, vNewBranchName, vFormatStr : string;=0A=
	vNextNum, vBranchVersionDigits : Integer;=0A=
	vOutput : TStringList;=0A=
	vRemoteExists: Boolean;=0A=
begin=0A=
	try=0A=
		vBranchVersionDigits :=3D GetBranchVersionDigits;=0A=
=0A=
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
		if vUserPrefix =3D '' then=0A=
		begin=0A=
			vUserPrefix :=3D GetGitConfigValue('user.contributionPrefix');=0A=
			if vUserPrefix =3D '' then=0A=
			begin=0A=
				vUserPrefix :=3D GetGitConfigValue('user.name');=0A=
				if vUserPrefix <> '' then=0A=
				begin=0A=
					vUserPrefix :=3D TRegEx.Replace(vUserPrefix, '[^a-zA-Z0-9]', '');=0A=
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
			vRemoteExists :=3D RemoteOriginExists;=0A=
=0A=
			Writeln('Switching to master branch...');=0A=
			if ExecuteCommand('git checkout master', vOutput) <> 0 then=0A=
			begin=0A=
				Writeln('Error: Failed to checkout master.');=0A=
				Writeln(vOutput.Text);=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
			if vRemoteExists then=0A=
			begin=0A=
				Writeln('Fetching latest master...');=0A=
				if ExecuteCommand('git pull origin master', vOutput) <> 0 then=0A=
				begin=0A=
					Writeln('Warning: Failed to pull latest master. Proceeding with local =
master.');=0A=
					Writeln(vOutput.Text);=0A=
				end;=0A=
				vOutput.Clear;=0A=
			end;=0A=
=0A=
			vNextNum :=3D GetNextContributionNumber(vUserPrefix, vRemoteExists);=0A=
			vFormatStr :=3D Format('%%sContribution%%0.%dd-%%s', [vBranchVersionDigi=
ts]);=0A=
			vNewBranchName :=3D Format(vFormatStr, [vUserPrefix, vNextNum, vSlug]);=
=0A=
=0A=
			if ExecuteCommand('git show-ref --verify refs/heads/' + vNewBranchName, =
vOutput) =3D 0 then=0A=
			begin=0A=
				Writeln('Error: Local branch already exists.');=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
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
=0A=
			if vRemoteExists then=0A=
			begin=0A=
				Writeln('Pushing new branch to origin...');=0A=
				if ExecuteCommand('git push -u origin ' + vNewBranchName, vOutput) <> 0=
 then=0A=
				begin=0A=
					Writeln('Error: Failed to push new branch.');=0A=
					Writeln(vOutput.Text);=0A=
					ExitCode :=3D 1;=0A=
					Exit;=0A=
				end;=0A=
				vOutput.Clear;=0A=
			end;=0A=
=0A=
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
Save program 3 as "git-set-active.dpr":=0A=
=0A=
program git_set_active;=0A=
=0A=
{=0A=
=0A=
Skybuck's GitFlow=0A=
=0A=
version 0.08 created on 29 august 2025 by Skybuck Flying and Gemini (AI) an=
d Co-Pilot (AI).=0A=
=0A=
credits:=0A=
=0A=
Almost all code by Google Gemini 2.5 Pro.=0A=
GetBranchVersionDigits code by Microsoft Co-Pilot.=0A=
Software Idea and Prompting and Overwatching the AI: Skybuck Flying.=0A=
=0A=
improvements for version 0.08:=0A=
+ local git support=0A=
+ better contribution number=0A=
=0A=
Delphi code developed for Delphi 12.3 and Windows 11.=0A=
=0A=
}=0A=
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
	begin=0A=
		Exit;=0A=
	end;=0A=
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
		if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, PI=
) then=0A=
		begin=0A=
			Exit;=0A=
		end;=0A=
=0A=
		CloseHandle(hWrite);=0A=
=0A=
		try=0A=
			while True do=0A=
			begin=0A=
				if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) or (=
BytesRead =3D 0) then=0A=
				begin=0A=
					break;=0A=
				end;=0A=
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
function RemoteOriginExists: boolean;=0A=
var=0A=
	Output: TStringList;=0A=
begin=0A=
	Output :=3D TStringList.Create;=0A=
	try=0A=
		Result :=3D ExecuteCommand('git remote get-url origin > NUL 2>&1', Output=
) =3D 0;=0A=
	finally=0A=
		Output.Free;=0A=
	end;=0A=
end;=0A=
=0A=
function BranchExists(const ParaBranchName: string; ParaRemoteExists: boole=
an): boolean;=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	Result :=3D False;=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git show-ref --verify "refs/heads/' + ParaBranchName +=
 '"', vOutput) =3D 0 then=0A=
		begin=0A=
			Result :=3D True;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git show-ref --verify "refs/remotes/origin/' + ParaBr=
anchName + '"', vOutput) =3D 0 then=0A=
			begin=0A=
				Result :=3D True;=0A=
			end;=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
end;=0A=
=0A=
function GetBranchHash(const ParaBranchName: string; ParaRemoteExists: bool=
ean): string;=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	Result :=3D '';=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			if ExecuteCommand('git rev-parse "refs/remotes/origin/' + ParaBranchName=
 + '^{commit}"', vOutput) =3D 0 then=0A=
			begin=0A=
				Result :=3D Trim(vOutput.Text);=0A=
				if Result <> '' then=0A=
				begin=0A=
					Exit;=0A=
				end;=0A=
			end;=0A=
		end;=0A=
=0A=
		vOutput.Clear;=0A=
		if ExecuteCommand('git rev-parse "refs/heads/' + ParaBranchName + '^{comm=
it}"', vOutput) =3D 0 then=0A=
		begin=0A=
			Result :=3D Trim(vOutput.Text);=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
end;=0A=
=0A=
procedure DeleteTagIfExists(const ParaTagName: string; ParaRemoteExists: bo=
olean);=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git show-ref --verify "refs/tags/' + ParaTagName + '"'=
, vOutput) =3D 0 then=0A=
		begin=0A=
			Writeln('Removing existing local tag: ' + ParaTagName + '...');=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git tag -d "' + ParaTagName + '"', vOutput) <> 0 then=
=0A=
			begin=0A=
				Writeln('Warning: Failed to delete local tag ' + ParaTagName + '.');=0A=
			end;=0A=
		end;=0A=
=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git ls-remote --tags origin "refs/tags/' + ParaTagNam=
e + '"', vOutput) =3D 0 then=0A=
			begin=0A=
				if vOutput.Text <> '' then=0A=
				begin=0A=
					Writeln('Removing existing remote tag: ' + ParaTagName + '...');=0A=
					vOutput.Clear;=0A=
					if ExecuteCommand('git push origin --delete "' + ParaTagName + '"', vO=
utput) <> 0 then=0A=
					begin=0A=
						Writeln('Warning: Failed to delete remote tag ' + ParaTagName + '.');=
=0A=
					end;=0A=
				end;=0A=
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
	vRemoteExists: Boolean;=0A=
begin=0A=
	try=0A=
		if ParamCount <> 1 then=0A=
		begin=0A=
			Writeln('Usage: git-set-active <branchname>');=0A=
			Writeln('Example: git-set-active SkybuckContribution001-ImplementLogin')=
;=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vBranchName :=3D ParamStr(1);=0A=
		vActiveTag :=3D 'active/' + vBranchName;=0A=
		vRemoteExists :=3D RemoteOriginExists;=0A=
=0A=
		if not BranchExists(vBranchName, vRemoteExists) then=0A=
		begin=0A=
			Writeln('Error: Branch ''' + vBranchName + ''' not found locally or remo=
tely.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vBranchHash :=3D GetBranchHash(vBranchName, vRemoteExists);=0A=
		if vBranchHash =3D '' then=0A=
		begin=0A=
			Writeln('Error: Unable to determine commit hash for branch ''' + vBranch=
Name + '''.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		DeleteTagIfExists('merged/' + vBranchName, vRemoteExists);=0A=
		DeleteTagIfExists('rejected/' + vBranchName, vRemoteExists);=0A=
=0A=
		Writeln('Creating active tag: ' + vActiveTag);=0A=
		vOutput :=3D TStringList.Create;=0A=
		try=0A=
			if ExecuteCommand('git tag -f "' + vActiveTag + '" "' + vBranchHash + '"=
', vOutput) <> 0 then=0A=
			begin=0A=
				Writeln('Error: Failed to create tag ' + vActiveTag);=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
			if vRemoteExists then=0A=
			begin=0A=
				Writeln('Pushing active tag to origin...');=0A=
				if ExecuteCommand('git push -f origin "' + vActiveTag + '"', vOutput) <=
> 0 then=0A=
				begin=0A=
					Writeln('Error: Failed to push tag ' + vActiveTag + ' to origin');=0A=
					ExitCode :=3D 1;=0A=
					Exit;=0A=
				end;=0A=
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
Save program 4 as "git-set-merged.dpr":=0A=
=0A=
program git_set_merged;=0A=
=0A=
{=0A=
=0A=
Skybuck's GitFlow=0A=
=0A=
version 0.08 created on 29 august 2025 by Skybuck Flying and Gemini (AI) an=
d Co-Pilot (AI).=0A=
=0A=
credits:=0A=
=0A=
Almost all code by Google Gemini 2.5 Pro.=0A=
GetBranchVersionDigits code by Microsoft Co-Pilot.=0A=
Software Idea and Prompting and Overwatching the AI: Skybuck Flying.=0A=
=0A=
improvements for version 0.08:=0A=
+ local git support=0A=
+ better contribution number=0A=
=0A=
Delphi code developed for Delphi 12.3 and Windows 11.=0A=
=0A=
}=0A=
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
	begin=0A=
		Exit;=0A=
	end;=0A=
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
		if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, PI=
) then=0A=
		begin=0A=
			Exit;=0A=
		end;=0A=
=0A=
		CloseHandle(hWrite);=0A=
=0A=
		try=0A=
			while True do=0A=
			begin=0A=
				if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) or (=
BytesRead =3D 0) then=0A=
				begin=0A=
					break;=0A=
				end;=0A=
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
function RemoteOriginExists: boolean;=0A=
var=0A=
	Output: TStringList;=0A=
begin=0A=
	Output :=3D TStringList.Create;=0A=
	try=0A=
		Result :=3D ExecuteCommand('git remote get-url origin > NUL 2>&1', Output=
) =3D 0;=0A=
	finally=0A=
		Output.Free;=0A=
	end;=0A=
end;=0A=
=0A=
function BranchExists(const ParaBranchName: string; ParaRemoteExists: boole=
an): boolean;=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	Result :=3D False;=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git show-ref --verify "refs/heads/' + ParaBranchName +=
 '"', vOutput) =3D 0 then=0A=
		begin=0A=
			Result :=3D True;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git show-ref --verify "refs/remotes/origin/' + ParaBr=
anchName + '"', vOutput) =3D 0 then=0A=
			begin=0A=
				Result :=3D True;=0A=
			end;=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
end;=0A=
=0A=
function GetBranchHash(const ParaBranchName: string; ParaRemoteExists: bool=
ean): string;=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	Result :=3D '';=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			if ExecuteCommand('git rev-parse "refs/remotes/origin/' + ParaBranchName=
 + '^{commit}"', vOutput) =3D 0 then=0A=
			begin=0A=
				Result :=3D Trim(vOutput.Text);=0A=
				if Result <> '' then=0A=
				begin=0A=
					Exit;=0A=
				end;=0A=
			end;=0A=
		end;=0A=
=0A=
		vOutput.Clear;=0A=
		if ExecuteCommand('git rev-parse "refs/heads/' + ParaBranchName + '^{comm=
it}"', vOutput) =3D 0 then=0A=
		begin=0A=
			Result :=3D Trim(vOutput.Text);=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
end;=0A=
=0A=
procedure DeleteTagIfExists(const ParaTagName: string; ParaRemoteExists: bo=
olean);=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git show-ref --verify "refs/tags/' + ParaTagName + '"'=
, vOutput) =3D 0 then=0A=
		begin=0A=
			Writeln('Removing existing local tag: ' + ParaTagName + '...');=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git tag -d "' + ParaTagName + '"', vOutput) <> 0 then=
=0A=
			begin=0A=
				Writeln('Warning: Failed to delete local tag ' + ParaTagName + '.');=0A=
			end;=0A=
		end;=0A=
=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git ls-remote --tags origin "refs/tags/' + ParaTagNam=
e + '"', vOutput) =3D 0 then=0A=
			begin=0A=
				if vOutput.Text <> '' then=0A=
				begin=0A=
					Writeln('Removing existing remote tag: ' + ParaTagName + '...');=0A=
					vOutput.Clear;=0A=
					if ExecuteCommand('git push origin --delete "' + ParaTagName + '"', vO=
utput) <> 0 then=0A=
					begin=0A=
						Writeln('Warning: Failed to delete remote tag ' + ParaTagName + '.');=
=0A=
					end;=0A=
				end;=0A=
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
	vRemoteExists: Boolean;=0A=
begin=0A=
	try=0A=
		if ParamCount <> 1 then=0A=
		begin=0A=
			Writeln('Usage: git-set-merged <branchname>');=0A=
			Writeln('Example: git-set-merged SkybuckContribution001-MyFeature');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vBranchName :=3D ParamStr(1);=0A=
		vMergedTag :=3D 'merged/' + vBranchName;=0A=
		vRemoteExists :=3D RemoteOriginExists;=0A=
=0A=
		if not BranchExists(vBranchName, vRemoteExists) then=0A=
		begin=0A=
			Writeln('Error: Branch ''' + vBranchName + ''' does not exist locally or=
 remotely.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vBranchHash :=3D GetBranchHash(vBranchName, vRemoteExists);=0A=
		if vBranchHash =3D '' then=0A=
		begin=0A=
			Writeln('Error: Unable to determine commit hash for branch ''' + vBranch=
Name + '''.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		DeleteTagIfExists('active/' + vBranchName, vRemoteExists);=0A=
		DeleteTagIfExists('rejected/' + vBranchName, vRemoteExists);=0A=
=0A=
		Writeln('Creating merged tag: ' + vMergedTag);=0A=
		vOutput :=3D TStringList.Create;=0A=
		try=0A=
			if ExecuteCommand('git tag -f "' + vMergedTag + '" "' + vBranchHash + '"=
', vOutput) <> 0 then=0A=
			begin=0A=
				Writeln('Error: Failed to create tag ' + vMergedTag + '.');=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
			if vRemoteExists then=0A=
			begin=0A=
				Writeln('Pushing merged tag to origin...');=0A=
				if ExecuteCommand('git push -f origin "' + vMergedTag + '"', vOutput) <=
> 0 then=0A=
				begin=0A=
					Writeln('Error: Failed to push tag ' + vMergedTag + ' to origin.');=0A=
					ExitCode :=3D 1;=0A=
					Exit;=0A=
				end;=0A=
			end;=0A=
		finally=0A=
			vOutput.Free;=0A=
		end;=0A=
=0A=
		Writeln('');=0A=
		Writeln('Branch ' + vBranchName + ' successfully marked as MERGED.');=0A=
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
Save program 5 as "git-set-rejected.dpr":=0A=
=0A=
program git_set_rejected;=0A=
=0A=
{=0A=
=0A=
Skybuck's GitFlow=0A=
=0A=
version 0.08 created on 29 august 2025 by Skybuck Flying and Gemini (AI) an=
d Co-Pilot (AI).=0A=
=0A=
credits:=0A=
=0A=
Almost all code by Google Gemini 2.5 Pro.=0A=
GetBranchVersionDigits code by Microsoft Co-Pilot.=0A=
Software Idea and Prompting and Overwatching the AI: Skybuck Flying.=0A=
=0A=
improvements for version 0.08:=0A=
+ local git support=0A=
+ better contribution number=0A=
=0A=
Delphi code developed for Delphi 12.3 and Windows 11.=0A=
=0A=
}=0A=
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
	begin=0A=
		Exit;=0A=
	end;=0A=
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
		if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, PI=
) then=0A=
		begin=0A=
			Exit;=0A=
		end;=0A=
=0A=
		CloseHandle(hWrite);=0A=
=0A=
		try=0A=
			while True do=0A=
			begin=0A=
				if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) or (=
BytesRead =3D 0) then=0A=
				begin=0A=
					break;=0A=
				end;=0A=
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
function RemoteOriginExists: boolean;=0A=
var=0A=
	Output: TStringList;=0A=
begin=0A=
	Output :=3D TStringList.Create;=0A=
	try=0A=
		Result :=3D ExecuteCommand('git remote get-url origin > NUL 2>&1', Output=
) =3D 0;=0A=
	finally=0A=
		Output.Free;=0A=
	end;=0A=
end;=0A=
=0A=
function BranchExists(const ParaBranchName: string; ParaRemoteExists: boole=
an): boolean;=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	Result :=3D False;=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git show-ref --verify "refs/heads/' + ParaBranchName +=
 '"', vOutput) =3D 0 then=0A=
		begin=0A=
			Result :=3D True;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git show-ref --verify "refs/remotes/origin/' + ParaBr=
anchName + '"', vOutput) =3D 0 then=0A=
			begin=0A=
				Result :=3D True;=0A=
			end;=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
end;=0A=
=0A=
function GetBranchHash(const ParaBranchName: string; ParaRemoteExists: bool=
ean): string;=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	Result :=3D '';=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			if ExecuteCommand('git rev-parse "refs/remotes/origin/' + ParaBranchName=
 + '^{commit}"', vOutput) =3D 0 then=0A=
			begin=0A=
				Result :=3D Trim(vOutput.Text);=0A=
				if Result <> '' then=0A=
				begin=0A=
					Exit;=0A=
				end;=0A=
			end;=0A=
		end;=0A=
=0A=
		vOutput.Clear;=0A=
		if ExecuteCommand('git rev-parse "refs/heads/' + ParaBranchName + '^{comm=
it}"', vOutput) =3D 0 then=0A=
		begin=0A=
			Result :=3D Trim(vOutput.Text);=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
end;=0A=
=0A=
procedure DeleteTagIfExists(const ParaTagName: string; ParaRemoteExists: bo=
olean);=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git show-ref --verify "refs/tags/' + ParaTagName + '"'=
, vOutput) =3D 0 then=0A=
		begin=0A=
			Writeln('Removing existing local tag: ' + ParaTagName + '...');=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git tag -d "' + ParaTagName + '"', vOutput) <> 0 then=
=0A=
			begin=0A=
				Writeln('Warning: Failed to delete local tag ' + ParaTagName + '.');=0A=
			end;=0A=
		end;=0A=
=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git ls-remote --tags origin "refs/tags/' + ParaTagNam=
e + '"', vOutput) =3D 0 then=0A=
			begin=0A=
				if vOutput.Text <> '' then=0A=
				begin=0A=
					Writeln('Removing existing remote tag: ' + ParaTagName + '...');=0A=
					vOutput.Clear;=0A=
					if ExecuteCommand('git push origin --delete "' + ParaTagName + '"', vO=
utput) <> 0 then=0A=
					begin=0A=
						Writeln('Warning: Failed to delete remote tag ' + ParaTagName + '.');=
=0A=
					end;=0A=
				end;=0A=
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
	vRemoteExists: Boolean;=0A=
begin=0A=
	try=0A=
		if ParamCount <> 1 then=0A=
		begin=0A=
			Writeln('Usage: git-set-rejected <branchname>');=0A=
			Writeln('Example: git-set-rejected AI0001Contribution002-ExperimentalAlg=
orithm');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vBranchName :=3D ParamStr(1);=0A=
		vRejectedTag :=3D 'rejected/' + vBranchName;=0A=
		vRemoteExists :=3D RemoteOriginExists;=0A=
=0A=
		if not BranchExists(vBranchName, vRemoteExists) then=0A=
		begin=0A=
			Writeln('Error: Branch ''' + vBranchName + ''' does not exist locally or=
 remotely.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vBranchHash :=3D GetBranchHash(vBranchName, vRemoteExists);=0A=
		if vBranchHash =3D '' then=0A=
		begin=0A=
			Writeln('Error: Could not determine commit hash for branch ''' + vBranch=
Name + '''.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		DeleteTagIfExists('active/' + vBranchName, vRemoteExists);=0A=
		DeleteTagIfExists('merged/' + vBranchName, vRemoteExists);=0A=
=0A=
		Writeln('Creating rejected tag: ' + vRejectedTag);=0A=
		vOutput :=3D TStringList.Create;=0A=
		try=0A=
			if ExecuteCommand('git tag -f "' + vRejectedTag + '" "' + vBranchHash + =
'"', vOutput) <> 0 then=0A=
			begin=0A=
				Writeln('Error: Could not create tag ''' + vRejectedTag + '''');=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
			if vRemoteExists then=0A=
			begin=0A=
				Writeln('Pushing rejected tag to origin...');=0A=
				if ExecuteCommand('git push -f origin "' + vRejectedTag + '"', vOutput)=
 <> 0 then=0A=
				begin=0A=
					Writeln('Error: Could not push tag ''' + vRejectedTag + ''' to origin'=
);=0A=
					ExitCode :=3D 1;=0A=
					Exit;=0A=
				end;=0A=
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
Save program 6 as "git-set-revive.dpr":=0A=
=0A=
program git_set_revive;=0A=
=0A=
{=0A=
=0A=
Skybuck's GitFlow=0A=
=0A=
version 0.08 created on 29 august 2025 by Skybuck Flying and Gemini (AI) an=
d Co-Pilot (AI).=0A=
=0A=
credits:=0A=
=0A=
Almost all code by Google Gemini 2.5 Pro.=0A=
GetBranchVersionDigits code by Microsoft Co-Pilot.=0A=
Software Idea and Prompting and Overwatching the AI: Skybuck Flying.=0A=
=0A=
improvements for version 0.08:=0A=
+ local git support=0A=
+ better contribution number=0A=
=0A=
Delphi code developed for Delphi 12.3 and Windows 11.=0A=
=0A=
}=0A=
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
	begin=0A=
		Exit;=0A=
	end;=0A=
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
		if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, PI=
) then=0A=
		begin=0A=
			Exit;=0A=
		end;=0A=
=0A=
		CloseHandle(hWrite);=0A=
=0A=
		try=0A=
			while True do=0A=
			begin=0A=
				if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) or (=
BytesRead =3D 0) then=0A=
				begin=0A=
					break;=0A=
				end;=0A=
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
function RemoteOriginExists: boolean;=0A=
var=0A=
	Output: TStringList;=0A=
begin=0A=
	Output :=3D TStringList.Create;=0A=
	try=0A=
		Result :=3D ExecuteCommand('git remote get-url origin > NUL 2>&1', Output=
) =3D 0;=0A=
	finally=0A=
		Output.Free;=0A=
	end;=0A=
end;=0A=
=0A=
function BranchExists(const ParaBranchName: string; ParaRemoteExists: boole=
an): boolean;=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	Result :=3D False;=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git show-ref --verify "refs/heads/' + ParaBranchName +=
 '"', vOutput) =3D 0 then=0A=
		begin=0A=
			Result :=3D True;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git show-ref --verify "refs/remotes/origin/' + ParaBr=
anchName + '"', vOutput) =3D 0 then=0A=
			begin=0A=
				Result :=3D True;=0A=
			end;=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
end;=0A=
=0A=
function HasTag(const ParaTagName: string; ParaRemoteExists: boolean): bool=
ean;=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	Result :=3D False;=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git show-ref --verify "refs/tags/' + ParaTagName + '"'=
, vOutput) =3D 0 then=0A=
		begin=0A=
			Result :=3D True;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git ls-remote --tags origin "refs/tags/' + ParaTagNam=
e + '"', vOutput) =3D 0 then=0A=
			begin=0A=
				Result :=3D vOutput.Text <> '';=0A=
			end;=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
end;=0A=
=0A=
procedure DeleteTagIfExists(const ParaTagName: string; ParaRemoteExists: bo=
olean);=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git show-ref --verify "refs/tags/' + ParaTagName + '"'=
, vOutput) =3D 0 then=0A=
		begin=0A=
			Writeln('Removing existing local tag: ' + ParaTagName + '...');=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git tag -d "' + ParaTagName + '"', vOutput) <> 0 then=
=0A=
			begin=0A=
				Writeln('Warning: Failed to delete local tag ' + ParaTagName + '.');=0A=
			end;=0A=
		end;=0A=
=0A=
		if ParaRemoteExists then=0A=
		begin=0A=
			vOutput.Clear;=0A=
			if ExecuteCommand('git ls-remote --tags origin "refs/tags/' + ParaTagNam=
e + '"', vOutput) =3D 0 then=0A=
			begin=0A=
				if vOutput.Text <> '' then=0A=
				begin=0A=
					Writeln('Removing existing remote tag: ' + ParaTagName + '...');=0A=
					vOutput.Clear;=0A=
					if ExecuteCommand('git push origin --delete "' + ParaTagName + '"', vO=
utput) <> 0 then=0A=
					begin=0A=
						Writeln('Warning: Failed to delete remote tag ' + ParaTagName + '.');=
=0A=
					end;=0A=
				end;=0A=
			end;=0A=
		end;=0A=
	finally=0A=
		vOutput.Free;=0A=
	end;=0A=
end;=0A=
=0A=
var=0A=
	vBranchName: string;=0A=
	vHasTag: boolean;=0A=
	vOutput: TStringList;=0A=
	vRemoteExists: Boolean;=0A=
begin=0A=
	try=0A=
		if ParamCount <> 1 then=0A=
		begin=0A=
			Writeln('Usage: git-set-revive <branchname>');=0A=
			Writeln('Example: git-set-revive SkybuckContribution005-BugfixRethink');=
=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vBranchName :=3D ParamStr(1);=0A=
		vRemoteExists :=3D RemoteOriginExists;=0A=
=0A=
		if not BranchExists(vBranchName, vRemoteExists) then=0A=
		begin=0A=
			Writeln('Error: Branch ''' + vBranchName + ''' not found locally or remo=
tely.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		vHasTag :=3D HasTag('merged/' + vBranchName, vRemoteExists) or HasTag('re=
jected/' + vBranchName, vRemoteExists);=0A=
=0A=
		if not vHasTag then=0A=
		begin=0A=
			Writeln('Error: Branch ''' + vBranchName + ''' is not marked as merged o=
r rejected.');=0A=
			Writeln('If it''s active, run: git-set-active ' + vBranchName);=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		Writeln('Attempting to revive branch ''' + vBranchName + '''...');=0A=
=0A=
		DeleteTagIfExists('merged/' + vBranchName, vRemoteExists);=0A=
		DeleteTagIfExists('rejected/' + vBranchName, vRemoteExists);=0A=
=0A=
		Writeln('---');=0A=
		Writeln('Calling git-set-active to apply active tag...');=0A=
		vOutput :=3D TStringList.Create;=0A=
		try=0A=
			if ExecuteCommand('cmd.exe /c "' + ExtractFilePath(ParamStr(0)) + 'git-s=
et-active.exe" ' + vBranchName, vOutput) <> 0 then=0A=
			begin=0A=
				Writeln(vOutput.Text);=0A=
				Writeln('Error: git-set-active failed. Try running manually: git-set-ac=
tive ' + vBranchName);=0A=
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
		Writeln('Branch ' + vBranchName + ' successfully REVIVED and marked as AC=
TIVE.');=0A=
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
Save program 7 as "git-the-future.dpr":=0A=
=0A=
program git_the_future;=0A=
=0A=
{=0A=
=0A=
Skybuck's GitFlow=0A=
=0A=
version 0.08 created on 29 august 2025 by Skybuck Flying and Gemini (AI) an=
d Co-Pilot (AI).=0A=
=0A=
credits:=0A=
=0A=
Almost all code by Google Gemini 2.5 Pro.=0A=
GetBranchVersionDigits code by Microsoft Co-Pilot.=0A=
Software Idea and Prompting and Overwatching the AI: Skybuck Flying.=0A=
=0A=
improvements for version 0.08:=0A=
+ local git support=0A=
+ better contribution number=0A=
=0A=
Delphi code developed for Delphi 12.3 and Windows 11.=0A=
=0A=
}=0A=
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
	begin=0A=
		Exit;=0A=
	end;=0A=
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
		if not CreateProcess(nil, PChar(Cmd), nil, nil, True, 0, nil, nil, SI, PI=
) then=0A=
		begin=0A=
			Exit;=0A=
		end;=0A=
=0A=
		if not PassThrough then=0A=
		begin=0A=
			CloseHandle(hWrite);=0A=
		end;=0A=
=0A=
		try=0A=
			if not PassThrough then=0A=
			begin=0A=
				while True do=0A=
				begin=0A=
					if not ReadFile(hRead, Buffer, SizeOf(Buffer) - 1, BytesRead, nil) or =
(BytesRead =3D 0) then=0A=
					begin=0A=
						break;=0A=
					end;=0A=
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
		begin=0A=
			CloseHandle(hRead);=0A=
		end;=0A=
	end;=0A=
	Output.Text :=3D string(FullOutput);=0A=
end;=0A=
=0A=
function RemoteOriginExists: boolean;=0A=
var=0A=
	Output: TStringList;=0A=
begin=0A=
	Output :=3D TStringList.Create;=0A=
	try=0A=
		Result :=3D ExecuteCommand('git remote get-url origin > NUL 2>&1', Output=
) =3D 0;=0A=
	finally=0A=
		Output.Free;=0A=
	end;=0A=
end;=0A=
=0A=
function GetCurrentBranch: string;=0A=
var=0A=
	vOutput: TStringList;=0A=
begin=0A=
	Result :=3D '';=0A=
	vOutput :=3D TStringList.Create;=0A=
	try=0A=
		if ExecuteCommand('git rev-parse --abbrev-ref HEAD', vOutput) =3D 0 then=
=0A=
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
	vRemoteExists: Boolean;=0A=
begin=0A=
	try=0A=
		vCurrentBranch :=3D GetCurrentBranch;=0A=
=0A=
		if (vCurrentBranch =3D '') or (vCurrentBranch =3D 'HEAD') then=0A=
		begin=0A=
			Writeln('Error: You are not on a branch (detached HEAD). Checkout a bran=
ch first.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		if vCurrentBranch.ToLower =3D 'master' then=0A=
		begin=0A=
			Writeln('Error: You''re on ''master''. This command is meant for feature=
 branches.');=0A=
			ExitCode :=3D 1;=0A=
			Exit;=0A=
		end;=0A=
=0A=
		Writeln('Preparing to rebase branch ''' + vCurrentBranch + ''' onto lates=
t ''master''...');=0A=
=0A=
		vOutput :=3D TStringList.Create;=0A=
		try=0A=
			vRemoteExists :=3D RemoteOriginExists;=0A=
=0A=
			Writeln('Updating ''master''...');=0A=
			if ExecuteCommand('git checkout master', vOutput) <> 0 then=0A=
			begin=0A=
				Writeln('Error: Could not checkout master.');=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
			if vRemoteExists then=0A=
			begin=0A=
				if ExecuteCommand('git pull origin master', vOutput) <> 0 then=0A=
				begin=0A=
					Writeln('Warning: Could not pull from origin master. Continuing with l=
ocal master.');=0A=
				end;=0A=
				vOutput.Clear;=0A=
			end;=0A=
=0A=
			if ExecuteCommand('git checkout "' + vCurrentBranch + '"', vOutput) <> 0=
 then=0A=
			begin=0A=
				Writeln('Error: Could not checkout back to ''' + vCurrentBranch + '''.'=
);=0A=
				ExitCode :=3D 1;=0A=
				Exit;=0A=
			end;=0A=
			vOutput.Clear;=0A=
=0A=
			Writeln('');=0A=
			Writeln('Starting rebase of ''' + vCurrentBranch + ''' onto ''master''..=
.');=0A=
			Writeln('----------------------------------------');=0A=
=0A=
			vRebaseStatus :=3D ExecuteCommand('git rebase master', vOutput, True);=
=0A=
=0A=
			if vRebaseStatus =3D 0 then=0A=
			begin=0A=
				Writeln('----------------------------------------');=0A=
				Writeln('Rebase completed successfully!');=0A=
				Writeln('Your branch ''' + vCurrentBranch + ''' is now on top of master=
.');=0A=
				if vRemoteExists then=0A=
				begin=0A=
					Writeln('To update remote:');=0A=
					Writeln('    git push --force-with-lease origin ' + vCurrentBranch);=
=0A=
				end;=0A=
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
				Writeln('Rebase failed with unexpected exit code: ' + IntToStr(vRebaseS=
tatus));=0A=
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
Testing:=0A=
=0A=
git-new-contribution has been tested and works ok.=0A=
git-set-active.exe is used by git-new-contribution seems to work ok.=0A=
=0A=
The rest of the programs still need to be tested more rigorously/better, fo=
r now posting this update so it's more workable and testable (locally).=0A=
=0A=
Bye for now,=0A=
  Skybuck Flying.=0A=
