Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2115.outbound.protection.outlook.com [40.107.104.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44C4A3D
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720757451; cv=fail; b=u4qQS6YhEiIi4Y0vVDTYPbwaFVw7xJM6E/iPl3rT8wV5YOFW9nV6fWsTkXCQewTD1diVup1PjE62TBlMlnz4UX9660VDRVa5PBvruGzq8DUhmiHr3nENzfcgzdV8kuGkkktqBPUZdgegY9yMVNS5OA+Q8Dxnazv1Xde1L9lLB7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720757451; c=relaxed/simple;
	bh=zEwhhvvrWND6+iBq5wSfxwrg2cUUnGrt8ECCxvXppSs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KKqxXsA81LxuH1jeT/groXKoxDuOc0Euji60ErF9vCVh+KLSM4s9b3kwHMjkfZ7jIHQm6ksJ6nVsv74AcQg70agL+bZU+0Cp8rNEwr+5GdGCri1pu0VMoR1+V4eJzLZzIt1FGkVB2N/eMav2Jo4pEyiPPpmStUvEOdn8MvTkOM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axway.com; spf=pass smtp.mailfrom=axway.com; dkim=pass (1024-bit key) header.d=axway.com header.i=@axway.com header.b=YwREm/Ep; arc=fail smtp.client-ip=40.107.104.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axway.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axway.com header.i=@axway.com header.b="YwREm/Ep"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bahUoDoj7YNxpYEPu4oZV5xm1FTBaloK6WycQicucKVs9jhnOXVLSmuHoE07hkawlnP5C/0fSl/2EEywSLBNNf7biQWppprmRrD61sVqkOLSeLLC6uY9BE+HR7AJ2OW2a47Lb7Ts9ck3PiG9JkveiPjomOA6bbEaqSwjFWWogA+egEztN158MGb9BzUDOKnljiK4VSllrzGnbe2S34N0cSFqm0Tj9dAIW8Q++cdh9lfBjmOJQIDzN7Oqhkd+6+an7XTViu90qUqouFX9mLLlHDiA/3mNYO/A1G6EUWqSBEz6Y9e/1G3eRHYB1p3lvlpFO16/+2uLg+tFnr6QcN9KLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEwhhvvrWND6+iBq5wSfxwrg2cUUnGrt8ECCxvXppSs=;
 b=rMwVa+ufyL6gXzN2D+8iIYiBcAYe1fbM//g0qde8K58ieVX2WflxplaXJeDOO4wxtJ8qQAWwUPI6Vx0Q4bVCnNTr3Xk04FPntHLuBUHbPJDaJeJOPOGMAEn42lm4hIoDv7QYnAufYPoC+OgJWPnWPVJz00fc5h3ig22YLYipAIIloG3UiglJPX7DCv5sKFgJSJlSsTixLuLCGCNQPTw/dGe2XmSZHD3WYVozfJ0X6LZqsArWz0UU/9q7TZK7hM0+/V1qod0m5wm80szgxZxnvxwGRU7F3JImPoNVn+9Hp3ZC8SaNKKpaYe8CX4r4/pk/2tjvR2VKBjVzUD9aOGqOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axway.com; dmarc=pass action=none header.from=axway.com;
 dkim=pass header.d=axway.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axway.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEwhhvvrWND6+iBq5wSfxwrg2cUUnGrt8ECCxvXppSs=;
 b=YwREm/EpLrNR+TjJfqoUzKcrWW6K6IeCg/8/hHI9ldRI7iq7TYVu9yfqDLTbCoMN1uk+9fcEjP1OrYfBbVmTfSBnAqlSqmRnE4O/RFoAceL/Fsgg5lixvmtdtSfXzFftEcKv3yqA6jujR5q86AxgSZ/1PnWrRHkLJ1SvR5Mwh1k=
Received: from DB9P190MB1500.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:241::20)
 by PA4P190MB1311.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 04:10:45 +0000
