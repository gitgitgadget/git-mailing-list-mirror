Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011032.outbound.protection.outlook.com [52.103.39.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7742FC02D
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446206; cv=fail; b=COoepLbwew1SJ7QNu4wMKtNXNYpT2rtGYDRuUFcsoxyaaySLd+nV165oUzMuaVmMZmjZgf6cdoJ8ZeXNz2RHSMrxYeOiHuj9P2MhSrun4J+oi6hqwJ48t9yclVf/6hrpmIyZNR6QNoeBwYMyNIReRcR7wr/5fIVhBw5I2lmfvSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446206; c=relaxed/simple;
	bh=XhV/LS2edAs+vCTxdcglAnUhi7Oi7CAFk04QLEiv4Ek=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f/BzwtflBSOei+Wl2Ig/MBCK2z35Ht2z5x5Ome+en7qAelziLDj3HcO9Q4CxJe/ao++3hP+dRkuu5BGs0jRIUM/o57dLs0WgpQkpocNoT+Zf9hsmSx/vzOXY+O+R247dPTviR+Bm6St2a7npqiW9o7LA55/0dyn1HOe0zndt26o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=dc4sLoYH; arc=fail smtp.client-ip=52.103.39.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="dc4sLoYH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2dtsSjE6cFfy1KdPjxncFAFGdPSHFFIb1FGgLkH+3YAnVmpG2/y9EduhggUhCnA00GhMsO08p8U0p+kOM1FMfjKztkdt9cHddqhlxCA3h7bqPEbB/eCpkYjlYkLk/TzYdewULMbnFkceEb34ihQ3ejGi6IkkheuZbkoDuXsYFFJCXeyzfOONE14zJwVorDZnolvRJBZ0MVpD4kQGr91Qwhp79uXzNSBwcRt1FX5cSchg2Q7SwgDE8erd11e27GfA7aodh0UTg/BuuQyDXf+dqCoEJ73A5y60A+YHXqKCYZuNRdGcPwZ08juDctMilNAYVVR/PMWrhdlIGu/60IFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5/cPVCwXci0YWtdi5IzJ6f7iBFcYt1gGjtDM4PoCE4=;
 b=qIyE3o+MZIdovoMkd0yzluJnvVkJ56Hv9efgxbqUdRrE6JLLBEjEoxCklpxQxsPkVsns+CLQ0+J5jTGVl7BsLbLYNnAF0Xt9pyg9MDAsLYoxI4MXn42p5WuLfgX4DsqLjjYdQJw+BMoB53qS2ySfD6AkfV4hHAlwjcFQMRdET5a41VyWcvGEB6FxAWVOADn4+gpt+oyIwEH3Adw+YkrHbQiDj2HTwrzNfeIgzz0fDuGFid79t2reM4xB+ZWB+vPxxIKy/qCZeM+zufIC73UrhBg+ect09hjUrvFLRFgrhjbVraaPrKt4dITDRfXpwuAhAN/V+rmo1hK5UvMW+mA7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5/cPVCwXci0YWtdi5IzJ6f7iBFcYt1gGjtDM4PoCE4=;
 b=dc4sLoYH08Ms2qlaXonY0cObN5Z9rGcd6nOsUicieIVkv9PIHT3P01C9r6Tr5tn7C6bd4Nv0vMOvQH+eXmWS9mqVCyF40jSWvGPhbJ8HrA+IVrCXiFOi0Wk29TGL3eWdw8XyGO1OIreoPvpo+VpZHEAva853qmVOjPjsw6bE9pp3kpjqDK2PuBWh8xenlUI2c8KHw7PSS+7wu/+3fbTBUXLY2K18fifJJBYFHz3oVzYIsBk6ub/zaIn5TGemPh/8fAczZ/NUNkprPkg3VBQSJUrwgVpw7/kMIfJkIKAnuuCJfvSvrBvg9VUzHhxs5b7hFVsYFrUFI57lsaw45wjW0A==
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com (2603:10a6:208:f4::27)
 by DB9PR02MB8299.eurprd02.prod.outlook.com (2603:10a6:10:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.16; Thu, 11 Dec
 2025 09:43:20 +0000
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf]) by AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf%5]) with mapi id 15.20.9388.013; Thu, 11 Dec 2025
 09:43:20 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Color remote repository part of a remote branch "pink" instead of
 red. I.E: [Feature Request] Mixed coloring for remote refs in git log --graph
 --all
