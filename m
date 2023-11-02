Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525D3200AB
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2101.outbound.protection.outlook.com [40.92.49.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C833A1A8
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 11:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQy/MZ2zBZeuwJM+1V2+Jm85BRhJ0zmzkqxAJfG4U/SR3z0ib8IQJWjw65QFy0VnCYNCfLqWZ0xOaSEAbidfTOsHRiTlGMk3PlHpczoARylgRGkU1Ohm7FZDD+wS4WwpWm+hORc5487494qe1TNtVkurZm7s/V3tjoTf/HZC8dsfxvtfOl0glp90Zdxm5IZ4QjkrqWhCNKAgx1L+XXVhYDtiL0txJr3pgq3ObSSXMVkyuHrl9cVvuT23MZC8AAJk0x76jMQo/3o/J167geYayOD3g9A2Q+PDXfYu70zIhHDJWnvZcG+EhGqJIC2gZMX5KzD6p2DhhI1o2uOv+e2Nfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02PaQ9pX5u+lzRb/voAepEF6OLYdUFjU2k/GcaBdUCA=;
 b=mFPtRauCEXiqDJlrS9ZrN9OSfRlt4ju3xmdLQDXnNLwn++C5XfTsQYUymw/OuMY0SGVVeqMVKDIR8mPxiGoz0Myyr3+Um8aTJVuXN+MJrWN/UqMTfDziQ05VmCyiqBU28bHVKjF+x4gzItkNFI8osf5z9ly1HAq0VeWth9iNQJck/rY3fvtzsGb+vg44m5dQhuXX2p2kpk8cDkop6+AXegZm5flR8603jetwH3DUi6hInJsCqlkEGdxZcM1B+iTBGnIGBU+XucgpQrArV/sI96i2LkT4UiTY4REpQJEpl+8q6Jq+4UOaetkm65ibadcMSfMGFqh6vR/kfyP7R8/ljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PR3P195MB0878.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a3::5) by
 GV1P195MB1620.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:63::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.28; Thu, 2 Nov 2023 18:56:39 +0000
