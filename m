Received: from mx-relay37-hz1-if1.hornetsecurity.com (mx-relay37-hz1-if1.hornetsecurity.com [94.100.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00DD18C332
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.128.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764837666; cv=fail; b=EaHE6iS40aWswjZbIm+q7bHIgCUVwW60x3OpVt4lD3cgTcS5WEe1PWusOVL4b+1VNyETdceFF62ylUPm9u4K4hmO2e3NZ/iZIgk2XxKsHJpGovHXFnlgJmQyecuq5c85wWo7li6ib7s8f52EAkDvhYTrfMgvaA13LLjHEtzQVYo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764837666; c=relaxed/simple;
	bh=9wcoVFtYPMBjpcd7TCrBVRLv2V1tSlTrdZL1iwJTHOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fGQlou1tL5fXvWQ1wuyQm5VZaQfVZSwJOLKp18veGbie0PU11Vn/aVkJ1M6KQuC/tXiD5Ft5wrMCbnD3uLZMQZnzw/kRQoM7QziDS7jYdKrZqLYqVlSeqZosj6oYh9mSJl0eHXzQJRvY7mC/uqibWelLeEj2F60sLlqp57yMS74=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com; spf=pass smtp.mailfrom=miele.com; dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b=bvTLabka; dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b=I3PvQpVO; arc=fail smtp.client-ip=94.100.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miele.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b="bvTLabka";
	dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b="I3PvQpVO"
ARC-Authentication-Results: i=2; mx-gate37-hz1.hornetsecurity.com 1; spf=fail
 reason=mailfrom (ip=52.101.69.32, headerfrom=miele.com)
 smtp.mailfrom=miele.com
 smtp.helo=am0pr83cu005.outbound.protection.outlook.com; dkim=pass
 header.d=miele365.onmicrosoft.com header.s=selector2-miele365-onmicrosoft-com
 header.a=rsa-sha256; dmarc=fail header.from=miele.com orig.disposition=reject
ARC-Message-Signature: a=rsa-sha256;
 bh=9wcoVFtYPMBjpcd7TCrBVRLv2V1tSlTrdZL1iwJTHOU=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1764837596;
 b=d2jhSx5MZhX8WHlGHOmJonL/P7Yo1z6b+rL33PXw7L/Y+8Q1fYqQKfUbviU9kX1JKBj9N3IO
 sa5LPMWtEcHhE7fH9M9FOjKvEpiuiHIN5sSkExlL6BrOT/dL0ayd9hyY2W0ayEpWNaWyLZHZ38Y
 cxYhH0g6jTv+XzcV/zhtp06GjLeq5jEa/sp7Ac/fYQfM5H/2n99EjDISXZYRW8wid3uxHZIAAZQ
 LSYTm/s+u1mSJaWD1OJrPT71/zXyIsRGXczj7KIk1ZbrIunWYwiyW6jDSISwuyrmeHVcUL+4lzm
 7ZLzhYRGsvT6abIE3gUs1W/hrQqRxSMhMjCd5WSWFFT/g==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1764837596;
 b=HxQQsJqQ3RwWxXK+wcgZGurahwzLs09Vcn7ws+tsNbi6KBYnoCGWN6B1sQlbJqTtqjRsYjGk
 R6JGvtK/aLB0xVEJKiShlQw4kP0B1GIa/6f2YA9//R5JuAQKanpLGd11tfyNYz07uEGmC5bHSdZ
 /YLFHIR7UOszFkywtisKZHXznDRWdhx4Qe+ydVBr3qsSZGVc31o8oLIydMrceMpIC+tZy6sPIH6
 JoMLs9Uj2kmd3GnPHCnf0fUH10PdwhZt8htIhPNpLPg9Ve7aObvXQTR85pAR8mf7ZznvFX6yhDO
 UobypZ4pIcOtoYXY/N3HtqU6Rvz6LBo4AimD+PeGLl7lQ==
Received: from mail-westeuropeazon11010032.outbound.protection.outlook.com ([52.101.69.32]) by mx-relay37-hz1.antispameurope.com;
 Thu, 04 Dec 2025 09:39:56 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkPxEqaV7NI7Z4VML7VrBt6eHA/WHv/JKfo1RRHJupFN4WWjogiJMx2n/NejU0k1ggruRaWYyHV2Zm5s52guImB8Lcn9Ne0NBanj98TYm6uE1cuElSm7vm0S99ufyT3AcahuxP8+XOZ04yES81k0GwTJA+WfICfy1T3fFP1pzAHW7bdq6TC6J5QV+r9SVetKRjoU5z9XRbbAfqzsWHYy4CUrZju7uFi2CbQcMn9RCWGiesJMZpjbZ0UMM71TChBKWrDXs/2neLbIPB/tPj74nJbkbNzk75ErX9DotHYBoCWU6LXGZzO4S63Bn9jN4pZF7hJ7qSyDKuVXwT1QH3kTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wcoVFtYPMBjpcd7TCrBVRLv2V1tSlTrdZL1iwJTHOU=;
 b=MuTCIOj36VI4cOu4ZQZ54L7A+1PQRxPoW8W0/z8jmT61SZ42hqUR6a8x8XHcV2cIkv/aOxQ2QbFMOymbYZRduimrM9oOXy1FM9VIvupHmpGjvOFVxMZU19ZR/MUy0Iqer+PCweitLW4MT7IG0NBzdWQH2mONjD8Mpdqz9r5V+kAR3iMd9MTsTr2JFRvkpZpIlfULpQ9Vn5K5JYUHWaC1HWFdHvnNKHpVNWUQDL/Ayi+CWiqqkIR731PzLXd5+OfEbQ4RdvGTi1Z1ViDLGXfaxSFOWc1FkS2b2kyoDEykqzjsUDbCyQ1Y1z1tLKzaRfQqEoGwMXooq9ffDrqAsW4bCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=miele.com; dmarc=pass action=none header.from=miele.com;
 dkim=pass header.d=miele.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miele365.onmicrosoft.com; s=selector2-miele365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wcoVFtYPMBjpcd7TCrBVRLv2V1tSlTrdZL1iwJTHOU=;
 b=bvTLabkaHk6Taf9ggKkvNdRvzJojDN/i18ThfPUpSjMOg5hFZ6I9772zS11B/DhnomNb8HHVTw5UzWl5oZgAe64Hy2XzyEW6g7+vBFK4bbSmPoliDZOXNBcjEZUc7GqGvrN+eBtbsEN708mUoDYZEabxTJk3jDaV5CXklbfDlr0=
Received: from DB8PR08MB5433.eurprd08.prod.outlook.com (2603:10a6:10:118::13)
 by AS8PR08MB6566.eurprd08.prod.outlook.com (2603:10a6:20b:33a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 08:39:51 +0000
Received: from DB8PR08MB5433.eurprd08.prod.outlook.com
 ([fe80::4e50:520f:c8d3:8dec]) by DB8PR08MB5433.eurprd08.prod.outlook.com
 ([fe80::4e50:520f:c8d3:8dec%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 08:39:51 +0000
From: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
To: Johannes Sixt <j6t@kdbg.org>
CC: Git Mailing List <git@vger.kernel.org>
Subject: AW: [PATCH] gitk: fix history window panes position
Thread-Topic: [PATCH] gitk: fix history window panes position
Thread-Index: AdxjfVz5xV1bhNtlQMuC0kJ0bml6MQAwF2UAAARkWEA=
Date: Thu, 4 Dec 2025 08:39:51 +0000
Message-ID:
 <DB8PR08MB5433FCF25C0693952E0E67BEE1A6A@DB8PR08MB5433.eurprd08.prod.outlook.com>
References:
 <AM0PR08MB5426BC141388A69BB5087732E1D8A@AM0PR08MB5426.eurprd08.prod.outlook.com>
 <9a9441d5-fb64-4718-8765-852e66458598@kdbg.org>
In-Reply-To: <9a9441d5-fb64-4718-8765-852e66458598@kdbg.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ActionId=e51cbba8-cfa0-4d65-b17e-63753904e64a;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ContentBits=0;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Enabled=true;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Method=Standard;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Name=General;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SetDate=2025-12-03T12:21:05Z;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SiteId=22991c1b-aa70-4d9c-85be-637908be565f;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=miele.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR08MB5433:EE_|AS8PR08MB6566:EE_
x-ms-office365-filtering-correlation-id: 41d1d96d-c9f3-4e51-783b-08de3310b135
x-miele-exorule: Spamfilter umgehen
x-miele-exorule-disclaimer-company-imperial: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?lhyKhZCsROV2M9q69XZGCN7N+Aq2CRw19E9+5HeMhUbrgMJsjSjru4uzKQ?=
 =?iso-8859-1?Q?pjMjFnc7SfvMbSIZgDR7GpbmH9dhYVEca1mWCpVkxrmBn1sX82IjMWo0bw?=
 =?iso-8859-1?Q?mlZauRUxBUSDawZJBfrt7O/ffJYguAHQFx8NsaZQ96qpYY42qscUd7czV+?=
 =?iso-8859-1?Q?Fp4J0dE2RZxvJIIMFHzJf5oAzEbtehcXMk5pBz/1XdcYTlBmnMjo9gw//Q?=
 =?iso-8859-1?Q?u4fvLddp72KVCqDIjQsiRD7Mvid8R8yX+xmMC2fh/4zppG8jPoa1WCCOmR?=
 =?iso-8859-1?Q?ceJOMd0xSH2dP776V0XT5B4n9j3tMZhBUoXcl1kyLOdwOOhuoKw5S+yfFm?=
 =?iso-8859-1?Q?WG6DZiOqsp2Gp9Nt49hFQ6Y490BWoK/11moHBa6ve2nTq8No8dcKvjFrMQ?=
 =?iso-8859-1?Q?kct+TYxIo7/6FM2BT2v6IloS5LEHjnnPGkVLg/C/z2Lk3bLT/LyIcvhNxR?=
 =?iso-8859-1?Q?bpg5fau0ZmwTt10yYtdbMICeNj2Gtz+RQ8Lo/MbxD21/8KPFv+7rvdEiHk?=
 =?iso-8859-1?Q?yQsu7xvNY/9eZFZTxs8bqSPC3Qbd2aSstn5c2FKJHY5U8aupVzGqfzgFvU?=
 =?iso-8859-1?Q?uGmoQgkcmlimp5fC20/ST2V9FP8HNK49YxdAj3jiXUFvR6t0hPkTsGZWEf?=
 =?iso-8859-1?Q?fET3k/hABaS1mZi3e3AiuMfkduO8desG9if/SBIx0FAPrGBlZQpGSv5OcE?=
 =?iso-8859-1?Q?CrwOdXp/n72mFR4z5UiIG9vejJE+CUHBX5TbXZZvc6uCSB47hzdS9CMKix?=
 =?iso-8859-1?Q?/TL0MjEsb6Nbp7tiVax655bf7DUcUPgYfp7ZcCAIhp72IhPKeIEXD39hs0?=
 =?iso-8859-1?Q?ZRLfvqSRDWJeMwaE5BwXNVvZioYY/DA08fjpoE6ClixyGnbbSqXjczcWz+?=
 =?iso-8859-1?Q?fKd87ldiFmniPqGpzA3nOciWWH6Xkis2Bb/8VHNXhbD8Rr3KwMxiv1nv6p?=
 =?iso-8859-1?Q?C6qIx1GqGWrmkVaa/6U3r4vXtkeDKQmzRClQHNGuUcebsVMngoJVgxt4Ea?=
 =?iso-8859-1?Q?seZXOqlKvKg4pYKLqoPEulJ4hYdjagbOQw3nXrcwsC8V1mmBvw1C5grVtY?=
 =?iso-8859-1?Q?1J0s9FlTvpVM5HZ/ao8i+hjaarvqrZBrm2mA7+s60CdoZDZHtCk1Zp3bAh?=
 =?iso-8859-1?Q?qdebgFiucf3xKM1xdUq4VmOcmcq0wiVSazr33u7/QMHDK7uaCFxJy+MEtR?=
 =?iso-8859-1?Q?67H2cz8MHV1cjP+xrKkOtuEGr/bTfLfFiGmeE+VKrFKIZv2mhuhln7vIWm?=
 =?iso-8859-1?Q?ntT7JWu5ZKM3cwXM8TJmH4gi/R8VNVeymHIwwvrmWIX+lzS2OcedfmJUsM?=
 =?iso-8859-1?Q?UcmTn/ViPMOBQ+p2ekC1UUn2AH43+h2KNrDO3QB+qMiD8jh0nm6GQ6QrAn?=
 =?iso-8859-1?Q?pIlrURZsZyiVCskghwjI4ywTuQzffk9lXRg/0PReiQJedKDSPN+NaW7rMp?=
 =?iso-8859-1?Q?W4v5TGnNUVMkcrR33cias9gCr7zlR9hhZlZJYfvXU3/NpxQ7WlQF/9IF/u?=
 =?iso-8859-1?Q?CHLASjqb3m+4yVavuAVZg3kfzTUqhmbJejFN2z974QCyN/54oM6xSqaFAI?=
 =?iso-8859-1?Q?8gZ+7ZvkdcARecrRIzJQr+koXaPe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5433.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0Tpw4hMRvxNcGoUFmZpN70eTcnClrqaKLhsMi2RktQI+nDbn2oloGBsMQd?=
 =?iso-8859-1?Q?9KifBex5FMx7nfGtFPvY+xZy4hzUAd7LhAT7tn7ca24YBpWzzVkhmCJi/e?=
 =?iso-8859-1?Q?t/bM8jtlICKQomDd6kwKnB5G+pIAMGSJ5neJC9/LSV3X4y2ZVL0L/4En6T?=
 =?iso-8859-1?Q?atFAMC3RPpVMtnqantl7jdmumEqeKSpN89H1TyoqVlu4tx0G6k81RB+nFR?=
 =?iso-8859-1?Q?NPh01Z0ZSVPqFOF60v9l6fTaKXKl3D+hcIriJtbtOpyJ+zP02Akkd+LpVd?=
 =?iso-8859-1?Q?/5IAqgtsBG/XgKhHMk6Hfxk1O0JQOVLV3YQi0Fd2GZDe7V2UOS+7lMRSm3?=
 =?iso-8859-1?Q?NctNovf5IJ9moXoNiVfFHf2Z6iegnBRNXQelXyQAyp+1z7t3CzrxN4udAe?=
 =?iso-8859-1?Q?u6k2gAq3DxFiIBsP5aXx4Cx2ZYtbJsVcmRv5iJyraUmxhqvrpAnOjQu9H0?=
 =?iso-8859-1?Q?e8MKVDy09EkUFhmon7/vvEA8ruyQ9OlbjQU1K39H/pcoxt4r9YavfJ8Nk9?=
 =?iso-8859-1?Q?1YNbmh68gJTOgtzFlO3EJ3P/cXkzVYFevmB6sEyYaYq4Trg8Lc+0nEvv/E?=
 =?iso-8859-1?Q?cnVfyLKUr6puHAp1ZKjXt49408gbijG+A0ax992iWv1SbnODFTxSi5gR+z?=
 =?iso-8859-1?Q?Jw5XXHScbGII/V3TJmHYbRUpMxMns4YMd7qIDftpAcgc7LYwvALHg6r6gR?=
 =?iso-8859-1?Q?tHA74ZM+KoLx2m06/4XezLUfhTVyJWV2rHtefIF+pzBs+u6Fjk5JC9HL2X?=
 =?iso-8859-1?Q?yGlAOtYH3oB3AYly6WzHe3Pcr7Kn4VgiwkHntNcuIhfFJDZPxZEUg/5hP3?=
 =?iso-8859-1?Q?DARZoy/8vgJCFUlok0la4bcNDumPBfPfvv3w4h2Ntb5JjqgaoC7XesOrPJ?=
 =?iso-8859-1?Q?8CmYx8bAJ6qMkswZ0md/cCxyi1pJLcwGi/lchUeirknVJtcYS5fxeIz7BF?=
 =?iso-8859-1?Q?Zg9JV0UjnOemTZqeBvm9XfPBavxQsPdp2gAQs4gPYZjLXLiZB4or4b8ww3?=
 =?iso-8859-1?Q?AkS5Zf/6lWwlGC9GIy9+r5Tr83xgIDVg7mB03LkvnhG9W4snOtAKE4aF+1?=
 =?iso-8859-1?Q?dEEmqDphde3uqGDC/s93Gh1JNfoYSCnLFoKa27qoi24xWZ2lx12XeRF7RU?=
 =?iso-8859-1?Q?xMM6gUDtF7o6qrAZcgGkMbpSrWYs4/ETe1hN0PpzlzSsDUGaJc9cRDqABq?=
 =?iso-8859-1?Q?nqRB8D0L5/YAanN7OF7E9y/y8eO9jKVEnofGR8+CV8q/kJSW9hytGk0j7O?=
 =?iso-8859-1?Q?qM+Ef7fLjskjDIUJQ4rkagn5ob1gE7vLve0fka8o1+zU3fLOlU42TU/svQ?=
 =?iso-8859-1?Q?p/4n9foqKrkHKfv4PowKmgedV/Whq/L+B+t0XnQZTChYZiCSB2khIfWspR?=
 =?iso-8859-1?Q?6QykDuNcWAbKU/wCOFh10neSszWFS3dd0I8JwVuRL59xlTFMtR1YLki4pb?=
 =?iso-8859-1?Q?sOP/sPN+ukpr0V3wc0hxVBiMst4nvCd6xmg4Vy4+IzOpf7CyNHuZrAMELH?=
 =?iso-8859-1?Q?YVTdVaVlt1nFQgEU0jwfFsIbeDhqzwHtxl24buTBA/ztXK8Cqqg5Ys7zRj?=
 =?iso-8859-1?Q?Er6ebHibMExhnkuayOpk3m+gzurXb1CHgu+6S/vUtE9mh4OryNjwJl0r4Z?=
 =?iso-8859-1?Q?DHRORIE616KvBWZoo7saIgC9oCU9k/IYzN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: miele.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5433.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d1d96d-c9f3-4e51-783b-08de3310b135
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 08:39:51.8681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22991c1b-aa70-4d9c-85be-637908be565f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5ec7bQLtWu4BeFFWmsa2XVjTJOKk0PNhYR2iXedP9XpWlKKJ+Voe6vFN3GR8Z+7c7P9DM3+cLYj1sHRS5/6xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6566
X-cloud-security-sender:tobias.boesch@miele.com
X-cloud-security-recipient:git@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay37-hz1.antispameurope.com with 4dMScT3HzKz2YlHC
X-cloud-security-connect: mail-westeuropeazon11010032.outbound.protection.outlook.com[52.101.69.32], TLS=1, IP=52.101.69.32
X-cloud-security-Digest:301177c98071136f3d46a89d2a4d3042
X-cloud-security:scantime:1.452
DKIM-Signature: a=rsa-sha256;
 bh=9wcoVFtYPMBjpcd7TCrBVRLv2V1tSlTrdZL1iwJTHOU=; c=relaxed/relaxed;
 d=miele.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1764837596; v=1;
 b=I3PvQpVO9z8aMdfrmFdkix6nba5fuSk/ijI+ot3Jc7uF5Co8YCWE88SaYAFKO//mx+qQNgUq
 8N6UC+S8KY9ZsQyujR4/zw6cr7k45pi86TQnPWmR2vIXQhQEIUPUL+JGDQBKZPX+g/EH51aLOSP
 KyxgPVnnYuyIx4edZlc+cKh+RV12ItiOt9d2Nnky27lEWrCSAntgUhp2MTyQxSgwzoiGH4HXUZ3
 Ye3i5q8KKLKa/9h/EXoOXZ/MAwkN2i9VyQwavUjazeZEsxhqgVXRUOMjFNknLao4zitYC0BJaA5
 QfXrJ+4lWv7de1a3O8/5tsdK2BAkuq76kN0UvubkFhnuw==

Some quick responses inlined below.
I'll look into the rest of your annotations and try to directly provide a s=
econd
version of the patch.

> -----Urspr=FCngliche Nachricht-----
> Von: Johannes Sixt <j6t@kdbg.org>
> Gesendet: Mittwoch, 3. Dezember 2025 11:15
> An: Boesch, Tobias <tobias.boesch@miele.com>
> Cc: Git Mailing List <git@vger.kernel.org>
> Betreff: Re: [PATCH] gitk: fix history window panes position
>
> Am 02.12.25 um 14:08 schrieb tobias.boesch@miele.com:
> > From: Tobias Boesch <tobias.boesch@miele.com>
> > Date: Thu, 27 Nov 2025 11:27:16 +0100
> > Subject: [PATCH] gitk: fix history window panes position
> >
> > When the history window panes in are resized by moving either of the
> > two sashes and then the gitk window is vertically resized, the sashes
> > fall back into their previous position without respecting the users
> > wish for resizing.
>
> You say "the Gitk windows is resized vertically". Did you mean "resized
> horizontally"? If I change only the height of the Gitk window, the widths=
 of the
> top panel (history, author, date) aren't changed at all.
> However, if I change only the width, the symptoms do occur.

You're right. I meant horizontally. Will be changed in the commit message.

>
> Also, the error is not limited to the upper half of the window. The lower=
 panel
> (patch text, file list) also forgets the last used position when the wind=
ow size is
> changed. Can we fix this, too?

Yes I plan to do that, but I thought it would be too big for one commit sin=
ce it is
a slightly different part of the app.
I wanted to put this in a separate patch, since I just started with using e=
mails and
the git mailing list directly instead of using gitgitgadjet. That's all new=
 to me and
I didn't want to start with a series of patches on this first try.
Would you like to have that fix in this patch and convert this patch into a=
 series
(somehow) or is it okay to put it in a separate patch?

Tobias


---------------------------------------------------------------------------=
----------------------
imperial-Werke oHG, Sitz B=FCnde, Registergericht Bad Oeynhausen - HRA 4825
