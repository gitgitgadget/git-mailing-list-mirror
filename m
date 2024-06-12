Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2109.outbound.protection.outlook.com [40.107.241.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4851420B8
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192719; cv=fail; b=XnZf4d8kNOum1Nahg8EFy6LIS8hJ0Afcp/RAw69gjfstzb4U0u4DYyh5wzvtWMNsiCOI+hsPzUas/FLUVDjJmKK7YnvcmS93XMbNw2AkiLVhFByKwNdV6WZjvOu575lN+Q2QYeGfFLCKLxSX2DmFzLlBp9Yr0vnT8sdA9QrV3Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192719; c=relaxed/simple;
	bh=6aEwW+7ftgfxSNXXC2B7JbjKsrDVsrPNQBo9g5LkpDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gR2NAlvrX81H6xpFq/F9FxIfUZROflJlDtM0h3pWue4o11+jZw6rBjKtHa6LmDAjzLozOT8KMxSqGm768XUf1VQazS9Rq+WFyOZ/ukKElA70zCuKDQe3mDBk00sBemelmiZ5BjcDAfeWxiiIoxei7J8ecHL/3GMo6EqIPoyP0Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axway.com; spf=pass smtp.mailfrom=axway.com; dkim=pass (1024-bit key) header.d=axway.com header.i=@axway.com header.b=h3WCl/8g; arc=fail smtp.client-ip=40.107.241.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axway.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axway.com header.i=@axway.com header.b="h3WCl/8g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMFbMyKPj0q3kZNCIz72areEbyalze+UWA+r0iuA0b3BKOXQeS+sZnQOK8e5BYfFWrBEl6xvHZoai7/43IXrcn4xQa8YA5imKt65ELKVP9KsLO0pGOccxO3anplLXwrcML0tcCuFTB2vOmFBC5ewTSQPptgbO22A/GH/7xv4ecgyE3wsRLEEXh3nfSlMmy0Z1Bg6KbTXLAtiAE7H9VjD0fr4LxegCQMk5Sm1CRfKBG/GKxoBz5JrUcJMtMzD5kbrroKE0pgQvADlGWtTbZMv5mzo60QYjLjuRA9Tn9tp0qCJBQZMMa9YVRdurqBNTN7B4/twcT6mKrGzjvWIraN7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aEwW+7ftgfxSNXXC2B7JbjKsrDVsrPNQBo9g5LkpDQ=;
 b=hQBitSdfVtKSUiAvRJ3BjoPdWCamdpgDwYQq08C8WJvyTHz+tSM1Tz8QhZUZC5XMPvr46NvNNY50J8klj3swH0Hio4XgOE0O70/XKB2tJolS7JfR1n4k1kcU0U/tNDnxNjTc55MKiiVoKD+2f/KZ9TS6Rciuid8iMxBu4B4/IHTemXdPnb91vlFxh7jvZoXpQF3kuxCa5tu7852IxDLPU+a649kYdX97VW3/pAWGdjRG/Cf4qzOxnBD0Lck/DW9o5AgyF/u2ohACJr4ifzIWpdkxa290wvZTTnRmNViTeY3LwMU6+aHajHpDamPPi1gkG0gIGQOASXMNlT3KwJy0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axway.com; dmarc=pass action=none header.from=axway.com;
 dkim=pass header.d=axway.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axway.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aEwW+7ftgfxSNXXC2B7JbjKsrDVsrPNQBo9g5LkpDQ=;
 b=h3WCl/8gSClvmd3YMCUEHLtaV9YwN537eMvdbI4U9hI3QOpvEVk0EhCGbOOclAGJ54gKxqWwLXVJtqr9hcHQxMecYxTTisuPLQRhZH+fA5gZXkqpa8PgW1PwRXV+1CcZuknbNo5LYeDGVjpRtYR1wAJodajSFbE7joLYZO5y0zQ=
Received: from DB9P190MB1500.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:241::20)
 by VI0P190MB2211.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 11:45:04 +0000