Thread-Topic: Color remote repository part of a remote branch "pink" instead
 of red. I.E: [Feature Request] Mixed coloring for remote refs in git log
 --graph --all
Thread-Index: AQHcaoHDhwUUx9BTykKiI8OBZKoaig==
Date: Thu, 11 Dec 2025 09:43:20 +0000
Message-ID:
 <AM0PR02MB44500013C2F28CBBD99A113EB3A1A@AM0PR02MB4450.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4450:EE_|DB9PR02MB8299:EE_
x-ms-office365-filtering-correlation-id: a913da58-0730-47f8-f268-08de3899b82f
x-ms-exchange-slblob-mailprops:
 HeyTOiyEx6ZhckDxAq9Edwy3NVcpSjyvcmeIcjezJJBn2/YMAZztpz8LVG3Q3Un45GFboq6enp7PCwxnBmE2fkErRMAiD93SXgGvkGH1U4+7Hq5Et0PcI/hbMqBumzp7Nj/MNT3ZQOo11wueye6FQnxLNpzSQf102sJvXcvjA8xGtQNFX6F6WHQyPavo9h7jeBirbSPdm29CDfy0GFKVChfulF7nTt5jUVfNBI+SYh9IREUIdxHwWoUug5aWVvrf78IqSDHvqbzISMaYAJiU9bJN9IIkCDZ8MY+LsT8tnUO7tQYL4+zv+Uf5v0L0QRV7i3pH+LFyLSOonwCK69f8XT4zQfpvP9L2NWBVYAPpEdNzlwuBJTZjD/pxHitC1U+voPtWZpDhIu6RI1X+PtpJex6JYI3cE9gM1PXi95pPSB5McdY+b4uB8NzfGP7FTcpk6MPYy8eAeMfBTgqUrm5pL7dLc+N9tPw43IwM3ndUhsThsdUxcZhsXN2HFVqZ/xx5Q4GzzH0JfrmmFB7jw1pARBZJQsVYYYThuGgH41SfxGyZuFjNBG48QR5JkGF+L+xjVR4yXO2v6mE5MOCNetudjeNtcPbwODhaU0F8Jjo3nPf/f2hW76Fg1yFJLs/hAAF8q5sC0eFhAbzQ6Vh5zFcVDC438PlCqNRwtmKRRlXU3k53Adp+m5eHvAyu9QWk2KHxFqvVYbwRhdsYFr+y/xJQ+yufKjxsEj7tQcZOIXNBrKvoENP5pXxuq/XAmqWLVTRmtUcc2lF4sgqqO2k8cNH0Xg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|461199028|19110799012|15030799006|15080799012|31061999003|51005399006|3412199025|4302099013|440099028|40105399003|10035399007|102099032|12091999003|26104999006|1602099012;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?jiXRtQC4PzD8BWjnnCPFT4KcYjDHXXGepYmVqrH8fwZfQMUYOmPmSulm?=
 =?Windows-1252?Q?F5woicADAt0QB4m7KjNADmlpsfpI0mvET9pZqPVOtnfAl/nGSijhqt1L?=
 =?Windows-1252?Q?7JSw8ojaV0utmiPhAIF06OINIk2Mn9ZLiTAnlsH4MRpoQCwAqCbfx2bB?=
 =?Windows-1252?Q?cC9AYfR/QfkI2G9xFhVJmpGlUeMqZ2EETvrXBlduegvtp2/1pFbOd7w1?=
 =?Windows-1252?Q?9QqEwRqDjWBRZCQrJ4Vde1AfkcvII+Kb2d5lPIK1llvGUbNOn6i5upHU?=
 =?Windows-1252?Q?H9s83E7t2knOmJuSVHlcWhz43ZMTQdMwGfbZE8DSgXwmrr/9N0/u3HXq?=
 =?Windows-1252?Q?IQjMPTAL5MVkfBbCJu0Pd0wkOmv0dwrXfMBZbaFAhcEvoXjHDg+DdX/a?=
 =?Windows-1252?Q?7u7l1yxc63uqtg5iIh7PK9yHdNcQuSktEXeitFIYGqSSNq8qrlYEUldp?=
 =?Windows-1252?Q?nxK+2j80tIVpJsXFSJ8FRYPWVJQ0SIxf5Tz5Ku+H0p7Om06Zs4bxDSxc?=
 =?Windows-1252?Q?F/xzzBu69Gu/xasiD6kZAL80b2UbpNAyBGG8sCnIgZ3rSY/JDlOEZFK9?=
 =?Windows-1252?Q?Vu1Xa5zqAyeAk5ASDWw5xm7rpIedEPupm+KveTGfM5QsYBtASOsn6n+S?=
 =?Windows-1252?Q?NEXKEFDn1gj9aciG0IMxqRNOX1IaZLh98mbgxwm19QsyCwX/LUzaHrFs?=
 =?Windows-1252?Q?5CPRhAAmqQoaOYxc0OuOn4YVvx/jHp+1cfMQcLKUaOWkOhYxMedyW6AV?=
 =?Windows-1252?Q?RdC7T5BGS/jTnNynF0KoD8wiPJf1Ua+tSK3qSeqG8GCJgeaQtDcuZ8lw?=
 =?Windows-1252?Q?+qJmA8P8Z25FOOGQpEhmmKL0IBncv2F5/dYpGunMcSeuBrpSj1V+Uby2?=
 =?Windows-1252?Q?bNI6ESH7cnIxA6SVlWNK0hIxenn41BgnNmpVchR379v0ZTk8oy2M14/l?=
 =?Windows-1252?Q?uUIDr8a/3yeLspKzvAhwqunWidjfMUYj8+bL7UsldAak82XX1oUR6425?=
 =?Windows-1252?Q?gHjLjTpsKOBmm4MalXpu05ZkoLxVjsbl+ZAfsmHsrqAxe2c7waQcGy4m?=
 =?Windows-1252?Q?Aer3TSBrSS8yrmMAL2LxhQe5NrL7L5GG5tQtEbPWOFdRdrD/r8Dut0TX?=
 =?Windows-1252?Q?LNs08B55znPQ9tTxWG9CclKFO5QBDQwMdoQ6SVDRHL+oAZ1hcS1d8x9Z?=
 =?Windows-1252?Q?9KZ3TWl427uBCRHXfsU0HsHKRb7sOrWYtZ0uS7cZl92Qz/l+3Z4oRh31?=
 =?Windows-1252?Q?VXT8xCsVIzvUUFj2lEHGPNH8xYh7/vmqo4cHg+9NW53ouZTy813zoYcx?=
 =?Windows-1252?Q?I0faxiMVSj06Su3z2D5f6O2dVOH81fvJwC7ddbr6yqJbKrJFiPQ9PjDK?=
 =?Windows-1252?Q?jHnvHhqqGBI78ygJeVa/Key6dwpZNbUnYWNq71gtYQSlsGMyeyusOePI?=
 =?Windows-1252?Q?mXgtsUNQ9S5b2EQr3Yz1XNYsf8K2DYREY3PgeJY70xe2CUojH8L/TnWT?=
 =?Windows-1252?Q?/vXpGdKvYf1xbl6JXh6bgzMluz5nUw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?mtvdFj0C6np+iDTw/DhKNhhHbSDH6zz5P13avmg4l6B9y+UM+TtaMLKJ?=
 =?Windows-1252?Q?L10zpPz5SDBI8KnCTHzyDTEx2fViJITs90Tljlc65z1NqhhB0cu8npmK?=
 =?Windows-1252?Q?jHKFnJ2d7mAstgOrzNsTjN6p9FTJ/3egwWqyPvqediyRMenJP8hfXz/Q?=
 =?Windows-1252?Q?YEvzEHXcJqk0tYFWqGSmblL8XNFsGDH3Oc0gxRsHJk5/ZlrytB/BeRni?=
 =?Windows-1252?Q?d4xAL3QmIivwcK2dMeIsAh8FbRq3HQ3+mySSElRTBHpuMq7egXJVFTgO?=
 =?Windows-1252?Q?+ZlqO6+M8AXqzqvnL4xxyx084GoxPGlKqslywIO+yO128N9w7CNC3x2S?=
 =?Windows-1252?Q?hl/1sbYhPCN4+h70MxKSzWWy2ah6KWlUryyoehjO/hGvTsT4+xRp/ctT?=
 =?Windows-1252?Q?Pccb0C2wkKBY/zBociylkOFeGYnN+F5v52u0LAddHEzm5c0JRJuL2CIJ?=
 =?Windows-1252?Q?W+iNuOEV9auHF+JzWUj44hsk4zC0Ql7f1nQHXd0u9Cze8CPDPlDb5Zo3?=
 =?Windows-1252?Q?UMNB9vmRCXY2jsvL3z4yZgdGCdW7HQ7CtuxzA5HewDE0PK33s9g/KY59?=
 =?Windows-1252?Q?BUUO6O5yaMXIlU0GqemlcdgNB/HdUz27a9M3+8RyhOdq+hVzDPTVFXGI?=
 =?Windows-1252?Q?ZX10JOXZUhAr2bxA8M1ayO5oNAx/yqG7oUb5dBzChBC8iqGL+9l/0vk5?=
 =?Windows-1252?Q?lQ3+s0KyQSi9HCmPbcti3xY4T8YvkjUZyAJ9TYkTqM+QJwH0gv2Ki3EY?=
 =?Windows-1252?Q?jZLxO6mcpRUA0sZPqnqSU7z257JMfbxthMtMBJLhJN6eK9p6WQ9wFRHR?=
 =?Windows-1252?Q?WUfQr9UE4F9RfrIsq4m8zyA5XuDc7hM73kMaEB6qoBszZK6ye6rLxF9M?=
 =?Windows-1252?Q?gjp60mXFKNZn26+xyCDRT84tJBgj7BIkRkL+gdU82N+DK9RVJTlgLtEx?=
 =?Windows-1252?Q?VY6B18bcYz/l4JfqIRMJfXebO/8tKerVEmACaBk0shtmcLdiUOVhDeqk?=
 =?Windows-1252?Q?psIQc6PAO8Zf1/2ppD3dBVZ/f8r9g8LiRG+XbQxZpSpuooi1YOp3LWws?=
 =?Windows-1252?Q?yMsZKI86WcmSSzWE5yWn3emH83jEvyH3pk/rFaCnZj/7JcWH9oF8vOv6?=
 =?Windows-1252?Q?iGTcphhdHl9azWMI6G91zVImc+V1hX/g8b6v1QipV7d5DT3puTzKbVVq?=
 =?Windows-1252?Q?SYUCH+fS7VisBp1TNKN/i/bHQQaa0/fwHYbjBgjczKSQeXBWIeIa3o4A?=
 =?Windows-1252?Q?tMWlUDBO2Lbroqs0IkUxP/5YoLtCNoSYQZWe+j/iLbxd7aqmi3nFbtGA?=
 =?Windows-1252?Q?bS3M2VXpe5+4c9fAuIFQG+KaFlJ4bW9iHtX0rcYFJu2VjZGVRee8lA8A?=
 =?Windows-1252?Q?o0xEHl3MGe4qXkeukSyhZwIaW2o8SKeV1JU=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4450.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a913da58-0730-47f8-f268-08de3899b82f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 09:43:20.4200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8299

