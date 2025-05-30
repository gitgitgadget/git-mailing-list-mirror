Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388E235054
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620214; cv=fail; b=KlWbe7rw/kwjCiSuyFB2lcXWd6f60fFJqIMogs/zUV8WoL5fPkanrDVhgpVjpXfxDj1pUIV9hLTIXgfn6F27EBfqORsjtB2SiJyCpb7t6AbyxUzSim2o9hmV3258f3fR9cK3BThKmaLl8v3WoQKudKHaIBDRyjzsE3UZUBKoBSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620214; c=relaxed/simple;
	bh=6Z7RFlUXf6BgBxPOCGGC80hfVqlbeY5odJmG59rRO20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uST1W59LBe7ukjGJv7G1TAxTArJA34BQgjbkthGiRlvXGwL8xqsBj20YJ99okW7EA2SLXCfSpJxKi64FvDGlW7VJWEV9vQ4KC4mCPhEN1uX81ESVamfff6kZNORLm/KYxr0/iogQYPeff8+EINNGUhfhsKGOw66Zv3BphcWvRzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=u4KUAunF; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="u4KUAunF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7wGsfEJIvq2eH1sAp7oIlkSkea3LUqg4zffU4I7utSEWPMs1VNIM9JiBqfr03PWVbylEJ7Kky0vhHdydHlOZtF2pqZ9yYoZysaVRqk5149PO8TEn2rceRo8A4SoXXPka9pdNPtfplMb5/484VpwR5m4LCwqYCCXh0G8bOOwaUtCBDOASW1SO36M2nLFsHCl2dm6s2XwfviHRpe+tkd7AXUHCNxgmPbZEQ5aNUjla7hjCuALzXoe6WV3WAJ3xiG/AZaaVya5yzrD6s079DGIq8uUdvYMZX3ap4W2sQQ0T52yAeY0d0aLAn5JBPQ1mDcxjs1Y8ikMHkyQUSfkjvgZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyAaz7hdXMh3hvrM09mE+agl7Wwl6E59l+ecZ3QeHw4=;
 b=sUqUx28Cffu2BgeTHQCc7o2Rn72VyUKzAvJmz84Hqdvns0mWjz2XGeNuJF5En6eSJwIoiT/uUo3rvy6OkTA9DD7ATjZ5RTv7fQXnrliHDvYtT6RCELxwvSt5ZX6yyYUqXH07DSBlFsxc9v+v6Gjm15GFw6PTBrz+LMpC8oemyO3SaDjVQaZ8aLYnswFzMQLC/GIAIwkCNZJ/FpnFL9+nNRb0L7T7fZQvBormhohVgn60ntM+/7dFrPyz41jBfB0NuhacNE1zh/FEAwyrkOpFBYMmm3UQNt0ldlSpliO3KNiVxF3OSH2vnqaYTypAvPX0Fh/5X0Y5QLFHRAMlQD0OnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyAaz7hdXMh3hvrM09mE+agl7Wwl6E59l+ecZ3QeHw4=;
 b=u4KUAunFQXaJQyxZ/rzQbQpg4qwxr2aXlVSjtOvXgTJ+GDFTEFNEv2PgjBcGgoiFYGqx6fkzQei4AXejHjQvfqx2gO9DSlFeS7ABEgUF9Cb2Hmn43UjBiZ9Q5Iy3CRpM89uc8BO9oNV5BrKhfky9bFF/sLqWsCpWm/69EsbGgFO3XiX6hca8niqftb0UMy+xPBfKHbi2MJfJRYWo/nn7Mc6V9YAqiUvsWM1sdVm/tUcGQTnIyoaDre/jeXQlhw2rUQTbSZL+nrQLXwxsQjpoaEE+TNwuwhspESJNFhLBvMSAA26NoRsqvWlHPxzVJWbajARyzfuhxOYkBmMnre7xeA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 15:50:04 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 15:50:04 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>, Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 2/4] docs: improve formatting in git-send-email
 documentation
Thread-Topic: [PATCH v7 2/4] docs: improve formatting in git-send-email
 documentation
