Received: from mx-relay55-hz1.antispameurope.com (mx-relay55-hz1.antispameurope.com [94.100.132.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880518CC15
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.132.228
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830389; cv=fail; b=GmcBVmWLONTcnPecDZSYb0clEvKOnCvuiaWXslJ8h89hAd3cqueJmK4QhbGUe55vQzFOioae68z/g1JpRiTttHH9kQ6Xcbtyi5iItU20MXnHmFSQtJN42ALpZ11vxpFdVUF6FZRnuFXn+xAVbefLJN9Wiz8JYBwpQHStS/8odcs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830389; c=relaxed/simple;
	bh=TNdmqN2jjTrtTcI2azbTFNlY80n0Z1f67oQX1DPwAOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eMKh9Km3P4TuAqr8naw+UhU9W04k/FFfaJkKBof4vARxioyb3uPRr2MVX5MOXduABA9OoelhYTjeVTngZJRnVXDO5895X0vBeoiGWvjfYAktyZozGTFgwC2Wb+xuU072j4QFK8RLTGOUcRLh7XbA11PJedH+oBw0ysliVDzN1Vc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com; spf=pass smtp.mailfrom=miele.com; dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b=AEmy0/gb; dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b=sXE8SKtw; arc=fail smtp.client-ip=94.100.132.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miele.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b="AEmy0/gb";
	dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b="sXE8SKtw"
ARC-Authentication-Results: i=2; mx-gate55-hz1.hornetsecurity.com 1; spf=fail
 reason=mailfrom (ip=104.47.11.105, headerfrom=miele.com)
 smtp.mailfrom=miele.com
 smtp.helo=eur02-db5-obe.outbound.protection.outlook.com; dkim=pass
 header.d=miele365.onmicrosoft.com header.s=selector2-miele365-onmicrosoft-com
 header.a=rsa-sha256; dmarc=fail header.from=miele.com orig.disposition=reject
ARC-Message-Signature: a=rsa-sha256;
 bh=TNdmqN2jjTrtTcI2azbTFNlY80n0Z1f67oQX1DPwAOA=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1745830366;
 b=DN1QMRT6vINiFBypQpn+YMx+cI8BG3G6rEFsQX4Z9ZbGIyDkJYusFNT/Bj32BjuiPV89hT/K
 lmsT6tLn4jjCTSwAQVRKh39crzKKzeNG/vriAa7zyNWxnDYPRdvKQhh3jEE64Rd6p1xrqLI/Jtu
 SyHFRC4BzlFCbGPV9gMQiJUUT1ptNjY99LqRbW1c9ZZ+u077eWT9KyrFQI1UhBVNdJhIU8Ah4QO
 I3HftJbndR66L/bXeW1ETQkcH9xuavLkJIXE8yQfg7Nlxa5UQ5mFr2XeJidoI5yQgQWP/gBJb0X
 I5Se45prLBhMsj98EGPXArflTRFaadRf0qWShKzxFq6RQ==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1745830366;
 b=p+zbFYrwUOngU+z8kQGb1bhyHpty3yUlisbf0NW6Q0XG7kFev9bimU3+15eYx70EJc0lI0oK
 BnFO5bdPnI2/Zo233dMufOQdi3ngllKccmglbXYPbU9mKGb6X64pMZtrnxzkWlBDDVdpS28t7+C
 IA8GCIcXR+fu3xLSwSs2P+fKa8vb1zKggxVIGecBZzcjvwkKyC1Li0o8cWJ4o2Blkuu38IxltOJ
 6bXev6QcWTuzQP3SzHofidK4NUMeMzRkw0WXJMeEijDSWRaHewi3XL4Xd4/+tUk156kw5eSU0fg
 VTG6DtyS9yfGOnXl2i73VLg3gJKYeGdcm+W0qH7evvYoQ==
Received: from mail-db5eur02lp2105.outbound.protection.outlook.com ([104.47.11.105]) by mx-relay55-hz1.antispameurope.com;
 Mon, 28 Apr 2025 10:52:46 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNS3+rL7BRU3VjqQkOiKxQrY02EoiGpg2hCmbWAo4P4Qmn/ID7c7U8xsjlN2gEXXnVzfsrsvvKjLEeVGOFnu+8UmU6+T1wo6pLxS9LU3VoI07Z6tU7X/8uQk0CAic7RAST9jI4FlejFsHAAZXCRZg/bb17sPPvTWxJtPa60110bmJO7hmAVP4XXFqJfopp8kHkRqdtKnI3OlsGoemciHARBpBxC5kaYVjGQqJcm/l3FL3ban1ajNOVcapuLh0Uqkj5KRe7TPWGVbzJpzkJm3uP1eoa38oJSIDpGKSNj88dzS62K6yglvfl3/dEN8vjRvs+fYcVyLUe9EAjQ4H9wXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNdmqN2jjTrtTcI2azbTFNlY80n0Z1f67oQX1DPwAOA=;
 b=TsE4Y42tdM4pkWDqZ6mPGhgslXqgcMiy3GKv+kAJU39V4gmzysvMvG6JPcRFIAIlyrElPGfikD5YI7I7cDZvmumf0qv6b4p0yl7u3S0TOjB0461eYVQ1bDngH9DUiIemxX5hYM/WQcaozcgnSy4SrwmFcJHEINanYQ5I3I96382Loqj/mHCugrqR1W2ZSrVbP/sBqn0RSpaSMer6isnMjvAn6s8MQk4g929nkcUNdH8xo1JkPoXuUesxzs/HaB9gkZAr9xkKmnNYvelYGQ6vJcTfRsIBBhsFDt3L3rZUkmthpOZl8XhR0RFAbWhyGQbENNpvB3IF4wOPi9Hevtc+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=miele.com; dmarc=pass action=none header.from=miele.com;
 dkim=pass header.d=miele.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miele365.onmicrosoft.com; s=selector2-miele365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNdmqN2jjTrtTcI2azbTFNlY80n0Z1f67oQX1DPwAOA=;
 b=AEmy0/gbF84skX0BRvwbH+J9g8aj3CTllU2HTaWa2v/Jjq3btWIoBLT1WDhBCPnK817bEABbpnr6EfXig2vHAeK7W11bJNWfmlfKHFzCR2ALsTNOWvZq6b8FHfZVEcWV5KDPeY5wwBTRYaNaoH3Obiy/07uuMmBVUn7Kijl5gPw=
Received: from DU0PR08MB8279.eurprd08.prod.outlook.com (2603:10a6:10:40d::20)
 by PAXPR08MB6718.eurprd08.prod.outlook.com (2603:10a6:102:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 08:52:37 +0000
Received: from DU0PR08MB8279.eurprd08.prod.outlook.com
 ([fe80::e4c9:e264:7d52:b768]) by DU0PR08MB8279.eurprd08.prod.outlook.com
 ([fe80::e4c9:e264:7d52:b768%6]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 08:52:36 +0000
From: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: ToBoMi via GitGitGadget <gitgitgadget@gmail.com>
Subject: AW: [PATCH v3] gitk: added external diff file rename detection
Thread-Topic: [PATCH v3] gitk: added external diff file rename detection
Thread-Index: AQHbjQWOooBO5VO01UeYTxvr0Xc0nrN2BPgAgEMWopA=
Date: Mon, 28 Apr 2025 08:52:36 +0000
Message-ID:
 <DU0PR08MB82799639DED41134E20C3255E1812@DU0PR08MB8279.eurprd08.prod.outlook.com>
References: <pull.1774.v2.git.1725607698680.gitgitgadget@gmail.com>
 <pull.1774.v3.git.1741093275742.gitgitgadget@gmail.com>
 <53c5aed4-ce4f-4ad7-8e90-a97fd3c973cd@kdbg.org>
In-Reply-To: <53c5aed4-ce4f-4ad7-8e90-a97fd3c973cd@kdbg.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ActionId=1c2b6741-9c3a-4a30-b666-346d6ca25ebe;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ContentBits=0;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Enabled=true;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Method=Standard;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Name=General;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SetDate=2025-04-28T08:52:08Z;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SiteId=22991c1b-aa70-4d9c-85be-637908be565f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=miele.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR08MB8279:EE_|PAXPR08MB6718:EE_
x-ms-office365-filtering-correlation-id: 0f0105cf-fb49-4c28-a397-08dd86320629
x-miele-exorule: Spamfilter umgehen
x-miele-exorule-disclaimer-company-imperial: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?d1pXU1B6Ym8wM1BvOHp4MTZ4RHNHVFhaY0ZGTitLYXFXdkNicHlsOGczdFlZ?=
 =?utf-8?B?WklPWWJYVHZxS1FpaHdQcXhqbXllN2wvaUg3Q2NTM0VyTDVXaG1kYUZYdlFw?=
 =?utf-8?B?STcwZW5xT2ZyN1dZNTFycVptYTJkY1BuVnE4YzNHY0FHTmt6elNFWS9icXJM?=
 =?utf-8?B?NE4xVzRzcHM0bkVrYWtzVXJXbzQ1Sk51aXNEcVVvWFR4NDZzWVN1cTRwU01N?=
 =?utf-8?B?enNnRElTbGlYRU5lamJGbmNQZzhZdW44V2lzUTllOS9tT2FaRGxSS0d0VjQ1?=
 =?utf-8?B?OFJUa0tQOExmUEpUbWxiNkhrWUFFUmlRZWdtbDN1S2x2YmFESlpZNTA5amZ2?=
 =?utf-8?B?YjNUUmtZSUljUjNzTHREUHplSGZheU9KQnUza1lFNXlNMXRvVkd6aW9Qald5?=
 =?utf-8?B?WTFsa2pHdVBUZ1RIaXVjUU5QV2Z4SjJlWW1DTHBvRDlmdHBXV1VVeStiUGM4?=
 =?utf-8?B?ZzVCbEpSODFRNG1xVEdBMnYwcDBZOVR2dFR3UFJpa0UwTHltNHZDS29LWlBZ?=
 =?utf-8?B?ZWM4Ly9RUmFTbmUvaFF5ZXdMWVVBNnAwT2VMRzRyOFA2TGkrQUhqMkFPUWJj?=
 =?utf-8?B?S1JReGx4SU9mdExMRXVFWFF4WHhIOTRWbm9PVytrUVlOL1M2R1lwUnY5c3RN?=
 =?utf-8?B?dUc4a21OWW9ZeFY3UW03K0dPZ3hVZWJxbWdQSENseWtMUlpTbFdYNlNmdytU?=
 =?utf-8?B?LzFGMkJvd3hpS1ZkLzVETnhyZ3BGVFlvVHFtUGhzYitVT2M3Qkh1QlF3WCtV?=
 =?utf-8?B?Rlo1VU5rbWRYVU05aFdKYWpYRHRmMWJzVlpMR050MTJFSXd6ZlRPUno5dlBx?=
 =?utf-8?B?S0hNTmNuMUNvaVVoQnBSRkdGZUtKc1cvVEE4NjhwYzhjTzNqYWoxME9oMU5Z?=
 =?utf-8?B?VWhrL002YzI4SFlLbzBaUWx4VFJsRjRuNUlDaEQxbkovYkV6K3NOVkdUR25O?=
 =?utf-8?B?NWFhN1FLd28wR0U3eUdmYnZLNHkxeDljMWFVOWpzQkFmZ0FxUWIzNHdFWkRl?=
 =?utf-8?B?REhsSjlGNWFqWkRpYjZDR2xJWHBqMS9sUGRGUWl6M2swRU54cmZzQjFVSlll?=
 =?utf-8?B?cG8wMFVqN0F1bzJtY0RWT29nYTZXc0orTmZQVTlUQ1BKdzBmUUdUR3YyUjFa?=
 =?utf-8?B?bXA3Y0FMWGFOWlo2ZU5CTXVWeEdKVWVQSkFDeXhGcVhlUUFhNHVUSlVaNUts?=
 =?utf-8?B?ekUyTW5mYmlCVTloWFNEdWt5dzJqRit1aDd2RUlVOUNCNnFTRVNDdUluYk9r?=
 =?utf-8?B?eklXajdRZm94NWN0eDVFTmczSUxGN1F0YVM5Zld1bS8wTlNDdXA3Nlg5Ynpi?=
 =?utf-8?B?VW5mSXk2ZVZlVWNwNzhHUUtWR2RhWUdaVm5mbklxd3JyTEVBSXUyaTIzSy9V?=
 =?utf-8?B?bnRVVDJGcXlRRk5nSERvb1R0Qmtzc3lxVFkxRTI1THdwNS9FT0FqcVA2dU1K?=
 =?utf-8?B?a0xHd0c3QUliSDF1M1VrSUQvallGSU1pcjZEQm04VE1sMlJnTmVZeTBqWFZo?=
 =?utf-8?B?K0FMT0hqc3BJRmdEazZ0VTBzVjRGRUJCVVlCNExTWEpSeVBQRnJabzBjNHF6?=
 =?utf-8?B?SlN1U3pxNlk0YjBwQ2pLeWhwdWUxYXpybTB1S2VNaEw2QXcwRGRNdUhLZEZQ?=
 =?utf-8?B?d3Z6Ym93SnJaWFJrNHo4UDE1T2FDclBBdFhzZ3dNVWFMczQ3NFBsZk1qZVJQ?=
 =?utf-8?B?cHlUTDNBT2lnZ2kyTmpON1dFK3RCdnpJYmpYcXQwcGdrT1QzUEVYRVh6RjdM?=
 =?utf-8?B?OWkybnI2RUdUTDMyMTRlN3dxRHZXNmljaGZmWjFaelNjeVQybTdweUZMRkdw?=
 =?utf-8?B?QXVXOFdSS25YZUJRc1FHS29YdEtaUWhWK3dBZDd3bzJ6MzEzc0tEWmpXdjA5?=
 =?utf-8?B?c0dIN3hrd2JIL1k3VVB4TG9xS0FIY1gvclZxSFJ6Y3J6UEVTZmZ1dlV5Wlhp?=
 =?utf-8?B?Rk90ZCtsNi9LbTYvam1zZElVUFhXekRVb1FCeEJUSFZYMDJDYk00aXRZdElj?=
 =?utf-8?B?dnFzWnozUEpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8279.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEF0ZGluUFBYNkZTMUNkZHB6SGY3NzVuTC8vbWI3MTN0YmpFMmhTV0tXa25z?=
 =?utf-8?B?SERaVW5rQWNxQUUyN2lRdnBaeUdnaTZQMXBOZ2xHTVN2YWVrZ2NEd3c0TnZW?=
 =?utf-8?B?bXRJTGdVL2owbitFRUtvMVJNRmU1RUNhL29pWGZodzRLaERJRnlEUXFuVVJm?=
 =?utf-8?B?NnNReStHNlZ0clVGZzFMRzVPRUFiVVFSSWU0eThkL1MwOGpKK1pBMGVQT1Y2?=
 =?utf-8?B?Ui9mSEcrTUFsU3JkbXAxdmRzTkE4WGk1NVF1VzR3VS9TZmY2TUJVVVNpOEY5?=
 =?utf-8?B?TkM4ZUh5ZHBFWmhQSU14M0p3RDFUZ2FYSWoxRkJxRlVSQnBQeUdIS1FvVVJI?=
 =?utf-8?B?bERNdVFPNDRDUnBtUlFTejViRTFOR2w3bVE2TmxpdGhTcXlTK2NkaFVWcGhP?=
 =?utf-8?B?SnhOVjVpWHFVczBxT3hMNXlzWUQvTW91aWRHN29NSjVPenFmSy9lUitPbVNG?=
 =?utf-8?B?WTBkUkRXSlV0VDB3STVkYk9CSmNvOTBmaHJIVWdaWkVKbEJ3Z3MyRTJqeE9p?=
 =?utf-8?B?M0g5cElDTmFjdENiSFM5MnRaamk2eHluOVZqZ2Fqb2ZjNjBHRGFrbEZ5cXBI?=
 =?utf-8?B?ZW5BMFFaQzdjWENLS3dpRXA5UGVjb1I0eVJ4NlQ5TWRLdkJPVnV3SzhSQU9u?=
 =?utf-8?B?bjIzNkMydmFxWSs3aXBNdTg3YWZKOFFKV3dOd25hRG1QM2ZSVkZWL3hXK29y?=
 =?utf-8?B?bzlySkFxYmlrSFk3dGN5WVR2OGNER3k1SVJXcFFRaHkwMlRuc3BlbVhrTzlr?=
 =?utf-8?B?V3BSQWtVMFNpMnNKMnlWenJIMTRyQnN2Zk5ycTVFNFdsakQrSlFwcERmekpJ?=
 =?utf-8?B?UDBjZ0ZWSnJlTjZzaFU1NHVBZlNZU1pVaDFBZ3c2a3FRcXdYN1dRQk44TFNw?=
 =?utf-8?B?dkxJdHZhenMzd1lGRStIMTdpTWQ4WkJCWWlGVERzdk9wYWJMVDduNStRSUZD?=
 =?utf-8?B?LzRmRERwSkhFejlQQUp1WGx0TkdkUVJlazk5eEhOcGNLSU5UWUFvR1hCcGFa?=
 =?utf-8?B?R2RrMlBhOWhjTnNsc0ZyczFvd2R1TEFzS2xvT2lmQTdCZlJVYlVjRWVVdmtU?=
 =?utf-8?B?QmNyRmFyeWxuTDVYN3cxM0xxOURIcFkzc2VOTXV4TjJkRHBjV0RZdHVVcXNr?=
 =?utf-8?B?VXZxL0pRaUdKckU0UGNEQVZkaGlnZmtEMGNGK2s0TS94ZUZUS09CemU2d25F?=
 =?utf-8?B?eG9tZks2VzhaakNISWJWQUw2Qmxaa0R4aVRCd2lJc1BBVlFGRGM5Unc5UGkx?=
 =?utf-8?B?UlZlRVBROTlWUmpydnRHalAzdExkbytybllZaENESi9DdmNrRG1YVFkxeCs3?=
 =?utf-8?B?RmlEbDBrN3VSZGJpZkphK1RIZmtUY0hLb3A5dVJ3aVRnUDdJazBrYlljTzNY?=
 =?utf-8?B?QXNFVGdiWGhQcSs4U3h4Y1NITmpZd1BSL05xbUh2bkVJQXdua2pMbU4vajFU?=
 =?utf-8?B?VnRrNlpPNkdiYW1xY0JYWWJVS0szODlyZ2FVZ3JhNmVhNEpuVFNpZFRxMktO?=
 =?utf-8?B?YVhmSDRjam1QTTREZG5rQlhzZEllK3hEYStwbmkyV0lwRlppd3J4bjkxRFRq?=
 =?utf-8?B?V1h6UytGTVZBcDJoaEE0VFkxbktXaWgzTVN2Q3VXWWRDU3RKdFpTZ3BTQTRk?=
 =?utf-8?B?MUQ2MFVjTmlUUmpwU0d2SVFTS1U3NWs5eGhvN0xnMTVaS2wxY3lqczhzUmNh?=
 =?utf-8?B?MlB5ZWR2eVliWVdzM2QyNExMejlvOVNyK2M5VWtBbTVJcy9MQmVhMUxhanBL?=
 =?utf-8?B?MWV4OUc3akRuR2ZWcGhMUzBVODREY05idDJqUGRFMEY4endIUGR1K1FySk9J?=
 =?utf-8?B?WXUyV2ZTbmVFNGRUSGJ0QTJLeFNIVUhHT1Z1ZkYyZFN1MXp1TjhTSGV0b3Bp?=
 =?utf-8?B?NTkwYlcwRzNISUN3bXVxYkxEQ0dLT0RubnovaWtZYUJFZXJCZ2RLZktwVWhk?=
 =?utf-8?B?dU45UGR1TGl3cjZGYnQ2Qy9jQ1VKYy9oVzdJdzJGc3JtdXlFV2xTd0lMd1FB?=
 =?utf-8?B?SmloQWtXa1IwcGpMZlkrQnRNME9wbnpsNERsc1lyOUZiaXFnWitZWDZYVm1n?=
 =?utf-8?B?T3ppMDh5Wm9SWnFjZ1g1T3hVdExTTzUvU3NzcVBCbzRRN0VTRVQxQU43OUg0?=
 =?utf-8?Q?cSQPOj6DuFAN354f3ZS3nd/NE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: miele.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8279.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0105cf-fb49-4c28-a397-08dd86320629
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 08:52:36.5827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22991c1b-aa70-4d9c-85be-637908be565f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hb3TGcVWKygVyc9V30iaoWXw4ksIccVnlroILQ5wETkCNFB1qodI2R9Ypr2hLvDIIVXSJNKlrkXgziF4mLFwHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6718
X-cloud-security-sender:tobias.boesch@miele.com
X-cloud-security-recipient:git@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay55-hz1.antispameurope.com with 4ZmHJl5tgYz17XCy
X-cloud-security-connect: mail-db5eur02lp2105.outbound.protection.outlook.com[104.47.11.105], TLS=1, IP=104.47.11.105
X-cloud-security-Digest:ee7dbbf7ef01749a35940cfb69d348f4
X-cloud-security:scantime:1.849
DKIM-Signature: a=rsa-sha256;
 bh=TNdmqN2jjTrtTcI2azbTFNlY80n0Z1f67oQX1DPwAOA=; c=relaxed/relaxed;
 d=miele.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1745830366; v=1;
 b=sXE8SKtwolu11ME0Yv7XnFusw8ar5VNdvMm2xy7EBU1u1ODcp0IIX3hGFOfP7PTFhUOcfiv1
 zzBgGmJhGg8PjMNUrQs2z3b9Pp1ZjQYcMQA8OlEvhHDpvPiS51ncXwcmJgHWHxpuOe4QG5iU2Fd
 elwUqtLPEPyaPhkc/FB1mrhFG7MSjpNfBDGKjBKcCYZwl9YL28Po7HPcmraz+3XvDam6mq0nsDM
 6wj48CH36EXTibKoE6muo0BzvGdeclOl7LTsRZFZEijeiKHNRGgZeti6jYMEnEGq3CutZUcDDrf
 dsjis4nb7cxXz05FdzHbZfjuwCY4PISgR04/7af3oSl/Q==

VGhhbmtzIGZvciB0aGUgdXBkYXRlLg0KVGFrZSB0aGUgdGltZSB5b3UgbmVlZC4NCkNoYW5nZXMg
dG8gdGhlIG1lc3NhZ2UgYXJlIGZvbGxvd2luZy4NCg0KPiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5h
Y2hyaWNodC0tLS0tDQo+IFZvbjogSm9oYW5uZXMgU2l4dCA8ajZ0QGtkYmcub3JnPg0KPiBHZXNl
bmRldDogU29ubnRhZywgMTYuIE3DpHJ6IDIwMjUgMTc6MjINCj4gQW46IEJvZXNjaCwgVG9iaWFz
IDx0b2JpYXMuYm9lc2NoQG1pZWxlLmNvbT4NCj4gQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmc7IFRv
Qm9NaSB2aWEgR2l0R2l0R2FkZ2V0IDxnaXRnaXRnYWRnZXRAZ21haWwuY29tPg0KPiBCZXRyZWZm
OiBSZTogW1BBVENIIHYzXSBnaXRrOiBhZGRlZCBleHRlcm5hbCBkaWZmIGZpbGUgcmVuYW1lIGRl
dGVjdGlvbg0KPg0KPiBBbSAwNC4wMy4yNSB1bSAxNDowMSBzY2hyaWViIFRvQm9NaSB2aWEgR2l0
R2l0R2FkZ2V0Og0KPiA+IEZyb206IFRvYmlhcyBCb2VzY2ggPHRvYmlhcy5ib2VzY2hAbWllbGUu
Y29tPg0KPiA+DQo+ID4gKiBJZiBhIGZpbGUgd2FzIHJlbmFtZWQgYmV0d2VlbiBjb21taXRzIGFu
ZCBhbiBleHRlcm5hbCBkaWZmIGlzIHN0YXJ0ZWQNCj4gPiAgIHRocm91Z2ggZ2l0ayBvbiB0aGUg
b3JpZ2luYWwgb3IgdGhlIHJlbmFtZWQgZmlsZSBuYW1lLA0KPiA+ICAgZ2l0ayB3YXMgdW5hYmxl
IHRvIG9wZW4gdGhlIHJlbmFtZWQgZmlsZSBpbiB0aGUgZXh0ZXJuYWwgZGlmZiBlZGl0b3IuDQo+
ID4gICBJdCBmYWlsZWQgdG8gZmV0Y2ggdGhlIHJlbmFtZWQgZmlsZSBmcm9tIGdpdCwgYmVjYXVz
ZSBpdCBmZXRjaGVkIGl0DQo+ID4gICB1c2luZyBpdHMgb3JpZ2luYWwgcGF0aCBpbiBjb250cmFz
dCB0byB1c2luZyB0aGUgcmVuYW1lZCBwYXRoIG9mIHRoZQ0KPiA+ICAgZmlsZS4NCj4gPiAqIFdp
dGggdGhpcyBjaGFuZ2UgZ2l0ayBkZXRlY3RzIHRoZSByZW5hbWUgYW5kIG9wZW5zIHRoZSBleHRl
cm5hbCBkaWZmDQo+ID4gICB3aXRoIHRoZSBvcmlnaW5hbCBhbmQgdGhlIHJlbmFtZWQgZmlsZSBp
bnN0ZWFkIG9mIG5vIGZpbGUgKGl0IGlzIGFibGUNCj4gPiAgIHRvIGZldGNoIHRoZSByZW5hbWVk
IGZpbGUgcGF0aCBhbmQgbmFtZSBub3cgZnJvbSBnaXQpLg0KPiA+ICogU2luY2UgZ2l0IGRvZXNu
J3QgZGVzdGluZ3Vpc2ggYmV0d2VlbiBtb3ZlIG9yIHJlbmFtZSB0aGlzIGFsc28gd29ya3MNCj4g
PiAgIGZvciBtb3ZlZCBmaWxlcy4NCj4gPiAqIFNob3dpbmcgdGhlIGV4dGVybmFsIGRpZmYgd2l0
aCB0aGUgb3JpZ2luYWwgYW5kIHRoZSByZW5hbWVkIGZpbGUNCj4gPiAgIHdvcmtzIHdoZW4gZWl0
aGVyIG9mIHRoZSBmaWxlcyBpcyBzZWxlY3RlZCBpbiBnaXRrLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogVG9iaWFzIEJvZXNjaCA8dG9iaWFzLmJvZXNjaEBtaWVsZS5jb20+DQo+ID4gLS0tDQo+
DQo+IEkndmUgcGlja2VkIHVwIHRoaXMgcGF0Y2gsIGJ1dCBoYXZlbid0IGZvdW5kIHRpbWUgdG8g
bG9vayBhdCBpdCBpbiBkZXRhaWwuIEl0IHdpbGwNCj4gdGFrZSBzb21lIHRpbWUuIFBsZWFzZSBi
ZWFyIHdpdGggbWUuDQo+DQo+IFRoZSBjb21taXQgbWVzc2FnZSB3b3VsZCBuZWVkIHRvIGJlIHJl
d3JpdHRlbiB0byBtYXRjaCBvdXIgdXN1YWwgc3R5bGU6DQo+DQo+IC0gV2UgZG8gbm90IHVzZSBi
dWxsZXQgcG9pbnRzIGZvciBub3JtYWwgdGV4dCBwYXJhZ3JhcGhzLg0KPiAtIFdlIGRlc2NyaWJl
IHRoZSBzdGF0dXMgcXVvIGluIHByZXNlbnQgdGVuc2UsDQo+IC0gYW5kIHRoZW4gdGhlIGNoYW5n
ZXMgaW4gaW1wZXJhdGl2ZSBtb29kLiAoTGlrZSwgImNvZGUsIGJlY29tZSBzbyEiKQ0KPiAtIFRo
ZSBzdWJqZWN0IGlzIG5vdCBpbiBwYXN0IHRlbnNlLCBidXQgdXN1YWxseSBhbHNvIGltcGVyYXRp
dmUuDQo+DQo+IC0tIEhhbm5lcw0KDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KaW1wZXJpYWwtV2Vya2Ugb0hHLCBTaXR6IELDvG5kZSwgUmVnaXN0ZXJnZXJp
Y2h0IEJhZCBPZXluaGF1c2VuIC0gSFJBIDQ4MjUNCg==
