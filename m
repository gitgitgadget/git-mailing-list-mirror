Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021134.outbound.protection.outlook.com [52.101.52.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0083803F1
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.134
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941989; cv=fail; b=jYOywuw796xPviy7rVkQNKWcSek0bgCTW76hFr727Z1aPR1+0lS+QZHPxV0HKXZc1lwCTLUit2Q1EjzdIiY2Us+p1aE/gHVI3M/+J/zu5cZd4YuJbK2tsCfK1i72vtzQb5i4ayy+Amw0qxnEpRzYsY34sZkmPGkH0RyiqRaiYiU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941989; c=relaxed/simple;
	bh=KV4pHT56Jx0zbHD/kclXgaMAHB3GCeLHyZadi+VS1GQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DMYt03Yf6rpiKqf7f+/CBf6QKzPwap1s2dx2kKrJ1bSxil3J2JdiEbafgDmOOifpONZOq7Y8IZgqx2kvP5O9jTUPWsHEmpPBDkfqlIkTvwm5UimG3P+zt8RuungSC38wwWlRB0H4G5neHiDIhHZXjT5xY/LCQUClbesOuhTgs60=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=personent.com; spf=pass smtp.mailfrom=personent.com; dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b=HwKd6JC1; dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b=HwKd6JC1; arc=fail smtp.client-ip=52.101.52.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=personent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=personent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b="HwKd6JC1";
	dkim=pass (2048-bit key) header.d=personent.com header.i=@personent.com header.b="HwKd6JC1"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=acRYdMQbpqruVQ0UGtEnl7TVdbXVLo4EDMXQbJu0cerLna8LBbRg3N7j3B/PdtCpQ3m6PktHV5xqkk9MvvOt4RRQw5kZjfqrnliAkegr0mAvr9Jd3t+xNLS0TcgFu8kSyJnkne31pcOwErH6OgWC5JLwy5dgBgt24LwbvJz8+FXWBqwSHygG6Sh4X5RY4IhYiLr1eGCSSg7aVt/cFiBA4uELx0Sr4Tkkp5GX86WqxcL3/gwqsS9/J2tqf0Z2tmjBqSUNjEoYVpf0K2i2YVe1ErnlMyagsYa3kNryD5GYDbHifHNBC3zUZnMHyR+gsy06i9W8v1uPrL93dhzxTNxJzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV4pHT56Jx0zbHD/kclXgaMAHB3GCeLHyZadi+VS1GQ=;
 b=AloeLRXXqbFUaBxMtqUW4YPVW/UiPdvTkAsWWSdkpkJvCX+pkX8gEJCn6jxPj7TgfDPGhUDoRBV7zY/5DnqPhluHLSDT14D0KBr1kkVqeQ7aTUKXOr4YD/xE07ZQGdv347OHc4Ro4PPBA34u5aSzPnuLk2SUtCa/BIMyPxCrRBO6oNjRy7A6MddrNz637MT2MSun9Qjr4LW6aXwyFSinGkHo+E8mxHFY6WBmlDucnqaeZMFhZjkQFRntRtETDAJt0VfgK4ksMFgq8tVpTUL0210JJFKkteC4a3KTuyMc8t6lqukphqMCafVAEdP3Nq/sVklNYa6PJnezkbxb9CdNIQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 24.32.222.183) smtp.rcpttodomain=gmx.de smtp.mailfrom=personent.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=personent.com; dkim=pass (signature was verified)
 header.d=personent.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=personent.com] dkim=[1,1,header.d=personent.com]
 dmarc=[1,1,header.from=personent.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=personent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV4pHT56Jx0zbHD/kclXgaMAHB3GCeLHyZadi+VS1GQ=;
 b=HwKd6JC1LlAXFDNel2Y/IgirkjVVajrMQ15s1cimFG1tIUVzXJAIAZgJgPdTgf5jZPvWomMtp6f5b0fUpaodcX4sN2Z+oFvwqLKfc5qrXy3yuWw72aO2Wkfwb0dKoMR8EQWC7OulyRH4dgZC6UhW0JQ2d7lrYMGu7CpBtfGQySCgMEO5qbbc/gTsSA+EcCHjxPMiEhTNZKSGf1PMq+wqG1jVB59dOI73HWJFYwBP36Fm+OG4nqQm1GVvJKB7SooXcJGBuSQ0sBWEeM3d/J8C689DsNvKDcfXorIQnWxMkIDX7v2QpH8DiI0c7e1dgMvmU3gyDPYE3k987dCdnkhMuw==
Received: from SA0PR12CA0025.namprd12.prod.outlook.com (2603:10b6:806:6f::30)
 by SA1P221MB471428.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:51c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 21:39:44 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::7d) by SA0PR12CA0025.outlook.office365.com
 (2603:10b6:806:6f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 21:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 24.32.222.183)
 smtp.mailfrom=personent.com; dkim=pass (signature was verified)
 header.d=personent.com;dmarc=pass action=none header.from=personent.com;
