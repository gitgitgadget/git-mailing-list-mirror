Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3113019CF
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293175; cv=fail; b=LBbKcL5hYan8Ea0jeyK+o84zBs/VWzFpCwIQaFmhKdRJh0MNj11xcV/pgiDfE0ZCc7cPkUQXQwkW6r6PTZbN8iVrK8WjuwMBCp5wREfRCt+k/Gbs10SuAISfyuiGWAEJ///cBOl5p0y9fxjKmwGy+kQbplz6FcluOwwBJgsabH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293175; c=relaxed/simple;
	bh=Y1MAokBvu3Bg8tw/jS8R1qzOsUWS61bG0//pSNeRYCY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u4iS0u0PbW1uyCT4lbQITGtII0Rs1/s3SmQOCDj12R6h9T3ghMatdPtpxVs0h/x4By5W67MZP0J2y62QE971ACCJwn9xHEjjT0ouPzOZ28aO2hexLLbOpxWl5i31R9n9ZWPGk3zn+iCgO0NbtSNVB/coO5hk+Am+sr/EdGM5JsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JKXbJriD; dkim=fail (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=t3hTk9rI reason="signature verification failed"; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JKXbJriD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="t3hTk9rI"
X-UUID: 4b942f52b0b011f0b33aeb1e7f16c2b6-20251024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:To:From; bh=Y1MAokBvu3Bg8tw/jS8R1qzOsUWS61bG0//pSNeRYCY=;
	b=JKXbJriDZVVkvBvYcbm3CAF9jNt/BsXdrd4F+4upOQhg8mIUc+2U8bBPcjuaTMg7Ceb9RyOjKeFwt3GdGX1nYOcv2Q8F8yXRs1KLltnlkqhuQMkTR+3ceGLqPTt7GwmWIMpwS/FeORHWWERYcXixGWBfyMWdy3dIHgMsgj5mL2g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:582b780f-40ff-450d-87a8-182811038f99,IP:0,UR
	L:0,TC:0,Content:38,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:63
X-CID-META: VersionHash:a9d874c,CLOUDID:6cc0c758-98d8-4d0a-b903-bc96efd77f78,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|110|111|836|888|898,TC:-5,Conten
	t:4|15|50,EDM:5,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4b942f52b0b011f0b33aeb1e7f16c2b6-20251024
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <david.moberg@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 744539298; Fri, 24 Oct 2025 16:06:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 24 Oct 2025 16:06:06 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 24 Oct 2025 16:06:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8FkjLqBw4ETEYL6kGrX2nP624BOOfK43a1OhnRuBIL4gFAZfhWSEKMzYB3L6ZCH5tsOM3i2ifGJidR5/wtPmRaLmNKLRK5UwWhiMqZbJGh6cbPzk9Cnhx2kLURCfcT6N9Aj6B212EqAPwZ+NlnVdug3BaQps5KaYFTiPAYYTXOsp0uPDLDaYJpzJ3SAEAfI4PSNX4bmyULPj7PTYxMop18eqOfqsGakLPfJ03eqcHzjm03uYpNj4s8VApOiJqS2Kz78hO0cZSBSb2oDgsFai29CCDMgIG0uMM5PWW2tSpQUsnpEnIRo7lM/o/gcNPTzQFqWQWjxPu8GWbqw4ETWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2+5OA75dTqty+WMpF+x8wHXHo11cnIVq6suKZStzuA=;
 b=EmHPb0XRMOpM4JowkepeE0SOHYGz9IOH37Arh8BT4SMhmalwBHTCqxOrGvtkY8EX6A+jdyXnRqB2K8SVunkwROK+M/uHB0q9AtDH0Fd0s8fqKPQSrJ5wwkpzP0d/klshBYC+SHbLQRrz7ChIRmKp0GOJBRJ8+RxsEzXCvtIa4ZHvWPqJTBEZxBYXPYMO6hFYOinoBj3uUKn5K+4kRXfpL8FfDmrzy6K7gTPu7ZatI8b2fqTJdWnN47KXOaquf6P0HVxVTbNdeCocryMOIig0i7q0hEM/3j3TgZ6pjIgrLXd6A0k0I9zIn8vcT3+x4FmcyLeNLLZ6W2VB2nakQ1+y2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2+5OA75dTqty+WMpF+x8wHXHo11cnIVq6suKZStzuA=;
 b=t3hTk9rI7lRC4F+kRLCuZMcTdlgOUkrHfik11ktSUszCb/7rit1/AjH9pwnwzMmgbOuDwM4cYzIDUBVjr1CMs8E+IhhHWgIOT4/Gf5k1IbQKJC0jI7lZE45gqVa9hxHrkjWFJjDMsgFeHIong9S+uFnSU4XLQEt5VNV8O4Q1EqQ=