Received: from DB9P190MB1500.EURP190.PROD.OUTLOOK.COM
 ([fe80::ae53:db19:bf45:8560]) by DB9P190MB1500.EURP190.PROD.OUTLOOK.COM
 ([fe80::ae53:db19:bf45:8560%5]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 11:45:04 +0000
From: Arpit Gupta <argupta@axway.com>
To: "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Anuradha Patial <anpatial@axway.com>, Madhurima Pandey
	<madhupandey@axway.com>
Subject: RE: Issue : Writing commits into the git repository takes longer than
 expected
Thread-Topic: Issue : Writing commits into the git repository takes longer
 than expected
Thread-Index: Adq7H1VaORjtBCCsTq+BTs/ioNM+hQAFpWWAAGEWXNA=
Date: Wed, 12 Jun 2024 11:45:04 +0000
Message-ID:
 <DB9P190MB150014507C0231112C78736DA7C02@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
References:
 <DB9P190MB1500D7DE16D758B8710BEFC7A7C62@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
 <0e4b01dabb35$eee8b5a0$ccba20e0$@nexbridge.com>
In-Reply-To: <0e4b01dabb35$eee8b5a0$ccba20e0$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-lsi-version: 1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axway.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P190MB1500:EE_|VI0P190MB2211:EE_
x-ms-office365-filtering-correlation-id: fc387781-deb7-41fc-a256-08dc8ad519a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|1800799016|366008|376006|38070700010;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tVh/3EQbSjrhzknWxneIGQSWZ//CUh7lcVzmb3SGhN+AaFKLdubX71Y+5tBB?=
 =?us-ascii?Q?tcpNbmCudNHLWSL77FGrtPBWV7jHMq/Pa8+rg96pkMcC1OKt+dLd/i9r8v6U?=
 =?us-ascii?Q?po28fCN4Zm3WapAwIr1bf9nw5ZtvK87ktOGXG3KpV6b6Srwc9T7iz3CNW/Gs?=
 =?us-ascii?Q?hHXFkwP1AqIwwFpfnlUncRKPFnnsHCQ4/c6204ymFKdPsxoyIvpTos25HoYm?=
 =?us-ascii?Q?qD4suGlBiJmHlSjoAJSComqzJSKY+ZpNG2eY47XdwU9ppM2ga2GSzJ/l4k5b?=
 =?us-ascii?Q?44OEQxxD6ZqqFvGMKUXROwUkFMEmartsIWFzHe31w2Mk5MjZxtvpyCu9iCT+?=
 =?us-ascii?Q?mCM7D7CMx/X5R1Nv4Gp8LKFnEfniCIKeN25xMciPJfY5qPuZ1eCGHAYqjlU0?=
 =?us-ascii?Q?3zlzi38I6ZQ0sPRibkEtaMqcxrV0HfbyuXabhkaBvQWBwXwfCkwaHFhatDMz?=
 =?us-ascii?Q?ODsfsGF9x+N84vrv4WRg0E9/dfl2qDw3aOxE36A7GUBjKPj5P/b/2izjE8BJ?=
 =?us-ascii?Q?T/tDn+BFpFQoiwFXElaGy/E1GKxDhCBYjVriKDdlWwagXI1u5LHHmc8ELe9b?=
 =?us-ascii?Q?towrc6uBZWBBWk5oZj1/1AnuyGaKky1D4mczDkITn/jflko3NQizDsGj0Q+d?=
 =?us-ascii?Q?97p9UkfDOM0sJx+ziIeOCjutz3KvrHwV0vzK66/k7SjSdItpxZ8wRlp56/tw?=
 =?us-ascii?Q?t7Ay3VyOH1isjVBxy4MhKOalChxUE+rvqhSkacmziSeoIUxw6xLQVhN/ZT5e?=
 =?us-ascii?Q?G15eYaVLQKkzfsQSgc31lw5iSnMgnyKX0KeyALjX+JcTxxPcJkv9R13dmqvr?=
 =?us-ascii?Q?L3E4iTiE0fSLyo7pQj2WhDXb1qWUPbmyGF+6dTH/QQQ7YLw6hkb1e7JzA5pw?=
 =?us-ascii?Q?MN4K5vCENywDaVLuiH6rFXAHTFRckaQlI4vdA2l5gBUBYEU/TVfCsClXXUFg?=
 =?us-ascii?Q?krjhf8yawuT7MVzqIlnmMpgBAbczWU5U0bp3DrmN3gmhioCiG01AvtN5J1/Y?=
 =?us-ascii?Q?COx7kAdvdogY+/MmZ7RACr4tNd0pOk9Mj5Cjc+dubOjlgljk2/iEXTvPm+Ja?=
 =?us-ascii?Q?nj5lOYA5ZInYRPXGNm78A3VuVHt98QQOPNt/See4/p/ICtq+PIdqZkmwhHuO?=
 =?us-ascii?Q?VuRdZ9ZfnOYrOD8ejJbYSWoA+i7J5syXYeN4YqFc6NWugOpIHUbgZxHi+hm5?=
 =?us-ascii?Q?xL+v1qZFqpEN5jZ2uGGhcGUjc+qUDdGijeBnPsn9PnxPM7KidK/nJf5rArrf?=
 =?us-ascii?Q?y0WRJfstQupC1dAERChKB90KrqYLuPi92V2T+4C+uCIQ174sXywl/gyzB+W2?=
 =?us-ascii?Q?CtEmeOok81p5e/kac4bUDI38x0kTLlnCYBKhNiP+a+J8/q8HwHR+mXcX/OyO?=
 =?us-ascii?Q?TjLLtVY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P190MB1500.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ULKKpsOS4YrHaAtoRU3wpvj9GKFMrUXIifTAQ+T1mUzAmsnIvG3mPfwPFSv0?=
 =?us-ascii?Q?qf3/sD72PvO2FPUvhPs2GdSRTckgQL1XV5OitvCzFxO4/1dVCf09B1XkvNiJ?=
 =?us-ascii?Q?BSkWQ5NUof9toavuR5Q0Epot/RBarNK5SW2UEAwSMJcLRVo5zRE7DZXoaTWW?=
 =?us-ascii?Q?5j4bUKHc3rONIyhfR79kikw5S+QLbouYPp2QcVDVfM6u0oFQFM0MsFgeYbIi?=
 =?us-ascii?Q?Vy2JKmHZVbfSBqdfZ5G1rvAY8qImVrCEzmnNlHN3dFj89sygV/oD8rDeBd+4?=
 =?us-ascii?Q?ByrcFdGL/FiARDGEfaSmFUAo6704Y5jqNqrCPX91tcEBSx/r0OL5KPmwcxUy?=
 =?us-ascii?Q?Y+gzSJEKxg7ymoidwXByfF17G/ILT3dLgwhtuTzvMwuf5py7GSQ6Hk7dmC52?=
 =?us-ascii?Q?EiDH/vsfAOdg5VoH/5LqIuEbbNyDWMg4EOm7bj/eiQ9JJ1/IkA5GnkqBQqxj?=
 =?us-ascii?Q?PGXLenZIvK+ZNj+aPV6x2d9Prj3rhVcWuwueVuGVR/Yq4tYz+aAnyz7AGZlp?=
 =?us-ascii?Q?8cPy3vL1eDL9uQWtU+0bSs3lBbwIY4c43L50zw2t4VYHMif7VmGAFtnVbNfO?=
 =?us-ascii?Q?KH9+TvKUP5qBNHl34GPAQa/LjyHny7UbhKKjKThKUjGYjM83KCnrZsUlRbn9?=
 =?us-ascii?Q?MMtH1O8EbcMGHWL7yik6YPA6JR4LeAsK+jV8XD0uED/icFQORqqhJ0n2Fpwz?=
 =?us-ascii?Q?fNRE8YyRIZJTSR4LzxNVgMAeFtAcBOjKVYvilt2e35gRl9qxghu/yiW5hjQ8?=
 =?us-ascii?Q?+b35TN353Qt5F+KxoIyT+Tjvy5h4XOJGVvSCycMb/1Hdr4QurpdqFcLewiR1?=
 =?us-ascii?Q?AvFtzkFyMnvijEaSWuyI9Z6qvgTou2+L2CcjLG8npHfRYU3rhGRv6ZQIdVeQ?=
 =?us-ascii?Q?SzDBOs5e+wBFZBasK2OmXr8vJRY4M3/gV12XyViEpFVLStQEb15lBdlq2DHk?=
 =?us-ascii?Q?acv+dsZ/5faQba10yx1etZncaDqqKADtT+U3gZhYlnDef2hiZnWkLEhrLga6?=
 =?us-ascii?Q?G43Q9nU8CIq3HZZY142/cv8oNVs/JMLI3Fsubvub/EObE65NhjfZSmbPNlpg?=
 =?us-ascii?Q?NiGkNz+dthkFxlDbkUh/1f4KQ5twG4OOWqP1YdpN6IWeQLO+KFPBmRtciJvj?=
 =?us-ascii?Q?DNMenhZJgNCMF3UTUYTauvOjUmklCwN3SmObausCFoZN3Szpfm9VPNGye6I3?=
 =?us-ascii?Q?9uQWmIkzOoyuGEroUXsSdSP6H1C2lMBVQ6rwcTrqmfV9MzuBnZLTMBX5Zst3?=
 =?us-ascii?Q?l3b6XClm0YaZqk17gW4lTv8lLfOEUBDo8SFUSjoR23UDFuO9c/ipsjq1hyNx?=
 =?us-ascii?Q?LaqT+u/yTuRDgaJqNYVxgqxbsVRAbCzw5Kn6uSqqCfnJnuoJrp+JF2WYOebk?=
 =?us-ascii?Q?cjyZpzeJHsSWyrlZzCmxx0kxGrQ8YiqnMQ1M+62Ve4aHMOcv93hOeDNjeoeE?=
 =?us-ascii?Q?l0LEKvH+xbR/VnjaP9vwCz2wMs7qX6QsP7VAngd1PucxWTeels2YL5LDRJmb?=
 =?us-ascii?Q?taX9Ew0aCGyEEBeT4+oz2ApatHhWlzQhDaYvKyL5lIkb2NajlnHexvQiAYfc?=
 =?us-ascii?Q?8NL15SrZHpkX3jVyndo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axway.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P190MB1500.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fc387781-deb7-41fc-a256-08dc8ad519a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 11:45:04.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 300f59df-78e6-436f-9b27-b64973e34f7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ac+H38jtipr/ffUkJM9KEo3NuXft6wN8T8p7v7HsI1dmLH1zJLso2cAo6sc1YgXba64l3I4hCE+XThD6B8XaQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2211

>> The XML files that are being written as content are multi-line. There ar=
e 2 tags present in the file and each tag are on their own line (one tag be=
ing the child of the other). The file size isn't large. It is hardly 2-3kb.=
 Below is the sample structure of the XML file being added as a part of con=
tent:

<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"yes"?>
<ServiceName type=3DServiceType>
<property>PropertyValue</property>
</ServiceName>

>> There are no virus scans running in the repository. Also, the git LFS is=
n't involved in this scenario.
>> There might be a case as when the commit time starts increasing (initial=
ly from 4-5s to 30s to 1min to 6-7min) and during that time another commit =
call also starts as there is a scheduler of 5 minutes which triggers this a=
ction. But this will only cause a certain amount of delay and it shouldn't =
be the factor to increase the CPU Utilization.
Also, the machine memory size is 32GB.=20

The commit time starts increasing from 4-5s and goes up to 6-7mins, what co=
uld be the trigger for the commit to increase from 4-5s to 1min and so on i=
n this scenario since before that there can't be any parallel commits ongoi=
ng onto the repository? Also, as I mentioned before, this issue is totally =
inconsistent.
Let me know in case any other information is required.

Thanks & Regards,
Arpit

-----Original Message-----
From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>=20
Sent: Monday, June 10, 2024 6:29 PM
To: Arpit Gupta <argupta@axway.com>; git@vger.kernel.org
Subject: RE: Issue : Writing commits into the git repository takes longer t=
han expected

[You don't often get email from rsbecker@nexbridge.com. Learn why this is i=
mportant at https://aka.ms/LearnAboutSenderIdentification ]

On Monday, June 10, 2024 6:17 AM, Arpit Gupta wrote:
>We are maintaining the different versions of data in git repository=20
>using
jgit maven
>library. So, a commit is done on the repository containing properties=20
>such
as author
>name, date and time, action, and the file path.
>The file path refers the xml file which contains the action performed=20
>and
is stored
>inside the repository.
>
>We have a job running every 5 minutes that commits the information onto=20
>the repository and the XML file content is over-written every time.=20
>Usually,
the commits
>and writing of XML file takes around 4-5 seconds but sometimes the time
while
>committing as well as writing the data increases which also increase=20
>the
overall CPU
>utilization of the machine. This behavior is inconsistent with respect=20
>to
the process
>and occurs randomly but during this behavior, there is a time when the=20
>CPU utilization becomes high that all other running processes hangs up=20
>which
demands
>the restart of the server.
>
>Could you please suggest which areas should we look for while=20
>identifying
the cause
>of this issue? Also, does frequent commit of the content onto=20
>repository
can trigger
>this issue?
>In your view, what might be the trigger of this issue and how we can
proceed to
>resolve it?

Are your XML files single line file or is each tag on its own line? Changes=
 to single-line XML files can cause complete rewrites. If the file is large=
 enough, this can cause performance issues.

Do you have virus scans running on your repository? These can also cause is=
sues. Some scanners are more friendly to developers than others. Also, is t=
his an NFS drive? Is Git LFS involved?

If you have two commits to the same repo happening at once, this can also c=
ause one commit to be delayed waiting on the lock file. More info is needed=
 to comment further.

--Randall

