Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6BA13DDAA
	for <git@vger.kernel.org>; Mon,  5 May 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455751; cv=fail; b=uIUdMDhTNO53Vet0ujztUofXWIgRv3G+pecXwNIJ4IyEzwrJsxzOKfnaXXKobGTmTfw1yJ56y/QMP12qLJQhO1K0hyR6/guLJ7bL2tEFbCOm70c3A0t23KZ1mdfFhuYgwAqJZQqrAmyULHuuP3+ZDKY92g5/sBhLBQU5C6HL3ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455751; c=relaxed/simple;
	bh=L8zsSnclFErsE7jRDAE3u9fGpYD8zCdQPM37xDFKQU0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EC4QG3vHlKfp/kCktx18VDMkQeVsj3StsiJWr65FDtYDg2Fd4ircvAZW4N79fkrwbSbfLfav8doCDsQ6W0SYVyUiKDFXAW6Cf2bgdqwfVlvw4s08AUuaqVuU+hqCsZPBhD8qM0Z0prErMjbeU8WDHsLsLo5PfHQH1TSUVHSG6jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com; spf=pass smtp.mailfrom=commvault.com; dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b=WRigDm/n; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commvault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b="WRigDm/n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGLXG+QeAFuqSwagX5Z51WXhla2/Bp6j1cJj3jT0jebzQvmlZXI41TQld0WnpIuvkHK1Dl20UoMtquZvQepBYkvyHd04Mc86oWde0CR6rJEWnuH62QIYh/F5Qv71fqgxPRhsaz3VVRKwL/wJpByTIdcuoWPlmcZ4dy5h2Hn5fmnZxrx2UEbOl7WIIWZ/fSQRN1W/Aq3ZyituhBX1XF5t9+CUJOcUk1yubK2Pnl3t0mITBcSKj1ZyqSMxd8eVfZ/lagMmKNkIaCiHuv6NJV9lvZwsLTScKZo3bxp4/vAFSeI1xhUr4Bh5nhXmomply9oBeGG9wURmtC8AXt03sDw/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8zsSnclFErsE7jRDAE3u9fGpYD8zCdQPM37xDFKQU0=;
 b=to4e3pYbzLLw9wdqUTI/pg0kJpdcMGsXw7kkcNJNhvOK4Mvha3LtMDyEszIbaUNwgOGBBw05rfl+vYCfhDS7Oo7XNY4bcW6fH/Dc3W25OO9wS3yuF7lOqy5Sr5Dub6T3FQZ3W8Ma+CG9jZrLcTgMGmWJr+oypIMp1rblBO96jgQbTCfhkAqOcfzadgCsnKedGCfingo7G+9+xtuVLbFch18UDHx7C6KqYVC3mu5rg6CzS028oiXNji5l1GkLmJ64VBgldUatU7+ELCajoSZvdttcuNXO8xzKKJnZd1O7sjCn6HxXb7w2xc2td6/nGZGB9WDh2EBrgTTZJHgRUlAB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=commvault.com; dmarc=pass action=none
 header.from=commvault.com; dkim=pass header.d=commvault.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=commvault.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8zsSnclFErsE7jRDAE3u9fGpYD8zCdQPM37xDFKQU0=;
 b=WRigDm/neAquvVXgArKp0+4U6dkwYf/IVNfMcNIIcHz5lhsMGu6UyCD4kNDCD+uAgvhnFvO4VxucPnUE3z9jqO/4J3DfRv2HbURwQqjLFIQnkAmQu3upRcWtPsSVBHJs7eitM1diOS3XTI1pbsXukdKl2ZhEKEo8YiiKe1Ybl4M2lgxvMQs+BFcAibU9pGqulACLF3PuYo4AMd/Hb/j18EElx6/rPVU6J8SYb8ZVsRTFlg3xSanruSCvpCmDrz9fDwMXOx95rtLFj2Vaxfhl9oOU4F5ZngG8KH00r7Z/OHGiAi2Yk7PcJQ7H+qNKeI/pjrVh9cAGeu+w2GCbEEolTA==
