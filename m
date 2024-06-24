Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2115.outbound.protection.outlook.com [40.107.21.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D098BE7
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719207983; cv=fail; b=IqRg9lSXW4G/i7ds3gPh3kln6j9+tET3ZEtJUpstpH3vwME2KuC0c/uxr7Z8dCmfJk377I40IhdbebkZelgYbyIvASYo7lB0W+78sX0s6Y3k8sy0yRPlreYq/FTRafpPUZwT6sBAoNcyxn24dUPUMm0tKNCkjXe73dc17KpPXAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719207983; c=relaxed/simple;
	bh=Ozu1h+HYIBJ1GUOifDKeBSPyiGUX3GcJjEHgyH3QKNM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RjlRS5qnN/TUOvqQhCNSFU4vhQ3VbzaOnE+J73pdi/5xcsfgU0wDF3WJV4OMLrwPPmCRQ2sibZKNvkmbonZZxFXpFeZf9LHCZ8T0dMbmTi2u+c91roxorDODsAKdToIO82v7btGOp+WxoFFcR7jLfbzf8N9n6Kl2u23zLEwDM00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axway.com; spf=pass smtp.mailfrom=axway.com; dkim=pass (1024-bit key) header.d=axway.com header.i=@axway.com header.b=Hy8ZpN6N; arc=fail smtp.client-ip=40.107.21.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axway.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axway.com header.i=@axway.com header.b="Hy8ZpN6N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIYIYxzhsCpE8R1lIQnjJOVGo7mAMAGgc99BnhUl5eZJEHpKkK0guUpZ8+g/4cM+9EDcuobxbMtsu7R2i2Wqs5jUM/CCb0tHy7/cqNjyISEJcbz8BLRjsOAMVaGx6QZK2tJxvYBQtB2WA5RDsHiqKX04yz7NaWG2citOaHxeXzQLrQ+ImW7+WUgHerW8y1PgcIpvAOpRSPpTiPpr54wxnoNn9eSQFalB8/hboKKwr8SQq6C+ENkgVjTSJcwgK04++Bz4tGLYpJoQCMlOdg0//0RCmkFwV7aRvoQKK2fUWOSI50xiHNi4UQSf8SbAPBfG4sYjwKhjkgXpemzQcUQOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ozu1h+HYIBJ1GUOifDKeBSPyiGUX3GcJjEHgyH3QKNM=;
 b=J6yLoAgepqisJ0b/JlwiA15pko9ZtG1R3kMjPhl5taviRgGMz55CytmSvVqxG/nSjJ7zHJ/JWueXWtm3xEPl2m9FkONtfPevtQlIbIi8A5qeFH6r2+Rtvu4vTbJZVC80w66we6pdZqa8wVxjBljzBIcsbm7xeQlX+I2ymUm/1Q2uHZSsBWKocuisS4kOxWWZ/wavnte+0Zj2e7SpoS/oo9ZZzrb5rM3L+GGnvC/UGnxIuRUHfThb9CNJ9QGSLNKo9bDvUxXyU/gH72LOUS5oUe2pC9Fm7aXm8kL/cFF2jtmnXH+xRVxasMtDNlOAeGfdvb4P35rbcrMVG0T25QEksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axway.com; dmarc=pass action=none header.from=axway.com;
 dkim=pass header.d=axway.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axway.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ozu1h+HYIBJ1GUOifDKeBSPyiGUX3GcJjEHgyH3QKNM=;
 b=Hy8ZpN6NgI6FL5Jd+WuKeoN7O7PeJ7yu1Zyj0uqtsnBSHwvq+z+2syyY7ysP0sqfTcu6xs4VAaAgYUJj/4GFMEh9MW2N5P3DpmKvLx4Kd2P+L9WeZrULxCoCQcjBBB0yUgmfmpUDmST3/W6LZRE/JxP+ZXthl+UJ9MyFMAUD5PQ=
Received: from DB9P190MB1500.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:241::20)
 by PA4P190MB1358.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 05:46:16 +0000