Thread-Index: AQHb0XqC+PW2opf79U6ivTl8p6TgoA==
Date: Fri, 30 May 2025 15:50:04 +0000
Message-ID: <20250530154934.10077-3-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250530154934.10077-1-gargaditya08@live.com>
In-Reply-To: <20250530154934.10077-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB6024:EE_
x-ms-office365-filtering-correlation-id: 33aa9ab9-4f2e-4017-381c-08dd9f91a50b
x-ms-exchange-slblob-mailprops:
 ukBna8sHV3J48egLt0zQW9/k+aCPfyTUi3JBzZlF9C0mWMgbZmjCgbqPvxF10guqcjHLy74SjxhzELxnERvbGt+mMYKTgvgmq0qnUPks/jOG9To0hzDOnNUl4I1HixiEpt4avJsRXS0romRvmqJDoiQNKghA5JsnBBwF36hBj1y72CEewDCmcTOh7p2pBnxbBU9OFgoU301KQQfoTf9IqpbQYKQcw5GX9QhQyw2C99trqVPqA4UI1FWrhkNqd+tKMhGUk+o9KYBrjRjIpIj1IFnxbvwbO1TcNebodvvM6H82hm5nNeNJZFThpk4PEt8f1zT63mVu1ivPu24dQydlEb4NPkpUE2mXQQVxokKRmOzIUimurSNq+lHmo0lwaEVyQreGiBHjMn25RR3Vbajs1gyiSi646oeKHJfTQbmlpnC8nptNIkFnaIhM5YwmzHsr0eIbzM9SG1XPPahjcLBusdZpzW9QKdN9xPY3sjWTDaUlAtRehQu63RTL4YOJFgn0Te3OMDAg3e+0Oo2dXMkbtnUOifWCKaQ0ha5RjF2lPNHL7wWT5VNv8WnGR2lo/CcrWfDfzyse8Ez7Rl3UvUmOEAaY4qJrU4hVavrbtvSA/+yUveJtvHFsHSnmiyyhmtrlOCM7YgCg9lG9ScncZeM99JCnXFxEYIdnNSdPc2loe81PXkr1VvYJPX3QqL7sbW+BY1iisQ7jGDX61Bx4mMg6dgW/6nR4bESeRe98Lp3tS6PdieAgt8NFHBlxOW1PFeZRoj2GF9x/wnOcwvnJlo/HNnnP8S4ckcnH8PlB72EXRbEBZ8czlM82Be3VsNs9H7tly4lqy22bBLX5t/M7wwNCbHMj0bV0CZQ7BZRxVyTBJmNW3fTUP+2jBmW0WUi7FrBDnpbgHrN5fBkyDIqfqFter/bmSmM3kfmy
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|7092599006|19110799006|8060799009|41001999006|8062599006|15080799009|12121999007|3412199025|440099028|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SyWmzI3F/bTs4sAIthI1GHcAMqYwbPxesJyTUj+zE2cL7C7L32aTrI9uLX?=
 =?iso-8859-1?Q?5SITWVn7ubJdFz7CUhjELXLBrdYNin2Dvdq4rqLUZlCbdWtR5rtHB1Wu4X?=
 =?iso-8859-1?Q?w96j+KNlKr7KWtmEyp9PPUWorOwR/kxynMCaXAHeXwnFW9wtk5szgsvs17?=
 =?iso-8859-1?Q?+AKoZ/X/zE7SyUFaYrVw0+2HlvLaJW9yDZZzfHOrB33VXRERAgYV5PVGfk?=
 =?iso-8859-1?Q?MifVBiv63QVVAlTiBcxMI0yobJmoH0vL1V4IOVnhRTP9/GVpjbKj8hNiLQ?=
 =?iso-8859-1?Q?kwZWB0o0rhgOVhkaGsk1KBHJQN/YkSzc/nnwaGGI+bl3HIQkBmq8NGul7K?=
 =?iso-8859-1?Q?jGpUSGH3oa5SXRu/fl5ng+6zYGE762VQPEpI6YDfr0AnXiAtl2mEcIYX83?=
 =?iso-8859-1?Q?C7CMoSvStfj0CEMiNnfN/wwrtGZgTelWo3a5Q6i40RL4EOH3nMVU9prG+J?=
 =?iso-8859-1?Q?ZAEgc6aR8V0I92Hht/4MBn+oBgy5ttjyf9t4ZeCscQFxsvps4ZEADmuNWr?=
 =?iso-8859-1?Q?fTn7PtDSumL6xgb/D1qKP3tj8d7hwUXUzJ1nwlqNZfrHo7QtaQ8VmZ64Vs?=
 =?iso-8859-1?Q?MsEZbMiNHrI6ooyUqDV8pgfyyquislmwmNwKYL9hnlI9y8FnOcHI3cqObo?=
 =?iso-8859-1?Q?rfkPcD7oR64Rr/8eAAyxjHYSNww8D/l3B8XY9y7KHGHC85/mgK0hZgvlHU?=
 =?iso-8859-1?Q?z5s5RujsinuPGAN5zWUV5hBGZySSO+WkXKBU57CeJnSsuPs5HcQH2aK485?=
 =?iso-8859-1?Q?No2hM1trp03WU/F+VTiOxevIIous4IklSagOWZv+qon1+R4JnZncMaxn+h?=
 =?iso-8859-1?Q?fOZRPd8N9mxsNT8E1ktUnyk7sy0GylL0GXbhqHRdYEuj/cNscDkHQ5XeJJ?=
 =?iso-8859-1?Q?1L32NhNZ1TcRldoaKxj+QcHyxOtiLmFT7lYXMcYNobLCTzdO4+KrdPAxYt?=
 =?iso-8859-1?Q?XdawlBTtXbwOdxWBGsHb32TKjbb5q9QomCyv84Rroajj8G9qiJ3lQGp40T?=
 =?iso-8859-1?Q?nRVqGmA/2rgSlPVr3c9uenOeR8AwsW5RQUgXQswKpCnyIqrpamnQ2kfLtB?=
 =?iso-8859-1?Q?gLSRfD0hN4TDnNIKRxVXMhfmTOxT7JC88ITYuEdW1KLbk4lG6Bl2lUyHvD?=
 =?iso-8859-1?Q?PnAHeZH6zVEj8mxJqKHj10Bd9aJ9pq8HsEy7q6errcYGd9ERQcfZBVQLjq?=
 =?iso-8859-1?Q?lUzfnJwSUnlsm1NkbKjpJ633boJsWeDzgRW/WuhQyWAJZljLsUkI/v0xhx?=
 =?iso-8859-1?Q?zaIsGgqNzIAIngzRhFWRdRohljp9toBUW2qOuVEWf2ppvJeabA4yGzojVC?=
 =?iso-8859-1?Q?1WrdPFC4OY4d0V02rpozxLYuig=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nenP/bcrSlhd4fqhInBze5BmUmQOxLaRp+gHOiUoPvDwTaKWLZ7zH6n1pQ?=
 =?iso-8859-1?Q?RpVysEv/ciPPR8f1/j5Q1qNpamFzYYzcAqyXwZ7T60VWLviyxrZ9XJrRgR?=
 =?iso-8859-1?Q?wemS+p4oQ3eGWVRYiSJIdl/V1XKUu1GQlbeZd208Wa0EyPe2bsSSfHcS/p?=
 =?iso-8859-1?Q?0J/TAj3nMk+/ECXI6nbhTya9+G2+EBNorz1IzLtZs7k203si4h7hrcVRDH?=
 =?iso-8859-1?Q?fnMI/t3FXEQrcYb8mdeGSaSX7KpfzJzEM9UyyWVgffVctasiNiyx9bGw8E?=
 =?iso-8859-1?Q?7L5DSE9MJDSUSfKYFbh/kZ+fO+gcn9qB8CrHVOqj163jyZSmHXrGdR6aCN?=
 =?iso-8859-1?Q?/JZApeEhuYzsWgqGEIWKyjLiimpXxOd15QxQ2+PfZvslXs8zZgxQ64bD05?=
 =?iso-8859-1?Q?MZAhNbFya9sMJxqKZSyMwIipLWAQNn5HKqVOs+b3TuQH+7x6uasx2ujjIJ?=
 =?iso-8859-1?Q?hreHldvvuMIbC4L5dNOqUtSsspX0ReVts0qWFSvW+bXTIRk7a0uWZxqism?=
 =?iso-8859-1?Q?WnmlDrDtuUMHioZOryUViKcJJBzmI8wXYh+viNkN4MFMbnC14BWTPbPUeG?=
 =?iso-8859-1?Q?rPDUkhLnTywz5lJyHZYG21UdJxj9VYhaoY0uD19Y2S97tCbZvq3OnRKqKE?=
 =?iso-8859-1?Q?fWWZcKa3m6jDYPhexq649chCYvrFJiECA19bzB+uXuIFpGziDgOWOkgrp6?=
 =?iso-8859-1?Q?9btztI8F+HmCDPJG2KLs4K0PmycdyhrLngwy2Fbsbp8vxfv1y93d0jjNkQ?=
 =?iso-8859-1?Q?xXae+pC+4RMFJBNOBcXKdV7xdHrLB5VLy8YvERuKVuZ2RcuxXBETrA06Ez?=
 =?iso-8859-1?Q?XLYh2IDLTJqCvJ5WYgwkk6XoTARij0sO8Dui7CnoU+GYiWVCfYk9FdVNxU?=
 =?iso-8859-1?Q?EzJ23z92P5TxAX6KeAraAWBcinfG9P5ZEAUClS3UzoZKQC9Ao1Ytjp7IsQ?=
 =?iso-8859-1?Q?zT98FLHMIAQ39epXgE/FyiJlsUSmg1gFNObHsxaD3yCKY/fbZF9gEjjKeT?=
 =?iso-8859-1?Q?uQqtOxhhWeyQkj6uB3xFGZXyG0LmDglACIuQe1JChXl7kMuE2hIfvqFcfl?=
 =?iso-8859-1?Q?PU3peiuw03j5Sro/6Yn7BtOtge083fYViPZrsjyryaEWpF+Uj6Ut30n4Jm?=
 =?iso-8859-1?Q?ZPEVQaoHrCocy5+zHkHYwRQdKXfaDuD/uHIo/xVc1SpgNFQBGgUl34WNub?=
 =?iso-8859-1?Q?PkLgRufu6PEhGPfsTCtQgqG+iAoU+n6OX060NVZB5xWU2Wo6DD3xK5+bDn?=
 =?iso-8859-1?Q?9uLPM3FmGgi9dv+Rfi2vDaD/FDzElw1zqcsm6rGCE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aa9ab9-4f2e-4017-381c-08dd9f91a50b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 15:50:04.4402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6024