Received: from PH7PR19MB7025.namprd19.prod.outlook.com (2603:10b6:510:204::19)
 by BY3PR19MB4916.namprd19.prod.outlook.com (2603:10b6:a03:36d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 14:35:44 +0000
Received: from PH7PR19MB7025.namprd19.prod.outlook.com
 ([fe80::c85c:658:ab30:87c]) by PH7PR19MB7025.namprd19.prod.outlook.com
 ([fe80::c85c:658:ab30:87c%3]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:35:43 +0000
From: Akash S <akashs@commvault.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: Adithya Urugudige <aurugudige@commvault.com>, Abhishek Dalmia
	<adalmia@commvault.com>
Subject: Incremental Backup of repositories using Git
Thread-Topic: Incremental Backup of repositories using Git
Thread-Index: Adu9yuZ7Kg9IZ5BOSWCrIQPM1Q8FHg==
Date: Mon, 5 May 2025 14:35:43 +0000
Message-ID:
 <PH7PR19MB70252D42F5D04FFC0331AB63C08E2@PH7PR19MB7025.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=commvault.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR19MB7025:EE_|BY3PR19MB4916:EE_
x-ms-office365-filtering-correlation-id: 35a05f78-0a0b-44f3-2211-08dd8be21e00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WWvOPXMHE0TnziKqA9tmTiCILsaMvqkBYF4n6hr8zU2B0mrPUVilBSRwaixp?=
 =?us-ascii?Q?0nb73jn8xBkS9ZF+oLfJicSaBM2gwJ3s3SuHTDixdd+JxnFrbfYu/jPhyxkN?=
 =?us-ascii?Q?UsBS6BR+715FfG3PmpZrjIPXeTFQ5iECaHpM739/YE1mt9BX1VkO5wTKRk8I?=
 =?us-ascii?Q?s3K3CqGY/wAKZsEF7+pNzMfv7xvT55onEr+xHxQitFZjCKx4+MrrPdx50AZf?=
 =?us-ascii?Q?ToeG+CQq6JD4vYm7EbZBO1nf0daUvsyouXvXo7IEXRfQ31Ql2ihiAWkxC1E2?=
 =?us-ascii?Q?xwOCWhD/T2SE+fOZuwtFiCYJRF4h2neGP76TkZZKSdLQAxKHNKKtjl7b+qlw?=
 =?us-ascii?Q?h+mjZ2AWe9qyFuCf9zRexIa27ZFlZmShqRsvYp6jXgmXsc+QvTJ0Pc65lPWq?=
 =?us-ascii?Q?iGZSovYMyV2ll6pXU2HKCqJWXAvKXyBjw5KDYDbUeeCbtasW/el8JhNgx5yg?=
 =?us-ascii?Q?V60vG/NEoLBtDvE6XMAMKjudKm+xMjDwYZS/6paLuGJua2m/PevxuedbdsHU?=
 =?us-ascii?Q?i34FSQ2D73fTtvyAynzhIIKJS8PdU5JYyOOgjm3IppvD5TzvhMZR7G1H0pXF?=
 =?us-ascii?Q?5DS3UMJ9Is92CuebVtZFfYRM15jrszAotaG6a5tle3IU7Jl//QSGabzuLMiY?=
 =?us-ascii?Q?PCQx3CXfK7ut6j+V8NK5D39XLCU9NKU+VnMIXJ1iNwIdONJidGlSHVUsnrAS?=
 =?us-ascii?Q?kO+sR7azvz7R1xLgIofrk1Lf5E0TdApDaV2L1QQbvqflapuSYnwiHdOAe1/9?=
 =?us-ascii?Q?WdfPEWvGkal3L3mKQtiYU5NSbIUerSE9Sf0lQHbI8kPczElUMOdfyNJYNS+K?=
 =?us-ascii?Q?Qkn0V7fEpqzlOEQCCliD72xWcNoYtQCXii0rzBwpf6bV/IxTPtn5sSJ19mf1?=
 =?us-ascii?Q?yMaBx7vrDA8GIA+SSABYlyEvF6wAxInB0OQ0beBZnvokS1tI6/X1VOpYzXRP?=
 =?us-ascii?Q?M3WmHndI5GqXNAL7zxAud9k6w7ekrntF+WfsHveaqm0mR8Q2x/bE2TigoJh2?=
 =?us-ascii?Q?VyUcvVET+AYz9hIuhLLD5mg8NMWSQSsovRCjiyRf2aW9PB7EecsxS/US676Y?=
 =?us-ascii?Q?oKb4hlIrLm81ClJP30Eqa92zKTUYzEavrVPeS6t6yFBYE22LABFibqfRVJB4?=
 =?us-ascii?Q?BKV8hGOSYrI7Zb/XP4sd30JVxXj3fC/c/UnXeEC/HTbsZ94PBpOsQ1H6Mw1Z?=
 =?us-ascii?Q?XiAsTC2vZ3EOMH4X+V8rWlv6w8Wr/NYSEhGT11nvNyMYO8duGdxdC9PYIezX?=
 =?us-ascii?Q?BEli3JUJ5J2YRH+goqFpUnLuiHb0v6dKd5fJB1NJk+6xZgmJpdqDVW4HjOQs?=
 =?us-ascii?Q?mwBDT9Qz6C6xYAlqWx2I8Cfct15kZ2Qw5WE998f3N2PZnKKPJu9QC/Ygc94/?=
 =?us-ascii?Q?5mDx1fAeNJ98vRoI8/ltlIqOpfY+owjC35/6hw3odGNxehL+Ci3PvizlVvn1?=
 =?us-ascii?Q?In16DYIU/oChoFjA1sX+J/8SJ0cyggmA1wYGkqv7Mr5yh6ixi/LayXLXEbO8?=
 =?us-ascii?Q?hMBPTY1cHxttQ3A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB7025.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r0X7N5og6+y4DjAezUXbM4fNypn2FEqjtkhfCdtrCFat8/zEaiShOFRDYJUy?=
 =?us-ascii?Q?kiPBxhgQVuKYxvy7VJtavcXpudZpeIsH2ddX+OSs6MyRslk2B7P9qN3ONFUI?=
 =?us-ascii?Q?BNA0/KnO3Wch/Rfvr5ASCcS0XhXFSXH+xNT3zts7xszNMK70dbVDX2VWRe5a?=
 =?us-ascii?Q?ULZHCVMiReFxH4XTMFh8M1HoggXs9Q35Qp0y3sbTtZqkvr/c/YOxmy0msY/q?=
 =?us-ascii?Q?iD4zMv2lQ4eyzO5vkeS0lT0Z23dxkwgNuF4RRmlFLLTllxSOoH7LP/hUQxVr?=
 =?us-ascii?Q?p2gTaLtc/gIG8h45fSbIegLJpixpTETiRJiDivA3cn0NxoOLQ8PMI4hsdc8H?=
 =?us-ascii?Q?X0JMLbpAi5SIUhbzKItGCL3FwXLwgxyxaLQMlsfoc9GoBLHOW0T2tD6uiFrv?=
 =?us-ascii?Q?3Qd5ya+3LkB+RubY2verkcZX2mb7uDk3VPlymNOfmVdPoZNfmQAL+pq4aBAy?=
 =?us-ascii?Q?vpIZH4jvlw5SvPU3mGxkRsB2wNH0ADljlYgVFKeImyPkAPOXbRDqV4VJhNI4?=
 =?us-ascii?Q?/WbITG8i/1PE8ATsx+RrCPprRUwkRgODy4Me/IN7FBdJrUM94Xc717XziHjl?=
 =?us-ascii?Q?EhEGk93pcpRjsFFmivO4L3iK4P7QNUbkCGpfZ6bu62ziURh5M9lZItyusE3K?=
 =?us-ascii?Q?rxWS5DRZeQ+p59+8bMCt1G7sKLYjJCsHIiCS9xk+LtkPrjMiMjZ+ZYhfkXY8?=
 =?us-ascii?Q?jVKk6Kb7KLy8Vt8KuJkqMDuTRL4+BRaSeCfPiu+QL4KuikwxeTafZzAO5UDF?=
 =?us-ascii?Q?SeX4SzDBuV34o0KpqFroP7Y5DRSumAxH/XbpiD+FATn5HAYXv13icEsdR6v8?=
 =?us-ascii?Q?MlcGw1FD0YftiF+mn0qfwHX13JJnvFYlmhJNd2hSCzm637WPgybM1vudNCKl?=
 =?us-ascii?Q?cTwJzrN2k9oJFGRq93+e8D5h/eIA6XGPiqkQFEJ7Kk2qLu9h27XZqZslksE3?=
 =?us-ascii?Q?pqTZhn/smQJqWTT7PrVloOX5dY70IW/Ta+jNBIPHvpMIXji1PsLlZBX18PDp?=
 =?us-ascii?Q?2dduC//Ff4tOAQkomox3gO304DT9IvAGglvwqfw/9q8vYmGkZQrPcZAEZRiU?=
 =?us-ascii?Q?qmZR9t4GLw35Ogmg3Ne16U8O7FF0KYq8/6YEyNJR2p2LbkCkzYDy08OvBW4r?=
 =?us-ascii?Q?MprA09byUeQ2lxd0nIrdrv+3oKllRNHBzuFDcbz1tvwlJEaJ7aPb3pD5lVoV?=
 =?us-ascii?Q?bajKeePCGWXJ7QyQjKBhsC10TPDWAq1kkNRZcXbhblTnaWuH25fOsMSfqFT8?=
 =?us-ascii?Q?oXeNmxuV/AD07bGTv1+bXDorRcNGCHMZ+19StNsUIijm9H8tHhDWDOZwZ2gI?=
 =?us-ascii?Q?td41wetXOJjkXNDhVsftwdVtCLrYwEqt+VuHLD6oqXi8jJN5aYJ0tJsuXk39?=
 =?us-ascii?Q?KPkkodooJvLcQnZ77YHtKZ0bgoLa/DuL0znTO+KCaOpn3CgHdk68C8SlqDiy?=
 =?us-ascii?Q?rMbr+6mB4OswQD9CQ6KcqQdl1hztreAbZWH7d9pJL82KT3Zi9ekDRk7N40Xq?=
 =?us-ascii?Q?mpH3xQt1fJKIIPwD9J7PZ81nHMN7//jLCxgefOPLkNprae7KAXoI6mNhYrx+?=
 =?us-ascii?Q?zO8tRkWceSNoidFMx5NLGbAhsuKLt2qMF/KZo501?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: commvault.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB7025.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a05f78-0a0b-44f3-2211-08dd8be21e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 14:35:43.8042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 40ed1e38-a16e-4622-9d7c-45161b6969d5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcMsNk9VSTqRcHjChe8Zj8VZikob2WHMXNItJRp1pzAmnHSt2qs1NcxbSW4gVAacURHUC0HVRCWefLH2TBTOlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB4916

Hi,

Currently we are backing up repositories using the "git clone -bare" comman=
d and save it to disk. If we want to restore, we just run git push -mirror =
from the repo that was saved during the backup.

Currently we are running full backups (run git clone -bare) everyday, which=
 is taking a lot of disk space and time.

Are there any possible ways to backup only the incremental changes of a rep=
ository? And somehow construct the whole repository when we want to do a re=
store from the incremental backups?

Thanks,
Akash