git log --graph --all would show something like:=0A=
=0A=
X:\Vite\Repository\LocalControl>git log --graph --all=0A=
* commit c2234c6162cae9e7bfe5013a76b6c381092046fb (origin/Branch/Feature/De=
lphi/SystemPromptUpdateForTestingUsingFreePascalCompiler, Repository/Branch=
/Feature/Delphi/SystemPromptUpdateForTestingUsingFreePascalCompiler)=0A=
| Author: Skybuck Flying <skybuck2000@hotmail.com>=0A=
| Date:   Thu Dec 11 10:15:51 2025 +0100=0A=
|=0A=
|     SystemPrompt.md +FPC testing, +common/types uses.=0A=
|=0A=
|     SystemPrompt.md updated for:=0A=
|     + Use FPCUnit for testing with Free Pascal Compiler.=0A=
|     + Special directives for common/types imports/uses clausules.=0A=
=0A=
origin is a remote (the github remote)=0A=
Repository is also a remote (locally on my disk).=0A=
=0A=
Both branches are in red:=0A=
origin/Branch/Feature/Delphi/SystemPromptUpdateForTestingUsingFreePascalCom=
piler=0A=
Repository/Branch/Feature/Delphi/SystemPromptUpdateForTestingUsingFreePasca=
lCompiler=0A=
=0A=
There is the possibility when creating branches in all kinds of ways of acc=
idently naming it the same as the remote, so it's not really a remote, but =
it's just some kind of branch name with happens to have the same remote nam=
e.=0A=
=0A=
Maybe these remote branch names are just one string and the difference don'=
t matter or maybe it does matter, I think it does matter, if it does matter=
/stored differently then the idea is to:=0A=
=0A=
Allow mixed colors in these remote branches.=0A=
=0A=
So the origin part becomes pink.=0A=
So the Repository part becomes pink.=0A=
=0A=
So that it's more clear what part of it is a *true* remote and what part of=
 it is a *true* branch.=0A=
