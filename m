Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427A12DD80
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543398; cv=fail; b=sKi6IAJ1kytrYoabukoYWNYkG2+U6n6O9PJsPvyEbu06z2bBjUQ15fyM4whn6SWQYNhQB6HCCpAZ5DBl8+1x9B6uzTB/LCXMpOnX6LOrxmpRhRz+OtJiCHgYEn/NFfoueGk8xFg8QndmZATeAKuRWQIdQPLj5rkA8K+O+ZgL68U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543398; c=relaxed/simple;
	bh=FsSjxKJRjii3U3vJHYrgFY0GLdIV5FiCA8g14tFAI3Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bHSq4ntxo6+8wQYLhDMHNvsyLYnwMUn+cg3I2t+qL3sIjsu9ViDzCD+whSTIzULW5zoKcA5E4nAu7D604WWIjvRJvFMciEZV+eKlt5kn5UgUKRlrzUSwlUlRrykgz0nmEHCGPDt4snf841YCK7freyeDtmzKiNvaDOlEyC1XBkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FFtpRA2d; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FFtpRA2d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVut4q/QUs7ASTaYfvgz/byXz7Aok25KKBymGSwgKL2RcDiMG/5655o9k7wBHUjAeMGZFmLubhZH1M137ezSe1pNodRzvt/t8xwXbr+VOgZQqxtJ7ipuPhONnxcudbgx7vMurrQDVyX09x+wqQzR6UL/bnE55csriqq+8q0YfPO0ZRkK/AisMrM7ZMMFHVeethaTAXq1+GUZBiFmyfnrZPIw+RBN5imy1J3buPJo2yaOrh3E+70zQFnaFIUH/Ar7uuroMXXuOIHwmz0k5wY0NPzVKaqn1ZoQ2SFAxOk9TapG/kF5pTO3bPz5Gx0JKRoUXOBMafB7yfJrJqBHNRDURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsSjxKJRjii3U3vJHYrgFY0GLdIV5FiCA8g14tFAI3Q=;
 b=ci3/4sc7dr5YJrCsIbsAsEy27eS9BECKWeKB9XCP4X8vqm5ZuiU208G5Qm59lm4AuxSM+RKu/NuQ4s/e0qdkzfQJO9YtJwFC1oj3LQbeM6r5aG8+lhIpS3l/qyNwizGOlm0p86ZeM8eVp7GBRdMqjY4yxxscTDtrHed4ppJRdVzDZkLDdYYcqmDOU5x7KZFjupgMDhYEWuWyKbp00ha40tncCOybM9daIIpnZFfA88Dn8SiCSJ3lkaI+7zxs0qEL9dV0+PyrmpBZEEQqYNi+4ozcAAZmc7rNJ7QEx7q1f611mwpm1IjquJ3LKpQU29MoZBmsgqqcJ8AZCXC0iTaQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsSjxKJRjii3U3vJHYrgFY0GLdIV5FiCA8g14tFAI3Q=;
 b=FFtpRA2d5BTBClxj7kzLIJGElrjUhRBTBBOQc3zknRx/MsqKBtRUp2eEsN7KCdpmsuvf6Voulk2PoQn3Y2PAEetfNab12CD18FBjwUYsl2dcnz4ThiHg/zXsRwbgHY7E8ds4NxgvQLDpyplmeVs9eQj7kbALK7LJRwmesNN/EZg=