Received: from DB9P190MB1500.EURP190.PROD.OUTLOOK.COM
 ([fe80::ae53:db19:bf45:8560]) by DB9P190MB1500.EURP190.PROD.OUTLOOK.COM
 ([fe80::ae53:db19:bf45:8560%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 05:46:16 +0000
From: Arpit Gupta <argupta@axway.com>
To: "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: RE: Issue : Writing commits into the git repository takes longer than
 expected
Thread-Topic: Issue : Writing commits into the git repository takes longer
 than expected
Thread-Index: Adq7H1VaORjtBCCsTq+BTs/ioNM+hQAFpWWAAGEWXNACT97y8A==
Date: Mon, 24 Jun 2024 05:46:15 +0000
Message-ID:
 <DB9P190MB15007FCFF0CF7F85CC800EECA7D42@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
References:
 <DB9P190MB1500D7DE16D758B8710BEFC7A7C62@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
 <0e4b01dabb35$eee8b5a0$ccba20e0$@nexbridge.com>
 <DB9P190MB150014507C0231112C78736DA7C02@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
In-Reply-To:
 <DB9P190MB150014507C0231112C78736DA7C02@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-lsi-version: 1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axway.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P190MB1500:EE_|PA4P190MB1358:EE_
x-ms-office365-filtering-correlation-id: 2a0a3e90-e4b1-4928-e0a2-08dc9410f6d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Qv96WImp7NIW48G5JdNWDInwI8jeLriXXIG5mHOuXan9N/d0AehvhzWM6T2J?=
 =?us-ascii?Q?0FHW0dgEPSTw8tLVoZpaiIZ2/+Losigkj/dFQgIDE5lTMT4dop7Wg0Z9Vv6i?=
 =?us-ascii?Q?9PsjOrIDTe1cD04WbbeuGulhUfoqPqo9o0SYuUUOHrW9KCk2hXAV4T5A/KCI?=
 =?us-ascii?Q?7EOD7d46Nv6CM0INfXEFJQbTDW9doOacN9GNCsW4n2wihNQsdAsPyXVZ31Rr?=
 =?us-ascii?Q?79A0epTsITR8f08O+kSUWlqIRH6XsGkRr1k5frwqadYkawAT3XFW0lr6MIKN?=
 =?us-ascii?Q?dtN6cx8bIpboAEaig37xZUpRAELrSAr778de3UctYrmpwiKRYRQ3BGAswMWj?=
 =?us-ascii?Q?BSLnOLAEHG63bOL/PIU7XWs/xDOPhMlojlDbiDYE8NldXiiqgmXtP4Z4ndBs?=
 =?us-ascii?Q?O+IoH5kDw8KPWS2N22eVDsa4BFhNyd82Y4CqsshwsuWvLePzQFCwCHbtOurF?=
 =?us-ascii?Q?I9SBc1uP0fT0Ota7wfKHXLaPfJ4TG1HR3likE9yXHjhSKccfNFHbXWrQ3K7v?=
 =?us-ascii?Q?Qbpn43GxfMb1NRJLhz/ugzD8ku/kErD2yG+Ob4xfQfpWTcZsoOUiaFN/InM7?=
 =?us-ascii?Q?fRpz14VD1C+lmUvsAk60FZrmcZ4DFgfWz3gg+bLIngkFQaZt0JdALMZ/fpQL?=
 =?us-ascii?Q?apFZd7KENjjW9+t1P8ATjQaPdfCWDZAIhT0wkEbd4VNH2qm1evTmsfYIJvbR?=
 =?us-ascii?Q?TYgPojiUqcvviTXydPPLcWJK2+izEzPReNlUcR2EaUUysK/vy8B3JmSelj5A?=
 =?us-ascii?Q?+3QJwyJ4NXm8JitRlsVAbQs9QMv8AFgEBJTLgnLf73vZlNnK+p1Xgbl6mqAj?=
 =?us-ascii?Q?/66cJNGMopan6qwGKwJsH08txt6rKsKHMueb4BDie63V+L7qwbMeAs/pR/Pb?=
 =?us-ascii?Q?YErLkCGvCkVm8imHWl7sWW5RA/Vbcb8iF7r5/W3InvfaSJO2eBzVq5dPW2L/?=
 =?us-ascii?Q?OVRZBdYUQBAQ2dtSx0yDIaYWJrp65oGq5L3opmFRkl4r8aNGoY1zkLPQirt+?=
 =?us-ascii?Q?GykRN3e6UXJOt9i/GbA7JAKFspTm462SQd8adweCL5yHsqpycmz+IzIZD3kL?=
 =?us-ascii?Q?HyVHyggds3YcxowjpxuCdfUr70vqUwGlUyz0ZTmcQe4IryplUNms2WkDFcbn?=
 =?us-ascii?Q?HyxgRRupcDTYpmdb1/Qx5izMDHDj3MztYknh+IySaoa1fj0kEhLKVutZx0y1?=
 =?us-ascii?Q?IFJlZomrORCU9ZyR1k19PCy8S9LY2BsXQV5q/MypoKVlkn/Hf8aIunngPEzH?=
 =?us-ascii?Q?SFXBsSA+dh2yI6Pd5hsDeuJZ2vg2fsKpOHtcW1mSoOdAdD74zPDxDJENGcOp?=
 =?us-ascii?Q?y3xnPTStJgm2Xsp5TUc88ygO1yvJPvnUDCSdyVZWB/zqP74Gp1/Fo2Mux9hW?=
 =?us-ascii?Q?XmiVyZc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P190MB1500.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lSNMdZo7Br4VY/gDpMo/d9KpkO5sdpGlHXRuzAdKeYYruGPwacTVT2rxu/yI?=
 =?us-ascii?Q?UFZoM+2uEwMV7d44XvG2RyJmDBudaGJttD87lfW8PFHFaGfBF8XtzguZuZt8?=
 =?us-ascii?Q?oC4dtJEfz04JwrY0eZJ5miRQMQ3z7UI4jy0orkOHPRGwwtMWETAC2Fg/Nbpc?=
 =?us-ascii?Q?aqlqzIYRQ0+Nb0Od9xNKWI/EzuafKzRv3uLJwyyAkMP7SnNbQSQJKIgys1ys?=
 =?us-ascii?Q?C6o+78daaW+PC6Q8qOL2/fcAWAy8yNHhx6xW3zRW4jnIpwHqZ8n0Awzz2xTO?=
 =?us-ascii?Q?meiFblz36wCK5mgmitSDO3ZYT7oOZJPwB5KPXCHFCzapj2q0C1IlZvpohm5M?=
 =?us-ascii?Q?FjrWfDEz265t/tP7M5QULo5T4Unx3yXP2bsINTL6y+w4OD8K1wcT0z8V7fIw?=
 =?us-ascii?Q?tILE7iiP7ayAdb+MMPKd0Lr2sL1SifOve/T86zi5ExF1Tt1W7UH8OuyY3E4I?=
 =?us-ascii?Q?T5rQl+U1GRt9VZrIDX+bwYrdsqkHovivu6PYzFMFPEeFoXx8bWKZCkqf8NBi?=
 =?us-ascii?Q?M++EP+juqA4Fz5lDZfgq18DvMWjHBsG2RsaAePodQgKJAEqXGyw/r90DzckB?=
 =?us-ascii?Q?r4uKh9Q2AaXbvwVzAqXaxooOtIvNyxk206vNOKRs6qnO69slkoLNP3j1I4dx?=
 =?us-ascii?Q?C5BdxryL1Z/zpyTR8hEvT01N1R2DPt+ZhLhgeUrgpQ9yWi5cg2WD9PyCsqnf?=
 =?us-ascii?Q?vaTcIwa0aXE52S3vfxaJuQHsKSIsom2IrqdNYFZaPQLV6ZGMvj37tFSdfS0q?=
 =?us-ascii?Q?Oln7drXI2ybdWDVuYFxdHNbS2/ShibXsvOwNoM9DuwvU5h7+zVvMWwuiKgnO?=
 =?us-ascii?Q?Bq3iiHrMMW05I9CziPWAPUpiY+fH/WjOjW43c51JQl7hjChAKBUR1zc2PoUp?=
 =?us-ascii?Q?OH5dxXIpUAia/8jZhUEceSX/KkUGhcsh9fB8/6PJbTNQS4YoqFEAcMQhb8uP?=
 =?us-ascii?Q?KywO9a9GgCtPzUQ5kfMgVuwSvMK67OXSzgCPx6T9b8cuPDaNpz0ZZ6g4FTW8?=
 =?us-ascii?Q?2LTVz3j2V6CRUiTM7I+heGh2+IR+6tih+Xk/hvIytLLEo+HMIY3nNCe+3bB2?=
 =?us-ascii?Q?KGXLDG0N6lKviBhuMbrZnIvP8dn/swkkczU/fwdhu0xw6BQLUT8ObXB8xUCc?=
 =?us-ascii?Q?WqybnRebV72xbqT+Np+7zv97su9Z7gsTvwsnrPp0sYUk+2AXOX7ltxi5gwx2?=
 =?us-ascii?Q?ACxidc1PaeDdq6bfJ18PEhdSlpyai3WFTn81VNiE5p0HPmiok1whMjvce8S2?=
 =?us-ascii?Q?quYEBWYDw+WoXSFRokkLvZ9NXC1VJ0c3W2VfjLiTM965yrIarIwKDNLYokv3?=
 =?us-ascii?Q?YXxN5Dp0aTHSHop3XeClPrO4ZorMmN1/WXndytBzicxqrgbOPSIL8y2T6Qe3?=
 =?us-ascii?Q?5Ir8oJjkxNCZ6efmBtZFhfJ4K9RQyKwc7ukkRIJhud01nRcixX9UseSI4A5f?=
 =?us-ascii?Q?UtGQv4yOx+KdWKlSGyjsvBsEH7eIJ0pzamXZAw2+Bwy6PT/CffSdD6S3/ijQ?=
 =?us-ascii?Q?NCSnTOBS19GC9uEechRO3YX0lRk52qotLRG/XdHthlHzGPgCW1cXJEf90p11?=
 =?us-ascii?Q?ozf7I1qrs8sg22w2Nzs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0a3e90-e4b1-4928-e0a2-08dc9410f6d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 05:46:16.1133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 300f59df-78e6-436f-9b27-b64973e34f7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54c4qqf2KAYK7BpXoAdd4pZlW8emuIIERO+HMeMSyQzvcx97hH1+MIcinRakhkzcUAeIM4y3WMeRtLYYtqztZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1358

Hi there!=20

Is there any update on this?

Thanks

-----Original Message-----
From: Arpit Gupta=20
Sent: Wednesday, June 12, 2024 5:15 PM
To: rsbecker@nexbridge.com; git@vger.kernel.org
Cc: Anuradha Patial <anpatial@axway.com>; Madhurima Pandey <madhupandey@axw=
ay.com>
Subject: RE: Issue : Writing commits into the git repository takes longer t=
han expected

>> The XML files that are being written as content are multi-line. There ar=
e 2 tags present in the file and each tag are on their own line (one tag be=
ing the child of the other). The file size isn't large. It is hardly 2-3kb.=
 Below is the sample structure of the XML file being added as a part of con=
tent:

<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"yes"?> <ServiceName =
type=3DServiceType> <property>PropertyValue</property>
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
From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>
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
>the repository and the XML file content is over-written every time.
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