Received: from PR3P195MB0878.EURP195.PROD.OUTLOOK.COM
 ([fe80::5e3c:6010:6ee7:e299]) by PR3P195MB0878.EURP195.PROD.OUTLOOK.COM
 ([fe80::5e3c:6010:6ee7:e299%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 18:56:39 +0000
From: Robin Dos Anjos <robin_1997@hotmail.fr>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: General question about "git range-diff"
Thread-Topic: General question about "git range-diff"
Thread-Index: AQHaDbc9AahPo/u4nk2yXD+mzwKkwA==
Date: Thu, 2 Nov 2023 18:56:39 +0000
Message-ID:
 <PR3P195MB087847E68AD2032148EFCA039BA6A@PR3P195MB0878.EURP195.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn:
 [vb8Gw7V/5bIVbUmQ6keEoeK9ztLkxNEYlnaqBLx8nN1wuIRjF2dhbdnUVMSmQtrPZLfHPc0aYEs=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3P195MB0878:EE_|GV1P195MB1620:EE_
x-ms-office365-filtering-correlation-id: 58cb64f8-9aed-46b7-493c-08dbdbd5723d
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MGQKwpKtwz+c4LSO9oPwWmr/FIIkUf660uzeAEZmh5Q0i5UeHSmP+xraUKwNnEeexhMF+EmgZSxRJR3ZaMJuTfbd8oxdzYWGu9d7zfBwYrxEFJszmEnXwTxrSFLCGMDZx/olKCiEpqMzM1SElOIkdikBlmxeTeFgmRmvfFK68XJA6nrxjfL7QyaOxGB3MlYxNzjvdedTNJFe7mH4+TH1F7JguW86IKlX9O+tOfS22PFJ/eOwtZl5Rlnst/W3LiljAj9sFiFBVyVYDKoLJuRLXetZesMdaSLnFEnnuVNU9pcAiA9edJhAO7JBinR2U2sRNtu7MCXvzr0PBD3slrvR0VTm1uYLa6R45miaQumrXV4s/bPG38Xu5uZaNOM+hDlpzAI965HRGuI1HQrp41FBtr5f1wrvMI8Q8fbfJ4B542Om/7EXxLX9gbTcG6IAg8XpZmNTakjxzUrZaUYBl6nQk/ZHIjGzjuT7rDNycGPQD1U44I6hhjkKcUdmiwhAU4ojTJOsPux5Qiqu06jE8fX2ac1BH/Dr0LdjA4hNxzQRsOnqDUXzR+zNkpjb3yGHf8qeiq27HlCSAArZF2u5o6vQoL1TD/8znm7vwAz8ByDM7QA=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pZW+D6wyWyz+s5Lj/Jd5by9EPZflI5UF8sPczIxwUrEXHtWIsKqg7JgbLc?=
 =?iso-8859-1?Q?NYwHlzEUwITAl4efmniIomxtZ/v9Xkjcr52WIoZmE8Q9NI5Vj+B9fpP8CE?=
 =?iso-8859-1?Q?E//4WSTlCa565qR6WXbdaoP34GzINRcIcSgb7uSG8cH/A9PKEfBi1q0Hs3?=
 =?iso-8859-1?Q?UQ2iiJQoQ9uSWwxaZdE459V7ajd9zrPMImeHaqsIlClXy7cs7WOWjP1EcZ?=
 =?iso-8859-1?Q?cQ9SCHwR463zb/g/z+75WRF1abMDujH2KJkV0vJt5h1YfZIQ5kGAIuTYbL?=
 =?iso-8859-1?Q?uxTaWWVOzYRzn4ayd9VpuV9+1LogKCHwGjO1RSNQRlPcVuFobooVBhm6Qu?=
 =?iso-8859-1?Q?+qI2lle6TmmHJZFhM+HlZ2L790qF1I3NOno8MzWSLEGYDxXt9CNdy7cYdp?=
 =?iso-8859-1?Q?ugTUHgPCXjkwrfSHPRp19/rgwdEZl48i8vXjWt8n36vOODi1r/ozwgD75X?=
 =?iso-8859-1?Q?W/hLrjLgZIJ1z8jYwas938/GgywoQCgqGpEKuyes84j5En1yt2XuUNUG+x?=
 =?iso-8859-1?Q?0+3QYB7gMRr2D2UZhB/1XlvXf5no6ooAwACZPC/aY4FwVe0ktb/2NGPpVr?=
 =?iso-8859-1?Q?ZCgdeKQ+bsUqwNJSo5/IXq1FAsbSvy++4ka/sAxWqWcrPNzAuChhdVZKbp?=
 =?iso-8859-1?Q?EUhkhkaJvvPfEfFllB35WZ9X/SoXQGXWgeZnPSsPZ66sLwsEUarAQMdtyX?=
 =?iso-8859-1?Q?YlpTYtvLdffWbBofSOp4+vNFUxdVGURj8yZtl9jYtDbUVFkxlL8EbPtNbp?=
 =?iso-8859-1?Q?D4chEGfq1+SyYjGHPIpI3n7R85ULxNMSMq4x7jimGgUDm8Z5bTjzLQebSq?=
 =?iso-8859-1?Q?f2iJ6XFiwi9fVlX4zWFZFkX8dbXskQmCZYH5gJ69bLev3vqNS8JDTITFbG?=
 =?iso-8859-1?Q?7XS2TEqxjqZY1utr0jiqT+TujqshlVW0mws/l5M38yNeOkVmDMw7xi2OCj?=
 =?iso-8859-1?Q?/dRkY5zPxbCVsdZqNGHIhFdlTtUxB1mwlxbUBFNYVUYAwGUJv6VPXsWUoq?=
 =?iso-8859-1?Q?0aoirDAjD8CSkDp3Pk4zliDcNAoZg1GegfYznxvQsX2FRVSk8xcJIv0Aq0?=
 =?iso-8859-1?Q?lyggpgHwLNjHyf4I+txQYT8jpGLo+AiBtKFljK2pASSu4W3jCADw4COH4L?=
 =?iso-8859-1?Q?qVwegehQS838gIOi7cYCeTQBxOlAn+rRC5ztDUNxOEgQp7msUHEcD4zjBy?=
 =?iso-8859-1?Q?vo5wLF+1/0c0Q4Bjdl1T3/QG/kxzwuW57bDJPk7bzDWcM1FEPNrWlSRsKY?=
 =?iso-8859-1?Q?T2tUHe0nIGLJqnIov7aVo9QcIkue75PCvZ2CAbS8J95WiYyxwMAdle2R+a?=
 =?iso-8859-1?Q?R4fZlN2jTF6CjXAooEdmnTLyBQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3P195MB0878.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cb64f8-9aed-46b7-493c-08dbdbd5723d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 18:56:39.4070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1620

Hi git community!=0A=
=0A=
I'm a bit intimidated as this is my first message in the mailing list but I=
'll give it a go!=0A=
First, I'd like to say that I've been using git for years and I think it's =
a fantastic tool. I always learn new things about it. It's so powerful and =
great.=0A=
=0A=
Git 2.19 introduced one of my favorite features: "git range-diff". I use it=
 all the time. Whenever I rebase a branch, I check that I resolved conflict=
s correctly using a range-diff. I avoided many bugs using this strategy.=0A=
=0A=
But there is a caveat. Sometimes, the rebased branch contains numerous comm=
its and resolving conflicts commit by commit is painful. This is particular=
ly true of long-lived feature branches with multiple people pushing to it. =
In this situation, I usually squash all the commits during the rebase to re=
solve all conflicts at once.=0A=
=0A=
The problem is that I'm no longer able to use "git range-diff" after such a=
 rebase. On one side, I have N commits and on the other, I have a single co=
mmit which is the result of squashing N commits. "git range-diff" won't let=
 me compare such histories because it wants to match commits one by one.=0A=
=0A=
There are several workarounds to this situation.=0A=
=0A=
The first one is to squash all the commits before rebasing. This works beca=
use I now have a single commit on both sides. I must say I don't really lik=
e this solution because it requires creating extra git objects needlessly.=
=0A=
=0A=
Another one is to run "a diff of diffs" manually by running multiple git co=
mmands successively. This is the approach I have chosen and that I have bee=
n using for more than a year now. I basically dump the two diffs into two f=
iles on disk, then run "git diff --no-index" to compare those diffs and fin=
ally reimplement dual coloring by hand to display it in the terminal using =
less. This works surprisingly well and is usually very close to what "git r=
ange-diff" would itself output. I shared my NodeJS script which does exactl=
y that on StackOverflow if you're interested in the details: https://stacko=
verflow.com/questions/70416396/how-to-pretty-format-an-arbitrary-diff-of-di=
ffs=0A=
=0A=
What I like about this is that, first, I don't pollute my repository with g=
it objects that I will never use again, but more importantly, it's very ver=
satile. I can specify the number of commits that I want on each side, and I=
 will get my range-diff between my two arbitrary histories.=0A=
=0A=
This is a quite different strategy from what "git range-diff" offers today.=
 While matching the commits one by one is certainly useful in many contexts=
, I highly appreciate being able to opt out of that and switch to a patch-b=
ased range-diff when I need it.=0A=
=0A=
This is so useful to me that I'm wondering why "git range-diff" does not im=
plement this behavior. We could imagine a flag that would make it behave as=
 I described. Is this something that was ever considered? Are there any tec=
hnical difficulties that I'm completely missing? Do you think this could be=
 helpful to other people?=0A=
=0A=
I think it would be really nice to see this in git natively, hence my messa=
ge. But if that is not feasible, I will still be happy to have my script!=
=0A=
=0A=
Thank you for reading my lengthy message and I'm looking forward to reading=
 your insights on the matter!=0A=
=0A=
Best regards,=0A=
=0A=
Robin DOS ANJOS=
