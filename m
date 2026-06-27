Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022077.outbound.protection.outlook.com [40.107.209.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98871342507
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.77
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595048; cv=fail; b=APlef9w6R7fqlj1mghLuQJcvPW4l9sqiucrbgchgcwfRy/xHmJUR1mk+AzW8BITscQ/yZJWWFPfE40j/bB+Lj6bxlMpSqhg0Di5hraT7DrYlp2S2//Wce05WRKIgMzLaFCTPKD/494us4OTbtbB8kHICgO4iuHGzAF2k7d6hyps=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595048; c=relaxed/simple;
	bh=ZtqbD93Wfnu53OLeUEIxXvJOp33CHWR47u5JarFG2Yc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L2UG1M2VI2B1O2OnhKs7lRnaYIk4mTzQ6a06d1P+8/PJnvfK1dfnjyF/1/Y6VAIa0q5k+4BhE9RBgP2IP5LsWAdAPgd5xpQ4F5gzS+ctf7aAgZgLPetlsWlnmT4kg3QRZryCyUiPh40Lh6GKuTuJL+v/eQ8JxQJW1lFKOWTs/9E=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=personent.com; spf=pass smtp.mailfrom=personent.com; dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b=eGAlb5KJ; dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b=eGAlb5KJ; arc=fail smtp.client-ip=40.107.209.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=personent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=personent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b="eGAlb5KJ";
	dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b="eGAlb5KJ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=e5QTKbEL1zL6F6/ePM/bnr2MO+Q/z/TCYijMZGyT7ze+04JYLyvlYMjjTjspFjgGmG7l04O+AEzHPKSvEWyVUZRO5DepHO9zOV3mT9q8yS4utpwdDmQWh3gl0G13HbTensRltGSdTZGthPIARaPXTKI6pd4Yds+BibILvjrGl50UPc9h+uLDui6IJHhv6ctuunFyTFjfNEhP3g9y92VpiQD8u0Mgbqje59KK8umdcFFcMxg3d1WXtCKim8Latyu7eAwZdbBrto4z1QcroaCn3xNrHpbtaNk4mATiE2QJO/QzOxaC11vvnjVC1BR7thQiq+kyVPB3QfDocJU6bh7MzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cW4h3mYgkCLFpSe697LBGF3wS0lnowZiEj3VZzSgUo=;
 b=Gozu8h2KtvpL+8lDpKHBy6TNayxoPyvCyPNj9Ud5UgKGtB0/WdChsq/rsBabKltR82PMA9w12eqlgg76ZGNLAQWEvbWR6Fkcfyy3eoq8u/aCQMq9jwYl5/OAAmIcB4L2oSQy6Hj9yO7gFZxOsE0dTYnCf9qP16XtMkbHq3RV6spEay6Q0oFRds2tlErWX86uPgUFtHu+seaEjU/jFyjLE5fmAhCqRFLvtbeCYgPPZQefy2eYnL1exRu3gvped1oLXUehhFlNpwt90UNTO6CMe6gQfKGU2LlWFf0fWmEo7aHCd+YRebnKsUQxqh45qqfbXIpED2NoeQQ9ssjiPBt2ig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 24.32.222.183) smtp.rcpttodomain=pobox.com smtp.mailfrom=personent.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=personent.com; dkim=pass (signature was verified)
 header.d=personent.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=personent.com] dkim=[1,1,header.d=personent.com]
 dmarc=[1,1,header.from=personent.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=personent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cW4h3mYgkCLFpSe697LBGF3wS0lnowZiEj3VZzSgUo=;
 b=eGAlb5KJBHgNW8FdXFg0mZoVRCjf/t5vaO/MBJY1wNRwsufn1/hP3JV/Sd5T2Yh2Czm4iWbr64Asti8PJFuQNVmhHTcy6R089W5Lm2A/S3X2UhJCY1vbk7dlkl2erGZrRwrImATMcpvtotXvuoma2kMPOYnYzbDJvwebUr7/9keyrAvyWeunynW24fBywJatzMYwq+n4P5hQScM9rkAUPWB1zjUWCP5wB4S4DpcJermvfoVrfK/ggwDtFq/MYVM8VtWqSelMDwTm8sF8E47h4gdgGJU7VQOtnPeN/yw0YlPyT5pQymSubco9bKt/0HjUlaZzuqJLBs0ggrmIdhiI4A==
Received: from CH5PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:1f1::22)
 by IA3P221MB2011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:579::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 21:17:20 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::95) by CH5PR03CA0009.outlook.office365.com
 (2603:10b6:610:1f1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 21:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 24.32.222.183)
 smtp.mailfrom=personent.com; dkim=pass (signature was verified)
 header.d=personent.com;dmarc=pass action=none header.from=personent.com;