Received: from KL1PR03MB5748.apcprd03.prod.outlook.com (2603:1096:820:75::9)
 by KL1PR03MB8730.apcprd03.prod.outlook.com (2603:1096:820:13d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 08:06:04 +0000
Received: from KL1PR03MB5748.apcprd03.prod.outlook.com
 ([fe80::9419:1a13:aa44:ee8e]) by KL1PR03MB5748.apcprd03.prod.outlook.com
 ([fe80::9419:1a13:aa44:ee8e%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 08:06:04 +0000
From: David Moberg <David.Moberg@mediatek.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git log format documentation/manpage
Thread-Topic: git log format documentation/manpage
Thread-Index: AdxEuwBQvy4rhyrlR/+0+oDWkF4iEQ==
Date: Fri, 24 Oct 2025 08:06:04 +0000
Message-ID: <KL1PR03MB5748DE5406618053D0A6CE0AEBF1A@KL1PR03MB5748.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5748:EE_|KL1PR03MB8730:EE_
x-ms-office365-filtering-correlation-id: 4ea269a9-ea4b-432d-4bf8-08de12d42dbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?dvPVjx6PYulzU/2W1ZHHSBuulcubbAQOZdNh5NdmYTHUoqK5vEYW0aZ3W95w?=
 =?us-ascii?Q?0G8o2jvGruiohENNEQbweQbsZHkp4BiWmlWWO9FMilSAMSQzpw9IfMdtAJ3s?=
 =?us-ascii?Q?YocN7x+P3LuH7QWPYfN4xdWCaKE2SSte3D4yCrIGsZMFmTMvenvzc7e55Xag?=
 =?us-ascii?Q?fAb5j+DiKjjA6II4pZJ9PWt6nYEVcsGPHgDPBSpmgYSYCVYeza0JZOzkINeU?=
 =?us-ascii?Q?LjcT1G22UY6EC/EMhfWNRzoUsKSyK+PaNibM4WIy38epQWyWEFuXcA7QZnVT?=
 =?us-ascii?Q?3jp0XaoIWmJvojoT9ivvlHAIC8XirF7ngnLzgJGi92W2ZWQu8bVM2QAS0cqx?=
 =?us-ascii?Q?2zqJekW9HNxn3jeK3OEjyb6cRrO2hNmB9FWLvhequ+xOVfQ69Fklmp7c+I2B?=
 =?us-ascii?Q?cN117lLG0gLsSE1KBmOT+/4w6SClWcfVik1Q+YFfNt8G1yb8CIdjbl3UW8xw?=
 =?us-ascii?Q?n8wCHpmhivIfGsyHg7gL2enfJ2LxP1MJU5JSmSn/1xUmKn/gXJk97YYJJwAP?=
 =?us-ascii?Q?qK1y+A0kbCJSS1d4B1FHaRix2dMPkekO8CYIMHHlLghmkqOH3rT4b4/CfePQ?=
 =?us-ascii?Q?nCeHaKtJuznPflti+4CGGq0PHYWmU3szHOtLo4U9Zg8OtwR9U66L/Gyo8gXu?=
 =?us-ascii?Q?+Gf0v/wroDh9VydnkWTYAUGdNKAbwFo3QQrFKZvmGttdtBpsOt+F7U2U9tGz?=
 =?us-ascii?Q?2wSFUIVu/kgFlDMLfda3itxLRCj5MWGVDMZPoSBXW/fMlPQiCzWdI+u1AcPD?=
 =?us-ascii?Q?uNHTh/SApH22kPJFU+EF/RD5Fojn+8yQ+4j2LUZPKVvKEze1gOXwd1uGqhdn?=
 =?us-ascii?Q?IUBLq4dwnJOSkbg9Mz/pYfEgtosvObQUSinfBQJY2KCNyGNzeJ17CAQr/AyI?=
 =?us-ascii?Q?D58xHIG+EAb1QEk4xx0E5tcNsFGBJLk5sRI9p4anuKrW3eioULlwfKhgBeX6?=
 =?us-ascii?Q?4eDelJrLemCTzsloOFis6AhYHOi7RqRnIH1vJ0f9lxZtfCyfF/knidlK0Xgv?=
 =?us-ascii?Q?A9X2tdDtFk6XbROsJZrZSRsudOx3bLbtHnP4LDxIFx6RwKirBVDjMDsqHEdc?=
 =?us-ascii?Q?i7SMErgNxpnQprURD6eRnH9cUPn+2bTMLGMu8F8Omotkcm3yLHAqub0Pndbf?=
 =?us-ascii?Q?OP5uxcLBAFhqF9h51h4tuJqmiOX4IDyzafskOzSs6YQVdn6c6NCtyAPOJisq?=
 =?us-ascii?Q?PP1T3454XwKUr3k6KnNiVlqHSqoT/5LKoUI4lGYAlQyEw4uciioCe3rSewBS?=
 =?us-ascii?Q?13C2GVSu/v+VEejK2d5hKnBnnUgCYtIxwsceW6FOPLjssASBtHl73GEEiZb2?=
 =?us-ascii?Q?jlFcmwN+BwaSafTwtSP0ljeEnRuPaEjFBsQRbqymI1SvVMeFQGSZzO/SFjnY?=
 =?us-ascii?Q?ZbqrWOFXo70Bc/xxGaCqwgcM4GlYMnI/ffofmbGP1ptlVxqaapsJR2dCVYgc?=
 =?us-ascii?Q?hnHpRAj1I0Dbrk0s0mH35ThN9JqREB9J8l8crET6+YbhQW5wySbwpZMG2AqH?=
 =?us-ascii?Q?ObZ2WI91SJqKLo9yBvxYb7dJeyPwJcrP4Sf5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5748.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uQuPXyTP7Ulr7r42XshcKsGmkk9uoBjCIHmzAmJPVgZ3jlIONnzdr5G0znxM?=
 =?us-ascii?Q?oyAPtvnYNAQfNZm/S5+vaTAuA485pkKgUPdb48Xf+2cyHrKTL6yfQ7yMwLpF?=
 =?us-ascii?Q?HCtkFnXAbbQiE5VgE+F3EVUhgrHLi3TQyhi0rt4qzlN99ly1YXZDkc1NzW76?=
 =?us-ascii?Q?UbXm8c3RpfpXYBAyGWgAc9Z0J0ZR7S/buLyyw1CKjzrZPU5tMzNil1GZcnIL?=
 =?us-ascii?Q?J2ClUaKojX566B6I2YLLQ9TKtKKDdeP3YEicDV3pI25n788ho51UGl7GXhSv?=
 =?us-ascii?Q?+KH27+QlXp02K1aX8QQv3M3iNAc7fpamrUPPKbn+hJ2l8gZGZM8i0I646TVY?=
 =?us-ascii?Q?ZDqbtZ2q4R0yYvMPSUiS7FsV2dOUfZqHOzqMuVjSu1y84buN0CxV1whS7tYC?=
 =?us-ascii?Q?PpOJwCbcJqtCc9LbxaRNqn304cBiH8srVfxMQvQ7/ztgiHKTmnncfYVsoe5f?=
 =?us-ascii?Q?jrUnFIV3oMCnyp/XLKxydeViOyqV8GLLqQ8C0UuUtilwyEARokoUpQLBYPyo?=
 =?us-ascii?Q?Kw4oOq+BbN+v8V/E0hk2+sBzvWmUnDAVCmDZkI4YTrF2XV3tLJKWc7gbUtuj?=
 =?us-ascii?Q?Uft74ll/GKoL0c/lAW44V1xdGMIgT9Flo708p9XZCiIJyQCsdlHrZpXExzkU?=
 =?us-ascii?Q?KZZbc4yzsT6oC6RFPCDU9wvOvSysFf+gTlc2ulNixMjrAPH6RlZnR0foDROs?=
 =?us-ascii?Q?pG5fsMLbvlasCiat2V0HHvHxSw7gh7xbChYnbekJ/nj/Lzitgi4B74pDtJLr?=
 =?us-ascii?Q?EiljMWETuJkv9AYzIGuUjuRN6GefjVaFf12SSHD03TH+dx6Q+BKY/mUIZoV3?=
 =?us-ascii?Q?qrb+UaahoNvOtmeiJQDaWJcdONNa9lRQdsID4DjTUrFt5SdXKAG0iJl8tlKK?=
 =?us-ascii?Q?AVE9UeCoCqDeKveivWMIhwQdpfzRlZZoLraLb2PYcIY6vaaNgny3MTXLHPUB?=
 =?us-ascii?Q?IucECs+FVm63o8rSqAd9y4m+Y3gL1WwQjL6XUBuZuS7Z+hZGIgWbDaV+In9f?=
 =?us-ascii?Q?HcNlKNGSmqQV/QaOpYDPSSGqYWV19ii86JQ/sxo+NzAJSMw+ZtQfZ3N7mmlJ?=
 =?us-ascii?Q?UZAC5ZLV64vS5qW2GmBWP7xZZOQDnLOw18UkxgCxL1fAq8wkeWTCN7gy/FT2?=
 =?us-ascii?Q?1zm3fld812VT48SaQ0a2j5T3hJIA5oVpUE8RWOMhqSXXClL7fTA4lCrifjdh?=
 =?us-ascii?Q?s50FWlkm0NZrGxm6PW1nFAjTeZQs8cOMhq66h1hACLkzrX2yNuQ9ERwaF9HD?=
 =?us-ascii?Q?MixdWuD6lBwL1phOkIAEd5BO9OzAlLudtZ34XqP6T/y9wfoimjCguOLUmgfu?=
 =?us-ascii?Q?MAwKFZBf9MOXw3JGERE3tTkRuM/36FnMDA6nuHbCbusQWsC3V6Yldw6zFXgJ?=
 =?us-ascii?Q?VWvz56oulZ9iQ5OxrpQukSbZ1AwvWNewoNzlZivR+ebava3Un6cee+7qB5Pp?=
 =?us-ascii?Q?JaqnsVUztP0Sxep6YBJpMvd3iAhoJWg6JNdNhXVumdF4uDE02qtR5DC55XSH?=
 =?us-ascii?Q?oNn8w/RDzsDylIKbc3c4QqJMnQFBY0OL2C6rZhz4ry8yxo1fY9saaryLJBsb?=
 =?us-ascii?Q?ay8mV+JVJrGyWq6FEi8GrPy+wJZY139xRl+0q6Jd?=
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5748.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea269a9-ea4b-432d-4bf8-08de12d42dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 08:06:04.3045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nyHcW26W6I+Em/9jpgtuSK288ZcCFO4JJ+jK/dxAMrk7LsWvVOHuuGZAHqvIO3SKADr5K6AHXBEC9QL5mt7BV09FRQ06KLAzolTltnpXi3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8730
Content-Transfer-Encoding: base64

SGkgSSdtIHRyeWluZyB0byByZXBsaWNhdGUgdGhlICJvbmVsaW5lIiBsb2cgZm9ybWF0IGFuZCBh
ZGQgbm90ZXMgdG8gaXQuIFdoYXQgSSBjYW4ndCBmaWd1cmUgb3V0Og0KDQoxLiBXaGF0IGlzIHRo
ZSBmb3JtYXQgc3RyaW5nIHRoYXQgY29ycmVzcG9uZHMgdG8gcHJldHR5IGZvcm1hdCAib25lbGlu
ZSI/DQoyLiBXaGF0IGlzIHRoZSBwbGFjZWhvbGRlciBmb3IgdGhlIHRpdGxlLWxpbmU/IEJ5IHNl
YXJjaGluZyBmb3IgInRpdGxlLWxpbmUiIGluIGBtYW4gZ2l0IGxvZ2AgSSBjb3VsZG4ndCBmaW5k
IGFueXRoaW5nLiBTdXJlbHkgdGhpcyBpcyBpbiBoZXJlIHNvbWV3aGVyZT8gICAgICAgDQogICBT
ZWFyY2hpbmcgZm9yIGBmdWxsLWNvbW1pdC1tZXNzYWdlYCBhbHNvIGxlZnQgbWUgZW1wdHktaGFu
ZGVkLg0KMy4gSG93IGNhbiBJIGRpc3BsYXkgbm90ZXMgKCVOIGZyb20gYGdpdCBub3RlcyBhZGRg
KSBhcyBpbi1saW5lIGluZm9ybWF0aW9uIChzdHJpcHBpbmcgYXdheSBuZXdsaW5lcyBhdCB0aGUg
ZW5kKT8NCg0KSG93IGRvIEkgZmlndXJlIG91dCB0aGUgcGxhY2Vob2xkZXJzPw0KDQpTdWdnZXN0
aW9uIGZvciBtYW5wYWdlIGltcHJvdmVtZW50czoNCjEuIHRoZSBwcmV0dHkgZm9ybWF0cyAob25l
bGluZSwgc2hvcnQsIC4uLikgc2hvdWxkIGNvbWUgd2l0aCBhICh0KWZvcm1hdCBzdHJpbmcgdGhh
dCBpdCBjb3JyZXNwb25kcyB0by4gVGhleSB3aWxsIGFjdCBhcyBncmVhdCBleGFtcGxlcy4NCjIu
IE1ha2Ugc3VyZSB0aGUgZGVzY3JpcHRpb25zIG9mIHRoZSBwcmV0dHkgZm9ybWF0cyAoIjx0aXRs
ZS1saW5lPiIsICI8ZnVsbC1jb21taXQtbWVzc2FnZT4iLCAuLi4pIGFyZSBzZWFyY2hhYmxlLg0K
DQpLaW5kIFJlZ2FyZHMsDQpEYXZpZCwga2FkZGtha2EsIE1vYmVyZw==

