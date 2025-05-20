Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF944C7C
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769490; cv=fail; b=HjqLj4nW9LM/Wy149BxZCEkya0Av8Oc5mS6Cb9I8LwPV7F6gVCVGGV2gHeZ93aYPxJrfOAIhL6ZbeYX2GvsIRU5XXIW77bYNW95KDTj8u0UgZ2kLz7vac7ZMvT4LIPrzPRlh0ORF8ZSqWJAWNhPw2HaKXloUVeBdBn7vIl2F5fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769490; c=relaxed/simple;
	bh=yIEyHBKhOgDjx4PdzSKMYdr8eu+6I3o3SFKUxOrcktk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FY+hbMcTQRfyCS27GhwUA+Fnk9MhePKSZ3wwuUU3qwzFbl+NTdUEtOrm87WMKOJJ0CVrHUtfVSYPIwzjfPGqP5GAX24J7VDHeatTmfITX8GE51bA23juejbzsLCl8tCJHRsYTEdZkEQn3HzKKPsPzHWbcC/aTZSGM5HcsyuqUPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=IuM16aqh; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IuM16aqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCmV3viO23fH8DqMH9fjUTpEX0l5fPLKKImu4JXglLhMgaktscOSteqeQA4E/buWXwQ1eHn42a+3xtIf7/eOsXQymbZ1S/cYFT0j6d8Of7PDJsrpje2SijQTNIGvZt9az6wkhuLMBh+WbrtAVZ4zL+wPUHGulpk841wZnBrr03gknrsv6L9BnMFN68vTMVUXLrq2L1NZ8SEXhXrzcDrXYuW27aw/00qhIBR9m30QXKZL5QaLfSZsTnaaHaXYBhVMhdNBdxfu3AaJRb8Fbgq6lxqio/PBW0LRplYeYrUh1mUym0zm716CDxxKUqcWoU3iviYZWaOoAAzSjQlvTbUX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIEyHBKhOgDjx4PdzSKMYdr8eu+6I3o3SFKUxOrcktk=;
 b=UBUrQPwbjE1Rq3LihETv6hyhncUoLJnzH9GVNeGcm9FG70hWzky0SqZQihjAnThRcCJ128QqpLpQ14BXtpBxDkSkPeksrmYSByj1GzuY2ERPnG4S533iyqIM5owNQoyDYuqLOxUjeK1OuDaay8KccjGfuKR7TaxEN0hGz1r7rrTpQbNYOGcIUF2I35lUjC2eQvELkDv8ls7/vblVt6NXp0AAthq1L4PM8y6cLXc6ias/182lkTU2MwER6TgXfDZb6u18LVkka4EFLVbyfs746aniIJcNYvNYTdAmp1cHS7n+ypn0VtSy55icQlaccv4pRgBTqFMZ3DTvAWisc/eWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIEyHBKhOgDjx4PdzSKMYdr8eu+6I3o3SFKUxOrcktk=;
 b=IuM16aqhanTEs6jy1iMP698BnOaw6dEsRS/nE4EqEg3fyKgaxeQwy0nE5Xo1nOwfsFlYG6xK832kA/Tedv+8n0CZC4Jjz/Mn+TrF9JP786rCBrJzZaf7j7SNYen//F82dXFEgWpuXo24vjgdsnY9oiJqOrUIWl3REz5Drjpq4DJ3SU5uLeaPyb1+BqHSuwik1iMly/iTqjuQVFVeayO8lF/h6Nc2jvXDkG/lMZPvHQjaOH6QaLczJohbhQgA82SxmJq2GxL+c9+jyLLOcU16rGHtbVnYKe7A7ttFrAk9kQomG3rjeuqLL4rl3FHNX8fNwJ7jeb5QgwsjHGfUO+KO9A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4427.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 19:31:25 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 19:31:24 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Proposal: Add tip to use git update-git-for-windows when running git
 help or git version on Windows
Thread-Topic: Proposal: Add tip to use git update-git-for-windows when running
 git help or git version on Windows
Thread-Index: AQHbyb1EujWoWlEnV0inYIPu5eg/Ng==
Date: Tue, 20 May 2025 19:31:24 +0000
Message-ID:
 <PN3PR01MB9597FDF30B7CE529985DE546B89FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB4427:EE_
