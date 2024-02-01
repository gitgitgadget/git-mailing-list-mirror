Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2089.outbound.protection.outlook.com [40.92.64.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9951649BB
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.64.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808515; cv=fail; b=dkE42UV6gsPEa2incd3K54oM9SIOPv7PtxF+YCIEUNDlaYhFhP8lMbcP6Wgs1L2DH3MvXHi48NDCNPvsbsnChIzKRp7YvW5zQ8Cd0rk84tRbDE4QtVm9bjiaV10sXKUldpur/t+z2h0Hz8AZUjubvy7Gi6Axz1I4ZDKJwgf7VL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808515; c=relaxed/simple;
	bh=gP3tOydunbtFVeYcL6Rrdh80jQ5Vfy1aoSgluEh8Tvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mHm4+Z8XuaN3741Q+lp84N96QSb48tj9vK3vJRvE5Jzgwj7EashogWbcZkw318u9vMFJQemQCPBHcC5vTt+XO03w3UHBr9tGx0r/M1Y45AeLBT7151ujsuhCHklGC8rQbgx3lgto+3d1L3x6JnRJJxeaLxMcc25cmdPA55HM/lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=gNkYlFZd; arc=fail smtp.client-ip=40.92.64.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gNkYlFZd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNRN29qGwFSFR/GwA72TitDwK99bLawIM5LrZ3F4dGBdglbVu8bKAwaTzqlTWs6g54w28oZ0dRNXfb3Str8cmSfBpUtpELUizlwMakHY6cRavrojyB4uZa8KjINcsvu+lo+xTmW2bK2RFXxAp1HAVZdPNukrobEW+OD2OONuepjvA/9qEbmEMTzo7wGqd86tHtXm0O6nl8FQSGfmPal6lq6XISKD9Bu7V0XoNeExts1gnjchY88EwopgxR/uKGfUFFr0WSfvFFtGyUR+P+kCie7kPTU+GY1SaFwNESQhu4p9scRQIN2qrcrT8M/UsKiigtVGuSnHP8k1k1emqfUH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP3tOydunbtFVeYcL6Rrdh80jQ5Vfy1aoSgluEh8Tvs=;
 b=ga+5JylrEGP4AkL23RhP6FnP00oBdbWaaKyP6TRtsFkwbyM3tfu65RoUwvoIqFJZhsuOGcLzEchn5GW0RDVD9/jmXvtN+N4dcwWzWy4+0K69hVYnoTkDT6FJMzswkGNQXBlGqKS0aMkO2xXVP/Nm8q4Z82a1ahu+/oqBySD3ShEgAFZr/sjT3ptgh2V7ilxnm4MysQWokSuX7/uQPhmJcTdkQvE1jyiWMu7WDFXDnI3AmwPIuW9Xw7FBRsHZNbyP4GgXX2+rc+gOW+qEndtexpoxkdGBvTkWX0KSETpu1KmfbZJpG/0kNhdtYvROHBL7pes1Yy3YonNqE1V65+tT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP3tOydunbtFVeYcL6Rrdh80jQ5Vfy1aoSgluEh8Tvs=;
 b=gNkYlFZd06u6EfmL+Gaey34G1uj9CwJDmCFXS0gJQyJ5s2XtgygCLJT33ZH73nQSuw50m6sMLBGp27HSb2CO1fjprFCj/wOhzOz+x5KMLweRbF17re6eUWigsoQog6VWVtUQUit2mcqXSfFGTVKbqewZ9eCz12HYMRHwJmGbBaQro+sIjlwzxVviXlCESAdOTOj6v0SXEy3sCmsG35crhcur4jGGcXf5nRH0L4dweRD7G9js/BKl2WY/1mJvWzjx1grMlgLLDrszSmvF4d+RCpx8bqrmZsH9vOiALOuBwF5Nr+zaEfQWbpL3SMSjRCkv+xu5aSPvbBQkYmbwM60CXQ==
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3d9::18)
 by VI1P195MB0525.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:15a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9; Thu, 1 Feb
 2024 17:28:31 +0000
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10]) by DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10%7]) with mapi id 15.20.7270.010; Thu, 1 Feb 2024
 17:28:30 +0000