The current documentation for git-send-email had an inconsistent use of
"", ``, and '' for quoting. This commit improves the formatting by
using the same style throughout the documentation. Missing full stops
have also been added at some places.

Finally, the cpan links of necessary perl modules have been added to
make their installation easier.

While at it, the unecessary use of $ with <num> and <int> placeholders
has also been removed.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/sendemail.adoc |  20 +--
 Documentation/git-send-email.adoc   | 232 ++++++++++++++--------------
 2 files changed, 130 insertions(+), 122 deletions(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sen=
demail.adoc
index 5ffcfc9f2a..54f1248e64 100644
--- a/Documentation/config/sendemail.adoc
+++ b/Documentation/config/sendemail.adoc
@@ -1,32 +1,32 @@
 sendemail.identity::
 	A configuration identity. When given, causes values in the
-	'sendemail.<identity>' subsection to take precedence over
-	values in the 'sendemail' section. The default identity is
+	`sendemail.<identity>` subsection to take precedence over
+	values in the `sendemail` section. The default identity is
 	the value of `sendemail.identity`.
=20
 sendemail.smtpEncryption::
 	See linkgit:git-send-email[1] for description.  Note that this
-	setting is not subject to the 'identity' mechanism.
+	setting is not subject to the `identity` mechanism.
=20
 sendemail.smtpSSLCertPath::
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
=20
 sendemail.<identity>.*::
-	Identity-specific versions of the 'sendemail.*' parameters
+	Identity-specific versions of the `sendemail.*` parameters
 	found below, taking precedence over those when this
 	identity is selected, through either the command-line or
 	`sendemail.identity`.
=20
 sendemail.multiEdit::
-	If true (default), a single editor instance will be spawned to edit
+	If `true` (default), a single editor instance will be spawned to edit
 	files you have to edit (patches when `--annotate` is used, and the
-	summary when `--compose` is used). If false, files will be edited one
+	summary when `--compose` is used). If `false`, files will be edited one
 	after the other, spawning a new editor each time.
