Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020089.outbound.protection.outlook.com [52.101.201.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302501C695
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782587984; cv=fail; b=Gkr/BWAK1fq2c4FcoYI/Pxr3UvxYxbf8g+1A76MvIceuSdRLhZVTxRpqjyoViwN7/Rg2VIoIvI3mASeqm1KheRGuaySb57gbKbrHjHX+gCczN8Xe/EzV+qoP5slYI1tt4UK0t1RYyNi5JZb7FBv3hcZDwzqh+oT3jKosFgozi4Q=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782587984; c=relaxed/simple;
	bh=9axOHKv4rfYuM2k4RBbLNe6fgcdTE/m7EDeIOuURRqA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nIi/7pUT8CJ0TwvN9dl8wlXliIdg2Rn/NQt0N9Mi57DTZrFZ0+K+un3y6+3Ois9KyS+AfMw3j92Nq2PpgjEEojy2JUUh115sQL6GFjHj2q7Xzx8iOE3X5tjprN2n9qED9cTVKwKJzjk5ayN2VN6fMeFO8oAckU0BImh4b9ljSRw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=personent.com; spf=pass smtp.mailfrom=personent.com; dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b=VrETwVji; dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b=VrETwVji; arc=fail smtp.client-ip=52.101.201.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=personent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=personent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b="VrETwVji";
	dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b="VrETwVji"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vbHD9OAS29kJco8kzRXK1MfY6hyMhG7e9OZ1e2bbiBWJo/HBMc83KnGPo5NO3SjhzpQj6J3HBvl5rq38pYIGUTxvLbCwiVeqgwwPQ8Fk9Ktf8yQvLD8EO134FlVMyCWhyflbUiXoNGdQ+LkuEHy29DQK02Pyb2i4PIvwHNsAOTFcK2NJxmbLNVMeUo+feAJALc+bjV+VyEARdvUDDknq09CAAD0XG+nIufpQdOxcVvx8sujFHHW4qsOhEc86DZPuGXqTjLSfPNABqHdEdgC1y+GlFbNXJLnmHPwfK4WXViQszgTt0maslr9cRcSG+JkhzV1N26HtzffD+Zq573+o3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9axOHKv4rfYuM2k4RBbLNe6fgcdTE/m7EDeIOuURRqA=;
 b=smr47KqTKxK3rSIv7GvS4Tx4LoCSqQabyShAVqRreyJXzQW6gu9gUImVvwz/8Smep4XGsMe9Lp2PkYa1SiIjNP/v1okmmkbDrLe2reBeQuR3ffuq7L+MMgmYArp5i1YopOA1jDtfjgwtdgKEFMWLb75Pc2ssWf/bHvzy7lwkGZ84REo80a7LoHbIOkc1LgTzDrr0sBUczwAasM5b/7OY8j6cdym4A990lsq2d2VIQwsRrewms2JonuIAUiX4UKLCtOYXouuFJYPVKE4i6Cb22W0eUT4kkbIAYtAp0i3t8oZNuybqZyDgfTcRwfnEhTiRxFUd7e+2w4swPxHR2RKe6A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 24.32.222.183) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=personent.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=personent.com; dkim=pass (signature was verified)
 header.d=personent.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=personent.com] dkim=[1,1,header.d=personent.com]
 dmarc=[1,1,header.from=personent.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=personent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9axOHKv4rfYuM2k4RBbLNe6fgcdTE/m7EDeIOuURRqA=;
 b=VrETwVjiK6yel4w8sk2srFLgoPnftJt9xV8TPmIzINzexx+oyi4YwROPbCLEmh2JxIzyQBhKzBBbeYraK2t6pNycFHJAB1nNsd9XN83HgDB5GmPmyeSHz684pIAVjjgY48UgjeGdEDKexU73EdBfAlj3vli6PchsVn4DdeTeUWWNOl2Ou6YGeoua6ybFJnvCcbi7EDMJ2lH6B0V/m/DBo4Cy1KWBiQL8SPQRs7ZJuwynwPtzb4xb4d2wZcQGHGYw76pCwrp+La9A9J9UPUc4GASxaLnzVLF602aBrFhX245dsFxgo8doRxx/OGPhncPHotwzb1at6p69u8TW/cX0qg==
Received: from DS1PR05CA0018.namprd05.prod.outlook.com (2603:10b6:8:23f::14)
 by LVXP221MB996924.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:38a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 19:19:16 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:8:23f:cafe::7d) by DS1PR05CA0018.outlook.office365.com
 (2603:10b6:8:23f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Sat, 27
 Jun 2026 19:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 24.32.222.183)
 smtp.mailfrom=personent.com; dkim=pass (signature was verified)
 header.d=personent.com;dmarc=pass action=none header.from=personent.com;
