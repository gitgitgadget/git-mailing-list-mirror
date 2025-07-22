Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D9219A95
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184930; cv=fail; b=AqxcADBByNC6Oohg844VYEHSzI8nmDkAdopL9KzP2xclfp4aBhM0pdqCvrqeoMqZmMuO7y7oiefzFSxRdObdl+N/kIM7Pd7iPDcVaAMc82PWqGRvjY+S7Df+yEA6lmVuBIgzAtw5RzbU+V4twhyBksLHdkRhbhts0WPHC8pWYSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184930; c=relaxed/simple;
	bh=ElzbLKpoDgWh6xsqAQFErp3Urikn19p8YsqkxVkE4nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jhwW/h4u/85Hod9IJZcM7sBSah61VBbnJTfMRPKrLT0CpmPYmkmZg966NF1CIE8df/chm9gO+B+8xf06q65rtAyzhrkT/lO+h4DT/LZw3FH34S4a+YctY+iGIDyc8QcHJo7Sjn0+zCpHpCFIPzkaO2JKlxeMt8MjSnyJP21LEfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=AmY9h0W4; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="AmY9h0W4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BezMr7ZN2UxwdLHSzJ+nh12aYS8dQ3dgaNaKf24ngyiLrCjsHbCGkNRffXYV7HHkbnCusGzyjssbyH/cl2n0gDqy+B52eHRV+coe4qYf9TR3gZh0UwHOrtRmpdc4Y8351QZwNZEmB0xFDiQ816AP+/p77VeLfF27Ay4GdiE1QKWnQliQRDDppzoekYNPzGWfigBe9gGS0UFGTSbUQEFHLuKlLr8idggXbWkruwM2pK37Oc9/B4Q28Db69arxkA40bGY4An1QG9i1vQdbhRYclnWB73m8Kf9twMmfBAvrW4PypsgwdwouF1W0gZGEHQtwSfzxWa8sMH3iFUR3Bn3CYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ijdkf8EZ3LSnAGgPm6/9njRhEqpFGePwFKlBGd5tPEw=;
 b=yCnXDA/GhJsDYwBTHqIjZyrgEXJ6soqmQboU7t2ZKuy19HAgr1tCCmxFVwqZHVp3zHl3kfKKZbTMsO4ezc5fb26R8tc8c+SiMId0RAHrim0so4mxyzIwFcZX0snz/VuB/6d/DpkKn/Fh1KHxo3JGzamua7qIxrKtjn2/KezVMG/zlOTDQIw6gPhkcOGg5qiP8j++KAS6BH0V6OtOpfdm0Z8XSCH9NSTdF0tYmb14/8v7GQ9zALlls3jpKdoKzzHyKHcn28NIcOzohCPxEpQD1Jz5HV2jzP8f0wHM8u/aTUjlDDo+23ZWvmRsoPB9JUeRXn0Y5wweULxDP5H1/0sJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijdkf8EZ3LSnAGgPm6/9njRhEqpFGePwFKlBGd5tPEw=;
 b=AmY9h0W4TnpEUO9CFQYL/gQaY7MMRptS672sYkCEjxOVi0gQU3tGURvjSA1nHcn1kAzML4D7bmFq6GCtYz8oIvoh0QJRfBdRSeZpIS0KZvRTojsbJ+BmtzHefVFAQexT+STyOaRkWP4tmA2Gmuq5HHTW82M2Bzg0mK7E8psXANxqiNcd4QyWd3wj5ynI/tVE80/dtUxyWkewHG9ezEh2aih0w/wkUmQfVGdI89M597L3KAbTph6Zgwc6SVic0GXWP15ZKkO1He56IPL/ox8xlsp4pK3SuR1SmaUjbb0uCrjWqrvmlQbs6MKKbp/BCGLQ3Qa+lnHbSJtwzOsbTK1gfw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB8921.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 11:48:43 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:48:42 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] docs: explain how to use `git imap-send --list` command to
 get a list of available folders
Thread-Topic: [PATCH v2] docs: explain how to use `git imap-send --list`
 command to get a list of available folders