Received: from AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9)
 by AM0PR04MB6883.eurprd04.prod.outlook.com (2603:10a6:208:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 12:43:14 +0000
Received: from AS4PR04MB9362.eurprd04.prod.outlook.com
 ([fe80::e370:be4c:8cb8:80a5]) by AS4PR04MB9362.eurprd04.prod.outlook.com
 ([fe80::e370:be4c:8cb8:80a5%2]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 12:43:13 +0000
From: Declan Snyder <declan.snyder@nxp.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Disabling sparse checkout cone config not appearing to have effect on
 git 2.43
Thread-Topic: Disabling sparse checkout cone config not appearing to have
 effect on git 2.43
Thread-Index: AdqARFRYDREzcBBUQt67AjNRaTXkIw==
Date: Wed, 27 Mar 2024 12:43:13 +0000
Message-ID:
 <AS4PR04MB93620325B032131979790EEEEB342@AS4PR04MB9362.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9362:EE_|AM0PR04MB6883:EE_
x-ms-office365-filtering-correlation-id: 90924cfb-be7a-42d5-8380-08dc4e5b77ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OV5JImDytI+Z83mzVSYdQ5qsfVq5W5W4XcWcWRkn4x4v1eFxHc52VR7lr4YfrjQ8pvqJggHh4zrGVuMd8JBQdNj4DeUceCsrn/6dvXN2Kss/7DvF2XD/0LbZojc9Dgk6jHFGQvL0i6ZQ5tzGGrkLAEmRRJHt/SBghbDfu8DBkdJcPXCUYjFAA23vfjzdsjgwjORPKVbMEwW3l+Q48xUnF7WLPqotVDZ0EPqkyFzwafw9sGUOnt1CR+WZ36fU/NtFesNOlxTr1if/UByAUWCPWRYU2RSgIpIu/5eEn3QzjZy2vX8C/M5FyRi8oD4X4kC5jFOlqM/BFm4xHg0YWBe5D1RfpCuX+GPqz2+Y9ckPHpcoTnBSZ0yA5jgJTL4d+VjWk46w+S+ly9bZyW/mCPPt0vMsactUwkiNrlE6kb/SWsfFd0OgJR+IfTciwMNuvqhEs/WTyU8pdrhjV3QD579h7aUB7JetylHp9kMWazbl7YumF1+GRluvEvhqIAcs3KQFScwVyy5qdnXa6QH65STk4m++lxN1sRMEpDDTvrO/sBsywvf1PGCPwqPrhFmF9alSNGczKUGWYtQAVJoYjWRgOew9br2txoR9jLeeGq2F098vLjD+Na1A4eBX+kFLArZ07CTPrD5eC17MbKG9bXxPaUf7lGtyxfrKb3lTaU+TIFAUQvJ1Ka1PObmO2Ww5G+A2sSFc+lBCA6mcvuTk8hNlOa5yDn4dieaLorJArlfqVnc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9362.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gtJA23iGzE6Qr3d528k2SdsIpR/uJkCooZmKJ9rC6lO/1A3oqS69afwAc5qI?=
 =?us-ascii?Q?4aWVN9FnhOKcG7F+9DzCq4VJdhJExyFmv5NW+SLYEnbBU4KWkctph89BW+2c?=
 =?us-ascii?Q?Q2VGbVgK7zBfGidyzMLMTRU5QRsGPNyokNcNKg5bgHyd9MPmQVSYhiV8/FXj?=
 =?us-ascii?Q?Yy+0E35qyD7FEX3sDMJUxNovM7n2cInjOVXN+atAbjsyaAN1lwdNjneLyqUm?=
 =?us-ascii?Q?vp3aIbpLAOuwFGkbdVd6ou0ENDuu1Vg6FmjDyGGaSmJMy6ses8n5tTdguWYi?=
 =?us-ascii?Q?pVuzOMQ2gSprVk4h5K35c+nc/yOyYYXb2Nm6DznZzc3w2j+HOsFk2iKjc7Rn?=
 =?us-ascii?Q?co6uKC5LrJNR0hnu0ehVcTibBi6PN26+c0jtNqQwQoFePgMFmzh7iicwfyA4?=
 =?us-ascii?Q?lIlCekeXttipbPYuh5txaslFAXfs3VwTzNkDekBmdMFCuPfl7BeB2N4OFSW8?=
 =?us-ascii?Q?iJ3DRJJqcTjDDIiV4hx9wa6Lb2ZqUp0aIEpkeVMfeyworF367eziH1WOWV8t?=
 =?us-ascii?Q?rpvLsJFS8XtruFwH6PPyf9FxM0eIT2Fw/CX+xAA9sKWxTv0HrheobEC183Pc?=
 =?us-ascii?Q?mCtKKqLwzpaVgc/dLhf9oPK7CfJmviluJnmW9RVCx0cdYctQuJywkHLiOomQ?=
 =?us-ascii?Q?Dx3aRWfZES6deKZPQ3hPxflmCUL8VGBfrMt2KykakJgw0Il5ZQYAnql/0riK?=
 =?us-ascii?Q?N3v8f9E7jT8n8iTZi1uGPx+FmnXyR1UznK/0JJ+5sP3QyBIsHE9lZ0OmoZs+?=
 =?us-ascii?Q?NRPuB9vUd+x+abI1EftW8FNx0nwP8D6CoT79vhm9bGm4NmgylP7a+LbTVSJB?=
 =?us-ascii?Q?SdBQ3BsFAotRL1stQvXMrHIBA0K7Zg0cHHhdf3MbCKt70WXUOTdd5S/z/Hv/?=
 =?us-ascii?Q?wFzDTZv9OqT2+omC3pZMmbNvZKOLP46k9CmZDbqKapBSQLfkqlDY0ddpt/jy?=
 =?us-ascii?Q?AKOqVpv5Oy+aBAkDNTTSxbSFAYTA5QqHnxkEgeHRgExQ7qP9hpW2Gc6EZzWM?=
 =?us-ascii?Q?DmaAHGwGcYFG/TZN0x99YuQKZNRlWf7xvaIFZ5WZDw04mmODrHTgWGk7ihxL?=
 =?us-ascii?Q?RKhu6S+p1+x3U/+EDomf5d+/oVKiipKoQhvrEklrSukXrlgKlnR9EBFbYHZU?=
 =?us-ascii?Q?uyiRynDpOr671zKpDz027x0CdDBySu7jj7ZHEfmE8FYpheGspQzDGi9klwvE?=
 =?us-ascii?Q?AaZ+K/sq6RLh03ecQhuq1slyclB2CI1dO+lKroMFhPzuD+e2olEFmN2qgtnm?=
 =?us-ascii?Q?4ae6l+psoPuVLM6DWMDqJhoU4/CVpOqZmUJAfD6mqz428oBcv7ozx53OJKsP?=
 =?us-ascii?Q?ygdWYH7SDtKI2zKKdYU8wY5+Iv7kkq7TogiW6hKccmAPVBb3t+J9KaV93AWG?=
 =?us-ascii?Q?AKXTlTFpZsLY8kS6fe4IF24v27Na0ZhIiuw9ybprqBaM8ejHfp2CEvpLtFeM?=
 =?us-ascii?Q?tjy8C0H6fEYJKCIO+kgtQ9fmtXwnUFWGXldfGnZCGdBq9V3zI+VyHBm+V4x4?=
 =?us-ascii?Q?cLZMUAUw1gVHgiyWhdrwdPhXwrl/6F+ZZ2Png6HwZFopkvCT3CnuppQywUhq?=
 =?us-ascii?Q?cLSR9pke/jld53ZzBFcwlOAob3EWyVwh8YE3caMR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9362.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90924cfb-be7a-42d5-8380-08dc4e5b77ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 12:43:13.8737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FW0WMH95iCIQ6sDiJ3yoRlw8MI0jVdfgiau1ydfDnR4v46KHC3bqidJDoUQqkNyAJAdvOnKeS49J+xs8GwsqXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6883

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I did "git config core.sparseCheckoutCone false" to disable the cone patter=
n matching of sparse checkout.
Then I did git sparse-checkout init with the sparse-checkout file in .git/i=
nfo looking essentially like this:

/*
!A

where A is a file in the top level of the repo. Clearly, this is not a vali=
d cone pattern. Which is why I set it to false.

What did you expect to happen? (Expected behavior)

I expected the sparse checkout will happen and the file "A" will not be in =
the working index.

What happened instead? (Actual behavior)

The command output warnings indicating that A is not a known pattern and th=
at it was disabling cone pattern matching.

What's different between what you expected and what actually happened?

The core.sparseCheckoutCone being set to false does not seem to have an eff=
ect.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.0-26-generic #26~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Ma=
r 12 10:22:43 UTC 2 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
post-checkout