=20
 sendemail.confirm::
 	Sets the default for whether to confirm before sending. Must be
-	one of 'always', 'never', 'cc', 'compose', or 'auto'. See `--confirm`
+	one of `always`, `never`, `cc`, `compose`, or `auto`. See `--confirm`
 	in the linkgit:git-send-email[1] documentation for the meaning of these
 	values.
=20
@@ -51,7 +51,7 @@ sendemail.aliasesFile::
=20
 sendemail.aliasFileType::
 	Format of the file(s) specified in sendemail.aliasesFile. Must be
-	one of 'mutt', 'mailrc', 'pine', 'elm', 'gnus', or 'sendmail'.
+	one of `mutt`, `mailrc`, `pine`, `elm`, `gnus`, or `sendmail`.
 +
 What an alias file in each format looks like can be found in
 the documentation of the email program of the same name. The
@@ -101,7 +101,7 @@ sendemail.signedOffCc (deprecated)::
=20
 sendemail.smtpBatchSize::
 	Number of messages to be sent per connection, after that a relogin
-	will happen.  If the value is 0 or undefined, send all messages in
+	will happen.  If the value is `0` or undefined, send all messages in
 	one connection.
 	See also the `--batch-size` option of linkgit:git-send-email[1].
=20
@@ -111,5 +111,5 @@ sendemail.smtpReloginDelay::
=20
 sendemail.forbidSendmailVariables::
 	To avoid common misconfiguration mistakes, linkgit:git-send-email[1]
-	will abort with a warning if any configuration options for "sendmail"
+	will abort with a warning if any configuration options for `sendmail`
 	exist. Set this variable to bypass the check.
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 81f8cbc6f3..5d13a856a7 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -21,7 +21,7 @@ Takes the patches given on the command line and emails th=
em out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email, as well as options understood by
+be passed to `git send-email`, as well as options understood by
 linkgit:git-format-patch[1].
=20
 The header of the email is configurable via command-line options.  If not
@@ -35,11 +35,11 @@ There are two formats accepted for patch files:
 This is what linkgit:git-format-patch[1] generates.  Most headers and MIME
 formatting are ignored.