Thread-Index: AQHb+v6SBJYaaOgBykKJY9JJ8XHKpA==
Date: Tue, 22 Jul 2025 11:48:42 +0000
Message-ID: <20250722114827.22493-1-gargaditya08@live.com>
References: <20250722114246.20422-1-gargaditya08@live.com>
In-Reply-To: <20250722114246.20422-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB8921:EE_
x-ms-office365-filtering-correlation-id: bd13bff7-6d43-4c0a-1209-08ddc915b51f
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|15080799012|461199028|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KsF9g9DgwOQY5twpY/c5LzSoln/bU9pENyp4JnszuH//RqmdNs7vBMxOyk?=
 =?iso-8859-1?Q?dc5ZitFnBmyJoWYGv0eAWpxsu0AgNFIMYrySDGzwr26mdgIzjBNPYBjS7o?=
 =?iso-8859-1?Q?bkPoSnPS82lOtW39D3kGf9DTjbW/D+xNnjUO4npdHathwoyIojwsYcHeWv?=
 =?iso-8859-1?Q?oVNLD4IaDOpl2vpfAa0/PNEYHkTq9PeMxnhaZ+nSyVC1jPIK7v3C7DQBjm?=
 =?iso-8859-1?Q?UzV4rYqRr+7mSuQczJwoDsJf74GFg3urn4mUGZZ+eJ9p911FyO2z5ZWcCa?=
 =?iso-8859-1?Q?mf2IMXaXlcP1JWCiEW1dYGZN4GsE+gSveaFcPgM6ADlGEzjCJRYzBsnUko?=
 =?iso-8859-1?Q?jv7a0CizS+fB81b1a7xNh42oagBMGBvL/bRCMcFwJCtrWO+5LzsRAzyBOC?=
 =?iso-8859-1?Q?qVH++TUbi/tTrfQp6qurERuy3ONC/9QDmziwzHNJKfeWATAl6hB9glxOXb?=
 =?iso-8859-1?Q?R1qaNPYJEPCM+Zetf/VXiKb0DKtlnNAs44ope0m6kgygRnwMsiQOK4HfQX?=
 =?iso-8859-1?Q?sxdZBsneebrH4ZgS0UrjdqF9SuxoqFic2eY2cd/IuVlj67NdvuqXpad8i5?=
 =?iso-8859-1?Q?k6QNyGOnZGS5+gpTWR/25dWWpTjlgAQVsP7Tqks/Vf5kGBCKxOS5iYTZ1D?=
 =?iso-8859-1?Q?IkVCyu6XKfWFWXVE95/nrzIDFKNjNnBBAx4gK5znnikE09Mcx1Ls8rXvrq?=
 =?iso-8859-1?Q?WzkMgsFDP1SVlgEpUjqOiYIl04J/iF5I7AulfF2AteMT1UUbx6nEtFKUna?=
 =?iso-8859-1?Q?EBx5zW/fhomr96tTXjZvL4TN86XfcvK9KRwRfDN0uh6FrZmVXcezgLCdKN?=
 =?iso-8859-1?Q?vkxsOgC1Y1ZcY0xFlG8KUCa+rGleXquYPnCgVJmDRKdzZeibIJi3PsXqUY?=
 =?iso-8859-1?Q?7CFWGOCUevpIETCCsmMXG8RgK2FiNq9DLORSGt9Ke5CT7tOJ0u7BtTfvM+?=
 =?iso-8859-1?Q?gtp/6hr1BOB92a29Kb5/2cgzFbibGi66JG8nTWC4mOjAkRHNkYgvMst+94?=
 =?iso-8859-1?Q?uT5jYndBkMD2VtDJZtw3c7FQdImzuSL4lJAzyUnTXCv44wkl6tKQlQ1Svo?=
 =?iso-8859-1?Q?tVTWhhlyLsfrzVlgDjjkBc0Xzm++rTWaqzclcWUvVSbv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?x2hS2oLBdIyP/xG9oefbxZ8FOk647WSTXNglLLrcj/I0NH5Z2pW8FfOGTD?=
 =?iso-8859-1?Q?d4N09aAHZixdat6dJa1y5wv4hvjOvy4+NKHQGeAI16ZxFIq+oq6+0KEhbl?=
 =?iso-8859-1?Q?MJksz0/Oy/pjmMJ0IIQcGitUuge/1hn2XU3KjA9mXCCOqel9EiYfTFUZ5G?=
 =?iso-8859-1?Q?1QCwEysWTBT1WnzrlX/p9gaemh3Hp7zjizyAxgp4afsTbx4veXcVGpT3KN?=
 =?iso-8859-1?Q?gtiWB7RIsPe0jkTFhcGlThpsExk9djqyrpy7ATHInEQJJJRKhHtN3ULcfb?=
 =?iso-8859-1?Q?TLU8s1V5og/UZ4FKQ2wdJR4SmnxXAm6FWKJHPZkHmZL33L5S3pyER4hq0K?=
 =?iso-8859-1?Q?+zI+cghdi4PjskSmndOlSHSnXYgv6T+QKnxsSiQVw9tGX39zpdeFV5HMKU?=
 =?iso-8859-1?Q?N3PtDylEFPhOCqLYVyfxPgfa3qypoou3TN5hCdUD9gSiE/PwbYraJ90ttM?=
 =?iso-8859-1?Q?o1A9d4i4XjuhFjVTymk1Ayj7z2nn5LJBL/PsJ89Sll7GT2UiEtGp1KpSLe?=
 =?iso-8859-1?Q?6nOjodz54w3jBMmH3vi0B3OU9daqrUvay8WHwNJqrbPj54HBTKMDP+l4t0?=
 =?iso-8859-1?Q?WtnTLSi7XmetEPB0mXKzQq2rEJDPklU0WO9RZvnvA2sFvbCxMO4mBgNXvV?=
 =?iso-8859-1?Q?CCwCWVE80175nf+n7Kc9fAakr6C+Co7nvshotfPpQrpf4CZYLW3yGg14R6?=
 =?iso-8859-1?Q?C80Ff0UMJb62Q5yaBWk73dRb+h1Yku2h/RQoqrTug9zsuP4JqCz8iSA9BI?=
 =?iso-8859-1?Q?H1iuZNN4006aM+GHh2lGsLRYeqJvB+3XXQ67IU6yRUMxVWka3zwjDz0bzD?=
 =?iso-8859-1?Q?FDNjZ29Rqq+W9CBLedLuH6aFAaR3WIcXjgdJvd0vHFLNSnRIhJmhN1rfvi?=
 =?iso-8859-1?Q?uEYoJBuv2C+6DMnWT7mOJT42PurD6rDP4Z06VLiHUZ5hCmenrhmy4goTQB?=
 =?iso-8859-1?Q?OxAhVjJWuSqK5ar369kGnR0nKHhfnwmxdXdYNIVPkiLHxzxs37vPpE7BBH?=
 =?iso-8859-1?Q?65bie1H+wCQSQiqg60RP0ys46VOdrYDN8Ho+zW/o/mDcSvVh1jx1DXsGTq?=
 =?iso-8859-1?Q?m7Di8dJaRAxOSBhJDna38EtOXwLQWhUhLvLbmoUnLVUswpDFfNA+Xf6Ai9?=
 =?iso-8859-1?Q?8od+52VuWeOnwIaDRhkyGrjyo3ROmtdzWFFklxxFsSFHUQD++5y4YT3CQ3?=
 =?iso-8859-1?Q?KNykGwKp4GTFoECnNcE3s9U9Ndzgs/UJF4qE6xQFU40BcIEUqDMvrfHcJ6?=
 =?iso-8859-1?Q?Budkb0Tw7M7S5lF75APa/aBEZWLGFsQxMYqkvOLKg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8769-5-msonline-outlook-acae4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bd13bff7-6d43-4c0a-1209-08ddc915b51f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 11:48:42.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8921

