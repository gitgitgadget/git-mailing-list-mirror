Received: from DXZP273CU001.outbound.protection.outlook.com (mail-uaenorthazon11011060.outbound.protection.outlook.com [40.107.54.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249A19E99B
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.54.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907642; cv=fail; b=cWdV466U55sghq5lqyHQXejvofzExMH1NWsGDOdNj/poBmzt8npueo283ScEvTc/CJtjJ37lLv/OisLhZcmFXULLuJwx3k2hvaUrAEfKESwBcOTkjCM+ZESbAucHMexYx/6RtJ2K3M7i2F/2BBm51SdOYyWsYCx4BYBXmE5MgVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907642; c=relaxed/simple;
	bh=WUjDog8tALz9Ij05DbYUh45K9Q0VdxJ4gzd3RHIxhsE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P3ONtbG3qsqBFkwit/KxhAmQ31XvNuvJaiGiKwW9KrocXb7aichQSpCA89f9dvCHdmMmF+vv7m10alSSpEijKsGhfouEEpwuxmDj50T9d/xUXC1gkjBLc81ZW54bwO+q9cs92quMPDcdUJZD0P0xD/Q+V9UXviizEtXJiM6FKt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cnsonline.net; spf=pass smtp.mailfrom=cnsonline.net; dkim=pass (1024-bit key) header.d=dpworld.onmicrosoft.com header.i=@dpworld.onmicrosoft.com header.b=JHmXWzto; arc=fail smtp.client-ip=40.107.54.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cnsonline.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cnsonline.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dpworld.onmicrosoft.com header.i=@dpworld.onmicrosoft.com header.b="JHmXWzto"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGbU9LEW2ESWTq8fvMb9t7EEB82DInIl1DXDdGvote8ok7WkJwZtXzHPwaaKJV4pcTxr+pu25hO6U2X7IsTwhEVXm7gvQQs0fsnUIHGk2uFJ8VxVbO5CwrgL2r4FJb5uSoABUh+ujNk4RP9P3DYdL3eq4O8sa2S4HRJsiIgcaV81pdIhLLg4xt025OEVEIc8jSv+29IwqszO8WqwFiPXO/Yz55rguQOITXbuFuMgENToHQmdibtHJRgKLC4t5chyMdGei4JlwRX87CkibNx5AuB4BpESYfS6mq9+ojmRvr73XrxDMSeMyK3B40ykn6xnZBE/sClsMl7Y+s2e8UX/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkGQOH4TuAgpu/pxnuaJAgiIZQGurV2FvKYCdszBaeI=;
 b=V8+He+FCUwjolqu8qYrtCNQWLPs3qjoAKL2NJBgoZPXpHmw5gTx5ucCgkqt9HUrP5BaRAQFhCOjVW0Xha2HH1ZX8dOAwU949ykeAVmUeJalR7nx4zZSVT4IOLdS/PomqV/xXVG1zrngvp9a3ui6hMsMUnzdmJrRIVv6TBegSw2toLSVXFor28g78b5HAj236YkVnbqxTdBtg0KKGkv2jZRZxqBX53+8Xk8HKnor3VUJUxFakd7Ed9V9v11T6o02wOa/IKMGzY4CGm41ZoN+U7/qQIgCeCP52O1uGXnkzyO/aptIiNC41ITYXC8kh6jwy1kybtZukQtq6nfNXguPmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.74.131.131) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cnsonline.net;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cnsonline.net;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dpworld.onmicrosoft.com; s=selector2-dpworld-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkGQOH4TuAgpu/pxnuaJAgiIZQGurV2FvKYCdszBaeI=;
 b=JHmXWztonrKb72l4Fr3SIGae9ADIvlqNPmgX2/7XlhZkUFZLhe78l5Svjf8AypDppYBSDqzPzzv3Sv+HDVwg/jtQt+pu3wO3Fi+lQyIcN02GB7/NWlYASVaEnizg8aTwr22G2y428wJCP79+KcV5fvDF8fVeWtH+eiSqykGjeK4=
Received: from AM6PR08CA0046.eurprd08.prod.outlook.com (2603:10a6:20b:c0::34)
 by DX5P273MB2185.AREP273.PROD.OUTLOOK.COM (2603:1086:300:b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 12:07:14 +0000
Received: from AM2PEPF0001C712.eurprd05.prod.outlook.com
 (2603:10a6:20b:c0:cafe::e5) by AM6PR08CA0046.outlook.office365.com
 (2603:10a6:20b:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 12:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.74.131.131)
 smtp.mailfrom=cnsonline.net; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cnsonline.net;
Received-SPF: Pass (protection.outlook.com: domain of cnsonline.net designates
 20.74.131.131 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.74.131.131;
 helo=email-signature-server-deployment-84dc76766b-pdfc8; pr=C
Received: from email-signature-server-deployment-84dc76766b-pdfc8
 (20.74.131.131) by AM2PEPF0001C712.mail.protection.outlook.com
 (10.167.16.182) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13 via Frontend Transport; Mon,
 14 Oct 2024 12:07:12 +0000
Received: from AUXP273MB0503.AREP273.PROD.OUTLOOK.COM (2603:1086:200:25::13)
 by DX3P273MB1509.AREP273.PROD.OUTLOOK.COM (2603:1086:300:7a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 12:07:08 +0000
Received: from AUXP273MB0503.AREP273.PROD.OUTLOOK.COM
 ([fe80::ff54:5a6f:439c:6504]) by AUXP273MB0503.AREP273.PROD.OUTLOOK.COM
 ([fe80::ff54:5a6f:439c:6504%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 12:07:08 +0000
From: Jordi Balcells-Smith <Jsmith@cnsonline.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git bug report - CNS - Shared repository permissions issues under
 RedHat 9
Thread-Topic: Git bug report - CNS - Shared repository permissions issues
 under RedHat 9
Thread-Index: AdseMbCJ7WEm6Ip9QeCqErzSBzroIw==
Date: Mon, 14 Oct 2024 12:07:07 +0000
Message-ID:
 <AUXP273MB050333B19CCE93899FE9F26DDB442@AUXP273MB0503.AREP273.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_ActionId=6fee737e-ee48-41af-a08c-dd9c9a305140;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_ContentBits=0;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_Enabled=true;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_Method=Standard;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_Name=DPW
 Internal;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_SetDate=2024-10-14T12:06:42Z;MSIP_Label_1d29d5a0-e4b2-4274-b79c-f85cb0068166_SiteId=2bd16c9b-7e21-4274-9c06-7919f7647bbb;
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cnsonline.net;
x-ms-traffictypediagnostic:
	AUXP273MB0503:EE_|DX3P273MB1509:EE_|AM2PEPF0001C712:EE_|DX5P273MB2185:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d1b3f8-c4d0-4694-4c29-08dcec48bcc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?XoZ6ev2m19VN5N4Z0+lPliVFZletESk3G8UKzf9hVDOwXQYXEKGDOqWAZu5R?=
 =?us-ascii?Q?qmVuvjCjcMfjID+VSkVtE23oP11BvHKK6YScD4BBY5qq22ZHUZjULyUVjjju?=
 =?us-ascii?Q?ekNkBLI5DHJHbVSrb53vLv+vNNTJ7bIzcqTx4otsgkXPNzGDh3dvCoLKpsyK?=
 =?us-ascii?Q?IJRMOrcQEsuzFRlXCxguZHgE8pM9AT92YSu/axG5ZRdYmEP8XiyR/rn4arV6?=
 =?us-ascii?Q?hGQB3soZyLxMk+QS4vX9bszO1emCLHHsoRymsOYUaJVkgc6OOTF3F3hau0R8?=
 =?us-ascii?Q?uH98V4ZqECPqf51dO0DjYbr3abqFYpjXjI+7nKejxkGbrDUz4MIcVYOMs6D4?=
 =?us-ascii?Q?Jb8vAN5xa/VnSSlkw9JwtESOU87zK/sJsrP7nwrI7V7eJxpz4656I30lrQ5L?=
 =?us-ascii?Q?JAMxWZbFf6p9u2maecFqjeReV57K+ZDxpdN+MXXkdUq4znn4Q9K6YuXwzmts?=
 =?us-ascii?Q?r0FP5QlPLiulp2mdDweK+7EhJyUvNoEZG2W7IJr+1mg0kogeZqhr3WkmkU/1?=
 =?us-ascii?Q?XkIKfm9Jo5iSJbideVQbCxE8MGNPRUoVeZVGVTZbWJ+FekDeICGFR205KRYy?=
 =?us-ascii?Q?SsZY9Xs3VjXQi/oGPuLMc6rOGQhGDmM/fOKAVScxCqC8HuM+baTqIy0VpwIu?=
 =?us-ascii?Q?R7FQaYriAa9YZN4Su5I0qoPhojJs5IZDiD2xqwfN2jtWWU89AWsVwEl410oZ?=
 =?us-ascii?Q?9xcgLGma5UJcZRnV8xQzBPTHyKUmvot/2KpuG3okZOK/TmKjBt5Lni1j1ndn?=
 =?us-ascii?Q?uMNltVE4uwWKZLT797tXGORpeWdLkJN9hXvZ7SU52T4r8HCrsIpSgF+kRRCA?=
 =?us-ascii?Q?uDxVxv3o+3BvATd0HXaBxYIPXSwRzkgG4aUOMXiKcBmQv1Rtvk2gq11MCJ5h?=
 =?us-ascii?Q?Z+EIIISSssI8hDitArtSkwf/+czvS0+9aUPyW+64vv0eiAMgqMmmyvcRpLpb?=
 =?us-ascii?Q?eQvgU69FGJ/rAVOnCRSH5eFpvnMfZrn5hdpsN6cK/E8zlvbZ8/ZgwK1AU9yu?=
 =?us-ascii?Q?bCLexGC/ZSHHgNK0wiWtEkCTcwbNBDlB4CxCN/xR5tH3UgJYvGIpWqIRL/iP?=
 =?us-ascii?Q?BD3jCQyQduuv/lXO0HzgaO7j7CGG5gGCF2LrEZZ1xWlr3PxQ1Eufv48NA9cT?=
 =?us-ascii?Q?G+xOKz674xA1Ytdtbhqkt17PlBWo/VEa2pkKW1ru1h/NAq/ALl3hmk3B9GEY?=
 =?us-ascii?Q?fefK5XV3xLQxCPL3FFc/6ju23Fx5ItABXC/ogrMVIsVz2Ry9N0ehBudL6iCT?=
 =?us-ascii?Q?DZ+3I/T5DQfT/YIQglvLrDbOWSOh+fKFXq6R4Xw0OGm43wpUy2W2d1Ly8rkM?=
 =?us-ascii?Q?JOAEPsQdM+gajYMy/9fV+SNJ1yimFiQpvdwdGO48YTtpjg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AUXP273MB0503.AREP273.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DX3P273MB1509
Templafy-EmailSignatureServer-Processed: true
Templafy-EmailSignatureServer-Version: 0.2.4.2957
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	823fbba8-d3e3-4bc1-6c0a-08dcec48b9a8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ER8bGPLvDWlT8FodOx1AsOV1hDIM+V2ZtzID03GwxXmYrcL//ffo6M409TkE?=
 =?us-ascii?Q?tpmWVwl9xOZyJa5jJaMDp3eV9fkEokq5EFbMV+o1bt1rfNQGUWRpZPgeDliV?=
 =?us-ascii?Q?g2tEHx9yYkEEZnVAQyVqcSGO+f/goNmK3J3SEL2WjuNzbEW5j+atNKj1FR8j?=
 =?us-ascii?Q?iMF1XVU1t6Tg+/lhPkhmHx+93zkBrq9V8b6CpMeWz8EIGr5sAYcDKuV48xsU?=
 =?us-ascii?Q?QQZQLdZ8D2l4nrGJ6aqvUkkaWfBFesYq79KnZeX5DWIO5tijtS/TdjakiYdh?=
 =?us-ascii?Q?TUnQnQ6sQ4gb/3hPtrhEfFlTUnL3coMtXkJmNwULCSHTIOAk5dnKzffRb/Jf?=
 =?us-ascii?Q?sFSvLH+6GTGG0t7OCdAmQwvmpvdQ12QwxCCu7O+O7gJh+c/6vgPoAYKLxelQ?=
 =?us-ascii?Q?nbnmI0BKnDzRgsbglp6sbBze82GdCDHscUYRbL1z7Ijnb4HTz/8PQEDMrmp9?=
 =?us-ascii?Q?FXTZbaW6+I5nBBRs3LkXQ9c33E2VQdFvIUuzXPnWCuynUHbZloD2ro5ZjYvN?=
 =?us-ascii?Q?pIFW+7iuLWIc/9ZNQNjRxjJcIbUK97qrSRmSfWNkrp0K24Hr/PlaXRFn3AwB?=
 =?us-ascii?Q?U3H0lTcpAeZ0IzfYOtggOvzbiwrwfcv6eMuT9hOhcYa6RwZBjSVCckBrQPvw?=
 =?us-ascii?Q?0Y1geuJP1Ih+qzGOA3D1Qp5VzTLJAZfKdMFIuHOIPW1KBiPNFFDhL4xF0Lif?=
 =?us-ascii?Q?AgWG4R+QhamIJ3EuttYP9diA14b6Wl5360HoEiZAYC/wJBo+vIsFUGUHrW19?=
 =?us-ascii?Q?mp6M1+ATwOmYU3pKLsReH60f8xoPYOZn/vKii8rq8WWfcVQaFMe4kflcBkCr?=
 =?us-ascii?Q?e5Ske+b55Amo432/LuIsZoFgL3RJ1L108qf84R+TGSdFUz7VZnNoftcMOu4F?=
 =?us-ascii?Q?FV/6Z5nZOmOZH9fhmDNexhc75UfRNd09uBPqK5AV665cEl8am+JoTE0mebJS?=
 =?us-ascii?Q?YWU4p1gqIfFR/2mkEhF2zqLyuyKWLdcwgwB0Tou3mKqGreHjhszT0u/pkIlJ?=
 =?us-ascii?Q?1VzcRhJ/VL4qpqH3ceAwMh4xzyO9VVecco5BQ42z5mV2EgF+baJ33OEZo6i5?=
 =?us-ascii?Q?IYpLVcVEBCdRnkzzLLC7WeyxEtBB25EkxgmYKoYRouQNdOyHLtrHfKGaeD8X?=
 =?us-ascii?Q?9Vqfs9DesJEPLRuqw/2AZv6rpdgiXaRScEcfdclDlpn64Xj2YaRJcpgjUg4i?=
 =?us-ascii?Q?EnJtKARDVCfDUZjCglW5zDx5iQ/KLE5yCnqcKwG2hcpumeE+c83WTZYmJ383?=
 =?us-ascii?Q?wVwCyYGzJPdAQIicmFdxrcSeMKvmwtTS1GyEh+8oZaEmoSOom6WLcjcDyLU6?=
 =?us-ascii?Q?p6WZ8BEMNOvrySvWs6FrIDyVPG9OgjaaYRcO9RyT13fmRnj1sMBN5R1/8RXl?=
 =?us-ascii?Q?azKq3sE=3D?=
X-Forefront-Antispam-Report:
	CIP:20.74.131.131;CTRY:AE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:email-signature-server-deployment-84dc76766b-pdfc8;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: cnsonline.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 12:07:12.4552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d1b3f8-c4d0-4694-4c29-08dcec48bcc5
X-MS-Exchange-CrossTenant-Id: 2bd16c9b-7e21-4274-9c06-7919f7647bbb
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=2bd16c9b-7e21-4274-9c06-7919f7647bbb;Ip=[20.74.131.131];Helo=[email-signature-server-deployment-84dc76766b-pdfc8]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DX5P273MB2185

Hello Git,

Please, consider our bug report. Thank-you




Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.



What did you do before the bug happened? (Steps to reproduce your issue)

We upgraded the operating system from RedHat Enterprise Linux 7 to 9. This =
upgrade pulled the version of Git from 1.8.3.1 to 2.43.5.

What did you expect to happen? (Expected behavior)

We expected to be able to continue using git in our shared repository norma=
lly.

What happened instead? (Actual behavior)

Since the upgrade, any clone attempt ends with

***

c:\tmp\gittest>git clone ssh://10.150.80.53/data/git/cns/repo-parent/repo.g=
it
Cloning into 'repo'...
fatal: detected dubious ownership in repository at '/data/git/cns/repo-pare=
nt/repo.git'
To add an exception for this directory, call:

        git config --global --add safe.directory /data/git/cns/repo-parent/=
repo.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists

***

Every repository we serve is already configured with the shareRepository di=
rective set to true. This used to work fine before the OS upgrade:

[core]
  repositoryformatversion =3D 0
  filemode =3D true
  bare =3D true
  sharedRepository =3D true

Adding the safe.directory setting on a client basis does not make any diffe=
rence, as the problem lies solely on the Git server.

The UNIX modes and ownership use the common setup with setgid (2770 permiss=
ions). Every user belongs to the group and is allowed to read and write wit=
h no exceptions. The effective permissions have been checked locally and vi=
a SSH and they work as expected. The system uses Centrify as the Microsoft =
Active Directory Domain Services client implementation, which was also upgr=
aded alongside the operating system, but given the fact that the effective =
permissions work fine after the OS upgrade we came to the conclusion that, =
apparently, Git might be involved.

What's different between what you expected and what actually happened?

The inability to interact with Git as you can see in the error.

Anything else you want to add:

We think that we might be missing an additional configuration directive as =
required by the Git upgrade, but are unsure about it.

Please enquire for any additional information you might need.

Thank-you very much for your attention.



Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.43.5
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.14.0-427.33.1.el9_4.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Aug 16=
 10:56:24 EDT 2024 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.34
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