Received-SPF: Pass (protection.outlook.com: domain of personent.com designates
 24.32.222.183 as permitted sender) receiver=protection.outlook.com;
 client-ip=24.32.222.183; helo=webmail.personent.com; pr=C
Received: from webmail.personent.com (24.32.222.183) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 21:17:20 +0000
Received: from EXSHQSP01.ad.personent.com (172.16.112.162) by
 EXSHQSP02.ad.personent.com (172.16.112.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 27 Jun 2026 14:17:18 -0700
Received: from DM2PR04CU003.outbound.protection.outlook.com (40.93.13.59) by
 EXSHQSP01.ad.personent.com (172.16.112.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sat, 27 Jun 2026 14:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjHVnwfe666HLDZa5SOTchyVorHhYonHyIX1zaUgu+9OyV9jCn7pB7hYDzO700TsUZ7dcbZHk07jvKo2TN7hyV6IlSs60VjJlUNoYL0CuaZGCPQ2692ha0QKxat6TpgSyi+QARWoMY8ZFXH8CyMtZIHbNMjWe6gJtsw19U6qnYHIivxR387BaW7OOQCbsVd13CXFvhkOcs83C0y15mWNJBhswbu8HLrgvJUCuDivwDBQi6XdGPKAP4EHR3oFYA7wirBYFQAmream/tuS71I8g3tIZvFCiVBJRuq8p1+hEUaYPVMl0xOd67WqkDMF354ugudu/eZmG84xstupe8KmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cW4h3mYgkCLFpSe697LBGF3wS0lnowZiEj3VZzSgUo=;
 b=fD7IvwAEinnDZ/Z+MrX1dLxcqk1HA3/eoRk46jGYcIdukTyqpqJft/6OFv8Miq5fh8mHqUxEw6OW/EY/5GS3z9LTQBYalgR7xviqIWB5h9RezWaQV8SI6lf7DQe1fj84gXhtI1FjabAHWNtOA9kYIWxcNL8cyxqGkjCKuJpoOrG5UpUeJQlybITwdo8zfWvNI+bEflEUEeUgklOEe8/UWkr3QhiY3DXSOgRtZjX9aQ4qoiHbdwcGKiZt7j8CoK9vgjXHilkpv7xIcqGLEWYp5Y3K1jRRl5/10634RG9knZCWsbm5iWbY0AUcIHlUckjd3q4tXLj4b0p/lypqWmBlVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=personent.com; dmarc=pass action=none
 header.from=personent.com; dkim=pass header.d=personent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=personent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cW4h3mYgkCLFpSe697LBGF3wS0lnowZiEj3VZzSgUo=;
 b=eGAlb5KJBHgNW8FdXFg0mZoVRCjf/t5vaO/MBJY1wNRwsufn1/hP3JV/Sd5T2Yh2Czm4iWbr64Asti8PJFuQNVmhHTcy6R089W5Lm2A/S3X2UhJCY1vbk7dlkl2erGZrRwrImATMcpvtotXvuoma2kMPOYnYzbDJvwebUr7/9keyrAvyWeunynW24fBywJatzMYwq+n4P5hQScM9rkAUPWB1zjUWCP5wB4S4DpcJermvfoVrfK/ggwDtFq/MYVM8VtWqSelMDwTm8sF8E47h4gdgGJU7VQOtnPeN/yw0YlPyT5pQymSubco9bKt/0HjUlaZzuqJLBs0ggrmIdhiI4A==
Received: from SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:200::15)
 by CH3P221MB1118.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 21:17:07 +0000
Received: from SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM
 ([fe80::fb08:77b9:d3c2:fd5]) by SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM
 ([fe80::fb08:77b9:d3c2:fd5%4]) with mapi id 15.21.0139.018; Sat, 27 Jun 2026
 21:17:06 +0000
From: "Person, Tim" <Tim.Person@personent.com>
To: Todd Zullinger <tmz@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Security Vulnerability in Git 2.54.0/OpenSSL 3.5.6 Status
Thread-Topic: Security Vulnerability in Git 2.54.0/OpenSSL 3.5.6 Status
Thread-Index: Ad0GabCi7jER2lM0TbS3m4XEzhGxjgADz8oAAAAbDXA=
Date: Sat, 27 Jun 2026 21:17:06 +0000
Message-ID: <SN4P221MB071311FDE610296A5059E8F994EA2@SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM>
References: <SN4P221MB0713994458A94BFCB51F7AC494EA2@SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM>
 <20260627210718.zl0eH_Sc@teonanacatl.net>
In-Reply-To: <20260627210718.zl0eH_Sc@teonanacatl.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_ActionId=add6434f-18d8-4ed7-aaf4-4ccb5efb1c40;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_ContentBits=0;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Enabled=true;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Method=Standard;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Name=defa4170-0d19-0005-0004-bc88714345d2;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_SetDate=2026-06-27T21:10:19Z;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_SiteId=e2de18dc-8323-462e-8c47-561025ebc66c;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Tag=10,
 3, 0, 1;
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=personent.com;
x-ms-traffictypediagnostic:
	SN4P221MB0713:EE_|CH3P221MB1118:EE_|CH2PEPF0000014A:EE_|IA3P221MB2011:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdb4ddf-51a6-4b3c-df7e-08ded4917960
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|4143699003|56012099006|11063799006|4133799003|55112099003|18002099003|22082099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 iMeFNz0pveVN0sYnK4H5PS3Fxs00UA5wNiG7RiISUliqxWeQ9RoY0DZ3YX0cJ1EH69uCdpsvpY77C0ENshIVaNXIxOnIeWtnlN2YG49VKIx+Dao9p/Orgvu+IM78r3MHtbjttwp1GoX5d5obQvCXRunw1+sPSII3jDbwbVQIvOP7fODEgw6ekOHGxQe0+oMvY8l3jsalo11/aq81oN887muBi5fhKydid2zMooGKSuG1YozuMS7VQXiYgnpGD7MhtYviLgFvFU0oeyGSu9DsiF8DlszFpDj3vUv3uSkpzNsXDcAY5Rz1U2bihWQM4b3+sURbOl3ojVprWIScpAvI+opuNhzdBu1jyboAkVJcqGnRln+N0bG3oz6XnuDSajdC2SavigN8T5Ei8QmOYZ+joIz4pXPq7tvqCOZ1jvKrTdo1VZ6n8PDFOIMc1qM+tZsuf6q2M0YT/3nuI0VOE2LZBHynb/tGrkdzFTBtshuuqa7RjLpK/MZ5uOEpwFYyav+4+6/p/iWsHQvt/197eJguhpaSpMTeXZB+HHvCDDGHYCi7OpKj2zbBK65N/Ss7CSj+QnTySS34lz2d31JME5MRwgfLfn+xhGMbjH+C1CpGVa8R57mVWYr2niCK3aTxKa0OY4CornDgBuFV7PVzs58xdquHRJMDqoTKUzl4oASr5gU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(56012099006)(11063799006)(4133799003)(55112099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sr+srKyjX1aFl2Ru7zqWc//1fy9xBSlEpvmh2znnOrMsaypz2R20lHuaY8XfuuwYw7ARTf5pzWhUpdlA7+R5U/rh7S7WKlUhKM+G7ay3i4msSnH+T4RahARLK2Uvx+83QZ+AHkMa9MDiB6G7+I1QBEHur2QylJyVe7N6+W4VvWz/wxd+y8MRPyUSFsx7juy35v+HoXpeBqO4l1tr5h/X+coN9jCPDT9aTvU1E8WhB+VDvz2KReNEyxAMBn5oCal2cwLwJ/aBO7Uxw0+HuiJoYy7nsfRpLGVnLuW6JkiJqDmSuehb2XU2sICTO8t5qJaTVPrvoNHsxPVl7Bmf2MD+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3P221MB1118
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1b75c9bf-cb16-4075-7616-08ded49170cf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|36860700016|1800799024|82310400026|23010399003|376014|22082099003|18002099003|4133799003|55112099003|4143699003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	S9364Vcf4Etm5AQo+bH960MPP3mGWeHSxBgJpa6ry1fw7ka8MB3kJlWU4n0C1fvfgF6551dXElMris7OgauI1Jw7nrhv/AFS0Q4M1H8SkJd8NpNLa9fVBy7ObaJBk/2LohtSkKwO4EF+6Cg7q+z3EObt7Fl1gPBnblAb+806dy6q0gbXx/KMpGPK9bWYA2VbNw8EHFERJ4g0KUHvj+jnfgxNODFv/hQcz+30K2veuGL17A4AvJEakEsOFod0riBV07ddrpEyFXxhxi2D0qbGaKjXLyU09JRgwYbhCyWNj4xyoVghu9puuKz3ZVHMsq4Yfe6XzCPzk8Ifh8cj4Eyka2gUd7GpzKI1mJ1mEg4mdSHrFKFAY4fDyCDlEcL8STNcIhvY9wrkBEkqxlM1OsKNreF3LFuOrgAOv8VqBV6wfmLeHKGZ/0cmf/TaeibKwN2XJSDo11N8BvsQSvC9S6a2CsBsvHhObpQtEiu7M3UyYz4D30B/991nZjVrKEv8OUze27bxlRH7qY/tcx2cfRFfyN3v5iiAxFi9m2jCqGkVsZ/PPctve3mZgkTxQFhuT3xNPpOg1iY+GmOXJsm22ZPgnXPv8WM+vPjY0Ks+5nrabzH6n7Sdrca29+kJkn18sdZ0lC7sOsv7irkYqDKfL8Q+LA==
X-Forefront-Antispam-Report:
	CIP:24.32.222.183;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.personent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(4133799003)(55112099003)(4143699003)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KDJWzgIAkWVbFgEY/D70E8DrB7aYEEFVDP+S7L3E0DoNbvHcYqtZ/UuulWPskK/zOGp4HWd22wgTvXgTVgkxtjYZxz9OToONl5GMkDtWqcvEJC6qlb9Ep7TpND9FFXup2h8WGuI1FRvnDEmIokiA+qg7N4Rr6sIX1VXbJQ81YzkBnMQn8jqjjygcLTc9EihVNqMwsQLoud3BX1vrkQ4BaaT2BJGB5dpo19RSFH9EWgmzUGkV4H69aUAuSjIqRHUnERTwDptnJxuXkMrBSD5QlC43QMJlStrdSvrSfFN1hx//TKE91Oa5Oq9qvj5S1c2TUWsKetfHtx7+w4lvGNEFi9AlBxQNDF7+iYATGGggyaxQoW7jWbszzxZV/JGeRVx8f4yAzHsUz+diuJ1T88BugeERtIe2CigGyO7GAFgtQ3F/K5kL40OCaovGsDbvCwHr
X-OriginatorOrg: personent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 21:17:20.3395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdb4ddf-51a6-4b3c-df7e-08ded4917960
X-MS-Exchange-CrossTenant-Id: e2de18dc-8323-462e-8c47-561025ebc66c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e2de18dc-8323-462e-8c47-561025ebc66c;Ip=[24.32.222.183];Helo=[webmail.personent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3P221MB2011

Todd,

Thank you for the reply, the explanation, and the information about who to =
contact.

Thanks,

Tim

-----Original Message-----
From: Todd Zullinger <tmz@pobox.com>
Sent: Saturday, June 27, 2026 2:07 PM
To: Person, Tim <Tim.Person@personent.com>
Cc: git@vger.kernel.org
Subject: Re: Security Vulnerability in Git 2.54.0/OpenSSL 3.5.6 Status

[You don't often get email from tmz@pobox.com. Learn why this is important =
at https://aka.ms/LearnAboutSenderIdentification ]

[CAUTION: This email originated from outside of the organization. Do not cl=
ick links or open attachments unless you recognize the sender and know the =
content is safe.]

Hi,

Person, Tim wrote:
> I am writing to determine when Git plans to release an update
> installer to patch the security vulnerability in Git 2.54.0 because of
> the included OpenSSL executable.
> This vulnerability is rated "Critical" in the CVE
> (https://www/
> .cve.org%2FCVERecord%3Fid%3DCVE-2026-34182&data=3D05%7C02%7CTim.Person%4
> 0personentcloud.mail.onmicrosoft.com%7C350b58458bd84a5312f308ded490243
> 8%7Ce2de18dc8323462e8c47561025ebc66c%7C0%7C0%7C639181913006654964%7CUnkno=
wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMi=
IsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C40000%7C%7C%7C&sdata=3DcaMSGrA%2FfpxkK=
s2o%2Bg1dE9JuEQQlOK3IBt8BzbZ%2F7GM%3D&reserved=3D0). An updated version of =
the OpenSSL.exe fixing this problem has been available since 06/12/2026. I =
am just wondering if/when you plan to address this major security issue.

The Git project does not distribute any binaries.  You likely want to direc=
t this to the Git for Windows project=B9.

That said, it's not even clear to me that the CVE you reference affects git=
's usage of OpenSSL.

From a little skimming, the issue affects use of CMS (which is something li=
ke the successor to S/MIME, as far as I can tell).

The only place where git gets close to that area is if you configure it to =
use x509 as gpg.program.  And then git uses gpgsm, which is not affected by=
 the CVE in OpenSSL.

=B9 https://gitforwindows.org/

--
Todd