Received-SPF: Pass (protection.outlook.com: domain of personent.com designates
 24.32.222.183 as permitted sender) receiver=protection.outlook.com;
 client-ip=24.32.222.183; helo=webmail.personent.com; pr=C
Received: from webmail.personent.com (24.32.222.183) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 21:39:43 +0000
Received: from EXSHQSP02.ad.personent.com (172.16.112.163) by
 EXSHQSP02.ad.personent.com (172.16.112.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 14:39:36 -0700
Received: from SJ0PR08CU001.outbound.protection.outlook.com (40.93.1.76) by
 EXSHQSP02.ad.personent.com (172.16.112.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 14:39:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBuNsQeR+eWxq3+xUDOQVwVMdu17nCubCt70sjUf7dGt0TQ/Ay+geungH+4qfTDlX2guDav98GNJ0F3iVgpfkmKv8VCECYs9qu/4HBCup5DR7YRknF3xKhYwDsbxXl+rR7RGxBq5BqGYRjKXErqGQff7N5ExHVvle/L4OitNqU5GIILzw0zpjyKBSZcCqFPhnff9pSnNUDwgdoIrGmxgMuj0Mh+wNnlA/jXqm8JuwKynCDvmDOOl5mCOQHnlA0unDy8y3zI/76l7ACLa/3HgQ8aUNOYWcb6BDXJRsBqa0LZTGfUpnhpYP7WaRGiJgJi+iRGu8EIzcWh2NxpdvHRTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV4pHT56Jx0zbHD/kclXgaMAHB3GCeLHyZadi+VS1GQ=;
 b=GMys7XHZKg21wpD2X6QL7LpuD6zkdQDoGdEtKsCKodtrR+ZQAzsfZDGcbAPKHRT8s/m4ONGZw090TORRCHScaG0RjRIOa/BX699DcUUrnxuXnEOdGHwJKpc+Cq4VijNILoDwfIwGyJmcshZOxmjMxeUzVxlr/NP4EwmnxlZJ2kyOn9yjyes4P9hZIq5ftrlyI8bn+31X7WDUldjScd+7kiJ5CrwknswTKcOhiGyC1ON99QsDa7BqyQ8JCANnx9JW5vUacoFptQIKpw/PUI5pqB9rqb6rr4qRaxpqZbTshujudte7RKCkphQG9AKQHm7GVWG5cWa/s1b0Z0QT0TSR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=personent.com; dmarc=pass action=none
 header.from=personent.com; dkim=pass header.d=personent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=personent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV4pHT56Jx0zbHD/kclXgaMAHB3GCeLHyZadi+VS1GQ=;
 b=HwKd6JC1LlAXFDNel2Y/IgirkjVVajrMQ15s1cimFG1tIUVzXJAIAZgJgPdTgf5jZPvWomMtp6f5b0fUpaodcX4sN2Z+oFvwqLKfc5qrXy3yuWw72aO2Wkfwb0dKoMR8EQWC7OulyRH4dgZC6UhW0JQ2d7lrYMGu7CpBtfGQySCgMEO5qbbc/gTsSA+EcCHjxPMiEhTNZKSGf1PMq+wqG1jVB59dOI73HWJFYwBP36Fm+OG4nqQm1GVvJKB7SooXcJGBuSQ0sBWEeM3d/J8C689DsNvKDcfXorIQnWxMkIDX7v2QpH8DiI0c7e1dgMvmU3gyDPYE3k987dCdnkhMuw==
Received: from SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:200::15)
 by IA4P221MB1742.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:56b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 21:39:31 +0000
Received: from SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM
 ([fe80::fb08:77b9:d3c2:fd5]) by SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM
 ([fe80::fb08:77b9:d3c2:fd5%2]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 21:39:31 +0000
From: "Person, Tim" <Tim.Person@personent.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Security Vulnerability in Git 2.54.0/OpenSSL 3.5.6 Status
Thread-Topic: Security Vulnerability in Git 2.54.0/OpenSSL 3.5.6 Status
Thread-Index: Ad0GabCi7jER2lM0TbS3m4XEzhGxjgBZX5oAAHSvXtA=
Date: Wed, 1 Jul 2026 21:39:30 +0000
Message-ID: <SN4P221MB0713A20D5451F80499B36C4694F62@SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM>
References: <SN4P221MB0713994458A94BFCB51F7AC494EA2@SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM>
 <fe8a3a3f-d762-d2c2-9454-a57ac9a75331@gmx.de>
In-Reply-To: <fe8a3a3f-d762-d2c2-9454-a57ac9a75331@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_ActionId=d5fd7cfd-51fc-4871-bc1b-5bb22ab8e3d5;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_ContentBits=0;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Enabled=true;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Method=Standard;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Name=defa4170-0d19-0005-0004-bc88714345d2;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_SetDate=2026-07-01T21:38:15Z;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_SiteId=e2de18dc-8323-462e-8c47-561025ebc66c;MSIP_Label_defa4170-0d19-0005-0004-bc88714345d2_Tag=10,
 3, 0, 1;
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=personent.com;
x-ms-traffictypediagnostic:
	SN4P221MB0713:EE_|IA4P221MB1742:EE_|SA2PEPF00003F65:EE_|SA1P221MB471428:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8b1cc1-053c-48d2-b24d-08ded7b943d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|4143699003|11063799006|56012099006|4133799003|22082099003|18002099003|55112099003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 DpD44exZnmdXIlpWSbeAA04dVzYrZuYUQHfiX3WWVqNHLkDGu+oliI3QIYGhjT4WwnUYBwp0jUoKNnUJ7uELOMLzqJGk0d0AKDblg8qHikLybNjQdXNOiIi51HR0vEia7QtHnfVEqX7u43KAoxil5NokhnoE2ORzkoHyf4sEpVo/ARwFeL2Y6hfdOf716YZuU5AyEicdHOV27WiNTTOHH6rBc1HEcfxB4ymA4YLx7cp5B6jBoH0xBVOBwxKMOyJoRZCwk0vL0+K4/SMnwtGrfbD3Kmi5iuzGoXOZg7BxVdb7yl4BkCFYIhCbshjh5nWmf5tfxyQ71UfDUzxtmM8W4VwYxJKkeBIMs0ULtE3KzCT2fepN1ww3FGvSDipzujz8EVOKgskYRwctTfOv8ZiOdz2HfgQezPA4v/k9QWoDMlo/b/QS+zJtmo0u/vCrnoHag73JiBiov678AFg9stWdmpW8p1bS2Y9qV7OhfHuxgtlRBq/UZmRgbSzx6WDcep07LBf1ZrrKwnHgV9FfdEyFSQeJJJmye1Q1aJtLIhfsoA9KO6OYEY9T2JSmho5HtWRm0CHjfU6UddEqRgJI7wD2Qig93Aud01sYrMoDXhPXS1XjHXiXBVF3DO9FF+lv1tS46g2qnuRy3EUFYFk8sZNkmEjXcMFXuqfXN4PSAAc9Yd+HA2FzxjkxWdxpjZC4NwaC0FBMg5t7Zi5Pc+mhZKg0gO1tFvETXMjyTmfHNFNOwco=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4P221MB0713.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(4133799003)(22082099003)(18002099003)(55112099003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kKGE5KLwj1COUJun2fCTzf63cfMDExVg4Wo2gSR2R/h0NSaV0EtKE/k8FxRDC3aVg6C9neyYWSt8mZmkx/0u6eKwboxwD57WR2pRZ/HWZtBPEpoKrLg8WQsnEfqThnBtGqU5luT12QiUQXKkjGRWmKtsu+dUPQ3d9/e6yXCm4S/MBDJnDqCJWtNCWA2gqGhZBWfcg0DEFjaIZPKqkr+09Aez64OkEkHDTxUSKffGaYJ0POonwWdFvJ/iFFjo1kVvldRNqM48vx4OC6CVkNq/wYmMmbhBxYXjGo0IVcnGELeW9YxniNB/ufwvIuymvi9TFSXm+ehjrTOem8dI/vML0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4P221MB1742
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2d206698-5901-4770-4848-08ded7b93c09
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|23010399003|35042699022|376014|82310400026|36860700016|1800799024|13003099007|18002099003|22082099003|4133799003|56012099006|4143699003|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info:
	3zvfHjmqVTominBO/V+wjdFyPAqFha5xCs2HM8tebh7rLuglPrkSgq4AylRZd3Sw7DE2DCLreC5xIaKAWd7eOeY10kON8FQmwmfS7J7JaWIzXyPjNjk9lTCxJhfsu9+aBm2FWFNSEFnv+egkLuIywcTo/ZWQJOmBXO73BZdG0+/8QJvYu1cvrW7s7P9+sJlZxoFlgAqy4OJ+cG7pPNxN4Rv2Sh/6Ydlgiytw/E/lMFoo36QuTWmXxjhDmNOBf4kjm4TgSu5f2cb2/za2r1IjAXInjVQa7l6fybrdsiiadbJaIiFMsgWMZqvCwPQ9nWK1/Ph9UoxbI+Modys2+79aqZu/G7tCXx5esk7P6yAfEmzHRS11SMP3PwgFcfX+dCPiCN/RVsB4bph8VTF7oW7lNAg6qoXBmcIPl12vF9C+eWHD7tyKXcPcg3VahIGMpU3JEIlfxzvVuTumSI0PJAix3j6XmOJ6zORLDwQfna2QZfWG8HkZcbYsSDwvbicyLL12gKhnd3v6HNwB+cuORUsudu81ZgCcxFyHgofsVZhEduFcMD5hVu7ZjaecAYnedbB6h8hgKhuDGxmbBsRFexR+eIiJo2QmSxpspoCx2QA/jSgLvCwthj7J1CyABlRZUfXxZZQj7W0ejIvqntRPF8cQ0Ar0mZi8HIGSXjanpwyJbeU8cQDkg3/ROtENoryiQks8he2ON7DigNHgHxT5fGLgmg==
X-Forefront-Antispam-Report:
	CIP:24.32.222.183;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.personent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(23010399003)(35042699022)(376014)(82310400026)(36860700016)(1800799024)(13003099007)(18002099003)(22082099003)(4133799003)(56012099006)(4143699003)(11063799006)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H0FYKHt3WBk7PoLrBYHELtQnhPTsxQi34yNKxYNFoFy7OAiby3rDt5C0iphK9nzgOjnzEDYQcApsiHRRN15JKDL6YUSeJqfh23yNs+rnZ+0Lc1F+oVgEO+E7UdSFSn4NbSx1wvPhY1ERv4Nz1/7NIBMCPUHGarh8r782pA5YNk3pdDp2HHMLZLBp3En3EC3CoqjoM5UiJ7pZhX+uGPVNMvC79ppozrGW3lCZRIP6+DBVKx/PUDjxT1bO5eaHQLNle69Oxv/vTCYWwbpBS5sO3OLNGVyosuW5lhnR/nomYljjmnZznGEJhcA3aupHaGrWG7FncBO8MXn5BZ/1kfiXtldIQWPsU0QopxcTluUgrYp7vMNmmdiNnjyt6Rm9YjcUqfWjeloGhvq5JloYWoTb3DwxkaE9MNhsIOPSLU2jxA3FVnaBduugvpocqhFcQKUn
X-OriginatorOrg: personent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 21:39:43.9116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8b1cc1-053c-48d2-b24d-08ded7b943d8
X-MS-Exchange-CrossTenant-Id: e2de18dc-8323-462e-8c47-561025ebc66c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e2de18dc-8323-462e-8c47-561025ebc66c;Ip=[24.32.222.183];Helo=[webmail.personent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P221MB471428

Johannes,

Thank you for the reply. I wasn't sure who to reach out to for this questio=
n. I really appreciate the response and the insight related to your process=
 and timing.

Thank you and have a great rest of your day.

Thanks,

Tim

-----Original Message-----
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=20
Sent: Monday, June 29, 2026 6:57 AM
To: Person, Tim <Tim.Person@personent.com>
Cc: git@vger.kernel.org
Subject: Re: Security Vulnerability in Git 2.54.0/OpenSSL 3.5.6 Status

[You don't often get email from johannes.schindelin@gmx.de. Learn why this =
is important at https://aka.ms/LearnAboutSenderIdentification ]

[CAUTION: This email originated from outside of the organization. Do not cl=
ick links or open attachments unless you recognize the sender and know the =
content is safe.]

Hi Tim,

On Sat, 27 Jun 2026, Person, Tim wrote:

> I am writing to determine when Git plans to release an update=20
> installer to patch the security vulnerability in Git 2.54.0 because of=20
> the included OpenSSL executable. This vulnerability is rated=20
> "Critical" in the CVE=20
> (https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .cve.org%2FCVERecord%3Fid%3DCVE-2026-34182&data=3D05%7C02%7CTim.Person%4
> 0personentcloud.mail.onmicrosoft.com%7Cd04161ef041e4b2492fe08ded5e65ef7%7=
Ce2de18dc8323462e8c47561025ebc66c%7C0%7C0%7C639183382582991445%7CUnknown%7C=
TWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF=
OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D0dAHZbln7dV%2BrqdlWcsEGf=
DvkY5k0L%2Fon0NExDAIGzo%3D&reserved=3D0). An updated version of the OpenSSL=
.exe fixing this problem has been available since 06/12/2026. I am just won=
dering if/when you plan to address this major security issue.

OpenSSL.exe is not part of the critical path of Git for Windows. It is mere=
ly included as a curiosity for historical reasons. The critical CVE you men=
tioned does not affect anything in Git itself. Therefore, I did not even co=
nsider making an out-of-band release of Git for Windows merely for that Ope=
nSSL v3.5.7 update.

The next Git for Windows release (v2.55.0, likely due later today, may slip=
 to tomorrow) will include OpenSSL v3.5.7.

Ciao,
Johannes
