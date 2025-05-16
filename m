Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08492550BB
	for <git@vger.kernel.org>; Fri, 16 May 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432162; cv=fail; b=iHhh4UOz2tD2TQCiT0mgPlYtChDOhsLR7GaJKD4VSKPe7m2TcSqprmXP/JKaWVeXa7bco+Z7EriZl2ZEiAh/QvVyVJ8OTd+O5UHnT3kay5rrNvdhC2gyDTw/evi2c/tYBnalI4eFE//8kCkym+nfx3UdhyBraVrXeN7yMqkJ5ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432162; c=relaxed/simple;
	bh=NWmTuNaRzgI8OJMiIeSshAAT4aRxufKZ+oockkj8JPk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QHiQtDnctZ9haPFSQLaHMKPBFsXfY6qC2Rp3EBmLG8TLeQpyGoQJaPiYSYc0HXmdK06bPOUYEiX6pNLlMsR7M5thNy+JQsamHF4TkHczUB7Phrf8jsm8G5vNsOhKvMAufTgt2JFCiaEgDI0CjoFi9z8DI9FlNhdbkqCVEZQK3FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pega.com; spf=fail smtp.mailfrom=pega.com; dkim=pass (2048-bit key) header.d=pega.com header.i=@pega.com header.b=DlyeOGrG; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pega.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=pega.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pega.com header.i=@pega.com header.b="DlyeOGrG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEDCsgNSfr3bpKB18ZtwiomHs/oTDUtw6IT6zVaBAOs7U+Iywyn7iku1WYW9OPhU3kfK8JDI4/lcOyedZf5KdgSZWlBF1lO9Gru71klkggLk+EsdnL8r0m4hEYABFl8dpSTKz08q0aJvcRj3c5MFRdyBX9isEZtGEHBrVZebvnG58eWMyLjQeh7I5OjeqYwWF19f54gwgg8vWCNfzAm6AuDMcYjIEC98XIwSFRqsuSa9k3N9fd7PHCgIYThDIhrioLWsfY82J7j05DLHOSa05hawdjI/O64ECLHwctpG9+acpeuG/ev25bD6i9bfy6f1WEO4a9R2+6T3P0qPhn/dEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWmTuNaRzgI8OJMiIeSshAAT4aRxufKZ+oockkj8JPk=;
 b=MdR/0gE7TmEtZ97hPc8oDbMfQRDXiFSPgrMoc0a0+YBWk4HdVeVbjaxIzWJqa4CfQg4fDqHGyLjQI1eNIP/NnuL1g4D31jLxVXc+s8PI/UZfW1H/TfeOY4aB33j8jVtbxrjd7/L4kRuNx0Rh6tZlvsvnlfMHPujwQnkdaNxE8zKiJC/FYevBIj6/bEC90eRljcK3tfKny94tpQByqBkT5orAiSjzj7bqZvsqvKAWWGTIg2RQA9VEWkhiz98DYaybOX7qH4KeZIuJfYi4fbo8AP1CDU8TkAztqtSsvq4aVZfTuykODegkGAA0rfCkZ/wnjjbPo52nttPvVxLKcU+bNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pega.com; dmarc=pass action=none header.from=pega.com;
 dkim=pass header.d=pega.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pega.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWmTuNaRzgI8OJMiIeSshAAT4aRxufKZ+oockkj8JPk=;
 b=DlyeOGrGVp67J3+dPRtpGjQKwVu8Q+0sgP+bKTVbjeEi4oBIDLQJ5sPyN/NIe31oz5yzIf1uqv0/RrNwRHFpRNGl4YCtlPWtZqDhWm675Rzlxg/xh5ls8VeNL7ppH4F28WreJNX8sM+PugbZLPi8wTyIxJJH6ocTi7JLsFcxpF31uWv4fTnTab4VB6Wftlb5PILEcAt8pyB8TdufFQgwwLvHTqzOQDRhXDLIcGPzzfK455JnW3aBJf1YWh+OayKhe4GLJQhdJzRuVOnSk7mVisMFtk+bwSTnXFW4mdhKYNmpUMwKNcdMWVWMDX/NEI1xweH+ZtUmQEBRiwScA6in4g==