=20
-2. The original format used by Greg Kroah-Hartman's 'send_lots_of_email.pl=
'
+2. The original format used by Greg Kroah-Hartman's `send_lots_of_email.pl=
`
    script
 +
-This format expects the first line of the file to contain the "Cc:" value
-and the "Subject:" of the message as the second line.
+This format expects the first line of the file to contain the `Cc:` value
+and the `Subject:` of the message as the second line.
=20
=20
 OPTIONS
@@ -54,13 +54,13 @@ Composing
 	`sendemail.multiEdit`.
=20
 --bcc=3D<address>,...::
-	Specify a "Bcc:" value for each email. Default is the value of
+	Specify a `Bcc:` value for each email. Default is the value of
 	`sendemail.bcc`.
 +
 This option may be specified multiple times.
=20
 --cc=3D<address>,...::
-	Specify a starting "Cc:" value for each email.
+	Specify a starting `Cc:` value for each email.
 	Default is the value of `sendemail.cc`.
 +
 This option may be specified multiple times.
@@ -69,14 +69,14 @@ This option may be specified multiple times.
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
 	to edit an introductory message for the patch series.
 +
-When `--compose` is used, git send-email will use the From, To, Cc, Bcc,
-Subject, Reply-To, and In-Reply-To headers specified in the message. If
-the body of the message (what you type after the headers and a blank
-line) only contains blank (or Git: prefixed) lines, the summary won't be
+When `--compose` is used, `git send-email` will use the `From`, `To`, `Cc`=
,
+`Bcc`, `Subject`, `Reply-To`, and `In-Reply-To` headers specified in the
+message. If the body of the message (what you type after the headers and a
+blank line) only contains blank (or `Git:` prefixed) lines, the summary wo=
n't be
 sent, but the headers mentioned above will be used unless they are
 removed.
 +
-Missing From or In-Reply-To headers will be prompted for.
+Missing `From` or `In-Reply-To` headers will be prompted for.
 +
 See the CONFIGURATION section for `sendemail.multiEdit`.
=20
@@ -85,13 +85,13 @@ See the CONFIGURATION section for `sendemail.multiEdit`=
.
 	the value of the `sendemail.from` configuration option is used.  If
 	neither the command-line option nor `sendemail.from` are set, then the
 	user will be prompted for the value.  The default for the prompt will be
-	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
-	set, as returned by "git var -l".
+	the value of `GIT_AUTHOR_IDENT`, or `GIT_COMMITTER_IDENT` if that is not
+	set, as returned by `git var -l`.
=20
 --reply-to=3D<address>::
 	Specify the address where replies from recipients should go to.
 	Use this if replies to messages should go to another address than what
-	is specified with the --from parameter.
+	is specified with the `--from` parameter.
=20
 --in-reply-to=3D<identifier>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
@@ -112,14 +112,14 @@ illustration below where `[PATCH v2 0/3]` is in reply=
 to `[PATCH 0/2]`:
       [PATCH v2 2/3] New tests
       [PATCH v2 3/3] Implementation
 +
-Only necessary if --compose is also set.  If --compose
+Only necessary if `--compose` is also set.  If `--compose`
 is not set, this will be prompted for.
=20
 --[no-]outlook-id-fix::
 	Microsoft Outlook SMTP servers discard the Message-ID sent via email and
 	assign a new random Message-ID, thus breaking threads.
 +
-With `--outlook-id-fix`, 'git send-email' uses a mechanism specific to
+With `--outlook-id-fix`, `git send-email` uses a mechanism specific to
 Outlook servers to learn the Message-ID the server assigned to fix the
 threading. Use it only when you know that the server reports the
 rewritten Message-ID the same way as Outlook servers do.
@@ -130,14 +130,14 @@ to 'smtp.office365.com' or 'smtp-mail.outlook.com'. U=
se
=20
 --subject=3D<string>::
 	Specify the initial subject of the email thread.
-	Only necessary if --compose is also set.  If --compose
+	Only necessary if `--compose` is also set.  If `--compose`
 	is not set, this will be prompted for.
=20
 --to=3D<address>,...::
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
 	value of the `sendemail.to` configuration value; if that is unspecified,
-	and --to-cmd is not specified, this will be prompted for.
+	and `--to-cmd` is not specified, this will be prompted for.
 +
 This option may be specified multiple times.
=20
@@ -145,30 +145,30 @@ This option may be specified multiple times.
 	When encountering a non-ASCII message or subject that does not
 	declare its encoding, add headers/quoting to indicate it is
 	encoded in <encoding>.  Default is the value of the
-	'sendemail.assume8bitEncoding'; if that is unspecified, this
+	`sendemail.assume8bitEncoding`; if that is unspecified, this
 	will be prompted for if any non-ASCII files are encountered.
 +
 Note that no attempts whatsoever are made to validate the encoding.
=20
 --compose-encoding=3D<encoding>::
 	Specify encoding of compose message. Default is the value of the
-	'sendemail.composeEncoding'; if that is unspecified, UTF-8 is assumed.
+	`sendemail.composeEncoding`; if that is unspecified, UTF-8 is assumed.
=20
 --transfer-encoding=3D(7bit|8bit|quoted-printable|base64|auto)::
 	Specify the transfer encoding to be used to send the message over SMTP.
-	7bit will fail upon encountering a non-ASCII message.  quoted-printable
+	`7bit` will fail upon encountering a non-ASCII message. `quoted-printable=
`
 	can be useful when the repository contains files that contain carriage
-	returns, but makes the raw patch email file (as saved from a MUA) much
-	harder to inspect manually.  base64 is even more fool proof, but also
-	even more opaque.  auto will use 8bit when possible, and quoted-printable
-	otherwise.
+	returns, but makes the raw patch email file (as saved from an MUA) much
+	harder to inspect manually. `base64` is even more fool proof, but also
+	even more opaque. `auto` will use `8bit` when possible, and
+	`quoted-printable` otherwise.
 +
 Default is the value of the `sendemail.transferEncoding` configuration
 value; if that is unspecified, default to `auto`.
=20
 --xmailer::
 --no-xmailer::
-	Add (or prevent adding) the "X-Mailer:" header.  By default,
+	Add (or prevent adding) the `X-Mailer:` header.  By default,
 	the header is added, but it can be turned off by setting the
 	`sendemail.xmailer` configuration variable to `false`.
=20
@@ -178,9 +178,9 @@ Sending
 --envelope-sender=3D<address>::
 	Specify the envelope sender used to send the emails.
 	This is useful if your default address is not the address that is
-	subscribed to a list. In order to use the 'From' address, set the
-	value to "auto". If you use the sendmail binary, you must have
-	suitable privileges for the -f parameter.  Default is the value of the
+	subscribed to a list. In order to use the `From` address, set the
+	value to `auto`. If you use the `sendmail` binary, you must have
+	suitable privileges for the `-f` parameter.  Default is the value of the
 	`sendemail.envelopeSender` configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
=20
@@ -189,27 +189,27 @@ Sending
 	be sendmail-like; specifically, it must support the `-i` option.
 	The command will be executed in the shell if necessary.  Default
 	is the value of `sendemail.sendmailCmd`.  If unspecified, and if
-	--smtp-server is also unspecified, git-send-email will search
-	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
+	`--smtp-server` is also unspecified, `git send-email` will search
+	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH`.
=20
 --smtp-encryption=3D<encryption>::
 	Specify in what way encrypting begins for the SMTP connection.
-	Valid values are 'ssl' and 'tls'. Any other value reverts to plain
+	Valid values are `ssl` and `tls`. Any other value reverts to plain
 	(unencrypted) SMTP, which defaults to port 25.
 	Despite the names, both values will use the same newer version of TLS,
-	but for historic reasons have these names. 'ssl' refers to "implicit"
+	but for historic reasons have these names. `ssl` refers to "implicit"
 	encryption (sometimes called SMTPS), that uses port 465 by default.
-	'tls' refers to "explicit" encryption (often known as STARTTLS),
+	`tls` refers to "explicit" encryption (often known as STARTTLS),
 	that uses port 25 by default. Other ports might be used by the SMTP
 	server, which are not the default. Commonly found alternative port for
