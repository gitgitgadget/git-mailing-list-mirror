Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020132.outbound.protection.outlook.com [52.101.196.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14129429
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734627; cv=fail; b=XVV5R63njWlXEcOWsksCfdb1DtUtE2HfWXIoHcxMxgb9YqQHXKRbp3OOIDvyE/MceJIe3vvb1UOgtnsgp3O+zmp76V5klICYOzVliJn9wPsrgyH9d6UJfzkRHfz5sOU/HwybKkiPPAumzdV25XOqgcTMj8lJ0N+8mIFwzSsTpDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734627; c=relaxed/simple;
	bh=V2tcQbyQe3kIO4JaOpaqv6BO3z2zOodwxJTS8zMlOWA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dIm8b5I+8EWeuHbUI/owK9NG6Ir8HiqciPJxd2jml41At+XZ1j6Qjal2SfZqvZIFIdxtIS+FUbEG92shQmZpg0fNcExtAKdgHBlfIgAZm11lR/q4TCJkxe1vR25Xs5Dp1Lsj6KO0eiE/ypj80butu1x74hjaJSalFPuqgDmck3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shymega.org.uk; spf=pass smtp.mailfrom=shymega.org.uk; dkim=pass (2048-bit key) header.d=shymega.org.uk header.i=@shymega.org.uk header.b=oI9d9u0t; arc=fail smtp.client-ip=52.101.196.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shymega.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shymega.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shymega.org.uk header.i=@shymega.org.uk header.b="oI9d9u0t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/p9XXRKutleKbtJ7lotgiqnW6fWKWp2FuD5Ejo5dxQEtSMG6kHww+t+INf5SMwfuUHMFSc0CVVx7XkAAb03wS0qjWurx2RTPRvDfwxnOg2Qu4TfH+JxCEP0Jb8U9KjDK6NaaAdD8AlBEBkMOwuT8fmE7xZN5c6jekLYl8eeeeSMgcDjMTiInPvccb8PMPjQtXoM5TJ/ejUMZncY8RHDXt0h5Hj/1/zzcPON2+InFmZc8D8/GXOmccW5MAWFYhuAnatlwmotNrznX12I7b+qIuWZ6y5UWvMUYNWaYHIKwN4pnh+7laZmWGVGdHlNwqIr8wrc9Y2mrgFUX/8LsfhSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qbmw1y/pPlMVwCYR8ZFJ2x+mWCkT6OB8INtKgztdc0o=;
 b=e5/ji9FDOdGfpN9q13vPjrKOImt58qRnitkTXJO/tn3MzUatEllevMub7/lNoU5piF+yh8K9xXV4VQY8CwiZPBYD6ie0HYDdSgIRZIIUeRKALINlpWYKTzdjl6GXO8VHRaIbUgV/oWjeGIVFT9HY80iEUvUmvdIzWsfLQVAjbDFakRZWGNWCEH2UXmgGssLm7ababb3A0SZa5fo1sONqNeUAxomxA3O7Ig9MHkH0yoljeCtv8xFXiJ08xrjqkFkCAu6vHSAlq3x6Z8WgiSh43Ph/KQoXbtuXKup7LE/8l2pE8GKZ8EuIKLtT7IYEfTPYKvjgjFTrxi94UNa1XtW7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 62.210.214.198) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=shymega.org.uk; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=shymega.org.uk; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shymega.org.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qbmw1y/pPlMVwCYR8ZFJ2x+mWCkT6OB8INtKgztdc0o=;
 b=oI9d9u0tGAHV30I8V8FvwQsV5ckzqQwlc2vUmlb3Tl4iEr+agPff8qeiHqfMEW3BI+J+Q9AySB+UBeXASKLX6HIJtZTsqPd+8/oyLGKbOKOkcGl4DiUAO0IhkzNkmOsHVEw6wQF9oSAI44TBM7R5aaZIp7PwGAIzN8Ml70RiyzaqWSnGRimQQpoKFGl5byBayHLR7jCfOlc1Do/7ElZZqIgWDQ9LfwD9wHzeyYUQhLXAaDGUoc5VIn2D3EmM24hlOKEtJBDq9Kr2VfF3WaVvt6ypOkYyHjmpba8Psw8PKDs/mH9+gj+5ZaNLOjNixXN49nEsdvLGwALTuSeWGnTa/A==
Received: from LO4P123CA0447.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a9::20)
 by LO4P265MB3630.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 22:17:02 +0000
Received: from LO1PEPF000022FE.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9:cafe::2a) by LO4P123CA0447.outlook.office365.com
 (2603:10a6:600:1a9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 22:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 62.210.214.198)
 smtp.mailfrom=shymega.org.uk; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=shymega.org.uk;