From: Hans Meiser <brille1@hotmail.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Topic: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Index: AQHaVQX2n79jCmLH3kymUsYhfKUndbD1ZQcXgAA6fwCAABmD9g==
Date: Thu, 1 Feb 2024 17:28:30 +0000
Message-ID:
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References:
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
In-Reply-To: <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [aFjl9VtrEdG9e83LRIvmEq+rKNAfM+Ki]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB2130:EE_|VI1P195MB0525:EE_
x-ms-office365-filtering-correlation-id: 64bf6a94-b0a4-4321-9723-08dc234b3598
x-ms-exchange-slblob-mailprops:
 laRBL560oLTk52esSKLYh4b8SPFuH6vV2s9+Gwd8MJZ6y0q/JacsK4Hmo9DDI4/OHD6bI261DlfM10x8CAgM8BnNbTn002DoZMy4HkObyehzhCAhoAUK3cXXjiuWTccMpyJ1BbN8BhOJr+ttKChc/cGBu+PE5zdfkxSGfzT82/A9YcQrWlUAX5qWTpSpHRmApB2zbdIQmTpZvVZ6t9vUZUxhCvQH2aZoo28sZMdiwmJMvfBPPof8DdRLoNxKJJ58DUUtVysqNUQL3WsD12Or0MWJ7n4EeEFIHY/L+XP1SKwWhZj87WGlKgD2LXGdDjvtb1uHJyKLpqhVT17ueAsLLzYH5rWQ5uw0Fx1gY0l0L1K8IMfQBz332jk52MC0hn9kzlMXLUV8kWQu19eT4qX4AZe1UWKWAOREgTwwFZqN//qM0X+RCcVo5TTFyzF9FAKghY6cxbby66YiZ+2mfsGhKTJbT8QURdxg/FJRMffAJG72iYzJtFz43tAK45vnzlVzc5Md2ssUyqSFcvL4LHGsjcXZXCZ++Za426W6KBqWCacgAZSZcRNWS7Tkevyh3Ma+iFi35hbhD+AJi8XxWwjVpQcx6zpUXPtyKsBW5sEUBlN8x7lKaciZFZffDOefqj/AU+mivZggz6Eiz5MwQYplwyufOfS9sFdLwIXVeYHWRI6Yhl2E0CnXpKbw2ex1Ba0ZnzxbH6C1LR/xH4oQpo3jZU2SgqeOMX62nyI7TfakY5HqW2WNGC71vH416x7NEUubf4dJeBqJxE4c1nXD8E6hguRR4uZc3zM1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eeAmvqMPA3Kug8LL7ikMBIVeeHY+gooct8GeiDQNOpAyKk1jWtASKbiXBZQqPfM5p/jdnWTDj3nswOOQSFRovfcoFxnHj/lNlBRwW9brv9u3rMfFU16w3lZdt9J4wrXmXMK4BDypo0K46sneiF73mFLM5/kNLT71yTRGi/IjRXs+XN7HnIhZTEu5JXMJtbQMi4WhDxhwfLGEP9WUyevvPgMKbvKHfYUfo59keUPv8Mt27xD0X2ZOFbr9pd0OVp7tC/rUPzOGZg8vIEZxeTYLdE1kW1fOSNytk8DJdAx26MfAltdoVtHo1vzqjb19G7DBJ47xjP3iWbyrSzdfxLfLFCtoTMybqaVfjiAQTG59zzhe9C126iJmJpCRuzE6RM3jb1vi1c9USMsNfVuSJ5f7Qp2xZSedHI8L50WEvAbHKK7TDjhlSBHX44cemDk1q/ntDb/+9UnQNFyXv4/mXX89+OYHVhzcNnImCf4XYV1nR99pVXeVZPKf2XfuLNnIYD2qszskXBzfarouuMC40iUnmDpJnbm3xWZ4iv0D4EF2bqFv9Zll45qYITupNrx+aCSj
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?dEElM8EWZXJWxh7K9O6waJVbBzzItw/GIdNQBsjImFlOpDnviOylEjA4?=
 =?Windows-1252?Q?q5ZILpKj3eWBccrvgEiYTjPNR/P2+LsMuvVbr7YbGAIj2NlaMgmctPPD?=
 =?Windows-1252?Q?FqKpbzXZzai9fCGayLiNCivEqE09WNFhzDL6kpqYAAdEzQH8TEiWdMB4?=
 =?Windows-1252?Q?+l1/Z8nEE50BC2qHvqzAuANxrE8GE05PZKmx+G3ctb8OMd9RmzrCn1zq?=
 =?Windows-1252?Q?C32feg4mRzESX3tKxn30tmqg1hlbS1SU4qVfBQj37wsf0z8ssjFW3oIL?=
 =?Windows-1252?Q?ClvkWlGWM5FGhMQjBCZijXcvR3H1i5FpUMt1usJauwbriY6OoBy1BqOZ?=
 =?Windows-1252?Q?4v31NxAbRVb8KMYcXewvrEQeLeIThJzCHpEdL7DjFTNhvl5Gq6yXYw99?=
 =?Windows-1252?Q?kmmC/MoXW3fkB+7JFeZubA7Yc8ocstJuiz00tsr5BTtOx1MgKc+gViQ1?=
 =?Windows-1252?Q?e1oB690TYv5+oTJjgPZfRzRABVf+vgaHrkWFp4S9+hMkVc0BM5pzcY18?=
 =?Windows-1252?Q?t0JI9QLAoBY/NhL/jiKCkN9iKp/ockD1pWH3aaYac4eZDbWHbFG2XsKG?=
 =?Windows-1252?Q?iZ/qdNJ0LEUm3keiUEtvzzhAOFhcPpviGJVPTy/JoAt8sURGZ72MrGYm?=
 =?Windows-1252?Q?DZ8Z1aIc2lCGm5jPvu+gnPe011bZLBLSPtlDCOMUtld9cQpVqWBwohnP?=
 =?Windows-1252?Q?V9TAjVB1EyQJs4Ij2YsulDJ9Mpm+cc4JqwzunyT9QSz8opmjYEWLCBaq?=
 =?Windows-1252?Q?7gqqlcrcVstAdQWZH2GF/mrL1rqYbtjlhDygVZbkMa0lBybRDoy1kpHF?=
 =?Windows-1252?Q?Dhpfpmgt/TJFe6SKcB61e2cuy3L5i9klgpcuCxgIzGJFzT8OiZaKm6dR?=
 =?Windows-1252?Q?f45jxMCoe1PaSCkuAsD4w5yYhe6Dwp69DzCKYJ6ln+61M4AM2b+TzK0e?=
 =?Windows-1252?Q?RmPdz+TDAQvaQMACtIoVE7HS1gxMo3doRMHT+yOUmatG+2uSvuhXovtO?=
 =?Windows-1252?Q?Dt/r3O0bHx6SVWgpt7Bm7RjE5fEL8eiTfgDz2aQs7spPsjOBVn2G1HvM?=
 =?Windows-1252?Q?J5ugRU8gQhOsFtFFHeCcO9QzKsAOH1kDZiQA6L26XX5ouA1WAEPbELQm?=
 =?Windows-1252?Q?mqlQIUazY51xsN+hQRh91vePUnKiIn6Lk9CTZ5JkxRF81Du1nu8zJbEH?=
 =?Windows-1252?Q?ZI6vWfyfJ5EPYP4QzOGoj/vUgnQ2be7DYKwC7d6xOj05zzIiWYfAMOa5?=
 =?Windows-1252?Q?naE6KN30rjNYH1QqA9ZnEJ+Gq/Pm6OILPVGtyqFQ?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bf6a94-b0a4-4321-9723-08dc234b3598
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 17:28:30.8435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0525

Thank you for enlightening me and elaborating on all of these very importan=
t facts!=0A=
=0A=
Just to make sure: So "git" is considered part of the kernel? And the "git =
documentation" is considered part of the kernel, too?=0A=
=0A=
Shouldn't these topics be separated then into separate repositories, partic=
ularly the git documentation?=0A=
=0A=
For people like me, who are contributing to dozens of documentations on Git=
Hub (and GitLab) =85 We don't focus on the kernel alone. We receive dozens =
of important technical, business and financially important e-mails from dif=
ferent sources day by day. So, people like me need some modern, common chan=
nels/tools for contributing. (If contribution is considered helpful and val=
uable by the kernel team at all.)=0A=
=0A=
With todays platforms, issues can be created by e-mail and e-mails will be =
received with each issue update. It's even possible to upload patches via R=
EST services. No web browser required. So this would keep mailing list user=
s acquainted to their habit.=0A=
=0A=
Setting up a local (on-premise) GitLab or Azure DevOps server for long-term=
 use should not be impossible. I'm running each of these myself. Once insta=
lled on-premise, the installation wouldn't be bound to any continuous suppo=
rt. All it needs is a provider for keeping the server machine running.=0A=
=0A=
Cheers,=0A=
AxelD=
