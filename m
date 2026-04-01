Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023121.outbound.protection.outlook.com [40.107.159.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CA36F439
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040717; cv=fail; b=le0iTSAQ97kfA4mEJDQgJ1BlwnsGZHTevIhy6iN0u7jyb3gmhBPorhFjq6QyIK/8WjN+s6dh5xqG1TaclTWtH+9t0LbZqemd8n9KpRXKwsCMDMmmsIfmZLCmFjJ0E3+nHXDZXNOyQyaYR7aJmlerlYDo3fJI5AWRJB/zUVapmU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040717; c=relaxed/simple;
	bh=9gekH1WUS+Dez3UnjnSr1NqBU7YGqWjqbnl43Zag9QE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vy6Y/MqY+B85lbChrKm7kN4s9Y8FUcFyW0LdZ4Lm+TTIxNN9E26iRhLg8bq3PcDR4iYsCoddFAp23YjlMQ+oByBW4YVLmfFeTlc8MwaVwehyLbJvcRq5o2hldO65T5r15waaVWl3dF39cSaWC+ymQC7WGtNFVS0NuwgR9nh1rEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bentco.biz; spf=pass smtp.mailfrom=bentco.biz; dkim=pass (1024-bit key) header.d=bentco.onmicrosoft.com header.i=@bentco.onmicrosoft.com header.b=kOzTomRf; arc=fail smtp.client-ip=40.107.159.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bentco.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bentco.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bentco.onmicrosoft.com header.i=@bentco.onmicrosoft.com header.b="kOzTomRf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuccyEs2No7huMK9NEkinzWWBG2C8e7E/7prN5o9Yiobz8Snfp8xz/lZf3bdyrGRN83Smx34teyfAqkMJPQ8M06lenmLeRLbK2+4HMdoLQnvEe9FXHINyy7Va12K4Vi+CJL7IR7B7qMCo5q0YefEgUiZ2+w4uCTRpj45h0ZK5cbLI6DvunZHInbi6Bh2JI9C6Y8ePG+teSTzDUP4AHCbKNgiRXXmN+/hlTY09LhJjdG8CbPtRy9ccvF/YSwT/kJgZRSrrHg11yqa+7xBJJyMYoCv9r9WuZ6m+A9ZH18PQ94R+8AOmk6nKjTL4BIoLMIacAh7B+Yfy38bELVniR5smA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gekH1WUS+Dez3UnjnSr1NqBU7YGqWjqbnl43Zag9QE=;
 b=AiOwAnvecBi0zAYqNJCbZ/As+1ykDOvv25sDLF+xddRBFBx1ea3bF1BY7v1Kgjt6cDJnKlv1Xnq1SrcA6tACPOQ+YYc9pGu+bJTjSbmr7f5/pBjMU738kjOqAmFhkWmVidOkkqaVCUwTTMGn6NylICshymn5qhWm5Brfie793Tsu9siXC0Vd/yhXICroT24i7CUuWqq5OCy5qgZ2mqyRpWDHBoPL0O9wb68LKyTYIo4cbEOS4PcQcUBX5bfUK+DMl0LfTTyQMz05R0HogBv5dBt+1lw7FOFyLG/PTSBslmDHY/Z+D2He6Jn+mRbSxSO9FWYS3ms/JQ2UbzbcmV3FDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bentco.biz; dmarc=pass action=none header.from=bentco.biz;
 dkim=pass header.d=bentco.biz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bentco.onmicrosoft.com; s=selector2-bentco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gekH1WUS+Dez3UnjnSr1NqBU7YGqWjqbnl43Zag9QE=;
 b=kOzTomRfRBsQsXw9z5pWr/X18iDI0yEnBanoO8B21DxT3KWnGVXPTz1sEbq8azRO1NwZIDVeDfqzw0hatalfZVvZ3f693CbyfTdhSHzTJ+2ot6u/v5IJUAHwqOM0NU71fRzJhRKJVCnhjOhOD/mK52whiA4bSvS0+MkAaUYz7aM=
Received: from DB4PR03MB10106.eurprd03.prod.outlook.com (2603:10a6:10:3fe::10)
 by AM9PR03MB7836.eurprd03.prod.outlook.com (2603:10a6:20b:41c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 1 Apr
 2026 10:51:50 +0000
Received: from DB4PR03MB10106.eurprd03.prod.outlook.com
 ([fe80::2f17:89b0:cc2a:6c9d]) by DB4PR03MB10106.eurprd03.prod.outlook.com
 ([fe80::2f17:89b0:cc2a:6c9d%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 10:51:49 +0000
From: Miljan Mitrovic <mmitrovic@bentco.biz>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Cloning an empty SHA256 remote creates a local SHA1 repo
Thread-Topic: Cloning an empty SHA256 remote creates a local SHA1 repo
Thread-Index: AdzBxYyt/MZwr5NiRMKl5YunO17DDA==
Date: Wed, 1 Apr 2026 10:51:49 +0000
Message-ID:
 <DB4PR03MB101069CF70418ABE11AAC1CF3C850A@DB4PR03MB10106.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bentco.biz;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB4PR03MB10106:EE_|AM9PR03MB7836:EE_
x-ms-office365-filtering-correlation-id: 09fd65c7-838e-4315-c7b5-08de8fdcad70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|7055299006;
x-microsoft-antispam-message-info:
 JAJYaQHLxzTFUoBROQ3hTteNJDMBdJR22U602xPyC/B/xptxSjn0ccTUEOuBnhdGGFNM9KcPjs8IFY+jrJ3P+NqZ0HAjdko/Uy0I57ezJ1G9lwaMmPw9KTxdvnm2Q5usFLLkrJuKAFwfDS7KSh45JUqS22Jsf5CalW9Sd8eGRqqOVLMGqrYNaGUyFPNnxqQlCqFIPiTc28wxBZZ5M8NJpnHd4ITjWb2tMURTJ/IT/xf3I3ytQmkjx8OW2yEJg11la8af7WMV9NVdksT1P1DB+sA9ohBkkfN4ns/ycIie8B5TDBtlfDcZxf8Hx8o7xfEAf0U4bU7JYLwP/h5LzVIeCclg1ZtcYG8rF80oO9l4Olt/F8Wtj1Bd45NIc0I/78HGVSDkDHqvxDtiuls+oGtYwget+acogS2iaw/CHjUD35Jhfc3O8/sTgukuPLilBU9qz6pAYyOXMlcfoF04VzP9QCkJh6EF1vtf/esjxvlnG9AARd3TlFkb8dCFYz4c9tfFCw0ClT3xoAu14icOT7H/AFX7ZeiXebxUy8QD0Ofw7Ui10gdTNoYgIcsh/wKzxAImD/tEGlRJeDMrdv1hQ2g5lDFcL6p87FCU3yagPHn66pyshG0vDzaOhHIa8RVHuU2jEiLwrcbIqO6LD4VWZlMCcawzh44kncywS6/5eEGq2omTCzj9FDVcn25Y1kZRnGRGieOy1kK4cfwSHItxY9Q5lbBsaxh1Tdf2V3NBDZbbQFXrZMOnpBBXrh/XGERJDNK5+3bdwSMVi5pHYjYXF055/9O8PJcVMmxKuhz03P0dxsoSE+gFxFZLOYKTUJ6+k4Zx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR03MB10106.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(7055299006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ynYufEfrQHCulWbYQNsHKrd8uzGUxURTRf5av3QpynScsW2I5P1Iav5kkebH?=
 =?us-ascii?Q?CPi687euBWl/+8kyz6df/ATksfODjZ6esmI+nttFHHRDt0ewVHxE0CX59BrH?=
 =?us-ascii?Q?bwccbGekg0xvOM+Sp3jz0TNnmU9vEDc4v3NOExGBzYf2p5fwf9xZDhqPKBYr?=
 =?us-ascii?Q?KCn6N3hM6ciq924VO+PQQTXnlVimSMmk+xd4Y1OHts0jFgLH/ZXswrbfO6dl?=
 =?us-ascii?Q?CUZX4yPonNG3HHZIKfR+oawaEjOXtPOhozDExTkXtfWS7ORXtGkc3+DVzb+N?=
 =?us-ascii?Q?w07Aag+cEWM5iFf66ARwr7KtWzusyIpJUBRM4Z6Vga/O5zWlYuvsoGoY1Hn4?=
 =?us-ascii?Q?PyhC+M3Bge2zXFkqz3P/hMmj+JWucPj33o5nUOYJzRnB6IxCl5fJXg26CrGN?=
 =?us-ascii?Q?sW+v+jJ2hPIknzvoopJMwAfre61opnUOfj2o1RGCQHTql+xo6giTU1bc8C07?=
 =?us-ascii?Q?8x2IGvwEPrAyDFNMWC9Utb9Rz6r1vWkjTdUkF3r9qLxbk4+7GRtXRsjCrCyR?=
 =?us-ascii?Q?bFSjuaVxGLAcatOZb2GCwPD9h9oPA74mstvJsft2iMdHaynO9IUs2tB2Cw+w?=
 =?us-ascii?Q?t+cVwoYuoUiK+rVSh2oFjlaUOajt4JCcpFJrhvd1IV4T+e8+zH8/ElF5LdJP?=
 =?us-ascii?Q?mmhBoXVub2iCMddyGHeCtVadCyCQgmAVa9BIH/EbzlXi0Slg/kWzjVZAVFny?=
 =?us-ascii?Q?6lDzVyknKiZlzHKdX5VemINBTAB7JYeGW3Tz//i6fgj2+SX9eryglKaQjO/x?=
 =?us-ascii?Q?domMCXTZ0ZqPHcpMP21AIQgKrC+GukXf5vuYDMMvePRBHIs76AGVBkOj+68c?=
 =?us-ascii?Q?F+p5GDMmP+HMYdb9XBb74DTrU+s2XEsg7LpwPua/tPVjyy6BdVY+rTNg7Wui?=
 =?us-ascii?Q?IK9UaJp05n7xeXgPjluqwcLf09Cw2OQDAjHB1qIvDOhG32Gj8EsD294vvQLP?=
 =?us-ascii?Q?360k8fIBDDFeEs3gFjYbf1GdS67VQkYChNerw53gCFZTso3jX/woSXbWqc3U?=
 =?us-ascii?Q?+6BqJcJ0e9MRccCtDF+HJINmuUucfXCxgDlZ60OSWfzCFs6k1fWYDgOyHu4W?=
 =?us-ascii?Q?he8POqVzXkruZFgL+jOt/F8UhkImnYsl6BDi/T8sPuFtTsi+R280tgscwo0L?=
 =?us-ascii?Q?4iMU8kS5BjN/ln/U5oyusoQhkJszFHgxoc4C6/wIW6K0F4KCdfNhHWX6t2wt?=
 =?us-ascii?Q?T+ZnpM2bkx/LNq7i4P3C87LY+t8+xAaIAqA2nml+PjIqkZ2BXaU/rgznsNDM?=
 =?us-ascii?Q?FVjMFr+hutVmlZkl0I84rphsJAilgDQyYYpYRdqGII6QQyZzkBBwnCPDd+c8?=
 =?us-ascii?Q?I537JSS4ngDR0P63Gclan9QLdEuCX8JtywNVpQjtxdNmyhIF05FsF+tuAemt?=
 =?us-ascii?Q?AGz/nL1Nhg9dRwNJFZS1gnxQp5rpS1/edtbqDs4uhxbGoba/iToz2lldRqHi?=
 =?us-ascii?Q?RDTSEKwRlqMloIteXPen3jGQn3nN0qYrZ2OCzBBTtpo40Rs2IhCqzXq9QpXZ?=
 =?us-ascii?Q?OWa6mRt+ov2ATzaM9Dlyy5B83E+FnqDUmR8ZktFUnBYMrOp++gOllbvamIJg?=
 =?us-ascii?Q?5kQN6TZ4Mka1sCYyNCiftcl5r1p0OKqzV1j/o23AZes5GypJtX65Tbo55u9y?=
 =?us-ascii?Q?PXk33WIVyBCL5Q5MmLSBPCDt6Po1/kYpoQ6RrmKa72ce4wg18iTa0pPKw6Cc?=
 =?us-ascii?Q?6Cr9nGTs67seXoEutwekgLR6OswEFiLt5WDYIkzbVvzVD2zx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bentco.biz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB4PR03MB10106.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fd65c7-838e-4315-c7b5-08de8fdcad70
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 10:51:49.8139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 74d7b2bd-6b03-42f3-b139-4dfb5adfdbd8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgq5KVQnHB+hHAtnzEqZBqZYk36/o4J9poLtAu9XOTtdHG2Gjiwb+b64Ucdjh+M7qFBhJqTIt2YLvFeA7+qz8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7836

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Created a blank remote SHA256 git repository, cloned that repository locall=
y using git clone

What did you expect to happen? (Expected behavior)
I expected a warning I am cloning an empty repo but get a blank local SHA25=
6 repository with remote set up.

What happened instead? (Actual behavior)
Warning was there but the created local repo is SHA1. Commits then made to =
it are rejected by remote. And there is no method to convert a repo from SH=
A1 to SHA256, even when its blank.

What's different between what you expected and what actually happened?
I expected git clone to create the repo using the same hashing algorithm

Anything else you want to add: I know this is a fringe scenario, but it sho=
uld work as expected. Now that repo's have roadblocking init settings, the =
important ones should be passed on to clone.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.1.windows.1
cpu: x86_64
built from commit: b03dafd9c26b06c92d509a07ab01b01e6d0d85ee
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 26200
compiler info: gnuc: 12.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>
