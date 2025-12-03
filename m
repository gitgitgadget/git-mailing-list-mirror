Received: from mx-relay33-hz1-if1.hornetsecurity.com (mx-relay33-hz1-if1.hornetsecurity.com [94.100.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1232DC335
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.128.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754570; cv=fail; b=muesP+d/aY5hVI4MGvcHBB9iwx5YYuKtjlwlIwmn88+OkgAU13lUybjoe1Gqr/Ca7N6AQUUnEKH5dMSe00Aj7tPuW+C6Wmo+O4wQF31ViM/Sx7f/UYNWeuETiWQyQ3YeoT7a4kxC1vakZ0r02l3UBV6YxjiPiFA2QNn7AA7Mjhk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754570; c=relaxed/simple;
	bh=1GZJlakIBG60bhQmjk8DhAlmglguN/GPzw8lgvZ1WCY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CjubMoLqsnXNk8gJKDw9QQHzmC51V7Bs+Z0UpSKTcw1ZCbbQRxg8W0T42qp9gxARYkyIH87x9SKJcVX5DMDQLYxAwzhoh1veh6j+XiH7+/NA+iuhynjyZOVdSdKldXP5+GDWsY75s4tEbWv0NVFxRwgElu+rr2rvxG4jjWXB0rs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com; spf=pass smtp.mailfrom=miele.com; dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b=PWPbfLUo; dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b=AKypAyNR; arc=fail smtp.client-ip=94.100.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miele.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b="PWPbfLUo";
	dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b="AKypAyNR"
ARC-Authentication-Results: i=2; mx-gate33-hz1.hornetsecurity.com 1; spf=fail
 reason=mailfrom (ip=52.101.84.67, headerfrom=miele.com)
 smtp.mailfrom=miele.com
 smtp.helo=db3pr0202cu003.outbound.protection.outlook.com; dkim=pass
 header.d=miele365.onmicrosoft.com header.s=selector2-miele365-onmicrosoft-com
 header.a=rsa-sha256; dmarc=fail header.from=miele.com orig.disposition=reject
ARC-Message-Signature: a=rsa-sha256;
 bh=F5VnE3v5W0OfDokEMlQxqlzYaxlwfWqAQqgIJnCxTB4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1764754533;
 b=NX63FuNcBZPDpx41xYufGsk+wfvW+A3mvlT9hc1S/kdFHTfiAws8FLEMxx9yC1DhRedizt6p
 Zg+fJbhmVIQWhCuvgkDv1NZ+CSpwbpA4mwgQCCjsRmkL1DuPn6+oODnv2/hCLXAcxWrtiJ0l+9y
 nUFvOdibosQJVKqWbTLslU+Hx1Poq1MGtReProS4gEkhQ7NqzAXXJky9b9idxf/IVoK11u/KhZU
 KmtI4tNWCyUSUuJy7czuhyduQH8F2BSzh7V90oNJdT71eZYhBlT22VDEOAVKCfrIl3zPkNYUcRc
 F4hh+F4Ztshum7x8ZgI1w8dvQseIkoj4VyXdpAjrVQh4w==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1764754533;
 b=jzzB7PV6CK2c/qfT20LT4hlQQuQeeXIorRpsDVpgV4D9VX5QaTqoC7bUDXUt4TrTgQ7HCswC
 H8eg7a8q0NsHUnXc4geNhBhW6uQGmFWVuZOx3EgiUFKgFM06tLeyfqSKBRkC8RlY5ruFDIsXcSJ
 bnQkiBwrL+Uj9rOBJdVmkB/N7+nLXQ8auE9dOsHPGRo925+PhhDSbmivynWJnESQ0LM/dM3pHPO
 pev4suCM9kwC9sgceU2yPHCinNcg5m70gDypzRIylh8ypDe7hav4gtKX9Scz3wihYGYz2NnCCXX
 l5yaxA7p590cbtIIHwmkU1lRtLb7yOY/8E77ZSMIGRJfg==
Received: from mail-northeuropeazon11010067.outbound.protection.outlook.com ([52.101.84.67]) by mx-relay33-hz1.antispameurope.com;
 Wed, 03 Dec 2025 10:35:33 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7/NFP8seioXYP4KJy67DUJaIMAYO2Wff+uKQ100eq2ViLzDPrvL+77OSKpndWUCm6xgRbNK+YGs7Gve+ntPlbaOr58CN6ezk+1l8XttPxCGmuHh9HY44quhMm3nSTN/siBEoropxajM/YPDSjsGvjeNSOd7RWDFoeYlbGDfVwYh5YKb2R4NYJDeDnh59p0cNhrpsmlJWpF3DdVuSEtZzIDwHY27vXx5ZUfcGPuW07wjX2uzsus5pqvAGkWEr8BXRSb9+owC+ULlt1BM9Xaq9QjINGXYxIoOfZ71ELMHP/NsJDcXWsB6da0msQcPknrzSIORs1sJg7spX94e8j8ZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5VnE3v5W0OfDokEMlQxqlzYaxlwfWqAQqgIJnCxTB4=;
 b=UHDWMsutDg8a1SIt0VMv+bbOEMfF7b6sHAWP1kBzuAfYMu3tEYOAn7eL921Y6OKObi36uqX+Q+AGRKBf9yOeZyR1RRNoI1X8LRz5AQ3+dNeCwvSduU5K52RTYrfeVkRzo/5iJ98q9dfU7Sv7DEcwweHlawTM8SsFa5z9QHOWJQz8RTLGMYNq7orYcg3va16mUMtx0z8a789OZ7I2Z0/56gmro2dEL8Of9pOHfLiXRdGh0w+IifQWCEp+TGCe1JNOENtwJ1s48pQpJenLfIwDU2fKnSPqvoxXgAsig5x48lr1qQpsa5mgz1Ol5P5wA+7Q4q2ceCHbaEzdEbpBgR2mrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=miele.com; dmarc=pass action=none header.from=miele.com;
 dkim=pass header.d=miele.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miele365.onmicrosoft.com; s=selector2-miele365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5VnE3v5W0OfDokEMlQxqlzYaxlwfWqAQqgIJnCxTB4=;
 b=PWPbfLUozt+F/yImXw1YI+7FnB8j+81b9cLUng9MUovzTLP0DtCoO39a0KEIZeLLQtycKKte+hP8/X6M8xi2WpGKA4iMzhlaFiq2B1EsgeaKHzMT7KbjL1IKRfgBWWCpUpIRYaT07BUKiLw0XwyrYlrk3z94WsAVVKgWmy9ha48=
Received: from AM0PR08MB5426.eurprd08.prod.outlook.com (2603:10a6:208:184::18)
 by AS2PR08MB10227.eurprd08.prod.outlook.com (2603:10a6:20b:647::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 09:35:27 +0000
Received: from AM0PR08MB5426.eurprd08.prod.outlook.com
 ([fe80::d351:b1bb:ce65:883a]) by AM0PR08MB5426.eurprd08.prod.outlook.com
 ([fe80::d351:b1bb:ce65:883a%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:35:27 +0000
From: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
To: Git Mailing List <git@vger.kernel.org>
CC: Johannes Sixt <j6t@kdbg.org>
Subject: AW: [PATCH] gitk: fix history window panes position
Thread-Topic: [PATCH] gitk: fix history window panes position
Thread-Index: AdxjfVz5xV1bhNtlQMuC0kJ0bml6MQAudiQQ
Date: Wed, 3 Dec 2025 09:35:27 +0000
Message-ID:
 <AM0PR08MB5426A65AA721DCA6CACF6C7AE1D9A@AM0PR08MB5426.eurprd08.prod.outlook.com>
References:
 <AM0PR08MB5426BC141388A69BB5087732E1D8A@AM0PR08MB5426.eurprd08.prod.outlook.com>
In-Reply-To:
 <AM0PR08MB5426BC141388A69BB5087732E1D8A@AM0PR08MB5426.eurprd08.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_5e95011a-3eb3-464c-a51f-65f490074734_ActionId=323fb50d-59f7-4f30-8f45-d130c5050602;MSIP_Label_5e95011a-3eb3-464c-a51f-65f490074734_ContentBits=0;MSIP_Label_5e95011a-3eb3-464c-a51f-65f490074734_Enabled=true;MSIP_Label_5e95011a-3eb3-464c-a51f-65f490074734_Method=Privileged;MSIP_Label_5e95011a-3eb3-464c-a51f-65f490074734_Name=Public;MSIP_Label_5e95011a-3eb3-464c-a51f-65f490074734_SetDate=2025-12-03T09:33:57Z;MSIP_Label_5e95011a-3eb3-464c-a51f-65f490074734_SiteId=22991c1b-aa70-4d9c-85be-637908be565f;MSIP_Label_5e95011a-3eb3-464c-a51f-65f490074734_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=miele.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR08MB5426:EE_|AS2PR08MB10227:EE_
x-ms-office365-filtering-correlation-id: d8f768f2-5113-410b-1206-08de324f4afa
x-miele-exorule: Spamfilter umgehen
x-miele-exorule-disclaimer-company-imperial: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LeRPM+WotCKf7fsEeSdu2KFCpCA4bo6aDPPh+DycWvNX2wgX/1Qufb5Q2v?=
 =?iso-8859-1?Q?gtfY+QeHzCRL5yC88bZeGy0Kmt4fPVw0/D36wD5KC4PKZSqVjZbxZvAlro?=
 =?iso-8859-1?Q?9pZIZsOV1SY6JzrYE6cB3c4yCVYcI9Lzo6iYPWWOxAjbNj6x5cSRc9T+cd?=
 =?iso-8859-1?Q?pTDdZrUfnnFm3uJeKb5yx37qP4DeHpIjrElumD4NaSo7wRdkWQpgY4BP74?=
 =?iso-8859-1?Q?kH137YXpwFf/HwUwH6KICpo9Zz/zkLNo/SyHq/YBPlPNKZMrIIXh6jFx/a?=
 =?iso-8859-1?Q?Dt7I7np+70NeMwu8thRzI2vWP0OGQScdlvoSHvtxCUaB19AUCHhil/zma5?=
 =?iso-8859-1?Q?qycGlXzkJjsB7q5rNOkNnpAJo7888A0UXz3ecZM667XjYhPiRrDvdhStNw?=
 =?iso-8859-1?Q?pqR7c+YZOz8QFm74QTLdAgF0Qrr6tYr+KV4PC8oonOdhhK3j9vTC2Xai8x?=
 =?iso-8859-1?Q?ChQMbXDvuaehCCv58Zode28rIY49fNbMrz00gUIMTQPvyRDJXmgw1zBSGd?=
 =?iso-8859-1?Q?/3UZLs7PIJ88qAoR5ukz/z8DGCRri600TD9dpozzfNPO+z3MXzlVZJXmHP?=
 =?iso-8859-1?Q?cbeAdR04wn4cEeI62RDFpvN2TcSfjRV+l7l2lFzfbFjw9AlWYTxg7TDtME?=
 =?iso-8859-1?Q?y9E6TdVY6srxqsYb/NUjkXPJpi8S0kgxjrHbawvzCzvH4Hoaq35yI18rpo?=
 =?iso-8859-1?Q?wcvzjZYJdSsH4Hg1NO2CmtZeAxIlHEBjK9J7Yofb9oW3JQHOSJ1XEk/hRn?=
 =?iso-8859-1?Q?Kkc740vufbtZFdMnu0pjK1/NLi0JnweCyKZjKyEZuZvdvKI7B/eN3u87+o?=
 =?iso-8859-1?Q?5NO9IQG3+9i/SQJuAHLZEdWK2BItdxIIN+Wh7cSZzIJgGXFxSSTUof7qI7?=
 =?iso-8859-1?Q?q3euZ2w1M6tK6BTB+BDr0Bp1VULZ/ZwX/0i7lFYz0HnkuTd+h/HYnNQqQF?=
 =?iso-8859-1?Q?4HONSVlXGTUMmtfxLmgQdHgRZr3taoiuHoCVTifijjRL9bHPyx1OICfOqM?=
 =?iso-8859-1?Q?IJu5Mz+leCt87FyiOSS/KVdIbn0TWco/DvdJQW6+PscYvfKzfeFSp5rjmE?=
 =?iso-8859-1?Q?D1P7+vh9aTcgYyzXCpzNSwTI/MRWjhl9G4hXWWvhFV9hGAR3RCpKPd9cQF?=
 =?iso-8859-1?Q?rfaNi6CeAYoIbQ4wbLT1GsqRMLP9rmr3PEtZLoC4F/shERETzjda7H7T6u?=
 =?iso-8859-1?Q?9AdsSFslXE9aup7YXWpGFwt7cPnfGYaLr1vW8G3txgeL+SuEJP8kwsggHe?=
 =?iso-8859-1?Q?XZsejtKuy77NnS7hcMtpZ8tQMWjbNeBPYrHqc2Hl78h0KWPh8HTHlStMxO?=
 =?iso-8859-1?Q?k6EPm+iP/3zNRD45XUAl1ah+HlDbgymanivhwYvmm534DFqUMwFTEIpDXE?=
 =?iso-8859-1?Q?rOMTMAn+PrNwdoJ+IoNMvJ3Y9v7KsrUZAIb8VC8OLIbOZ+gmeCh+7wMlQH?=
 =?iso-8859-1?Q?fls2OrNxqSP7HoMpXyGXX41FNk3Hk5zx7VPBbcDr8Iqd3HZkt3kdxAt7sI?=
 =?iso-8859-1?Q?5ReC7HFj8EXo5PPZmM47+MjZRsdJmmVCAto+YFCwtUYKBR59k8DcdIuFPa?=
 =?iso-8859-1?Q?bN9glRiCoY129jX8hpW65UyX3uKV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rYk5EMIbmg0H/OGFE9zpxjgsnKomTANzJf7RbebQzsKQaee/iDmnBGf93u?=
 =?iso-8859-1?Q?Mf2SoTmm2GBdz9cd2G5PWOUcWxN25WFPMDffTboXfXWfDnHK0qs5FvAaV3?=
 =?iso-8859-1?Q?22OGDfVHN36dXeudl6aknph9HBXrrcqHh6ZivX+1vlvUxz8/L1IRmQfIHJ?=
 =?iso-8859-1?Q?Bj1tMZkGGqbJOFob0JPWB5kXa0akRudJFSGfycV6I0myVQcPikH5ZffHPj?=
 =?iso-8859-1?Q?GpyuV+QPg1SDWf9aHkJAsOfpnc3PukcgVIdBejJhxkn80kyW+ddPNnjdT6?=
 =?iso-8859-1?Q?4rQbHBZ0FpaaztkUeA6GpD1uFpvGkceDX6Z9bl982IkFt5+MHhqrW2VCv+?=
 =?iso-8859-1?Q?jERhwro6QbILpM/s5y5ZoEk9f5O0/vw/x3HR+iIycAzMoHj5VhUPwZh5YW?=
 =?iso-8859-1?Q?yLTVpnFpNNHONBYQK4ShTEbROkl6d82rPv7C83hzMLrUEKWOEaqr229NV/?=
 =?iso-8859-1?Q?x99Qr4lHxrfU1hWzWnTfY4xETkcd1PfvE0oqVsOwfuuYD32/jAvi7Ijken?=
 =?iso-8859-1?Q?oHBOax1jTd6wXr9qP71hmuzAiH783VeVEUEiMFTcGxiV9BK4Gkbp4gzaIw?=
 =?iso-8859-1?Q?JArtyk9jMQNfjez7HUStzA8g/8b8C38SNJR8IEsKRQAKGBJLqUpW/dmAx+?=
 =?iso-8859-1?Q?WZQjR2rClhZ1HmunUm9iv2x3lLwyUE4p0fHd91kYh0KIgnnFCJVeCTFdMK?=
 =?iso-8859-1?Q?UumGAip2v1RymSPegz/rarvi/VNDY0MIOzzTZYd3fMjFe3GOVqxqRxxens?=
 =?iso-8859-1?Q?MP65pZEgChmbzMgepxLdC3a64SCntwukOMKh1Qu5BYLxwRIqNbyxt60IeK?=
 =?iso-8859-1?Q?4SW3s+7Ldwg9f/7Y1SKS6yp54wOhfXzcWZOaMbLjzr+1Vy38EancPbHiUf?=
 =?iso-8859-1?Q?fC76mmY79yjWADthXA594mC611IhqbUL9aGwbHDwnq+x5LMq/8XYIR4qmO?=
 =?iso-8859-1?Q?xQToZb8aqv5ULG9DDtwfr1ANrC3qDRIV97ndWkevA2f1kSwh6+hx90r8JP?=
 =?iso-8859-1?Q?VLs1sxn6/+4eSaGG0Sw2V9pqO1wKriECbzbcCpjTThq0rby1vRIvEzQGcn?=
 =?iso-8859-1?Q?oYRjWKeT+i/tntjeu2JJiur01OZ6nlnnE2OFQsf6/ock4aMvk6K97NxKIq?=
 =?iso-8859-1?Q?/97A5FJi/Dk+68QFPeowvMZmGdKjBKvh0Uq5CHSTYVPOE5zqbAIUDKlgq9?=
 =?iso-8859-1?Q?xF9+6Vg5q92zd/mEoDaJfBQjrcVfpLiL2JIZCAbI2RenfCiRWKzA8Ru1u0?=
 =?iso-8859-1?Q?+zBG5wBr8RW9nAIzSlRQr4pkDkCQRmax4Qu7iXG7gZ19cg9GtskAsfB/vf?=
 =?iso-8859-1?Q?NUFAqmVpSt9DaJQfmuKQRV0RGULeVTKAUxYyZ+CPFaYkqHkxqSZBRYhD7O?=
 =?iso-8859-1?Q?N6w5rWq8M+cNC4o1g6CHGu1bOYW7+YE9t3kmZs5YgCXomUN0IUggHND3cA?=
 =?iso-8859-1?Q?dILFzNNzBUP+h1/ZxAds9SxtzQgDbLsPAUMAT9XS6FtioLO+EZqpNZH9aE?=
 =?iso-8859-1?Q?HqLAFMPRaU+X5U15HlTi3Ga9EugJ3P+O/YyFH/tj2wZE5D25cyDNq0jHB1?=
 =?iso-8859-1?Q?YpFIT449oxgYT77p2Qy1bCL7UEqJaNEZubBLjqybD4uKyVN9DTthZC+OiV?=
 =?iso-8859-1?Q?FiJUglSa4fVm42JrXOfjYc07pii00jv+HB?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB5426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f768f2-5113-410b-1206-08de324f4afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 09:35:27.4866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22991c1b-aa70-4d9c-85be-637908be565f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbVq8xJYb4xShfaMJKWC/hhmkasQgcUU0LfW3ocYABr2nKNHGPJeuelKKxRVkXNsawjht3yIdxrp5Veb/6nHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10227
X-cloud-security-sender:tobias.boesch@miele.com
X-cloud-security-recipient:git@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay33-hz1.antispameurope.com with 4dLsv55bXXz42pnF
X-cloud-security-connect: mail-northeuropeazon11010067.outbound.protection.outlook.com[52.101.84.67], TLS=1, IP=52.101.84.67
X-cloud-security-Digest:fed5dba70779a84faec09ace27c0bc70
X-cloud-security:scantime:1.478
DKIM-Signature: a=rsa-sha256;
 bh=F5VnE3v5W0OfDokEMlQxqlzYaxlwfWqAQqgIJnCxTB4=; c=relaxed/relaxed;
 d=miele.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1764754533; v=1;
 b=AKypAyNRx8Sw31BkipA9jB11lMRnsn5B86ngQ+ty8vO+wfMSRxtk7XtfVI6bMu2sybwl1yiq
 VsX9WQOLgOOgQSu3v1YVLQ2HJRN0X9cdL5VMAMLGY+4Qo4+aFoXAmaEsTplIBumxB1dXvzLDyw+
 2OL0ruDX+hvohqYJ+EO4fJ1CAJcOQOSlFJsgFS5P8ykIzxu5zaAaF8S3PSZVcVljlvFbHt1v09q
 98W+rr6ttzBAm4kHk0gqOR0zYaa7LNq7sh5BHlSLlQ9ZKuGkS4MKBOM5sFGrQbJGF1hO4XkGUIO
 /E9GfedBt8moRoPqe0Ibjt6YTGeykThxp9Yw0o6BGgJ4w==

An addition for testing:

To test or simulate the usage of a smaller monitor
one can move both sashes of the history window all
the way to the right. Then close the application.
That are the same conditions as if using a smaller
screen, after using a bigger screen.
On restart of gitk the panes should then be resized
automatically to a reasonable size.

> -----Urspr=FCngliche Nachricht-----
> Von: Boesch, Tobias
> Gesendet: Dienstag, 2. Dezember 2025 14:08
> An: Git Mailing List <git@vger.kernel.org>
> Cc: Johannes Sixt <j6t@kdbg.org>
> Betreff: [PATCH] gitk: fix history window panes position
>
> From b2ca7abc7d7efffc7312859b700780abb927e0b3 Mon Sep 17 00:00:00
> 2001
> From: Tobias Boesch <tobias.boesch@miele.com>
> Date: Thu, 27 Nov 2025 11:27:16 +0100
> Subject: [PATCH] gitk: fix history window panes position
>
> When the history window panes in are resized by moving either of the two
> sashes and then the gitk window is vertically resized, the sashes fall ba=
ck into
> their previous position without respecting the users wish for resizing.
> Save the sash position when the sashes are moved to make them keep their
> position when the window is resized afterwards.
>
> When the gitk window is opened and maximized on a screen, then closed and
> opened on a screen smaller than the previously used one, the author pane =
and
> time pane of the history window only are a few pixels wide and their cont=
ents
> are barely visible.
> Widen the two panes on start of gitk to a reasonable fixed size that show=
s a
> good amount of text of authors and time.
>
> Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
> ---
>
> Notes:
>     Debug print statements are left in the code for easier
>     testing by maintainers.
>     They will be removed when the review is finished.
>
>  gitk-git/gitk | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk index 7f62c8041d..6fbc2588fb 1=
00755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2471,6 +2471,23 @@ proc makewindow {} {
>          -xscrollincr $linespc \
>          -yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
>      .tf.histframe.pwclist add $canv
> +    bind .tf.histframe.pwclist.canv <Configure> {
> +        global oldsash
> +        set parent [regsub {\.[A-Za-z]+$} %W ""]
> +        puts "Canvas (pwclist) configuration changed saving sash \
> +                position if parent panedwindow $parent is initialised \
> +                (oldsash exist)"
> +        if {[info exists oldsash($parent)]} {
> +            set s0 [$parent sashpos 0]
> +            set s1 [$parent sashpos 1]
> +            puts "   Sash0 is $s0"
> +            puts "   Sash1 is $s1"
> +            set oldsash($parent) [list $s0 $s1]
> +            puts "   oldsash saved for $parent"
> +        } else {
> +            puts "   oldsash not yet existing so oldsash is not saved fo=
r $parent"
> +        }
> +    }
>      set canv2 .tf.histframe.pwclist.canv2
>      canvas $canv2 \
>          -selectbackground $selectbgcolor \ @@ -3116,30 +3133,53 @@ proc
> savestuff {w} {
>
>  proc resizeclistpanes {win w} {
>      global oldwidth oldsash
> +    puts "Starting resizeclistpanes..."
>      if {[info exists oldwidth($win)]} {
>          if {[info exists oldsash($win)]} {
> +            puts "   Using oldsash from window"
>              set s0 [lindex $oldsash($win) 0]
>              set s1 [lindex $oldsash($win) 1]
> +            puts "   Sash0 is $s0"
> +            puts "   Sash1 is $s1"
>          } else {
> +            puts "   New window creation detected"
> +            puts "   Width is $w"
> +            puts "   Using sash from window sashpos directly"
>              set s0 [$win sashpos 0]
>              set s1 [$win sashpos 1]
> +            puts "   Sash0 is $s0"
> +            puts "   Sash1 is $s1"
> +            if {$s1 > $w - 140} {
> +                puts "      Sash1 greater than width - 140, setting max =
size"
> +                set s1 [expr {$w - 140}]
> +                if {$s0 > $s1 - 300} {
> +                    puts "         Sash0 greater than sash1 - 300, setti=
ng max size"
> +                    set s0 [expr {$s1 - 300}]
> +                }
> +            }
>          }
>          if {$w < 60} {
> +            puts "   Narrow window ($w), scaling sash in dependency to w=
indow
> width"
>              set sash0 [expr {int($w/2 - 2)}]
>              set sash1 [expr {int($w*5/6 - 2)}]
>          } else {
> +            puts "   Wide window ($w), scaling sash in dependency to old=
 width,
> oldsash and window width"
>              set factor [expr {1.0 * $w / $oldwidth($win)}]
>              set sash0 [expr {int($factor * [lindex $s0 0])}]
>              set sash1 [expr {int($factor * [lindex $s1 0])}]
>              if {$sash0 < 30} {
> +                puts "      Sash0 too small, setting min size"
>                  set sash0 30
>              }
>              if {$sash1 < $sash0 + 20} {
> +                puts "      Sash1 smaller than sash0 + 20, setting min s=
ize"
>                  set sash1 [expr {$sash0 + 20}]
>              }
>              if {$sash1 > $w - 10} {
> +                puts "      Sash1 greater than width - 140, setting max =
size"
>                  set sash1 [expr {$w - 10}]
>                  if {$sash0 > $sash1 - 20} {
> +                    puts "         Sash0 greater than sash1 - 300, setti=
ng max size"
>                      set sash0 [expr {$sash1 - 20}]
>                  }
>              }
> @@ -3149,6 +3189,7 @@ proc resizeclistpanes {win w} {
>          set oldsash($win) [list $sash0 $sash1]
>      }
>      set oldwidth($win) $w
> +    puts "Finished resizeclistpanes..."
>  }
>
>  proc resizecdetpanes {win w} {
> --
> 2.47.1.windows.2
>



---------------------------------------------------------------------------=
----------------------
imperial-Werke oHG, Sitz B=FCnde, Registergericht Bad Oeynhausen - HRA 4825