-	'tls' and unencrypted is 587. You need to check your provider's
+	`tls` and unencrypted is 587. You need to check your provider's
 	documentation or your server configuration to make sure
 	for your own case. Default is the value of `sendemail.smtpEncryption`.
=20
 --smtp-domain=3D<FQDN>::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
-	FQDN to match your IP address.  If not set, git send-email attempts
+	FQDN to match your IP address.  If not set, `git send-email` attempts
 	to determine your FQDN automatically.  Default is the value of
 	`sendemail.smtpDomain`.
=20
@@ -223,10 +223,10 @@ $ git send-email --smtp-auth=3D"PLAIN LOGIN GSSAPI" .=
..
 +
 If at least one of the specified mechanisms matches the ones advertised by=
 the
 SMTP server and if it is supported by the utilized SASL library, the mecha=
nism
-is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-au=
th`
+is used for authentication. If neither `sendemail.smtpAuth` nor `--smtp-au=
th`
 is specified, all mechanisms supported by the SASL library can be used. Th=
e
-special value 'none' maybe specified to completely disable authentication
-independently of `--smtp-user`
+special value `none` maybe specified to completely disable authentication
+independently of `--smtp-user`.
=20
 --smtp-pass[=3D<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
@@ -238,16 +238,16 @@ Furthermore, passwords need not be specified in confi=
guration files
 or on the command line. If a username has been specified (with
 `--smtp-user` or a `sendemail.smtpUser`), but no password has been
 specified (with `--smtp-pass` or `sendemail.smtpPass`), then
-a password is obtained using 'git-credential'.
+a password is obtained using linkgit:git-credential[1].
=20
 --no-smtp-auth::
-	Disable SMTP authentication. Short hand for `--smtp-auth=3Dnone`
+	Disable SMTP authentication. Short hand for `--smtp-auth=3Dnone`.
=20
 --smtp-server=3D<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  If unspecified, and if
 	`--sendmail-cmd` is also unspecified, the default is to search
-	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH if such a
+	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH` if such a
 	program is available, falling back to `localhost` otherwise.
 +
 For backward compatibility, this option can also specify a full pathname
@@ -260,7 +260,7 @@ instead.
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25, but may also listen to
 	submission port 587, or the common SSL smtp port 465);
-	symbolic port names (e.g. "submission" instead of 587)
+	symbolic port names (e.g. `submission` instead of 587)
 	are also accepted. The port can also be set with the
 	`sendemail.smtpServerPort` configuration variable.
=20
@@ -269,17 +269,17 @@ instead.
 	Default value can be specified by the `sendemail.smtpServerOption`
 	configuration option.
 +
-The --smtp-server-option option must be repeated for each option you want
+The `--smtp-server-option` option must be repeated for each option you wan=
t
 to pass to the server. Likewise, different lines in the configuration file=
s
 must be used for each option.
=20
 --smtp-ssl::
-	Legacy alias for '--smtp-encryption ssl'.
+	Legacy alias for `--smtp-encryption ssl`.
=20
 --smtp-ssl-cert-path::
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
 	certificate validation (either a directory that has been processed
-	by 'c_rehash', or a single file containing one or more PEM format
+	by `c_rehash`, or a single file containing one or more PEM format
 	certificates concatenated together: see verify(1) -CAfile and
 	-CApath for more information on these). Set it to an empty string
 	to disable certificate verification. Defaults to the value of the
@@ -298,18 +298,18 @@ must be used for each option.
 	connection and authentication problems.
=20
 --batch-size=3D<num>::
-	Some email servers (e.g. smtp.163.com) limit the number emails to be
+	Some email servers (e.g. 'smtp.163.com') limit the number of emails to be
 	sent per session (connection) and this will lead to a failure when
 	sending many messages.  With this option, send-email will disconnect afte=
r
-	sending $<num> messages and wait for a few seconds (see --relogin-delay)
-	and reconnect, to work around such a limit.  You may want to
-	use some form of credential helper to avoid having to retype
-	your password every time this happens.  Defaults to the
+	sending _<num>_ messages and wait for a few seconds
+	(see `--relogin-delay`) and reconnect, to work around such a limit.
+	You may want to use some form of credential helper to avoid having to
+	retype your password every time this happens.  Defaults to the
 	`sendemail.smtpBatchSize` configuration variable.
=20
 --relogin-delay=3D<int>::
-	Waiting $<int> seconds before reconnecting to SMTP server. Used together
-	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
+	Waiting _<int>_ seconds before reconnecting to SMTP server. Used together
+	with `--batch-size` option.  Defaults to the `sendemail.smtpReloginDelay`
 	configuration variable.
=20
 Automating
@@ -318,7 +318,7 @@ Automating
 --no-to::
 --no-cc::
 --no-bcc::
-	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
+	Clears any list of `To:`, `Cc:`, `Bcc:` addresses previously
 	set via config.
=20
 --no-identity::
@@ -327,13 +327,13 @@ Automating
=20
 --to-cmd=3D<command>::
 	Specify a command to execute once per patch file which
-	should generate patch file specific "To:" entries.
+	should generate patch file specific `To:` entries.
 	Output of this command must be single email address per line.
-	Default is the value of 'sendemail.toCmd' configuration value.
+	Default is the value of `sendemail.toCmd` configuration value.
=20
 --cc-cmd=3D<command>::
 	Specify a command to execute once per patch file which