x-ms-office365-filtering-correlation-id: 70fb1b30-7f22-4504-4ad3-08dd97d4e8a3
x-ms-exchange-slblob-mailprops:
 Op6Ru+d2ciFKrUN1BU1+ZWNZ9tdqoG33zaNiAGm1ImRjup8euPeeJbQRkW7lcfuR5HOo63/JTeuyDIH9RpvzhVBH6dbX4K8DaIPQ1Mi8f7f7cRl9uS1z5G7CFPSG0sugINgOKIu2M4appOkbktgtZtEhNgjZmaDRpEdvY0fkzIxvn84zlgWvxjBWZCoP66cmbBeTeTzUXxpcAP996VbsDaWYPDhZYnHfiii5SyKNmTTF2E3W4dwTHNGF3puGBtdxs3O7rX4D0RwQN6lgWTiebkjt4h0IY1Yi4vneeuccG4FlZUgN/KGQOZVUCMqMUZQBeNuIMQmLoIDh31jsspTNF2sBg1QStc4cymsgQcA3Dh02c16s4X+zzjIH8c10sfGjDAdjNTBMIREWeZyPAprZ8DUG4sybM3/IL0T9GykukJ3ffu70neSXJqr9hFj94/Iq4zLMGIXH9zctzVtri632VRO8PUPpeMPlZjzjcZ0aEmcutO/oje9xYR799TXSthvrXswfyXghNvs2NP74Oa3JGWUbEztK++lfZieEQ9dn7LV7amr1Yzk/pwVcyjG1He+4dBZWasZVSK/J0KgVrqB3VdqV4cXpEaZIulZ1Kbj1AMEEXfpXbnXLzO1rB7e+5OwzwzvddNCw1lb/4Hs9ZGtS6a75K2hRRBWCnz6mqhvOicr+oz9hvMLhnYyFD7+wtSaeGqECffKJNYoO5FQtran+YISeSKkZTIAf
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15030799003|21061999006|8060799009|7092599006|8062599006|19110799006|15080799009|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yrmpghzVY/CGm77yARXGNOj8XeLGk+KnDq3jyb1LS+VcrZ34iuOIdzV3n0?=
 =?iso-8859-1?Q?o8QMmwdzOybtFTR6l9mnu8zG5qiPA2yfk3y/CGx1EgjKVeyXMOlVN43B38?=
 =?iso-8859-1?Q?lQMGDRrNWed532VwjjWH7H8WhczpodjWo7D37xPFbFz7GZtLum07G+t7vH?=
 =?iso-8859-1?Q?jaFTE39rWaKVt0z6gq9JgQbr5PTID4RJLw0MB+NMPAdi9vsswWdBN83UHS?=
 =?iso-8859-1?Q?EOULyc29OQMyagT3QVx9Rhx62l8ZBhYnoGSSEGwV1W4r/2vpLkp3DtL5tk?=
 =?iso-8859-1?Q?Ny3WyYCSe7mXxiVZbws+iakwO2gAlDnzSS23Mw2FpGVUXhf/Ermidxiugl?=
 =?iso-8859-1?Q?pOyN7dUE29sMUenkt8nGwgpkvlvZ6fTBeHxpieSZyyufJ38MhoTt5kf+J+?=
 =?iso-8859-1?Q?zEJwvpHbtcwdnzsqmV3VKXsw/6bNJenAalCL+2LJKtTrjjtKuQSAIXY+5V?=
 =?iso-8859-1?Q?/k9bFGH3M1XKSyviGM6nsAm2Ul6d+83DNPVdDwW2hISzfLUzXcCUdLr4BP?=
 =?iso-8859-1?Q?VQVy0727TWmok3CcYZZ0N/m+f2JuWYvKSFSeGNocPphuKpC8NcEfwBLOaI?=
 =?iso-8859-1?Q?EVQdfjpevOTDepnIxUkYbhHDkKy7jdj3mG6iDsGR+5NBcSD6h3pibVIKHP?=
 =?iso-8859-1?Q?GwNrvANO+5LHF9npVd4N/OqYhftQ/vc/iajPhFDN1kYC360uzKJ/OZZ9U+?=
 =?iso-8859-1?Q?TLJaMVb53o7vKrUdX/BbT1moV545OshXlqQ3sYsqjOslq70WpSIe0XymZQ?=
 =?iso-8859-1?Q?2ETURp4W6jUQktyIPaoXZBZ5BZnd3TJV9SlBUnV2e6OXDTNTKT98vGBwz8?=
 =?iso-8859-1?Q?aezMvXitXOLfj8R1kthG3AS+/ftFiRjOVcIhppmQx8K4vlbb9GhYLxOmb/?=
 =?iso-8859-1?Q?ywmK1bjl+DSEVjNCPJccsxeDH8vH1wpUfcChpVG43zv9XnbfEONKJS4WRm?=
 =?iso-8859-1?Q?RTLS1Xv29z+/2Ah6tB6OnSTObpm0O9/qQZTNdtl2g58ctw3dgAvOb+XiY0?=
 =?iso-8859-1?Q?JjtG+4N0696Mp0EgD5cVgAL4RdKIUOPXYs6a7gRHNCtIDvxI7R7eULhnSY?=
 =?iso-8859-1?Q?ee891o0/9ZDR+xK8DDllYzvrnp1fnkqqXW6XgtW+sgBCqHQTN/tc5A9Q36?=
 =?iso-8859-1?Q?j1F98zppWospszPDPGDxBCiqGeUJAuHXfEq7kDENC4sj17Ge7P9AC7dFJb?=
 =?iso-8859-1?Q?wK47AB+2cP7TLRj2Cwx18SKzVMpAd5e/Mts=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?phPSDkEVe6I+VedO082p4kQK7oRiUYSC2u0T8QMgb7XBlYQ4p3jQ2YTe+k?=
 =?iso-8859-1?Q?ExfIqsz7DAVMDyTQmAzBktjuyjRSu866gJVLY2fRF1+R8nkvaoAS7O2oKz?=
 =?iso-8859-1?Q?E4mCT7rPg4x5K+E9oNagX7UVPRVVOb9VkCfwlQxeaBeZRhHH0gFNGnjR0X?=
 =?iso-8859-1?Q?jmxc70a/OeqYYbhRH7s5GYVAO+kN3/2qJ9u54Hlb5TTS643kcoFaFpoW0v?=
 =?iso-8859-1?Q?pRkMhxIHxFJESMD5Nb4NFV+PN0PhaC2UJKfiKwZLhob6ZK9ziklS5Ukw1+?=
 =?iso-8859-1?Q?9fmT/SPK/OFw5G2TBmL5S1Dk54j0ieCHZ2UKfTep8fma6nfCXV/fDRkxcq?=
 =?iso-8859-1?Q?JTVB32hbCmM967iHZls14QgXAGAVfZwGtv/Bt2oKAhkUgStnauyRTEBXjQ?=
 =?iso-8859-1?Q?e72QtyHQPXOpJB4QFInUa1Je3Rb4ktnsUe0b7FRi+sHUqu4irWjNKvGWL/?=
 =?iso-8859-1?Q?SxY0v5vumMHUsqBD8zAYCjukB4lWfP3nTS7rTz10MEmqMaN/fWiMwT5YlS?=
 =?iso-8859-1?Q?qXVSsXwx/wQewIA0ioYt21TulHoxofi1QLHAkNWa/k22j0mZ2mv6vAPNnK?=
 =?iso-8859-1?Q?prXNK4wd91EjU7+HiiwzI+POglqpDtzjlZ3bFB3mX0LFCC79PUKP5Imy9A?=
 =?iso-8859-1?Q?upe8sdpPo7Q1c4ohsctVnidHQGykOmprlXPbBiQNGZXg9Jwe9xd0nRlnRT?=
 =?iso-8859-1?Q?CH0qdJaEeqLBAvtF4561aVlltM7ticb4gmdWR4CdGdAK+BMukzPCuvMJ/P?=
 =?iso-8859-1?Q?tS7Z9qb/U93UJmpzqOxnqvVuPHIIFrQK3bSX0zDLBKO0n8kcBDvfgLPf6k?=
 =?iso-8859-1?Q?72fxLGtMDtnLv44t6Gf6IsZtyKv16uIZYezMZW9qnGF9clw2BU7YLRhVxU?=
 =?iso-8859-1?Q?6ENx4qY1twULjByF1lmQk6Q7ezdQ+agR0HpmBwH1AuR0P7iMtzAhrTR/mh?=
 =?iso-8859-1?Q?GPahV1JzEbDH71p37hgVg2vQAW/pARoM+mA4P6FB5SY0mLbpMtj2qD2icl?=
 =?iso-8859-1?Q?iqX42zwSSOnilxSUG7HgF3YxT1YBCtmsZaKPqeT7MZhwVYpw/xefAM3uFE?=
 =?iso-8859-1?Q?fCc+iWN435GegU/RmdXNlbOnz4JUmRogOJUqsAT44c+GFVzevtG+5K6zUn?=
 =?iso-8859-1?Q?1caGSw1i7rXcDoytBGQGvQl8V5BOCvZXWPtD969mtqNQmNfbar0oG9coj5?=
 =?iso-8859-1?Q?L37aJqeCfBnZmCCbfDZoKCpowSeUBw6OoQ/IFjAUu2uhM09FW84ULxhrMd?=
 =?iso-8859-1?Q?BaBVYw1FjCILCUn/XLRwGefS4H+vBYbkuUNZ/8c3y2Jd2PA2M9Xm2Ek+bk?=
 =?iso-8859-1?Q?neyPkaDy/ny0TDjG/+tl7Z/No1+15FX4he2j6nfhildL8NE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fb1b30-7f22-4504-4ad3-08dd97d4e8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 19:31:24.7787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4427

I've recently started exploring git for windows, and one thing I noticed wa=
s, there was no sign of updates! I googled a bit and found the git update-g=
it-for-windows command. I think it would be nice if we could add a line lik=
e:=0A=
=0A=
"Tip: Run `git update-git-for-windows` to update git"=0A=
=0A=
At the last of the output when we run git help, git version or both.=0A=
=0A=
Looking at the code, adding a compiler flag to check for windows in help.c =
and print it seems to be a possible solution.=