Received: from BN6PR13MB3091.namprd13.prod.outlook.com (2603:10b6:405:80::13)
 by DM6PR13MB3867.namprd13.prod.outlook.com (2603:10b6:5:245::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 21:49:16 +0000
Received: from BN6PR13MB3091.namprd13.prod.outlook.com
 ([fe80::99e8:a66e:becb:93b8]) by BN6PR13MB3091.namprd13.prod.outlook.com
 ([fe80::99e8:a66e:becb:93b8%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 21:49:16 +0000
From: "Conti, Chris" <Chris.Conti@pega.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: symlink issue in 2.49.0.windows.1
Thread-Topic: symlink issue in 2.49.0.windows.1
Thread-Index: AdvGrDfenJPdILcATyOrfsd0ciuKTg==
Date: Fri, 16 May 2025 21:49:15 +0000
Message-ID:
 <BN6PR13MB3091D0E52DBC0D6F60B6C95E9493A@BN6PR13MB3091.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pega.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR13MB3091:EE_|DM6PR13MB3867:EE_
x-ms-office365-filtering-correlation-id: 135e6f2b-3647-4dac-1b34-08dd94c38105
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cGQH8446AxrYkiM11X8dbInR8yWQEc3Ullv+uicDiPUUiPj2NhITyw5vksrg?=
 =?us-ascii?Q?VLztNFFBfmc7xv8FrRSm5rl4XHQ1sn784Hce/65m0lqNHwpehg9UZVn6F4Tz?=
 =?us-ascii?Q?vcb2PdEeq2gbWbtSUbsPpihyVlbb+Hp5lIIThQ2v6YN9/QPAfSmiyvUMBc8E?=
 =?us-ascii?Q?mEmdG1ahUCY6eJA2N0cz79eYja77b4A1UudO53iwEfJlE/F0iO3YTHFQ1DrK?=
 =?us-ascii?Q?frosArkwmrpZlguxPAt4AP0l3BAuKPrCPTSLoKvC9VPnRbTnoLXpteECJVyn?=
 =?us-ascii?Q?VbNZTIWqMSMClFs8+VuuCE6VNkDbl5UccGFN0CaVZtY3bKIl9mfgQUpMl9AP?=
 =?us-ascii?Q?wHkMFSPqHaazH3ucZIEmPg5IpBgORFLLE8FCc0liwKga5J8ixif5pxFSLFz6?=
 =?us-ascii?Q?jLoqLo7bFA1uNoL8w8zk4+6ajcQe+uXUF5jUytkIxt6JwL/WddEBxaL+aYLX?=
 =?us-ascii?Q?y7XNWXmOzTc/X/cBEN/E7c3Moc1ZUBJb+87ILT83wtIQo6gwezwgMuvKub8H?=
 =?us-ascii?Q?vo1ZXzAUsf1Ju9UCqmzc4k+pFkGC/Z10+nStNZyiEjZujH6tYl+CrkMd2TWg?=
 =?us-ascii?Q?1z0Td+7MHIcRx4A1ax6aobKCKZn5d3uydyZ7gC+qR/ZW79HWL3Zrq/KgOz9u?=
 =?us-ascii?Q?d5kkcoNBQOjsee2MYyAsvQKz4Y0t/I2GmvKhAokxuyPimqOaGvNi7zvq+Quv?=
 =?us-ascii?Q?bw64q0JPOQrsIViAolaAy+DsrieOLDyzg3FDuVpsAyoYyDRjncT48zdzMGdH?=
 =?us-ascii?Q?4A/KL5ZuO+kOSPfjoXJbgJI/gTSQAGfMizdJ0Gb7IVTSEIUHAuG261Ftv4pG?=
 =?us-ascii?Q?aj0a84jF9/wlodLJ/+t2ehCzdQqrqECwXoqyEOYqsdGv6Z0hSelcGmQGYEYm?=
 =?us-ascii?Q?f7TMA0xFIXnkFQ8pc4welUxj9GLXgyXu0/CymbaaoGDGw0f9ghKrUAn+1mPP?=
 =?us-ascii?Q?Bn8md/MFPV4En16QSh+R1hXzs7tb0ByqGvQA032yEc7yJmxPsRzB04rm7m+B?=
 =?us-ascii?Q?43sikOlRbptp6ZA3Eh6B0HjLu0T5b3w3LSlCOyL8JgVC0TJwzrLsMDxZVkEr?=
 =?us-ascii?Q?fy8KXU38yIb/NtkhJm9mlGEdK30tRm0So8UB4dkhMFor/8vUZ9B4zlcCKg+x?=
 =?us-ascii?Q?76RQ7pQXgpbbyVCt7IAaKDA/4fVysO91q5WcFEodoA+0LMdCx4dguq8O/hPk?=
 =?us-ascii?Q?0zTTNOhAwzBkL2hv99phljYwQ/32hI5gtQqNpv2zBeE0X0i5Vqu/3RTcvxh2?=
 =?us-ascii?Q?hGCGB429CdtWtfZrb8CXAG10Nzd/ili/4Lk04w3ZPmyG7VO8oMl/8F1nv0aW?=
 =?us-ascii?Q?Bdobzm1ggT9//svGWHsmypZtbSMY84mYTBoZmwPKxGmVachWpXu9RvSQjsW8?=
 =?us-ascii?Q?5pr7tAiwD888xbYoQb2/h4+TOJruZqsXMvwJeg9wzn6yUzcnzs+FyDewDZiG?=
 =?us-ascii?Q?QTFts5d53pOoULRE9oow5qq98l0Miv5HyA1W8FTPARq1PYPSSdbcOA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR13MB3091.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?glEholInRprTqhTBJPyxO1w7aiyxR+82ynfeuFCFCTCOBDIlDIs1HmIuxDEd?=
 =?us-ascii?Q?asKc7seZ0nXKd7pONPh5aH6JVIG64gkZuWJkMttyHHfNh5VLjiLLN4L4WrcH?=
 =?us-ascii?Q?i2tEkcAuwc8No5yhZokaqqxwCWXoZ/j7qmtnENuaTYhbMcoy6WjWMS+JHarq?=
 =?us-ascii?Q?gYs9LN9nMU2NiBhfie7yasbUVTvGePBQnPmEqGcGncDDd4EqHcJeBhl15tvp?=
 =?us-ascii?Q?AuYtOk+PhoVMV0xDt1W03nMoHobBAu8p9Fp3P//pYebGghIGXramLbBxOItK?=
 =?us-ascii?Q?fGZ0D4JFfyxejcjjJaY/aJ/Fl5StFthTyjLPKHd1/UtataoHaKkueboExyU5?=
 =?us-ascii?Q?91m+ip8QKZAiZiFVYa4HfjieGgtA/mfgmPEdL6tmGd1Or+NwMCMZaSePqSk9?=
 =?us-ascii?Q?4aUCi3hNXwfuwmIdezqu7nIFM6jVJMMXNXLwlZOFnX2va+ZwH/cCX55yXUF+?=
 =?us-ascii?Q?3qRP6mRSt6bqlH9egyB07aLEuRFz70MDkfxOvSrabqoGaT2irEe65qFcbmpA?=
 =?us-ascii?Q?0fKUJZSisLSVahK/LcHAAyvlgOz2Q3sLN03QGktgWkSJFJ8j+xjRW9DOcFZP?=
 =?us-ascii?Q?BdWNYXuiS5Jxnw1ARslpZF366lfsq96gczqiuB7sOv7Y5AKfmVKsPLA8C9mr?=
 =?us-ascii?Q?exVTQ7xgNQxyqayoviu/jPhR4yOwYDYWhy4rZYsTZ6qp7TXJIgNkyd424qvI?=
 =?us-ascii?Q?5+Zx7lH8QXLQi6dirI6RRBoBYvT6lrW6xU4grNQi+zLBKO6yANFIb8plpGsP?=
 =?us-ascii?Q?F9tJgDGqdaj21XYOMu+gHjMioQolAR1pi7I5g3SIiuF4zBf9f9j79vcSxDSw?=
 =?us-ascii?Q?4Vm3tUUW5YMbS0+OBFzv3n/4MAjkpIPk8ZNNHcAbL2/VTz8qbu0Zmbws3pox?=
 =?us-ascii?Q?NG5QInOwQ1Y2mGGjAT5/IGQiwSqKYdeZ82Nd7Yo1VlY/xed8jkn2cOgAG2Vi?=
 =?us-ascii?Q?rAXvD+gJel8TSQG2p66JiUeWV89A/GMndEYJUG4rs/V6i9Fy03A2AgIX4oLM?=
 =?us-ascii?Q?OEJsiJecP3YnjXGFiE70z5R1r/EbGOpHdFYa+A7oz3hIf7X3G+YKkglOicjZ?=
 =?us-ascii?Q?KrNli/Ic3Xh2rronEA2m/7WbGRanOwIbKM/twYRtLFxjE36jxjRhQpEhg9pp?=
 =?us-ascii?Q?xXJxzlsGux7ZuDqnuFoX6vFSD8s0DdGyd8zRlzyMM4fbr3u7sC30y/gf/Dhm?=
 =?us-ascii?Q?ylD7iRi1YuvER33IxRnxnsD7UpUdOmkFGUDi4naeGx31AHQYLjGDGNJeptIP?=
 =?us-ascii?Q?uQWRkp6T6RLAHvZDrhT9H1zq855A1oSd9O5mB8UGhrWR5/eYIigGjwpt3Gen?=
 =?us-ascii?Q?qRbSzBQvLMsn4pUAtQk5WUT8MDIyhmUy4YZgU/Txhova3eOcG6eJ8ilZLWv5?=
 =?us-ascii?Q?QiTDyzI+ygwbN4BIXe3WBRbbN+QYhTLtQki71mAzg34wsdujsFPfYkur3YGb?=
 =?us-ascii?Q?ZfG19KxtHZhdYlFkemGYg971VOJ0Gg/3mvTWy7IdIbCAsYwG0SUyEWiNt4rf?=
 =?us-ascii?Q?Pac2RsgpDXHsFbqF417yd5N4ihfyCO4ZWsxzJ3hOg/KKD3Hdp2lfdTACvpXQ?=
 =?us-ascii?Q?AbUSjoEH4ZmMVh1idtIhgsOqxzQQuNce38quvUVx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: pega.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR13MB3091.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135e6f2b-3647-4dac-1b34-08dd94c38105
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 21:49:16.0021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 45d30f04-98fd-4d38-bdc0-9d81422180f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdQ6o88fai4kzZMEkQVoeKm2r4/XcI4L0palZgEqPSD4X+5RYGf4XK077v61xq6Kg5dw8KDZsdmkKlcMELAplQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3867

What did you do before the bug happened? (Steps to reproduce your issue)
I have an alias that enables core.symlinks from the command line:

relevant lines from my system gitconfig:
core.symlinks=3Dfalse

relevant lines from my user .gitconfig:
difftool.bc4diredit.cmd=3D"c:/Program Files/Beyond Compare 4/BCompare.exe" =
-lro -expandall -solo "$LOCAL" "$REMOTE"
alias.diffdirsym=3D-c core.symlinks=3Dtrue difftool --dir-diff --tool=3Dbc4=
diredit --no-prompt

execution (in a repo with a changed file)
git diffdirsym

execution environment
elevated powershell 5.1 shell

What did you expect to happen? (Expected behavior)

for the command to work

What happened instead? (Actual behavior)

received a "Function not implemented" error:
error: could not symlink '<redacted physical path to changed file>' to 'C:\=
Users\contc\AppData\Local\Temp/git-difftool.a49272/right/<redacted relative=
 path to copy of changed file>': Function not implemented

What's different between what you expected and what actually happened?

Anything else you want to add:

verified the alias works in 2.48.1.windows.1

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.49.0.windows.1
cpu: x86_64
built from commit: cca1f38702730b35f52c29efd62864b85e85ddcc
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.12.1
OpenSSL: OpenSSL 3.2.4 11 Feb 2025
zlib: 1.3.1
uname: Windows 10.0 19045
compiler info: gnuc: 14.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]

Chris Conti
Email: chris.conti@pega.com | pega.com