=0A=
Further info:=0A=
=0A=
X:\Vite\Repository\LocalControl>git remote -v=0A=
Repository      X:\Vite\Repository\Mirror (fetch)=0A=
Repository      X:\Vite\Repository\Mirror (push)=0A=
origin  https://github.com/SkybuckFlying/SkyVite.git (fetch)=0A=
origin  https://github.com/SkybuckFlying/SkyVite.git (push)=0A=
upstream        https://github.com/vitelabs/go-vite.git (fetch)=0A=
upstream        https://github.com/vitelabs/go-vite.git (push)=0A=
=0A=
Bye,=0A=
  For now,=0A=
   Skybuck.=0A=
=0A=
P.S.:=0A=
=0A=
Here is the AI version of it, in case you find it easier to read :):=0A=
=0A=
Hello,=0A=
=0A=
When running `git log --graph --all`, I see decorations like:=0A=
=0A=
* commit c2234c6162cae9e7bfe5013a76b6c381092046fb=0A=
  (origin/Branch/Feature/Delphi/SystemPromptUpdateForTestingUsingFreePascal=
Compiler,=0A=
   Repository/Branch/Feature/Delphi/SystemPromptUpdateForTestingUsingFreePa=
scalCompiler)=0A=
=0A=
Both `origin/...` and `Repository/...` are shown in red. In my setup:=0A=
=0A=
- origin =3D GitHub remote=0A=
- Repository =3D local mirror remote (X:\Vite\Repository\Mirror)=0A=
=0A=
This makes it hard to visually distinguish the *remote name* from the *bran=
ch name*.=0A=
It=92s also possible to accidentally create a branch whose name collides wi=
th a remote=0A=
name, which adds to the confusion.=0A=
=0A=
**Proposal:**=0A=
Allow mixed colors for remote branch decorations, so that:=0A=
- The remote part (`origin`, `Repository`, etc.) is shown in one color (e.g=
. pink).=0A=
- The branch part (`Branch/Feature/...`) remains in another color (e.g. red=
).=0A=
=0A=
This would make it clearer which part of the decoration is the true remote =
and which=0A=
part is the branch name.=0A=
=0A=
Current remotes in my repo:=0A=
  Repository      X:\Vite\Repository\Mirror (fetch/push)=0A=
  origin          https://github.com/SkybuckFlying/SkyVite.git (fetch/push)=
=0A=
  upstream        https://github.com/vitelabs/go-vite.git (fetch/push)=0A=
=0A=
Thanks for considering,=0A=
  Skybuck Flying=