Received-SPF: Pass (protection.outlook.com: domain of personent.com designates
 24.32.222.183 as permitted sender) receiver=protection.outlook.com;
 client-ip=24.32.222.183; helo=webmail.personent.com; pr=C
Received: from webmail.personent.com (24.32.222.183) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 19:19:15 +0000
Received: from EXSHQSP02.ad.personent.com (172.16.112.163) by
 EXSHQSP02.ad.personent.com (172.16.112.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 27 Jun 2026 12:18:48 -0700
Received: from CH4PR07CU001.outbound.protection.outlook.com (40.93.20.99) by
 EXSHQSP02.ad.personent.com (172.16.112.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sat, 27 Jun 2026 12:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQrS68P5BXVupYzJzerktclMGRojJyFoWViHCzE05a8RGa4KByXesLjG0uoXTzSPq3iu6uqBWzBzCWsrAM7PNBZWEIHwX2l8QCPetD9SchDVBThkrsMgsgbrwiou6BFAOVfhU4kKCt0o4ugabqClE8O4KzGNnFKV+Zm5Z5Eh9DpiwtnblKPAY2B/vcRB6j06T3IuJZtBbmRXk4j/po/ZEdnx1wYI/MbjMT3svwAgmDrEwkOf17HvlVoBc+BIF9G9DXGpScGNo220BsfoY4IlWFgFoMtugSQA8LHcLLxeG1l6hLOML9G8aSldDnRd+FLTAaZ4u9j2K1VMb46vkvpXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9axOHKv4rfYuM2k4RBbLNe6fgcdTE/m7EDeIOuURRqA=;
 b=X910vPiB9D87Ax33m0d5hcSzlOds8gSvteKyEUAkCS/3MC3AnZLik+kQkZKjp5hZjPixKWX6+vJkcKigOKI7pT0Lw/W0i38Akb8KOttCZrhsZQqb3MlcDPRtb84peFbE3kz5LUq8Q1uDxJXIZj7ZkFrs92Lnnc/Ebvt+EGqAWFc7aSmXg2O+Ub4gzVBp5OmI3jMgVjvcXH35vCPfLuLWNg3nWoAzFf0lLj/r2NVEjGtpu0uV2LqOVtEh9H1TUIQw3RhI2YiFDlWJczrW0cknJCoX/+erEZ5YVWfzNrfb1PWPJMWVGsPwrgZQwVt9gBCa4mSpd/lUOY/xWgH0dW5VIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=personent.com; dmarc=pass action=none
 header.from=personent.com; dkim=pass header.d=personent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=personent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9axOHKv4rfYuM2k4RBbLNe6fgcdTE/m7EDeIOuURRqA=;
 b=VrETwVjiK6yel4w8sk2srFLgoPnftJt9xV8TPmIzINzexx+oyi4YwROPbCLEmh2JxIzyQBhKzBBbeYraK2t6pNycFHJAB1nNsd9XN83HgDB5GmPmyeSHz684pIAVjjgY48UgjeGdEDKexU73EdBfAlj3vli6PchsVn4DdeTeUWWNOl2Ou6YGeoua6ybFJnvCcbi7EDMJ2lH6B0V/m/DBo4Cy1KWBiQL8SPQRs7ZJuwynwPtzb4xb4d2wZcQGHGYw76pCwrp+La9A9J9UPUc4GASxaLnzVLF602aBrFhX245dsFxgo8doRxx/OGPhncPHotwzb1at6p69u8TW/cX0qg==
Received: from SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:200::15)
 by IA4P221MB1720.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:563::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 19:18:39 +0000
Received: from SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM
 ([fe80::fb08:77b9:d3c2:fd5]) by SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM
 ([fe80::fb08:77b9:d3c2:fd5%4]) with mapi id 15.21.0139.018; Sat, 27 Jun 2026
 19:18:39 +0000
From: "Person, Tim" <Tim.Person@personent.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Security Vulnerability in Git 2.54.0/OpenSSL 3.5.6 Status
Thread-Topic: Security Vulnerability in Git 2.54.0/OpenSSL 3.5.6 Status
Thread-Index: Ad0GabCi7jER2lM0TbS3m4XEzhGxjg==
Date: Sat, 27 Jun 2026 19:18:38 +0000
Message-ID: <SN4P221MB0713994458A94BFCB51F7AC494EA2@SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_ActionId=cfbb5ba7-62e8-48b8-9975-9815651903b5;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_ContentBits=0;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Enabled=true;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Method=Standard;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Name=defa4170-0d19-0005-0004-bc88714345d2;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_SetDate=2026-06-27T19:16:56Z;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_SiteId=e2de18dc-8323-462e-8c47-561025ebc66c;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Tag=10,
 3, 0, 1;
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=personent.com;
x-ms-traffictypediagnostic:
	SN4P221MB0713:EE_|IA4P221MB1720:EE_|DM2PEPF00003FC8:EE_|LVXP221MB996924:EE_
X-MS-Office365-Filtering-Correlation-Id: 40889e1f-5b89-4ed1-9a08-08ded480fa8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|38070700021|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 oYcCPFFflCI1QkOfY7nFWsHTX0KxHRhfZoI59YNDNJnhu9NYucaN3fayaueAFcKmK/zPcYxgxWtBOcAOdR/gOhrQhKrkGgoiedKMJ7RLCiKef8HYG4/ys/UMb+RlaTiLKTvBTefl4lMFkudX05F+Fy8bhm+putqNSjfg2SGi1y1qA5h1rsWHKDJ0Dcp4mTUenf1E7lug/dXKzfBFejajGHK88C+c0NqpYoZtP9bNQJTwd/KaxqtvvCNzSxm8Pa09T32WvFZ3Kswr8YQAcImRwXNLDr5wVMACR9BuoCubNfo4mQcf/BRn4SFZAMEwATg26hxuKFCufQC61VndvvGELdTTt1P5jNVEc4ZbF6eH8nLPj9+a35UOwYlDS2kPR6N6mRQa6nEmyaTVWLRN+wHfx3eDBRNyHnGvGTdQObc0xIHoZWSct0PP0EwBhGL+a04zVY6aTxs6qiZnyKTjP3GRFzOQyR4DIANj8s+VV2MGx6pZW1K8Gsf8J4q9ggR4yyRB/k/965NjoPsQXs2jCEG72eBvDNfnHfF62SG2sEbfEoSlB/jASe6jJm5X50wyYduESKzJJCOX7lOPTUPPPvg2wtWrH8049a0/YnIJMUYOCP8Nl9qoBUNs5y4dcjYWh5JXohKX4E0LNv1AHtIgk3g4i0gg9C20ZCoHJ0Bpuy7DybOwGTsFcUXRwGJgftn7QbJSWm1Va5up60zcUMjyaTlVNi2rKmipzZQ6CLIfvkJHJvA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iAdmaCGvwu5Hh/cfs/mIQNN2wn+nbhTPW20sWXuptAOuJFpnC8X6iKsKNVfJBKxyfmTCU7j8ERKpI8ftR42YQxddiSsWCciw9lZSHgcQLBQm4CSC+oDSa3cwdAcev5tVqiEUcI6ldfHcuoJbZqeuIQOI87lrhgRuBNepJOL2AoQ3nl4AC138U3eZQA9nZQ9taG+wHFBbW7QX433e2/v7YirpQTJTXKeRvF6DHx061QniwC3KJUVaXa+uYQaTASg/IIUbfE7oDVgt5O2Pbp+Q05mERzTvu2yDgPgeFHF5u9D3DtTR75d0kexd9fJ1utpWcTV5ayND+d7xzA5cjFMoCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4P221MB1720
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	de30565d-babb-4297-e90b-08ded480e4a7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|14060799003|35042699022|376014|82310400026|1800799024|23010399003|55112099003|11063799006|56012099006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	wQ2sa9OL3QjLCtvbgBKxjmEzVZyRa1OqPtaGBpSzeuhUafi2zRXNoAbqpWFV64Ra6Tj35T7aXVSOBryzYI/JiEZQxuhtoQjOcK9AUOuttlD8gVNnKrnUFvd+nssGndqvY7cZ1MWQCm+sObIaFqa+DWHdqCPEqghtjH3iravLVPTJfwDysXxG7NDlJM1uHwPi+yNwoLOi3s5LICrvDpprtwSvBLAXMFLTRS63QcO9QdhP3tuqglhn7l2Tate0p59pZ80sl7hRVH8gfx6/XjR16Q276rKOgE2mMn7S6Mw/fftWJb6qENHSJGwp/0KjuzVvrkcn9p0+3FGW9As3v/RpY1BHkZiCykbGeq4aqcuoKxrhGuOc7cB4hz+K2xSuOPamg9y3esJ+B9xcgqWSYTYWOsSkPlLK11x0ava/E5acUyZcZKVe+VAY88JfR+z5tO4hCpBltEiuluoIxaQo6e1zhNspLUGoyqpOi0kC/o2ZSTweiyLTbk/HMOmuggMJF5DEFUyPRsw9EOc/myJ7TDLbC9h0rxHh5iOtxW6oPPT8wVjxD11H8SOHYAw6cApCcPA4H2Z8TqA2EBchxwFrb5CrbUL+20QY2LQV5cBZUub2Ref31KxHr8DDAjeNaQOakyRzxhz54nGM8fmLk/yFpa37ai5KSCiLht+sHUbXHBKp3fi4YoLpJkwPOKcM+Rhl2ImQrY3jkV11P7vEbXBgopY2eA==
X-Forefront-Antispam-Report:
	CIP:24.32.222.183;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.personent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(14060799003)(35042699022)(376014)(82310400026)(1800799024)(23010399003)(55112099003)(11063799006)(56012099006)(13003099007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wg3B9p0HReo3RP6PbQBsaapOXcXAbrxYAAR/e04ckpWrqm4BxNfbG/KcV/QzYP41Jdi2lcSylMUOF/tbbiq+70aGAyNiQswphgond1HG49sjVuk6kbkX6LdwmiVQqQNnqKeoZ/raSwQqCAVegVG20MzDA+cQCVEz4iYhw2pT0Vrh4NktVMQyLP8H0cdAZV+RiqF/BCSlRc1pEyCmoEYX9VnOrpByD3h0k72P40LigXp59LUOgK0IQ+WwUMOrq4uPHs++MmZR9YW28JTXMFzZ6eiLynSg+RkRxPHGmLHOSE3NvJNUzjqE8JRmkLgHKsh3g4VSkN25cV+d5sQoqUqn1xbFUKv5mW1Z9PFSrc1R2RApR8yXBsuVZWC0pe0Y9sTGiP5meFU+kibA8ICIpNJIvWX0joKR0JcAZkXUFYz+sKo/ccLzn4wms+CBUUAXTStD
X-OriginatorOrg: personent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 19:19:15.6316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40889e1f-5b89-4ed1-9a08-08ded480fa8c
X-MS-Exchange-CrossTenant-Id: e2de18dc-8323-462e-8c47-561025ebc66c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e2de18dc-8323-462e-8c47-561025ebc66c;Ip=[24.32.222.183];Helo=[webmail.personent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXP221MB996924

Good afternoon,

I am writing to determine when Git plans to release an update installer to =
patch the security vulnerability in Git 2.54.0 because of the included Open=
SSL executable. This vulnerability is rated "Critical" in the CVE (https://=
www.cve.org/CVERecord?id=3DCVE-2026-34182). An updated version of the OpenS=
SL.exe fixing this problem has been available since 06/12/2026. I am just w=
ondering if/when you plan to address this major security issue.

Respectfully,

Tim Person