The output `git imap-send --list` command can be a bit confusing for new
users since the IMAP LIST command output is very verbose. Help such users
to analyse the same by using an example output.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-imap-send.adoc | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index 17147f93c3..278e5ccd36 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -68,6 +68,34 @@ include::includes/cmd-config-section-rest.adoc[]
=20
 include::config/imap.adoc[]
=20
+GETTING A LIST OF AVAILABLE FOLDERS
+-----------------------------------
+
+In order to send an email to a specific folder, you need to know the corre=
ct name of
+intended folder in your mailbox. The names like "Junk", "Trash" etc. displ=
ayed by
+various email clients need not be the actual names of the folders stored i=
n the mail
+server of your email provider.
+
+In order to get the correct folder name to be used with `git imap-send`, y=
ou can run
+`git imap-send --list`. This will display a list of valid folder names. An=
 example
+of such an output when run on a Gmail account is:
+
+.........................
+* LIST (\HasNoChildren) "/" "INBOX"
+* LIST (\HasChildren \Noselect) "/" "[Gmail]"
+* LIST (\All \HasNoChildren) "/" "[Gmail]/All Mail"
+* LIST (\Drafts \HasNoChildren) "/" "[Gmail]/Drafts"
+* LIST (\HasNoChildren \Important) "/" "[Gmail]/Important"
+* LIST (\HasNoChildren \Sent) "/" "[Gmail]/Sent Mail"
+* LIST (\HasNoChildren \Junk) "/" "[Gmail]/Spam"
+* LIST (\Flagged \HasNoChildren) "/" "[Gmail]/Starred"
+* LIST (\HasNoChildren \Trash) "/" "[Gmail]/Trash"
+.........................
+
+Here, you can observe that the correct name for the "Junk" folder is `[Gma=
il]/Spam`
+and for the "Trash" folder is `[Gmail]/Trash`. Similar logic can be used t=
o determine
+other folders as well.
+
 EXAMPLES
 --------
 Using tunnel mode:

Range-diff against v1:
1:  369d96569e ! 1:  75cafeebf1 docs: explain how to use `git imap-send --l=
ist` command to get a list of available folders
    @@ Documentation/git-imap-send.adoc: include::includes/cmd-config-secti=
on-rest.adoc
     +
     +In order to send an email to a specific folder, you need to know the =
correct name of
     +intended folder in your mailbox. The names like "Junk", "Trash" etc. =
displayed by
    -+various email clients need to be the actual names of the folders stor=
ed in the mail
    ++various email clients need not be the actual names of the folders sto=
red in the mail
     +server of your email provider.
     +
     +In order to get the correct folder name to be used with `git imap-sen=
d`, you can run
--=20
2.50.1.319.gda7cee769f