Received: from DB9P190MB1500.EURP190.PROD.OUTLOOK.COM
 ([fe80::ae53:db19:bf45:8560]) by DB9P190MB1500.EURP190.PROD.OUTLOOK.COM
 ([fe80::ae53:db19:bf45:8560%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 04:10:44 +0000
From: Arpit Gupta <argupta@axway.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Issue : Writing commits into the git repository takes longer than
 expected
Thread-Topic: Issue : Writing commits into the git repository takes longer
 than expected
Thread-Index: AdrUEVkwgFM2CZsnR1WSBief/Uniew==
Date: Fri, 12 Jul 2024 04:10:44 +0000
Message-ID:
 <DB9P190MB15008877ED559C3ED70050E3A7A62@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-lsi-version: 1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axway.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P190MB1500:EE_|PA4P190MB1311:EE_
x-ms-office365-filtering-correlation-id: 5c6ca3c3-e462-484b-3567-08dca2289a2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xpepkmoL28/vhqOzSeTAF8ciGZDbk7YCaOe9G6E9Hg3Kv+PwyFTUduKyp3T9?=
 =?us-ascii?Q?Xoqqvte/fCM43nVyUmGlsdFqNF5zkx/THGbQrBeAzp3SuDoTrhjgb9Zcp0Rd?=
 =?us-ascii?Q?P2lZcHdOcMqxPFHSeUxCbIj7nq4DyIGttUpbuiR6BUXPbZZeLo7+06fBwaHq?=
 =?us-ascii?Q?J0LgyltK/5SkeafTcU4Ldee6dho57d6k50umfNCU3BcdWG4Y5VF7GTJJ+jLk?=
 =?us-ascii?Q?BYBI2jqhkfu7dGTxR9zexfd26LPPIYdCF5eoCD6b1TA5H0HboLG9aiKKcwi7?=
 =?us-ascii?Q?MF1Fks9yCMXNZt+ngUv6Xl+o5gVjFKl8jkGIOG5Qa7ZxScwa9pEX4fQd/ck4?=
 =?us-ascii?Q?1PdQ4JhednFdDSZgGe4esRogw1zfrhQdtmyoumPP03PQ8A7Wk7WayD3OaM42?=
 =?us-ascii?Q?vpO2Unjxyh+Sx1fpy+eK5JrejhDdS0ncCtiDVd6uaYz+PL/nUWwULA3mQU7r?=
 =?us-ascii?Q?ihnKDPrt7G3CO8+IuzaRTpl1TN6yqfDQWtWRbimFkrVwTVn7MPCl91B4TbuC?=
 =?us-ascii?Q?GZH40vkX/okHdtXDZio9ria8cNgWniilCxUAOHzZlUhn5kaB4RuPdaAmocRZ?=
 =?us-ascii?Q?9A+TeHjhtHCvyeI16OYcODnZChFSJBjPoLUx/YY/fqHSS/+Y7K7bvCajkNrl?=
 =?us-ascii?Q?MO7rTI5DH4E6bQSjfA7ydpMf5sdUeMfx+BpnQKyMxcZDQWCfszz+nXNq1hHF?=
 =?us-ascii?Q?2/Wa8pKmBDezKcAsL+oFoxeoeKzRHt6brByc5SbZr1Zh2qJyO4dtGEb8+hrK?=
 =?us-ascii?Q?FlZcrowQKo0ZL0HGnEPubkMMiEnIK3WOCRulNDAlxaeqvGBV5utsJHbGVcdc?=
 =?us-ascii?Q?wkUd/2LlRz7BSBWLlm0mrthnxume6ATVqAaPcDa45t6cpkG1qGKl19r3sVJn?=
 =?us-ascii?Q?1FrqFjPQLPDpbr67fLujWEy4fdhF44UEHyRf6wrSChfPPs9of3zBkvCzp/Zm?=
 =?us-ascii?Q?pJC97ofwqZFLaw0Q2cytrnZiJstAwQBmqULt8hYyfEoQqWc/IMWR+St+3ht3?=
 =?us-ascii?Q?8XoMqxCg2NRzH0Not47f6gc1TPHV1tU0aaccCSvCSUxArxImbf85GciK7vuA?=
 =?us-ascii?Q?PeGJeCI4v4qfnDMTjM+QcN25riW/x7pTde6nIFJ31QIOykc9AH2K6HT4IM6G?=
 =?us-ascii?Q?8Qq0UoQlOJBI39nqjMGWHoxp7zg8Q2m8fbeSmind1TJS6zrgHJ3NpNVMLyXA?=
 =?us-ascii?Q?nJGCnItI/Ync2q2HFCWrqMQivwpdhlOs0kKgGJ/nxaXdIdWjjwyqs4XBwmBa?=
 =?us-ascii?Q?c4HyUhaz+jJzE8WM+hKX4WbNiC/8eyMG4SJkTDNTBNe2o7BYrJ55mHnF/Ocj?=
 =?us-ascii?Q?hWwZsroXVA0GJ9dqlHN/CQBK8UAPApLSRMhpjBV3MIYkVwjhNJF4QBeppVcg?=
 =?us-ascii?Q?O9z3J+NPOR2W8H9iQ4Rv+Oo1QAQlxmpqegyWDESyeRdnYPR4Rw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P190MB1500.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Oma8yvCyqTYL5EEFGc/z40zON9iMp9FZwbhLPHKI7p442Wbtq4TBxIkdDqAJ?=
 =?us-ascii?Q?nc2e7HlURGU4hnUqHkDJfs644kMuEuw803tSwcLC16r1jVJb4trfDXlO1tVy?=
 =?us-ascii?Q?iHrPLGfE7vdpXfbt8blzxj1+kqMBf6N8YAetrgDTNR3Tc3nV01wnHAMSrFgG?=
 =?us-ascii?Q?aE6BK/qI9DSfuK/MTdaoNkSRB04C5ptN3niJ7olhwfm/K5D3mKe7WpJRHQtk?=
 =?us-ascii?Q?zXbXSQv6TTfMkTDcMrJl3EIfjwnhbNet/r320ur7AxNV9OcIiQtYVrUeKQ+3?=
 =?us-ascii?Q?DD0szsIKSp7MaeRtVG9FIbygAwMAUjEtAuY9DX8hj1QY6GzfQII4MjnWgmuN?=
 =?us-ascii?Q?KLmfdXMrPDUAewBk58ubp554G6fmhQTFdxuuh/Da19q9SoXLpQ90Uw8Ac+4R?=
 =?us-ascii?Q?3anxZti23AFcFeq/NMa5RWxiG6/EtcOqU8/Ftu8ZMTN5TwYbXe5ANK76cIK1?=
 =?us-ascii?Q?HVhRvyolR4KbodZ/RMfT/tsoovgCTDn5Ci4BqIXBpFFdrH20EiquPYSCqc0i?=
 =?us-ascii?Q?3Lhk8fpYPRZ14Pac+vTcoi5fseiaKziQUSVpf+8pxJbbiXgy6RoxUoq9TOQ0?=
 =?us-ascii?Q?mtv2/ZZi7VDYLcsw2p8i0O/MyKEMd0qpy5x7ECiRHjT5Gc4pDntSQUUof4nl?=
 =?us-ascii?Q?yWoL3DU30UyvAw0niV3Ffz4aHxMHzWr1gLa5Mi3xeYWtXDALZbnBJakx3Exj?=
 =?us-ascii?Q?nkEResZ9r8hrqWGU7ky0mkQTexiKqOK/VdjAHB0aGr+YRfTELYUG4X6xY2tQ?=
 =?us-ascii?Q?u3kUfdONYY1E0YtT3PVAxaP9jhYpDkKlxqdpH/NiXvOjwD8AeGioohTmHmOC?=
 =?us-ascii?Q?JGDwNfiNR2bE0wZtFIHlMRbjalQYGBVDbnjeS4KsXlcbRP1iPAdrLnjn5Jl9?=
 =?us-ascii?Q?tJSuE69XjdSEgIwsFb8G/lhMXqDZb+U6zzzoo8hs9sPSJo9mEWKjH0NEOEZD?=
 =?us-ascii?Q?J0nlcIcEBZcF9sYng2VGr0HmradQRkOv9fPFAdFRi3kkRTkoxO1naaA917w4?=
 =?us-ascii?Q?mw05ahXAaBlEmmTc+CtUABIJRidOBySC3o4Kxo3x7NHEA77CIwsYTCapkiJS?=
 =?us-ascii?Q?SEc8ZtK9C1NIn66uWIXIL31LSd93IrKUnskM6ACAz7LhCz+NzOVtgNcmIHGv?=
 =?us-ascii?Q?iFOChKvkRnbBI3muNnXBi+WZF7ajebNM1OadLnlEy9e3R3fvsr8Fgq2nI4vy?=
 =?us-ascii?Q?YhAWSFHDo1egQiP5qvAUxGUavEzw54gjYZDFfbDmPeaB3ejVBlBe2g9Cjp0n?=
 =?us-ascii?Q?5E26XPuBmyVTq4Rq0il98dye6gLM7g4vpyvtgSkZn/KSMoIWgL+KSIsS4Vgi?=
 =?us-ascii?Q?gGnIDJuQyRXHFnQQfkYmtjjhAUL7KelHqemAwKeyptPfyuM0MiEsQgJzhLOx?=
 =?us-ascii?Q?vC3VbY+pdi/hOJIkCFlVljtPeSn4Ac4XmwdmzEl0vHIzBYaGpWn4fO2Xa9Hh?=
 =?us-ascii?Q?SOR0KIK258lByrDCuDKHT7dXjcrdaaxFt8lphbEbCq1/IR25XK0Pw6e/T12E?=
 =?us-ascii?Q?/aZLQ99K2FNf3amR9J21XgLVsay46gKrkZTE6GzuYdWEl3dHQCWx1JG1a8u8?=
 =?us-ascii?Q?akZ2Qnux4gXs7V+zmwM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6ca3c3-e462-484b-3567-08dca2289a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 04:10:44.8266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 300f59df-78e6-436f-9b27-b64973e34f7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYJLktTwVDU71PTGZ2c0VR9JNNR1JBTCBUoZlw4aeHn5odhtOIUJNaHjL3aeqyTkcamlOSPRu4crpq04y/tSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1311

Hi,

We are maintaining the different versions of data in git repository using j=
git maven library. So, a commit is done on the repository containing proper=
ties such as author name, date and time, action, and the file path.
The file path refers the xml file which contains the action performed and i=
s stored inside the repository.

We have a job running every 5 minutes that commits the information onto the=
 repository and the XML file content is over-written every time. Usually, t=
he commits and writing of XML file takes around 4-5 seconds but sometimes t=
he time while committing as well as writing the data increases which also i=
ncrease the overall CPU utilization of the machine. This behavior is incons=
istent with respect to the process and occurs randomly but during this beha=
vior, there is a time when the CPU utilization becomes high that all other =
running processes hangs up which demands the restart of the server.

Furthermore,
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
Also, the machine memory size is 32GB and the machine type is /dev/nvme2n1

The commit time starts increasing from 4-5s and goes up to 6-7mins, what co=
uld be the trigger for the commit to increase from 4-5s to 1min and so on i=
n this scenario since before that there can't be any parallel commits ongoi=
ng onto the repository? Also, as I mentioned before, this issue is totally =
inconsistent.
Let me know in case any other information is required.

Could you please suggest which areas should we look for while identifying t=
he cause of this issue? Also, does frequent commit of the content onto repo=
sitory can trigger this issue?=20
In your view, what might be the trigger of this issue and how we can procee=
d to resolve it?

Thanks & Regards,
Arpit Gupta