Received-SPF: Pass (protection.outlook.com: domain of shymega.org.uk
 designates 62.210.214.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.210.214.198;
 helo=oracle.rodriguez.org.uk; pr=C
Received: from oracle.rodriguez.org.uk (62.210.214.198) by
 LO1PEPF000022FE.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8026.11
 via Frontend Transport; Mon, 30 Sep 2024 22:17:02 +0000
Received: from MORPHEUS-LINUX.localdomain (unknown [217.155.6.253])
	by oracle.rodriguez.org.uk (Postfix) with ESMTPSA id D1E7CACA004A
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:17:01 +0000 (UTC)
Received: from MORPHEUS-LINUX (localhost [IPv6:::1])
	by MORPHEUS-LINUX.localdomain (Postfix) with SMTP id 2902D1EA8E0
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 23:04:38 +0100 (BST)
Date: Mon, 30 Sep 2024 23:04:38 +0100
From: "Dom (shymega) Rodriguez" <shymega@shymega.org.uk>
To: git MAILING LIST <git@vger.kernel.org>
Subject: Rewriting history - email/author change on match?
Message-ID: <biapebw5nsonirhirnunsgu4wnbynt4zdn4rud5kdvwljnpz63@3hc3ujx2gosw>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fmx4fkt2az43sfj5"
Content-Disposition: inline
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO1PEPF000022FE:EE_|LO4P265MB3630:EE_
X-MS-Office365-Filtering-Correlation-Id: f82e1930-bfd6-4bb4-1377-08dce19d9c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTBxMnlYWnVYaVArK3ZOdEFNbkwzSnpsU3JmN281MGV2VDVzeWZPSmdhZUo2?=
 =?utf-8?B?bmwwcWo4S3MvbGVBeTBneEJIUTRXK1ozZUpPM0JGQTJtUmpJcGNpbFNOK3RI?=
 =?utf-8?B?b0VRa2IzbUZkVVdyS2JFb05BcXBNaEpQTm1qVDBQK2NMUlhDb3E1ekVvSnFK?=
 =?utf-8?B?STFYVHA5cFhhdG1ZL3k2V1dWVDdMd2lEN1NkWmdQZThRdmJiK0txTmIxTHRC?=
 =?utf-8?B?QnBDV2hpTFp1b3ljTE56T3hLbjRoY1BYSk1qR2YyKzJOYkdENGdEcGwrSjJV?=
 =?utf-8?B?d1RCM0kzcmZJdEYvYzYzNjhxdWdiSTFUMlNnSTlvVnZmQzZWM1Yrem1uVUZL?=
 =?utf-8?B?WFRwaHN0d0VWam1FdDhZQVBoay9JZWtabFlCb2sxNklYdXBwZDlFTUNYbTNM?=
 =?utf-8?B?R2tXMUFFb0lLV1NkMFdralhPNndvK0JNenQwZ0g2amFVM1EwcTJIa0Vyc2g4?=
 =?utf-8?B?M2xJM3drUlFCelBveDhkSmh0VVA5c3AxWE5jdm5IcVNtRGZzWUVqWTMxaEh5?=
 =?utf-8?B?TW1QcjRXa0ZJYVUxMElnZXFrN2d4L2wxUXdtZ2ZOQU03SzV3T3JWYW0ydi85?=
 =?utf-8?B?QnY5S20xcHBEMElrUXMvSEZrV2I2eEdzejJnMnhVUWFzNTR4Wk5CRHExSG9R?=
 =?utf-8?B?Q3NrcWxJSTFpN0h5OTRqMFBUaDB6M1ZWOWVNbFNSaUFXQmVuZ1lVT1R4TENM?=
 =?utf-8?B?R0Jqc0ZxU3JrNGMrMlZaR2lLcTlYLy9neExzQ3ZoNWlQWVk4dXlxVmhXam53?=
 =?utf-8?B?c0ZiUzBBTkZ3OFdGMHlka1ozN3h0N3haejh0Z28yYnJmZjcvYjVkc0tGSHc4?=
 =?utf-8?B?aWdvNWdUMytRQ0oyVXdwZ21pMmlmYlJTVjFzeHpxc3kxdjFINklSdllBWk5W?=
 =?utf-8?B?cWttQ01YQnRSMFJ6dnUyazE2NzJ4OG91YVc3SFZ4VEQ2Z2NIczdLSjQ3YXpm?=
 =?utf-8?B?cG5oQkJickt0eGtyUUhubkkzVGVrbkN5a0EzaE9tbGxEL1p3Rk5iNEtCT2s0?=
 =?utf-8?B?VGRqRC9ZNmVZT3ZDRlVMRzRXNTNMb0JZTktLdFRadlErekVoMHh4eEhyNEo3?=
 =?utf-8?B?dlVoWlNNYXdveFN3RjR2eExBTk9hQldvUHRHNy9XMFFWYmZhSTJQNllkOG1p?=
 =?utf-8?B?N0M5MndHalk5aC9LMTl0QkcrRkQvSldtck1hSjVGM21SN2d2eFpMT3M4R1hS?=
 =?utf-8?B?NVpySWJjV0JyRGlWeTMydW82dWtMNGpkdlRmalpQTTR6Q3RuZW5TWWVsdVBB?=
 =?utf-8?B?NFJUUi9yR0xjOCtzRW8xYVF1Z0trQzFrZzlFMlkzb3hWeGxMUkhId1NMK2xn?=
 =?utf-8?B?VGZ0aFpBRWlxNEhuaWJkQkNPOG1relhRYUxibVUzbkhlUWcxK0VIdFZaS1Bs?=
 =?utf-8?B?ZVBDNjlzYVZEdmJKWDJucU9ON1YySnU1ZFY2Q3doM3VHaXlYVUtFK2ZmSzFG?=
 =?utf-8?B?T0N3Y0FBSS9mQm92K0Y2ZzlhU0N5NW1LVUI0a08wTWdBSEk1aTM4bkxqcktC?=
 =?utf-8?B?aU13ODU5YkhvZU4ybkMvK2FtdVVEOW51YTRGQVhVY3lNSTVRVm5YZXA4ZytY?=
 =?utf-8?B?ODNCZVFmTlJ4SzZJZ09IRDdrY201RFIwK2hWbW9ld1Rnb2h5M0psczA1OUZk?=
 =?utf-8?B?NkJtelJUdUpxVFVQWkhNdi80VGdZQWxqellJWm1pNmxqSlhyRzZPNi9iVUg4?=
 =?utf-8?B?UEROSUJwVVRkUUFjK0lDQXcxY3VTaHJiQXAzcGQwTC9BVEVLYjdNamN3Tysw?=
 =?utf-8?B?SGVObzR2WUtLT3ozV1FoUVNqTDdYZENhZllScWE2RG9LMk9lOTFHMUk2Skt2?=
 =?utf-8?B?RmJ4cnlNbnZMNzJwd0krbkZxV2puWGRNNFBhcE9DdERGT1ZEa0RsOU9vQkJM?=
 =?utf-8?Q?RKx8ojH1N11PR?=
X-Forefront-Antispam-Report:
	CIP:62.210.214.198;CTRY:FR;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oracle.rodriguez.org.uk;PTR:oracle.rodriguez.org.uk;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: shymega.org.uk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 22:17:02.4409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f82e1930-bfd6-4bb4-1377-08dce19d9c1d
X-MS-Exchange-CrossTenant-Id: 7e15dc52-0465-4028-b82a-3c894bbc5ba6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=7e15dc52-0465-4028-b82a-3c894bbc5ba6;Ip=[62.210.214.198];Helo=[oracle.rodriguez.org.uk]
X-MS-Exchange-CrossTenant-AuthSource: LO1PEPF000022FE.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB3630


--fmx4fkt2az43sfj5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

Hello,

I've got a few private repos that I am the sole contributor to, but some
commits are under my usual Git author+email. These commits are
automated, and I'd like to rewrite commits that match the commit message
(the message is consistent) and the 'old' author+email to a new
author+email, but retain the commit message.

The tool that springs to mind is `git-filter-branch`. However, I've also
come across `git-filter-repo` on GitHub.

I'm a little confused, and I wanted to ask for advice on the list. I did
try using `git-filter-branch`, but got lost quickly with
`--commit-filter/`--msg-filter`.

I also found a 'users' Git mailing list on Google Groups, but by the
warning I got from Google, it has a spam issue. If this is the wrong
place to ask for help, please do let me know.

Thank you.

Best wishes,
--
Dom Rodriguez
GPG Fingerprint: EB0D 45E6 D0DC 1BA1 A2B5  FC24 72DC F123 1E54 BD43

--fmx4fkt2az43sfj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6w1F5tDcG6GitfwkctzxIx5UvUMFAmb7IHYACgkQctzxIx5U
vUOqqBAApxwMDmzcoHzC5fP2iLvZmIz0ulvrxc55FiWIxQB7IIdcMLhh5QzOfP/q
kP/t19OjBsDaHbyQYBg0IXrtEQmTYSf5NiLHcdDRO529KLXVTJ39pjdSiZrCUJ4L
lo89fWCfv1KkjMndoEyvB8sl8ztxFznklSt+j80Kdl3S/OOla/5L73Y1uQIFmlVP
Tih+Z0uYkvMdunAhjsqnZQrh5LREctviXy/x4ww9DF5iJLNMw1hTQydWjGeyezIs
iFh7i8Ob6Jvn1ZqweAxr8qQjbz/i3yLD3wORSvTrWmw6iW65DUAUWMItlZSkikqQ
h69TEuzyA/GK0meoKHz2LBIGZe/E17F64RaKA9+LcweUJ7SrBNIeVoCP8AOenne5
Dy4FvEJPbl9k7Ww/94Twj7SdsWsfiv2MfQYiW++VOf3wQAmuJ20MtCbduEGQzmAE
IwOa48yo9FJktjUVes7XSDug92wCGtkpcxyjCnv7jyh+hUwj2D9oULlv+PIYIvjr
0oW+6sWSKHBFEf4p93+SWCYafRwtmTtwRYKYULnSV3F0vP+4/ZTlpd00/y8Vgc5q
rGzuhbanQno26HeFoGLhmrCp68ZEd5rGjdbcF6zC2N5JGObzpMc9AcFXnK9S8lUx
jF9fBOk9O1lGeOiA/qOFsSolC0ahUgKW0Li2TwSrCI0FJM3adsA=
=GT+9
-----END PGP SIGNATURE-----

--fmx4fkt2az43sfj5--