-	should generate patch file specific "Cc:" entries.
+	should generate patch file specific `Cc:` entries.
 	Output of this command must be single email address per line.
 	Default is the value of `sendemail.ccCmd` configuration value.
=20
@@ -341,7 +341,7 @@ Automating
 	Specify a command that is executed once per outgoing message
 	and output RFC 2822 style header lines to be inserted into
 	them. When the `sendemail.headerCmd` configuration variable is
-	set, its value is always used. When --header-cmd is provided
+	set, its value is always used. When `--header-cmd` is provided
 	at the command line, its value takes precedence over the
 	`sendemail.headerCmd` configuration variable.
=20
@@ -350,7 +350,7 @@ Automating
=20
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
-	email sent.  If disabled with "--no-chain-reply-to", all emails after
+	email sent.  If disabled with `--no-chain-reply-to`, all emails after
 	the first will be sent as replies to the first email sent.  When using
 	this, it is recommended that the first file given be an overview of the
 	entire patch series. Disabled by default, but the `sendemail.chainReplyTo=
`
@@ -358,79 +358,80 @@ Automating
=20
 --identity=3D<identity>::
 	A configuration identity. When given, causes values in the
-	'sendemail.<identity>' subsection to take precedence over
-	values in the 'sendemail' section. The default identity is
+	`sendemail.<identity>` subsection to take precedence over
+	values in the `sendemail` section. The default identity is
 	the value of `sendemail.identity`.
=20
 --[no-]signed-off-by-cc::
-	If this is set, add emails found in the `Signed-off-by` trailer or Cc: li=
nes to the
-	cc list. Default is the value of `sendemail.signedOffByCc` configuration
-	value; if that is unspecified, default to --signed-off-by-cc.
+	If this is set, add emails found in the `Signed-off-by` trailer or `Cc:`
+	lines to the cc list. Default is the value of `sendemail.signedOffByCc`
+	configuration value; if that is unspecified, default to
+	`--signed-off-by-cc`.
=20
 --[no-]cc-cover::
-	If this is set, emails found in Cc: headers in the first patch of
+	If this is set, emails found in `Cc:` headers in the first patch of
 	the series (typically the cover letter) are added to the cc list
-	for each email set. Default is the value of 'sendemail.ccCover'
-	configuration value; if that is unspecified, default to --no-cc-cover.
+	for each email set. Default is the value of `sendemail.ccCover`
+	configuration value; if that is unspecified, default to `--no-cc-cover`.
=20
 --[no-]to-cover::
-	If this is set, emails found in To: headers in the first patch of
+	If this is set, emails found in `To:` headers in the first patch of
 	the series (typically the cover letter) are added to the to list
-	for each email set. Default is the value of 'sendemail.toCover'
-	configuration value; if that is unspecified, default to --no-to-cover.
+	for each email set. Default is the value of `sendemail.toCover`
+	configuration value; if that is unspecified, default to `--no-to-cover`.
=20
 --suppress-cc=3D<category>::
 	Specify an additional category of recipients to suppress the
 	auto-cc of:
 +
 --
-- 'author' will avoid including the patch author.
-- 'self' will avoid including the sender.
-- 'cc' will avoid including anyone mentioned in Cc lines in the patch head=
er
-  except for self (use 'self' for that).
-- 'bodycc' will avoid including anyone mentioned in Cc lines in the
-  patch body (commit message) except for self (use 'self' for that).
-- 'sob' will avoid including anyone mentioned in the Signed-off-by trailer=
s except
-  for self (use 'self' for that).
-- 'misc-by' will avoid including anyone mentioned in Acked-by,
+- `author` will avoid including the patch author.
+- `self` will avoid including the sender.
+- `cc` will avoid including anyone mentioned in Cc lines in the patch head=
er
+  except for self (use `self` for that).
+- `bodycc` will avoid including anyone mentioned in Cc lines in the
+  patch body (commit message) except for self (use `self` for that).
+- `sob` will avoid including anyone mentioned in the Signed-off-by trailer=
s except
+  for self (use `self` for that).
+- `misc-by` will avoid including anyone mentioned in Acked-by,
   Reviewed-by, Tested-by and other "-by" lines in the patch body,
-  except Signed-off-by (use 'sob' for that).
-- 'cccmd' will avoid running the --cc-cmd.
-- 'body' is equivalent to 'sob' + 'bodycc' + 'misc-by'.
-- 'all' will suppress all auto cc values.
+  except Signed-off-by (use `sob` for that).
+- `cccmd` will avoid running the --cc-cmd.
+- `body` is equivalent to `sob` + `bodycc` + `misc-by`.
+- `all` will suppress all auto cc values.
 --
 +
 Default is the value of `sendemail.suppressCc` configuration value; if
-that is unspecified, default to 'self' if --suppress-from is
-specified, as well as 'body' if --no-signed-off-cc is specified.
+that is unspecified, default to `self` if `--suppress-from` is
+specified, as well as `body` if `--no-signed-off-cc` is specified.
=20
 --[no-]suppress-from::
-	If this is set, do not add the From: address to the cc: list.
+	If this is set, do not add the `From:` address to the `Cc:` list.
 	Default is the value of `sendemail.suppressFrom` configuration
-	value; if that is unspecified, default to --no-suppress-from.
+	value; if that is unspecified, default to `--no-suppress-from`.
=20
 --[no-]thread::
-	If this is set, the In-Reply-To and References headers will be
+	If this is set, the `In-Reply-To` and `References` headers will be
 	added to each email sent.  Whether each mail refers to the
-	previous email (`deep` threading per 'git format-patch'
+	previous email (`deep` threading per `git format-patch`
 	wording) or to the first email (`shallow` threading) is
-	governed by "--[no-]chain-reply-to".
+	governed by `--[no-]chain-reply-to`.
 +
-If disabled with "--no-thread", those headers will not be added
-(unless specified with --in-reply-to).  Default is the value of the
+If disabled with `--no-thread`, those headers will not be added
+(unless specified with `--in-reply-to`).  Default is the value of the
 `sendemail.thread` configuration value; if that is unspecified,
-default to --thread.
+default to `--thread`.
 +
 It is up to the user to ensure that no In-Reply-To header already
-exists when 'git send-email' is asked to add it (especially note that
-'git format-patch' can be configured to do the threading itself).
+exists when `git send-email` is asked to add it (especially note that
+`git format-patch` can be configured to do the threading itself).
 Failure to do so may not produce the expected result in the
 recipient's MUA.
=20
 --[no-]mailmap::
 	Use the mailmap file (see linkgit:gitmailmap[5]) to map all
 	addresses to their canonical real name and email address. Additional
-	mailmap data specific to git-send-email may be provided using the
+	mailmap data specific to `git send-email` may be provided using the
 	`sendemail.mailmap.file` or `sendemail.mailmap.blob` configuration
 	values. Defaults to `sendemail.mailmap`.
=20
@@ -441,17 +442,17 @@ Administering
 	Confirm just before sending:
 +
 --
-- 'always' will always confirm before sending
-- 'never' will never confirm before sending
-- 'cc' will confirm before sending when send-email has automatically
-  added addresses from the patch to the Cc list
-- 'compose' will confirm before sending the first message when using --com=
pose.
-- 'auto' is equivalent to 'cc' + 'compose'
+- `always` will always confirm before sending.
+- `never` will never confirm before sending.
+- `cc` will confirm before sending when send-email has automatically
+  added addresses from the patch to the Cc list.
+- `compose` will confirm before sending the first message when using --com=
pose.
+- `auto` is equivalent to `cc` + `compose`.
 --
 +
 Default is the value of `sendemail.confirm` configuration value; if that
-is unspecified, default to 'auto' unless any of the suppress options
-have been specified, in which case default to 'compose'.
+is unspecified, default to `auto` unless any of the suppress options
+have been specified, in which case default to `compose`.
=20
 --dry-run::
 	Do everything except actually send the emails.
@@ -460,10 +461,10 @@ have been specified, in which case default to 'compos=
e'.
 	When an argument may be understood either as a reference or as a file nam=
e,
 	choose to understand it as a format-patch argument (`--format-patch`)
 	or as a file name (`--no-format-patch`). By default, when such a conflict
-	occurs, git send-email will fail.
+	occurs, `git send-email` will fail.
=20
 --quiet::
-	Make git-send-email less verbose.  One line per email should be
+	Make `git send-email` less verbose.  One line per email should be
 	all that is output.
=20
 --[no-]validate::
@@ -474,7 +475,7 @@ have been specified, in which case default to 'compose'=
.
 		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]=
).
 		*	Warn of patches that contain lines longer than
 			998 characters unless a suitable transfer encoding
-			('auto', 'base64', or 'quoted-printable') is used;
+			(`auto`, `base64`, or `quoted-printable`) is used;
 			this is due to SMTP limits as described by
 			https://www.ietf.org/rfc/rfc5322.txt.
 --
@@ -493,13 +494,13 @@ Information
 	Instead of the normal operation, dump the shorthand alias names from
 	the configured alias file(s), one per line in alphabetical order. Note
 	that this only includes the alias name and not its expanded email address=
es.
-	See 'sendemail.aliasesFile' for more information about aliases.
+	See `sendemail.aliasesFile` for more information about aliases.
=20
 --translate-aliases::
 	Instead of the normal operation, read from standard input and
 	interpret each line as an email alias. Translate it according to the
 	configured alias file(s). Output each translated name and email
-	address to standard output, one per line. See 'sendemail.aliasFile'
+	address to standard output, one per line. See `sendemail.aliasFile`
 	for more information about aliases.
=20
 CONFIGURATION
@@ -525,7 +526,7 @@ edit `~/.gitconfig` to specify your account settings:
 ----
=20
 If you have multi-factor authentication set up on your Gmail account, you =
can
-generate an app-specific password for use with 'git send-email'. Visit
+generate an app-specific password for use with `git send-email`. Visit
 https://security.google.com/settings/security/apppasswords to create it.
=20
 You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` and
@@ -599,9 +600,16 @@ helpers.
=20
 Note: the following core Perl modules that may be installed with your
 distribution of Perl are required:
-MIME::Base64, MIME::QuotedPrint, Net::Domain and Net::SMTP.
+
+https://metacpan.org/pod/MIME::Base64[MIME::Base64],
+https://metacpan.org/pod/MIME::QuotedPrint[MIME::QuotedPrint],
+https://metacpan.org/pod/Net::Domain[Net::Domain] and
+https://metacpan.org/pod/Net::SMTP[Net::SMTP].
+
 These additional Perl modules are also required:
-Authen::SASL and Mail::Address.
+
+https://metacpan.org/pod/Authen::SASL[Authen::SASL] and
+https://metacpan.org/pod/Mail::Address[Mail::Address].
=20
=20
 SEE ALSO
--=20
2.49.0.639.ge2dd5d9d81

